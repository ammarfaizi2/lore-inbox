Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWI1XUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWI1XUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWI1XUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:20:22 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:38635 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964915AbWI1XUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:20:20 -0400
Message-ID: <451C58B2.1070302@us.ibm.com>
Date: Thu, 28 Sep 2006 16:20:18 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: ext4 <linux-ext4@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [Fwd: Re: [patch 003/152] jbd: fix commit of ordered data buffers]
Content-Type: multipart/mixed;
 boundary="------------060006000201070801040801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060006000201070801040801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Forgot to CC: ext4 & lkml earlier..

Thanks,
Badari

--------------060006000201070801040801
Content-Type: message/rfc822;
 name*0="Re: [patch 003/152] jbd: fix commit of ordered data buffers"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="Re: [patch 003/152] jbd: fix commit of ordered data buffers"

Message-ID: <451C4DDE.60307@us.ibm.com>
Date: Thu, 28 Sep 2006 15:34:06 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: akpm@osdl.org
CC: torvalds@osdl.org,  jack@suse.cz,  stable@kernel.org
Subject: Re: [patch 003/152] jbd: fix commit of ordered data buffers
References: <200609260630.k8Q6UrvQ011999@shell0.pdx.osdl.net>
In-Reply-To: <200609260630.k8Q6UrvQ011999@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

akpm@osdl.org wrote:
> From: Jan Kara <jack@suse.cz>
>
> ....
> [suitable for 2.6.18.x around the 2.6.19-rc2 timeframe]
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> Cc: Badari Pulavarty <pbadari@us.ibm.com>
> Cc: <stable@kernel.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  fs/jbd/commit.c |  182 ++++++++++++++++++++++++++++------------------
>  1 file changed, 113 insertions(+), 69 deletions(-)
>
> diff -puN fs/jbd/commit.c~jbd-fix-commit-of-ordered-data-buffers fs/jbd/commit.c
> --- a/fs/jbd/commit.c~jbd-fix-commit-of-ordered-data-buffers
> +++ a/fs/jbd/commit.c
> @@ -160,6 +160,117 @@ static int journal_write_commit_record(j
>  	return (ret == -EIO);
>  }
>  
> +static void journal_do_submit_data(struct buffer_head **wbuf, int bufs)
> +{
> +	int i;
> +
> +	for (i = 0; i < bufs; i++) {
> +		wbuf[i]->b_end_io = end_buffer_write_sync;
> +		/* We use-up our safety reference in submit_bh() */
> +		submit_bh(WRITE, wbuf[i]);
> +	}
> +}
> +
> +/*
> + *  Submit all the data buffers to disk
> + */
> +static void journal_submit_data_buffers(journal_t *journal,
> +				transaction_t *commit_transaction)
> +{
> +	struct journal_head *jh;
> +	struct buffer_head *bh;
> +	int locked;
> +	int bufs = 0;
> +	struct buffer_head **wbuf = journal->j_wbuf;
> +
> +	/*
> +	 * Whenever we unlock the journal and sleep, things can get added
> +	 * onto ->t_sync_datalist, so we have to keep looping back to
> +	 * write_out_data until we *know* that the list is empty.
> +	 *
> +	 * Cleanup any flushed data buffers from the data list.  Even in
> +	 * abort mode, we want to flush this out as soon as possible.
> +	 */
> +write_out_data:
> +	cond_resched();
> +	spin_lock(&journal->j_list_lock);
> +
> +	while (commit_transaction->t_sync_datalist) {
> +		jh = commit_transaction->t_sync_datalist;
>   
Don't we need                  

		commit_transaction->t_sync_datalist = jh->b_tnext;

here to skip to the next "jh" for next time ?

Thanks,
Badari

> +		bh = jh2bh(jh);
> +		locked = 0;
> +
> +		/* Get reference just to make sure buffer does not disappear
> +		 * when we are forced to drop various locks */
> +		get_bh(bh);
> +		/* If the buffer is dirty, we need to submit IO and hence
> +		 * we need the buffer lock. We try to lock the buffer without
> +		 * blocking. If we fail, we need to drop j_list_lock and do
> +		 * blocking lock_buffer().
> +		 */
> +		if (buffer_dirty(bh)) {
> +			if (test_set_buffer_locked(bh)) {
> +				BUFFER_TRACE(bh, "needs blocking lock");
> +				spin_unlock(&journal->j_list_lock);
> +				/* Write out all data to prevent deadlocks */
> +				journal_do_submit_data(wbuf, bufs);
> +				bufs = 0;
> +				lock_buffer(bh);
> +				spin_lock(&journal->j_list_lock);
> +			}
> +			locked = 1;
> +		}
> +		/* We have to get bh_state lock. Again out of order, sigh. */
> +		if (!inverted_lock(journal, bh)) {
> +			jbd_lock_bh_state(bh);
> +			spin_lock(&journal->j_list_lock);
> +		}
> +		/* Someone already cleaned up the buffer? */
> +		if (!buffer_jbd(bh)
> +			|| jh->b_transaction != commit_transaction
> +			|| jh->b_jlist != BJ_SyncData) {
> +			jbd_unlock_bh_state(bh);
> +			if (locked)
> +				unlock_buffer(bh);
> +			BUFFER_TRACE(bh, "already cleaned up");
> +			put_bh(bh);
> +			continue;
> +		}
> +		if (locked && test_clear_buffer_dirty(bh)) {
> +			BUFFER_TRACE(bh, "needs writeout, adding to array");
> +			wbuf[bufs++] = bh;
> +			__journal_file_buffer(jh, commit_transaction,
> +						BJ_Locked);
> +			jbd_unlock_bh_state(bh);
> +			if (bufs == journal->j_wbufsize) {
> +				spin_unlock(&journal->j_list_lock);
> +				journal_do_submit_data(wbuf, bufs);
> +				bufs = 0;
> +				goto write_out_data;
> +			}
> +		}
> +		else {
> +			BUFFER_TRACE(bh, "writeout complete: unfile");
> +			__journal_unfile_buffer(jh);
> +			jbd_unlock_bh_state(bh);
> +			if (locked)
> +				unlock_buffer(bh);
> +			journal_remove_journal_head(bh);
> +			/* Once for our safety reference, once for
> +			 * journal_remove_journal_head() */
> +			put_bh(bh);
> +			put_bh(bh);
> +		}
> +
> +		if (lock_need_resched(&journal->j_list_lock)) {
> +			spin_unlock(&journal->j_list_lock);
> +			goto write_out_data;
> +		}
> +	}
> +	spin_unlock(&journal->j_list_lock);
> +	journal_do_submit_data(wbuf, bufs);
> +}
> +
>  /*
>   * journal_commit_transaction
>   *
> @@ -313,80 +424,13 @@ void journal_commit_transaction(journal_
>  	 * Now start flushing things to disk, in the order they appear
>  	 * on the transaction lists.  Data blocks go first.
>  	 */
> -
>  	err = 0;
> -	/*
> -	 * Whenever we unlock the journal and sleep, things can get added
> -	 * onto ->t_sync_datalist, so we have to keep looping back to
> -	 * write_out_data until we *know* that the list is empty.
> -	 */
> -	bufs = 0;
> -	/*
> -	 * Cleanup any flushed data buffers from the data list.  Even in
> -	 * abort mode, we want to flush this out as soon as possible.
> -	 */
> -write_out_data:
> -	cond_resched();
> -	spin_lock(&journal->j_list_lock);
> -
> -	while (commit_transaction->t_sync_datalist) {
> -		struct buffer_head *bh;
> -
> -		jh = commit_transaction->t_sync_datalist;
> -		commit_transaction->t_sync_datalist = jh->b_tnext;
> -		bh = jh2bh(jh);
> -		if (buffer_locked(bh)) {
> -			BUFFER_TRACE(bh, "locked");
> -			if (!inverted_lock(journal, bh))
> -				goto write_out_data;
> -			__journal_temp_unlink_buffer(jh);
> -			__journal_file_buffer(jh, commit_transaction,
> -						BJ_Locked);
> -			jbd_unlock_bh_state(bh);
> -			if (lock_need_resched(&journal->j_list_lock)) {
> -				spin_unlock(&journal->j_list_lock);
> -				goto write_out_data;
> -			}
> -		} else {
> -			if (buffer_dirty(bh)) {
> -				BUFFER_TRACE(bh, "start journal writeout");
> -				get_bh(bh);
> -				wbuf[bufs++] = bh;
> -				if (bufs == journal->j_wbufsize) {
> -					jbd_debug(2, "submit %d writes\n",
> -							bufs);
> -					spin_unlock(&journal->j_list_lock);
> -					ll_rw_block(SWRITE, bufs, wbuf);
> -					journal_brelse_array(wbuf, bufs);
> -					bufs = 0;
> -					goto write_out_data;
> -				}
> -			} else {
> -				BUFFER_TRACE(bh, "writeout complete: unfile");
> -				if (!inverted_lock(journal, bh))
> -					goto write_out_data;
> -				__journal_unfile_buffer(jh);
> -				jbd_unlock_bh_state(bh);
> -				journal_remove_journal_head(bh);
> -				put_bh(bh);
> -				if (lock_need_resched(&journal->j_list_lock)) {
> -					spin_unlock(&journal->j_list_lock);
> -					goto write_out_data;
> -				}
> -			}
> -		}
> -	}
> -
> -	if (bufs) {
> -		spin_unlock(&journal->j_list_lock);
> -		ll_rw_block(SWRITE, bufs, wbuf);
> -		journal_brelse_array(wbuf, bufs);
> -		spin_lock(&journal->j_list_lock);
> -	}
> +	journal_submit_data_buffers(journal, commit_transaction);
>  
>  	/*
>  	 * Wait for all previously submitted IO to complete.
>  	 */
> +	spin_lock(&journal->j_list_lock);
>  	while (commit_transaction->t_locked_list) {
>  		struct buffer_head *bh;
>  
> _
>   



--------------060006000201070801040801--


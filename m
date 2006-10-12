Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWJLLzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWJLLzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 07:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWJLLzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 07:55:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41673 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750881AbWJLLzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 07:55:48 -0400
Date: Thu, 12 Oct 2006 13:55:38 +0200
From: Jan Kara <jack@suse.cz>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       mm-commits@vger.kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, pbadari@us.ibm.com
Subject: Re: [patch 16/67] jbd: fix commit of ordered data buffers
Message-ID: <20061012115538.GJ9495@atrey.karlin.mff.cuni.cz>
References: <20061011204756.642936754@quad.kroah.org> <20061011210446.GQ16627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011210446.GQ16627@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> -stable review patch.  If anyone has any objections, please let us know.
  There does not seem to be any obvious issues with this change and it
fixes a real BUG happenning during some stress-testing. On the other hand
the change is kind of intrusive and changes a quite complex code (or
better said code with complex interactions). So I'm not sure if it really is
-stable material...

								Honza

> ------------------
> From: Jan Kara <jack@suse.cz>
> 
> Original commit code assumes, that when a buffer on BJ_SyncData list is
> locked, it is being written to disk.  But this is not true and hence it can
> lead to a potential data loss on crash.  Also the code didn't count with
> the fact that journal_dirty_data() can steal buffers from committing
> transaction and hence could write buffers that no longer belong to the
> committing transaction.  Finally it could possibly happen that we tried
> writing out one buffer several times.
> 
> The patch below tries to solve these problems by a complete rewrite of the
> data commit code.  We go through buffers on t_sync_datalist, lock buffers
> needing write out and store them in an array.  Buffers are also immediately
> refiled to BJ_Locked list or unfiled (if the write out is completed).  When
> the array is full or we have to block on buffer lock, we submit all
> accumulated buffers for IO.
> 
> [suitable for 2.6.18.x around the 2.6.19-rc2 timeframe]
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> Cc: Badari Pulavarty <pbadari@us.ibm.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  fs/jbd/commit.c |  182 ++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 113 insertions(+), 69 deletions(-)
> 
> --- linux-2.6.18.orig/fs/jbd/commit.c
> +++ linux-2.6.18/fs/jbd/commit.c
> @@ -160,6 +160,117 @@ static int journal_write_commit_record(j
>  	return (ret == -EIO);
>  }
>  
> +void journal_do_submit_data(struct buffer_head **wbuf, int bufs)
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
> 
> --
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

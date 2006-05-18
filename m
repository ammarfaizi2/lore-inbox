Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWERPL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWERPL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWERPL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:11:59 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:39819 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751318AbWERPL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:11:58 -0400
Message-ID: <446C8EB1.3090905@bull.net>
Date: Thu, 18 May 2006 17:11:45 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change ll_rw_block() calls in JBD
References: <446C2F89.5020300@bull.net> <20060518134533.GA20159@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060518134533.GA20159@atrey.karlin.mff.cuni.cz>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/05/2006 17:15:04,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/05/2006 17:15:08,
	Serialize complete at 18/05/2006 17:15:08
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Getting better :-)

> +		was_dirty = buffer_dirty(bh);

Why do not we use "buffer_jbddirty()"?

> +		if (was_dirty && test_set_buffer_locked(bh)) {
> +			BUFFER_TRACE(bh, "needs blocking lock");
> +			get_bh(bh);

Why do you need a "get_bh(bh)"?
"bh" is attached to "jh".
Can it go away while waiting for the buffer lock?
("jh" in on "t_sync_datalist", it cannot go away.)

> +			spin_unlock(&journal->j_list_lock);
> +			lock_buffer(bh);
> +			spin_lock(&journal->j_list_lock);
> +			/* Someone already cleaned up the buffer? Restart. */
> +			if (!buffer_jbd(bh) || jh->b_jlist != BJ_SyncData) {

Who (else) can take away the journal head, remove our "jh" from the
synch. data list?

> +		else {
> +			BUFFER_TRACE(bh, "needs writeout, submitting");
>  			__journal_temp_unlink_buffer(jh);
>  			__journal_file_buffer(jh, commit_transaction,
>  						BJ_Locked);

A simple "__journal_file_buffer(...)" could be enough as it includes:

	if (jh->b_transaction)
		__journal_temp_unlink_buffer(jh);


Would not it be more easy to read like this?

                if ((!was_dirty && buffer_locked(bh))
                    || (was_dirty && test_clear_buffer_dirty(bh))) {
                        BUFFER_TRACE(bh, "needs writeout, submitting");
                        __journal_temp_unlink_buffer(jh);
                        __journal_file_buffer(jh, commit_transaction,
                                                BJ_Locked);
                        jbd_unlock_bh_state(bh);
                        if (was_dirty) {
                                get_bh(bh);
                                bh->b_end_io = end_buffer_write_sync;
                                submit_bh(WRITE, bh);
                        }
                }
                else {

                        BUFFER_TRACE(bh, "writeout complete: unfile");
                        __journal_unfile_buffer(jh);
                        jbd_unlock_bh_state(bh);
                        journal_remove_journal_head(bh);
                        if (was_dirty)
                                unlock_buffer(bh);
                        put_bh(bh);
                }


As synch. data handling is a compact stuff, cannot it be moved out from
"journal_commit_transaction()" as e.g. "journal_write_revoke_records()"?
(Just for a better readability...)

Thanks,

Zoltan








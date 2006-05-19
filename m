Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWESBaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWESBaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 21:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWESBaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 21:30:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42625 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932172AbWESBaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 21:30:06 -0400
Date: Fri, 19 May 2006 03:30:23 +0200
From: Jan Kara <jack@suse.cz>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change ll_rw_block() calls in JBD
Message-ID: <20060519013023.GA11424@atrey.karlin.mff.cuni.cz>
References: <446C2F89.5020300@bull.net> <20060518134533.GA20159@atrey.karlin.mff.cuni.cz> <446C8EB1.3090905@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446C8EB1.3090905@bull.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Getting better :-)
> 
> >+		was_dirty = buffer_dirty(bh);
> 
> Why do not we use "buffer_jbddirty()"?
  I think Stephen has already explained it... We have a data buffer and
hence we use buffer_dirty()

> 
> >+		if (was_dirty && test_set_buffer_locked(bh)) {
> >+			BUFFER_TRACE(bh, "needs blocking lock");
> >+			get_bh(bh);
> 
> Why do you need a "get_bh(bh)"?
> "bh" is attached to "jh".
> Can it go away while waiting for the buffer lock?
> ("jh" in on "t_sync_datalist", it cannot go away.)
> 
> >+			spin_unlock(&journal->j_list_lock);
> >+			lock_buffer(bh);
> >+			spin_lock(&journal->j_list_lock);
> >+			/* Someone already cleaned up the buffer? Restart. */
> >+			if (!buffer_jbd(bh) || jh->b_jlist != BJ_SyncData) {
> 
> Who (else) can take away the journal head, remove our "jh" from the
> synch. data list?
  For two of the above comments: Under memory pressure data buffers can
be written out earlier and then released by __journal_try_to_free_buffer()
as they are not dirty any more. The above checks protect us against this.

> >+		else {
> >+			BUFFER_TRACE(bh, "needs writeout, submitting");
> > 			__journal_temp_unlink_buffer(jh);
> > 			__journal_file_buffer(jh, commit_transaction,
> > 						BJ_Locked);
> 
> A simple "__journal_file_buffer(...)" could be enough as it includes:
> 
> 	if (jh->b_transaction)
> 		__journal_temp_unlink_buffer(jh);
  Yes, you are right here.

> Would not it be more easy to read like this?
> 
>                if ((!was_dirty && buffer_locked(bh))
>                    || (was_dirty && test_clear_buffer_dirty(bh))) {
>                        BUFFER_TRACE(bh, "needs writeout, submitting");
>                        __journal_temp_unlink_buffer(jh);
>                        __journal_file_buffer(jh, commit_transaction,
>                                                BJ_Locked);
>                        jbd_unlock_bh_state(bh);
>                        if (was_dirty) {
>                                get_bh(bh);
>                                bh->b_end_io = end_buffer_write_sync;
>                                submit_bh(WRITE, bh);
>                        }
>                }
>                else {
> 
>                        BUFFER_TRACE(bh, "writeout complete: unfile");
>                        __journal_unfile_buffer(jh);
>                        jbd_unlock_bh_state(bh);
>                        journal_remove_journal_head(bh);
>                        if (was_dirty)
>                                unlock_buffer(bh);
>                        put_bh(bh);
>                }
  So you basically mean switching those two branches of if.. OK, maybe.

> As synch. data handling is a compact stuff, cannot it be moved out from
> "journal_commit_transaction()" as e.g. "journal_write_revoke_records()"?
> (Just for a better readability...)
  Yes, probably moving it to a new function may improve the readability.
Thanks for suggestions.

								Honza 
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

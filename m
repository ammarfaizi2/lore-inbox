Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVINSa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVINSa7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVINSa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:30:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44509 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932275AbVINSa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:30:59 -0400
Date: Wed, 14 Sep 2005 11:30:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix commit of ordered data buffers
Message-Id: <20050914113012.3d86c6d7.akpm@osdl.org>
In-Reply-To: <20050914120322.GE15582@atrey.karlin.mff.cuni.cz>
References: <20050913153024.GL30108@atrey.karlin.mff.cuni.cz>
	<20050913184305.24705a98.akpm@osdl.org>
	<20050914120322.GE15582@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:
>
> > Also, I don't think it works.  See ll_rw_block()'s handling of
> > already-locked buffers..
>
>   We send it to disk with SWRITE - hence ll_rw_block() wait for the buffer
> lock for us. Or do you have something else in mind?
>

OK.
 
> > An alternative is to just lock the buffer in journal_commit_transaction(),
> > if it was locked-and-dirty.  And remove the call to ll_rw_block() and
> > submit the locked buffers by hand.
>
>   Yes, this has the advantage that we can move the buffer to t_locked_list
> in the right time and so we don't change the semantics of t_locked_list.
> OTOH the locking will be a bit more complicated (we'd need to acquire and
> drop j_list_lock almost for every bh while currently we do it only once
> per batch)

Only need to drop the spinlock if test_set_buffer_locked() fails.

> 
> spin_lock(&journal->j_list_lock);
> while (commit_transaction->t_sync_datalist) {
> 	jh = commit_transaction->t_sync_datalist;
> 	bh = jh2bh(jh);
> 	journal_grab_journal_head(bh);
> 	if (buffer_dirty(bh)) {
> 		get_bh(bh);
> 		spin_unlock(&journal->j_list_lock);
>                 lock_buffer(bh);
> 		if (buffer_dirty(bh))
> 			/* submit the buffer */
> 		jbd_lock_bh_state(bh);
> 		spin_lock(&journal->j_list_lock);
> 		/* Check that somebody did not move the jh elsewhere */
> 	}
> 	else {
> 		if (!inverted_lock(journal, bh))
> 			goto write_out_data;
> 	}
> 	__journal_temp_unlink_buffer(jh);
> 	__journal_file_buffer(jh, commit_transaction, BJ_Locked);
> 	journal_put_journal_head(bh);
> 	jbd_unlock_bh_state(bh);
> }
> 
> If you prefer something like this I can code it up...

If the code is conceptually simpler then I think it's worth doing, even if
the actual implementation is similarly or even more complex.

So yes please, let's see how it looks.

> > That would mean that if someone had redirtied a buffer which was on
> > t_sync_datalist *while* it was under writeout, we'd end up waiting on that
> > writeout to complete before submitting more I/O.  But I suspect that's
> > pretty rare.
> > 
> > One thing which concerns me with your approach is livelocks: if some process
> > sits in a tight loop writing to the same part of the same file, will it
> > cause kjournald to get stuck?
>
>   No, because as soon as we find the buffer in t_sync_datalist we move
> it to t_locked_list and submit it for IO - this case is one reason why I
> introduced that new meaning to t_locked_list.

Right.  But the buffer can be redirtied while it's on t_locked_list, even
while the I/O is in flight.  What happens then?  Will kjournald try to
rewrite it?

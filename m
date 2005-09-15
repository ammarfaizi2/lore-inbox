Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbVIOHVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbVIOHVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbVIOHVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:21:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21407 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965145AbVIOHVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:21:34 -0400
Date: Thu, 15 Sep 2005 09:23:22 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix commit of ordered data buffers
Message-ID: <20050915072322.GA10906@atrey.karlin.mff.cuni.cz>
References: <20050913153024.GL30108@atrey.karlin.mff.cuni.cz> <20050913184305.24705a98.akpm@osdl.org> <20050914120322.GE15582@atrey.karlin.mff.cuni.cz> <20050914113012.3d86c6d7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914113012.3d86c6d7.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > An alternative is to just lock the buffer in journal_commit_transaction(),
> > > if it was locked-and-dirty.  And remove the call to ll_rw_block() and
> > > submit the locked buffers by hand.
> >
> >   Yes, this has the advantage that we can move the buffer to t_locked_list
> > in the right time and so we don't change the semantics of t_locked_list.
> > OTOH the locking will be a bit more complicated (we'd need to acquire and
> > drop j_list_lock almost for every bh while currently we do it only once
> > per batch)
> 
> Only need to drop the spinlock if test_set_buffer_locked() fails.
  Ahh, good point.

> > spin_lock(&journal->j_list_lock);
> > while (commit_transaction->t_sync_datalist) {
> > 	jh = commit_transaction->t_sync_datalist;
> > 	bh = jh2bh(jh);
> > 	journal_grab_journal_head(bh);
> > 	if (buffer_dirty(bh)) {
> > 		get_bh(bh);
> > 		spin_unlock(&journal->j_list_lock);
> >                 lock_buffer(bh);
> > 		if (buffer_dirty(bh))
> > 			/* submit the buffer */
> > 		jbd_lock_bh_state(bh);
> > 		spin_lock(&journal->j_list_lock);
> > 		/* Check that somebody did not move the jh elsewhere */
> > 	}
> > 	else {
> > 		if (!inverted_lock(journal, bh))
> > 			goto write_out_data;
> > 	}
> > 	__journal_temp_unlink_buffer(jh);
> > 	__journal_file_buffer(jh, commit_transaction, BJ_Locked);
> > 	journal_put_journal_head(bh);
> > 	jbd_unlock_bh_state(bh);
> > }
> > 
> > If you prefer something like this I can code it up...
> 
> If the code is conceptually simpler then I think it's worth doing, even if
> the actual implementation is similarly or even more complex.
> 
> So yes please, let's see how it looks.
  OK, will do.

> > > That would mean that if someone had redirtied a buffer which was on
> > > t_sync_datalist *while* it was under writeout, we'd end up waiting on that
> > > writeout to complete before submitting more I/O.  But I suspect that's
> > > pretty rare.
> > > 
> > > One thing which concerns me with your approach is livelocks: if some process
> > > sits in a tight loop writing to the same part of the same file, will it
> > > cause kjournald to get stuck?
> >
> >   No, because as soon as we find the buffer in t_sync_datalist we move
> > it to t_locked_list and submit it for IO - this case is one reason why I
> > introduced that new meaning to t_locked_list.
> 
> Right.  But the buffer can be redirtied while it's on t_locked_list, even
> while the I/O is in flight.  What happens then?  Will kjournald try to
> rewrite it?
  No. With my patch journaling code writes only data buffers in
t_sync_data_list and moves them to t_locked_list even before the actual
submit so we really write each buffer exactly once in the
journal_commit_transaction().
  Originally it worked as follows: buffer has been first submitted
for IO, then if we eventually came over it for the second time and found
it has been locked, we moved it to t_locked_list. If we found a clean
buffer in t_sync_data_list we just removed it from the transaction.
Now the livelock you were talking about was prevented by the clever
code in journal_dirty_data() that has been (and still is) checking
whether the buffer is a part of committing transaction and if so, it
sends it to disk and refiles it to the new transaction.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

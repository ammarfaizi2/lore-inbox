Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932727AbVINMBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbVINMBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 08:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbVINMBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 08:01:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18669 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932727AbVINMBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 08:01:38 -0400
Date: Wed, 14 Sep 2005 14:03:22 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix commit of ordered data buffers
Message-ID: <20050914120322.GE15582@atrey.karlin.mff.cuni.cz>
References: <20050913153024.GL30108@atrey.karlin.mff.cuni.cz> <20050913184305.24705a98.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913184305.24705a98.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan Kara <jack@suse.cz> wrote:
> >
> > When a buffer is locked it does not mean that write-out is in progress. We
> >  have to check if the buffer is dirty and if it is we have to submit it
> >  for write-out. We unconditionally move the buffer to t_locked_list so
> >  that we don't mistake unprocessed buffer and buffer not yet given to
> >  ll_rw_block(). This subtly changes the meaning of buffer states in
> >  t_locked_list - unlock buffer (for list users different from
> >  journal_commit_transaction()) does not mean it has been written. But
> >  only journal_unmap_buffer() cares and it now checks if the buffer
> >  is not dirty.
> 
> Seems complex.  It means that t_locked_list takes on an additional (and
> undocumented!) meaning.
  Sorry, if we agree on some final form I'll add the appropriate
comment to the header file.

> Also, I don't think it works.  See ll_rw_block()'s handling of
> already-locked buffers..
  We send it to disk with SWRITE - hence ll_rw_block() wait for the buffer
lock for us. Or do you have something else in mind?

> An alternative is to just lock the buffer in journal_commit_transaction(),
> if it was locked-and-dirty.  And remove the call to ll_rw_block() and
> submit the locked buffers by hand.
  Yes, this has the advantage that we can move the buffer to t_locked_list
in the right time and so we don't change the semantics of t_locked_list.
OTOH the locking will be a bit more complicated (we'd need to acquire and
drop j_list_lock almost for every bh while currently we do it only once
per batch) - the code would have to be like:

spin_lock(&journal->j_list_lock);
while (commit_transaction->t_sync_datalist) {
	jh = commit_transaction->t_sync_datalist;
	bh = jh2bh(jh);
	journal_grab_journal_head(bh);
	if (buffer_dirty(bh)) {
		get_bh(bh);
		spin_unlock(&journal->j_list_lock);
                lock_buffer(bh);
		if (buffer_dirty(bh))
			/* submit the buffer */
		jbd_lock_bh_state(bh);
		spin_lock(&journal->j_list_lock);
		/* Check that somebody did not move the jh elsewhere */
	}
	else {
		if (!inverted_lock(journal, bh))
			goto write_out_data;
	}
	__journal_temp_unlink_buffer(jh);
	__journal_file_buffer(jh, commit_transaction, BJ_Locked);
	journal_put_journal_head(bh);
	jbd_unlock_bh_state(bh);
}

If you prefer something like this I can code it up...

> That would mean that if someone had redirtied a buffer which was on
> t_sync_datalist *while* it was under writeout, we'd end up waiting on that
> writeout to complete before submitting more I/O.  But I suspect that's
> pretty rare.
> 
> One thing which concerns me with your approach is livelocks: if some process
> sits in a tight loop writing to the same part of the same file, will it
> cause kjournald to get stuck?
  No, because as soon as we find the buffer in t_sync_datalist we move
it to t_locked_list and submit it for IO - this case is one reason why I
introduced that new meaning to t_locked_list.

> The problem we have here is "was the buffer dirtied before this commit
> started, or after?".  In the former case we are obliged to write it.  In
> the later case we are not, and in trying to do this we risk livelocking.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

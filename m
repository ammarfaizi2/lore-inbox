Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVCGOuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVCGOuP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 09:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVCGOuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 09:50:15 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:65444 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261193AbVCGOuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 09:50:06 -0500
Date: Mon, 7 Mar 2005 15:50:07 +0100
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
Message-ID: <20050307145007.GB27051@atrey.karlin.mff.cuni.cz>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk> <20050304160451.4c33919c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304160451.4c33919c.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Stephen C. Tweedie" <sct@redhat.com> wrote:
> >
> > For the past few months there has been a slow but steady trickle of
> > reports of oopses in kjournald.
> 
> Yes, really tenuous stuff.  Very glad if this is the fix!
> 
> >  Recently I got a couple of reports that
> > were repeatable enough to rerun with extra debugging code.
> > 
> > It turns out that we're releasing a journal_head while it is still
> > linked onto the transaction's t_locked_list.  The exact location is in
> > journal_unmap_buffer().  On several exit paths, that does:
> > 
> > 		spin_unlock(&journal->j_list_lock); 
> > 		jbd_unlock_bh_state(bh);
> > 		spin_unlock(&journal->j_state_lock);
> > 		journal_put_journal_head(jh);
> > 
> > releasing the jh *after* dropping the j_list_lock and j_state_lock.
> > 
> > kjournald can then be doing journal_commit_transaction():
> > 
> > 	spin_lock(&journal->j_list_lock);
> > ...
> > 		if (buffer_locked(bh)) {
> > 			BUFFER_TRACE(bh, "locked");
> > 			if (!inverted_lock(journal, bh))
> > 				goto write_out_data;
> > 			__journal_unfile_buffer(jh);
> > 			__journal_file_buffer(jh, commit_transaction,
> > 						BJ_Locked);
> > 			jbd_unlock_bh_state(bh);
> > 
> > The problem happens if journal_unmap_buffer()'s own put_journal_head()
> > manages to get in between kjournald's *unfile_buffer and the following
> > *file_buffer.  Because journal_unmap_buffer() has dropped its bh_state
> > lock by this point, there's nothing to prevent this, leading to a
> > variety of unpleasant situations.  In particular, the jh is unfiled at
> > this point, so there's nothing to stop the put_journal_head() from
> > freeing the memory we're just about to link onto the BJ_Locked list.
> 
> Right.  I don't know why journal_put_journal_head() looks at
> ->b_transaction, really.  Should have made presence on a list contribute to
> b_jcount.  Oh well, it's been that way since 2.5.0 or older..
> 
> Don't we have the same race anywhere where we're doing a
> journal_refile_buffer() (or equiv) in parallel with a
> journal_put_journal_head() outside locks?  There seem to be many such.
  I believe the other places should be safe (mostly by luck) as the
caller has made sure that __journal_remove_journal_head() won't do
anything (e.g. set b_transaction, b_next_transaction or such).
Anyway it doesn't seem too safe to me...

								Honza

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVCIN2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVCIN2t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 08:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVCIN2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 08:28:49 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13759 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262358AbVCIN2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 08:28:37 -0500
Date: Wed, 9 Mar 2005 14:28:38 +0100
From: Jan Kara <jack@suse.cz>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
Message-ID: <20050309132838.GJ6145@atrey.karlin.mff.cuni.cz>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk> <20050304160451.4c33919c.akpm@osdl.org> <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk> <20050307123118.3a946bc8.akpm@osdl.org> <1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk> <1110286417.1941.40.camel@sisko.sctweedie.blueyonder.co.uk> <20050308151258.GD23403@atrey.karlin.mff.cuni.cz> <1110373818.1932.31.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110373818.1932.31.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2005-03-08 at 15:12, Jan Kara wrote:
> 
> >   Isn't also the following scenario dangerous?
> > 
> >   __journal_unfile_buffer(jh);
> >   journal_remove_journal_head(bh);
> 
> It depends.  I think the biggest problem here is that there's really no
> written rule protecting this stuff universally.  But in testing, we just
> don't see this triggering.
> 
> Why not?  We actually have a raft of other locks protecting us in
> various places.  As long as there's some overlap in the locks, we're
> OK.  But because it's not written down, not everybody relies on the same
> set of locks; it's only because journal_unmap_buffer() was dropping the
> jh without enough locks that we saw a problem there.
> 
> So the scenario:
> 
> 	__journal_unfile_buffer(jh);
> 	journal_remove_journal_head(bh);
> 
> *might* be dangerous, if called carelessly; but in practice it works out
> OK.  Remember, that journal_remove_journal_head() call still takes the
> bh_journal_head lock and still checks b_transaction with that held.
  Hmm. I see for example a place at jbd/commit.c, line 287 (which you
did not change in your patch) which does this and doesn't seem to be
protected against journal_unmap_buffer() (but maybe I miss something).
Not that I'd find that race probable but in theory...

> I think it's time I went and worked out *why* it works out OK, though,
> so that we can write it down and make sure it stays working!  And we may
> well be able to simplify the locking when we do this; collapsing the two
> bh state locks, for example, may help improve the robustness as well as
> improving performance through removing some redundant locking
> operations.
> 
> Fortunately, there are really only three classes of operation that can
> remove a jh.  There are the normal VFS/VM operations, like writepage,
> try_to_free_buffer, etc; these are all called with the page lock.  There
> are metadata updates, which take a liberal dose of buffer, bh_state and
> journal locks.  
> 
> Finally there are the commit/checkpoint functions, which run
> asynchronously to the rest of the journaling and which don't relate to
> the current transaction, but to previous ones.  This is the danger area,
> I think.  But as long as at least the bh_state lock is held, we can
> protect these operations against the data/metadata update operations.
  I agree that only the metadata/data updates can race with checkpoint/commit
because other combinations are already serialized by 'higher-level'
locks. But I think we agree that the simplier (and 'local') the locking rules
are the less probable the bugs are..

									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVCINN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVCINN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 08:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVCINN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 08:13:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63678 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262176AbVCINKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 08:10:42 -0500
Subject: Re: [RFC] ext3/jbd race: releasing in-use journal_heads
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050308151258.GD23403@atrey.karlin.mff.cuni.cz>
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050304160451.4c33919c.akpm@osdl.org>
	 <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050307123118.3a946bc8.akpm@osdl.org>
	 <1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1110286417.1941.40.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050308151258.GD23403@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110373818.1932.31.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 09 Mar 2005 13:10:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-03-08 at 15:12, Jan Kara wrote:

>   Isn't also the following scenario dangerous?
> 
>   __journal_unfile_buffer(jh);
>   journal_remove_journal_head(bh);

It depends.  I think the biggest problem here is that there's really no
written rule protecting this stuff universally.  But in testing, we just
don't see this triggering.

Why not?  We actually have a raft of other locks protecting us in
various places.  As long as there's some overlap in the locks, we're
OK.  But because it's not written down, not everybody relies on the same
set of locks; it's only because journal_unmap_buffer() was dropping the
jh without enough locks that we saw a problem there.

So the scenario:

	__journal_unfile_buffer(jh);
	journal_remove_journal_head(bh);

*might* be dangerous, if called carelessly; but in practice it works out
OK.  Remember, that journal_remove_journal_head() call still takes the
bh_journal_head lock and still checks b_transaction with that held.

I think it's time I went and worked out *why* it works out OK, though,
so that we can write it down and make sure it stays working!  And we may
well be able to simplify the locking when we do this; collapsing the two
bh state locks, for example, may help improve the robustness as well as
improving performance through removing some redundant locking
operations.

Fortunately, there are really only three classes of operation that can
remove a jh.  There are the normal VFS/VM operations, like writepage,
try_to_free_buffer, etc; these are all called with the page lock.  There
are metadata updates, which take a liberal dose of buffer, bh_state and
journal locks.  

Finally there are the commit/checkpoint functions, which run
asynchronously to the rest of the journaling and which don't relate to
the current transaction, but to previous ones.  This is the danger area,
I think.  But as long as at least the bh_state lock is held, we can
protect these operations against the data/metadata update operations.

--Stephen


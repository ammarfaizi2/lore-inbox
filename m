Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTFKBPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 21:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTFKBPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 21:15:25 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:52425 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S263375AbTFKBPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 21:15:20 -0400
Date: Tue, 10 Jun 2003 18:28:24 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@transmeta.com,
       marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030610182824.A18280@google.com>
References: <20030603165438.A24791@google.com> <shswug2sz5x.fsf@charged.uio.no> <20030604142047.C24603@google.com> <16094.25720.895263.4398@charged.uio.no> <20030603165438.A24791@google.com> <20030609065141.A9781@google.com> <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Wed, Jun 11, 2003 at 01:54:25AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 01:54:25AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Jun 09, 2003 at 06:51:41AM -0700, Frank Cusack wrote:
>  
> > When foo is unlinked, nfs_unlink() does a sillyrename, this puts the
> > dentry on nfs_delete_queue, and (in the VFS) unhashes it from the dcache.
> > This causes a problem, because dentry->d_parent->d_inode is now guaranteed
> > to remain stale.  (OK, I'm not really sure about this last part.)
> 
> ????
> 
> What does hashed state have to ->d_parent?

Because now d_parent can be d_deleted (no children) and then go away.
Then won't dentry->d_parent be wrong?  What happens if d_parent becomes
a negative d_entry v. disappearing entirely.

Like I said, I didn't study this part well enough to be sure even what
I'm talking about, much less the conclusion. :-)

> > Then readdir() returns the new .nfs file, this creates a NEW dentry
> > (we just moved the first one to nfs_delete_queue and did not create a
> > negative dentry) which now has d_count==1 so instead of sillyrename we
> > just remove it (but note, we actually have this file open).  Then rmdir
> > succeeeds.
> > 
> > Now, we have a dentry on nfs_delete_queue which a) has already been
> > unlinked and b) whose dentry->d_parent DNE and dentry->d_parent->d_inode
> > DNE.  Of course this will cause confusion later!
> 
> b) is bogus.  Unhashing does nothing to ->d_parent.

Except that d_parent can now disappear, right?  Because it no longer knows
it has children.  Or is that wrong.

> > Note that if a process does a drive by on the .nfs file (another round
> > of unlinked-but-open) before we unlink it, we would sillyrename it again.
> > We'd now have two different dentry's on the delete queue for the same
> > file.  (One of them would just leak, I think--possible local DoS?)
> 
> Two different dentries for the same file is obviously not a problem...

It is if d_count goes to 0 on one of them and the inode is then unlinked.
But the other dentry remains and again tries to unlink when its d_count
goes to 0.  Over NFS the fh includes the generation and so you can't
accidentally delete what only looks like the same file, but what happens
in the local fs?

Also, the real problem is that something goes wrong with d_parent and
NFS tries to refresh an inode that it should really know doesn't exist
anymore.  That's why my #2 patch only executes during a rmdir.

I may not have 100% accurately captured the problem, but the effect is
easy to see.

As for the last sentence about the DoS, I can trivially construct
a program which just keeps creating dentries on the nfs_delete_queue
that will never go away.  Because the original dentry gets unhashed and
when the file is looked up again it doesn't have the flags, so it gets
sillyrenamed again...  and again ... and again.  The nfs_delete_queue
processing stops at the first hit.

> > 1) Don't unhash the dentry after silly-renaming.  In 2.2, each fs is
> >    responsible for doing a d_delete(), in 2.4 it happens in the VFS and
> >    I think it was just an oversight that the 2.4 VFS doesn't consider
> >    sillyrename (considering the code and comments that are cruft).
> > 
> >    This preserves the unlinked-but-open semantic, but breaks rmdir.  So
> >    it's not a clear winner from a semantics POV.  dentry->d_count is
> >    always correct, which sounds like a plus.
> > 
> >    The patch to make this work is utterly simple, which is a big plus.
> 
> ... and AFAICS it opens a huge can of worms with races in NFS unlink/rename.

AFAICS it solves at least one of them.  I actually prefer this #1 patch
to my #2 patch, I just posted the other for completeness.  It's obviously
correct to leave the d_entry alone, since you did not actually remove it
from the directory.  And d_count and d_flags accurately represents the
state, and nfs_unlink does treat that correctly.  I'm new to the kernel,
so please educate me where that is wrong.

> Sigh...  I'll look through that code and try to reconstruct the analysis.
> It used to be a very big mess and there was fairly subtle logics around
> unhashing/checks for d_count/etc. involved in fixing ;-/  And there was
> a lot of changes since then.  Oh, well...

That would be very cool if you do that.  There are other problems besides
the one I described, I haven't figured them out enough to post yet.  But
I don't see why you wouldn't think the one liner above isn't correct.

/fc

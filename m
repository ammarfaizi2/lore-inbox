Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269660AbUHZWyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269660AbUHZWyk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269753AbUHZWvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:51:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:39046 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269742AbUHZWrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:47:08 -0400
Date: Thu, 26 Aug 2004 15:45:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: [some sanity for a change] possible design issues for hybrids
In-Reply-To: <20040826223625.GB21964@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0408261538030.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
 <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org>
 <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk>
 <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0408261344150.2304@ppc970.osdl.org>
 <20040826212853.GA21964@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0408261436480.2304@ppc970.osdl.org>
 <20040826223625.GB21964@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > It should be reasonably easy to create new ones on-the-fly, since we'd
> > have all the information (the parent vfsmount comes stated, and the
> > vfsmount we create would point to the same things that the "base" one
> > would).
> 
> Erm...  What do we do upon unlink()?  I'm killing a file, fs it's in is
> mounted in a dozen of places (no namespaces, just chroot jails, whatever).
> We need to find all vfsmounts to be killed by that.

But that should be trivial: that's what the per-inode vfsmount list was 
(your first question in the last email).

> And BTW that's an argument against anchoring that list in inode - unlink()
> on foo should not screw bar/... even if bar and foo are links to the same
> file.  So we'll need to check for dentry match anyway.

And again - I talked about this in the previous email. Even if you anchor 
the list in "struct inode", or you do it with a totally external 
hash-list, you'll always have the "vfsmount->mnt_mountpoint" pointer to 
point to the dentry. So you can just iterate over the list, and 
cherry-pick the ones that point to the dentry you are removing.

>  
> > > 3) what do we do on umount(2)?  We can get a bunch of vfsmounts hanging off
> > > it.  MNT_DETACH will have no problems, but normal umount() is a different
> > > story.  Note that it's not just hybrid-related problem - implementing the
> > > mount traps will cause the same kind of trouble,
> > 
> > Don't allow umount. It's not something the user can unmount - the mount is 
> > "implied" in the file. 
> 
> See below.
> 
> > > 4) OK, we have those hybrids and want to create vfsmounts when crossing a
> > > mountpoint.  When do they go away, anyway?  When we don't reference them
> > > anymore?  Right now "attached to mount tree" == "+1 to refcount" and detaching
> > > happens explicitly - outside of the "dropping the final reference" path.
> > > Might become a locking issue.
> > 
> > Ahh. Umm.. Yes. I think this might be the real problem. Unless I seriously 
> > clossed something over when I blathered about the "create the vfsmount on 
> > the fly" thing above ;)
> 
> > > 5) Creation of these vfsmounts: fs should somehow tell us whether it wants
> > > one or not (at the very least, we should stop *somewhere*).  Can we use
> > > the same dentry/inode?  I'm not sure and I really doubt that we'd like that.
> > 
> > Why not? When doing the ->lookup() operation, the filesystem would create
> > the vfsmount and bind it to the current vfsmount. That guarantees that it
> > has a vfsmount, and will mean that it will show up positive with the
> > "d_mountpoint()" query, which in turn will cause us to do the
> > "lookup_mnt()".
> 
> Several paragraphs below you are saying that you don't like fs messing with
> vfsmounts.  Use of ->lookup() would mean that we should not only create
> and attach vfsmounts from within fs code, but would actually have to make
> ->lookup() return vfsmount+dentry, AFAICS.

No, lookup would just return the dentry, but the dentry would already be 
filled in with the mount-point information.

And you can do that with a simple vfs helper function, ie the filesystem 
itself would just need to do

	pseudo_mount(dentry, inode);

thing - which just fills in dentry->d_mountpoint with a new vfsmount
thing. It would allocate a new root dentry (for the pseudo-mount) and a
new vfsmount, and make dentry->d_mountpoint point to it.

IOW, the filesystem itself would never mess around with d_mountpoint 
itself.

> Err...  What about dir-on-dir-that-is-on-file?  I.e. mount on foo/. when foo
> is a file?

Hmm.. We might as well allow it, I suspect. It's not like it should hurt.  
We'd end up following the mount-chain twice, but we already have that
issue with multi-mount cases..

		Linus

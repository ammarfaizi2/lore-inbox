Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269730AbUHZWNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269730AbUHZWNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269746AbUHZWKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:10:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:43734 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269730AbUHZWHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:07:30 -0400
Date: Thu, 26 Aug 2004 15:04:21 -0700 (PDT)
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
In-Reply-To: <20040826212853.GA21964@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0408261436480.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
 <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org>
 <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk>
 <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0408261344150.2304@ppc970.osdl.org>
 <20040826212853.GA21964@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ This is quite possibly just impossible and buggy, but here's my
  implementation notes. You asked for them. ]

On Thu, 26 Aug 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> All right, let's see where that would take us.
> 
> 1) we would need to find all vfsmounts over given dentry.  Probably a cyclic
> list (we want to check if there are normal mounts/bindings among those and
> we want to dissolve them if there's none).

Not per-inode? dentries are a bitmore memory-constrained than inodes, and 
we only need this for filesystems that want to support it, so we wouldn't 
need to put this information in each dentry.

Since the vfsmounts have back-pointers to the dentry they are mounted on,
you can still do a "per-dentry" traversal, by just doign the inode list
and checking the dentry pointer. No?

Alternatively, we could just put the list on an external hash-chain 
entirely, and hash off the dentry. It depends on how often we end up 
needing it.

Or we could just put it in the dentry itself. I'd hate to make it any 
bigger than it already is, but maybe it doesn't matter that much.

> 2) we would need to do something about locking, since mount trees in other
> guys' namespaces are protected by semaphores of their own.

Ok, I'll admit that I don't know how to handle namespaces. These things 
should just go into a global namespace, and I was kind of assuming it 
would happen automatically in "lookup_mnt()" or something like that. A 
special case in lookup_mnt which says something like "if you didn't find a 
vfsmount, we create a new one for you".

It should be reasonably easy to create new ones on-the-fly, since we'd
have all the information (the parent vfsmount comes stated, and the
vfsmount we create would point to the same things that the "base" one
would).

> 3) what do we do on umount(2)?  We can get a bunch of vfsmounts hanging off
> it.  MNT_DETACH will have no problems, but normal umount() is a different
> story.  Note that it's not just hybrid-related problem - implementing the
> mount traps will cause the same kind of trouble,

Don't allow umount. It's not something the user can unmount - the mount is 
"implied" in the file. 

> 4) OK, we have those hybrids and want to create vfsmounts when crossing a
> mountpoint.  When do they go away, anyway?  When we don't reference them
> anymore?  Right now "attached to mount tree" == "+1 to refcount" and detaching
> happens explicitly - outside of the "dropping the final reference" path.
> Might become a locking issue.

Ahh. Umm.. Yes. I think this might be the real problem. Unless I seriously 
clossed something over when I blathered about the "create the vfsmount on 
the fly" thing above ;)

> 5) Creation of these vfsmounts: fs should somehow tell us whether it wants
> one or not (at the very least, we should stop *somewhere*).  Can we use
> the same dentry/inode?  I'm not sure and I really doubt that we'd like that.

Why not? When doing the ->lookup() operation, the filesystem would create
the vfsmount and bind it to the current vfsmount. That guarantees that it
has a vfsmount, and will mean that it will show up positive with the
"d_mountpoint()" query, which in turn will cause us to do the
"lookup_mnt()".

Which in turn will create the other vfsmounts as needed, if you have 
multiple namespaces.

So I _think_ creation is easy. Getting rid of the dang things migth be 
harder.

> 6) if it's a method, where should it live, *especially* if we want them on
> device nodes.  Note that inode_operations belongs to underlying fs, so it's
> not particulary good place for device case.

Why not just let the existing .lookup method initialize the mount-point 
thing? After that, it's all in the VFS layer (I'd hate to have filesystems 
mess around with vfsmounts - they'll just get it wrong).

> 7) automount folks want partially shared mount trees (well, mirrored,
> actually).

I don't think you can get partial sharing on one of these puppies. You'd 
always have one vfsmount per namespace (well, lazily created, so maybe in 
practice you'd see a lot fewer).

> 8) what should happen when something is mounted on top of directory-over-file?
> How do we treat such beasts?  What are the implications?

Allow file-on-file mounts - it will just totally hide the thing (in that
namespace, at least). But don't allow the dir-on-file thing (that we
already don't allow).

> 9) how do we recognize such mountpoints in the path lookups?  It *is* a
> hot path, so we should be careful in that area; the impact will be felt
> by everything in the system.

I don't think you'll have any special cases. Same d_mountpount(), same 
lookup_mnt().

> 10) how do we deal with directories, anyway?  Mixing "attributes" with
> normal directory contents is going to be fun, what with lseek() insanity.

You couldn't get at the attributes that way anyway, so I think the point 
is moot. The "real" directory always takes over.

Crazy people could try to just use the regular "xattrs" interfaces if they 
really want attributes on directories. You wouldn't ever be able to use 
the "easy" one.

> 11) if we go for your "here's stuff that belongs in device node viewed
> as directory", how would that play with fs metadata exporters?  Again,
> due to the insanity of lseek() on directories it's *very* hard to deal
> with unions, when parts of directory come from different chunks of code.

Don't go there. See above. Directories would be just plain directories, 
you could never see their metadata. Same goes for at least symlinks, and 
possibly other filetypes too (ie at least initially, a block or character 
special device will just take over the whole "file_operations", which 
includes "readdir", so it's actually hard to have the filesystem do 
anything about those).

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269686AbUHZWnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269686AbUHZWnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269688AbUHZWkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:40:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8686 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269759AbUHZWgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:36:31 -0400
Date: Thu, 26 Aug 2004 23:36:25 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: [some sanity for a change] possible design issues for hybrids
Message-ID: <20040826223625.GB21964@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com> <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org> <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk> <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261344150.2304@ppc970.osdl.org> <20040826212853.GA21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408261436480.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408261436480.2304@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 03:04:21PM -0700, Linus Torvalds wrote:
 
> > 2) we would need to do something about locking, since mount trees in other
> > guys' namespaces are protected by semaphores of their own.
> 
> Ok, I'll admit that I don't know how to handle namespaces. These things 
> should just go into a global namespace, and I was kind of assuming it 
> would happen automatically in "lookup_mnt()" or something like that. A 
> special case in lookup_mnt which says something like "if you didn't find a 
> vfsmount, we create a new one for you".
> 
> It should be reasonably easy to create new ones on-the-fly, since we'd
> have all the information (the parent vfsmount comes stated, and the
> vfsmount we create would point to the same things that the "base" one
> would).

Erm...  What do we do upon unlink()?  I'm killing a file, fs it's in is
mounted in a dozen of places (no namespaces, just chroot jails, whatever).
We need to find all vfsmounts to be killed by that.

And BTW that's an argument against anchoring that list in inode - unlink()
on foo should not screw bar/... even if bar and foo are links to the same
file.  So we'll need to check for dentry match anyway.
 
> > 3) what do we do on umount(2)?  We can get a bunch of vfsmounts hanging off
> > it.  MNT_DETACH will have no problems, but normal umount() is a different
> > story.  Note that it's not just hybrid-related problem - implementing the
> > mount traps will cause the same kind of trouble,
> 
> Don't allow umount. It's not something the user can unmount - the mount is 
> "implied" in the file. 

See below.

> > 4) OK, we have those hybrids and want to create vfsmounts when crossing a
> > mountpoint.  When do they go away, anyway?  When we don't reference them
> > anymore?  Right now "attached to mount tree" == "+1 to refcount" and detaching
> > happens explicitly - outside of the "dropping the final reference" path.
> > Might become a locking issue.
> 
> Ahh. Umm.. Yes. I think this might be the real problem. Unless I seriously 
> clossed something over when I blathered about the "create the vfsmount on 
> the fly" thing above ;)

> > 5) Creation of these vfsmounts: fs should somehow tell us whether it wants
> > one or not (at the very least, we should stop *somewhere*).  Can we use
> > the same dentry/inode?  I'm not sure and I really doubt that we'd like that.
> 
> Why not? When doing the ->lookup() operation, the filesystem would create
> the vfsmount and bind it to the current vfsmount. That guarantees that it
> has a vfsmount, and will mean that it will show up positive with the
> "d_mountpoint()" query, which in turn will cause us to do the
> "lookup_mnt()".

Several paragraphs below you are saying that you don't like fs messing with
vfsmounts.  Use of ->lookup() would mean that we should not only create
and attach vfsmounts from within fs code, but would actually have to make
->lookup() return vfsmount+dentry, AFAICS.
 
> > 6) if it's a method, where should it live, *especially* if we want them on
> > device nodes.  Note that inode_operations belongs to underlying fs, so it's
> > not particulary good place for device case.
> 
> Why not just let the existing .lookup method initialize the mount-point 
> thing? After that, it's all in the VFS layer (I'd hate to have filesystems 
> mess around with vfsmounts - they'll just get it wrong).

> Allow file-on-file mounts - it will just totally hide the thing (in that
> namespace, at least). But don't allow the dir-on-file thing (that we
> already don't allow).

Err...  What about dir-on-dir-that-is-on-file?  I.e. mount on foo/. when foo
is a file?
 
> > 9) how do we recognize such mountpoints in the path lookups?  It *is* a
> > hot path, so we should be careful in that area; the impact will be felt
> > by everything in the system.

> I don't think you'll have any special cases. Same d_mountpount(), same 
> lookup_mnt().

See above on use ->lookup()

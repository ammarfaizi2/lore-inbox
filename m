Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269242AbUH0JBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269242AbUH0JBh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUH0JBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:01:37 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:62917 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S269272AbUH0I5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:57:40 -0400
Subject: Re: [some sanity for a change] possible design issues for hybrids
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de, christer@weinigel.se,
       spam@tnonline.net, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.58.0408261436480.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
	 <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua>
	 <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org>
	 <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk>
	 <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0408261344150.2304@ppc970.osdl.org>
	 <20040826212853.GA21964@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0408261436480.2304@ppc970.osdl.org>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Message-Id: <1093596998.5994.34.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 27 Aug 2004 09:56:39 +0100
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 23:04, Linus Torvalds wrote:
> [ This is quite possibly just impossible and buggy, but here's my
>   implementation notes. You asked for them. ]
> On Thu, 26 Aug 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > All right, let's see where that would take us.
> > 3) what do we do on umount(2)?  We can get a bunch of vfsmounts hanging off
> > it.  MNT_DETACH will have no problems, but normal umount() is a different
> > story.  Note that it's not just hybrid-related problem - implementing the
> > mount traps will cause the same kind of trouble,
> 
> Don't allow umount. It's not something the user can unmount - the mount is 
> "implied" in the file. 
> 
> > 4) OK, we have those hybrids and want to create vfsmounts when crossing a
> > mountpoint.  When do they go away, anyway?  When we don't reference them
> > anymore?  Right now "attached to mount tree" == "+1 to refcount" and detaching
> > happens explicitly - outside of the "dropping the final reference" path.
> > Might become a locking issue.
> 
> Ahh. Umm.. Yes. I think this might be the real problem. Unless I seriously 
> clossed something over when I blathered about the "create the vfsmount on 
> the fly" thing above ;)

If it is created on the fly, it should be "easy" to destroy on the fly
using time-based expiry, i.e. a kernel daemon going over all of those
beasts every X seconds (X = 5 perhaps?) and doing something like:

for (each vfsmount) {
	lock_vfsmount(vfsmount);
	if (MOUNT_IS_BUSY(vfsmount)) {
		unlock_vfsmount(vfsmount);
		continue;
	}
	if (current_time() < (vfsmount->last_used_time +
			vfsmount->expire_after)) {
		unlock_vfsmount(vfsmount);
		continue;
	}
	destroy_locked_vfsmount(vfsmount);
}

Wouldn't that work?

> > 10) how do we deal with directories, anyway?  Mixing "attributes" with
> > normal directory contents is going to be fun, what with lseek() insanity.
> 
> You couldn't get at the attributes that way anyway, so I think the point 
> is moot. The "real" directory always takes over.
> 
> Crazy people could try to just use the regular "xattrs" interfaces if they 
> really want attributes on directories. You wouldn't ever be able to use 
> the "easy" one.

But that defeats the whole point of the hybrid objects!  We might as
well just keep the xattrs interface and throw away the new one if we
will have to keep the old one anyway so that we can do named
streams/attributes on directories.  Windows (and other OS?) certainly do
allow them and do use them on directories as well as files...

> > 11) if we go for your "here's stuff that belongs in device node viewed
> > as directory", how would that play with fs metadata exporters?  Again,
> > due to the insanity of lseek() on directories it's *very* hard to deal
> > with unions, when parts of directory come from different chunks of code.
> 
> Don't go there. See above. Directories would be just plain directories, 
> you could never see their metadata. Same goes for at least symlinks, and 
> possibly other filetypes too (ie at least initially, a block or character 
> special device will just take over the whole "file_operations", which 
> includes "readdir", so it's actually hard to have the filesystem do 
> anything about those).

Ah, but at least in other OS (Windows is the one I know about)
directories _also_ have the same semantics as files with respect to
named streams/attributes.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTKYS3X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 13:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTKYS3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 13:29:23 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:3037 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262838AbTKYS3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 13:29:20 -0500
Date: Tue, 25 Nov 2003 19:26:47 +0100
From: Manuel Estrada Sainz <ranty@debian.org>
To: Hannes Reinecke <hare@suse.de>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Andrey Borzenkov <arvidjaar@mail.ru>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is initramfs freed after kernel is booted?
Message-ID: <20031125182647.GA8068@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <E1ALlQs-000769-00.arvidjaar-mail-ru@f7.mail.ru> <3FB90A6A.4050505@nortelnetworks.com> <20031117180312.GZ24159@parcelfarce.linux.theplanet.co.uk> <200311172133.59839.arvidjaar@mail.ru> <20031117191513.GA24159@parcelfarce.linux.theplanet.co.uk> <3FBB8748.8020503@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBB8748.8020503@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 04:07:52PM +0100, Hannes Reinecke wrote:
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> >On Mon, Nov 17, 2003 at 09:33:59PM +0300, Andrey Borzenkov wrote:
> >
> >>On Monday 17 November 2003 21:03, viro@parcelfarce.linux.theplanet.co.uk 
> >>wrote:
> >>
> >>>On Mon, Nov 17, 2003 at 12:50:34PM -0500, Chris Friesen wrote:
> >>>
> >>>>viro@parcelfarce.linux.theplanet.co.uk wrote:
[snip]
> >You do, but you can trivially call unlink() on the executable itself.  It
> >will be freed after it does exec() of final /sbin/init...
> >
> >Alternatively, you could
> >mkdir /root
> >mount final root on /root
> >
> >chdir("/root");
> >mount("/", "initramfs", NULL, MS_BIND, NULL);
> >mount(".", "/", NULL, MS_MOVE, NULL);
> >chroot(".");
> >execve("/sbin/init", ...)
> >
> Nope. initramfs shares the superblock with 'rootfs', which has the 
> MS_NOUSER flags set. Hence graft_tree() (which is the worker function 
> for MS_BIND) refuses to work.
> Can't we just remove the MS_NOUSER flags if initramfs is active?
> Probably not the correct way, but certainly the quickest :-)
> The correct way would probably be to clone the superblock of initramfs, 
> set the filesystem-type of initramfs to 'ramfs' so that initramfs 
> appears to be a chroot()ed filesystem like initrd. Then we could do a 
> pivot_root and we have the contents of initramfs still available.
> But needs someone with deeper fs-knowledge than myself to do it.

 How about this one liner?

--- fs/ramfs/inode.c	22 Oct 2003 15:19:58 -0000	1.39
+++ fs/ramfs/inode.c	25 Nov 2003 18:10:00 -0000
@@ -207,7 +207,7 @@
 static struct super_block *rootfs_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
-	return get_sb_nodev(fs_type, flags|MS_NOUSER, data, ramfs_fill_super);
+	return get_sb_single(fs_type, flags, data, ramfs_fill_super);
 }
 
 static struct file_system_type ramfs_fs_type = {



 Since rootfs is supposed to be mounted just once, it shouldn't be a
 problem using get_sb_single().

 This way, you can mount rootfs anytime, and get in there to remove
 files.


 Am I missing something obvious here?

 Have a nice day

 	Manuel
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

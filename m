Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVAFNkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVAFNkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 08:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVAFNkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 08:40:17 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:28828 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262820AbVAFNkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 08:40:07 -0500
Date: Thu, 6 Jan 2005 15:41:44 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, ak@suse.de, mingo@elte.hu, rlrevell@joe-job.com,
       tiwai@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: [PATCH] make standard conversions work with compat_ioctl.
Message-ID: <20050106134144.GA25629@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Andrew Morton (akpm@osdl.org) "Re: [PATCH] deprecate (un)register_ioctl32_conversion":
> "Michael S. Tsirkin" <mst@mellanox.co.il> wrote:
> >  Christoph, I know you want to remove the inode parameter :)
> > 
> >  Otherwise I think -mm1 has the final version of the replacement.
> 
> I merged Christoph's verion of the patch into -mm.

Unfortunately, in -mm2 version, it seems that once a driver
implements compat_ioctl, the standard ioctls like FIOQSIZE
stop working for it, and so
do standard commands implemented with COMPATIBLE_IOCTL.

The simplest solution is, I think, to do as Arnd Bergmann suggested,
and go back to the hash lookup if compat_ioctl returns -ENOIOCTLCMD.

To make it easy to use the same function for unlocked_ioctl
and for ioctl_compat, for unlocked_ioctl the code -ENOIOCTLCMD
shall be translated to -EINVAL.

Attached patch is for -mm2, applies over 2.6.10 as well with 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm2/broken-out/ioctl-rework-2.patch

MST

Handle generic ioctl commands by falling back on static
conversion functions in fs/compat_ioctl.c on -ENOIOCTLCMD code.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

diff -rup linux-2.6.10/fs/compat.c linux-2.6.10-ioctls/fs/compat.c
--- linux-2.6.10/fs/compat.c	2005-01-06 17:54:13.234156872 +0200
+++ linux-2.6.10-ioctls/fs/compat.c	2005-01-06 17:37:38.110438672 +0200
@@ -440,8 +440,10 @@ asmlinkage long compat_sys_ioctl(unsigne
 		if (!filp->f_op->ioctl)
 			goto do_ioctl;
 	} else if (filp->f_op->compat_ioctl) {
+		/* compat_ioctl returns -ENOIOCTLCMD on unhandled command. */
 		error = filp->f_op->compat_ioctl(filp, cmd, arg);
-		goto out_fput;
+		if (error != -ENOIOCTLCMD)
+			goto out_fput;
 	}
 
 	down_read(&ioctl32_sem);
diff -rup linux-2.6.10/fs/ioctl.c linux-2.6.10-ioctls/fs/ioctl.c
--- linux-2.6.10/fs/ioctl.c	2005-01-06 17:54:13.235156720 +0200
+++ linux-2.6.10-ioctls/fs/ioctl.c	2005-01-06 18:00:10.463849704 +0200
@@ -26,6 +26,9 @@ static long do_ioctl(struct file *filp, 
 
 	if (filp->f_op->unlocked_ioctl) {
 		error = filp->f_op->unlocked_ioctl(filp, cmd, arg);
+		if (error == -ENOIOCTLCMD)
+			error = -EINVAL;
+		goto out;
 	} else if (filp->f_op->ioctl) {
 		lock_kernel();
 		error = filp->f_op->ioctl(filp->f_dentry->d_inode,

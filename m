Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVAUB1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVAUB1W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 20:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVAUB1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 20:27:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:21418 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261546AbVAUB1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 20:27:15 -0500
Date: Thu, 20 Jan 2005 17:26:56 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>, ak@suse.de,
       Greg KH <greg@kroah.com>, tiwai@suse.de, mingo@elte.hu,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, VANDROVE@vc.cvut.cz
Subject: [PATCH] compat ioctl security hook fixup
Message-ID: <20050120172656.R24171@build.pdx.osdl.net>
References: <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050112203606.GA23307@mellanox.co.il> <20050112212954.GA13558@kroah.com> <20050112214326.GB14703@wotan.suse.de> <20050112225230.GA14590@kroah.com> <20050112151049.7473db7d.akpm@osdl.org> <20050119213818.55b14bb0.akpm@osdl.org> <20050121000935.GA341@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050121000935.GA341@mellanox.co.il>; from mst@mellanox.co.il on Fri, Jan 21, 2005 at 02:09:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael S. Tsirkin (mst@mellanox.co.il) wrote:
> Security hook seems to be missing before compat_ioctl in mm2.
> And, it would be nice to avoid calling it twice on some paths.
> 
> Chris Wright's patch addressed this in the most elegant way I think,
> by adding vfs_ioctl.

The patch below is against Linus' tree as per Andrew's request.  It will
conflict with some of the changes in -mm2 (including the some-fixes bit
from Andi, and LTT).  I also have a patch directly against -mm2 if anyone
would like to see that instead.

thanks,
-chris
--

Introduce a simple helper, vfs_ioctl(), so that both sys_ioctl() and
compat_sys_ioctl() call the security hook in all cases and without
duplication.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== fs/ioctl.c 1.15 vs edited =====
--- 1.15/fs/ioctl.c	2005-01-15 14:31:01 -08:00
+++ edited/fs/ioctl.c	2005-01-18 11:18:33 -08:00
@@ -77,21 +77,10 @@ static int file_ioctl(struct file *filp,
 	return do_ioctl(filp, cmd, arg);
 }
 
-
-asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+int vfs_ioctl(struct file *filp, unsigned int fd, unsigned int cmd, unsigned long arg)
 {
-	struct file * filp;
 	unsigned int flag;
-	int on, error = -EBADF;
-	int fput_needed;
-
-	filp = fget_light(fd, &fput_needed);
-	if (!filp)
-		goto out;
-
-	error = security_file_ioctl(filp, cmd, arg);
-	if (error)
-		goto out_fput;
+	int on, error = 0;
 
 	switch (cmd) {
 		case FIOCLEX:
@@ -157,6 +146,24 @@ asmlinkage long sys_ioctl(unsigned int f
 				error = do_ioctl(filp, cmd, arg);
 			break;
 	}
+	return error;
+}
+
+asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{
+	struct file * filp;
+	int error = -EBADF;
+	int fput_needed;
+
+	filp = fget_light(fd, &fput_needed);
+	if (!filp)
+		goto out;
+
+	error = security_file_ioctl(filp, cmd, arg);
+	if (error)
+		goto out_fput;
+
+	error = vfs_ioctl(filp, fd, cmd, arg);
  out_fput:
 	fput_light(filp, fput_needed);
  out:
===== fs/compat.c 1.48 vs edited =====
--- 1.48/fs/compat.c	2005-01-15 14:31:01 -08:00
+++ edited/fs/compat.c	2005-01-18 11:07:56 -08:00
@@ -437,6 +437,11 @@ asmlinkage long compat_sys_ioctl(unsigne
 	if (!filp)
 		goto out;
 
+	/* RED-PEN how should LSM module know it's handling 32bit? */
+	error = security_file_ioctl(filp, cmd, arg);
+	if (error)
+		goto out_fput;
+
 	if (filp->f_op && filp->f_op->compat_ioctl) {
 		error = filp->f_op->compat_ioctl(filp, cmd, arg);
 		if (error != -ENOIOCTLCMD)
@@ -477,7 +482,7 @@ asmlinkage long compat_sys_ioctl(unsigne
 
 	up_read(&ioctl32_sem);
  do_ioctl:
-	error = sys_ioctl(fd, cmd, arg);
+	error = vfs_ioctl(filp, fd, cmd, arg);
  out_fput:
 	fput_light(filp, fput_needed);
  out:
===== include/linux/fs.h 1.373 vs edited =====
--- 1.373/include/linux/fs.h	2005-01-15 14:31:01 -08:00
+++ edited/include/linux/fs.h	2005-01-18 11:10:54 -08:00
@@ -1564,6 +1564,8 @@ extern int vfs_stat(char __user *, struc
 extern int vfs_lstat(char __user *, struct kstat *);
 extern int vfs_fstat(unsigned int, struct kstat *);
 
+extern int vfs_ioctl(struct file *, unsigned int, unsigned int, unsigned long);
+
 extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_super(struct block_device *);
 extern struct super_block *user_get_super(dev_t);

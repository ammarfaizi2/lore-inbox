Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVAUGii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVAUGii (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVAUGih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:38:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:13744 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262283AbVAUGfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:35:50 -0500
Date: Thu, 20 Jan 2005 22:35:09 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, tiwai@suse.de,
       mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, VANDROVE@vc.cvut.cz
Subject: [PATCH] compat ioctl security hook fixup (take2)
Message-ID: <20050120223509.T24171@build.pdx.osdl.net>
References: <20050112212954.GA13558@kroah.com> <20050112214326.GB14703@wotan.suse.de> <20050112225230.GA14590@kroah.com> <20050112151049.7473db7d.akpm@osdl.org> <20050119213818.55b14bb0.akpm@osdl.org> <20050121000935.GA341@mellanox.co.il> <20050120172656.R24171@build.pdx.osdl.net> <20050121041959.GA27155@wotan.suse.de> <20050120215103.S24171@build.pdx.osdl.net> <20050121061119.GA657@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050121061119.GA657@wotan.suse.de>; from ak@suse.de on Fri, Jan 21, 2005 at 07:11:19AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Thu, Jan 20, 2005 at 09:51:03PM -0800, Chris Wright wrote:
> > > If you add it make at least sure it's not EXPORT_SYMBOL()ed.
> > 
> > It's certainly not, nor intended to be.  Would a comment to that
> > affect alleviate your concern?
> 
> Yes please.

Patch respun, with comment added.

thanks,
-chris
--

Introduce a simple helper, vfs_ioctl(), so that both sys_ioctl() and
compat_sys_ioctl() call the security hook in all cases and without
duplication.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== fs/ioctl.c 1.15 vs edited =====
--- 1.15/fs/ioctl.c	2005-01-15 14:31:01 -08:00
+++ edited/fs/ioctl.c	2005-01-20 22:27:43 -08:00
@@ -77,21 +77,13 @@ static int file_ioctl(struct file *filp,
 	return do_ioctl(filp, cmd, arg);
 }
 
-
-asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+/* Simple helper for sys_ioctl and compat_sys_ioctl.  Not for drivers'
+ * use, and not intended to be EXPORT_SYMBOL()'d
+ */
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
@@ -157,6 +149,24 @@ asmlinkage long sys_ioctl(unsigned int f
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
+++ edited/fs/compat.c	2005-01-20 22:25:33 -08:00
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
+++ edited/include/linux/fs.h	2005-01-20 22:25:33 -08:00
@@ -1564,6 +1564,8 @@ extern int vfs_stat(char __user *, struc
 extern int vfs_lstat(char __user *, struct kstat *);
 extern int vfs_fstat(unsigned int, struct kstat *);
 
+extern int vfs_ioctl(struct file *, unsigned int, unsigned int, unsigned long);
+
 extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_super(struct block_device *);
 extern struct super_block *user_get_super(dev_t);

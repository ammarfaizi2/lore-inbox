Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVARH7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVARH7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 02:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVARH7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 02:59:50 -0500
Received: from colin2.muc.de ([193.149.48.15]:2820 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261170AbVARH7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 02:59:39 -0500
Date: 18 Jan 2005 08:59:38 +0100
Date: Tue, 18 Jan 2005 08:59:38 +0100
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org
Cc: mike.miller@hp.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Convert cciss to compat_ioctl
Message-ID: <20050118075938.GE76018@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the cciss driver to compat_ioctl.  This cleans up a lot 
of code.

I don't have such hardware thus this is only compile tested.

This requires the block device compat_ioctl patch I sent earlier.

Signed-off-by: Andi Kleen <ak@muc.de>

diff -u linux-2.6.11-rc1-bk4/drivers/block/cciss.c-o linux-2.6.11-rc1-bk4/drivers/block/cciss.c
--- linux-2.6.11-rc1-bk4/drivers/block/cciss.c-o	2005-01-14 10:12:17.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/block/cciss.c	2005-01-18 06:30:43.000000000 +0100
@@ -146,11 +146,18 @@
 static void cciss_procinit(int i) {}
 #endif /* CONFIG_PROC_FS */
 
+#ifdef CONFIG_COMPAT
+static int cciss_compat_ioctl(struct file *f, unsigned cmd, unsigned long arg);
+#endif
+
 static struct block_device_operations cciss_fops  = {
 	.owner		= THIS_MODULE,
 	.open		= cciss_open, 
 	.release       	= cciss_release,
         .ioctl		= cciss_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl   = cciss_compat_ioctl,
+#endif
 	.revalidate_disk= cciss_revalidate,
 };
 
@@ -477,80 +484,50 @@
 }
 
 #ifdef CONFIG_COMPAT
-/* for AMD 64 bit kernel compatibility with 32-bit userland ioctls */
-extern long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
-extern int
-register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int,
-      unsigned int, unsigned long, struct file *));
-extern int unregister_ioctl32_conversion(unsigned int cmd);
-
-static int cciss_ioctl32_passthru(unsigned int fd, unsigned cmd, unsigned long arg, struct file *file);
-static int cciss_ioctl32_big_passthru(unsigned int fd, unsigned cmd, unsigned long arg,
-	struct file *file);
-
-typedef int (*handler_type) (unsigned int, unsigned int, unsigned long, struct file *);
-
-static struct ioctl32_map {
-	unsigned int cmd;
-	handler_type handler;
-	int registered;
-} cciss_ioctl32_map[] = {
-	{ CCISS_GETPCIINFO,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_GETINTINFO,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_SETINTINFO,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_GETNODENAME,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_SETNODENAME,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_GETHEARTBEAT,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_GETBUSTYPES,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_GETFIRMVER,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_GETDRIVVER,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_REVALIDVOLS,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_PASSTHRU32,	cciss_ioctl32_passthru, 0 },
-	{ CCISS_DEREGDISK,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_REGNEWDISK,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_REGNEWD,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_RESCANDISK,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_GETLUNINFO,	(handler_type) sys_ioctl, 0 },
-	{ CCISS_BIG_PASSTHRU32,	cciss_ioctl32_big_passthru, 0 },
-};
-#define NCCISS_IOCTL32_ENTRIES (sizeof(cciss_ioctl32_map) / sizeof(cciss_ioctl32_map[0]))
-static void register_cciss_ioctl32(void)
-{
-	int i, rc;
 
-	for (i=0; i < NCCISS_IOCTL32_ENTRIES; i++) {
-		rc = register_ioctl32_conversion(
-			cciss_ioctl32_map[i].cmd,
-			cciss_ioctl32_map[i].handler);
-		if (rc != 0) {
-			printk(KERN_WARNING "cciss: failed to register "
-				"32 bit compatible ioctl 0x%08x\n",
-				cciss_ioctl32_map[i].cmd);
-			cciss_ioctl32_map[i].registered = 0;
-		} else
-			cciss_ioctl32_map[i].registered = 1;
-	}
-}
-static void unregister_cciss_ioctl32(void)
+static int do_ioctl(struct file *f, unsigned cmd, unsigned long arg)
 {
-	int i, rc;
+	int ret;
+	lock_kernel();
+	ret = cciss_ioctl(f->f_dentry->d_inode, f, cmd, arg);
+	unlock_kernel();
+	return ret;
+}
 
-	for (i=0; i < NCCISS_IOCTL32_ENTRIES; i++) {
-		if (!cciss_ioctl32_map[i].registered)
-			continue;
-		rc = unregister_ioctl32_conversion(
-			cciss_ioctl32_map[i].cmd);
-		if (rc == 0) {
-			cciss_ioctl32_map[i].registered = 0;
-			continue;
-		}
-		printk(KERN_WARNING "cciss: failed to unregister "
-			"32 bit compatible ioctl 0x%08x\n",
-			cciss_ioctl32_map[i].cmd);
+static int cciss_ioctl32_passthru(struct file *f, unsigned cmd, unsigned long arg);
+static int cciss_ioctl32_big_passthru(struct file *f, unsigned cmd, unsigned long arg);
+
+static long cciss_compat_ioctl(struct file *f, unsigned cmd, unsigned long arg)
+{
+	switch (cmd) { 
+	case CCISS_GETPCIINFO:
+	case CCISS_GETINTINFO:
+	case CCISS_SETINTINFO:
+	case CCISS_GETNODENAME:
+	case CCISS_SETNODENAME:
+	case CCISS_GETHEARTBEAT:
+	case CCISS_GETBUSTYPES:
+	case CCISS_GETFIRMVER:
+	case CCISS_GETDRIVVER:
+	case CCISS_REVALIDVOLS:
+	case CCISS_DEREGDISK:
+	case CCISS_REGNEWDISK:
+	case CCISS_REGNEWD:
+	case CCISS_RESCANDISK:
+	case CCISS_GETLUNINFO:
+		return do_ioctl(f, cmd, arg);
+
+	case CCISS_PASSTHRU32:
+		return cciss_ioctl32_passthru(f, cmd, arg);
+	case CCISS_BIG_PASSTHRU32:
+		return cciss_ioctl32_big_passthru(f, cmd, arg);
+		
+	default:
+		return -ENOIOCTLCMD;
 	}
 }
-int cciss_ioctl32_passthru(unsigned int fd, unsigned cmd, unsigned long arg,
-	struct file *file)
+
+static int cciss_ioctl32_passthru(struct file *f, unsigned cmd, unsigned long arg)
 {
 	IOCTL32_Command_struct __user *arg32 =
 		(IOCTL32_Command_struct __user *) arg;
@@ -571,7 +548,7 @@
 	if (err)
 		return -EFAULT;
 
-	err = sys_ioctl(fd, CCISS_PASSTHRU, (unsigned long) p);
+	err = do_ioctl(f, CCISS_PASSTHRU, (unsigned long) p);
 	if (err)
 		return err;
 	err |= copy_in_user(&arg32->error_info, &p->error_info, sizeof(arg32->error_info));
@@ -580,8 +557,7 @@
 	return err;
 }
 
-int cciss_ioctl32_big_passthru(unsigned int fd, unsigned cmd, unsigned long arg,
-	struct file *file)
+static int cciss_ioctl32_big_passthru(struct file *file, unsigned cmd, unsigned long arg)
 {
 	BIG_IOCTL32_Command_struct __user *arg32 =
 		(BIG_IOCTL32_Command_struct __user *) arg;
@@ -603,7 +579,7 @@
 	if (err)
 		 return -EFAULT;
 
-	err = sys_ioctl(fd, CCISS_BIG_PASSTHRU, (unsigned long) p);
+	err = do_ioctl(file, CCISS_BIG_PASSTHRU, (unsigned long) p);
 	if (err)
 		return err;
 	err |= copy_in_user(&arg32->error_info, &p->error_info, sizeof(arg32->error_info));
@@ -611,9 +587,6 @@
 		return -EFAULT;
 	return err;
 }
-#else
-static inline void register_cciss_ioctl32(void) {}
-static inline void unregister_cciss_ioctl32(void) {}
 #endif
 /*
  * ioctl 
@@ -2915,7 +2888,6 @@
 
 static int __init init_cciss_module(void)
 {
-	register_cciss_ioctl32();
 	return ( cciss_init());
 }
 
@@ -2923,7 +2895,6 @@
 {
 	int i;
 
-	unregister_cciss_ioctl32();
 	pci_unregister_driver(&cciss_pci_driver);
 	/* double check that all controller entrys have been removed */
 	for (i=0; i< MAX_CTLR; i++) 

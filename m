Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUFIPje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUFIPje (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 11:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266171AbUFIPgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 11:36:54 -0400
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:8461 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S265807AbUFIPet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 11:34:49 -0400
Date: Wed, 9 Jun 2004 10:36:17 -0500 (CDT)
From: mikem@beardog.cca.cpqcorp.net
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: cciss update for 2.4.27
Message-ID: <Pine.LNX.4.58.0406091031030.2861@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is pass 2 of the patch that adds conversion functions for 32-bit apps
running on a 64-bit kernel on x86_64.
Changed the ifdef from using a compiler directive to using the
CONFIG_COMPAT flag. Cleaned up the compile-time warnings thanks to Andrew
Morton.
Please consider this for inclusion in 2.4.27. It is critical for the HP
ACU and management agents.

Thanks,
mikem
mike.miller@hp.com
-------------------------------------------------------------------------------
 drivers/block/cciss.c       |  146 +++++++++++++++++++++++++++++++++++++++++++- include/linux/cciss_ioctl.h |   27 ++++++++
 2 files changed, 172 insertions(+), 1 deletion(-)

diff -burpN lx2427-rc5.orig/drivers/block/cciss.c lx2427-rc5/drivers/block/cciss.c
--- lx2427-rc5.orig/drivers/block/cciss.c	2004-06-09 09:38:34.000000000 -0500
+++ lx2427-rc5/drivers/block/cciss.c	2004-06-09 09:46:19.000000000 -0500
@@ -493,6 +493,149 @@ static int cciss_release(struct inode *i
 	return 0;
 }

+#ifdef CONFIG_COMPAT
+/* for AMD 64 bit kernel compatibility with 32-bit userland ioctls */
+extern int sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
+
+extern int
+register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int,
+      unsigned int, unsigned long, struct file *));
+extern int unregister_ioctl32_conversion(unsigned int cmd);
+
+static int cciss_ioctl32_passthru(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file);
+static int cciss_ioctl32_big_passthru(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file);
+
+typedef int (*handler_type)(unsigned int, unsigned int, unsigned long,
+				struct file *);
+
+static struct ioctl32_map {
+	unsigned int cmd;
+	handler_type handler;
+	int registered;
+} cciss_ioctl32_map[] = {
+	{ CCISS_GETPCIINFO,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_GETINTINFO,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_SETINTINFO,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_GETNODENAME,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_SETNODENAME,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_GETHEARTBEAT,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_GETBUSTYPES,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_GETFIRMVER,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_GETDRIVVER,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_REVALIDVOLS,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_PASSTHRU32,	cciss_ioctl32_passthru, 0 },
+	{ CCISS_DEREGDISK,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_REGNEWDISK,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_REGNEWD,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_RESCANDISK,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_GETLUNINFO,	(handler_type)sys_ioctl, 0 },
+	{ CCISS_BIG_PASSTHRU32,	cciss_ioctl32_big_passthru, 0 },
+};
+#define NCCISS_IOCTL32_ENTRIES (sizeof(cciss_ioctl32_map) / sizeof(cciss_ioctl32_map[0]))
+static void register_cciss_ioctl32(void)
+{
+	int i, rc;
+
+	for (i=0; i < NCCISS_IOCTL32_ENTRIES; i++) {
+		rc = register_ioctl32_conversion(
+			cciss_ioctl32_map[i].cmd,
+			cciss_ioctl32_map[i].handler);
+		if (rc != 0) {
+			printk(KERN_WARNING "cciss: failed to register "
+				"32 bit compatible ioctl 0x%08x\n",
+				cciss_ioctl32_map[i].cmd);
+			cciss_ioctl32_map[i].registered = 0;
+		} else
+			cciss_ioctl32_map[i].registered = 1;
+	}
+}
+static void unregister_cciss_ioctl32(void)
+{
+	int i, rc;
+
+	for (i=0; i < NCCISS_IOCTL32_ENTRIES; i++) {
+		if (!cciss_ioctl32_map[i].registered)
+			continue;
+		rc = unregister_ioctl32_conversion(
+			cciss_ioctl32_map[i].cmd);
+		if (rc == 0) {
+			cciss_ioctl32_map[i].registered = 0;
+			continue;
+		}
+		printk(KERN_WARNING "cciss: failed to unregister "
+			"32 bit compatible ioctl 0x%08x\n",
+			cciss_ioctl32_map[i].cmd);
+	}
+}
+int cciss_ioctl32_passthru(unsigned int fd, unsigned int cmd, unsigned long arg,
+	struct file *file)
+{
+	IOCTL32_Command_struct *arg32 =
+		(IOCTL32_Command_struct *) arg;
+	IOCTL_Command_struct arg64;
+	mm_segment_t old_fs;
+	int err;
+	unsigned long cp;
+
+	err = 0;
+	err |= copy_from_user(&arg64.LUN_info, &arg32->LUN_info, sizeof(arg64.LUN_info));
+	err |= copy_from_user(&arg64.Request, &arg32->Request, sizeof(arg64.Request));
+	err |= copy_from_user(&arg64.error_info, &arg32->error_info, sizeof(arg64.error_info));
+	err |= get_user(arg64.buf_size, &arg32->buf_size);
+	err |= get_user(cp, &arg32->buf);
+	arg64.buf = (BYTE *)cp;
+
+	if (err)
+		return -EFAULT;
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	err = sys_ioctl(fd, CCISS_PASSTHRU, (unsigned long) &arg64);
+	set_fs(old_fs);
+	if (err)
+		return err;
+	err |= copy_to_user(&arg32->error_info, &arg64.error_info, sizeof(&arg32->error_info));
+	if (err)
+		return -EFAULT;
+	return err;
+}
+int cciss_ioctl32_big_passthru(unsigned int fd, unsigned int cmd, unsigned long arg,
+	struct file *file)
+{
+	BIG_IOCTL32_Command_struct *arg32 =
+		(BIG_IOCTL32_Command_struct *) arg;
+	BIG_IOCTL_Command_struct arg64;
+	mm_segment_t old_fs;
+	int err;
+	unsigned long cp;
+
+	err = 0;
+	err |= copy_from_user(&arg64.LUN_info, &arg32->LUN_info, sizeof(arg64.LUN_info));
+	err |= copy_from_user(&arg64.Request, &arg32->Request, sizeof(arg64.Request));
+	err |= copy_from_user(&arg64.error_info, &arg32->error_info, sizeof(arg64.error_info));
+	err |= get_user(arg64.buf_size, &arg32->buf_size);
+	err |= get_user(arg64.malloc_size, &arg32->malloc_size);
+	err |= get_user(cp, &arg32->buf);
+	arg64.buf = (BYTE *)cp;
+
+	if (err)
+		return -EFAULT;
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	err = sys_ioctl(fd, CCISS_BIG_PASSTHRU, (unsigned long) &arg64);
+	set_fs(old_fs);
+	if (err)
+		return err;
+	err |= copy_to_user(&arg32->error_info, &arg64.error_info, sizeof(&arg32->error_info));
+	if (err)
+		return -EFAULT;
+	return err;
+}
+#else
+static inline void register_cciss_ioctl32(void) {}
+static inline void unregister_cciss_ioctl32(void) {}
+#endif
 /*
  * ioctl
  */
@@ -3323,7 +3466,7 @@ int __init cciss_init(void)
 EXPORT_NO_SYMBOLS;
 static int __init init_cciss_module(void)
 {
-
+	register_cciss_ioctl32();
 	return cciss_init();
 }

@@ -3331,6 +3474,7 @@ static void __exit cleanup_cciss_module(
 {
 	int i;

+	unregister_cciss_ioctl32();
 	pci_unregister_driver(&cciss_pci_driver);
 	/* double check that all controller entrys have been removed */
 	for (i=0; i< MAX_CTLR; i++) {
diff -burpN lx2427-rc5.orig/include/linux/cciss_ioctl.h lx2427-rc5/include/linux/cciss_ioctl.h
--- lx2427-rc5.orig/include/linux/cciss_ioctl.h	2003-06-13 09:51:38.000000000 -0500
+++ lx2427-rc5/include/linux/cciss_ioctl.h	2004-06-09 09:44:00.000000000 -0500
@@ -208,4 +208,31 @@ typedef struct _LogvolInfo_struct{
 #define CCISS_GETLUNINFO  _IOR(CCISS_IOC_MAGIC, 17, LogvolInfo_struct)
 #define CCISS_BIG_PASSTHRU _IOWR(CCISS_IOC_MAGIC, 18, BIG_IOCTL_Command_struct)

+#ifdef __KERNEL__
+#ifdef CONFIG_COMPAT
+
+/* 32 bit compatible ioctl structs */
+typedef struct _IOCTL32_Command_struct {
+  LUNAddr_struct	   LUN_info;
+  RequestBlock_struct      Request;
+  ErrorInfo_struct  	   error_info;
+  WORD			   buf_size;  /* size in bytes of the buf */
+  __u32			   buf; /* 32 bit pointer to data buffer */
+} IOCTL32_Command_struct;
+
+typedef struct _BIG_IOCTL32_Command_struct {
+  LUNAddr_struct	   LUN_info;
+  RequestBlock_struct      Request;
+  ErrorInfo_struct  	   error_info;
+  DWORD			   malloc_size; /* < MAX_KMALLOC_SIZE in cciss.c */
+  DWORD			   buf_size;    /* size in bytes of the buf */
+  				        /* < malloc_size * MAXSGENTRIES */
+  __u32 		buf;	/* 32 bit pointer to data buffer */
+} BIG_IOCTL32_Command_struct;
+
+#define CCISS_PASSTHRU32   _IOWR(CCISS_IOC_MAGIC, 11, IOCTL32_Command_struct)
+#define CCISS_BIG_PASSTHRU32 _IOWR(CCISS_IOC_MAGIC, 18, BIG_IOCTL32_Command_struct)
+
+#endif /* CONFIG_COMPAT */
+#endif /* __KERNEL__ */
 #endif


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVLPOd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVLPOd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVLPOd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:33:57 -0500
Received: from verein.lst.de ([213.95.11.210]:16282 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932309AbVLPOd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:33:56 -0500
Date: Fri, 16 Dec 2005 15:33:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, schwidefsky@de.ibm.com, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dasd: remove dynamic ioctl registration
Message-ID: <20051216143348.GB19541@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dasd has some really messy code to allow submodule to register ioctl.
Right now there are two cases:  cmd and eckd.

cmd was merged into the main module in the last patchh, so we don't
need the mechanism for it anymore.

eckd is actually broken right now because we allow calling the eckd
ioctls on other dasd disciplines aswell, but they assume eckd-specific
private data.

Fix this second issue by adding an ioctl method to the dasd_discipline
structure.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.15-rc5/drivers/s390/block/dasd.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/s390/block/dasd.c	2005-12-16 15:17:43.000000000 +0100
+++ linux-2.6.15-rc5/drivers/s390/block/dasd.c	2005-12-16 15:19:29.000000000 +0100
@@ -1762,7 +1762,6 @@
 #ifdef CONFIG_PROC_FS
 	dasd_proc_exit();
 #endif
-	dasd_ioctl_exit();
         if (dasd_page_cache != NULL) {
 		kmem_cache_destroy(dasd_page_cache);
 		dasd_page_cache = NULL;
@@ -2034,9 +2033,6 @@
 	rc = dasd_parse();
 	if (rc)
 		goto failed;
-	rc = dasd_ioctl_init();
-	if (rc)
-		goto failed;
 #ifdef CONFIG_PROC_FS
 	rc = dasd_proc_init();
 	if (rc)
Index: linux-2.6.15-rc5/drivers/s390/block/dasd_diag.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/s390/block/dasd_diag.c	2005-12-16 15:17:43.000000000 +0100
+++ linux-2.6.15-rc5/drivers/s390/block/dasd_diag.c	2005-12-16 15:19:29.000000000 +0100
@@ -612,6 +612,7 @@
 	.free_cp = dasd_diag_free_cp,
 	.dump_sense = dasd_diag_dump_sense,
 	.fill_info = dasd_diag_fill_info,
+	.ioctl = dasd_generic_ioctl,
 };
 
 static int __init
Index: linux-2.6.15-rc5/drivers/s390/block/dasd_eckd.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/s390/block/dasd_eckd.c	2005-12-16 15:17:43.000000000 +0100
+++ linux-2.6.15-rc5/drivers/s390/block/dasd_eckd.c	2005-12-16 15:19:29.000000000 +0100
@@ -1485,6 +1485,26 @@
 	return 0;
 }
 
+static int
+dasd_eckd_ioctl(struct block_device *bdev, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case BIODASDGATTR:
+		return dasd_eckd_get_attrib(bdev, cmd, arg);
+	case BIODASDSATTR:
+		return dasd_eckd_set_attrib(bdev, cmd, arg);
+	case BIODASDPSRD:
+		return dasd_eckd_performance(bdev, cmd, arg);
+	case BIODASDRLSE:
+		return dasd_eckd_release(bdev, cmd, arg);
+	case BIODASDRSRV:
+		return dasd_eckd_reserve(bdev, cmd, arg);
+	case BIODASDSLCK:
+		return dasd_eckd_steal_lock(bdev, cmd, arg);
+	default:
+		return dasd_generic_ioctl(bdev, cmd, arg);
+}
+
 /*
  * Print sense data and related channel program.
  * Parts are printed because printk buffer is only 1024 bytes.
@@ -1643,6 +1663,7 @@
 	.free_cp = dasd_eckd_free_cp,
 	.dump_sense = dasd_eckd_dump_sense,
 	.fill_info = dasd_eckd_fill_info,
+	.ioctl = dasd_eckd_ioctl,
 };
 
 static int __init
@@ -1650,37 +1671,11 @@
 {
 	int ret;
 
-	dasd_ioctl_no_register(THIS_MODULE, BIODASDGATTR,
-			       dasd_eckd_get_attrib);
-	dasd_ioctl_no_register(THIS_MODULE, BIODASDSATTR,
-			       dasd_eckd_set_attrib);
-	dasd_ioctl_no_register(THIS_MODULE, BIODASDPSRD,
-			       dasd_eckd_performance);
-	dasd_ioctl_no_register(THIS_MODULE, BIODASDRLSE,
-			       dasd_eckd_release);
-	dasd_ioctl_no_register(THIS_MODULE, BIODASDRSRV,
-			       dasd_eckd_reserve);
-	dasd_ioctl_no_register(THIS_MODULE, BIODASDSLCK,
-			       dasd_eckd_steal_lock);
-
 	ASCEBC(dasd_eckd_discipline.ebcname, 4);
 
 	ret = ccw_driver_register(&dasd_eckd_driver);
-	if (ret) {
-		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDGATTR,
-					 dasd_eckd_get_attrib);
-		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDSATTR,
-					 dasd_eckd_set_attrib);
-		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDPSRD,
-					 dasd_eckd_performance);
-		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDRLSE,
-					 dasd_eckd_release);
-		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDRSRV,
-					 dasd_eckd_reserve);
-		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDSLCK,
-					 dasd_eckd_steal_lock);
+	if (ret)
 		return ret;
-	}
 
 	dasd_generic_auto_online(&dasd_eckd_driver);
 	return 0;
@@ -1690,19 +1685,6 @@
 dasd_eckd_cleanup(void)
 {
 	ccw_driver_unregister(&dasd_eckd_driver);
-
-	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDGATTR,
-				 dasd_eckd_get_attrib);
-	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDSATTR,
-				 dasd_eckd_set_attrib);
-	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDPSRD,
-				 dasd_eckd_performance);
-	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDRLSE,
-				 dasd_eckd_release);
-	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDRSRV,
-				 dasd_eckd_reserve);
-	dasd_ioctl_no_unregister(THIS_MODULE, BIODASDSLCK,
-				 dasd_eckd_steal_lock);
 }
 
 module_init(dasd_eckd_init);
Index: linux-2.6.15-rc5/drivers/s390/block/dasd_fba.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/s390/block/dasd_fba.c	2005-12-16 15:17:43.000000000 +0100
+++ linux-2.6.15-rc5/drivers/s390/block/dasd_fba.c	2005-12-16 15:19:29.000000000 +0100
@@ -565,6 +565,7 @@
 	.free_cp = dasd_fba_free_cp,
 	.dump_sense = dasd_fba_dump_sense,
 	.fill_info = dasd_fba_fill_info,
+	.ioctl = dasd_generic_ioctl,
 };
 
 static int __init
Index: linux-2.6.15-rc5/drivers/s390/block/dasd_int.h
===================================================================
--- linux-2.6.15-rc5.orig/drivers/s390/block/dasd_int.h	2005-12-16 15:17:43.000000000 +0100
+++ linux-2.6.15-rc5/drivers/s390/block/dasd_int.h	2005-12-16 15:26:34.000000000 +0100
@@ -69,15 +69,6 @@
  */
 struct dasd_device;
 
-typedef int (*dasd_ioctl_fn_t) (struct block_device *bdev, int no, long args);
-
-struct dasd_ioctl {
-	struct list_head list;
-	struct module *owner;
-	int no;
-	dasd_ioctl_fn_t handler;
-};
-
 typedef enum {
 	dasd_era_fatal = -1,	/* no chance to recover		     */
 	dasd_era_none = 0,	/* don't recover, everything alright */
@@ -272,6 +263,7 @@
         /* i/o control functions. */
 	int (*fill_geometry) (struct dasd_device *, struct hd_geometry *);
 	int (*fill_info) (struct dasd_device *, struct dasd_information2_t *);
+	int (*ioctl) (struct block_device, unsigned int, unsigned long);
 };
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
@@ -490,6 +482,17 @@
 int dasd_generic_notify(struct ccw_device *, int);
 void dasd_generic_auto_online (struct ccw_driver *);
 
+/* externals in dasd_cmb.c */
+#ifdef CONFIG_DASD_CMB
+int  dasd_cmd_ioctl(struct block_device *, unsigned int, unsigned long);
+#else
+static inline int dasd_cmd_ioctl(struct block_device *bdev,
+		unsigned int cmd, unsigned long arg)
+{
+	return -ENOIOCTLCMD;
+}
+#endif
+
 /* externals in dasd_devmap.c */
 extern int dasd_max_devindex;
 extern int dasd_probeonly;
@@ -522,10 +525,7 @@
 void dasd_destroy_partitions(struct dasd_device *);
 
 /* externals in dasd_ioctl.c */
-int  dasd_ioctl_init(void);
-void dasd_ioctl_exit(void);
-int  dasd_ioctl_no_register(struct module *, int, dasd_ioctl_fn_t);
-int  dasd_ioctl_no_unregister(struct module *, int, dasd_ioctl_fn_t);
+int  dasd_generic_ioctl(struct block_device *, unsigned int, unsigned long);
 int  dasd_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
 long dasd_compat_ioctl(struct file *, unsigned int, unsigned long);
 
Index: linux-2.6.15-rc5/drivers/s390/block/dasd_ioctl.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/s390/block/dasd_ioctl.c	2005-12-16 15:17:43.000000000 +0100
+++ linux-2.6.15-rc5/drivers/s390/block/dasd_ioctl.c	2005-12-16 15:27:56.000000000 +0100
@@ -25,97 +25,20 @@
 
 #include "dasd_int.h"
 
-/*
- * SECTION: ioctl functions.
- */
-static struct list_head dasd_ioctl_list = LIST_HEAD_INIT(dasd_ioctl_list);
-
-/*
- * Find the ioctl with number no.
- */
-static struct dasd_ioctl *
-dasd_find_ioctl(int no)
-{
-	struct dasd_ioctl *ioctl;
-
-	list_for_each_entry (ioctl, &dasd_ioctl_list, list)
-		if (ioctl->no == no)
-			return ioctl;
-	return NULL;
-}
-
-/*
- * Register ioctl with number no.
- */
-int
-dasd_ioctl_no_register(struct module *owner, int no, dasd_ioctl_fn_t handler)
-{
-	struct dasd_ioctl *new;
-	if (dasd_find_ioctl(no))
-		return -EBUSY;
-	new = kmalloc(sizeof (struct dasd_ioctl), GFP_KERNEL);
-	if (new == NULL)
-		return -ENOMEM;
-	new->owner = owner;
-	new->no = no;
-	new->handler = handler;
-	list_add(&new->list, &dasd_ioctl_list);
-	return 0;
-}
-
-/*
- * Deregister ioctl with number no.
- */
-int
-dasd_ioctl_no_unregister(struct module *owner, int no, dasd_ioctl_fn_t handler)
-{
-	struct dasd_ioctl *old = dasd_find_ioctl(no);
-	if (old == NULL)
-		return -ENOENT;
-	if (old->no != no || old->handler != handler || owner != old->owner)
-		return -EINVAL;
-	list_del(&old->list);
-	kfree(old);
-	return 0;
-}
 
 int
-dasd_ioctl(struct inode *inp, struct file *filp,
-	   unsigned int no, unsigned long data)
+dasd_ioctl(struct inode *inode, struct file *file,
+	   unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inp->i_bdev;
+	struct block_device *bdev = inode->i_bdev;
 	struct dasd_device *device = bdev->bd_disk->private_data;
-	struct dasd_ioctl *ioctl;
-	const char *dir;
-	int rc;
+	int rval;
 
-	if ((_IOC_DIR(no) != _IOC_NONE) && (data == 0)) {
-		PRINT_DEBUG("empty data ptr");
-		return -EINVAL;
-	}
-	dir = _IOC_DIR (no) == _IOC_NONE ? "0" :
-		_IOC_DIR (no) == _IOC_READ ? "r" :
-		_IOC_DIR (no) == _IOC_WRITE ? "w" : 
-		_IOC_DIR (no) == (_IOC_READ | _IOC_WRITE) ? "rw" : "u";
-	DBF_DEV_EVENT(DBF_DEBUG, device,
-		      "ioctl 0x%08x %s'0x%x'%d(%d) with data %8lx", no,
-		      dir, _IOC_TYPE(no), _IOC_NR(no), _IOC_SIZE(no), data);
-	/* Search for ioctl no in the ioctl list. */
-	list_for_each_entry(ioctl, &dasd_ioctl_list, list) {
-		if (ioctl->no == no) {
-			/* Found a matching ioctl. Call it. */
-			if (!try_module_get(ioctl->owner))
-				continue;
-			rc = ioctl->handler(bdev, no, data);
-			module_put(ioctl->owner);
-			return rc;
-		}
-	}
-	/* No ioctl with number no. */
-	DBF_DEV_EVENT(DBF_INFO, device,
-		      "unknown ioctl 0x%08x=%s'0x%x'%d(%d) data %8lx", no,
-		      dir, _IOC_TYPE(no), _IOC_NR(no), _IOC_SIZE(no), data);
-	return -EINVAL;
+	rval = dasd_cmd_ioctl(bdev, cmd, arg);
+	if (rval != -ENOIOCTLCMD)
+		return rval;
+
+	return device->discipline->ioctl(bdev, cmd, arg);
 }
 
 long
@@ -497,47 +420,35 @@
 	return rc;
 }
 
-/*
- * List of static ioctls.
- */
-static struct { int no; dasd_ioctl_fn_t fn; } dasd_ioctls[] =
-{
-	{ BIODASDDISABLE, dasd_ioctl_disable },
-	{ BIODASDENABLE, dasd_ioctl_enable },
-	{ BIODASDQUIESCE, dasd_ioctl_quiesce },
-	{ BIODASDRESUME, dasd_ioctl_resume },
-	{ BIODASDFMT, dasd_ioctl_format },
-	{ BIODASDINFO, dasd_ioctl_information },
-	{ BIODASDINFO2, dasd_ioctl_information },
-	{ BIODASDPRRD, dasd_ioctl_read_profile },
-	{ BIODASDPRRST, dasd_ioctl_reset_profile },
-	{ BLKROSET, dasd_ioctl_set_ro },
-	{ DASDAPIVER, dasd_ioctl_api_version },
-	{ -1, NULL }
-};
-
-int
-dasd_ioctl_init(void)
-{
-	int i;
-
-	for (i = 0; dasd_ioctls[i].no != -1; i++)
-		dasd_ioctl_no_register(NULL, dasd_ioctls[i].no,
-				       dasd_ioctls[i].fn);
-	return 0;
-
-}
-
-void
-dasd_ioctl_exit(void)
+int dasd_generic_ioctl(struct block_device *bdev, unsigned int cmd,
+		unsigned long arg)
 {
-	int i;
-
-	for (i = 0; dasd_ioctls[i].no != -1; i++)
-		dasd_ioctl_no_unregister(NULL, dasd_ioctls[i].no,
-					 dasd_ioctls[i].fn);
+	switch (cmd) {
+	case BIODASDDISABLE:
+		return dasd_ioctl_disable(bdev, cmd, arg);
+	case BIODASDDISABLE:
+		return dasd_ioctl_disable(bdev, cmd, arg);
+	case BIODASDENABLE:
+		return dasd_ioctl_enable(bdev, cmd, arg);
+	case BIODASDQUIESCE:
+		return dasd_ioctl_quiesce(bdev, cmd, arg);
+	case BIODASDRESUME:
+		return dasd_ioctl_resume(bdev, cmd, arg);
+	case BIODASDFMT:
+		return dasd_ioctl_format(bdev, cmd, arg);
+	case BIODASDINFO:
+		return dasd_ioctl_information(bdev, cmd, arg);
+	case BIODASDINFO2:
+		return dasd_ioctl_information(bdev, cmd, arg);
+	case BIODASDPRRD:
+		return dasd_ioctl_read_profile(bdev, cmd, arg);
+	case BIODASDPRRST:
+		return dasd_ioctl_reset_profile(bdev, cmd, arg);
+	case BLKROSET:
+		return dasd_ioctl_set_ro(bdev, cmd, arg);
+	case DASDAPIVER:
+		return dasd_ioctl_api_version(bdev, cmd, arg);
+	}
 
+	return -EINVAL;
 }
-
-EXPORT_SYMBOL(dasd_ioctl_no_register);
-EXPORT_SYMBOL(dasd_ioctl_no_unregister);
Index: linux-2.6.15-rc5/drivers/s390/block/dasd_cmb.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/s390/block/dasd_cmb.c	2005-12-12 18:31:37.000000000 +0100
+++ linux-2.6.15-rc5/drivers/s390/block/dasd_cmb.c	2005-12-16 15:26:49.000000000 +0100
@@ -78,52 +78,21 @@
 	return 0;
 }
 
-/* module initialization below here. dasd already provides a mechanism
- * to dynamically register ioctl functions, so we simply use this. */
-static inline int
-ioctl_reg(unsigned int no, dasd_ioctl_fn_t handler)
+int dasd_cmd_ioctl(struct block_device *bdev, unsigned int cmd,
+		unsigned long arg)
 {
-	return dasd_ioctl_no_register(THIS_MODULE, no, handler);
-}
-
-static inline void
-ioctl_unreg(unsigned int no, dasd_ioctl_fn_t handler)
-{
-	dasd_ioctl_no_unregister(THIS_MODULE, no, handler);
-}
-
-static void
-dasd_cmf_exit(void)
-{
-	ioctl_unreg(BIODASDCMFENABLE,  dasd_ioctl_cmf_enable);
-	ioctl_unreg(BIODASDCMFDISABLE, dasd_ioctl_cmf_disable);
-	ioctl_unreg(BIODASDREADALLCMB, dasd_ioctl_readall_cmb);
-}
-
-static int __init
-dasd_cmf_init(void)
-{
-	int ret;
-	ret = ioctl_reg (BIODASDCMFENABLE, dasd_ioctl_cmf_enable);
-	if (ret)
-		goto err;
-	ret = ioctl_reg (BIODASDCMFDISABLE, dasd_ioctl_cmf_disable);
-	if (ret)
-		goto err;
-	ret = ioctl_reg (BIODASDREADALLCMB, dasd_ioctl_readall_cmb);
-	if (ret)
-		goto err;
+	switch (cmd) {
+	case BIODASDCMFENABLE:
+		return dasd_ioctl_cmf_enable(bdev, cmd, arg);
+	case BIODASDCMFDISABLE:
+		return dasd_ioctl_cmf_disable(bdev, cmd, arg);
+	case BIODASDREADALLCMB:
+		return dasd_ioctl_readall_cmb(bdev, cmd, arg);
+	}
 
-	return 0;
-err:
-	dasd_cmf_exit();
-
-	return ret;
+	return -ENOIOCTLCMD;
 }
 
-module_init(dasd_cmf_init);
-module_exit(dasd_cmf_exit);
-
 MODULE_AUTHOR("Arnd Bergmann <arndb@de.ibm.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("channel measurement facility interface for dasd\n"

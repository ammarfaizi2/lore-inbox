Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbUKYHN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbUKYHN1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 02:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbUKYHN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 02:13:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28676 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262996AbUKYHLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 02:11:05 -0500
Date: Thu, 25 Nov 2004 00:10:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: axboe@suse.de, tim@cyberelk.net, mike.miller@hp.com,
       Andrew Morton <akpm@osdl.org>
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org,
       iss_storagedev@hp.com
Subject: [2.6 patch] drivers/block/: some cleanups
Message-ID: <20041124231055.GN19873@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the patch below removes some unused code from drivers/block/, makes 
some needlessly global code static and does some other small cleanups.

Please review and comment.


diffstat output:
 drivers/block/cciss.c        |   18 +++------
 drivers/block/cciss_scsi.c   |   35 ++---------------
 drivers/block/cciss_scsi.h   |    1 
 drivers/block/cpqarray.c     |   13 +-----
 drivers/block/elevator.c     |    4 +-
 drivers/block/floppy.c       |    4 +-
 drivers/block/genhd.c        |    2 -
 drivers/block/loop.c         |    4 +-
 drivers/block/nbd.c          |    6 +--
 drivers/block/noop-iosched.c |   12 +++---
 drivers/block/paride/setup.h |   70 -----------------------------------
 drivers/block/pktcdvd.c      |    4 +-
 drivers/block/ps2esdi.c      |   42 ---------------------
 drivers/block/rd.c           |    4 +-
 drivers/block/ub.c           |    2 -
 drivers/block/umem.c         |    4 +-
 drivers/block/xd.c           |    2 -
 drivers/block/paride/pcd.c   |   22 -----------
 drivers/block/paride/pd.c    |   23 -----------
 drivers/block/paride/pf.c    |   23 -----------
 drivers/block/paride/pg.c    |   21 ----------
 drivers/block/paride/pt.c    |   22 -----------
 22 files changed, 42 insertions(+), 296 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/block/cciss.c.old	2004-11-06 19:45:19.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/cciss.c	2004-11-06 20:23:11.000000000 +0100
@@ -61,7 +61,7 @@
 #include <linux/cciss_ioctl.h>
 
 /* define the PCI info for the cards we can control */
-const struct pci_device_id cciss_pci_device_id[] = {
+static const struct pci_device_id cciss_pci_device_id[] = {
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISS,
 			0x0E11, 0x4070, 0, 0, 0},
 	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_CISSB,
@@ -2908,21 +2908,17 @@
  *  This is it.  Register the PCI driver information for the cards we control
  *  the OS will call our registered routines when it finds one of our cards. 
  */
-int __init cciss_init(void)
+static int __init init_cciss(void)
 {
+	register_cciss_ioctl32();
+
 	printk(KERN_INFO DRIVER_NAME "\n");
 
 	/* Register for our PCI devices */
 	return pci_module_init(&cciss_pci_driver);
 }
 
-static int __init init_cciss_module(void)
-{
-	register_cciss_ioctl32();
-	return ( cciss_init());
-}
-
-static void __exit cleanup_cciss_module(void)
+static void __exit cleanup_cciss(void)
 {
 	int i;
 
@@ -2941,5 +2937,5 @@
 	remove_proc_entry("cciss", proc_root_driver);
 }
 
-module_init(init_cciss_module);
-module_exit(cleanup_cciss_module);
+module_init(init_cciss);
+module_exit(cleanup_cciss);
--- linux-2.6.10-rc1-mm3-full/drivers/block/cciss_scsi.h.old	2004-11-06 19:54:18.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/cciss_scsi.h	2004-11-06 19:54:41.000000000 +0100
@@ -39,7 +39,6 @@
 #define SCSI_CCISS_CAN_QUEUE 2
 
 /* 
-	info:           	cciss_scsi_info,		\
 
 Note, cmd_per_lun could give us some trouble, so I'm setting it very low.
 Likewise, SCSI_CCISS_CAN_QUEUE is set very conservatively.
--- linux-2.6.10-rc1-mm3-full/drivers/block/cciss_scsi.c.old	2004-11-06 19:48:45.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/cciss_scsi.c	2004-11-06 20:30:38.000000000 +0100
@@ -53,9 +53,7 @@
 	int cmd_type);
 
 
-const char *cciss_scsi_info(struct Scsi_Host *sa);
-
-int cciss_scsi_proc_info(
+static int cciss_scsi_proc_info(
 		struct Scsi_Host *sh,
 		char *buffer, /* data buffer */
 		char **start, 	   /* where data in buffer starts */
@@ -63,7 +61,7 @@
 		int length, 	   /* length of data in buffer */
 		int func);	   /* 0 == read, 1 == write */
 
-int cciss_scsi_queue_command (struct scsi_cmnd *cmd, 
+static int cciss_scsi_queue_command (struct scsi_cmnd *cmd, 
 		void (* done)(struct scsi_cmnd *));
 
 static struct cciss_scsi_hba_t ccissscsi[MAX_CTLR] = {
@@ -712,8 +710,6 @@
 	return 1;
 }
 
-static void __exit cleanup_cciss_module(void);
-
 static void
 cciss_unmap_one(struct pci_dev *pdev,
 		CommandList_struct *cp,
@@ -1114,7 +1110,7 @@
 }
 
 
-int
+static int
 cciss_scsi_proc_info(struct Scsi_Host *sh,
 		char *buffer, /* data buffer */
 		char **start, 	   /* where data in buffer starts */
@@ -1149,29 +1145,6 @@
 			buffer, length);	
 } 
 
-/* this is via the generic proc support */
-const char *
-cciss_scsi_info(struct Scsi_Host *sa)
-{
-	static char buf[300];
-	ctlr_info_t *ci;
-
-	/* probably need to work on putting a bit more info in here... */
-	/* this is output via the /proc filesystem. */
-
-	ci = (ctlr_info_t *) sa->hostdata[0];
-
-	sprintf(buf, "%s %c%c%c%c\n",
-		ci->product_name, 
-		ci->firm_ver[0],
-		ci->firm_ver[1],
-		ci->firm_ver[2],
-		ci->firm_ver[3]);
-
-	return buf; 
-}
-
-
 /* cciss_scatter_gather takes a struct scsi_cmnd, (cmd), and does the pci 
    dma mapping  and fills in the scatter gather entries of the 
    cciss command, cp. */
@@ -1225,7 +1198,7 @@
 }
 
 
-int 
+static int 
 cciss_scsi_queue_command (struct scsi_cmnd *cmd, void (* done)(struct scsi_cmnd *))
 {
 	ctlr_info_t **c;
--- linux-2.6.10-rc1-mm3-full/drivers/block/cpqarray.c.old	2004-11-06 19:51:42.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/cpqarray.c	2004-11-06 19:53:16.000000000 +0100
@@ -97,7 +97,7 @@
 };
 
 /* define the PCI info for the PCI cards this driver can control */
-const struct pci_device_id cpqarray_pci_device_id[] =
+static const struct pci_device_id cpqarray_pci_device_id[] =
 {
 	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_COMPAQ_42XX,
 		0x0E11, 0x4058, 0, 0, 0},       /* SA431 */
@@ -135,7 +135,6 @@
 /* Debug Extra Paranoid... */
 #define DBGPX(s) do { } while(0)
 
-int cpqarray_init_step2(void);
 static int cpqarray_pci_init(ctlr_info_t *c, struct pci_dev *pdev);
 static void __iomem *remap_pci_mem(ulong base, ulong size);
 static int cpqarray_eisa_detect(void);
@@ -312,14 +311,6 @@
 
 module_param_array(eisa, int, NULL, 0);
 
-/* This is a bit of a hack,
- * necessary to support both eisa and pci
- */
-int __init cpqarray_init(void)
-{
-	return (cpqarray_init_step2());
-}
-
 static void release_io_mem(ctlr_info_t *c)
 {
 	/* if IO mem was not protected do nothing */
@@ -560,7 +551,7 @@
  *  This is it.  Find all the controllers and register them.
  *  returns the number of block devices registered.
  */
-int __init cpqarray_init_step2(void)
+static int __init cpqarray_init(void)
 {
 	int num_cntlrs_reg = 0;
 	int i;
--- linux-2.6.10-rc1-mm3-full/drivers/block/elevator.c.old	2004-11-06 19:55:01.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/elevator.c	2004-11-06 19:55:34.000000000 +0100
@@ -92,7 +92,7 @@
 }
 EXPORT_SYMBOL(elv_try_last_merge);
 
-struct elevator_type *elevator_find(const char *name)
+static struct elevator_type *elevator_find(const char *name)
 {
 	struct elevator_type *e = NULL;
 	struct list_head *entry;
@@ -222,7 +222,7 @@
 	kfree(e);
 }
 
-int elevator_global_init(void)
+static int elevator_global_init(void)
 {
 	return 0;
 }
--- linux-2.6.10-rc1-mm3-full/drivers/block/floppy.c.old	2004-11-06 19:55:49.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/floppy.c	2004-11-06 20:06:29.000000000 +0100
@@ -4397,7 +4397,7 @@
 }
 #endif
 
-int __init floppy_init(void)
+static int __init floppy_init(void)
 {
 	int i, unit, drive;
 	int err, dr;
@@ -4738,7 +4738,7 @@
 
 #ifdef MODULE
 
-char *floppy;
+static char *floppy;
 
 static void unregister_devfs_entries(int drive)
 {
--- linux-2.6.10-rc1-mm3-full/drivers/block/genhd.c.old	2004-11-06 20:07:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/genhd.c	2004-11-06 20:07:13.000000000 +0100
@@ -305,7 +305,7 @@
 	return NULL;
 }
 
-int __init device_init(void)
+static int __init device_init(void)
 {
 	bdev_map = kobj_map_init(base_probe, &block_subsys);
 	blk_dev_init();
--- linux-2.6.10-rc1-mm3-full/drivers/block/loop.c.old	2004-11-06 20:09:10.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/loop.c	2004-11-06 20:09:31.000000000 +0100
@@ -1114,7 +1114,7 @@
 EXPORT_SYMBOL(loop_register_transfer);
 EXPORT_SYMBOL(loop_unregister_transfer);
 
-int __init loop_init(void)
+static int __init loop_init(void)
 {
 	int	i;
 
@@ -1189,7 +1189,7 @@
 	return -ENOMEM;
 }
 
-void loop_exit(void)
+static void loop_exit(void)
 {
 	int i;
 
--- linux-2.6.10-rc1-mm3-full/drivers/block/nbd.c.old	2004-11-06 20:09:39.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/nbd.c	2004-11-06 20:10:16.000000000 +0100
@@ -315,7 +315,7 @@
 }
 
 /* NULL returned = something went wrong, inform userspace */
-struct request *nbd_read_stat(struct nbd_device *lo)
+static struct request *nbd_read_stat(struct nbd_device *lo)
 {
 	int result;
 	struct nbd_reply reply;
@@ -377,7 +377,7 @@
 	return NULL;
 }
 
-void nbd_do_it(struct nbd_device *lo)
+static void nbd_do_it(struct nbd_device *lo)
 {
 	struct request *req;
 
@@ -388,7 +388,7 @@
 	return;
 }
 
-void nbd_clear_que(struct nbd_device *lo)
+static void nbd_clear_que(struct nbd_device *lo)
 {
 	struct request *req;
 
--- linux-2.6.10-rc1-mm3-full/drivers/block/noop-iosched.c.old	2004-11-06 20:10:24.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/noop-iosched.c	2004-11-06 20:11:23.000000000 +0100
@@ -17,7 +17,7 @@
 /*
  * See if we can find a request that this buffer can be coalesced with.
  */
-int elevator_noop_merge(request_queue_t *q, struct request **req,
+static int elevator_noop_merge(request_queue_t *q, struct request **req,
 			struct bio *bio)
 {
 	struct list_head *entry = &q->queue_head;
@@ -50,13 +50,13 @@
 	return ELEVATOR_NO_MERGE;
 }
 
-void elevator_noop_merge_requests(request_queue_t *q, struct request *req,
+static void elevator_noop_merge_requests(request_queue_t *q, struct request *req,
 				  struct request *next)
 {
 	list_del_init(&next->queuelist);
 }
 
-void elevator_noop_add_request(request_queue_t *q, struct request *rq,
+static void elevator_noop_add_request(request_queue_t *q, struct request *rq,
 			       int where)
 {
 	struct list_head *insert = q->queue_head.prev;
@@ -75,7 +75,7 @@
 		q->last_merge = rq;
 }
 
-struct request *elevator_noop_next_request(request_queue_t *q)
+static struct request *elevator_noop_next_request(request_queue_t *q)
 {
 	if (!list_empty(&q->queue_head))
 		return list_entry_rq(q->queue_head.next);
@@ -94,12 +94,12 @@
 	.elevator_owner = THIS_MODULE,
 };
 
-int noop_init(void)
+static int noop_init(void)
 {
 	return elv_register(&elevator_noop);
 }
 
-void noop_exit(void)
+static void noop_exit(void)
 {
 	elv_unregister(&elevator_noop);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/block/pktcdvd.c.old	2004-11-06 20:16:55.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/pktcdvd.c	2004-11-06 20:17:22.000000000 +0100
@@ -2627,7 +2627,7 @@
 	.fops  		= &pkt_ctl_fops
 };
 
-int pkt_init(void)
+static int pkt_init(void)
 {
 	int ret;
 
@@ -2663,7 +2663,7 @@
 	return ret;
 }
 
-void pkt_exit(void)
+static void pkt_exit(void)
 {
 	remove_proc_entry("pktcdvd", proc_root_driver);
 	misc_deregister(&pkt_misc);
--- linux-2.6.10-rc1-mm3-full/drivers/block/ps2esdi.c.old	2004-11-06 20:17:34.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/ps2esdi.c	2004-11-06 20:18:33.000000000 +0100
@@ -221,48 +221,6 @@
 }
 #endif /* MODULE */
 
-/* handles boot time command line parameters */
-void __init tp720_setup(char *str, int *ints)
-{
-	/* no params, just sets the tp720esdi flag if it exists */
-
-	printk("%s: TP 720 ESDI flag set\n", DEVICE_NAME);
-	tp720esdi = 1;
-}
-
-void __init ed_setup(char *str, int *ints)
-{
-	int hdind = 0;
-
-	/* handles 3 parameters only - corresponding to
-	   1. Number of cylinders
-	   2. Number of heads
-	   3. Sectors/track
-	 */
-
-	if (ints[0] != 3)
-		return;
-
-	/* print out the information - seen at boot time */
-	printk("%s: ints[0]=%d ints[1]=%d ints[2]=%d ints[3]=%d\n",
-	       DEVICE_NAME, ints[0], ints[1], ints[2], ints[3]);
-
-	/* set the index into device specific information table */
-	if (ps2esdi_info[0].head != 0)
-		hdind = 1;
-
-	/* set up all the device information */
-	ps2esdi_info[hdind].head = ints[2];
-	ps2esdi_info[hdind].sect = ints[3];
-	ps2esdi_info[hdind].cyl = ints[1];
-	ps2esdi_info[hdind].wpcom = 0;
-	ps2esdi_info[hdind].lzone = ints[1];
-	ps2esdi_info[hdind].ctl = (ints[2] > 8 ? 8 : 0);
-#if 0				/* this may be needed for PS2/Mod.80, but it hurts ThinkPad! */
-	ps2esdi_drives = hdind + 1;	/* increment index for the next time */
-#endif
-}				/* ed_setup */
-
 static int ps2esdi_getinfo(char *buf, int slot, void *d)
 {
 	int len = 0;
--- linux-2.6.10-rc1-mm3-full/drivers/block/rd.c.old	2004-11-06 20:18:40.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/rd.c	2004-11-06 20:19:25.000000000 +0100
@@ -77,7 +77,7 @@
  * architecture-specific setup routine (from the stored boot sector
  * information).
  */
-int rd_size = CONFIG_BLK_DEV_RAM_SIZE;		/* Size of the RAM disks */
+static int rd_size = CONFIG_BLK_DEV_RAM_SIZE;	/* Size of the RAM disks */
 /*
  * It would be very desirable to have a soft-blocksize (that in the case
  * of the ramdisk driver is also the hardblocksize ;) of PAGE_SIZE because
@@ -89,7 +89,7 @@
  * behaviour. The default is still BLOCK_SIZE (needed by rd_load_image that
  * supposes the filesystem in the image uses a BLOCK_SIZE blocksize).
  */
-int rd_blocksize = BLOCK_SIZE;			/* blocksize of the RAM disks */
+static int rd_blocksize = BLOCK_SIZE;		/* blocksize of the RAM disks */
 
 /*
  * Copyright (C) 2000 Linus Torvalds.
--- linux-2.6.10-rc1-mm3-full/drivers/block/ub.c.old	2004-11-06 20:19:32.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/ub.c	2004-11-06 20:19:45.000000000 +0100
@@ -2097,7 +2097,7 @@
 	spin_unlock_irqrestore(&ub_lock, flags);
 }
 
-struct usb_driver ub_driver = {
+static struct usb_driver ub_driver = {
 	.owner =	THIS_MODULE,
 	.name =		"ub",
 	.probe =	ub_probe,
--- linux-2.6.10-rc1-mm3-full/drivers/block/umem.c.old	2004-11-06 20:19:51.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/umem.c	2004-11-06 20:20:16.000000000 +0100
@@ -1181,7 +1181,7 @@
 -----------------------------------------------------------------------------------
 */
 
-int __init mm_init(void)
+static int __init mm_init(void)
 {
 	int retval, i;
 	int err;
@@ -1232,7 +1232,7 @@
 --                             mm_cleanup
 -----------------------------------------------------------------------------------
 */
-void __exit mm_cleanup(void)
+static void __exit mm_cleanup(void)
 {
 	int i;
 
--- linux-2.6.10-rc1-mm3-full/drivers/block/xd.c.old	2004-11-06 20:20:25.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/xd.c	2004-11-06 20:21:01.000000000 +0100
@@ -67,7 +67,7 @@
 /* Above may need to be increased if a problem with the 2nd drive detection
    (ST11M controller) or resetting a controller (WD) appears */
 
-XD_INFO xd_info[XD_MAXDRIVES];
+static XD_INFO xd_info[XD_MAXDRIVES];
 
 /* If you try this driver and find that your card is not detected by the driver at bootup, you need to add your BIOS
    signature and details to the following list of signatures. A BIOS signature is a string embedded into the first
--- linux-2.6.10-rc1-mm3-full/drivers/block/paride/setup.h	2004-10-18 23:55:27.000000000 +0200
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,69 +0,0 @@
-/*
-	setup.h	   (c) 1997-8   Grant R. Guenther <grant@torque.net>
-		                Under the terms of the GNU General Public License.
-
-        This is a table driven setup function for kernel modules
-        using the module.variable=val,... command line notation.
-
-*/
-
-/* Changes:
-
-	1.01	GRG 1998.05.05	Allow negative and defaulted values
-
-*/
-
-#include <linux/ctype.h>
-#include <linux/string.h>
-
-struct setup_tab_t {
-
-	char	*tag;	/* variable name */
-	int	size;	/* number of elements in array */
-	int	*iv;	/* pointer to variable */
-};
-
-typedef struct setup_tab_t STT;
-
-/*  t 	  is a table that describes the variables that can be set
-	  by gen_setup
-    n	  is the number of entries in the table
-    ss	  is a string of the form:
-
-		<tag>=[<val>,...]<val>
-*/
-
-static void generic_setup( STT t[], int n, char *ss )
-
-{	int	j,k, sgn;
-
-	k = 0;
-	for (j=0;j<n;j++) {
-		k = strlen(t[j].tag);
-		if (strncmp(ss,t[j].tag,k) == 0) break;
-	}
-	if (j == n) return;
-
-	if (ss[k] == 0) {
-		t[j].iv[0] = 1;
-		return;
-	}
-
-	if (ss[k] != '=') return;
-	ss += (k+1);
-
-	k = 0;
-	while (ss && (k < t[j].size)) {
-		if (!*ss) break;
-		sgn = 1;
-		if (*ss == '-') { ss++; sgn = -1; }
-		if (!*ss) break;
-		if (isdigit(*ss))
-		  t[j].iv[k] = sgn * simple_strtoul(ss,NULL,0);
-		k++; 
-		if ((ss = strchr(ss,',')) != NULL) ss++;
-	}
-}
-
-/* end of setup.h */
-


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--- linux-2.6.10-rc2-mm3-full/drivers/block/paride/pcd.c.old	2004-11-24 23:45:49.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/block/paride/pcd.c	2004-11-24 23:46:42.000000000 +0100
@@ -142,26 +142,6 @@
 
 static spinlock_t pcd_lock;
 
-#ifndef MODULE
-
-#include "setup.h"
-
-static STT pcd_stt[6] = {
-	{"drive0", 6, drive0},
-	{"drive1", 6, drive1},
-	{"drive2", 6, drive2},
-	{"drive3", 6, drive3},
-	{"disable", 1, &disable},
-	{"nice", 1, &nice}
-};
-
-void pcd_setup(char *str, int *ints)
-{
-	generic_setup(pcd_stt, 6, str);
-}
-
-#endif
-
 MODULE_PARM(verbose, "i");
 MODULE_PARM(major, "i");
 MODULE_PARM(name, "s");
@@ -218,7 +198,7 @@
 	struct gendisk *disk;
 };
 
-struct pcd_unit pcd[PCD_UNITS];
+static struct pcd_unit pcd[PCD_UNITS];
 
 static char pcd_scratch[64];
 static char pcd_buffer[2048];	/* raw block buffer */
--- linux-2.6.10-rc2-mm3-full/drivers/block/paride/pd.c.old	2004-11-24 23:46:42.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/block/paride/pd.c	2004-11-24 23:46:55.000000000 +0100
@@ -157,27 +157,6 @@
 
 static spinlock_t pd_lock = SPIN_LOCK_UNLOCKED;
 
-#ifndef MODULE
-
-#include "setup.h"
-
-static STT pd_stt[7] = {
-	{"drive0", 8, drive0},
-	{"drive1", 8, drive1},
-	{"drive2", 8, drive2},
-	{"drive3", 8, drive3},
-	{"disable", 1, &disable},
-	{"cluster", 1, &cluster},
-	{"nice", 1, &nice}
-};
-
-void pd_setup(char *str, int *ints)
-{
-	generic_setup(pd_stt, 7, str);
-}
-
-#endif
-
 MODULE_PARM(verbose, "i");
 MODULE_PARM(major, "i");
 MODULE_PARM(name, "s");
@@ -255,7 +234,7 @@
 	struct gendisk *gd;
 };
 
-struct pd_unit pd[PD_UNITS];
+static struct pd_unit pd[PD_UNITS];
 
 static char pd_scratch[512];	/* scratch block buffer */
 
--- linux-2.6.10-rc2-mm3-full/drivers/block/paride/pf.c.old	2004-11-24 23:46:55.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/block/paride/pf.c	2004-11-24 23:47:06.000000000 +0100
@@ -156,27 +156,6 @@
 
 static spinlock_t pf_spin_lock;
 
-#ifndef MODULE
-
-#include "setup.h"
-
-static STT pf_stt[7] = {
-	{"drive0", 7, drive0},
-	{"drive1", 7, drive1},
-	{"drive2", 7, drive2},
-	{"drive3", 7, drive3},
-	{"disable", 1, &disable},
-	{"cluster", 1, &cluster},
-	{"nice", 1, &nice}
-};
-
-void pf_setup(char *str, int *ints)
-{
-	generic_setup(pf_stt, 7, str);
-}
-
-#endif
-
 MODULE_PARM(verbose, "i");
 MODULE_PARM(major, "i");
 MODULE_PARM(name, "s");
@@ -256,7 +235,7 @@
 	struct gendisk *disk;
 };
 
-struct pf_unit units[PF_UNITS];
+static struct pf_unit units[PF_UNITS];
 
 static int pf_identify(struct pf_unit *pf);
 static void pf_lock(struct pf_unit *pf, int func);
--- linux-2.6.10-rc2-mm3-full/drivers/block/paride/pg.c.old	2004-11-24 23:47:06.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/block/paride/pg.c	2004-11-24 23:47:19.000000000 +0100
@@ -165,25 +165,6 @@
 
 #include <asm/uaccess.h>
 
-#ifndef MODULE
-
-#include "setup.h"
-
-static STT pg_stt[5] = {
-	{"drive0", 6, drive0},
-	{"drive1", 6, drive1},
-	{"drive2", 6, drive2},
-	{"drive3", 6, drive3},
-	{"disable", 1, &disable}
-};
-
-void pg_setup(char *str, int *ints)
-{
-	generic_setup(pg_stt, 5, str);
-}
-
-#endif
-
 MODULE_PARM(verbose, "i");
 MODULE_PARM(major, "i");
 MODULE_PARM(name, "s");
@@ -235,7 +216,7 @@
 	char name[PG_NAMELEN];	/* pg0, pg1, ... */
 };
 
-struct pg devices[PG_UNITS];
+static struct pg devices[PG_UNITS];
 
 static int pg_identify(struct pg *dev, int log);
 
--- linux-2.6.10-rc2-mm3-full/drivers/block/paride/pt.c.old	2004-11-24 23:47:19.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/block/paride/pt.c	2004-11-24 23:47:30.000000000 +0100
@@ -149,26 +149,6 @@
 
 #include <asm/uaccess.h>
 
-#ifndef MODULE
-
-#include "setup.h"
-
-static STT pt_stt[5] = {
-	{"drive0", 6, drive0},
-	{"drive1", 6, drive1},
-	{"drive2", 6, drive2},
-	{"drive3", 6, drive3},
-	{"disable", 1, &disable}
-};
-
-void
-pt_setup(char *str, int *ints)
-{
-	generic_setup(pt_stt, 5, str);
-}
-
-#endif
-
 MODULE_PARM(verbose, "i");
 MODULE_PARM(major, "i");
 MODULE_PARM(name, "s");
@@ -246,7 +226,7 @@
 
 static int pt_identify(struct pt_unit *tape);
 
-struct pt_unit pt[PT_UNITS];
+static struct pt_unit pt[PT_UNITS];
 
 static char pt_scratch[512];	/* scratch block buffer */
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318783AbSHNOzf>; Wed, 14 Aug 2002 10:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318859AbSHNOzf>; Wed, 14 Aug 2002 10:55:35 -0400
Received: from inmail.compaq.com ([161.114.64.101]:26128 "EHLO
	zmamail01.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S318783AbSHNOzd>; Wed, 14 Aug 2002 10:55:33 -0400
Date: Wed, 14 Aug 2002 09:56:51 -0500
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.31, fix cciss driver to use gendisk per disk
Message-ID: <20020814095651.A893@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the cciss driver to accomodate the 
changes made in 2.5.30 which now require a gendisk per
disk.  Patch applies to 2.5.31.

-- steve

diff -urN linux-2.5.31/drivers/block/cciss.c linux-2.5.31-cciss/drivers/block/cciss.c
--- linux-2.5.31/drivers/block/cciss.c	Mon Aug 12 09:34:32 2002
+++ linux-2.5.31-cciss/drivers/block/cciss.c	Wed Aug 14 09:43:46 2002
@@ -46,12 +46,12 @@
 #include <linux/completion.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "Compaq CISS Driver (v 2.5.0)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,5,0)
+#define DRIVER_NAME "Compaq CISS Driver (v 2.5.1)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,5,1)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Charles M. White III - Compaq Computer Corporation");
-MODULE_DESCRIPTION("Driver for Compaq Smart Array Controller 5xxx v. 2.5.0");
+MODULE_DESCRIPTION("Driver for Compaq Smart Array Controller 5xxx v. 2.5.1");
 MODULE_LICENSE("GPL");
 
 #include "cciss_cmd.h"
@@ -336,23 +336,16 @@
 /*  
  * fills in the disk information. 
  */
-static void cciss_geninit( int ctlr)
+static void cciss_geninit( int ctlr, int disk)
 {
 	drive_info_struct *drv;
-	int i;
-	
-	/* Loop through each real device */ 
-	hba[ctlr]->gendisk.nr_real = 0; 
-	for(i=0; i< NWD; i++)
-	{
-		drv = &(hba[ctlr]->drv[i]);
-		if( !(drv->nr_blocks))
-			continue;
-		hba[ctlr]->hd[i << NWD_SHIFT].nr_sects = drv->nr_blocks;
-		//hba[ctlr]->gendisk.nr_real++;
-		(BLK_DEFAULT_QUEUE(MAJOR_NR + ctlr))->hardsect_size = drv->block_size;
-	}
-	hba[ctlr]->gendisk.nr_real = hba[ctlr]->highest_lun+1;
+
+	drv = &(hba[ctlr]->drv[disk]);
+	if( !(drv->nr_blocks))
+		return;
+	hba[ctlr]->hd[disk << NWD_SHIFT].nr_sects = drv->nr_blocks;
+	hba[ctlr]->gendisk[disk].nr_real = 1;
+	(BLK_DEFAULT_QUEUE(MAJOR_NR + ctlr))->hardsect_size = drv->block_size;
 }
 /*
  * Open.  Make sure the device is really there.
@@ -374,10 +367,10 @@
 	 * but I'm already using way to many device nodes to claim another one
 	 * for "raw controller".
 	 */
-	if (inode->i_bdev->bd_inode->i_size == 0) {
+	if (hba[ctlr]->gendisk[dsk].part[PART(inode->i_rdev)].nr_sects == 0) {
 		if (minor(inode->i_rdev) != 0)
 			return -ENXIO;
-		if (!capable(CAP_SYS_ADMIN))
+		if (!capable(CAP_SYS_ADMIN)) 
 			return -EPERM;
 	}
 	hba[ctlr]->drv[dsk].usage_count++;
@@ -726,8 +719,8 @@
 {
         int ctlr = major(dev) - MAJOR_NR;
 	int target = minor(dev) >> NWD_SHIFT;
-        struct gendisk *gdev = &(hba[ctlr]->gendisk);
-	gdev->part[minor(dev)].nr_sects = hba[ctlr]->drv[target].nr_blocks;
+	struct gendisk *gdev = &(hba[ctlr]->gendisk[target]);
+	gdev->part[PART(dev)].nr_sects = hba[ctlr]->drv[target].nr_blocks;
 	return 0;
 }
 
@@ -745,7 +738,7 @@
 
         target = minor(dev) >> NWD_SHIFT;
         ctlr = major(dev) - MAJOR_NR;
-        gdev = &(hba[ctlr]->gendisk);
+	gdev = &(hba[ctlr]->gendisk[target]);
 
         spin_lock_irqsave(CCISS_LOCK(ctlr), flags);
         if (hba[ctlr]->drv[target].usage_count > maxusage) {
@@ -806,7 +799,8 @@
 	memset(hba[ctlr]->hd,         0, sizeof(struct hd_struct) * 256);
         memset(hba[ctlr]->drv,        0, sizeof(drive_info_struct)
 						* CISS_MAX_LUN);
-        hba[ctlr]->gendisk.nr_real = 0;
+	for (i=0;i<CISS_MAX_LUN;i++)
+		hba[ctlr]->gendisk[i].nr_real = 0;
 
         /*
          * Tell the array controller not to give us any interrupts while
@@ -817,10 +811,10 @@
         cciss_getgeometry(ctlr);
         hba[ctlr]->access.set_intr_mask(hba[ctlr], CCISS_INTR_ON);
 
-        cciss_geninit(ctlr);
-        for(i=0; i<NWD; i++) {
+	for(i=0; i<CISS_MAX_LUN; i++) {
 		kdev_t kdev = mk_kdev(major(dev), i << NWD_SHIFT);
-                if (hba[ctlr]->gendisk.part[ i<<NWD_SHIFT ].nr_sects)
+		cciss_geninit(ctlr, i);
+		if (hba[ctlr]->gendisk[i].part[0].nr_sects)
                         revalidate_logvol(kdev, 2);
 	}
 
@@ -831,7 +825,7 @@
 static int deregister_disk(int ctlr, int logvol)
 {
 	unsigned long flags;
-	struct gendisk *gdev = &(hba[ctlr]->gendisk);
+	struct gendisk *gdev = &(hba[ctlr]->gendisk[logvol]);
 	ctlr_info_t  *h = hba[ctlr];
 	int start, max_p;
 
@@ -858,10 +852,9 @@
 	{
 		/* if so, find the new hightest lun */
 		int i, newhighest =-1;
-		for(i=0; i<h->highest_lun; i++)
-		{
+		for(i=0; i<h->highest_lun; i++) {
 			/* if the disk has size > 0, it is available */
-			if (h->gendisk.part[i << gdev->minor_shift].nr_sects)
+			if (h->gendisk[i].part[0].nr_sects)
 				newhighest = i;
 		}
 		h->highest_lun = newhighest;
@@ -1067,7 +1060,7 @@
 }
 static int register_new_disk(kdev_t dev, int ctlr)
 {
-        struct gendisk *gdev = &(hba[ctlr]->gendisk);
+        struct gendisk *gdev;
         ctlr_info_t  *h = hba[ctlr];
         int start, max_p, i;
 	int num_luns;
@@ -1208,6 +1201,7 @@
          }
 
 	logvol = free_index;
+        gdev = &hba[ctlr]->gendisk[logvol];
 	hba[ctlr]->drv[logvol].LunID = lunid;
 		/* there could be gaps in lun numbers, track hightest */
 	if(hba[ctlr]->highest_lun < lunid)
@@ -1298,7 +1292,7 @@
 
 	wipe_partitions(kdev);
 	++hba[ctlr]->num_luns;
-	gdev->nr_real = hba[ctlr]->highest_lun + 1;
+	cciss_geninit(ctlr, logvol);
 	/* setup partitions per disk */
 	grok_partitions(kdev, hba[ctlr]->drv[logvol].nr_blocks);
 	
@@ -2488,22 +2482,24 @@
 
 	blk_queue_max_sectors(q, 512);
 
-	/* Fill in the gendisk data */ 	
-	hba[i]->gendisk.major = MAJOR_NR + i;
-	hba[i]->gendisk.major_name = "cciss";
-	hba[i]->gendisk.minor_shift = NWD_SHIFT;
-	hba[i]->gendisk.part = hba[i]->hd;
-	hba[i]->gendisk.nr_real = hba[i]->highest_lun+1;  
-
-	/* Get on the disk list */ 
-	add_gendisk(&(hba[i]->gendisk));
-
-	cciss_geninit(i);
-	for(j=0; j<NWD; j++)
-		register_disk(&(hba[i]->gendisk),
+
+	for(j=0; j<CISS_MAX_LUN; j++) {
+		/* Fill in the gendisk data */ 	
+		hba[i]->gendisk[j].major = MAJOR_NR + i;
+		hba[i]->gendisk[j].major_name = "cciss";
+		hba[i]->gendisk[j].minor_shift = NWD_SHIFT;
+		hba[i]->gendisk[j].part = &hba[i]->hd[j<<NWD_SHIFT];
+		hba[i]->gendisk[j].nr_real = (j <= hba[i]->highest_lun);  
+		hba[i]->gendisk[j].first_minor = j<<NWD_SHIFT;
+
+		/* Get on the disk list */ 
+		add_gendisk(&(hba[i]->gendisk[j]));
+		cciss_geninit(i, j);
+		register_disk(&(hba[i]->gendisk[j]),
 			mk_kdev(MAJOR_NR+i, j <<4), 
 			MAX_PART, &cciss_fops, 
 			hba[i]->drv[j].nr_blocks);
+	}
 
 	cciss_register_scsi(i, 1);  /* hook ourself into SCSI subsystem */
 
@@ -2513,7 +2509,7 @@
 static void __devexit cciss_remove_one (struct pci_dev *pdev)
 {
 	ctlr_info_t *tmp_ptr;
-	int i;
+	int i, j;
 	char flush_buf[4];
 	int return_code; 
 
@@ -2548,7 +2544,8 @@
 	remove_proc_entry(hba[i]->devname, proc_cciss);	
 	
 	/* remove it from the disk list */
-	del_gendisk(&(hba[i]->gendisk));
+	for (j=0;j<CISS_MAX_LUN;j++)
+		del_gendisk(&(hba[i]->gendisk[j]));
 
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof(CommandList_struct),
 			    hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);
diff -urN linux-2.5.31/drivers/block/cciss.h linux-2.5.31-cciss/drivers/block/cciss.h
--- linux-2.5.31/drivers/block/cciss.h	Wed Jul 24 16:03:17 2002
+++ linux-2.5.31-cciss/drivers/block/cciss.h	Wed Aug 14 09:25:38 2002
@@ -5,10 +5,11 @@
 
 #include "cciss_cmd.h"
 
-
 #define NWD		16
 #define NWD_SHIFT	4
 #define MAX_PART	(1 << NWD_SHIFT)
+#define CISS_PARTITION_MASK  (MAX_PART-1)
+#define PART(x)		(minor(x) & CISS_PARTITION_MASK)
 
 #define IO_OK		0
 #define IO_ERROR	1
@@ -81,7 +82,7 @@
 	int			nr_frees; 
 
 	// Disk structures we need to pass back
-	struct gendisk   gendisk;
+	struct gendisk   gendisk[CISS_MAX_LUN];
 	   // indexed by minor numbers
 	struct hd_struct hd[256];
 	int		 sizes[256];

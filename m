Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271577AbRICSGU>; Mon, 3 Sep 2001 14:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271638AbRICSGD>; Mon, 3 Sep 2001 14:06:03 -0400
Received: from ns.caldera.de ([212.34.180.1]:55720 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S271577AbRICSFu>;
	Mon, 3 Sep 2001 14:05:50 -0400
Date: Mon, 3 Sep 2001 20:05:04 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: aeb@cwi.nl, linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup gendisk handling
Message-ID: <20010903200504.A30093@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>, aeb@cwi.nl,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

as you probably know the gendisk handling in the current kernel is a
horrible mess.  All driver have to do the linked list handling themselves,
etc..

Andries has a patchset on kernel.org that addresses most of this issues -
but it does very large API changes and is thus not acceptable for 2.4.

The appended patch tries to cleanup the gendisk handling for the in-kernel
driver a LOT, keeping all old APIs for posssible out-of-tree drivers.

The whole cleanup basically consist of providing (and using, of course)
three functions in drivers/block/genhd.c:

  * add_gendisk(struct gendisk *gp)

     Add gendisk to global list

  * del_gendisk(struct gendisk *gp)

     Remove gnedisk from global list

  * get_gendisk(kdev_t)

     Get gendisk for given dev_t (linear search!)

All drivers have been converted to use these functions instead of doing
the list handling themselves, additionally gendisk_head and get_partiton_list
have been moved from fs/partitions/check.c to drivers/block/genhd.c.

Basically gendisk_head ist static now, although that is a too big API
change for 2.4, IMHO.

Please apply,

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/acorn/block/mfmhd.c linux/drivers/acorn/block/mfmhd.c
--- ../master/linux-2.4.10-pre4/drivers/acorn/block/mfmhd.c	Thu Aug 30 10:35:24 2001
+++ linux/drivers/acorn/block/mfmhd.c	Mon Sep  3 18:29:07 2001
@@ -1450,10 +1450,7 @@
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB?) read ahread */
 
-#ifndef MODULE
-	mfm_gendisk.next = gendisk_head;
-	gendisk_head = &mfm_gendisk;
-#endif
+	add_gendisk(&mfm_gendisk);
 
 	Busy = 0;
 	lastspecifieddrive = -1;
@@ -1512,6 +1509,7 @@
 		outw (0, mfm_irqenable);	/* Required to enable IRQs from MFM podule */
 	free_irq(mfm_irq, NULL);
 	unregister_blkdev(MAJOR_NR, "mfm");
+	del_gendisk(&mfm_gendisk);
 	if (ecs)
 		ecard_release(ecs);
 	if (mfm_addr)
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/block/DAC960.c linux/drivers/block/DAC960.c
--- ../master/linux-2.4.10-pre4/drivers/block/DAC960.c	Mon Sep  3 17:32:39 2001
+++ linux/drivers/block/DAC960.c	Mon Sep  3 18:02:50 2001
@@ -1938,13 +1938,7 @@
   /*
     Install the Generic Disk Information structure at the end of the list.
   */
-  if ((GenericDiskInfo = gendisk_head) != NULL)
-    {
-      while (GenericDiskInfo->next != NULL)
-	GenericDiskInfo = GenericDiskInfo->next;
-      GenericDiskInfo->next = &Controller->GenericDiskInfo;
-    }
-  else gendisk_head = &Controller->GenericDiskInfo;
+  add_gendisk(&Controller->GenericDiskInfo);
   /*
     Indicate the Block Device Registration completed successfully,
   */
@@ -1980,16 +1974,7 @@
   /*
     Remove the Generic Disk Information structure from the list.
   */
-  if (gendisk_head != &Controller->GenericDiskInfo)
-    {
-      GenericDiskInfo_T *GenericDiskInfo = gendisk_head;
-      while (GenericDiskInfo != NULL &&
-	     GenericDiskInfo->next != &Controller->GenericDiskInfo)
-	GenericDiskInfo = GenericDiskInfo->next;
-      if (GenericDiskInfo != NULL)
-	GenericDiskInfo->next = GenericDiskInfo->next->next;
-    }
-  else gendisk_head = Controller->GenericDiskInfo.next;
+  del_gendisk(&Controller->GenericDiskInfo);
 }
 
 
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/block/acsi.c linux/drivers/block/acsi.c
--- ../master/linux-2.4.10-pre4/drivers/block/acsi.c	Thu Aug 30 10:35:24 2001
+++ linux/drivers/block/acsi.c	Mon Sep  3 17:53:09 2001
@@ -1792,8 +1792,7 @@
 	
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	read_ahead[MAJOR_NR] = 8;		/* 8 sector (4kB) read-ahead */
-	acsi_gendisk.next = gendisk_head;
-	gendisk_head = &acsi_gendisk;
+	add_gendisk(&acsi_gendisk);
 
 #ifdef CONFIG_ATARI_SLM
 	err = slm_init();
@@ -1817,8 +1816,6 @@
 
 void cleanup_module(void)
 {
-	struct gendisk ** gdp;
-
 	del_timer( &acsi_timer );
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 	atari_stram_free( acsi_buffer );
@@ -1826,13 +1823,7 @@
 	if (devfs_unregister_blkdev( MAJOR_NR, "ad" ) != 0)
 		printk( KERN_ERR "acsi: cleanup_module failed\n");
 
-	for (gdp = &gendisk_head; *gdp; gdp = &((*gdp)->next))
-		if (*gdp == &acsi_gendisk)
-			break;
-	if (!*gdp)
-		printk( KERN_ERR "acsi: entry in disk chain missing!\n" );
-	else
-		*gdp = (*gdp)->next;
+	del_gendisk(&acsi_gendisk);
 }
 #endif
 
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/block/blkpg.c linux/drivers/block/blkpg.c
--- ../master/linux-2.4.10-pre4/drivers/block/blkpg.c	Mon Sep  3 17:32:39 2001
+++ linux/drivers/block/blkpg.c	Mon Sep  3 17:49:30 2001
@@ -54,17 +54,6 @@
  * Note that several drives may have the same major.
  */
 
-/* a linear search, superfluous when dev is a pointer */
-static struct gendisk *get_gendisk(kdev_t dev) {
-	struct gendisk *g;
-	int m = MAJOR(dev);
-
-	for (g = gendisk_head; g; g = g->next)
-		if (g->major == m)
-			break;
-	return g;
-}
-
 /*
  * Add a partition.
  *
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/block/cciss.c linux/drivers/block/cciss.c
--- ../master/linux-2.4.10-pre4/drivers/block/cciss.c	Mon Sep  3 17:32:40 2001
+++ linux/drivers/block/cciss.c	Mon Sep  3 19:39:51 2001
@@ -1965,8 +1965,7 @@
 	hba[i]->gendisk.nr_real = hba[i]->num_luns;
 
 	/* Get on the disk list */ 
-	hba[i]->gendisk.next = gendisk_head;
-	gendisk_head = &(hba[i]->gendisk); 
+	add_gendisk(&(hba[i]->gendisk));
 
 	cciss_geninit(i);
 	for(j=0; j<NWD; j++)
@@ -1982,7 +1981,6 @@
 {
 	ctlr_info_t *tmp_ptr;
 	int i;
-	struct gendisk *g;
 
 	if (pdev->driver_data == NULL)
 	{
@@ -2007,19 +2005,8 @@
 	
 
 	/* remove it from the disk list */
-	if (gendisk_head == &(hba[i]->gendisk))
-	{
-		gendisk_head = hba[i]->gendisk.next;
-	} else
-	{
-		for(g=gendisk_head; g ; g=g->next)
-		{
-			if(g->next == &(hba[i]->gendisk))
-			{
-				g->next = hba[i]->gendisk.next;
-			}
-		}
-	}
+	del_gendisk(&(hba[i]->gendisk));
+
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof(CommandList_struct), 
 		hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof( ErrorInfo_struct),
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/block/cpqarray.c linux/drivers/block/cpqarray.c
--- ../master/linux-2.4.10-pre4/drivers/block/cpqarray.c	Mon Sep  3 17:32:40 2001
+++ linux/drivers/block/cpqarray.c	Mon Sep  3 19:39:38 2001
@@ -311,7 +311,6 @@
 void cleanup_module(void)
 {
 	int i;
-	struct gendisk *g;
 	char buff[4]; 
 
 	for(i=0; i<nr_ctlr; i++) {
@@ -335,16 +334,7 @@
 			hba[i]->cmd_pool_dhandle);
 		kfree(hba[i]->cmd_pool_bits);
 
-		if (gendisk_head == &ida_gendisk[i]) {
-			gendisk_head = ida_gendisk[i].next;
-		} else {
-			for(g=gendisk_head; g; g=g->next) {
-				if (g->next == &ida_gendisk[i]) {
-					g->next = ida_gendisk[i].next;
-					break;
-				}
-			}
-		}
+		del_gendisk(&ida_gendisk[i]);
 	}
 	remove_proc_entry("cpqarray", proc_root_driver);
 	kfree(ida);
@@ -550,8 +540,7 @@
 		ida_gendisk[i].nr_real = 0; 
 	
 		/* Get on the disk list */
-		ida_gendisk[i].next = gendisk_head;
-		gendisk_head = &ida_gendisk[i];
+		add_gendisk(&ida_gendisk[i]);
 
 		init_timer(&hba[i]->timer);
 		hba[i]->timer.expires = jiffies + IDA_TIMER;
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/block/genhd.c linux/drivers/block/genhd.c
--- ../master/linux-2.4.10-pre4/drivers/block/genhd.c	Fri Jul 20 02:48:15 2001
+++ linux/drivers/block/genhd.c	Mon Sep  3 19:38:50 2001
@@ -17,6 +17,75 @@
 #include <linux/blk.h>
 #include <linux/init.h>
 
+
+struct gendisk *gendisk_head;
+
+void
+add_gendisk(struct gendisk *gp)
+{
+	gp->next = gendisk_head;
+	gendisk_head = gp;
+}
+
+void
+del_gendisk(struct gendisk *gp)
+{
+	struct gendisk **gpp;
+
+	for (gpp = &gendisk_head; *gpp; gpp = &((*gpp)->next))
+		if (*gpp == gp)
+			break;
+	if (*gpp)
+		*gpp = (*gpp)->next;
+}
+
+struct gendisk *
+get_gendisk(kdev_t dev)
+{
+	struct gendisk *gp = NULL;
+	int maj = MAJOR(dev);
+
+	for (gp = gendisk_head; gp; gp = gp->next)
+		if (gp->major == maj)
+			return gp;
+	return NULL;
+}
+
+#ifdef CONFIG_PROC_FS
+int
+get_partition_list(char *page, char **start, off_t offset, int count)
+{
+	struct gendisk *gp;
+	char buf[64];
+	int len, n;
+
+	len = sprintf(page, "major minor  #blocks  name\n\n");
+	for (gp = gendisk_head; gp; gp = gp->next) {
+		for (n = 0; n < (gp->nr_real << gp->minor_shift); n++) {
+			if (gp->part[n].nr_sects == 0)
+				continue;
+
+			len += snprintf(page + len, 63,
+					"%4d  %4d %10d %s\n",
+					gp->major, n, gp->sizes[n],
+					disk_name(gp, n, buf));
+			if (len < offset)
+				offset -= len, len = 0;
+			else if (len >= offset + count)
+				goto out;
+		}
+	}
+
+out:
+	*start = page + offset;
+	len -= offset;
+	if (len < 0)
+		len = 0;
+	return len > count ? count : len;
+}
+#endif
+
+
 extern int blk_dev_init(void);
 #ifdef CONFIG_BLK_DEV_DAC960
 extern void DAC960_Initialize(void);
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/block/paride/pd.c linux/drivers/block/paride/pd.c
--- ../master/linux-2.4.10-pre4/drivers/block/paride/pd.c	Sat Apr 28 20:27:53 2001
+++ linux/drivers/block/paride/pd.c	Mon Sep  3 18:24:19 2001
@@ -455,8 +455,7 @@
         
 	pd_gendisk.major = major;
 	pd_gendisk.major_name = name;
-	pd_gendisk.next = gendisk_head;
-	gendisk_head = &pd_gendisk;
+	add_gendisk(&pd_gendisk);
 
 	for(i=0;i<PD_DEVS;i++) pd_blocksizes[i] = 1024;
 	blksize_size[MAJOR_NR] = pd_blocksizes;
@@ -642,12 +641,7 @@
 	int unit;
 
         devfs_unregister_blkdev(MAJOR_NR,name);
-        for(gdp=&gendisk_head;*gdp;gdp=&((*gdp)->next))
-                if (*gdp == &pd_gendisk) break;
-        if (*gdp) *gdp = (*gdp)->next;
-
-	for (unit=0;unit<PD_UNITS;unit++) 
-	   if (PD.present) pi_release(PI);
+	del_gendisk(&pd_gendisk);
 }
 
 #endif
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/block/ps2esdi.c linux/drivers/block/ps2esdi.c
--- ../master/linux-2.4.10-pre4/drivers/block/ps2esdi.c	Mon Sep  3 17:32:40 2001
+++ linux/drivers/block/ps2esdi.c	Mon Sep  3 18:21:52 2001
@@ -184,8 +184,7 @@
 	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 
 	/* some minor housekeeping - setup the global gendisk structure */
-	ps2esdi_gendisk.next = gendisk_head;
-	gendisk_head = &ps2esdi_gendisk;
+	add_gendisk(&ps2esdi_gendisk);
 	ps2esdi_geninit();
 	return 0;
 }				/* ps2esdi_init */
@@ -232,6 +231,7 @@
 	free_dma(dma_arb_level);
   	free_irq(PS2ESDI_IRQ, NULL)
 	devfs_unregister_blkdev(MAJOR_NR, "ed");
+	del_gendisk(&ps2esdi_gendisk);
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 }
 #endif /* MODULE */
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/block/xd.c linux/drivers/block/xd.c
--- ../master/linux-2.4.10-pre4/drivers/block/xd.c	Fri May 25 00:14:08 2001
+++ linux/drivers/block/xd.c	Mon Sep  3 19:39:30 2001
@@ -173,8 +173,7 @@
 	devfs_handle = devfs_mk_dir (NULL, xd_gendisk.major_name, NULL);
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
-	xd_gendisk.next = gendisk_head;
-	gendisk_head = &xd_gendisk;
+	add_gendisk(&xd_gendisk);
 	xd_geninit();
 
 	return 0;
@@ -1112,18 +1111,12 @@
 
 static void xd_done (void)
 {
-	struct gendisk ** gdp;
-	
 	blksize_size[MAJOR_NR] = NULL;
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 	blk_size[MAJOR_NR] = NULL;
 	hardsect_size[MAJOR_NR] = NULL;
 	read_ahead[MAJOR_NR] = 0;
-	for (gdp = &gendisk_head; *gdp; gdp = &((*gdp)->next))
-		if (*gdp == &xd_gendisk)
-			break;
-	if (*gdp)
-		*gdp = (*gdp)->next;
+	del_gendisk(&xd_gendisk);
 	release_region(xd_iobase,4);
 }
 
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/i2o/i2o_block.c linux/drivers/i2o/i2o_block.c
--- ../master/linux-2.4.10-pre4/drivers/i2o/i2o_block.c	Mon Sep  3 17:32:40 2001
+++ linux/drivers/i2o/i2o_block.c	Mon Sep  3 18:29:41 2001
@@ -1975,9 +1975,8 @@
 
 	/*
 	 *	Adding i2ob_gendisk into the gendisk list.
-	 */	
-	i2ob_gendisk.next = gendisk_head;
-	gendisk_head = &i2ob_gendisk;
+	 */
+	add_gendisk(&i2ob_gendisk);
 
 	return 0;
 }
@@ -2047,20 +2046,6 @@
 	 */
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 
-	/*
-	 *	Why isnt register/unregister gendisk in the kernel ???
-	 */
-
-	if (gendisk_head == &i2ob_gendisk) {
-		gendisk_head = i2ob_gendisk.next;
-		}
-	else {
-		for (gdp = gendisk_head; gdp; gdp = gdp->next)
-			if (gdp->next == &i2ob_gendisk)
-			{
-				gdp->next = i2ob_gendisk.next;
-				break;
-			}
-	}
+	del_gendisk(&i2ob_gendisk);
 }
 #endif
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/ide/hd.c linux/drivers/ide/hd.c
--- ../master/linux-2.4.10-pre4/drivers/ide/hd.c	Sat Apr 28 20:27:53 2001
+++ linux/drivers/ide/hd.c	Mon Sep  3 17:40:40 2001
@@ -842,8 +842,7 @@
 	}
 	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	read_ahead[MAJOR_NR] = 8;		/* 8 sector (4kB) read-ahead */
-	hd_gendisk.next = gendisk_head;
-	gendisk_head = &hd_gendisk;
+	add_gendisk(&hd_gendisk, MAJOR_NR);
 	init_timer(&device_timer);
 	device_timer.function = hd_times_out;
 	hd_geninit();
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- ../master/linux-2.4.10-pre4/drivers/ide/ide-probe.c	Thu Aug 30 10:35:25 2001
+++ linux/drivers/ide/ide-probe.c	Mon Sep  3 18:30:30 2001
@@ -747,7 +747,7 @@
  */
 static void init_gendisk (ide_hwif_t *hwif)
 {
-	struct gendisk *gd, **gdp;
+	struct gendisk *gd;
 	unsigned int unit, units, minors;
 	int *bs, *max_sect, *max_ra;
 	extern devfs_handle_t ide_devfs_handle;
@@ -800,8 +800,8 @@
 	if (gd->flags)
 		memset (gd->flags, 0, sizeof *gd->flags * units);
 
-	for (gdp = &gendisk_head; *gdp; gdp = &((*gdp)->next)) ;
-	hwif->gd = *gdp = gd;			/* link onto tail of list */
+	hwif->gd = gd;
+	add_gendisk(gd);
 
 	for (unit = 0; unit < units; ++unit) {
 		if (hwif->drives[unit].present) {
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/ide/ide.c linux/drivers/ide/ide.c
--- ../master/linux-2.4.10-pre4/drivers/ide/ide.c	Mon Sep  3 17:32:40 2001
+++ linux/drivers/ide/ide.c	Mon Sep  3 18:30:20 2001
@@ -2059,7 +2059,7 @@
 
 void ide_unregister (unsigned int index)
 {
-	struct gendisk *gd, **gdp;
+	struct gendisk *gd;
 	ide_drive_t *drive, *d;
 	ide_hwif_t *hwif, *g;
 	ide_hwgroup_t *hwgroup;
@@ -2179,13 +2179,9 @@
 	blk_dev[hwif->major].data = NULL;
 	blk_dev[hwif->major].queue = NULL;
 	blksize_size[hwif->major] = NULL;
-	for (gdp = &gendisk_head; *gdp; gdp = &((*gdp)->next))
-		if (*gdp == hwif->gd)
-			break;
-	if (*gdp == NULL)
-		printk("gd not in disk chain!\n");
-	else {
-		gd = *gdp; *gdp = gd->next;
+	gd = hwif->gd;
+	if (gd) {
+		del_gendisk(gd);
 		kfree(gd->sizes);
 		kfree(gd->part);
 		if (gd->de_arr)
@@ -2193,6 +2189,7 @@
 		if (gd->flags)
 			kfree (gd->flags);
 		kfree(gd);
+		hwif->gd = NULL;
 	}
 	old_hwif		= *hwif;
 	init_hwif_data (index);	/* restore hwif data to pristine status */
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/md/lvm.c linux/drivers/md/lvm.c
--- ../master/linux-2.4.10-pre4/drivers/md/lvm.c	Mon Sep  3 17:32:40 2001
+++ linux/drivers/md/lvm.c	Mon Sep  3 19:04:45 2001
@@ -394,8 +394,6 @@
  */
 int lvm_init(void)
 {
-	struct gendisk *gendisk_ptr = NULL;
-
 	if (register_chrdev(LVM_CHAR_MAJOR, lvm_name, &lvm_chr_fops) < 0) {
 		printk(KERN_ERR "%s -- register_chrdev failed\n", lvm_name);
 		return -EIO;
@@ -423,19 +421,7 @@
 	lvm_init_vars();
 	lvm_geninit(&lvm_gendisk);
 
-	/* insert our gendisk at the corresponding major */
-	if (gendisk_head != NULL) {
-		gendisk_ptr = gendisk_head;
-		while (gendisk_ptr->next != NULL &&
-		       gendisk_ptr->major > lvm_gendisk.major) {
-			gendisk_ptr = gendisk_ptr->next;
-		}
-		lvm_gendisk.next = gendisk_ptr->next;
-		gendisk_ptr->next = &lvm_gendisk;
-	} else {
-		gendisk_head = &lvm_gendisk;
-		lvm_gendisk.next = NULL;
-	}
+	add_gendisk(&lvm_gendisk);
 
 #ifdef LVM_HD_NAME
 	/* reference from drivers/block/genhd.c */
@@ -469,8 +455,6 @@
  */
 static void lvm_cleanup(void)
 {
-	struct gendisk *gendisk_ptr = NULL, *gendisk_ptr_prev = NULL;
-
 	devfs_unregister (lvm_devfs_handle);
 
 	if (unregister_chrdev(LVM_CHAR_MAJOR, lvm_name) < 0) {
@@ -481,16 +465,7 @@
 	}
 
 
-	gendisk_ptr = gendisk_ptr_prev = gendisk_head;
-	while (gendisk_ptr != NULL) {
-		if (gendisk_ptr == &lvm_gendisk)
-			break;
-		gendisk_ptr_prev = gendisk_ptr;
-		gendisk_ptr = gendisk_ptr->next;
-	}
-	/* delete our gendisk from chain */
-	if (gendisk_ptr == &lvm_gendisk)
-		gendisk_ptr_prev->next = gendisk_ptr->next;
+	del_gendisk(&lvm_gendisk);
 
 	blk_size[MAJOR_NR] = NULL;
 	blksize_size[MAJOR_NR] = NULL;
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/md/md.c linux/drivers/md/md.c
--- ../master/linux-2.4.10-pre4/drivers/md/md.c	Mon Sep  3 17:32:40 2001
+++ linux/drivers/md/md.c	Mon Sep  3 19:40:03 2001
@@ -222,18 +222,6 @@
 	return mddev;
 }
 
-struct gendisk * find_gendisk (kdev_t dev)
-{
-	struct gendisk *tmp = gendisk_head;
-
-	while (tmp != NULL) {
-		if (tmp->major == MAJOR(dev))
-			return (tmp);
-		tmp = tmp->next;
-	}
-	return (NULL);
-}
-
 mdk_rdev_t * find_rdev_nr(mddev_t *mddev, int nr)
 {
 	mdk_rdev_t * rdev;
@@ -281,7 +269,7 @@
 	/*
 	 * ok, add this new device name to the list
 	 */
-	hd = find_gendisk (dev);
+	hd = get_gendisk (dev);
 	dname->name = NULL;
 	if (hd)
 		dname->name = disk_name (hd, MINOR(dev), dname->namebuf);
@@ -569,7 +557,7 @@
 static kdev_t dev_unit(kdev_t dev)
 {
 	unsigned int mask;
-	struct gendisk *hd = find_gendisk(dev);
+	struct gendisk *hd = get_gendisk(dev);
 
 	if (!hd)
 		return 0;
@@ -3515,9 +3503,8 @@
 	
 
 	read_ahead[MAJOR_NR] = INT_MAX;
-	md_gendisk.next = gendisk_head;
 
-	gendisk_head = &md_gendisk;
+	add_gendisk(&md_gendisk);
 
 	md_recovery_thread = md_register_thread(md_do_recovery, NULL, name);
 	if (!md_recovery_thread)
@@ -3843,8 +3830,6 @@
 
 void cleanup_module (void)
 {
-	struct gendisk **gendisk_ptr;
-
 	md_unregister_thread(md_recovery_thread);
 	devfs_unregister(devfs_handle);
 
@@ -3854,15 +3839,9 @@
 #ifdef CONFIG_PROC_FS
 	remove_proc_entry("mdstat", NULL);
 #endif
-	
-	gendisk_ptr = &gendisk_head;
-	while (*gendisk_ptr) {
-		if (*gendisk_ptr == &md_gendisk) {
-			*gendisk_ptr = md_gendisk.next;
-			break;
-		}
-		gendisk_ptr = & (*gendisk_ptr)->next;
-	}
+
+	del_gendisk(&md_gendisk);
+
 	blk_dev[MAJOR_NR].queue = NULL;
 	blksize_size[MAJOR_NR] = NULL;
 	blk_size[MAJOR_NR] = NULL;
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/mtd/ftl.c linux/drivers/mtd/ftl.c
--- ../master/linux-2.4.10-pre4/drivers/mtd/ftl.c	Tue Jun 12 19:30:27 2001
+++ linux/drivers/mtd/ftl.c	Mon Sep  3 18:31:51 2001
@@ -1428,8 +1428,7 @@
     blksize_size[FTL_MAJOR] = ftl_blocksizes;
     ftl_gendisk.major = FTL_MAJOR;
     blk_init_queue(BLK_DEFAULT_QUEUE(FTL_MAJOR), &do_ftl_request);
-    ftl_gendisk.next = gendisk_head;
-    gendisk_head = &ftl_gendisk;
+    add_gendisk(&ftl_gendisk);
     
     register_mtd_user(&ftl_notifier);
     
@@ -1438,19 +1437,13 @@
 
 mod_exit_t cleanup_ftl(void)
 {
-    struct gendisk *gd, **gdp;
-
     unregister_mtd_user(&ftl_notifier);
 
     unregister_blkdev(FTL_MAJOR, "ftl");
     blk_cleanup_queue(BLK_DEFAULT_QUEUE(FTL_MAJOR));
     blksize_size[FTL_MAJOR] = NULL;
 
-    for (gdp = &gendisk_head; *gdp; gdp = &((*gdp)->next))
-	if (*gdp == &ftl_gendisk) {
-	    gd = *gdp; *gdp = gd->next;
-	    break;
-	}
+    del_gendisk(&ftl_gendisk);
 }
 
 module_init(init_ftl);
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/mtd/nftlcore.c linux/drivers/mtd/nftlcore.c
--- ../master/linux-2.4.10-pre4/drivers/mtd/nftlcore.c	Tue Jun 12 19:30:27 2001
+++ linux/drivers/mtd/nftlcore.c	Mon Sep  3 18:14:27 2001
@@ -1059,8 +1059,7 @@
 		}
 		blksize_size[MAJOR_NR] = nftl_blocksizes;
 
-		nftl_gendisk.next = gendisk_head;
-		gendisk_head = &nftl_gendisk;
+		add_gendisk(&nftl_gendisk);
 	}
 	
 	register_mtd_user(&nftl_notifier);
@@ -1083,11 +1082,7 @@
 
 	/* remove ourself from generic harddisk list
 	   FIXME: why can't I found this partition on /proc/partition */
-  	for (gdp = &gendisk_head; *gdp; gdp = &((*gdp)->next))
-    		if (*gdp == &nftl_gendisk) {
-      			gd = *gdp; *gdp = gd->next;
-      			break;
-		}
+	del_gendisk(&nftl_gendisk);:
 }
 
 module_init(init_nftl);
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/s390/block/dasd.c linux/drivers/s390/block/dasd.c
--- ../master/linux-2.4.10-pre4/drivers/s390/block/dasd.c	Mon Sep  3 17:32:40 2001
+++ linux/drivers/s390/block/dasd.c	Mon Sep  3 17:42:07 2001
@@ -714,10 +714,9 @@
 
 	INIT_BLK_DEV (major, do_dasd_request, dasd_get_queue, NULL);
 
-	major_info->gendisk.major = major;
-	major_info->gendisk.next = gendisk_head;
 	major_info->gendisk.sizes = blk_size[major];
-	gendisk_head = &major_info->gendisk;
+	major_info->gendisk.major = major;
+	add_gendisk (&major_info->gendisk);
 	return major;
 
         /* error handling - free the prior allocated memory */  
@@ -775,7 +774,6 @@
 {
 	int rc = 0;
 	int major;
-	struct gendisk *dd, *prev = NULL;
 	unsigned long flags;
 
 	if (major_info == NULL) {
@@ -784,20 +782,8 @@
 	major = major_info->gendisk.major;
 	INIT_BLK_DEV (major, NULL, NULL, NULL);
 
-	/* do the gendisk stuff */
-	for (dd = gendisk_head; dd; dd = dd->next) {
-		if (dd == &major_info->gendisk) {
-			if (prev)
-				prev->next = dd->next;
-			else
-				gendisk_head = dd->next;
-			break;
-		}
-		prev = dd;
-	}
-	if (dd == NULL) {
-		return -ENOENT;
-	}
+	del_gendisk (&major_info->gendisk);
+
 	kfree (major_info->dasd_device);
 	kfree (major_info->gendisk.part);
 
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/drivers/scsi/sd.c linux/drivers/scsi/sd.c
--- ../master/linux-2.4.10-pre4/drivers/scsi/sd.c	Mon Sep  3 17:32:40 2001
+++ linux/drivers/scsi/sd.c	Mon Sep  3 19:08:06 2001
@@ -578,7 +578,6 @@
 static struct gendisk *sd_gendisks = &sd_gendisk;
 
 #define SD_GENDISK(i)    sd_gendisks[(i) / SCSI_DISKS_PER_MAJOR]
-#define LAST_SD_GENDISK  sd_gendisks[N_USED_SD_MAJORS - 1]
 
 /*
  * rw_intr is the interrupt routine for the device driver.
@@ -1147,12 +1146,10 @@
 		sd_gendisks[i].part = sd + (i * SCSI_DISKS_PER_MAJOR << 4);
 		sd_gendisks[i].sizes = sd_sizes + (i * SCSI_DISKS_PER_MAJOR << 4);
 		sd_gendisks[i].nr_real = 0;
-		sd_gendisks[i].next = sd_gendisks + i + 1;
 		sd_gendisks[i].real_devices =
 		    (void *) (rscsi_disks + i * SCSI_DISKS_PER_MAJOR);
 	}
 
-	LAST_SD_GENDISK.next = NULL;
 	return 0;
 
 cleanup_gendisks_flags:
@@ -1184,19 +1181,13 @@
 
 static void sd_finish()
 {
-	struct gendisk *gendisk;
 	int i;
 
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
 		blk_dev[SD_MAJOR(i)].queue = sd_find_queue;
+		add_gendisk(&sd_gendisks[i]);
 	}
-	for (gendisk = gendisk_head; gendisk != NULL; gendisk = gendisk->next)
-		if (gendisk == sd_gendisks)
-			break;
-	if (gendisk == NULL) {
-		LAST_SD_GENDISK.next = gendisk_head;
-		gendisk_head = sd_gendisks;
-	}
+
 	for (i = 0; i < sd_template.dev_max; ++i)
 		if (!rscsi_disks[i].capacity && rscsi_disks[i].device) {
 			sd_init_onedisk(i);
@@ -1377,10 +1368,7 @@
 
 static void __exit exit_sd(void)
 {
-	struct gendisk **prev_sdgd_link;
-	struct gendisk *sdgd;
 	int i;
-	int removed = 0;
 
 	scsi_unregister_module(MODULE_SCSI_DEV, &sd_template);
 
@@ -1394,26 +1382,9 @@
 		kfree(sd_blocksizes);
 		kfree(sd_hardsizes);
 		kfree((char *) sd);
-
-		/*
-		 * Now remove sd_gendisks from the linked list
-		 */
-		prev_sdgd_link = &gendisk_head;
-		while ((sdgd = *prev_sdgd_link) != NULL) {
-			if (sdgd >= sd_gendisks && sdgd <= &LAST_SD_GENDISK) {
-				removed++;
-				*prev_sdgd_link = sdgd->next;
-				continue;
-			}
-			prev_sdgd_link = &sdgd->next;
-		}
-
-		if (removed != N_USED_SD_MAJORS)
-			printk("%s %d sd_gendisks in disk chain",
-			       removed > N_USED_SD_MAJORS ? "total" : "just", removed);
-
 	}
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
+		del_gendisk(&sd_gendisks[i]);
 		blk_size[SD_MAJOR(i)] = NULL;
 		hardsect_size[SD_MAJOR(i)] = NULL;
 		read_ahead[SD_MAJOR(i)] = 0;
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/fs/partitions/check.c linux/fs/partitions/check.c
--- ../master/linux-2.4.10-pre4/fs/partitions/check.c	Tue Aug 14 20:03:14 2001
+++ linux/fs/partitions/check.c	Mon Sep  3 17:51:16 2001
@@ -36,7 +36,6 @@
 
 extern int *blk_size[];
 
-struct gendisk *gendisk_head;
 int warn_no_part = 1; /*This is ugly: should make genhd removable media aware*/
 
 static int (*check_part[])(struct gendisk *hd, kdev_t dev, unsigned long first_sect, int first_minor) = {
@@ -257,39 +256,6 @@
 	return ret;
 }
 
-#ifdef CONFIG_PROC_FS
-int get_partition_list(char *page, char **start, off_t offset, int count)
-{
-	struct gendisk *dsk;
-	int len;
-
-	len = sprintf(page, "major minor  #blocks  name\n\n");
-	for (dsk = gendisk_head; dsk; dsk = dsk->next) {
-		int n;
-
-		for (n = 0; n < (dsk->nr_real << dsk->minor_shift); n++)
-			if (dsk->part[n].nr_sects) {
-				char buf[64];
-
-				len += sprintf(page + len,
-					       "%4d  %4d %10d %s\n",
-					       dsk->major, n, dsk->sizes[n],
-					       disk_name(dsk, n, buf));
-				if (len < offset)
-					offset -= len, len = 0;
-				else if (len >= offset + count)
-					goto leave_loops;
-			}
-	}
-leave_loops:
-	*start = page + offset;
-	len -= offset;
-	if (len < 0)
-		len = 0;
-	return len > count ? count : len;
-}
-#endif
-
 static void check_partition(struct gendisk *hd, kdev_t dev, int first_part_minor)
 {
 	devfs_handle_t de = NULL;
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/include/linux/genhd.h linux/include/linux/genhd.h
--- ../master/linux-2.4.10-pre4/include/linux/genhd.h	Fri Jul 20 21:53:03 2001
+++ linux/include/linux/genhd.h	Mon Sep  3 19:55:10 2001
@@ -74,6 +74,14 @@
 	devfs_handle_t *de_arr;         /* one per physical disc */
 	char *flags;                    /* one per physical disc */
 };
+
+/* drivers/block/genhd.c */
+extern struct gendisk *gendisk_head;
+
+extern void add_gendisk(struct gendisk *gp);
+extern void del_gendisk(struct gendisk *gp);
+extern struct gendisk *get_gendisk(kdev_t dev);
+
 #endif  /*  __KERNEL__  */
 
 #ifdef CONFIG_SOLARIS_X86_PARTITION
@@ -230,7 +238,6 @@
 #endif /* CONFIG_MINIX_SUBPARTITION */
 
 #ifdef __KERNEL__
-extern struct gendisk *gendisk_head;	/* linked list of disks */
 
 char *disk_name (struct gendisk *hd, int minor, char *buf);
 
diff -uNr -X../current/dontdiff ../master/linux-2.4.10-pre4/include/linux/raid/md.h linux/include/linux/raid/md.h
--- ../master/linux-2.4.10-pre4/include/linux/raid/md.h	Thu Aug 30 10:35:30 2001
+++ linux/include/linux/raid/md.h	Mon Sep  3 19:29:53 2001
@@ -78,7 +78,6 @@
 extern void md_sync_acct(kdev_t dev, unsigned long nr_sectors);
 extern void md_recover_arrays (void);
 extern int md_check_ordering (mddev_t *mddev);
-extern struct gendisk * find_gendisk (kdev_t dev);
 extern int md_notify_reboot(struct notifier_block *this,
 					unsigned long code, void *x);
 extern int md_error (mddev_t *mddev, kdev_t rdev);

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267408AbSLETrE>; Thu, 5 Dec 2002 14:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbSLETrD>; Thu, 5 Dec 2002 14:47:03 -0500
Received: from verein.lst.de ([212.34.181.86]:57362 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S267408AbSLETot>;
	Thu, 5 Dec 2002 14:44:49 -0500
Date: Thu, 5 Dec 2002 20:52:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] get rid of MAJOR_NR
Message-ID: <20021205205220.B29552@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <= 2.4 some of the mess in blk.h needed it defined, but that's
long gone now.


--- 1.45/drivers/block/acsi.c	Tue Nov  5 19:22:51 2002
+++ edited/drivers/block/acsi.c	Thu Dec  5 16:05:51 2002
@@ -43,9 +43,6 @@
  *
  */
 
-#define MAJOR_NR ACSI_MAJOR
-#define DEVICE_NAME "ACSI"
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
@@ -971,7 +968,7 @@
 	aip = disk->private_data;
 	if (CURRENT->bh) {
 		if (!CURRENT->bh && !buffer_locked(CURRENT->bh))
-			panic(DEVICE_NAME ": block not locked");
+			panic("ACSI: block not locked");
 	}
 
 	block = CURRENT->sector;
@@ -1627,8 +1624,8 @@
 #endif
 	if (!MACH_IS_ATARI || !ATARIHW_PRESENT(ACSI))
 		return 0;
-	if (register_blkdev( MAJOR_NR, "ad", &acsi_fops )) {
-		printk( KERN_ERR "Unable to get major %d for ACSI\n", MAJOR_NR );
+	if (register_blkdev( ACSI_MAJOR, "ad", &acsi_fops )) {
+		printk( KERN_ERR "Unable to get major %d for ACSI\n", ACSI_MAJOR );
 		err = -EBUSY;
 		goto out1;
 	}
@@ -1731,7 +1728,7 @@
 	for( i = 0; i < NDevices; ++i ) {
 		struct gendisk *disk = acsi_gendisk[i];
 		sprintf(disk->disk_name, "ad%c", 'a'+i);
-		disk->major = MAJOR_NR;
+		disk->major = ACSI_MAJOR;
 		disk->first_minor = i << 4;
 		if (acsi_info[i].type != HARDDISK) {
 			disk->minor_shift = 0;
@@ -1751,7 +1748,7 @@
 	blk_cleanup_queue(&acsi_queue);
 	atari_stram_free( acsi_buffer );
 out2:
-	unregister_blkdev( MAJOR_NR, "ad" );
+	unregister_blkdev( ACSI_MAJOR, "ad" );
 out1:
 	return err;
 }
@@ -1778,7 +1775,7 @@
 	blk_cleanup_queue(&acsi_queue);
 	atari_stram_free( acsi_buffer );
 
-	if (unregister_blkdev( MAJOR_NR, "ad" ) != 0)
+	if (unregister_blkdev( ACSI_MAJOR, "ad" ) != 0)
 		printk( KERN_ERR "acsi: cleanup_module failed\n");
 
 	for (i = 0; i < NDevices; i++) {
===== drivers/block/acsi_slm.c 1.8 vs edited =====
--- 1.8/drivers/block/acsi_slm.c	Tue Dec  3 18:13:58 2002
+++ edited/drivers/block/acsi_slm.c	Thu Dec  5 16:02:07 2002
@@ -95,8 +95,6 @@
  */
 #define	SLM_CONT_CNT_REPROG
 
-#define MAJOR_NR ACSI_MAJOR
-
 #define CMDSET_TARG_LUN(cmd,targ,lun)			\
     do {										\
 		cmd[0] = (cmd[0] & ~0xe0) | (targ)<<5;	\
@@ -997,14 +995,14 @@
 
 {
 	int i;
-	if (register_chrdev( MAJOR_NR, "slm", &slm_fops )) {
-		printk( KERN_ERR "Unable to get major %d for ACSI SLM\n", MAJOR_NR );
+	if (register_chrdev( ACSI_MAJOR, "slm", &slm_fops )) {
+		printk( KERN_ERR "Unable to get major %d for ACSI SLM\n", ACSI_MAJOR );
 		return -EBUSY;
 	}
 	
 	if (!(SLMBuffer = atari_stram_alloc( SLM_BUFFER_SIZE, NULL, "SLM" ))) {
 		printk( KERN_ERR "Unable to get SLM ST-Ram buffer.\n" );
-		unregister_chrdev( MAJOR_NR, "slm" );
+		unregister_chrdev( ACSI_MAJOR, "slm" );
 		return -ENOMEM;
 	}
 	BufferP = SLMBuffer;
@@ -1015,7 +1013,7 @@
 		char name[16];
 		sprintf(name, "slm/%d", i);
 		devfs_register(NULL, name, DEVFS_FL_DEFAULT,
-			       MAJOR_NR, i, S_IFCHR | S_IRUSR | S_IWUSR,
+			       ACSI_MAJOR, i, S_IFCHR | S_IRUSR | S_IWUSR,
 			       &slm_fops, NULL);
 	}
 	return 0;
@@ -1044,7 +1042,7 @@
 	for (i = 0; i < MAX_SLM; i++)
 		devfs_remove("slm/%d", i);
 	devfs_remove("slm");
-	if (unregister_chrdev( MAJOR_NR, "slm" ) != 0)
+	if (unregister_chrdev( ACSI_MAJOR, "slm" ) != 0)
 		printk( KERN_ERR "acsi_slm: cleanup_module failed\n");
 	atari_stram_free( SLMBuffer );
 }
===== drivers/block/amiflop.c 1.31 vs edited =====
--- 1.31/drivers/block/amiflop.c	Mon Nov 11 02:40:24 2002
+++ edited/drivers/block/amiflop.c	Thu Dec  5 16:05:00 2002
@@ -120,9 +120,6 @@
 MODULE_LICENSE("GPL");
 
 static struct request_queue floppy_queue;
-
-#define MAJOR_NR FLOPPY_MAJOR
-#define DEVICE_NAME "floppy"
 #define QUEUE (&floppy_queue)
 #define CURRENT elv_next_request(&floppy_queue)
 
@@ -1620,7 +1617,7 @@
 	restore_flags(flags);
 
 	if (old_dev != system)
-		invalidate_buffers(mk_kdev(MAJOR_NR, drive + (system << 2)));
+		invalidate_buffers(mk_kdev(FLOPPY_MAJOR, drive + (system << 2)));
 
 	unit[drive].dtype=&data_types[system];
 	unit[drive].blocks=unit[drive].type->heads*unit[drive].type->tracks*
@@ -1727,7 +1724,7 @@
 			nomem = 1;
 		}
 		printk("fd%d ",drive);
-		disk->major = MAJOR_NR;
+		disk->major = FLOPPY_MAJOR;
 		disk->first_minor = drive;
 		disk->fops = &floppy_fops;
 		sprintf(disk->disk_name, "fd%d", drive);
@@ -1762,8 +1759,8 @@
 	if (!AMIGAHW_PRESENT(AMI_FLOPPY))
 		return -ENXIO;
 
-	if (register_blkdev(MAJOR_NR,"fd",&floppy_fops)) {
-		printk("fd: Unable to get major %d for floppy\n",MAJOR_NR);
+	if (register_blkdev(FLOPPY_MAJOR,"fd",&floppy_fops)) {
+		printk("fd: Unable to get major %d for floppy\n",FLOPPY_MAJOR);
 		return -EBUSY;
 	}
 	/*
@@ -1772,21 +1769,21 @@
 	 */
 	if (!request_mem_region(CUSTOM_PHYSADDR+0x20, 8, "amiflop [Paula]")) {
 		printk("fd: cannot get floppy registers\n");
-		unregister_blkdev(MAJOR_NR,"fd");
+		unregister_blkdev(FLOPPY_MAJOR,"fd");
 		return -EBUSY;
 	}
 	if ((raw_buf = (char *)amiga_chip_alloc (RAW_BUF_SIZE, "Floppy")) ==
 	    NULL) {
 		printk("fd: cannot get chip mem buffer\n");
 		release_mem_region(CUSTOM_PHYSADDR+0x20, 8);
-		unregister_blkdev(MAJOR_NR,"fd");
+		unregister_blkdev(FLOPPY_MAJOR,"fd");
 		return -ENOMEM;
 	}
 	if (request_irq(IRQ_AMIGA_DSKBLK, fd_block_done, 0, "floppy_dma", NULL)) {
 		printk("fd: cannot get irq for dma\n");
 		amiga_chip_free(raw_buf);
 		release_mem_region(CUSTOM_PHYSADDR+0x20, 8);
-		unregister_blkdev(MAJOR_NR,"fd");
+		unregister_blkdev(FLOPPY_MAJOR,"fd");
 		return -EBUSY;
 	}
 	if (request_irq(IRQ_AMIGA_CIAA_TB, ms_isr, 0, "floppy_timer", NULL)) {
@@ -1794,7 +1791,7 @@
 		free_irq(IRQ_AMIGA_DSKBLK, NULL);
 		amiga_chip_free(raw_buf);
 		release_mem_region(CUSTOM_PHYSADDR+0x20, 8);
-		unregister_blkdev(MAJOR_NR,"fd");
+		unregister_blkdev(FLOPPY_MAJOR,"fd");
 		return -EBUSY;
 	}
 	if (fd_probe_drives() < 1) { /* No usable drives */
@@ -1802,10 +1799,10 @@
 		free_irq(IRQ_AMIGA_DSKBLK, NULL);
 		amiga_chip_free(raw_buf);
 		release_mem_region(CUSTOM_PHYSADDR+0x20, 8);
-		unregister_blkdev(MAJOR_NR,"fd");
+		unregister_blkdev(FLOPPY_MAJOR,"fd");
 		return -ENXIO;
 	}
-	blk_register_region(MKDEV(MAJOR_NR, 0), 256, THIS_MODULE,
+	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
 				floppy_find, NULL, NULL);
 
 	/* initialize variables */
@@ -1866,13 +1863,13 @@
 			kfree(unit[i].trackbuf);
 		}
 	}
-	blk_unregister_region(MKDEV(MAJOR_NR, 0), 256);
+	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
 	free_irq(IRQ_AMIGA_CIAA_TB, NULL);
 	free_irq(IRQ_AMIGA_DSKBLK, NULL);
 	custom.dmacon = DMAF_DISK; /* disable DMA */
 	amiga_chip_free(raw_buf);
 	blk_cleanup_queue(&floppy_queue);
 	release_mem_region(CUSTOM_PHYSADDR+0x20, 8);
-	unregister_blkdev(MAJOR_NR, "fd");
+	unregister_blkdev(FLOPPY_MAJOR, "fd");
 }
 #endif
===== drivers/block/ataflop.c 1.30 vs edited =====
--- 1.30/drivers/block/ataflop.c	Mon Nov  4 21:00:28 2002
+++ edited/drivers/block/ataflop.c	Thu Dec  5 16:04:38 2002
@@ -100,8 +100,6 @@
 
 static struct request_queue floppy_queue;
 
-#define MAJOR_NR FLOPPY_MAJOR
-#define DEVICE_NAME "floppy"
 #define QUEUE (&floppy_queue)
 #define CURRENT elv_next_request(&floppy_queue)
 
@@ -1936,8 +1934,8 @@
 		/* Hades doesn't have Atari-compatible floppy */
 		return -ENXIO;
 
-	if (register_blkdev(MAJOR_NR,"fd",&floppy_fops)) {
-		printk(KERN_ERR "Unable to get major %d for floppy\n",MAJOR_NR);
+	if (register_blkdev(FLOPPY_MAJOR,"fd",&floppy_fops)) {
+		printk(KERN_ERR "Unable to get major %d for floppy\n",FLOPPY_MAJOR);
 		return -EBUSY;
 	}
 
@@ -1973,7 +1971,7 @@
 	for (i = 0; i < FD_MAX_UNITS; i++) {
 		unit[i].track = -1;
 		unit[i].flags = 0;
-		unit[i].disk->major = MAJOR_NR;
+		unit[i].disk->major = FLOPPY_MAJOR;
 		unit[i].disk->first_minor = i;
 		sprintf(unit[i].disk->disk_name, "fd%d", i);
 		unit[i].disk->fops = &floppy_fops;
@@ -1983,7 +1981,7 @@
 		add_disk(unit[i].disk);
 	}
 
-	blk_register_region(MKDEV(MAJOR_NR, 0), 256, THIS_MODULE,
+	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
 				floppy_find, NULL, NULL);
 
 	printk(KERN_INFO "Atari floppy driver: max. %cD, %strack buffering\n",
@@ -1995,7 +1993,7 @@
 Enomem:
 	while (i--)
 		put_disk(unit[i].disk);
-	unregister_blkdev(MAJOR_NR, "fd");
+	unregister_blkdev(FLOPPY_MAJOR, "fd");
 	return -ENOMEM;
 }
 
@@ -2042,12 +2040,12 @@
 void cleanup_module (void)
 {
 	int i;
-	blk_unregister_region(MKDEV(MAJOR_NR, 0), 256);
+	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
 	for (i = 0; i < FD_MAX_UNITS; i++) {
 		del_gendisk(unit[i].disk);
 		put_disk(unit[i].disk);
 	}
-	unregister_blkdev(MAJOR_NR, "fd");
+	unregister_blkdev(FLOPPY_MAJOR, "fd");
 
 	blk_cleanup_queue(&floppy_queue);
 	del_timer_sync(&fd_timer);
===== drivers/block/cciss.c 1.65 vs edited =====
--- 1.65/drivers/block/cciss.c	Sun Nov 17 20:20:11 2002
+++ edited/drivers/block/cciss.c	Thu Dec  5 16:03:48 2002
@@ -338,7 +338,7 @@
  */
 static int cciss_open(struct inode *inode, struct file *filep)
 {
-	int ctlr = major(inode->i_rdev) - MAJOR_NR;
+	int ctlr = major(inode->i_rdev) - COMPAQ_CISS_MAJOR;
 	int dsk  = minor(inode->i_rdev) >> NWD_SHIFT;
 
 #ifdef CCISS_DEBUG
@@ -368,7 +368,7 @@
  */
 static int cciss_release(struct inode *inode, struct file *filep)
 {
-	int ctlr = major(inode->i_rdev) - MAJOR_NR;
+	int ctlr = major(inode->i_rdev) - COMPAQ_CISS_MAJOR;
 	int dsk  = minor(inode->i_rdev) >> NWD_SHIFT;
 
 #ifdef CCISS_DEBUG
@@ -388,7 +388,7 @@
 static int cciss_ioctl(struct inode *inode, struct file *filep, 
 		unsigned int cmd, unsigned long arg)
 {
-	int ctlr = major(inode->i_rdev) - MAJOR_NR;
+	int ctlr = major(inode->i_rdev) - COMPAQ_CISS_MAJOR;
 	int dsk  = minor(inode->i_rdev) >> NWD_SHIFT;
 
 #ifdef CCISS_DEBUG
@@ -723,7 +723,7 @@
 	int ctlr, i;
 	unsigned long flags;
 
-	ctlr = major(dev) - MAJOR_NR;
+	ctlr = major(dev) - COMPAQ_CISS_MAJOR;
         if (minor(dev) != 0)
                 return -ENXIO;
 
@@ -2344,10 +2344,10 @@
 		return -ENODEV;
 	}
 
-	if( register_blkdev(MAJOR_NR+i, hba[i]->devname, &cciss_fops))
+	if( register_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname, &cciss_fops))
 	{
 		printk(KERN_ERR "cciss:  Unable to get major number "
-			"%d for %s\n", MAJOR_NR+i, hba[i]->devname);
+			"%d for %s\n", COMPAQ_CISS_MAJOR+i, hba[i]->devname);
 		release_io_mem(hba[i]);
 		free_hba(i);
 		return(-1);
@@ -2360,7 +2360,7 @@
 	{
 		printk(KERN_ERR "ciss: Unable to get irq %d for %s\n",
 			hba[i]->intr, hba[i]->devname);
-		unregister_blkdev( MAJOR_NR+i, hba[i]->devname);
+		unregister_blkdev( COMPAQ_CISS_MAJOR+i, hba[i]->devname);
 		release_io_mem(hba[i]);
 		free_hba(i);
 		return(-1);
@@ -2388,7 +2388,7 @@
 				hba[i]->errinfo_pool, 
 				hba[i]->errinfo_pool_dhandle);
                 free_irq(hba[i]->intr, hba[i]);
-                unregister_blkdev(MAJOR_NR+i, hba[i]->devname);
+                unregister_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname);
 		release_io_mem(hba[i]);
 		free_hba(i);
                 printk( KERN_ERR "cciss: out of memory");
@@ -2435,7 +2435,7 @@
 		struct gendisk *disk = hba[i]->gendisk[j];
 
 		sprintf(disk->disk_name, "cciss/c%dd%d", i, j);
-		disk->major = MAJOR_NR + i;
+		disk->major = COMPAQ_CISS_MAJOR + i;
 		disk->first_minor = j << NWD_SHIFT;
 		disk->fops = &cciss_fops;
 		disk->queue = &hba[i]->queue;
@@ -2486,7 +2486,7 @@
 	pci_set_drvdata(pdev, NULL);
 	iounmap((void*)hba[i]->vaddr);
 	cciss_unregister_scsi(i);  /* unhook from SCSI subsystem */
-	unregister_blkdev(MAJOR_NR+i, hba[i]->devname);
+	unregister_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname);
 	remove_proc_entry(hba[i]->devname, proc_cciss);	
 	
 	/* remove it from the disk list */
===== drivers/block/cciss.h 1.17 vs edited =====
--- 1.17/drivers/block/cciss.h	Fri Oct 18 12:55:58 2002
+++ edited/drivers/block/cciss.h	Thu Dec  5 16:03:43 2002
@@ -13,8 +13,6 @@
 #define IO_OK		0
 #define IO_ERROR	1
 
-#define MAJOR_NR COMPAQ_CISS_MAJOR 
-
 struct ctlr_info;
 typedef struct ctlr_info ctlr_info_t;
 
===== drivers/block/cpqarray.c 1.67 vs edited =====
--- 1.67/drivers/block/cpqarray.c	Tue Dec  3 18:14:30 2002
+++ edited/drivers/block/cpqarray.c	Thu Dec  5 16:02:59 2002
@@ -38,6 +38,9 @@
 #include <linux/init.h>
 #include <linux/hdreg.h>
 #include <linux/spinlock.h>
+#include <linux/blk.h>
+#include <linux/blkdev.h>
+#include <linux/genhd.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
@@ -53,14 +56,6 @@
 MODULE_DESCRIPTION("Driver for Compaq Smart2 Array Controllers");
 MODULE_LICENSE("GPL");
 
-#define MAJOR_NR COMPAQ_SMART2_MAJOR
-#define LOCAL_END_REQUEST
-#define DEVICE_NAME "ida"
-#define DEVICE_NR(device) (minor(device) >> 4)
-#include <linux/blk.h>
-#include <linux/blkdev.h>
-#include <linux/genhd.h>
-
 #include "cpqarray.h"
 #include "ida_cmd.h"
 #include "smart1,2.h"
@@ -295,7 +290,7 @@
 		}
 		free_irq(hba[i]->intr, hba[i]);
 		iounmap(hba[i]->vaddr);
-		unregister_blkdev(MAJOR_NR+i, hba[i]->devname);
+		unregister_blkdev(COMPAQ_SMART2_MAJOR+i, hba[i]->devname);
 		del_timer(&hba[i]->timer);
 		blk_cleanup_queue(&hba[i]->queue);
 		remove_proc_entry(hba[i]->devname, proc_array);
@@ -344,9 +339,9 @@
 	for(i=0; i < nr_ctlr; i++) {
 	  	/* If this successful it should insure that we are the only */
 		/* instance of the driver */	
-		if (register_blkdev(MAJOR_NR+i, hba[i]->devname, &ida_fops)) {
+		if (register_blkdev(COMPAQ_SMART2_MAJOR+i, hba[i]->devname, &ida_fops)) {
                         printk(KERN_ERR "cpqarray: Unable to get major number %d for ida\n",
-                                MAJOR_NR+i);
+                                COMPAQ_SMART2_MAJOR+i);
                         continue;
                 }
 		hba[i]->access.set_intr_mask(hba[i], 0);
@@ -355,7 +350,7 @@
 
 			printk(KERN_ERR "cpqarray: Unable to get irq %d for %s\n", 
 				hba[i]->intr, hba[i]->devname);
-			unregister_blkdev(MAJOR_NR+i, hba[i]->devname);
+			unregister_blkdev(COMPAQ_SMART2_MAJOR+i, hba[i]->devname);
 			continue;
 		}
 		num_cntlrs_reg++;
@@ -405,7 +400,7 @@
 			struct gendisk *disk = ida_gendisk[i][j];
 			drv_info_t *drv = &hba[i]->drv[j];
 			sprintf(disk->disk_name, "ida/c%dd%d", i, j);
-			disk->major = MAJOR_NR + i;
+			disk->major = COMPAQ_SMART2_MAJOR + i;
 			disk->first_minor = j<<NWD_SHIFT;
 			disk->flags = GENHD_FL_DEVFS;
 			disk->fops = &ida_fops; 
@@ -433,7 +428,7 @@
 		ida_gendisk[i][j] = NULL;
 	}
 	free_irq(hba[i]->intr, hba[i]);
-	unregister_blkdev(MAJOR_NR+i, hba[i]->devname);
+	unregister_blkdev(COMPAQ_SMART2_MAJOR+i, hba[i]->devname);
 	num_cntlrs_reg--;
 	printk( KERN_ERR "cpqarray: out of memory");
 
@@ -712,7 +707,7 @@
  */
 static int ida_open(struct inode *inode, struct file *filep)
 {
-	int ctlr = major(inode->i_rdev) - MAJOR_NR;
+	int ctlr = major(inode->i_rdev) - COMPAQ_SMART2_MAJOR;
 	int dsk  = minor(inode->i_rdev) >> NWD_SHIFT;
 
 	DBGINFO(printk("ida_open %x (%x:%x)\n", inode->i_rdev, ctlr, dsk) );
@@ -741,7 +736,7 @@
  */
 static int ida_release(struct inode *inode, struct file *filep)
 {
-	int ctlr = major(inode->i_rdev) - MAJOR_NR;
+	int ctlr = major(inode->i_rdev) - COMPAQ_SMART2_MAJOR;
 	hba[ctlr]->usage_count--;
 	return 0;
 }
@@ -1022,7 +1017,7 @@
  */
 static int ida_ioctl(struct inode *inode, struct file *filep, unsigned int cmd, unsigned long arg)
 {
-	int ctlr = major(inode->i_rdev) - MAJOR_NR;
+	int ctlr = major(inode->i_rdev) - COMPAQ_SMART2_MAJOR;
 	int dsk  = minor(inode->i_rdev) >> NWD_SHIFT;
 	int error;
 	int diskinfo[4];
@@ -1402,7 +1397,7 @@
 	if (minor(dev) != 0)
 		return -ENXIO;
 
-	ctlr = major(dev) - MAJOR_NR;
+	ctlr = major(dev) - COMPAQ_SMART2_MAJOR;
 
 	spin_lock_irqsave(IDA_LOCK(ctlr), flags);
 	if (hba[ctlr]->usage_count > 1) {
===== drivers/block/floppy.c 1.63 vs edited =====
--- 1.63/drivers/block/floppy.c	Tue Dec  3 19:14:11 2002
+++ edited/drivers/block/floppy.c	Thu Dec  5 16:01:30 2002
@@ -240,9 +240,8 @@
 static int irqdma_allocated;
 
 #define LOCAL_END_REQUEST
-#define MAJOR_NR FLOPPY_MAJOR
 #define DEVICE_NAME "floppy"
-#define DEVICE_NR(device) ( (minor(device) & 3) | ((minor(device) & 0x80 ) >> 5 ))
+
 #include <linux/blk.h>
 #include <linux/blkpg.h>
 #include <linux/cdrom.h> /* for the compatibility eject ioctl */
@@ -3969,7 +3968,7 @@
 	    char name[16];
 
 	    sprintf(name, "floppy/%d%s", drive, table[table_sup[UDP->cmos][i]]);
-	    devfs_register(NULL, name, DEVFS_FL_DEFAULT, MAJOR_NR,
+	    devfs_register(NULL, name, DEVFS_FL_DEFAULT, FLOPPY_MAJOR,
 			    base_minor + (table_sup[UDP->cmos][i] << 2),
 			    S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |S_IWGRP,
 			    &floppy_fops, NULL);
@@ -4241,20 +4240,20 @@
 	}
 
 	devfs_mk_dir (NULL, "floppy", NULL);
-	if (register_blkdev(MAJOR_NR,"fd",&floppy_fops)) {
-		printk("Unable to get major %d for floppy\n",MAJOR_NR);
+	if (register_blkdev(FLOPPY_MAJOR,"fd",&floppy_fops)) {
+		printk("Unable to get major %d for floppy\n",FLOPPY_MAJOR);
 		err = -EBUSY;
 		goto out;
 	}
 
 	for (i=0; i<N_DRIVE; i++) {
-		disks[i]->major = MAJOR_NR;
+		disks[i]->major = FLOPPY_MAJOR;
 		disks[i]->first_minor = TOMINOR(i);
 		disks[i]->fops = &floppy_fops;
 		sprintf(disks[i]->disk_name, "fd%d", i);
 	}
 
-	blk_register_region(MKDEV(MAJOR_NR, 0), 256, THIS_MODULE,
+	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
 				floppy_find, NULL, NULL);
 
 	for (i=0; i<256; i++)
@@ -4378,8 +4377,8 @@
 out1:
 	del_timer(&fd_timeout);
 out2:
-	blk_unregister_region(MKDEV(MAJOR_NR, 0), 256);
-	unregister_blkdev(MAJOR_NR,"fd");
+	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
+	unregister_blkdev(FLOPPY_MAJOR,"fd");
 	blk_cleanup_queue(&floppy_queue);
 out:
 	for (i=0; i<N_DRIVE; i++)
@@ -4572,8 +4571,8 @@
 	int drive;
 		
 	platform_device_unregister(&floppy_device);
-	blk_unregister_region(MKDEV(MAJOR_NR, 0), 256);
-	unregister_blkdev(MAJOR_NR, "fd");
+	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
+	unregister_blkdev(FLOPPY_MAJOR, "fd");
 	for (drive = 0; drive < N_DRIVE; drive++) {
 		if ((allowed_drive_mask & (1 << drive)) &&
 		    fdc_state[FDC(drive)].version != FDC_NONE) {
===== drivers/block/loop.c 1.77 vs edited =====
--- 1.77/drivers/block/loop.c	Mon Dec  2 23:25:03 2002
+++ edited/drivers/block/loop.c	Thu Dec  5 15:52:06 2002
@@ -79,8 +79,6 @@
 
 #include <asm/uaccess.h>
 
-#define MAJOR_NR LOOP_MAJOR
-
 static int max_loop = 8;
 static struct loop_device *loop_dev;
 static struct gendisk **disks;
@@ -1015,9 +1013,9 @@
 		max_loop = 8;
 	}
 
-	if (register_blkdev(MAJOR_NR, "loop", &lo_fops)) {
+	if (register_blkdev(LOOP_MAJOR, "loop", &lo_fops)) {
 		printk(KERN_WARNING "Unable to get major number %d for loop"
-				    " device\n", MAJOR_NR);
+				    " device\n", LOOP_MAJOR);
 		return -EIO;
 	}
 
@@ -1082,7 +1080,7 @@
 		devfs_remove("loop/%d", i);
 	}
 	devfs_remove("loop");
-	if (unregister_blkdev(MAJOR_NR, "loop"))
+	if (unregister_blkdev(LOOP_MAJOR, "loop"))
 		printk(KERN_WARNING "loop: cannot unregister blkdev\n");
 
 	kfree(disks);
===== drivers/block/nbd.c 1.44 vs edited =====
--- 1.44/drivers/block/nbd.c	Mon Dec  2 23:27:16 2002
+++ edited/drivers/block/nbd.c	Thu Dec  5 16:03:11 2002
@@ -53,7 +53,6 @@
 #include <asm/uaccess.h>
 #include <asm/types.h>
 
-#define MAJOR_NR NBD_MAJOR
 #include <linux/nbd.h>
 
 #define LO_MAGIC 0x68797548
@@ -69,6 +68,29 @@
 static int requests_in;
 static int requests_out;
 
+static void nbd_end_request(struct request *req)
+{
+	int uptodate = (req->errors == 0) ? 1 : 0;
+	request_queue_t *q = req->q;
+	struct bio *bio;
+	unsigned nsect;
+	unsigned long flags;
+
+#ifdef PARANOIA
+	requests_out++;
+#endif
+	spin_lock_irqsave(q->queue_lock, flags);
+	while((bio = req->bio) != NULL) {
+		nsect = bio_sectors(bio);
+		blk_finished_io(nsect);
+		req->bio = bio->bi_next;
+		bio->bi_next = NULL;
+		bio_endio(bio, nsect << 9, uptodate ? 0 : -EIO);
+	}
+	blk_put_request(req);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+
 static int nbd_open(struct inode *inode, struct file *file)
 {
 	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
@@ -538,14 +560,14 @@
 		nbd_dev[i].disk = disk;
 	}
 
-	if (register_blkdev(MAJOR_NR, "nbd", &nbd_fops)) {
+	if (register_blkdev(NBD_MAJOR, "nbd", &nbd_fops)) {
 		printk("Unable to get major number %d for NBD\n",
-		       MAJOR_NR);
+		       NBD_MAJOR);
 		err = -EIO;
 		goto out;
 	}
 #ifdef MODULE
-	printk("nbd: registered device at major %d\n", MAJOR_NR);
+	printk("nbd: registered device at major %d\n", NBD_MAJOR);
 #endif
 	blk_init_queue(&nbd_queue, do_nbd_request, &nbd_lock);
 	devfs_mk_dir (NULL, "nbd", NULL);
@@ -562,7 +584,7 @@
 		nbd_dev[i].blksize = 1024;
 		nbd_dev[i].blksize_bits = 10;
 		nbd_dev[i].bytesize = ((u64)0x7ffffc00) << 10; /* 2TB */
-		disk->major = MAJOR_NR;
+		disk->major = NBD_MAJOR;
 		disk->first_minor = i;
 		disk->fops = &nbd_fops;
 		disk->private_data = &nbd_dev[i];
@@ -593,7 +615,7 @@
 	}
 	devfs_remove("nbd");
 	blk_cleanup_queue(&nbd_queue);
-	unregister_blkdev(MAJOR_NR, "nbd");
+	unregister_blkdev(NBD_MAJOR, "nbd");
 }
 
 module_init(nbd_init);
===== drivers/block/ps2esdi.c 1.60 vs edited =====
--- 1.60/drivers/block/ps2esdi.c	Sun Nov 17 18:10:40 2002
+++ edited/drivers/block/ps2esdi.c	Thu Dec  5 15:58:13 2002
@@ -27,15 +27,10 @@
    + reset after read/write error
  */
 
-#include <linux/config.h>
-#include <linux/major.h>
-
-#ifdef  CONFIG_BLK_DEV_PS2
-
-#define MAJOR_NR PS2ESDI_MAJOR
 #define DEVICE_NAME "PS/2 ESDI"
-#define DEVICE_NR(device) (minor(device) >> 6)
 
+#include <linux/config.h>
+#include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/wait.h>
 #include <linux/interrupt.h>
@@ -153,8 +148,9 @@
 
 	/* register the device - pass the name, major number and operations
 	   vector .                                                 */
-	if (register_blkdev(MAJOR_NR, "ed", &ps2esdi_fops)) {
-		printk("%s: Unable to get major number %d\n", DEVICE_NAME, MAJOR_NR);
+	if (register_blkdev(PS2ESDI_MAJOR, "ed", &ps2esdi_fops)) {
+		printk("%s: Unable to get major number %d\n", DEVICE_NAME,
+				PS2ESDI_MAJOR);
 		return -1;
 	}
 	/* set up some global information - indicating device specific info */
@@ -165,7 +161,7 @@
 	if (error) {
 		printk(KERN_WARNING "PS2ESDI: error initialising"
 			" device, releasing resources\n");
-		unregister_blkdev(MAJOR_NR, "ed");
+		unregister_blkdev(PS2ESDI_MAJOR, "ed");
 		blk_cleanup_queue(&ps2esdi_queue);
 		return error;
 	}
@@ -214,7 +210,7 @@
 	release_region(io_base, 4);
 	free_dma(dma_arb_level);
 	free_irq(PS2ESDI_IRQ, &ps2esdi_gendisk);
-	unregister_blkdev(MAJOR_NR, "ed");
+	unregister_blkdev(PS2ESDI_MAJOR, "ed");
 	blk_cleanup_queue(&ps2esdi_queue);
 	for (i = 0; i < ps2esdi_drives; i++) {
 		del_gendisk(ps2esdi_gendisk[i]);
@@ -421,7 +417,7 @@
 		struct gendisk *disk = alloc_disk(64);
 		if (!disk)
 			goto err_out4;
-		disk->major = MAJOR_NR;
+		disk->major = PS2ESDI_MAJOR;
 		disk->first_minor = i<<6;
 		sprintf(disk->disk_name, "ed%c", 'a'+i);
 		disk->fops = &ps2esdi_fops;
@@ -1090,5 +1086,3 @@
 	}
 	wake_up(&ps2esdi_int);
 }
-
-#endif
===== drivers/block/rd.c 1.66 vs edited =====
--- 1.66/drivers/block/rd.c	Tue Dec  3 18:15:02 2002
+++ edited/drivers/block/rd.c	Thu Dec  5 15:53:53 2002
@@ -52,17 +52,9 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h>		/* for invalidate_bdev() */
 #include <linux/backing-dev.h>
-#include <asm/uaccess.h>
-
-/*
- * 35 has been officially registered as the RAMDISK major number, but
- * so is the original MAJOR number of 1.  We're using 1 in
- * include/linux/major.h for now
- */
-#define MAJOR_NR RAMDISK_MAJOR
-#define DEVICE_NR(device) (minor(device))
 #include <linux/blk.h>
 #include <linux/blkpg.h>
+#include <asm/uaccess.h>
 
 /* The RAM disk size is now a parameter */
 #define NUM_RAMDISKS 16		/* This cannot be overridden (yet) */ 
@@ -386,7 +378,7 @@
 	devfs_remove("rd/initrd");
 #endif
 	devfs_remove("rd");
-	unregister_blkdev( MAJOR_NR, "ramdisk" );
+	unregister_blkdev(RAMDISK_MAJOR, "ramdisk" );
 }
 
 static struct request_queue rd_queue;
@@ -407,7 +399,7 @@
 	initrd_disk = alloc_disk(1);
 	if (!initrd_disk)
 		return -ENOMEM;
-	initrd_disk->major = MAJOR_NR;
+	initrd_disk->major = RAMDISK_MAJOR;
 	initrd_disk->first_minor = INITRD_MINOR;
 	initrd_disk->fops = &rd_bd_op;	
 	sprintf(initrd_disk->disk_name, "initrd");
@@ -418,8 +410,8 @@
 			goto out;
 	}
 
-	if (register_blkdev(MAJOR_NR, "ramdisk", &rd_bd_op)) {
-		printk("RAMDISK: Could not get major %d", MAJOR_NR);
+	if (register_blkdev(RAMDISK_MAJOR, "ramdisk", &rd_bd_op)) {
+		printk("RAMDISK: Could not get major %d", RAMDISK_MAJOR);
 		err = -EIO;
 		goto out;
 	}
@@ -432,7 +424,7 @@
 		struct gendisk *disk = rd_disks[i];
 		char name[16];
 		/* rd_size is given in kB */
-		disk->major = MAJOR_NR;
+		disk->major = RAMDISK_MAJOR;
 		disk->first_minor = i;
 		disk->fops = &rd_bd_op;
 		disk->queue = &rd_queue;
@@ -452,7 +444,7 @@
 	/* We ought to separate initrd operations here */
 	set_capacity(initrd_disk, (initrd_end-initrd_start+511)>>9);
 	add_disk(initrd_disk);
-	devfs_register(NULL, "rd/initrd", DEVFS_FL_DEFAULT, MAJOR_NR,
+	devfs_register(NULL, "rd/initrd", DEVFS_FL_DEFAULT, RAMDISK_MAJOR,
 			INITRD_MINOR, S_IFBLK | S_IRUSR, &rd_bd_op, NULL);
 #endif
 
===== drivers/block/swim3.c 1.21 vs edited =====
--- 1.21/drivers/block/swim3.c	Mon Oct 28 20:57:53 2002
+++ edited/drivers/block/swim3.c	Thu Dec  5 15:57:01 2002
@@ -24,6 +24,8 @@
 #include <linux/delay.h>
 #include <linux/fd.h>
 #include <linux/ioctl.h>
+#include <linux/blk.h>
+#include <linux/devfs_fs_kernel.h>
 #include <asm/io.h>
 #include <asm/dbdma.h>
 #include <asm/prom.h>
@@ -32,11 +34,6 @@
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 
-#define MAJOR_NR	FLOPPY_MAJOR
-#define DEVICE_NAME "floppy"
-#include <linux/blk.h>
-#include <linux/devfs_fs_kernel.h>
-
 static struct request_queue swim3_queue;
 static struct gendisk *disks[2];
 static struct request *fd_req;
@@ -1007,15 +1004,16 @@
 			goto out;
 	}
 
-	if (register_blkdev(MAJOR_NR, "fd", &floppy_fops)) {
-		printk(KERN_ERR"Unable to get major %d for floppy\n", MAJOR_NR);
+	if (register_blkdev(FLOPPY_MAJOR, "fd", &floppy_fops)) {
+		printk(KERN_ERR"Unable to get major %d for floppy\n",
+				FLOPPY_MAJOR);
 		err = -EBUSY;
 		goto out;
 	}
 	blk_init_queue(&swim3_queue, do_fd_request, &swim3_lock);
 	for (i = 0; i < floppy_count; i++) {
 		struct gendisk *disk = disks[i];
-		disk->major = MAJOR_NR;
+		disk->major = FLOPPY_MAJOR;
 		disk->first_minor = i;
 		disk->fops = &floppy_fops;
 		disk->private_data = &floppy_states[i];
@@ -1102,7 +1100,7 @@
 	sprintf(floppy_name, "%s%d", floppy_devfs_handle ? "" : "floppy",
 			floppy_count);
 	floppy_handle = devfs_register(floppy_devfs_handle, floppy_name, 
-			DEVFS_FL_DEFAULT, MAJOR_NR, floppy_count, 
+			DEVFS_FL_DEFAULT, FLOPPY_MAJOR, floppy_count, 
 			S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |S_IWGRP, 
 			&floppy_fops, NULL);
 
===== drivers/block/swim_iop.c 1.20 vs edited =====
--- 1.20/drivers/block/swim_iop.c	Mon Nov  4 21:01:19 2002
+++ edited/drivers/block/swim_iop.c	Thu Dec  5 15:56:16 2002
@@ -78,9 +78,6 @@
 static struct floppy_state floppy_states[MAX_FLOPPIES];
 static spinlock_t swim_iop_lock = SPIN_LOCK_UNLOCKED;
 
-#define MAJOR_NR  FLOPPY_MAJOR
-#define DEVICE_NAME "floppy"
-#define QUEUE (&swim_queue)
 #define CURRENT elv_next_request(&swim_queue)
 
 static char *drive_names[7] = {
@@ -142,9 +139,9 @@
 
 	if (!iop_ism_present) return -ENODEV;
 
-	if (register_blkdev(MAJOR_NR, "fd", &floppy_fops)) {
+	if (register_blkdev(FLOPPY_MAJOR, "fd", &floppy_fops)) {
 		printk(KERN_ERR "SWIM-IOP: Unable to get major %d for floppy\n",
-		       MAJOR_NR);
+		       FLOPPY_MAJOR);
 		return -EBUSY;
 	}
 	blk_init_queue(&swim_queue, do_fd_request, &swim_iop_lock);
@@ -190,7 +187,7 @@
 		struct gendisk *disk = alloc_disk(1);
 		if (!disk)
 			continue;
-		disk->major = MAJOR_NR;
+		disk->major = FLOPPY_MAJOR;
 		disk->first_minor = i;
 		disk->fops = &floppy_fops;
 		sprintf(disk->disk_name, "fd%d", i);
@@ -523,9 +520,9 @@
 		wake_up(&fs->wait);
 		return;
 	}
-	while (!blk_queue_empty(QUEUE) && fs->state == idle) {
+	while (!blk_queue_empty(&swim_queue) && fs->state == idle) {
 		if (CURRENT->bh && !buffer_locked(CURRENT->bh))
-			panic(DEVICE_NAME ": block not locked");
+			panic("floppy: block not locked");
 #if 0
 		printk("do_fd_req: dev=%s cmd=%d sec=%ld nr_sec=%ld buf=%p\n",
 		       CURRENT->rq_disk->disk_name, CURRENT->cmd,
===== drivers/block/umem.c 1.32 vs edited =====
--- 1.32/drivers/block/umem.c	Tue Dec  3 19:05:29 2002
+++ edited/drivers/block/umem.c	Thu Dec  5 15:52:25 2002
@@ -97,7 +97,6 @@
 static int pci_cmds;
 
 static int major_nr;
-#define MAJOR_NR	(major_nr)
 
 #include <linux/blk.h>
 #include <linux/blkpg.h>
@@ -1177,7 +1176,7 @@
 	return 0;
 
 out:
-	unregister_blkdev(MAJOR_NR, "umem");
+	unregister_blkdev(major_nr, "umem");
 	while (i--)
 		put_disk(mm_gendisk[i]);
 	return -ENOMEM;
@@ -1201,7 +1200,7 @@
 
 	pci_unregister_driver(&mm_pci_driver);
 
-	unregister_blkdev(MAJOR_NR, "umem");
+	unregister_blkdev(major_nr, "umem");
 }
 
 module_init(mm_init);
===== drivers/block/xd.c 1.48 vs edited =====
--- 1.48/drivers/block/xd.c	Tue Dec  3 19:05:54 2002
+++ edited/drivers/block/xd.c	Thu Dec  5 15:53:02 2002
@@ -46,16 +46,14 @@
 #include <linux/init.h>
 #include <linux/wait.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/blk.h>
+#include <linux/blkpg.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/dma.h>
 
-#define MAJOR_NR XT_DISK_MAJOR
-#include <linux/blk.h>
-#include <linux/blkpg.h>
-
 #include "xd.h"
 
 static void __init do_xd_setup (int *integers);
@@ -172,8 +170,8 @@
 	}
 
 	err = -EBUSY;
-	if (register_blkdev(MAJOR_NR,"xd",&xd_fops)) {
-		printk("xd: Unable to get major number %d\n",MAJOR_NR);
+	if (register_blkdev(XT_DISK_MAJOR,"xd",&xd_fops)) {
+		printk("xd: Unable to get major number %d\n",XT_DISK_MAJOR);
 		goto out1;
 	}
 	devfs_mk_dir(NULL, "xd", NULL);
@@ -205,7 +203,7 @@
 		if (!disk)
 			goto Enomem;
 		p->unit = i;
-		disk->major = MAJOR_NR;
+		disk->major = XT_DISK_MAJOR;
 		disk->first_minor = i<<6;
 		sprintf(disk->disk_name, "xd%c", i+'a');
 		disk->fops = &xd_fops;
@@ -246,7 +244,7 @@
 out2:
 	devfs_remove("xd");
 	blk_cleanup_queue(&xd_queue);
-	unregister_blkdev(MAJOR_NR, "xd");
+	unregister_blkdev(XT_DISK_MAJOR, "xd");
 out1:
 	if (xd_dma_buffer)
 		xd_dma_mem_free((unsigned long)xd_dma_buffer,
@@ -1047,7 +1045,7 @@
 void cleanup_module(void)
 {
 	int i;
-	unregister_blkdev(MAJOR_NR, "xd");
+	unregister_blkdev(XT_DISK_MAJOR, "xd");
 	for (i = 0; i < xd_drives; i++) {
 		del_gendisk(xd_gendisk[i]);
 		put_disk(xd_gendisk[i]);
===== drivers/block/z2ram.c 1.19 vs edited =====
--- 1.19/drivers/block/z2ram.c	Tue Oct  8 00:21:22 2002
+++ edited/drivers/block/z2ram.c	Thu Dec  5 15:55:08 2002
@@ -25,9 +25,7 @@
 ** implied warranty.
 */
 
-#define MAJOR_NR    Z2RAM_MAJOR
 #define DEVICE_NAME "Z2RAM"
-#define DEVICE_NR(device) (minor(device))
 
 #include <linux/major.h>
 #include <linux/slab.h>
@@ -155,7 +153,7 @@
 	sizeof( z2ram_map[0] );
     int rc = -ENOMEM;
 
-    device = DEVICE_NR( inode->i_rdev );
+    device = minor( inode->i_rdev );
 
     if ( current_device != -1 && current_device != device )
     {
@@ -341,18 +339,18 @@
     if ( !MACH_IS_AMIGA )
 	return -ENXIO;
 
-    if ( register_blkdev( MAJOR_NR, DEVICE_NAME, &z2_fops ) )
+    if ( register_blkdev( Z2RAM_MAJOR, DEVICE_NAME, &z2_fops ) )
     {
 	printk( KERN_ERR DEVICE_NAME ": Unable to get major %d\n",
-	    MAJOR_NR );
+	    Z2RAM_MAJOR );
 	return -EBUSY;
     }
     z2ram_gendisk = alloc_disk(1);
     if (!z2ram_gendisk) {
-	unregister_blkdev( MAJOR_NR, DEVICE_NAME );
+	unregister_blkdev( Z2RAM_MAJOR, DEVICE_NAME );
 	return -ENOMEM;
     }
-    z2ram_gendisk->major = MAJOR_NR;
+    z2ram_gendisk->major = Z2RAM_MAJOR;
     z2ram_gendisk->first_minor = 0;
     z2ram_gendisk->fops = &z2_fops;
     sprintf(z2ram_gendisk->disk_name, "z2ram");
@@ -360,7 +358,7 @@
     blk_init_queue(&z2_queue, do_z2_request, &z2ram_lock);
     z2ram_gendisk->queue = &z2_queue;
     add_disk(z2ram_gendisk);
-    blk_register_region(MKDEV(MAJOR_NR, 0), Z2MINOR_COUNT, THIS_MODULE,
+    blk_register_region(MKDEV(Z2RAM_MAJOR, 0), Z2MINOR_COUNT, THIS_MODULE,
 				z2_find, NULL, NULL);
 
     return 0;
@@ -388,8 +386,8 @@
 cleanup_module( void )
 {
     int i, j;
-    blk_unregister_region(MKDEV(MAJOR_NR, 0), 256);
-    if ( unregister_blkdev( MAJOR_NR, DEVICE_NAME ) != 0 )
+    blk_unregister_region(MKDEV(Z2RAM_MAJOR, 0), 256);
+    if ( unregister_blkdev( Z2RAM_MAJOR, DEVICE_NAME ) != 0 )
 	printk( KERN_ERR DEVICE_NAME ": unregister of device failed\n");
 
     del_gendisk(z2ram_gendisk);
===== drivers/block/paride/pcd.c 1.30 vs edited =====
--- 1.30/drivers/block/paride/pcd.c	Fri Oct 18 12:55:27 2002
+++ edited/drivers/block/paride/pcd.c	Thu Dec  5 16:07:02 2002
@@ -137,7 +137,7 @@
 #include <linux/delay.h>
 #include <linux/cdrom.h>
 #include <linux/spinlock.h>
-
+#include <linux/blk.h>
 #include <asm/uaccess.h>
 
 static spinlock_t pcd_lock;
@@ -172,13 +172,6 @@
 MODULE_PARM(drive3, "1-6i");
 
 #include "paride.h"
-
-/* set up defines for blk.h,  why don't all drivers do it this way ? */
-
-#define MAJOR_NR	major
-
-#include <linux/blk.h>
-
 #include "pseudo.h"
 
 #define PCD_RETRIES	     5
@@ -949,8 +942,8 @@
 	/* get the atapi capabilities page */
 	pcd_probe_capabilities();
 
-	if (register_blkdev(MAJOR_NR, name, &pcd_bdops)) {
-		printk("pcd: unable to get major number %d\n", MAJOR_NR);
+	if (register_blkdev(major, name, &pcd_bdops)) {
+		printk("pcd: unable to get major number %d\n", major);
 		for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++)
 			put_disk(cd->disk);
 		return -1;
@@ -984,7 +977,7 @@
 		put_disk(cd->disk);
 	}
 	blk_cleanup_queue(&pcd_queue);
-	unregister_blkdev(MAJOR_NR, name);
+	unregister_blkdev(major, name);
 }
 
 MODULE_LICENSE("GPL");
===== drivers/block/paride/pd.c 1.45 vs edited =====
--- 1.45/drivers/block/paride/pd.c	Fri Oct 18 12:55:27 2002
+++ edited/drivers/block/paride/pd.c	Thu Dec  5 16:07:21 2002
@@ -150,7 +150,8 @@
 #include <linux/delay.h>
 #include <linux/hdreg.h>
 #include <linux/cdrom.h>	/* for the eject ioctl */
-
+#include <linux/blk.h>
+#include <linux/blkpg.h>
 #include <asm/uaccess.h>
 
 static spinlock_t pd_lock = SPIN_LOCK_UNLOCKED;
@@ -187,12 +188,6 @@
 MODULE_PARM(drive3, "1-8i");
 
 #include "paride.h"
-
-#define MAJOR_NR   major
-
-#include <linux/blk.h>
-#include <linux/blkpg.h>
-
 #include "pseudo.h"
 
 #define PD_BITS    4
@@ -895,7 +890,7 @@
 {
 	if (disable)
 		return -1;
-	if (register_blkdev(MAJOR_NR, name, &pd_fops)) {
+	if (register_blkdev(major, name, &pd_fops)) {
 		printk("%s: unable to get major number %d\n", name, major);
 		return -1;
 	}
@@ -906,7 +901,7 @@
 	       name, name, PD_VERSION, major, cluster, nice);
 	pd_init_units();
 	if (!pd_detect()) {
-		unregister_blkdev(MAJOR_NR, name);
+		unregister_blkdev(major, name);
 		return -1;
 	}
 	return 0;
@@ -916,7 +911,7 @@
 {
 	struct pd_unit *disk;
 	int unit;
-	unregister_blkdev(MAJOR_NR, name);
+	unregister_blkdev(major, name);
 	for (unit = 0, disk = pd; unit < PD_UNITS; unit++, disk++) {
 		if (disk->present) {
 			struct gendisk *p = disk->gd;
===== drivers/block/paride/pf.c 1.36 vs edited =====
--- 1.36/drivers/block/paride/pf.c	Fri Oct 18 12:55:27 2002
+++ edited/drivers/block/paride/pf.c	Thu Dec  5 16:06:39 2002
@@ -150,7 +150,8 @@
 #include <linux/hdreg.h>
 #include <linux/cdrom.h>
 #include <linux/spinlock.h>
-
+#include <linux/blk.h>
+#include <linux/blkpg.h>
 #include <asm/uaccess.h>
 
 static spinlock_t pf_spin_lock;
@@ -187,14 +188,6 @@
 MODULE_PARM(drive3, "1-7i");
 
 #include "paride.h"
-
-/* set up defines for blk.h,  why don't all drivers do it this way ? */
-
-#define MAJOR_NR   major
-
-#include <linux/blk.h>
-#include <linux/blkpg.h>
-
 #include "pseudo.h"
 
 /* constants for faking geometry numbers */
@@ -316,7 +309,7 @@
 		pf->drive = (*drives[unit])[D_SLV];
 		pf->lun = (*drives[unit])[D_LUN];
 		snprintf(pf->name, PF_NAMELEN, "%s%d", name, unit);
-		disk->major = MAJOR_NR;
+		disk->major = major;
 		disk->first_minor = unit;
 		strcpy(disk->disk_name, pf->name);
 		disk->fops = &pf_fops;
@@ -964,7 +957,7 @@
 		return -1;
 	pf_busy = 0;
 
-	if (register_blkdev(MAJOR_NR, name, &pf_fops)) {
+	if (register_blkdev(major, name, &pf_fops)) {
 		printk("pf_init: unable to get major number %d\n", major);
 		for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++)
 			put_disk(pf->disk);
@@ -989,7 +982,7 @@
 {
 	struct pf_unit *pf;
 	int unit;
-	unregister_blkdev(MAJOR_NR, name);
+	unregister_blkdev(major, name);
 	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
 		if (!pf->present)
 			continue;
--- 1.14/include/linux/nbd.h	Fri Oct 18 23:35:43 2002
+++ edited/include/linux/nbd.h	Thu Dec  5 16:00:40 2002
@@ -26,13 +26,6 @@
 	NBD_CMD_DISC = 2
 };
 
-#ifdef MAJOR_NR
-
-#include <asm/semaphore.h>
-
-#define LOCAL_END_REQUEST
-
-#include <linux/blk.h>
 
 #ifdef PARANOIA
 extern int requests_in;
@@ -40,30 +33,6 @@
 #endif
 
 #define nbd_cmd(req) ((req)->cmd[0])
-
-static void
-nbd_end_request(struct request *req)
-{
-	struct bio *bio;
-	unsigned nsect;
-	unsigned long flags;
-	int uptodate = (req->errors == 0) ? 1 : 0;
-	request_queue_t *q = req->q;
-
-#ifdef PARANOIA
-	requests_out++;
-#endif
-	spin_lock_irqsave(q->queue_lock, flags);
-	while((bio = req->bio) != NULL) {
-		nsect = bio_sectors(bio);
-		blk_finished_io(nsect);
-		req->bio = bio->bi_next;
-		bio->bi_next = NULL;
-		bio_endio(bio, nsect << 9, uptodate ? 0 : -EIO);
-	}
-	blk_put_request(req);
-	spin_unlock_irqrestore(q->queue_lock, flags);
-}
 
 #define MAX_NBD 128
 


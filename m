Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTL3VKf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 16:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265116AbTL3VKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 16:10:35 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:22946 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S263930AbTL3VJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 16:09:42 -0500
Message-ID: <33109.209.251.159.140.1072818582.squirrel@mail.mainstreetsoftworks.com>
Date: Tue, 30 Dec 2003 16:09:42 -0500 (EST)
Subject: Re: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
From: "Brad House" <brad_mssw@gentoo.org>
To: <sflory@rackable.com>
In-Reply-To: <3FF1D7EE.5050603@rackable.com>
References: <65095.68.105.173.45.1072761027.squirrel@mail.mainstreetsoftworks.com>
        <20031230052041.GA7007@gtf.org>
        <65025.68.105.173.45.1072765590.squirrel@mail.mainstreetsoftworks.com>
        <3FF11CC2.7040209@pobox.com>
        <3FF1D567.4040205@rackable.com>
        <33036.209.251.159.140.1072813780.squirrel@mail.mainstreetsoftworks.com>
        <3FF1D7EE.5050603@rackable.com>
X-Priority: 3
Importance: Normal
Cc: <brad_mssw@gentoo.org>, <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>, <Atul.Mukker@lsil.com>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I just ported the 2.00.9 driver to 2.6.0.
It still has these warnings during compilation as I did not
attempt to apply my 64bit fixes from before as I've been told
they are just plain wrong :/

But, I suppose this should work fine in 32bit mode, I would
greatly appreciate any help in porting it for 64bit platforms.

The patch can be downloaded here :
http://dev.gentoo.org/~brad_mssw/kernel_patches/megaraid/megaraid-v2.00.9-linux2.6.patch
And only applies to the source from ftp.lsil.com, it's not a kernel-patch
per-se, but copying the result over to the drivers/scsi  will compile inplace
of the current versions.

Please CC me on any replies!
-Brad House <brad_mssw@gentoo.org>

I've also inlined it here:
# To use this patch, you must extract the megaraid 2.00.9 tarball
# from
ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.00.9/megaraid.tgz
# and   mv megaraid2.c megaraid.c
#       mv megaraid2.h megaraid.h
# Then
#       patch -p1 < megaraid-v2.00.9-linux2.6.patch
# This patch is based off the v2.00.5 linux2.5.6x patch from
#
ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.00.5/megaraid2005-2.5.6x.patch.gz
# TODO: - Figure out if megaraid_isr_iomapped and megaraid_isr_memmapped
are implemented
#         correctly
#       - Make it 64bit clean, as it gets 'cast to pointer from integer of
different size'
#         warnings
# Brad House <brad_mssw@gentoo.org> 12/30/03
diff -ruN megaraid-v2.00.9/megaraid.c megaraid-v2.00.9-linux2.6/megaraid.c
--- megaraid-v2.00.9/megaraid.c	2003-09-09 15:24:36.000000000 -0400
+++ megaraid-v2.00.9-linux2.6/megaraid.c	2003-12-30 16:18:06.298221000 -0500
@@ -32,18 +32,20 @@

 #include <linux/mm.h>
 #include <linux/fs.h>
-#include <linux/blk.h>
+#include <linux/blkdev.h>
 #include <asm/uaccess.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/module.h>
 #include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/proc_fs.h>
+#include <scsi/scsicam.h>

-#include "sd.h"
 #include "scsi.h"
 #include "hosts.h"

-#include "megaraid2.h"
+#include "megaraid.h"

 MODULE_AUTHOR ("LSI Logic Corporation");
 MODULE_DESCRIPTION ("LSI Logic MegaRAID driver");
@@ -88,10 +90,10 @@
  * The File Operations structure for the serial/ioctl interface of the
driver
  */
 static struct file_operations megadev_fops = {
+	.owner		= THIS_MODULE,
 	.ioctl		= megadev_ioctl,
 	.open		= megadev_open,
 	.release	= megadev_close,
-	.owner		= THIS_MODULE,
 };

 /*
@@ -174,11 +176,6 @@
 	}

 	if(hba_count) {
-		/*
-		 * re-order hosts so that one with bootable logical drive
-		 * comes first
-		 */
-		mega_reorder_hosts();

 #ifdef CONFIG_PROC_FS
 		mega_proc_dir_entry = proc_mkdir("megaraid", &proc_root);
@@ -320,13 +317,12 @@

 		if( pci_resource_flags(pdev, 0) & IORESOURCE_MEM ) {

-			if( check_mem_region(mega_baseport, 128) ) {
+			if (!request_mem_region(mega_baseport, 128,
+					"MegaRAID: LSI Logic Corporation.")) {
 				printk(KERN_WARNING
 					"megaraid: mem region busy!\n");
 				continue;
 			}
-			request_mem_region(mega_baseport, 128,
-					"MegaRAID: LSI Logic Corporation.");

 			mega_baseport =
 				(unsigned long)ioremap(mega_baseport, 128);
@@ -362,7 +358,7 @@

 		did_scsi_reg_f = 1;

-		scsi_set_pci_device(host, pdev);
+		scsi_set_device(host, &pdev->dev);

 		adapter = (adapter_t *)host->hostdata;
 		memset(adapter, 0, sizeof(adapter_t));
@@ -400,7 +396,7 @@
 		// the lock in host structure.
 		adapter->host_lock = &adapter->lock;

-		host->lock = adapter->host_lock;
+		scsi_assign_lock(host, adapter->host_lock);

 		host->cmd_per_lun = max_cmd_per_lun;
 		host->max_sectors = max_sectors_per_io;
@@ -926,7 +922,7 @@
 	scb_t	*scb;
 	int	busy=0;

-	adapter = (adapter_t *)scmd->host->hostdata;
+	adapter = (adapter_t *)scmd->device->host->hostdata;

 	scmd->scsi_done = done;

@@ -1000,7 +996,7 @@
 	/*
 	 * We know what channels our logical drives are on - mega_find_card()
 	 */
-	islogical = adapter->logdrv_chan[cmd->channel];
+	islogical = adapter->logdrv_chan[cmd->device->channel];

 	/*
 	 * The theory: If physical drive is chosen for boot, all the physical
@@ -1012,12 +1008,13 @@
 	if( adapter->boot_pdrv_enabled ) {
 		if( islogical ) {
 			/* logical channel */
-			channel = cmd->channel -
+			channel = cmd->device->channel -
 				adapter->product_info.nchannels;
 		}
 		else {
-			channel = cmd->channel; /* this is physical channel */
-			target = cmd->target;
+			/* this is physical channel */
+			channel = cmd->device->channel;
+			target = cmd->device->id;

 			/*
 			 * boot from a physical disk, that disk needs to be
@@ -1034,13 +1031,13 @@
 	}
 	else {
 		if( islogical ) {
-			channel = cmd->channel;	/* this is the logical channel
-						 */
+			/* this is the logical channel */
+			channel = cmd->device->channel;
 		}
 		else {
-			channel = cmd->channel - NVIRT_CHAN;	/* physical
-								   channel */
-			target = cmd->target;
+			/* physical channel */
+			channel = cmd->device->channel - NVIRT_CHAN;
+			target = cmd->device->id;
 		}
 	}

@@ -1048,7 +1045,7 @@
 	if(islogical) {

 		/* have just LUN 0 for each target on virtual channels */
-		if (cmd->lun) {
+		if (cmd->device->lun) {
 			cmd->result = (DID_BAD_TARGET << 16);
 			cmd->scsi_done(cmd);
 			return NULL;
@@ -1075,7 +1072,7 @@

 	}
 	else {
-		if( cmd->lun > 7) {
+		if( cmd->device->lun > 7) {
 			/*
 			 * Do not support lun >7 for physically accessed
 			 * devices
@@ -1138,15 +1135,15 @@
 		case READ_CAPACITY:
 		case INQUIRY:

-			if(!(adapter->flag & (1L << cmd->channel))) {
+			if(!(adapter->flag & (1L << cmd->device->channel))) {

 				printk(KERN_NOTICE
 					"scsi%d: scanning scsi channel %d ",
 						adapter->host->host_no,
-						cmd->channel);
+						cmd->device->channel);
 				printk("for logical drives.\n");

-				adapter->flag |= (1L << cmd->channel);
+				adapter->flag |= (1L << cmd->device->channel);
 			}

 			/* Allocate a SCB and initialize passthru */
@@ -1448,7 +1445,7 @@
 		(channel << 4) | target : target;

 	pthru->cdblen = cmd->cmd_len;
-	pthru->logdrv = cmd->lun;
+	pthru->logdrv = cmd->device->lun;

 	memcpy(pthru->cdb, cmd->cmnd, cmd->cmd_len);

@@ -1459,15 +1456,15 @@
 	switch (cmd->cmnd[0]) {
 	case INQUIRY:
 	case READ_CAPACITY:
-		if(!(adapter->flag & (1L << cmd->channel))) {
+		if(!(adapter->flag & (1L << cmd->device->channel))) {

 			printk(KERN_NOTICE
 				"scsi%d: scanning scsi channel %d [P%d] ",
 					adapter->host->host_no,
-					cmd->channel, channel);
+					cmd->device->channel, channel);
 			printk("for physical devices.\n");

-			adapter->flag |= (1L << cmd->channel);
+			adapter->flag |= (1L << cmd->device->channel);
 		}
 		/* Fall through */
 	default:
@@ -1511,7 +1508,7 @@
 		(channel << 4) | target : target;

 	epthru->cdblen = cmd->cmd_len;
-	epthru->logdrv = cmd->lun;
+	epthru->logdrv = cmd->device->lun;

 	memcpy(epthru->cdb, cmd->cmnd, cmd->cmd_len);

@@ -1521,15 +1518,15 @@
 	switch(cmd->cmnd[0]) {
 	case INQUIRY:
 	case READ_CAPACITY:
-		if(!(adapter->flag & (1L << cmd->channel))) {
+		if(!(adapter->flag & (1L << cmd->device->channel))) {

 			printk(KERN_NOTICE
 				"scsi%d: scanning scsi channel %d [P%d] ",
 					adapter->host->host_no,
-					cmd->channel, channel);
+					cmd->device->channel, channel);
 			printk("for physical devices.\n");

-			adapter->flag |= (1L << cmd->channel);
+			adapter->flag |= (1L << cmd->device->channel);
 		}
 		/* Fall through */
 	default:
@@ -1791,7 +1788,7 @@
  * Find out if our device is interrupting. If yes, acknowledge the interrupt
  * and service the completed commands.
  */
-static void
+static irqreturn_t
 megaraid_isr_iomapped(int irq, void *devp, struct pt_regs *regs)
 {
 	adapter_t	*adapter = devp;
@@ -1809,7 +1806,7 @@

 	spin_unlock_irqrestore(adapter->host_lock, flags);

-	return;
+	return IRQ_RETVAL(1);
 }


@@ -1885,7 +1882,7 @@
  * Find out if our device is interrupting. If yes, acknowledge the interrupt
  * and service the completed commands.
  */
-static void
+static irqreturn_t
 megaraid_isr_memmapped(int irq, void *devp, struct pt_regs *regs)
 {
 	adapter_t	*adapter = devp;
@@ -1903,7 +1900,7 @@

 	spin_unlock_irqrestore(adapter->host_lock, flags);

-	return;
+	return IRQ_RETVAL(1);
 }


@@ -1993,6 +1990,7 @@
 	mbox_t	*mbox = NULL;
 	u8	c;
 	scb_t	*scb;
+	int	islogical;
 	int	cmdid;
 	int	i;

@@ -2074,9 +2072,9 @@
 #if MEGA_HAVE_STATS
 			{

-			int	islogical = adapter->logdrv_chan[cmd->channel];
 			int	logdrv = mbox->logdrv;

+			islogical = adapter->logdrv_chan[cmd->device->channel];
 			/*
 			 * Maintain an error counter for the logical drive.
 			 * Some application like SNMP agent need such
@@ -2112,23 +2110,31 @@
 		 * hard disk and not logical, request should return failure! -
 		 * PJ
 		 */
-		if(cmd->cmnd[0] == INQUIRY) {
-			int islogical = adapter->logdrv_chan[cmd->channel];
+		islogical = adapter->logdrv_chan[cmd->device->channel];
+		if( cmd->cmnd[0] == INQUIRY && !islogical ) {

-			if(!islogical) {
-				if( cmd->use_sg ) {
-					sgl = (struct scatterlist *)
-						cmd->request_buffer;
-					c = *(u8 *)sgl[0].address;
+			if( cmd->use_sg ) {
+				sgl = (struct scatterlist *)
+					cmd->request_buffer;
+
+				if( sgl->page ) {
+					c = *(unsigned char *)
+					page_address((&sgl[0])->page) +
+					(&sgl[0])->offset;
 				}
 				else {
-					c = *(u8 *)cmd->request_buffer;
+					printk(KERN_WARNING
+						"megaraid: invalid sg.\n");
+					c = 0;
 				}
+			}
+			else {
+				c = *(u8 *)cmd->request_buffer;
+			}

-				if(IS_RAID_CH(adapter, cmd->channel) &&
-						((c & 0x1F ) == TYPE_DISK)) {
-					status = 0xF0;
-				}
+			if(IS_RAID_CH(adapter, cmd->device->channel) &&
+					((c & 0x1F ) == TYPE_DISK)) {
+				status = 0xF0;
 			}
 		}

@@ -2245,12 +2251,11 @@
 		break;

 	case MEGA_BULK_DATA:
-		pci_unmap_page(adapter->host->pci_dev, scb->dma_h_bulkdata,
+		pci_unmap_page(adapter->dev, scb->dma_h_bulkdata,
 			scb->cmd->request_bufflen, scb->dma_direction);

 		if( scb->dma_direction == PCI_DMA_FROMDEVICE ) {
-			pci_dma_sync_single(adapter->host->pci_dev,
-					scb->dma_h_bulkdata,
+			pci_dma_sync_single(adapter->dev, scb->dma_h_bulkdata,
 					scb->cmd->request_bufflen,
 					PCI_DMA_FROMDEVICE);
 		}
@@ -2258,12 +2263,11 @@
 		break;

 	case MEGA_SGLIST:
-		pci_unmap_sg(adapter->host->pci_dev, scb->cmd->request_buffer,
+		pci_unmap_sg(adapter->dev, scb->cmd->request_buffer,
 			scb->cmd->use_sg, scb->dma_direction);

 		if( scb->dma_direction == PCI_DMA_FROMDEVICE ) {
-			pci_dma_sync_sg(adapter->host->pci_dev,
-					scb->cmd->request_buffer,
+			pci_dma_sync_sg(adapter->dev, scb->cmd->request_buffer,
 					scb->cmd->use_sg, PCI_DMA_FROMDEVICE);
 		}

@@ -2334,8 +2338,7 @@

 		offset = ((unsigned long)cmd->request_buffer & ~PAGE_MASK);

-		scb->dma_h_bulkdata = pci_map_page(adapter->host->pci_dev,
-						  page, offset,
+		scb->dma_h_bulkdata = pci_map_page(adapter->dev, page, offset,
 						  cmd->request_bufflen,
 						  scb->dma_direction);
 		scb->dma_type = MEGA_BULK_DATA;
@@ -2357,8 +2360,7 @@
 		}

 		if( scb->dma_direction == PCI_DMA_TODEVICE ) {
-			pci_dma_sync_single(adapter->host->pci_dev,
-					scb->dma_h_bulkdata,
+			pci_dma_sync_single(adapter->dev, scb->dma_h_bulkdata,
 					cmd->request_bufflen,
 					PCI_DMA_TODEVICE);
 		}
@@ -2373,7 +2375,7 @@
 	 *
 	 * The number of sg elements returned must not exceed our limit
 	 */
-	sgcnt = pci_map_sg(adapter->host->pci_dev, sgl, cmd->use_sg,
+	sgcnt = pci_map_sg(adapter->dev, sgl, cmd->use_sg,
 			scb->dma_direction);

 	scb->dma_type = MEGA_SGLIST;
@@ -2402,7 +2404,7 @@
 	*len = (u32)cmd->request_bufflen;

 	if( scb->dma_direction == PCI_DMA_TODEVICE ) {
-		pci_dma_sync_sg(adapter->host->pci_dev, sgl, cmd->use_sg,
+		pci_dma_sync_sg(adapter->dev, sgl, cmd->use_sg,
 				PCI_DMA_TODEVICE);
 	}

@@ -2633,19 +2635,6 @@
 	return buffer;
 }

-/* shouldn't be used, but included for completeness */
-static int
-megaraid_command (Scsi_Cmnd *cmd)
-{
-	printk(KERN_WARNING
-	"megaraid critcal error: synchronous interface is not implemented.\n");
-
-	cmd->result = (DID_ERROR << 16);
-	cmd->scsi_done(cmd);
-
-	return 1;
-}
-

 /**
  * megaraid_abort - abort the scsi command
@@ -2663,13 +2652,13 @@
 	long			iter;
 	int			rval = SUCCESS;

-	adapter = (adapter_t *)scp->host->hostdata;
+	adapter = (adapter_t *)scp->device->host->hostdata;

 	ASSERT( spin_is_locked(adapter->host_lock) );

 	printk("megaraid: aborting-%ld cmd=%x <c=%d t=%d l=%d>\n",
-		scp->serial_number, scp->cmnd[0], scp->channel, scp->target,
-		scp->lun);
+		scp->serial_number, scp->cmnd[0], scp->device->channel, scp->device->id,
+		scp->device->lun);


 	list_for_each_safe( pos, next, &adapter->pending_list ) {
@@ -2752,20 +2741,20 @@


 static int
-megaraid_reset(Scsi_Cmnd *cmd)
+megaraid_reset(Scsi_Cmnd *scp)
 {
 	adapter_t	*adapter;
 	megacmd_t	mc;
 	long		iter;
 	int		rval = SUCCESS;

-	adapter = (adapter_t *)cmd->host->hostdata;
+	adapter = (adapter_t *)scp->device->host->hostdata;

 	ASSERT( spin_is_locked(adapter->host_lock) );

 	printk("megaraid: reset-%ld cmd=%x <c=%d t=%d l=%d>\n",
-		cmd->serial_number, cmd->cmnd[0], cmd->channel, cmd->target,
-		cmd->lun);
+		scp->serial_number, scp->cmnd[0], scp->device->channel, scp->device->id,
+		scp->device->lun);


 #if MEGA_HAVE_CLUSTERING
@@ -3866,44 +3855,40 @@
 #endif


+
 /**
  * megaraid_biosparam()
- * @disk
- * @dev
- * @geom
  *
  * Return the disk geometry for a particular disk
- * Input:
- *	Disk *disk - Disk geometry
- *	kdev_t dev - Device node
- *	int *geom  - Returns geometry fields
- *		geom[0] = heads
- *		geom[1] = sectors
- *		geom[2] = cylinders
  */
 static int
-megaraid_biosparam(Disk *disk, kdev_t dev, int *geom)
+megaraid_biosparam(struct scsi_device *sdev, struct block_device *bdev,
+		    sector_t capacity, int geom[])
 {
-	int heads, sectors, cylinders;
-	adapter_t *adapter;
+	adapter_t	*adapter;
+	unsigned char	*bh;
+	int	heads;
+	int	sectors;
+	int	cylinders;
+	int	rval;

 	/* Get pointer to host config structure */
-	adapter = (adapter_t *)disk->device->host->hostdata;
+	adapter = (adapter_t *)sdev->host->hostdata;

-	if (IS_RAID_CH(adapter, disk->device->channel)) {
+	if (IS_RAID_CH(adapter, sdev->channel)) {
 			/* Default heads (64) & sectors (32) */
 			heads = 64;
 			sectors = 32;
-			cylinders = disk->capacity / (heads * sectors);
+			cylinders = (ulong)capacity / (heads * sectors);

 			/*
 			 * Handle extended translation size for logical drives
 			 * > 1Gb
 			 */
-			if (disk->capacity >= 0x200000) {
+			if ((ulong)capacity >= 0x200000) {
 				heads = 255;
 				sectors = 63;
-				cylinders = disk->capacity / (heads * sectors);
+				cylinders = (ulong)capacity / (heads * sectors);
 			}

 			/* return result */
@@ -3912,23 +3897,30 @@
 			geom[2] = cylinders;
 	}
 	else {
-		if( !mega_partsize(disk, dev, geom) )
-			return 0;
+		bh = scsi_bios_ptable(bdev);

-		printk(KERN_WARNING
+		if( bh ) {
+			rval = scsi_partsize(bh, capacity,
+					    &geom[2], &geom[0], &geom[1]);
+			kfree(bh);
+			if( rval != -1 )
+				return rval;
+		}
+
+		printk(KERN_INFO
 		"megaraid: invalid partition on this disk on channel %d\n",
-				disk->device->channel);
+				sdev->channel);

 		/* Default heads (64) & sectors (32) */
 		heads = 64;
 		sectors = 32;
-		cylinders = disk->capacity / (heads * sectors);
+		cylinders = (ulong)capacity / (heads * sectors);

 		/* Handle extended translation size for logical drives > 1Gb */
-		if (disk->capacity >= 0x200000) {
+		if ((ulong)capacity >= 0x200000) {
 			heads = 255;
 			sectors = 63;
-			cylinders = disk->capacity / (heads * sectors);
+			cylinders = (ulong)capacity / (heads * sectors);
 		}

 		/* return result */
@@ -3940,78 +3932,6 @@
 	return 0;
 }

-/*
- * mega_partsize()
- * @disk
- * @geom
- *
- * Purpose : to determine the BIOS mapping used to create the partition
- *	table, storing the results (cyls, hds, and secs) in geom
- *
- * Note:	Code is picked from scsicam.h
- *
- * Returns : -1 on failure, 0 on success.
- */
-static int
-mega_partsize(Disk *disk, kdev_t dev, int *geom)
-{
-	struct buffer_head *bh;
-	struct partition *p, *largest = NULL;
-	int i, largest_cyl;
-	int heads, cyls, sectors;
-	int capacity = disk->capacity;
-
-	int ma = MAJOR(dev);
-	int mi = (MINOR(dev) & ~0xf);
-
-	int block = 1024;
-
-	if (blksize_size[ma])
-		block = blksize_size[ma][mi];
-
-	if (!(bh = bread(MKDEV(ma,mi), 0, block)))
-		return -1;
-
-	if (*(unsigned short *)(bh->b_data + 510) == 0xAA55 ) {
-
-		for (largest_cyl = -1,
-			p = (struct partition *)(0x1BE + bh->b_data), i = 0;
-			i < 4; ++i, ++p) {
-
-			if (!p->sys_ind) continue;
-
-			cyls = p->end_cyl + ((p->end_sector & 0xc0) << 2);
-
-			if (cyls >= largest_cyl) {
-				largest_cyl = cyls;
-				largest = p;
-			}
-		}
-	}
-
-	if (largest) {
-		heads = largest->end_head + 1;
-		sectors = largest->end_sector & 0x3f;
-
-		if (!heads || !sectors) {
-			brelse(bh);
-			return -1;
-		}
-
-		cyls = capacity/(heads * sectors);
-
-		geom[0] = heads;
-		geom[1] = sectors;
-		geom[2] = cyls;
-
-		brelse(bh);
-		return 0;
-	}
-
-	brelse(bh);
-	return -1;
-}
-

 /**
  * megaraid_reboot_notify()
@@ -4181,7 +4101,6 @@
 	 */
 	if( !capable(CAP_SYS_ADMIN) ) return -EACCES;

-	MOD_INC_USE_COUNT;
 	return 0;
 }

@@ -4770,7 +4689,6 @@
 static int
 megadev_close (struct inode *inode, struct file *filep)
 {
-	MOD_DEC_USE_COUNT;
 	return 0;
 }

@@ -5184,7 +5102,7 @@
 	int		tgt;
 	int		ldrv_num;

-	tgt = cmd->target;
+	tgt = cmd->device->id;

 	if ( tgt > adapter->this_id )
 		tgt--;	/* we do not get inquires for initiator id */
@@ -5228,185 +5146,6 @@
 	return ldrv_num;
 }

-
-/**
- * mega_reorder_hosts()
- *
- * Hack: reorder the scsi hosts in mid-layer so that the controller with the
- * boot device on it appears first in the list.
- */
-static void
-mega_reorder_hosts(void)
-{
-	struct Scsi_Host *shpnt;
-	struct Scsi_Host *shone;
-	struct Scsi_Host *shtwo;
-	adapter_t *boot_host;
-	int i;
-
-	/*
-	 * Find the (first) host which has it's BIOS enabled
-	 */
-	boot_host = NULL;
-	for (i = 0; i < MAX_CONTROLLERS; i++) {
-		if (mega_hbas[i].is_bios_enabled) {
-			boot_host = mega_hbas[i].hostdata_addr;
-			break;
-		}
-	}
-
-	if (!boot_host) {
-		printk(KERN_NOTICE "megaraid: no BIOS enabled.\n");
-		return;
-	}
-
-	/*
-	 * Traverse through the list of SCSI hosts for our HBA locations
-	 */
-	shone = shtwo = NULL;
-	for (shpnt = scsi_hostlist; shpnt; shpnt = shpnt->next) {
-		/* Is it one of ours? */
-		for (i = 0; i < MAX_CONTROLLERS; i++) {
-			if ((adapter_t *) shpnt->hostdata ==
-				mega_hbas[i].hostdata_addr) {
-				/* Does this one has BIOS enabled */
-				if (mega_hbas[i].hostdata_addr == boot_host) {
-
-					/* Are we first */
-					if (!shtwo)	/* Yes! */
-						return;
-					else	/* :-( */
-						shone = shpnt;
-				} else {
-					if (!shtwo) {
-						/* were we here before? xchng
-						 * first */
-						shtwo = shpnt;
-					}
-				}
-				break;
-			}
-		}
-		/*
-		 * Have we got the boot host and one which does not have the
-		 * bios enabled.
-		 */
-		if (shone && shtwo)
-			break;
-	}
-	if (shone && shtwo) {
-		mega_swap_hosts (shone, shtwo);
-	}
-
-	return;
-}
-
-
-static void
-mega_swap_hosts (struct Scsi_Host *shone, struct Scsi_Host *shtwo)
-{
-	struct Scsi_Host *prevtoshtwo;
-	struct Scsi_Host *prevtoshone;
-	struct Scsi_Host *save = NULL;
-
-	/* Are these two nodes adjacent */
-	if (shtwo->next == shone) {
-
-		if (shtwo == scsi_hostlist && !shone->next) {
-
-			/* just two nodes */
-			scsi_hostlist = shone;
-			shone->next = shtwo;
-			shtwo->next = NULL;
-		} else if (shtwo == scsi_hostlist) {
-			/* first two nodes of the list */
-
-			scsi_hostlist = shone;
-			shtwo->next = shone->next;
-			scsi_hostlist->next = shtwo;
-		} else if (!shone->next) {
-			/* last two nodes of the list */
-
-			prevtoshtwo = scsi_hostlist;
-
-			while (prevtoshtwo->next != shtwo)
-				prevtoshtwo = prevtoshtwo->next;
-
-			prevtoshtwo->next = shone;
-			shone->next = shtwo;
-			shtwo->next = NULL;
-		} else {
-			prevtoshtwo = scsi_hostlist;
-
-			while (prevtoshtwo->next != shtwo)
-				prevtoshtwo = prevtoshtwo->next;
-
-			prevtoshtwo->next = shone;
-			shtwo->next = shone->next;
-			shone->next = shtwo;
-		}
-
-	} else if (shtwo == scsi_hostlist && !shone->next) {
-		/* shtwo at head, shone at tail, not adjacent */
-
-		prevtoshone = scsi_hostlist;
-
-		while (prevtoshone->next != shone)
-			prevtoshone = prevtoshone->next;
-
-		scsi_hostlist = shone;
-		shone->next = shtwo->next;
-		prevtoshone->next = shtwo;
-		shtwo->next = NULL;
-	} else if (shtwo == scsi_hostlist && shone->next) {
-		/* shtwo at head, shone is not at tail */
-
-		prevtoshone = scsi_hostlist;
-		while (prevtoshone->next != shone)
-			prevtoshone = prevtoshone->next;
-
-		scsi_hostlist = shone;
-		prevtoshone->next = shtwo;
-		save = shtwo->next;
-		shtwo->next = shone->next;
-		shone->next = save;
-	} else if (!shone->next) {
-		/* shtwo not at head, shone at tail */
-
-		prevtoshtwo = scsi_hostlist;
-		prevtoshone = scsi_hostlist;
-
-		while (prevtoshtwo->next != shtwo)
-			prevtoshtwo = prevtoshtwo->next;
-		while (prevtoshone->next != shone)
-			prevtoshone = prevtoshone->next;
-
-		prevtoshtwo->next = shone;
-		shone->next = shtwo->next;
-		prevtoshone->next = shtwo;
-		shtwo->next = NULL;
-
-	} else {
-		prevtoshtwo = scsi_hostlist;
-		prevtoshone = scsi_hostlist;
-		save = NULL;
-
-		while (prevtoshtwo->next != shtwo)
-			prevtoshtwo = prevtoshtwo->next;
-		while (prevtoshone->next != shone)
-			prevtoshone = prevtoshone->next;
-
-		prevtoshtwo->next = shone;
-		save = shone->next;
-		shone->next = shtwo->next;
-		prevtoshone->next = shtwo;
-		shtwo->next = save;
-	}
-	return;
-}
-
-
-
 #ifdef CONFIG_PROC_FS
 /**
  * mega_adapinq()
@@ -5554,6 +5293,7 @@
 		mega_passthru *pthru )
 {
 	Scsi_Cmnd	*scmd;
+	struct	scsi_device *sdev;
 	unsigned long	flags = 0;
 	scb_t	*scb;
 	int	rval;
@@ -5571,7 +5311,11 @@
 	scmd = &adapter->int_scmd;
 	memset(scmd, 0, sizeof(Scsi_Cmnd));

-	scmd->host = adapter->host;
+	sdev = kmalloc(sizeof(struct scsi_device), GFP_KERNEL);
+	memset(sdev, 0, sizeof(struct scsi_device));
+	scmd->device = sdev;
+
+	scmd->device->host = adapter->host;
 	scmd->buffer = (void *)scb;
 	scmd->cmnd[0] = MEGA_INTERNAL_CMD;

@@ -5615,6 +5359,7 @@

 	rval = scmd->result;
 	mc->status = scmd->result;
+	kfree(sdev);

 	/*
 	 * Print a debug message for all failed commands. Applications can use
@@ -5642,7 +5387,7 @@
 {
 	adapter_t	*adapter;

-	adapter = (adapter_t *)scmd->host->hostdata;
+	adapter = (adapter_t *)scmd->device->host->hostdata;

 	scmd->state = 1; /* thread waiting for its command to complete */

diff -ruN megaraid-v2.00.9/megaraid.h megaraid-v2.00.9-linux2.6/megaraid.h
--- megaraid-v2.00.9/megaraid.h	2003-09-05 12:45:15.000000000 -0400
+++ megaraid-v2.00.9-linux2.6/megaraid.h	2003-12-30 16:16:07.743244000 -0500
@@ -129,7 +129,6 @@
 	.detect =			megaraid_detect,	\
 	.release =			megaraid_release,	\
 	.info =				megaraid_info,		\
-	.command =			megaraid_command,	\
 	.queuecommand =			megaraid_queue,		\
 	.bios_param =			megaraid_biosparam,	\
 	.max_sectors =			MAX_SECTORS_PER_IO,	\
@@ -140,12 +139,10 @@
 	.present =  			0,			\
 	.unchecked_isa_dma =		0,			\
 	.use_clustering =		ENABLE_CLUSTERING,	\
-	.use_new_eh_code =		1,			\
 	.eh_abort_handler =		megaraid_abort,		\
 	.eh_device_reset_handler =	megaraid_reset,		\
 	.eh_bus_reset_handler =		megaraid_reset,		\
 	.eh_host_reset_handler =	megaraid_reset,		\
-	.highmem_io =			1			\
 }


@@ -1103,19 +1100,18 @@
 static inline void mega_runpendq(adapter_t *);
 static int issue_scb_block(adapter_t *, u_char *);

-static void megaraid_isr_memmapped(int, void *, struct pt_regs *);
+static irqreturn_t megaraid_isr_memmapped(int, void *, struct pt_regs *);
 static inline void megaraid_memmbox_ack_sequence(adapter_t *);
-static void megaraid_isr_iomapped(int, void *, struct pt_regs *);
+static irqreturn_t megaraid_isr_iomapped(int, void *, struct pt_regs *);
 static inline void megaraid_iombox_ack_sequence(adapter_t *);

 static void mega_free_scb(adapter_t *, scb_t *);

 static int megaraid_release (struct Scsi_Host *);
-static int megaraid_command (Scsi_Cmnd *);
 static int megaraid_abort(Scsi_Cmnd *);
 static int megaraid_reset(Scsi_Cmnd *);
-static int megaraid_biosparam (Disk *, kdev_t, int *);
-
+static int megaraid_biosparam(struct scsi_device *, struct block_device *,
+              sector_t, int []);
 static int mega_build_sglist (adapter_t *adapter, scb_t *scb,
 			      u32 *buffer, u32 *length);
 static inline int mega_busywait_mbox (adapter_t *);
@@ -1137,8 +1133,6 @@
 static int mega_init_scb (adapter_t *);

 static int mega_is_bios_enabled (adapter_t *);
-static void mega_reorder_hosts (void);
-static void mega_swap_hosts (struct Scsi_Host *, struct Scsi_Host *);

 #ifdef CONFIG_PROC_FS
 static void mega_create_proc_entry(int, struct proc_dir_entry *);
@@ -1171,7 +1165,6 @@
 static mega_ext_passthru* mega_prepare_extpassthru(adapter_t *,
 		scb_t *, Scsi_Cmnd *, int, int);
 static void mega_enum_raid_scsi(adapter_t *);
-static int mega_partsize(Disk *, kdev_t, int *);
 static void mega_get_boot_drv(adapter_t *);
 static inline int mega_get_ldrv_num(adapter_t *, Scsi_Cmnd *, int);
 static int mega_support_random_del(adapter_t *);



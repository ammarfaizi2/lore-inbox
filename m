Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUCVW6I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 17:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUCVW6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 17:58:07 -0500
Received: from mail0.lsil.com ([147.145.40.20]:41213 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261326AbUCVW4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 17:56:53 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230C77A@exa-atlanta.se.lsil.com>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: [PATCH][RELEASE] megaraid 2.10.2 Driver
Date: Mon, 22 Mar 2004 17:56:49 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please apply this patch on megaraid 2.10.1 to get 2.10.2. The patch is
inlined below.
The 2.10.2 driver is available at:
ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.10.2/

List of changes since 2.10.1:

- Ioctl support for x86_64
- Check for possible failure of register_chrev() for private ioctlinterface.
- Added subsystem vendor id for FSC
- PCI DMA sync *after* tearing down PCI mapping in mega_free_scb
	(command completion)
- Typecast scsi buffer to "struct scatterlist *" for pci_dma_sync_sg,
	since the buffer is caddr_t
- Check for controller type before disabling interrupt for IO based
controller!
- 64-bit typecasts for private ioctl interface.
- Remove bios_param interface. Now we let kernel decide on the geometry.

Regards,
Sreenivas
LSI Logic

diff -Naur old/drivers/scsi/megaraid3.c new/drivers/scsi/megaraid2.c
--- old/drivers/scsi/megaraid2.c	2004-03-22 17:28:38.000000000 -0500
+++ new/drivers/scsi/megaraid2.c	2004-03-22 13:11:07.000000000 -0500
@@ -14,7 +14,10 @@
  *	  - speed-ups (list handling fixes, issued_list, optimizations.)
  *	  - lots of cleanups.
  *
- * Version : v2.10.1 (Dec 03, 2003) - Atul Mukker <Atul.Mukker@lsil.com>
+ * Version : v2.10.2 (Mar 22, 2004)
+ *
+ * Authors:	Atul Mukker <Atul.Mukker@lsil.com>
+ *		Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>
  *
  * Description: Linux device driver for LSI Logic MegaRAID controller
  *
@@ -23,8 +26,6 @@
  *
  * This driver is supported by LSI Logic, with assistance from Red Hat,
Dell,
  * and others. Please send updates to the public mailing list
- * linux-megaraid-devel@dell.com, and subscribe to and read archives of
this
- * list at http://lists.us.dell.com/.
  *
  * For history of changes, see ChangeLog.megaraid.
  *
@@ -45,6 +46,10 @@
 
 #include "megaraid2.h"
 
+#ifdef LSI_CONFIG_COMPAT
+#include <asm/ioctl32.h>
+#endif
+
 MODULE_AUTHOR ("LSI Logic Corporation");
 MODULE_DESCRIPTION ("LSI Logic MegaRAID driver");
 MODULE_LICENSE ("GPL");
@@ -206,6 +211,10 @@
 		 */
 		major = register_chrdev(0, "megadev", &megadev_fops);
 
+		if (!major) {
+			printk(KERN_WARNING
+				"megaraid: failed to register char
device.\n");
+		}
 		/*
 		 * Register the Shutdown Notification hook in kernel
 		 */
@@ -214,6 +223,13 @@
 				"MegaRAID Shutdown routine not
registered!!\n");
 		}
 
+#ifdef LSI_CONFIG_COMPAT
+		/*
+		 * Register the 32-bit ioctl conversion
+		 */
+		register_ioctl32_conversion(MEGAIOCCMD,
megadev_compat_ioctl);
+#endif
+
 	}
 
 	return hba_count;
@@ -311,6 +327,7 @@
 				(subsysvid != DELL_SUBSYS_VID) &&
 				(subsysvid != HP_SUBSYS_VID) &&
 				(subsysvid != INTEL_SUBSYS_VID) &&
+				(subsysvid != FSC_SUBSYS_VID) &&
 				(subsysvid != LSI_SUBSYS_VID) ) continue;
 
 
@@ -403,7 +420,8 @@
 		scsi_set_host_lock(&adapter->lock);
 #  endif
 #else
-		/* And this is the remainder of the 2.4 kernel series */
+		/* And this is the remainder of the 2.4 kernel
+		series */
 		adapter->host_lock = &io_request_lock;
 #endif
 
@@ -620,12 +638,15 @@
 
 		/* Set the Mode of addressing to 64 bit if we can */
 		if((adapter->flag & BOARD_64BIT)&&(sizeof(dma_addr_t) == 8))
{
-			pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
-			adapter->has_64bit_addr = 1;
+			if (pci_set_dma_mask(pdev, 0xffffffffffffffffULL) ==
0)
+				adapter->has_64bit_addr = 1;
 		}
-		else  {
-			pci_set_dma_mask(pdev, 0xffffffff);
-			adapter->has_64bit_addr = 0;
+		if (!adapter->has_64bit_addr)  {
+			if (pci_set_dma_mask(pdev, 0xffffffff) != 0) {
+				printk("megaraid%d: DMA not available.\n",
+					host->host_no);
+				goto fail_attach;
+			}
 		}
 
 		init_MUTEX(&adapter->int_mtx);
@@ -2249,26 +2270,28 @@
 		break;
 
 	case MEGA_BULK_DATA:
-		pci_unmap_page(adapter->dev, scb->dma_h_bulkdata,
-			scb->cmd->request_bufflen, scb->dma_direction);
-
 		if( scb->dma_direction == PCI_DMA_FROMDEVICE ) {
 			pci_dma_sync_single(adapter->dev,
scb->dma_h_bulkdata,
 					scb->cmd->request_bufflen,
 					PCI_DMA_FROMDEVICE);
 		}
 
+		pci_unmap_page(adapter->dev, scb->dma_h_bulkdata,
+			scb->cmd->request_bufflen, scb->dma_direction);
+
 		break;
 
 	case MEGA_SGLIST:
-		pci_unmap_sg(adapter->dev, scb->cmd->request_buffer,
-			scb->cmd->use_sg, scb->dma_direction);
-
 		if( scb->dma_direction == PCI_DMA_FROMDEVICE ) {
-			pci_dma_sync_sg(adapter->dev,
scb->cmd->request_buffer,
-					scb->cmd->use_sg,
PCI_DMA_FROMDEVICE);
+			pci_dma_sync_sg(adapter->dev,
+				(struct scatterlist
*)scb->cmd->request_buffer,
+				scb->cmd->use_sg, PCI_DMA_FROMDEVICE);
 		}
 
+		pci_unmap_sg(adapter->dev,
+			(struct scatterlist *)scb->cmd->request_buffer,
+			scb->cmd->use_sg, scb->dma_direction);
+
 		break;
 
 	default:
@@ -2402,8 +2425,9 @@
 	*len = (u32)cmd->request_bufflen;
 
 	if( scb->dma_direction == PCI_DMA_TODEVICE ) {
-		pci_dma_sync_sg(adapter->dev, cmd->request_buffer,
-				cmd->use_sg, PCI_DMA_TODEVICE);
+		pci_dma_sync_sg(adapter->dev,
+			(struct scatterlist *)cmd->request_buffer,
+			cmd->use_sg, PCI_DMA_TODEVICE);
 	}
 
 	/* Return count of SG requests */
@@ -2474,7 +2498,9 @@
 	memset(raw_mbox, 0, sizeof(raw_mbox));
 	raw_mbox[0] = FLUSH_ADAPTER;
 
-	irq_disable(adapter);
+	if (adapter->flag & BOARD_IOMAP)
+		irq_disable(adapter);
+
 	free_irq(adapter->host->irq, adapter);
 
 	/* Issue a blocking (interrupts disabled) command to the card */
@@ -2549,7 +2575,9 @@
 		/*
 		 * Unregister the character device interface to the driver.
 		 */
-		unregister_chrdev(major, "megadev");
+		if (major) {
+			unregister_chrdev(major, "megadev");
+		}
 
 		unregister_reboot_notifier(&mega_notifier);
 
@@ -2568,6 +2596,9 @@
 	 */
 	scsi_unregister(host);
 
+#ifdef LSI_CONFIG_COMPAT
+	unregister_ioctl32_conversion(MEGAIOCCMD);
+#endif
 
 	printk("ok.\n");
 
@@ -3860,153 +3891,6 @@
 
 
 /**
- * megaraid_biosparam()
- * @disk
- * @dev
- * @geom
- *
- * Return the disk geometry for a particular disk
- * Input:
- *	Disk *disk - Disk geometry
- *	kdev_t dev - Device node
- *	int *geom  - Returns geometry fields
- *		geom[0] = heads
- *		geom[1] = sectors
- *		geom[2] = cylinders
- */
-static int
-megaraid_biosparam(Disk *disk, kdev_t dev, int *geom)
-{
-	int heads, sectors, cylinders;
-	adapter_t *adapter;
-
-	/* Get pointer to host config structure */
-	adapter = (adapter_t *)disk->device->host->hostdata;
-
-	if (IS_RAID_CH(adapter, disk->device->channel)) {
-			/* Default heads (64) & sectors (32) */
-			heads = 64;
-			sectors = 32;
-			cylinders = disk->capacity / (heads * sectors);
-
-			/*
-			 * Handle extended translation size for logical
drives
-			 * > 1Gb
-			 */
-			if (disk->capacity >= 0x200000) {
-				heads = 255;
-				sectors = 63;
-				cylinders = disk->capacity / (heads *
sectors);
-			}
-
-			/* return result */
-			geom[0] = heads;
-			geom[1] = sectors;
-			geom[2] = cylinders;
-	}
-	else {
-		if( !mega_partsize(disk, dev, geom) )
-			return 0;
-
-		printk(KERN_WARNING
-		"megaraid: invalid partition on this disk on channel %d\n",
-				disk->device->channel);
-
-		/* Default heads (64) & sectors (32) */
-		heads = 64;
-		sectors = 32;
-		cylinders = disk->capacity / (heads * sectors);
-
-		/* Handle extended translation size for logical drives > 1Gb
*/
-		if (disk->capacity >= 0x200000) {
-			heads = 255;
-			sectors = 63;
-			cylinders = disk->capacity / (heads * sectors);
-		}
-
-		/* return result */
-		geom[0] = heads;
-		geom[1] = sectors;
-		geom[2] = cylinders;
-	}
-
-	return 0;
-}
-
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
-
-/**
  * megaraid_reboot_notify()
  * @this - unused
  * @code - shutdown code
@@ -4040,7 +3924,9 @@
 		memset(raw_mbox, 0, sizeof(raw_mbox));
 		raw_mbox[0] = FLUSH_ADAPTER;
 
-		irq_disable(adapter);
+		if (adapter->flag & BOARD_IOMAP)
+			irq_disable(adapter);
+
 		free_irq(adapter->host->irq, adapter);
 
 		/*
@@ -4179,6 +4065,18 @@
 }
 
 
+#ifdef LSI_CONFIG_COMPAT
+static int
+megadev_compat_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg,
+		struct file *filep)
+{
+	struct inode *inode = filep->f_dentry->d_inode;
+
+	return megadev_ioctl(inode, filep, cmd, arg);
+}
+#endif
+
+
 /**
  * megadev_ioctl()
  * @inode - Our device inode
@@ -4386,8 +4284,8 @@
 			/*
 			 * The user passthru structure
 			 */
-			upthru = (mega_passthru *)MBOX(uioc)->xferaddr;
-
+			upthru = (mega_passthru *)
+					((ulong)(MBOX(uioc)->xferaddr));
 			/*
 			 * Copy in the user passthru here.
 			 */
@@ -4434,8 +4332,9 @@
 				/*
 				 * Get the user data
 				 */
-				if( copy_from_user(data, (char *)uxferaddr,
-							pthru->dataxferlen)
) {
+				if( copy_from_user(data,
+						(char *)((ulong)uxferaddr),
+						pthru->dataxferlen) ) {
 					rval = (-EFAULT);
 					goto freemem_and_return;
 				}
@@ -4460,8 +4359,8 @@
 			 * Is data going up-stream
 			 */
 			if( pthru->dataxferlen && (uioc.flags & UIOC_RD) ) {
-				if( copy_to_user((char *)uxferaddr, data,
-							pthru->dataxferlen)
) {
+				if( copy_to_user((char *)((ulong)uxferaddr),
+						data, pthru->dataxferlen) )
{
 					rval = (-EFAULT);
 				}
 			}
@@ -4509,12 +4408,13 @@
 				/*
 				 * Get the user data
 				 */
-				if( copy_from_user(data, (char *)uxferaddr,
-							uioc.xferlen) ) {
+				if( copy_from_user(data,
+						(char *)((ulong)uxferaddr),
+						uioc.xferlen) ) {
 
 					pci_free_consistent(pdev,
-							uioc.xferlen,
-							data,
data_dma_hndl);
+						uioc.xferlen, data,
+						data_dma_hndl);
 
 					return (-EFAULT);
 				}
@@ -4545,8 +4445,8 @@
 			 * Is data going up-stream
 			 */
 			if( uioc.xferlen && (uioc.flags & UIOC_RD) ) {
-				if( copy_to_user((char *)uxferaddr, data,
-							uioc.xferlen) ) {
+				if( copy_to_user((char *)((ulong)uxferaddr),
+						data, uioc.xferlen) ) {
 
 					rval = (-EFAULT);
 				}
@@ -4731,7 +4631,7 @@
 
 			umc = MBOX_P(uiocp);
 
-			upthru = (mega_passthru *)umc->xferaddr;
+			upthru = (mega_passthru *)((ulong)(umc->xferaddr));
 
 			if( put_user(mc->status, (u8 *)&upthru->scsistatus)
)
 				return (-EFAULT);
@@ -4749,7 +4649,7 @@
 			if (copy_from_user(&kmc, umc, sizeof(megacmd_t)))
 				return -EFAULT;
 
-			upthru = (mega_passthru *)kmc.xferaddr;
+			upthru = (mega_passthru *)((ulong)kmc.xferaddr);
 
 			if( put_user(mc->status, (u8 *)&upthru->scsistatus)
)
 				return (-EFAULT);
diff -Naur old/drivers/scsi/megaraid2.h new/drivers/scsi/megaraid2.h
--- old/drivers/scsi/megaraid2.h	2004-03-22 17:28:38.000000000 -0500
+++ new/drivers/scsi/megaraid2.h	2004-03-22 13:10:48.000000000 -0500
@@ -6,7 +6,7 @@
 
 
 #define MEGARAID_VERSION	\
-	"v2.10.1 (Release Date: Wed Dec  3 15:34:42 EST 2003)\n"
+	"v2.10.2 (Release Date: Mon Mar 22 13:10:39 EST 2004)\n"
 
 /*
  * Driver features - change the values to enable or disable features in the
@@ -44,8 +44,6 @@
  */
 #define MEGA_HAVE_ENH_PROC	1
 
-#define MAX_DEV_TYPE	32
-
 #ifndef PCI_VENDOR_ID_LSI_LOGIC
 #define PCI_VENDOR_ID_LSI_LOGIC		0x1000
 #endif
@@ -87,6 +85,7 @@
 #define	HP_SUBSYS_VID			0x103C
 #define LSI_SUBSYS_VID			0x1000
 #define INTEL_SUBSYS_VID		0x8086
+#define FSC_SUBSYS_VID			0x1734
 
 #define HBA_SIGNATURE	      		0x3344
 #define HBA_SIGNATURE_471	  	0xCCCC
@@ -134,7 +133,6 @@
 	.info =				megaraid_info,		\
 	.command =			megaraid_command,	\
 	.queuecommand =			megaraid_queue,		\
-	.bios_param =			megaraid_biosparam,	\
 	.max_sectors =			MAX_SECTORS_PER_IO,	\
 	.can_queue =			MAX_COMMANDS,		\
 	.this_id =			DEFAULT_INITIATOR_ID,	\
@@ -148,7 +146,8 @@
 	.eh_device_reset_handler =	megaraid_reset,		\
 	.eh_bus_reset_handler =		megaraid_reset,		\
 	.eh_host_reset_handler =	megaraid_reset,		\
-	.highmem_io =			1			\
+	.highmem_io =			1,			\
+	.vary_io =			1			\
 }
 
 
@@ -662,6 +661,9 @@
  */
 #define MEGAIOC_MAGIC  	'm'
 
+/* Mega IOCTL command */
+#define MEGAIOCCMD     	_IOWR(MEGAIOC_MAGIC, 0, struct uioctl_t)
+
 #define MEGAIOC_QNADAP		'm'	/* Query # of adapters */
 #define MEGAIOC_QDRVRVER	'e'	/* Query driver version */
 #define MEGAIOC_QADAPINFO   	'g'	/* Query adapter information */
@@ -1115,7 +1117,6 @@
 static int megaraid_command (Scsi_Cmnd *);
 static int megaraid_abort(Scsi_Cmnd *);
 static int megaraid_reset(Scsi_Cmnd *);
-static int megaraid_biosparam (Disk *, kdev_t, int *);
 
 static int mega_build_sglist (adapter_t *adapter, scb_t *scb,
 			      u32 *buffer, u32 *length);
@@ -1129,6 +1130,15 @@
 static int megaraid_reboot_notify (struct notifier_block *,
 				   unsigned long, void *);
 static int megadev_open (struct inode *, struct file *);
+
+#if defined (CONFIG_COMPAT) || defined ( __x86_64__)
+#define LSI_CONFIG_COMPAT
+#endif
+#ifdef LSI_CONFIG_COMPAT
+static int megadev_compat_ioctl(unsigned int, unsigned int, unsigned long,
+	struct file *);
+#endif
+
 static int megadev_ioctl (struct inode *, struct file *, unsigned int,
 		unsigned long);
 static int mega_m_to_n(void *, nitioctl_t *);
@@ -1172,7 +1182,6 @@
 static mega_ext_passthru* mega_prepare_extpassthru(adapter_t *,
 		scb_t *, Scsi_Cmnd *, int, int);
 static void mega_enum_raid_scsi(adapter_t *);
-static int mega_partsize(Disk *, kdev_t, int *);
 static void mega_get_boot_drv(adapter_t *);
 static inline int mega_get_ldrv_num(adapter_t *, Scsi_Cmnd *, int);
 static int mega_support_random_del(adapter_t *);

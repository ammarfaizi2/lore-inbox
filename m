Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281255AbSAHJl0>; Tue, 8 Jan 2002 04:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282482AbSAHJlJ>; Tue, 8 Jan 2002 04:41:09 -0500
Received: from [195.63.194.11] ([195.63.194.11]:20750 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S281255AbSAHJk4>; Tue, 8 Jan 2002 04:40:56 -0500
Message-ID: <3C3ABC0C.7050408@evision-ventures.com>
Date: Tue, 08 Jan 2002 10:29:48 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2.5.2-pre9 scsi cleanup
In-Reply-To: <Pine.LNX.4.33.0201011402560.13397-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------060904020309090405060307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060904020309090405060307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch does the following.

1. Clean up some ifdef confusion in do_mount

2. Clean up the scsi code to make ppa.c work.

3. Clean up some unneccessary unneeded globals from scsi code.

4. Make a bit more sure, that the minor() and friends end up in
unsigned int's.

--------------060904020309090405060307
Content-Type: text/plain;
 name="cleanup-scsi-2.5.2-pre9.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cleanup-scsi-2.5.2-pre9.patch"

diff -ur linux-old/drivers/scsi/dpt_i2o.c linux/drivers/scsi/dpt_i2o.c
--- linux-old/drivers/scsi/dpt_i2o.c	Sat May  4 09:11:43 2002
+++ linux/drivers/scsi/dpt_i2o.c	Sat May  4 06:54:58 2002
@@ -1551,7 +1551,7 @@
 
 static int adpt_open(struct inode *inode, struct file *file)
 {
-	int minor;
+	unsigned int minor;
 	adpt_hba* pHba;
 
 	//TODO check for root access
@@ -1584,7 +1584,7 @@
 
 static int adpt_close(struct inode *inode, struct file *file)
 {
-	int minor;
+	unsigned int minor;
 	adpt_hba* pHba;
 
 	minor = minor(inode->i_rdev);
@@ -1878,7 +1878,7 @@
 static int adpt_ioctl(struct inode *inode, struct file *file, uint cmd,
 	      ulong arg)
 {
-	int minor;
+	unsigned int minor;
 	int error = 0;
 	adpt_hba* pHba;
 	ulong flags;
diff -ur linux-old/drivers/scsi/fcal.c linux/drivers/scsi/fcal.c
--- linux-old/drivers/scsi/fcal.c	Fri Feb  9 20:30:23 2001
+++ linux/drivers/scsi/fcal.c	Sat May  4 07:47:15 2002
@@ -249,8 +249,6 @@
 				if (scd->host->host_no == hostno && scd->id == target) {
 					SPRINTF ("  [AL-PA: %02x, Id: %02d, Port WWN: %08x%08x, Node WWN: %08x%08x]  ",
 						alpa, target, u1[0], u1[1], u2[0], u2[1]);
-					SPRINTF ("%s ", (scd->type < MAX_SCSI_DEVICE_CODE) ?
-						scsi_device_types[(short) scd->type] : "Unknown device");
 
 					for (j = 0; (j < 8) && (scd->vendor[j] >= 0x20); j++)
 						SPRINTF ("%c", scd->vendor[j]);
diff -ur linux-old/drivers/scsi/g_NCR5380.c linux/drivers/scsi/g_NCR5380.c
--- linux-old/drivers/scsi/g_NCR5380.c	Sun Sep 30 21:26:07 2001
+++ linux/drivers/scsi/g_NCR5380.c	Sat May  4 07:48:21 2002
@@ -789,7 +789,6 @@
     struct NCR5380_hostdata *hostdata;
 #ifdef NCR5380_STATS
     Scsi_Device *dev;
-    extern const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE];
 #endif
     save_flags(flags);
     cli();
@@ -833,7 +832,7 @@
 	    long tr = hostdata->time_read[dev->id] / HZ;
 	    long tw = hostdata->time_write[dev->id] / HZ;
 
-	    PRINTP("  T:%d %s " ANDP dev->id ANDP (dev->type < MAX_SCSI_DEVICE_CODE) ? scsi_device_types[(int)dev->type] : "Unknown");
+	    PRINTP("  T:%d " ANDP dev->id );
 	    for (i=0; i<8; i++)
 		if (dev->vendor[i] >= 0x20)
 		    *(buffer+(len++)) = dev->vendor[i];
diff -ur linux-old/drivers/scsi/ppa.c linux/drivers/scsi/ppa.c
--- linux-old/drivers/scsi/ppa.c	Sun Sep 30 21:26:07 2001
+++ linux/drivers/scsi/ppa.c	Sat May  4 07:45:50 2002
@@ -115,11 +115,6 @@
     int i, nhosts, try_again;
     struct parport *pb;
 
-    /*
-     * unlock to allow the lowlevel parport driver to probe
-     * the irqs
-     */
-    spin_unlock_irq(&io_request_lock);
     pb = parport_enumerate();
 
     printk("ppa: Version %s\n", PPA_VERSION);
@@ -128,7 +123,6 @@
 
     if (!pb) {
 	printk("ppa: parport reports no devices.\n");
-	spin_lock_irq(&io_request_lock);
 	return 0;
     }
   retry_entry:
@@ -154,7 +148,6 @@
 		      "pardevice is owning the port for too longtime!\n",
 			   i);
 		    parport_unregister_device(ppa_hosts[i].dev);
-		    spin_lock_irq(&io_request_lock);
 		    return 0;
 		}
 	    }
@@ -223,15 +216,12 @@
 	    printk("  supported by the imm (ZIP Plus) driver. If the\n");
 	    printk("  cable is marked with \"AutoDetect\", this is what has\n");
 	    printk("  happened.\n");
-	    spin_lock_irq(&io_request_lock);
 	    return 0;
 	}
 	try_again = 1;
 	goto retry_entry;
-    } else {
-	spin_lock_irq(&io_request_lock);
+    } else
 	return 1;		/* return number of hosts detected */
-    }
 }
 
 /* This is to give the ppa driver a way to modify the timings (and other
@@ -847,9 +837,9 @@
 
     tmp->cur_cmd = 0;
     
-    spin_lock_irqsave(&io_request_lock, flags);
+    spin_lock_irqsave(&cmd->host->host_lock, flags);
     cmd->scsi_done(cmd);
-    spin_unlock_irqrestore(&io_request_lock, flags);
+    spin_unlock_irqrestore(&cmd->host->host_lock, flags);
     return;
 }
 
diff -ur linux-old/drivers/scsi/scsi.c linux/drivers/scsi/scsi.c
--- linux-old/drivers/scsi/scsi.c	Sat May  4 09:11:44 2002
+++ linux/drivers/scsi/scsi.c	Sat May  4 07:49:19 2002
@@ -139,25 +139,7 @@
  */
 unsigned int scsi_logging_level;
 
-const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE] =
-{
-	"Direct-Access    ",
-	"Sequential-Access",
-	"Printer          ",
-	"Processor        ",
-	"WORM             ",
-	"CD-ROM           ",
-	"Scanner          ",
-	"Optical Device   ",
-	"Medium Changer   ",
-	"Communications   ",
-	"Unknown          ",
-	"Unknown          ",
-	"Unknown          ",
-	"Enclosure        ",
-};
-
-/* 
+/*
  * Function prototypes.
  */
 extern void scsi_times_out(Scsi_Cmnd * SCpnt);
diff -ur linux-old/drivers/scsi/scsi.h linux/drivers/scsi/scsi.h
--- linux-old/drivers/scsi/scsi.h	Sat May  4 09:11:44 2002
+++ linux/drivers/scsi/scsi.h	Sat May  4 07:49:38 2002
@@ -89,9 +89,6 @@
 #define FALSE 0
 #endif
 
-#define MAX_SCSI_DEVICE_CODE 14
-extern const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE];
-
 #ifdef DEBUG
 #define SCSI_TIMEOUT (5*HZ)
 #else
diff -ur linux-old/drivers/scsi/scsi_proc.c linux/drivers/scsi/scsi_proc.c
--- linux-old/drivers/scsi/scsi_proc.c	Thu Jun 28 02:10:55 2001
+++ linux/drivers/scsi/scsi_proc.c	Sat May  4 07:51:31 2002
@@ -260,7 +260,6 @@
 {
 
 	int x, y = *size;
-	extern const char *const scsi_device_types[MAX_SCSI_DEVICE_CODE];
 
 	y = sprintf(buffer + len,
 	     "Host: scsi%d Channel: %02d Id: %02d Lun: %02d\n  Vendor: ",
@@ -285,13 +284,8 @@
 		else
 			y += sprintf(buffer + len + y, " ");
 	}
-	y += sprintf(buffer + len + y, "\n");
-
-	y += sprintf(buffer + len + y, "  Type:   %s ",
-		     scd->type < MAX_SCSI_DEVICE_CODE ?
-	       scsi_device_types[(int) scd->type] : "Unknown          ");
-	y += sprintf(buffer + len + y, "               ANSI"
-		     " SCSI revision: %02x", (scd->scsi_level - 1) ? scd->scsi_level - 1 : 1);
+	y += sprintf(buffer + len + y, "\n  ANSI SCSI revision: %02x",
+		(scd->scsi_level - 1) ? scd->scsi_level - 1 : 1);
 	if (scd->scsi_level == 2)
 		y += sprintf(buffer + len + y, " CCS\n");
 	else
diff -ur linux-old/drivers/scsi/scsi_scan.c linux/drivers/scsi/scsi_scan.c
--- linux-old/drivers/scsi/scsi_scan.c	Sat May  4 09:11:44 2002
+++ linux/drivers/scsi/scsi_scan.c	Sat May  4 07:52:25 2002
@@ -231,13 +231,7 @@
 			printk(" ");
 	}
 
-	printk("\n");
-
-	i = data[0] & 0x1f;
-
-	printk("  Type:   %s ",
-	       i < MAX_SCSI_DEVICE_CODE ? scsi_device_types[i] : "Unknown          ");
-	printk("                 ANSI SCSI revision: %02x", data[2] & 0x07);
+	printk("\n  ANSI SCSI revision: %02x", data[2] & 0x07);
 	if ((data[2] & 0x07) == 1 && (data[3] & 0x0f) == 1)
 		printk(" CCS\n");
 	else
diff -ur linux-old/drivers/scsi/scsi_syms.c linux/drivers/scsi/scsi_syms.c
--- linux-old/drivers/scsi/scsi_syms.c	Sat May  4 09:11:44 2002
+++ linux/drivers/scsi/scsi_syms.c	Sat May  4 07:52:50 2002
@@ -87,7 +87,6 @@
 EXPORT_SYMBOL(scsi_hostlist);
 EXPORT_SYMBOL(scsi_hosts);
 EXPORT_SYMBOL(scsi_devicelist);
-EXPORT_SYMBOL(scsi_device_types);
 
 /*
  * Externalize timers so that HBAs can safely start/restart commands.
diff -ur linux-old/drivers/scsi/sg.c linux/drivers/scsi/sg.c
--- linux-old/drivers/scsi/sg.c	Sat May  4 09:11:44 2002
+++ linux/drivers/scsi/sg.c	Sat May  4 06:56:26 2002
@@ -254,7 +254,7 @@
 
 static int sg_open(struct inode * inode, struct file * filp)
 {
-    int dev = minor(inode->i_rdev);
+    unsigned int dev = minor(inode->i_rdev);
     int flags = filp->f_flags;
     Sg_device * sdp;
     Sg_fd * sfp;
@@ -1035,7 +1035,7 @@
 static void sg_cmd_done_bh(Scsi_Cmnd * SCpnt)
 {
     Scsi_Request * SRpnt = SCpnt->sc_request;
-    int dev = minor(SRpnt->sr_request.rq_dev);
+    unsigned int dev = minor(SRpnt->sr_request.rq_dev);
     Sg_device * sdp = NULL;
     Sg_fd * sfp;
     Sg_request * srp = NULL;
@@ -2687,7 +2687,8 @@
 	    Sg_fd * fp;
 	    Sg_request * srp;
 	    struct scsi_device * scsidp;
-	    int dev, k, m, blen, usg;
+	    unsigned int dev;
+	    int k, m, blen, usg;
  
 	    scsidp = sdp->device;
 	    if (NULL == scsidp) {
diff -ur linux-old/drivers/scsi/sr.c linux/drivers/scsi/sr.c
--- linux-old/drivers/scsi/sr.c	Sat May  4 09:11:44 2002
+++ linux/drivers/scsi/sr.c	Sat May  4 07:58:13 2002
@@ -99,11 +99,13 @@
 
 static void sr_release(struct cdrom_device_info *cdi)
 {
-	if (scsi_CDs[minor(cdi->dev)].device->sector_size > 2048)
-		sr_set_blocklength(minor(cdi->dev), 2048);
-	scsi_CDs[minor(cdi->dev)].device->access_count--;
-	if (scsi_CDs[minor(cdi->dev)].device->host->hostt->module)
-		__MOD_DEC_USE_COUNT(scsi_CDs[minor(cdi->dev)].device->host->hostt->module);
+	unsigned int minor = minor(cdi->dev);
+
+	if (scsi_CDs[minor].device->sector_size > 2048)
+		sr_set_blocklength(minor, 2048);
+	scsi_CDs[minor].device->access_count--;
+	if (scsi_CDs[minor].device->host->hostt->module)
+		__MOD_DEC_USE_COUNT(scsi_CDs[minor].device->host->hostt->module);
 	if (sr_template.module)
 		__MOD_DEC_USE_COUNT(sr_template.module);
 }
@@ -145,12 +147,14 @@
 int sr_media_change(struct cdrom_device_info *cdi, int slot)
 {
 	int retval;
+	unsigned int minor;
 
 	if (CDSL_CURRENT != slot) {
 		/* no changer support */
 		return -EINVAL;
 	}
-	retval = scsi_ioctl(scsi_CDs[minor(cdi->dev)].device,
+	minor = minor(cdi->dev);
+	retval = scsi_ioctl(scsi_CDs[minor].device,
 			    SCSI_IOCTL_TEST_UNIT_READY, 0);
 
 	if (retval) {
@@ -159,13 +163,13 @@
 		 * and we will figure it out later once the drive is
 		 * available again.  */
 
-		scsi_CDs[minor(cdi->dev)].device->changed = 1;
+		scsi_CDs[minor].device->changed = 1;
 		return 1;	/* This will force a flush, if called from
 				 * check_disk_change */
 	};
 
-	retval = scsi_CDs[minor(cdi->dev)].device->changed;
-	scsi_CDs[minor(cdi->dev)].device->changed = 0;
+	retval = scsi_CDs[minor].device->changed;
+	scsi_CDs[minor].device->changed = 0;
 	/* If the disk changed, the capacity will now be different,
 	 * so we force a re-read of this information */
 	if (retval) {
@@ -179,9 +183,9 @@
 		 * be trying to use something that is too small if the disc
 		 * has changed.
 		 */
-		scsi_CDs[minor(cdi->dev)].needs_sector_size = 1;
+		scsi_CDs[minor].needs_sector_size = 1;
 
-		scsi_CDs[minor(cdi->dev)].device->sector_size = 2048;
+		scsi_CDs[minor].device->sector_size = 2048;
 	}
 	return retval;
 }
@@ -250,18 +254,21 @@
 
 static request_queue_t *sr_find_queue(kdev_t dev)
 {
+	unsigned int minor = minor(dev);
 	/*
 	 * No such device
 	 */
-	if (minor(dev) >= sr_template.dev_max || !scsi_CDs[minor(dev)].device)
+	if (minor >= sr_template.dev_max || !scsi_CDs[minor].device)
 		return NULL;
 
-	return &scsi_CDs[minor(dev)].device->request_queue;
+	return &scsi_CDs[minor].device->request_queue;
 }
 
 static int sr_init_command(Scsi_Cmnd * SCpnt)
 {
-	int dev, devm, block=0, this_count, s_size;
+	int dev;
+	unsigned int devm;
+	int block=0, this_count, s_size;
 
 	devm = minor(SCpnt->request.rq_dev);
 	dev = DEVICE_NR(SCpnt->request.rq_dev);
@@ -397,22 +404,22 @@
 
 static int sr_open(struct cdrom_device_info *cdi, int purpose)
 {
+	unsigned int minor = minor(cdi->dev);
 	check_disk_change(cdi->dev);
 
-	if (minor(cdi->dev) >= sr_template.dev_max
-	    || !scsi_CDs[minor(cdi->dev)].device) {
+	if (minor >= sr_template.dev_max || !scsi_CDs[minor].device) {
 		return -ENXIO;	/* No such device */
 	}
 	/*
 	 * If the device is in error recovery, wait until it is done.
 	 * If the device is offline, then disallow any access to it.
 	 */
-	if (!scsi_block_when_processing_errors(scsi_CDs[minor(cdi->dev)].device)) {
+	if (!scsi_block_when_processing_errors(scsi_CDs[minor].device)) {
 		return -ENXIO;
 	}
-	scsi_CDs[minor(cdi->dev)].device->access_count++;
-	if (scsi_CDs[minor(cdi->dev)].device->host->hostt->module)
-		__MOD_INC_USE_COUNT(scsi_CDs[minor(cdi->dev)].device->host->hostt->module);
+	scsi_CDs[minor].device->access_count++;
+	if (scsi_CDs[minor].device->host->hostt->module)
+		__MOD_INC_USE_COUNT(scsi_CDs[minor].device->host->hostt->module);
 	if (sr_template.module)
 		__MOD_INC_USE_COUNT(sr_template.module);
 
@@ -421,8 +428,8 @@
 	 * this is the case, and try again.
 	 */
 
-	if (scsi_CDs[minor(cdi->dev)].needs_sector_size)
-		get_sectorsize(minor(cdi->dev));
+	if (scsi_CDs[minor].needs_sector_size)
+		get_sectorsize(minor);
 
 	return 0;
 }
@@ -616,7 +623,6 @@
 	n = buffer[3] + 4;
 	scsi_CDs[i].cdi.speed = ((buffer[n + 8] << 8) + buffer[n + 9]) / 176;
 	scsi_CDs[i].readcd_known = 1;
-	scsi_CDs[i].readcd_cdda = buffer[n + 5] & 0x01;
 	/* print some capability bits */
 	printk("sr%i: scsi3-mmc drive: %dx/%dx %s%s%s%s%s%s\n", i,
 	       ((buffer[n + 14] << 8) + buffer[n + 15]) / 176,
@@ -671,13 +677,14 @@
  */
 static int sr_packet(struct cdrom_device_info *cdi, struct cdrom_generic_command *cgc)
 {
-	Scsi_Device *device = scsi_CDs[minor(cdi->dev)].device;
+	unsigned int minor = minor(cdi->dev);
+	Scsi_Device *device = scsi_CDs[minor].device;
 
 	/* set the LUN */
 	if (device->scsi_level <= SCSI_2)
 		cgc->cmd[1] |= device->lun << 5;
 
-	cgc->stat = sr_do_ioctl(minor(cdi->dev), cgc->cmd, cgc->buffer, cgc->buflen, cgc->quiet, cgc->data_direction, cgc->sense);
+	cgc->stat = sr_do_ioctl(minor, cgc->cmd, cgc->buffer, cgc->buflen, cgc->quiet, cgc->data_direction, cgc->sense);
 
 	return cgc->stat;
 }
@@ -761,7 +768,6 @@
 		scsi_CDs[i].device->ten = 1;
 		scsi_CDs[i].device->remap = 1;
 		scsi_CDs[i].readcd_known = 0;
-		scsi_CDs[i].readcd_cdda = 0;
 		sr_sizes[i] = scsi_CDs[i].capacity >> (BLOCK_SIZE_BITS - 9);
 
 		scsi_CDs[i].cdi.ops = &sr_dops;
diff -ur linux-old/drivers/scsi/sr.h linux/drivers/scsi/sr.h
--- linux-old/drivers/scsi/sr.h	Fri Jul 20 06:18:31 2001
+++ linux/drivers/scsi/sr.h	Sat May  4 07:58:37 2002
@@ -30,7 +30,6 @@
 	unsigned use:1;		/* is this device still supportable     */
 	unsigned xa_flag:1;	/* CD has XA sectors ? */
 	unsigned readcd_known:1;	/* drive supports READ_CD (0xbe) */
-	unsigned readcd_cdda:1;	/* reading audio data using READ_CD */
 	struct cdrom_device_info cdi;
 } Scsi_CD;
 
diff -ur linux-old/drivers/scsi/sr_ioctl.c linux/drivers/scsi/sr_ioctl.c
--- linux-old/drivers/scsi/sr_ioctl.c	Sat May  4 09:11:44 2002
+++ linux/drivers/scsi/sr_ioctl.c	Sat May  4 06:59:15 2002
@@ -333,7 +333,8 @@
 int sr_audio_ioctl(struct cdrom_device_info *cdi, unsigned int cmd, void *arg)
 {
 	u_char sr_cmd[10];
-	int result, target = minor(cdi->dev);
+	int result;
+	unsigned int target = minor(cdi->dev);
 	unsigned char buffer[32];
 
 	memset(sr_cmd, 0, sizeof(sr_cmd));
@@ -539,7 +540,7 @@
 int sr_dev_ioctl(struct cdrom_device_info *cdi,
 		 unsigned int cmd, unsigned long arg)
 {
-	int target;
+	unsigned int target;
 
 	target = minor(cdi->dev);
 
diff -ur linux-old/drivers/scsi/sr_vendor.c linux/drivers/scsi/sr_vendor.c
--- linux-old/drivers/scsi/sr_vendor.c	Sat May  4 09:11:44 2002
+++ linux/drivers/scsi/sr_vendor.c	Sat May  4 06:59:49 2002
@@ -156,7 +156,8 @@
 	unsigned long sector;
 	unsigned char *buffer;	/* the buffer for the ioctl */
 	unsigned char cmd[MAX_COMMAND_SIZE];	/* the scsi-command */
-	int rc, no_multi, minor;
+	int rc, no_multi;
+	unsigned int minor;
 
 	minor = minor(cdi->dev);
 	if (scsi_CDs[minor].cdi.mask & CDC_MULTI_SESSION)
diff -ur linux-old/drivers/scsi/wd7000.c linux/drivers/scsi/wd7000.c
--- linux-old/drivers/scsi/wd7000.c	Sat May  4 09:11:44 2002
+++ linux/drivers/scsi/wd7000.c	Sat May  4 07:59:58 2002
@@ -1469,8 +1469,6 @@
 	if (scd->host->host_no == hostno) {
 	    SPRINTF ("  [Channel: %02d, Id: %02d, Lun: %02d]  ",
 		     scd->channel, scd->id, scd->lun);
-	    SPRINTF ("%s ", (scd->type < MAX_SCSI_DEVICE_CODE) ?
-		     scsi_device_types[(short) scd->type] : "Unknown device");
 
 	    for (i = 0; (i < 8) && (scd->vendor[i] >= 0x20); i++)
 		SPRINTF ("%c", scd->vendor[i]);
diff -ur linux-old/init/do_mounts.c linux/init/do_mounts.c
--- linux-old/init/do_mounts.c	Sat May  4 09:11:56 2002
+++ linux/init/do_mounts.c	Sat May  4 05:20:30 2002
@@ -364,6 +364,7 @@
 	return sys_symlink(path + n + 5, name);
 }
 
+#ifdef CONFIG_BLK_DEV_RAM
 static void __init change_floppy(char *fmt, ...)
 {
 	struct termios termios;
@@ -392,8 +393,6 @@
 	}
 }
 
-#ifdef CONFIG_BLK_DEV_RAM
-
 int __initdata rd_prompt = 1;	/* 1 = prompt for RAM disk, 0 = don't prompt */
 
 static int __init prompt_ramdisk(char *str)
@@ -843,6 +842,7 @@
 }
 
 #ifdef BUILD_CRAMDISK
+# ifdef CONFIG_BLK_DEV_RAM
 
 /*
  * gzip declarations
@@ -986,5 +986,5 @@
 	kfree(window);
 	return result;
 }
-
+# endif
 #endif  /* BUILD_CRAMDISK */

--------------060904020309090405060307--


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310281AbSCKRRc>; Mon, 11 Mar 2002 12:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310458AbSCKRQR>; Mon, 11 Mar 2002 12:16:17 -0500
Received: from host194.steeleye.com ([216.33.1.194]:32268 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S310452AbSCKRPt>; Mon, 11 Mar 2002 12:15:49 -0500
Message-Id: <200203111715.g2BHFRB06909@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Douglas Gilbert <dougg@torque.net>,
        Jeremy Higdon <jeremy@classic.engr.sgi.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
In-Reply-To: Message from "Stephen C. Tweedie" <sct@redhat.com> 
   of "Mon, 11 Mar 2002 11:34:46 GMT." <20020311113446.A10150@redhat.com> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_21289125120"
Date: Mon, 11 Mar 2002 12:15:26 -0500
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_21289125120
Content-Type: text/plain; charset=us-ascii

This patch (against 2.4.18) addresses our synchronisation problems with write 
back caches only, not the ordering problem with tags.

It probes the cache type on attach and inserts synchronisation instructions on 
release() (i.e. unmount) or if the reboot notifier is called.

How would you like the cache synchronize instruction plugged into the journal 
writes?  I can do it either by exposing an ioctl which the journal code can 
use, or I can try to use the write barrier (however, the bio layer is going to 
have to ensure the ordering if I do that).

James


--==_Exmh_21289125120
Content-Type: text/plain ; name="sd-cache-2.4.18.diff"; charset=us-ascii
Content-Description: sd-cache-2.4.18.diff
Content-Disposition: attachment; filename="sd-cache-2.4.18.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.160   -> 1.162  
#	   drivers/scsi/sd.h	1.1     -> 1.2    
#	   drivers/scsi/sd.c	1.19    -> 1.21   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/03/08	jejb@mulgrave.(none)	1.161
# sd cache control changes
#   
# - detect cache type on boot and store in extra fields in Scsi_Disk.
# - if cache is write back synchronize on device release.
# - if cache is write back also synchronize on shutdown notifier.
# 
# --------------------------------------------
# 02/03/11	jejb@mulgrave.(none)	1.162
# sd cache control
# 
# - bug fixes
# --------------------------------------------
#
diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Mon Mar 11 12:09:13 2002
+++ b/drivers/scsi/sd.c	Mon Mar 11 12:09:13 2002
@@ -42,6 +42,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/reboot.h>
 
 #include <linux/smp.h>
 
@@ -104,6 +105,10 @@
 static int sd_detect(Scsi_Device *);
 static void sd_detach(Scsi_Device *);
 static int sd_init_command(Scsi_Cmnd *);
+static int sd_synchronize_cache(Scsi_Device *, int);
+static int sd_notifier(struct notifier_block *, unsigned long, void *);
+
+static struct notifier_block sd_notifier_block = {sd_notifier, NULL, 0}; 
 
 static struct Scsi_Device_Template sd_template = {
 	name:"disk",
@@ -549,6 +554,11 @@
 		__MOD_DEC_USE_COUNT(SDev->host->hostt->module);
 	if (sd_template.module)
 		__MOD_DEC_USE_COUNT(sd_template.module);
+
+	/* check that we actually have a write back cache to synchronize */
+	if(rscsi_disks[target].WCE)
+		sd_synchronize_cache(SDev, 1);
+		       
 	return 0;
 }
 
@@ -860,8 +870,6 @@
 	}
 
 	mode_retries = 2;	/* make two attempts to change the cache type */
-
- retry_mode_select:
 	retries = 3;
 	do {
 
@@ -901,60 +909,20 @@
 			print_req_sense("sd", SRpnt);
 		else
 			printk("%s : sense not available. \n", nbuff);
+
+		printk("%s : assuming drive cache: write through\n", nbuff);
+		rscsi_disks[i].WCE = 0;
+		rscsi_disks[i].RCD = 0;
 	} else {
 		const char *types[] = { "write through", "none", "write back", "write back, no read (daft)" };
 		int ct = 0;
 
-		ct = (buffer[6] & 0x01 /* RCD */) | ((buffer[6] & 0x04 /* WCE */) >> 1);
+		rscsi_disks[i].WCE = buffer[6] & 0x04;
+		rscsi_disks[i].RCD = buffer[6] & 0x01;
 
-		printk("%s : checking drive cache: %s \n", nbuff, types[ct]);
-		if(ct != 0x0 && mode_retries-- == 0) {
-			printk("%s : FAILED to change cache to write back, continuing\n", nbuff);
-		}
-		else if(ct != 0x0) {
-			retries = 3;
-			buffer[6] &= (~0x05); /* clear RCD and WCE */
-			do {
-				memset((void *) &cmd[0], 0, 10);
-				cmd[0] = MODE_SELECT;
-				cmd[1] = (rscsi_disks[i].device->scsi_level <= SCSI_2) ?
-					((rscsi_disks[i].device->lun << 5) & 0xe0) : 0;
-				cmd[1] |= 0x10;	/* PF */
-				cmd[4] = 24;	/* allocation length */
-				
-				
-				SRpnt->sr_cmd_len = 0;
-				SRpnt->sr_sense_buffer[0] = 0;
-				SRpnt->sr_sense_buffer[2] = 0;
-				
-				SRpnt->sr_data_direction = SCSI_DATA_WRITE;
-				scsi_wait_req(SRpnt, (void *) cmd, (void *) buffer,
-					      24, SD_TIMEOUT, MAX_RETRIES);
+		ct =  rscsi_disks[i].RCD + 2*rscsi_disks[i].WCE;
 
-				the_result = SRpnt->sr_result;
-				retries--;
-
-			} while (the_result && retries);
-
-			if (the_result) {
-				printk("%s : MODE SELECT failed.\n"
-				       "%s : status = %x, message = %02x, host = %d, driver = %02x \n",
-				       nbuff, nbuff,
-				       status_byte(the_result),
-				       msg_byte(the_result),
-				       host_byte(the_result),
-				       driver_byte(the_result)
-				       );
-				if (driver_byte(the_result) & DRIVER_SENSE)
-					print_req_sense("sd", SRpnt);
-				else
-					printk("%s : sense not available. \n", nbuff);
-			} else {
-				printk("%s : changing drive cache to write through\n", nbuff);
-			}
-			goto retry_mode_select;
-		}
-		
+		printk("%s : drive cache: %s\n", nbuff, types[ct]);
 	}
 
 	retries = 3;
@@ -1491,8 +1459,13 @@
 
 static int __init init_sd(void)
 {
+	int ret;
+
 	sd_template.module = THIS_MODULE;
-	return scsi_register_module(MODULE_SCSI_DEV, &sd_template);
+	ret = scsi_register_module(MODULE_SCSI_DEV, &sd_template);
+	if(ret == 0)
+		register_reboot_notifier(&sd_notifier_block);
+	return ret;
 }
 
 static void __exit exit_sd(void)
@@ -1521,6 +1494,92 @@
 	sd_template.dev_max = 0;
 	if (sd_gendisks != &sd_gendisk)
 		kfree(sd_gendisks);
+
+	unregister_reboot_notifier(&sd_notifier_block);
+}
+
+static int sd_notifier(struct notifier_block *nbt, unsigned long event, void *buf)
+{
+	Scsi_Disk *dpnt;
+	int i;
+
+	if (!(event == SYS_RESTART || event == SYS_HALT 
+	      || event == SYS_POWER_OFF))
+		return NOTIFY_DONE;
+	for (dpnt = rscsi_disks, i = 0; i < sd_template.dev_max; i++, dpnt++) {
+		if (!dpnt->device)
+			continue;
+		if (dpnt->WCE)
+			sd_synchronize_cache(dpnt->device, 1);
+	}
+
+	return NOTIFY_OK;
+}
+
+/* send a SYNCHRONIZE CACHE instruction down to the device through the
+ * normal SCSI command structure.  Wait for the command to complete (must
+ * have user context) */
+static int sd_synchronize_cache(Scsi_Device *SDpnt, int verbose)
+{
+	Scsi_Request *SRpnt;
+	int retries, the_result;
+
+	if(verbose) {
+		/* we actually want an sd name, so this awful lookup
+		 * is only done if verbose is specified */
+		int i;
+		char buf[16];
+		Scsi_Disk *dpnt;
+
+		for (dpnt = rscsi_disks, i = 0; i < sd_template.dev_max; i++, dpnt++) {
+		if (dpnt->device == SDpnt)
+			break;
+		}
+		/* no error checking ! */
+		sd_devname(i, buf);
+
+		printk("%s: synchronizing cache...", buf);
+	}
+
+	SRpnt = scsi_allocate_request(SDpnt);
+	if(!SRpnt) {
+		if(verbose)
+			printk("FAILED\n  No memory for request\n");
+		return 0;
+	}
+		
+
+	for(retries = 3; retries > 0; --retries) {
+		unsigned char cmd[10] = { 0 };
+
+		cmd[0] = SYNCHRONIZE_CACHE;
+		cmd[1] = SDpnt->scsi_level <= SCSI_2 ? (SDpnt->lun << 5) & 0xe0 : 0;
+		/* leave the rest of the command zero to indicate 
+		 * flush everything */
+		scsi_wait_req(SRpnt, (void *)cmd, NULL, 0,
+			      SD_TIMEOUT, MAX_RETRIES);
+
+		if(SRpnt->sr_result == 0)
+			break;
+	}
+
+	the_result = SRpnt->sr_result;
+	scsi_release_request(SRpnt);
+	if(verbose) {
+		if(the_result == 0) {
+			printk("OK\n");
+		} else {
+			printk("FAILED\n  status = %x, message = %02x, host = %d, driver = %02x\n  ",
+			       status_byte(the_result),
+			       msg_byte(the_result),
+			       host_byte(the_result),
+			       driver_byte(the_result));
+			if (driver_byte(the_result) & DRIVER_SENSE)
+				print_req_sense("sd", SRpnt);
+
+		}
+	}
+	return (the_result == 0);
 }
 
 module_init(init_sd);
diff -Nru a/drivers/scsi/sd.h b/drivers/scsi/sd.h
--- a/drivers/scsi/sd.h	Mon Mar 11 12:09:13 2002
+++ b/drivers/scsi/sd.h	Mon Mar 11 12:09:13 2002
@@ -33,6 +33,8 @@
 	unsigned char sector_bit_size;	/* sector_size = 2 to the  bit size power */
 	unsigned char sector_bit_shift;		/* power of 2 sectors per FS block */
 	unsigned has_part_table:1;	/* has partition table */
+        unsigned WCE:1;         /* state of disk WCE bit */
+        unsigned RCD:1;         /* state of disk RCD bit */
 } Scsi_Disk;
 
 extern int revalidate_scsidisk(kdev_t dev, int maxusage);

--==_Exmh_21289125120--



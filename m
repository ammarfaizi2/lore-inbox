Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVGKT1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVGKT1e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVGKT1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:27:30 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:62928 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S262295AbVGKT1Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:27:24 -0400
Date: Mon, 11 Jul 2005 15:27:22 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
cc: "'Stefano Rivoir'" <s.rivoir@gts.it>,
       "'Kernel development list'" <linux-kernel@vger.kernel.org>,
       "'USB development list'" <linux-usb-devel@lists.sourceforge.net>
Subject: RE: [linux-usb-devel] Kernel unable to read partition table on US
 B Memory Key
In-Reply-To: <40BC5D4C2DD333449FBDE8AE961E0C334F9385@psexc03.nbnz.co.nz>
Message-ID: <Pine.LNX.4.44L0.0507111506570.6399-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005, Roberts-Thomson, James wrote:

> OK, it turns out that for this particular key, a two second pause after
> "sd_spinup_disk" is called and before "sd_read_capacity" will make it work.
> The 'dmesg' (or syslog) output is still ugly, however; but once I realised
> that it was "sd_spinup_disk" that:
> 
> A) needed the delay, and 
> B) causes the first ugly message to be printed in the first place, then a
> better patch came to mind.
> 
> So, after combining Alan's suggestion to use "msleep" rather than my
> previous convoluted method, and moving the location of the pause to inside
> sd_spinup_disk (and targeting it to remove the first "ugly"), I came up with
> a better patch, which is attached.
> 
> This patch adds the module parameter 'firmware_delay', and will cause a
> pause for "firmware_delay" seconds inside sd_spinup_disk when the first SCSI
> command returns UNIT_ATTENTION as the sense key.
> 
> Again, I have deliberately made the default value for this parameter 0,
> which means that the end-user will need to ensure insmod or modprobe
> supplies a >0 value to firmware_delay before the patch takes effect.
> 
> I'm not sure what the procedure is for getting this patch officially
> recognised for inclusion into the kernel - Alan, are you able to "sponsor"
> this patch for inclusion?

How about the patch below instead?  It's a bit easier to use, in that it 
doesn't require users to know about a new parameter.  Also it retries at 
1-second intervals for up to 5 seconds, which makes it a little more 
flexible.  If this works for you, I'll submit it for inclusion in the 
official kernel.

Alan Stern


Index: usb-2.6/drivers/scsi/sd.c
===================================================================
--- usb-2.6.orig/drivers/scsi/sd.c
+++ usb-2.6/drivers/scsi/sd.c
@@ -987,7 +987,7 @@ static void
 sd_spinup_disk(struct scsi_disk *sdkp, char *diskname,
 	       struct scsi_request *SRpnt, unsigned char *buffer) {
 	unsigned char cmd[10];
-	unsigned long spintime_value = 0;
+	unsigned long spintime_expire = 0;
 	int retries, spintime;
 	unsigned int the_result;
 	struct scsi_sense_hdr sshdr;
@@ -1074,12 +1074,27 @@ sd_spinup_disk(struct scsi_disk *sdkp, c
 				scsi_wait_req(SRpnt, (void *)cmd, 
 					      (void *) buffer, 0/*512*/, 
 					      SD_TIMEOUT, SD_MAX_RETRIES);
-				spintime_value = jiffies;
+				spintime_expire = jiffies + 100 * HZ;
+				spintime = 1;
 			}
-			spintime = 1;
 			/* Wait 1 second for next try */
 			msleep(1000);
 			printk(".");
+
+		/*
+		 * Wait for USB flash devices with slow firmware.
+		 * Yes, this sense key/ASC combination shouldn't
+		 * occur here.  It's typical of these devices.
+		 */
+		} else if (sense_valid &&
+				sshdr.sense_key == UNIT_ATTENTION &&
+				sshdr.asc == 0x28) {
+			if (!spintime) {
+				spintime_expire = jiffies + 5 * HZ;
+				spintime = 1;
+			}
+			/* Wait 1 second for next try */
+			msleep(1000);
 		} else {
 			/* we don't understand the sense code, so it's
 			 * probably pointless to loop */
@@ -1091,8 +1106,7 @@ sd_spinup_disk(struct scsi_disk *sdkp, c
 			break;
 		}
 				
-	} while (spintime &&
-		 time_after(spintime_value + 100 * HZ, jiffies));
+	} while (spintime && time_before_eq(jiffies, spintime_expire));
 
 	if (spintime) {
 		if (scsi_status_is_good(the_result))


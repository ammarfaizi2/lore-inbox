Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbTDJUaj (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 16:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTDJUae (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 16:30:34 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:25275 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264155AbTDJUaZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 16:30:25 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Date: Thu, 10 Apr 2003 13:39:49 -0700
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_DQA5HE8VWMM26WEVJU0F"
Message-Id: <200304101339.49895.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_DQA5HE8VWMM26WEVJU0F
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Here is the (sd) patch to support > 4000 disks on 32-bit dev_t work
in 2.5.67-mm tree.

This patch addresses the backward compatibility with device nodes
issue. All the new disks will be addressed by only last major.

SCSI has 16 majors. Each major supports 16 disks currently.
This patch leaves this assumption for first 15 majors and all the
new disks addressable by 32/64 dev_t work will be added to
SCSI last major#. This way, we don't need to create device
nodes in /dev, if you switch between 2.4 and 2.5.

Any comments ?

Thanks,
Badari



--------------Boundary-00=_DQA5HE8VWMM26WEVJU0F
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sd.new"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sd.new"

--- linux-2.5.67/drivers/scsi/sd.c	Wed Apr  9 13:12:38 2003
+++ linux-2.5.67.new/drivers/scsi/sd.c	Thu Apr 10 13:23:49 2003
@@ -56,7 +56,9 @@
  * Remaining dev_t-handling stuff
  */
 #define SD_MAJORS	16
-#define SD_DISKS	(SD_MAJORS << 4)
+#define SD_DISKS	((SD_MAJORS - 1) << 4)
+#define LAST_MAJOR_DISKS	(1 << (KDEV_MINOR_BITS - 4))
+#define TOTAL_SD_DISKS	(SD_DISKS + LAST_MAJOR_DISKS)
 
 /*
  * Time out in seconds for disks and Magneto-opticals (which are slower).
@@ -85,7 +87,7 @@ struct scsi_disk {
 static LIST_HEAD(sd_devlist);
 static spinlock_t sd_devlist_lock = SPIN_LOCK_UNLOCKED;
 
-static unsigned long sd_index_bits[SD_DISKS / BITS_PER_LONG];
+static unsigned long sd_index_bits[TOTAL_SD_DISKS / BITS_PER_LONG];
 static spinlock_t sd_index_lock = SPIN_LOCK_UNLOCKED;
 
 static void sd_init_onedisk(struct scsi_disk * sdkp, struct gendisk *disk);
@@ -123,7 +125,10 @@ static int sd_major(int major_idx)
 	case 1 ... 7:
 		return SCSI_DISK1_MAJOR + major_idx - 1;
 	case 8 ... 15:
-		return SCSI_DISK8_MAJOR + major_idx;
+		return SCSI_DISK8_MAJOR + major_idx - 8;
+#define MAX_IDX	(TOTAL_SD_DISKS >> 4)
+	case 16 ... MAX_IDX:
+		return SCSI_DISK15_MAJOR;
 	default:
 		BUG();
 		return 0;	/* shut up gcc */
@@ -1313,8 +1318,8 @@ static int sd_attach(struct scsi_device 
 		goto out_free;
 
 	spin_lock(&sd_index_lock);
-	index = find_first_zero_bit(sd_index_bits, SD_DISKS);
-	if (index == SD_DISKS) {
+	index = find_first_zero_bit(sd_index_bits, TOTAL_SD_DISKS);
+	if (index == TOTAL_SD_DISKS) {
 		spin_unlock(&sd_index_lock);
 		error = -EBUSY;
 		goto out_put;
@@ -1329,15 +1334,25 @@ static int sd_attach(struct scsi_device 
 
 	gd->de = sdp->de;
 	gd->major = sd_major(index >> 4);
-	gd->first_minor = (index & 15) << 4;
+#define DISKS_PER_MINOR_MASK	((1 << (KDEV_MINOR_BITS - 4)) - 1)
+	if (index > SD_DISKS) 
+		gd->first_minor = ((index - SD_DISKS) & DISKS_PER_MINOR_MASK) << 4;
+	else
+		gd->first_minor = (index & 15) << 4;
 	gd->minors = 16;
 	gd->fops = &sd_fops;
 
-	if (index >= 26) {
+	if (index < 26) {
+		sprintf(gd->disk_name, "sd%c", 'a' + index % 26);
+	} else if (index < (26*27)) {
 		sprintf(gd->disk_name, "sd%c%c",
 			'a' + index/26-1,'a' + index % 26);
 	} else {
-		sprintf(gd->disk_name, "sd%c", 'a' + index % 26);
+		const unsigned int m1 = (index/ 26 - 1) / 26 - 1;
+		const unsigned int m2 = (index / 26 - 1) % 26;
+		const unsigned int m3 = index % 26;
+		sprintf(gd->disk_name, "sd%c%c%c", 
+			'a' + m1, 'a' + m2, 'a' + m3);
 	}
 
 	sd_init_onedisk(sdkp, gd);
 

--------------Boundary-00=_DQA5HE8VWMM26WEVJU0F--


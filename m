Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269641AbRHQE2w>; Fri, 17 Aug 2001 00:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269643AbRHQE2m>; Fri, 17 Aug 2001 00:28:42 -0400
Received: from phnx1-blk2-hfc-0251-d1db10f1.rdc1.az.coxatwork.com ([209.219.16.241]:24021
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S269641AbRHQE2e>; Fri, 17 Aug 2001 00:28:34 -0400
Message-ID: <008901c126d5$425d60f0$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix 2.4.8-ac6 brokenness
Date: Thu, 16 Aug 2001 21:29:52 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch you included in -ac6 from Neil Brown for fs/partitions/check.c was
a quick&dirty thing he wrote up on the mailing list, and it does not work at
all. In fact, with that patch in place disk_name() will never call devfs to
generate a disk name path at all, because of the way the unit number is
computed. Attached is the patch that I created a couple of days ago when I
first found this problem; it corrects the problem and also removes some
extraneous code from disk_name().

--- fs/partitions/check.old Wed Aug 15 10:09:50 2001
+++ fs/partitions/check.c Wed Aug 15 10:24:15 2001
@@ -96,12 +96,11 @@

 char *disk_name (struct gendisk *hd, int minor, char *buf)
 {
- unsigned int part;
  const char *maj = hd->major_name;
- int unit = (minor >> hd->minor_shift) + 'a';
+ unsigned int unit = (minor >> hd->minor_shift);
+ unsigned int part = (minor & ((1 << hd->minor_shift) - 1));

- part = minor & ((1 << hd->minor_shift) - 1);
- if (hd->part[minor].de) {
+ if ((unit < hd->nr_real) && (hd->part[minor].de)) {
   int pos;

   pos = devfs_generate_path (hd->part[minor].de, buf, 64);
@@ -111,7 +110,7 @@

 #ifdef CONFIG_ARCH_S390
  if (genhd_dasd_name
-     && genhd_dasd_name (buf, unit - 'a', part, hd) == 0)
+     && genhd_dasd_name (buf, unit, part, hd) == 0)
   return buf;
 #endif
  /*
@@ -142,11 +141,11 @@
    maj = "hd";
    break;
   case MD_MAJOR:
-   sprintf(buf, "%s%d", maj, unit - 'a');
+   sprintf(buf, "%s%d", maj, unit);
    return buf;
  }
  if (hd->major >= SCSI_DISK1_MAJOR && hd->major <= SCSI_DISK7_MAJOR) {
-  unit = unit + (hd->major - SCSI_DISK1_MAJOR + 1) * 16;
+  unit = unit + 'a' + (hd->major - SCSI_DISK1_MAJOR + 1) * 16;
   if (unit > 'z') {
    unit -= 'z' + 1;
    sprintf(buf, "sd%c%c", 'a' + unit / 26, 'a' + unit % 26);
@@ -157,47 +156,39 @@
  }
  if (hd->major >= COMPAQ_SMART2_MAJOR && hd->major <=
COMPAQ_SMART2_MAJOR+7) {
   int ctlr = hd->major - COMPAQ_SMART2_MAJOR;
-   int disk = minor >> hd->minor_shift;
-   int part = minor & (( 1 << hd->minor_shift) - 1);
    if (part == 0)
-    sprintf(buf, "%s/c%dd%d", maj, ctlr, disk);
+    sprintf(buf, "%s/c%dd%d", maj, ctlr, unit);
    else
-    sprintf(buf, "%s/c%dd%dp%d", maj, ctlr, disk, part);
+    sprintf(buf, "%s/c%dd%dp%d", maj, ctlr, unit, part);
    return buf;
   }
  if (hd->major >= COMPAQ_CISS_MAJOR && hd->major <= COMPAQ_CISS_MAJOR+7) {
                 int ctlr = hd->major - COMPAQ_CISS_MAJOR;
-                int disk = minor >> hd->minor_shift;
-                int part = minor & (( 1 << hd->minor_shift) - 1);
                 if (part == 0)
-                        sprintf(buf, "%s/c%dd%d", maj, ctlr, disk);
+                        sprintf(buf, "%s/c%dd%d", maj, ctlr, unit);
                 else
-                        sprintf(buf, "%s/c%dd%dp%d", maj, ctlr, disk,
part);
+                        sprintf(buf, "%s/c%dd%dp%d", maj, ctlr, unit,
part);
                 return buf;
  }
  if (hd->major >= DAC960_MAJOR && hd->major <= DAC960_MAJOR+7) {
   int ctlr = hd->major - DAC960_MAJOR;
-   int disk = minor >> hd->minor_shift;
-   int part = minor & (( 1 << hd->minor_shift) - 1);
    if (part == 0)
-    sprintf(buf, "%s/c%dd%d", maj, ctlr, disk);
+    sprintf(buf, "%s/c%dd%d", maj, ctlr, unit);
    else
-    sprintf(buf, "%s/c%dd%dp%d", maj, ctlr, disk, part);
+    sprintf(buf, "%s/c%dd%dp%d", maj, ctlr, unit, part);
    return buf;
   }
  if (hd->major == ATARAID_MAJOR) {
-   int disk = minor >> hd->minor_shift;
-   int part = minor & (( 1 << hd->minor_shift) - 1);
    if (part == 0)
-    sprintf(buf, "%s/d%d", maj, disk);
+    sprintf(buf, "%s/d%d", maj, unit);
    else
-    sprintf(buf, "%s/d%dp%d", maj, disk, part);
+    sprintf(buf, "%s/d%dp%d", maj, unit, part);
    return buf;
   }
  if (part)
-  sprintf(buf, "%s%c%d", maj, unit, part);
+  sprintf(buf, "%s%c%d", maj, unit + 'a', part);
  else
-  sprintf(buf, "%s%c", maj, unit);
+  sprintf(buf, "%s%c", maj, unit + 'a');
  return buf;
 }



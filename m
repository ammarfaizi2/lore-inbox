Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbTFRKbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 06:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbTFRKbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 06:31:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:30436 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265133AbTFRKbI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 06:31:08 -0400
Subject: [PATCH] /proc/stat doesn't display stats for more than 16 devices
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-kesrSm7sxCLgzT/nafNA"
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jun 2003 16:15:30 +0530
Message-Id: <1055933133.4507.26.camel@nhari>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kesrSm7sxCLgzT/nafNA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

Currently, /proc/stat doesn't display statistics correctly if there are
more than 16 devices connected. Tests with more than 16 SCSI devices
show that /proc/stat displays statistics only for the first 16 devices.

This is because of the way the disk stats array has been implemented.
There is no room to capture the additional SCSI majors in the array. The
following patch corrects this behavior. It also makes a small adjustment
in the disk_index funtion to parse the additional majors correctly.

Also, this was first observed while using iostat. A small change is
needed in iostat as well to make it work properly. I am attaching the
iostat patch along with this.

The kernel patch is at the 2.4.2* level and the iostat (sysstat
actually) is at 4.0.* level. Both /proc/stat and iostat work correctly
after these changes.

Kindly review.

--- kernel_stat.h.org	2003-05-19 16:58:39.000000000 +0530
+++ kernel_stat.h	2003-05-19 17:03:41.000000000 +0530
@@ -12,7 +12,7 @@
  * used by rstatd/perfmeter
  */
 
-#define DK_MAX_MAJOR 16
+#define DK_MAX_MAJOR 256
 #define DK_MAX_DISK 16
 
 struct kernel_stat {
--- genhd.h.org	2003-05-19 16:58:48.000000000 +0530
+++ genhd.h	2003-05-19 17:04:01.000000000 +0530
@@ -298,6 +298,13 @@
 			index = (minor & 0x00f8) >> 3;
 			break;
 		case SCSI_DISK0_MAJOR:
+		case SCSI_DISK1_MAJOR:
+		case SCSI_DISK2_MAJOR:
+		case SCSI_DISK3_MAJOR:
+		case SCSI_DISK4_MAJOR:
+		case SCSI_DISK5_MAJOR:
+		case SCSI_DISK6_MAJOR:
+		case SCSI_DISK7_MAJOR:
 			index = (minor & 0x00f0) >> 4;
 			break;
 		case IDE0_MAJOR:	/* same as HD_MAJOR */


Regards,
Hari



--=-kesrSm7sxCLgzT/nafNA
Content-Disposition: attachment; filename=iostat.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=iostat.patch; charset=ISO-8859-1

--- iostat.c.org	Wed May 28 13:48:20 2003
+++ iostat.c	Wed May 28 13:46:42 2003
@@ -107,7 +107,7 @@
 void read_stat(int curr, int flags)
 {
    FILE *statfp;
-   char line[1024];
+   char line[8192];
    int pos, i;
    unsigned int v_tmp[3], v_major, v_index;
 #if 0
@@ -122,7 +122,7 @@
       exit(2);
    }
=20
-   while (fgets(line, 1024, statfp) !=3D NULL) {
+   while (fgets(line, 8192, statfp) !=3D NULL) {
=20
       if (!strncmp(line, "cpu ", 4)) {
 	 /*
@@ -245,7 +245,7 @@
 {
    FILE *partfp;
    int i;
-   char line[1024];
+   char line[8192];
    struct disk_stats part;
    struct disk_hdr_stats part_hdr;
=20
@@ -255,7 +255,7 @@
       exit(2);
    }
=20
-   while (fgets(line, 1024, partfp) !=3D NULL) {
+   while (fgets(line, 8192, partfp) !=3D NULL) {
=20
       if (sscanf(line, "%*d %*d %*d %63s %d %d %d %d %d %d %d %d %*d %d %d=
",
 	     part_hdr.name,	/* No need to read major and minor numbers */

--=-kesrSm7sxCLgzT/nafNA--


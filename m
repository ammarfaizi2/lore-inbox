Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281484AbRLAHIq>; Sat, 1 Dec 2001 02:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283966AbRLAHIh>; Sat, 1 Dec 2001 02:08:37 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:23458 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281484AbRLAHIX>; Sat, 1 Dec 2001 02:08:23 -0500
Subject: [PATCH] Enhancement of /proc/partitions output (2.5.1-pre5)
To: torvalds@transmeta.com
Date: Sat, 1 Dec 2001 07:08:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E16A4G6-0003bf-00@libra.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please consider below patch which adds the starting sector and number of
sectors to /proc/partitions.

It works fine here and I find having this information output can be very
useful (especially when the values in the kernel don't match the values
output by fdisk for example).

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


diff -u -urN linux-2.5.1-pre5-vanilla/drivers/block/genhd.c l251p5/drivers/block/genhd.c
--- linux-2.5.1-pre5-vanilla/drivers/block/genhd.c	Sat Dec  1 06:09:57 2001
+++ l251p5/drivers/block/genhd.c	Sat Dec  1 03:57:57 2001
@@ -149,7 +149,8 @@
 	char buf[64];
 	int len, n;
 
-	len = sprintf(page, "major minor  #blocks  name\n\n");
+	len = sprintf(page, "major minor   #blocks  start_sect   nr_sects  "
+			"name\n\n");
 	read_lock(&gendisk_lock);
 	for (gp = gendisk_head; gp; gp = gp->next) {
 		for (n = 0; n < (gp->nr_real << gp->minor_shift); n++) {
@@ -157,8 +158,10 @@
 				continue;
 
 			len += snprintf(page + len, 63,
-					"%4d  %4d %10d %s\n",
+					"%4d  %4d %10d  %10lu %10lu  %s\n",
 					gp->major, n, gp->sizes[n],
+					gp->part[n].start_sect,
+					gp->part[n].nr_sects,
 					disk_name(gp, n, buf));
 			if (len < offset)
 				offset -= len, len = 0;


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263253AbTCNEU0>; Thu, 13 Mar 2003 23:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263252AbTCNEUZ>; Thu, 13 Mar 2003 23:20:25 -0500
Received: from smtp.comcast.net ([24.153.64.2]:53654 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S263248AbTCNEUU>;
	Thu, 13 Mar 2003 23:20:20 -0500
Date: Thu, 13 Mar 2003 23:31:02 -0500
From: "R. Scott Bailey" <rscottbailey@comcast.net>
Subject: PATCH: raid1 on alpha
To: mingo@redhat.com, neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       scott.bailey@eds.com
Message-id: <002d01c2e9e2$855de880$0201a8c0@spiffy>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Driven by desperation :-) I have churned out a patch that works around a
long-standing problem with software RAID1 on Alpha platforms. gcc (at least
2.95 and 3.2) generated code for alpha apparently has a problem that is
exercised by the form of the loops in raid1_read_balance.

My admittedly lame patch, against 2.4.20, has been working for my SMP
Alphaserver 4100 for a couple of weeks now without ill effect. (Everything,
including root, on LVM on RAID1.) But I think I cut a corner or two in order
to get it working and keep it simple. I'm hoping a more artful/knowledgeable
programmer can massage this so it is acceptable for inclusion in the
mainline kernels.

Cheers,

	Scott Bailey
	scott.bailey@eds.com | rscottbailey@comcast.net


--- linux-2.4.20/drivers/md/raid1.c	2003-01-17 17:43:45.000000000 -0500
+++ linux-2.4.20-rsb/drivers/md/raid1.c	2003-01-17 17:43:20.000000000 -0500
@@ -11,6 +11,7 @@
  *
  * Fixes to reconstruction by Jakob Østergaard" <jakob@ostenfeld.dk>
  * Various fixes by Neil Brown <neilb@cse.unsw.edu.au>
+ * Spastic hacks on raid1_read_balance by Scott Bailey
<scott.bailey@eds.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -475,6 +476,8 @@
 	int new_disk = conf->last_used;
 	const int sectors = bh->b_size >> 9;
 	const unsigned long this_sector = bh->b_rsector;
+	const int max_disk = conf->raid_disks;
+	const int loop_disk = max_disk - 1; /* optimizer is stooopid */
 	int disk = new_disk;
 	unsigned long new_distance;
 	unsigned long current_distance;
@@ -488,22 +491,18 @@


 	/* make sure that disk is operational */
-	while( !conf->mirrors[new_disk].operational) {
-		if (new_disk <= 0) new_disk = conf->raid_disks;
-		new_disk--;
-		if (new_disk == disk) {
-			/*
-			 * This means no working disk was found
-			 * Nothing much to do, lets not change anything
-			 * and hope for the best...
-			 */
-
-			new_disk = conf->last_used;
+	/* RSB: if not, be simple-minded and choose first readable disk */

-			goto rb_out;
+	if (!conf->mirrors[new_disk].operational) {
+		for (disk = loop_disk; disk >= 0; disk--) {
+			if ((conf->mirrors[disk].operational) &&
+				(!conf->mirrors[disk].write_only)) break;
 		}
+		if (disk < 0) /* If no usable disk was found */
+			goto rb_out;
+		new_disk = disk;
 	}
-	disk = new_disk;
+
 	/* now disk == new_disk == starting point for search */

 	/*
@@ -519,35 +518,26 @@
 	 * This is for kicking those idling disks so that
 	 * they would find work near some hotspot.
 	 */
-
-	if (conf->sect_count >= conf->mirrors[new_disk].sect_limit) {
-		conf->sect_count = 0;

-#if defined(CONFIG_SPARC64) && (__GNUC__ == 2) && (__GNUC_MINOR__ == 92)
-		/* Work around a compiler bug in egcs-2.92.11 19980921 */
-		new_disk = *(volatile int *)&new_disk;
-#endif
-		do {
-			if (new_disk<=0)
-				new_disk = conf->raid_disks;
-			new_disk--;
-			if (new_disk == disk)
-				break;
-		} while ((conf->mirrors[new_disk].write_only) ||
-			 (!conf->mirrors[new_disk].operational));
+	/*
+	 * RSB: Instead of making a scan for some other disk explicitly, just
+	 * mark the head position as being at start of the disk. Then the next
+	 * loop checking for "close" disks is almost certain to pick somebody
+	 * else. Except for hot spots at front of disk, sigh.
+	 */

-		goto rb_out;
+	if (conf->sect_count >= conf->mirrors[new_disk].sect_limit) {
+		conf->sect_count = 0;
+		conf->mirrors[new_disk].head_position = 0;
 	}

-	current_distance = abs(this_sector -
-				conf->mirrors[disk].head_position);
-
 	/* Find the disk which is closest */
+	/* current_distance is initialized to guaranteed worse-than-worst
+	   so that we can simplify loop logic */
+
+	current_distance = conf->mirrors[0].sect_limit + 1;

-	do {
-		if (disk <= 0)
-			disk = conf->raid_disks;
-		disk--;
+	for (disk = loop_disk; disk >= 0; disk--) {

 		if ((conf->mirrors[disk].write_only) ||
 				(!conf->mirrors[disk].operational))
@@ -561,7 +551,7 @@
 			current_distance = new_distance;
 			new_disk = disk;
 		}
-	} while (disk != conf->last_used);
+	}

 rb_out:
 	conf->mirrors[new_disk].head_position = this_sector + sectors;


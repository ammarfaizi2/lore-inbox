Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265062AbUFAOdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbUFAOdP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbUFAOdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:33:15 -0400
Received: from cust.88.114.adsl.cistron.nl ([195.64.88.114]:1546 "EHLO
	gw.wurtel.net") by vger.kernel.org with ESMTP id S265062AbUFAO3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:29:11 -0400
Date: Tue, 1 Jun 2004 16:28:52 +0200
From: Paul Slootman <paul+nospam@wurtel.net>
To: linux-kernel@vger.kernel.org
Subject: floppy oddness in 2.6.7-rc2 [PATCH included]
Message-ID: <20040601142852.GA14985@wurtel.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Scanner: exiscan *1BVAG4-0004GE-00*4kgsifzkTV.*Wurtel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to write to a floppy in /dev/fd0 (1.44MB), it gave a
"No such device or address" error and the kernel logged the message
"kernel: end_request: I/O error, dev fd1, sector 0".

Note I accessed /dev/fd0; the kernel reports an error on fd1

Yes, the /dev/fd0 entry is correct:
wurtel:/tmp# ls -l /dev/fd[01]
brw-rw----    1 root     floppy     2,   0 Dec 29  2001 /dev/fd0
brw-rw----    1 root     floppy     2,   1 Aug  5  2001 /dev/fd1

When booting, this was (correctly) reported:

Floppy drive(s): fd0 is 1.44M, fd1 is 1.2M
FDC 0 is a post-1991 82077

Kernel configured with CONFIG_BLK_DEV_FD=y

When reading /dev/fd0 with a diskette in /dev/fd1, it gives the contents
of /dev/fd1, however, it stops after 4096 bytes. Using /dev/fd1 it reads
the floppy in /dev/fd1 completely.

Giving the diff a quick glance I see this patch to floppy.c:

@@ -4247,35 +4225,40 @@
 int __init floppy_init(void)
 {
 	int i, unit, drive;
-	int err;
+	int err, dr;
 
 	raw_cmd = NULL;
+	i = 0;
 
-	for (i = 0; i < N_DRIVE; i++) {
-		disks[i] = alloc_disk(1);
-		if (!disks[i])
-			goto Enomem;
-
-		disks[i]->major = FLOPPY_MAJOR;
-		disks[i]->first_minor = TOMINOR(i);
-		disks[i]->fops = &floppy_fops;
-		sprintf(disks[i]->disk_name, "fd%d", i);
-
-		init_timer(&motor_off_timer[i]);
-		motor_off_timer[i].data = i;
-		motor_off_timer[i].function = motor_off_callback;
+	for (dr = 0; dr < N_DRIVE; dr++) {
+		disks[dr] = alloc_disk(1);
+		if (!disks[dr]) {
+			err = -ENOMEM;
+			goto out_put_disk;
+		}
+
+		disks[dr]->major = FLOPPY_MAJOR;
+		disks[dr]->first_minor = TOMINOR(i);
+		disks[dr]->fops = &floppy_fops;
+		sprintf(disks[dr]->disk_name, "fd%d", dr);
+
+		init_timer(&motor_off_timer[dr]);
+		motor_off_timer[dr].data = dr;
+		motor_off_timer[dr].function = motor_off_callback;
 	}


I expect this line:
+		disks[dr]->first_minor = TOMINOR(i);
is the problem. i was changed into dr for some reason, however the
TOMINOR(i) is not changed to TOMINOR(dr)
This patch should fix it:

--- linux/drivers/block/floppy.c.orig	2004-05-30 12:53:21.000000000 +0200
+++ linux/drivers/block/floppy.c	2004-06-01 16:26:20.000000000 +0200
@@ -4238,7 +4238,7 @@
 		}
 
 		disks[dr]->major = FLOPPY_MAJOR;
-		disks[dr]->first_minor = TOMINOR(i);
+		disks[dr]->first_minor = TOMINOR(dr);
 		disks[dr]->fops = &floppy_fops;
 		sprintf(disks[dr]->disk_name, "fd%d", dr);
 
I haven't tested it, due to lack of test system at this moment.


Please CC me on responses, as I read through a mail->news gateway that's
not always up to date.

Paul Slootman

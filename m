Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbUDASbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbUDASbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:31:31 -0500
Received: from math.ut.ee ([193.40.5.125]:914 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262257AbUDASaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:30:35 -0500
Date: Thu, 1 Apr 2004 21:30:33 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [2.4 IDE PATCH] only use set_max when it is present
Message-ID: <Pine.GSO.4.44.0404012126180.15708-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Credits to Kaupo Arulo: he debugged why he got ide errors about aborted
commands during disk detection (SanDisk flash) and found that
idedisk_read_native_max_address() is done regardless of whether the
drive supports it. This patch (by him) changes ide-disk.c to only try
set_max when the disk supports host protected area. Tested in 2.4.22 and
compile tested on 2.4.26-rc1.

===== drivers/ide/ide-disk.c 1.15 vs edited =====
--- 1.15/drivers/ide/ide-disk.c	Thu Aug 14 00:14:34 2003
+++ edited/drivers/ide/ide-disk.c	Thu Apr  1 21:14:22 2004
@@ -1161,14 +1161,14 @@
 {
 	struct hd_driveid *id = drive->id;
 	unsigned long capacity = drive->cyl * drive->head * drive->sect;
-	unsigned long set_max = idedisk_read_native_max_address(drive);
+	int have_setmax = idedisk_supports_host_protected_area(drive);
+	unsigned long set_max =
+		(have_setmax ? idedisk_read_native_max_address(drive) : 0);
 	unsigned long long capacity_2 = capacity;
 	unsigned long long set_max_ext;

 	drive->capacity48 = 0;
 	drive->select.b.lba = 0;
-
-	(void) idedisk_supports_host_protected_area(drive);

 	if (id->cfs_enable_2 & 0x0400) {
 		capacity_2 = id->lba_capacity_2;

-- 
Meelis Roos (mroos@linux.ee)


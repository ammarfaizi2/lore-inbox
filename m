Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319186AbSIJPAB>; Tue, 10 Sep 2002 11:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319189AbSIJPAB>; Tue, 10 Sep 2002 11:00:01 -0400
Received: from kim.it.uu.se ([130.238.12.178]:60588 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S319186AbSIJO77>;
	Tue, 10 Sep 2002 10:59:59 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15742.2570.240823.948051@kim.it.uu.se>
Date: Tue, 10 Sep 2002 17:04:42 +0200
To: torvalds@transmeta.com
Subject: [PATCH] 2.5.34 floppy driver init/exit fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.5 floppy driver has for a long time has two init/exit bugs:
1. It calls register_sys_device() on init, but fails to call
   unregister_sys_device() in exit. This leads to data structure
   corruption if floppy is a module and it gets unloaded.
2. If calls register_sys_device() early on init, but fails to call
   unregister_sys_device() if init fails. Again, this leads to
   data structure corruption.

The patch below fixes both these problems. I've used it since 2.5.13
or so. Please apply.
   
/Mikael

diff -ruN linux-2.5.34/drivers/block/floppy.c linux-2.5.34.floppy/drivers/block/floppy.c
--- linux-2.5.34/drivers/block/floppy.c	Mon Sep  9 21:15:28 2002
+++ linux-2.5.34.floppy/drivers/block/floppy.c	Mon Sep  9 21:20:51 2002
@@ -4219,8 +4219,6 @@
 {
 	int i,unit,drive;
 
-	register_sys_device(&device_floppy);
-
 	raw_cmd = NULL;
 
 	devfs_handle = devfs_mk_dir (NULL, "floppy", NULL);
@@ -4347,6 +4345,9 @@
 			register_disk(NULL, mk_kdev(MAJOR_NR,TOMINOR(drive)+i*4),
 					1, &floppy_fops, 0);
 	}
+
+	register_sys_device(&device_floppy);
+
 	return have_no_fdc;
 }
 
@@ -4529,6 +4530,7 @@
 {
 	int dummy;
 		
+	unregister_sys_device(&device_floppy);
 	devfs_unregister (devfs_handle);
 	unregister_blkdev(MAJOR_NR, "fd");
 

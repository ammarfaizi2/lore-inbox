Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319141AbSH2IN1>; Thu, 29 Aug 2002 04:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319142AbSH2IN1>; Thu, 29 Aug 2002 04:13:27 -0400
Received: from CPE-144-132-190-206.nsw.bigpond.net.au ([144.132.190.206]:15745
	"EHLO orthos") by vger.kernel.org with ESMTP id <S319141AbSH2IN0>;
	Thu, 29 Aug 2002 04:13:26 -0400
Subject: [PATCH] 2.5.32 floppy init and misc fixes
From: "Mikolaj J. Habryn" <dichro-evo@rcpt.to>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 29 Aug 2002 18:17:40 +1000
Message-Id: <1030609060.3529.6.camel@orthos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The floppy driver doesn't clean up it's register_sys_device if it fails
to init correctly. The below patch adds the appropriate
unregister_sys_device in the various failure paths, and also includes
Ewan MacMahon's one-liner for working VCs on devfs-only machines, and a
couple of missing #includes. Minimum required to get 2.5.32 working on
my Portege.

m.

--- linux-2.5.32/drivers/char/console.c.orig	2002-08-29 14:07:59.000000000 +1000
+++ linux-2.5.32/drivers/char/console.c	2002-08-29 13:42:07.000000000 +1000
@@ -2526,6 +2526,7 @@
 
 	kbd_init();
 	console_map_init();
+	con_init_devfs();
 	vcs_init();
 	return 0;
 }
--- linux-2.5.32/drivers/block/floppy.c.orig	2002-08-29 16:17:30.000000000 +1000
+++ linux-2.5.32/drivers/block/floppy.c	2002-08-29 16:19:20.000000000 +1000
@@ -4235,6 +4235,7 @@
 	devfs_handle = devfs_mk_dir (NULL, "floppy", NULL);
 	if (register_blkdev(MAJOR_NR,"fd",&floppy_fops)) {
 		printk("Unable to get major %d for floppy\n",MAJOR_NR);
+		unregister_sys_device(&device_floppy);
 		return -EBUSY;
 	}
 
@@ -4269,6 +4270,7 @@
 		unregister_blkdev(MAJOR_NR,"fd");
 		del_timer(&fd_timeout);
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
+		unregister_sys_device(&device_floppy);
 		return -ENODEV;
 	}
 #if N_FDC > 1
@@ -4280,6 +4282,7 @@
 		del_timer(&fd_timeout);
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 		unregister_blkdev(MAJOR_NR,"fd");
+		unregister_sys_device(&device_floppy);
 		return -EBUSY;
 	}
 
@@ -4343,6 +4346,7 @@
 			floppy_release_irq_and_dma();
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 		unregister_blkdev(MAJOR_NR,"fd");
+		unregister_sys_device(&device_floppy);
 	}
 	
 	for (drive = 0; drive < N_DRIVE; drive++) {
--- linux-2.5.32/drivers/net/wireless/hermes.c.orig	2002-08-29 14:55:28.000000000 +1000
+++ linux-2.5.32/drivers/net/wireless/hermes.c	2002-08-29 14:56:03.000000000 +1000
@@ -45,6 +45,7 @@
 #include <linux/threads.h>
 #include <linux/smp.h>
 #include <asm/io.h>
+#include <linux/sched.h>
 #include <linux/ptrace.h>
 #include <linux/delay.h>
 #include <linux/init.h>
--- linux-2.5.32/drivers/char/toshiba.c.orig	2002-08-29 14:09:44.000000000 +1000
+++ linux-2.5.32/drivers/char/toshiba.c	2002-08-29 14:10:09.000000000 +1000
@@ -69,6 +69,7 @@
 #include <linux/init.h>
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
+#include <linux/interrupt.h>
 
 #include <linux/toshiba.h>
 

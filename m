Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbULGPCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbULGPCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbULGPBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:01:07 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:45549 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261823AbULGPA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:00:26 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 7 Dec 2004 15:39:13 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       uml devel <user-mode-linux-devel@lists.sourceforge.net>,
       Jeff Dike <jdike@addtoit.com>,
       Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: [patch] uml: sysfs support for the uml block devices.
Message-ID: <20041207143913.GA23659@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$subject says all ;)

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 arch/um/drivers/ubd_kern.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+)

Index: linux-2004-11-23/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2004-11-23.orig/arch/um/drivers/ubd_kern.c	2004-11-24 12:52:38.000000000 +0100
+++ linux-2004-11-23/arch/um/drivers/ubd_kern.c	2004-11-26 17:29:27.138934607 +0100
@@ -54,6 +54,8 @@
 #include "mem.h"
 #include "mem_kern.h"
 
+#define DRIVER_NAME "uml-blkdev"
+
 static spinlock_t ubd_io_lock = SPIN_LOCK_UNLOCKED;
 static spinlock_t ubd_lock = SPIN_LOCK_UNLOCKED;
 
@@ -117,6 +119,7 @@ struct ubd {
 	struct openflags openflags;
 	int no_cow;
 	struct cow cow;
+	struct platform_device pdev;
 
 	int map_writes;
 	int map_reads;
@@ -585,6 +588,14 @@ static int ubd_new_disk(int major, u64 s
 		sprintf(disk->devfs_name, "ubd_fake/disc%d", unit);
 	}
 
+	/* sysfs register (not for ide fake devices) */
+	if (major == MAJOR_NR) {
+		ubd_dev[unit].pdev.id   = unit;
+		ubd_dev[unit].pdev.name = DRIVER_NAME;
+		platform_device_register(&ubd_dev[unit].pdev);
+		disk->driverfs_dev = &ubd_dev[unit].pdev.dev;
+	}
+
 	disk->private_data = &ubd_dev[unit];
 	disk->queue = ubd_queue;
 	add_disk(disk);
@@ -718,6 +729,7 @@ static int ubd_remove(char *str)
 		fake_gendisk[n] = NULL;
 	}
 
+	platform_device_unregister(&dev->pdev);
 	*dev = ((struct ubd) DEFAULT_UBD);
 	err = 0;
  out:
@@ -740,6 +752,11 @@ static int ubd_mc_init(void)
 
 __initcall(ubd_mc_init);
 
+static struct device_driver ubd_driver = {
+	.name  = DRIVER_NAME,
+	.bus   = &platform_bus_type,
+};
+
 int ubd_init(void)
 {
         int i;
@@ -762,6 +779,7 @@ int ubd_init(void)
 		if (register_blkdev(fake_major, "ubd"))
 			return -1;
 	}
+	driver_register(&ubd_driver);
 	for (i = 0; i < MAX_DEV; i++) 
 		ubd_add(i);
 	return 0;

-- 
#define printk(args...) fprintf(stderr, ## args)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbWFMAea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbWFMAea (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbWFMAe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:34:27 -0400
Received: from ns2.suse.de ([195.135.220.15]:60395 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932692AbWFMAeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:34:08 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 05/16] 64bit resource: fix up printks for resources in mtd drivers
Reply-To: Greg KH <greg@kroah.com>
Date: Mon, 12 Jun 2006 17:31:07 -0700
Message-Id: <11501586942938-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11501586902008-git-send-email-greg@kroah.com>
References: <20060613003033.GA10717@kroah.com> <11501586781628-git-send-email-greg@kroah.com> <1150158683636-git-send-email-greg@kroah.com> <11501586871870-git-send-email-greg@kroah.com> <11501586902008-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed if we wish to change the size of the resource structures.

Based on an original patch from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/mtd/devices/pmc551.c       |    8 ++++----
 drivers/mtd/maps/amd76xrom.c       |    5 +++--
 drivers/mtd/maps/ichxrom.c         |    5 +++--
 drivers/mtd/maps/scx200_docflash.c |    5 +++--
 drivers/mtd/maps/sun_uflash.c      |   10 ++++++----
 5 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/devices/pmc551.c b/drivers/mtd/devices/pmc551.c
index 666cce1..ce2a233 100644
--- a/drivers/mtd/devices/pmc551.c
+++ b/drivers/mtd/devices/pmc551.c
@@ -551,11 +551,11 @@ #ifdef CONFIG_MTD_PMC551_DEBUG
         /*
          * Some screen fun
          */
-        printk(KERN_DEBUG "pmc551: %d%c (0x%x) of %sprefetchable memory at 0x%lx\n",
+        printk(KERN_DEBUG "pmc551: %d%c (0x%x) of %sprefetchable memory at 0x%llx\n",
 	       (size<1024)?size:(size<1048576)?size>>10:size>>20,
                (size<1024)?'B':(size<1048576)?'K':'M',
 	       size, ((dcmd&(0x1<<3)) == 0)?"non-":"",
-               (dev->resource[0].start)&PCI_BASE_ADDRESS_MEM_MASK );
+               (unsigned long long)((dev->resource[0].start)&PCI_BASE_ADDRESS_MEM_MASK));
 
         /*
          * Check to see the state of the memory
@@ -685,8 +685,8 @@ static int __init init_pmc551(void)
                         break;
                 }
 
-                printk(KERN_NOTICE "pmc551: Found PCI V370PDC at 0x%lX\n",
-				    PCI_Device->resource[0].start);
+                printk(KERN_NOTICE "pmc551: Found PCI V370PDC at 0x%llx\n",
+				    (unsigned long long)PCI_Device->resource[0].start);
 
                 /*
                  * The PMC551 device acts VERY weird if you don't init it
diff --git a/drivers/mtd/maps/amd76xrom.c b/drivers/mtd/maps/amd76xrom.c
index c350878..a505870 100644
--- a/drivers/mtd/maps/amd76xrom.c
+++ b/drivers/mtd/maps/amd76xrom.c
@@ -123,9 +123,10 @@ static int __devinit amd76xrom_init_one 
 		window->rsrc.parent = NULL;
 		printk(KERN_ERR MOD_NAME
 			" %s(): Unable to register resource"
-			" 0x%.08lx-0x%.08lx - kernel bug?\n",
+			" 0x%.16llx-0x%.16llx - kernel bug?\n",
 			__func__,
-			window->rsrc.start, window->rsrc.end);
+			(unsigned long long)window->rsrc.start,
+			(unsigned long long)window->rsrc.end);
 	}
 
 #if 0
diff --git a/drivers/mtd/maps/ichxrom.c b/drivers/mtd/maps/ichxrom.c
index ea50737..1673279 100644
--- a/drivers/mtd/maps/ichxrom.c
+++ b/drivers/mtd/maps/ichxrom.c
@@ -177,9 +177,10 @@ static int __devinit ichxrom_init_one (s
 		window->rsrc.parent = NULL;
 		printk(KERN_DEBUG MOD_NAME
 			": %s(): Unable to register resource"
-			" 0x%.08lx-0x%.08lx - kernel bug?\n",
+			" 0x%.16llx-0x%.16llx - kernel bug?\n",
 			__func__,
-			window->rsrc.start, window->rsrc.end);
+			(unsigned long long)window->rsrc.start,
+			(unsigned long long)window->rsrc.end);
 	}
 
 	/* Map the firmware hub into my address space. */
diff --git a/drivers/mtd/maps/scx200_docflash.c b/drivers/mtd/maps/scx200_docflash.c
index 28b8a57..331a158 100644
--- a/drivers/mtd/maps/scx200_docflash.c
+++ b/drivers/mtd/maps/scx200_docflash.c
@@ -164,8 +164,9 @@ static int __init init_scx200_docflash(v
 		outl(pmr, scx200_cb_base + SCx200_PMR);
 	}
 
-       	printk(KERN_INFO NAME ": DOCCS mapped at 0x%lx-0x%lx, width %d\n",
-	       docmem.start, docmem.end, width);
+       	printk(KERN_INFO NAME ": DOCCS mapped at 0x%llx-0x%llx, width %d\n",
+			(unsigned long long)docmem.start,
+			(unsigned long long)docmem.end, width);
 
 	scx200_docflash_map.size = size;
 	if (width == 8)
diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index 0758cb1..9ed42d5 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -74,9 +74,10 @@ int uflash_devinit(struct linux_ebus_dev
 		/* Non-CFI userflash device-- once I find one we
 		 * can work on supporting it.
 		 */
-		printk("%s: unsupported device at 0x%lx (%d regs): " \
+		printk("%s: unsupported device at 0x%llx (%d regs): " \
 			"email ebrower@usa.net\n",
-			UFLASH_DEVNAME, edev->resource[0].start, nregs);
+			UFLASH_DEVNAME,
+			(unsigned long long)edev->resource[0].start, nregs);
 		return -ENODEV;
 	}
 
@@ -132,8 +133,9 @@ static int __init uflash_init(void)
 		for_each_ebusdev(edev, ebus) {
 			if (!strcmp(edev->prom_name, UFLASH_OBPNAME)) {
 				if(0 > prom_getproplen(edev->prom_node, "user")) {
-					DEBUG(2, "%s: ignoring device at 0x%lx\n",
-							UFLASH_DEVNAME, edev->resource[0].start);
+					DEBUG(2, "%s: ignoring device at 0x%llx\n",
+						UFLASH_DEVNAME,
+						(unsigned long long)edev->resource[0].start);
 				} else {
 					uflash_devinit(edev);
 				}
-- 
1.4.0


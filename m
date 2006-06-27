Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161180AbWF0Qkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbWF0Qkj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbWF0Qhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:37:54 -0400
Received: from mx1.suse.de ([195.135.220.2]:26326 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161175AbWF0QhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:37:20 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/17] [PATCH] 64bit resource: fix up printks for resources in mtd drivers
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:41 -0700
Message-Id: <11514260483754-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11514260442539-git-send-email-greg@kroah.com>
References: <20060627163317.GA31073@kroah.com> <11514260331421-git-send-email-greg@kroah.com> <11514260373971-git-send-email-greg@kroah.com> <115142604066-git-send-email-greg@kroah.com> <11514260442539-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed if we wish to change the size of the resource structures.

Based on an original patch from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/mtd/devices/pmc551.c       |    8 ++++----
 drivers/mtd/maps/amd76xrom.c       |    5 +++--
 drivers/mtd/maps/ichxrom.c         |    5 +++--
 drivers/mtd/maps/scx200_docflash.c |    5 +++--
 drivers/mtd/maps/sun_uflash.c      |    5 +++--
 5 files changed, 16 insertions(+), 12 deletions(-)

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
index 24a0315..4db2055 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -62,9 +62,10 @@ int uflash_devinit(struct linux_ebus_dev
 		/* Non-CFI userflash device-- once I find one we
 		 * can work on supporting it.
 		 */
-		printk("%s: unsupported device at 0x%lx (%d regs): " \
+		printk("%s: unsupported device at 0x%llx (%d regs): " \
 			"email ebrower@usa.net\n",
-		       dp->full_name, res->start, edev->num_addrs);
+		       dp->full_name, (unsigned long long)res->start,
+		       edev->num_addrs);
 
 		return -ENODEV;
 	}
-- 
1.4.0


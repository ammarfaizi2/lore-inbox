Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUGRMA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUGRMA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 08:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUGRMA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 08:00:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23488 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263815AbUGRMAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 08:00:54 -0400
Date: Sun, 18 Jul 2004 14:00:48 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: dwmw2@redhat.com
Cc: mtd@infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] MTD: remove some kernel 2.0 and 2.2 #ifdef's
Message-ID: <20040718120048.GW14733@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below (applies against 2.6.8-rc2) removes some #ifdef's for 
kernel 2.0 and 2.2 from the MTD code.

diffstat output:
 drivers/mtd/chips/cfi_cmdset_0020.c |    5 -----
 drivers/mtd/nand/tx4925ndfmc.c      |    8 --------
 drivers/mtd/devices/pmc551.c        |   12 +++---------
 drivers/mtd/nand/autcpu12.c         |    8 --------
 include/linux/mtd/cfi.h             |    2 --
 5 files changed, 3 insertions(+), 32 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc2-full/drivers/mtd/chips/cfi_cmdset_0020.c.old	2004-07-18 13:49:31.000000000 +0200
+++ linux-2.6.8-rc2-full/drivers/mtd/chips/cfi_cmdset_0020.c	2004-07-18 13:49:45.000000000 +0200
@@ -1400,11 +1400,6 @@
 	kfree(cfi);
 }
 
-#if LINUX_VERSION_CODE < 0x20212 && defined(MODULE)
-#define cfi_staa_init init_module
-#define cfi_staa_exit cleanup_module
-#endif
-
 static char im_name[]="cfi_cmdset_0020";
 
 int __init cfi_staa_init(void)
--- mtd/drivers/mtd/devices/pmc551.c	24 Jan 2003 13:34:30 -0000	1.22
+++ mtd/drivers/mtd/devices/pmc551.c	12 Mar 2003 08:57:58 -0000
@@ -108,12 +108,6 @@
 #include <linux/mtd/pmc551.h>
 #include <linux/mtd/compatmac.h>
 
-#if LINUX_VERSION_CODE > 0x20300
-#define PCI_BASE_ADDRESS(dev) (dev->resource[0].start)
-#else
-#define PCI_BASE_ADDRESS(dev) (dev->base_address[0])
-#endif
-
 static struct mtd_info *pmc551list;
 
 static int pmc551_erase (struct mtd_info *mtd, struct erase_info *instr)
@@ -563,7 +557,7 @@
 	       (size<1024)?size:(size<1048576)?size>>10:size>>20,
                (size<1024)?'B':(size<1048576)?'K':'M',
 	       size, ((dcmd&(0x1<<3)) == 0)?"non-":"",
-               PCI_BASE_ADDRESS(dev)&PCI_BASE_ADDRESS_MEM_MASK );
+               (dev->resource[0].start)&PCI_BASE_ADDRESS_MEM_MASK );
 
         /*
          * Check to see the state of the memory
@@ -698,7 +692,7 @@
                 }
 
                 printk(KERN_NOTICE "pmc551: Found PCI V370PDC at 0x%lX\n",
-				    PCI_BASE_ADDRESS(PCI_Device));
+				    PCI_Device->resource[0].start);
 
                 /*
                  * The PMC551 device acts VERY weird if you don't init it
@@ -752,7 +746,7 @@
 			printk(KERN_NOTICE "pmc551: Using specified aperture size %dM\n", asize>>20);
 			priv->asize = asize;
 		}
-                priv->start = ioremap((PCI_BASE_ADDRESS(PCI_Device)
+                priv->start = ioremap(((PCI_Device->resource[0].start)
                                        & PCI_BASE_ADDRESS_MEM_MASK),
                                       priv->asize);
 		
--- mtd/drivers/mtd/nand/autcpu12.c	20 Feb 2003 13:39:38 -0000	1.9
+++ mtd/drivers/mtd/nand/autcpu12.c	12 Mar 2003 08:58:00 -0000
@@ -42,14 +42,6 @@
  */
 static struct mtd_info *autcpu12_mtd = NULL;
 
-/*
- * Module stuff
- */
-#if LINUX_VERSION_CODE < 0x20212 && defined(MODULE)
-#define autcpu12_init init_module
-#define autcpu12_cleanup cleanup_module
-#endif
-
 static int autcpu12_io_base = CS89712_VIRT_BASE;
 static int autcpu12_fio_pbase = AUTCPU12_PHYS_SMC;
 static int autcpu12_fio_ctrl = AUTCPU12_SMC_SELECT_OFFSET;
--- linux-2.6.8-rc2-full/drivers/mtd/nand/tx4925ndfmc.c.old	2004-07-18 13:53:28.000000000 +0200
+++ linux-2.6.8-rc2-full/drivers/mtd/nand/tx4925ndfmc.c	2004-07-18 13:53:41.000000000 +0200
@@ -40,14 +40,6 @@
 static struct mtd_info *tx4925ndfmc_mtd = NULL;
 
 /*
- * Module stuff
- */
-#if LINUX_VERSION_CODE < 0x20212 && defined(MODULE)
-#define tx4925ndfmc_init init_module
-#define tx4925ndfmc_cleanup cleanup_module
-#endif
-
-/*
  * Define partitions for flash devices
  */
 
--- mtd/include/linux/mtd/cfi.h	5 Sep 2002 05:15:32 -0000	1.32
+++ mtd/include/linux/mtd/cfi.h	12 Mar 2003 08:58:13 -0000
@@ -457,14 +457,12 @@
 
 static inline void cfi_udelay(int us)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
 	unsigned long t = us * HZ / 1000000;
 	if (t) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(t);
 		return;
 	}
-#endif
 	udelay(us);
 	cond_resched();
 }


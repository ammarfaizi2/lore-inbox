Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269645AbRHTWMV>; Mon, 20 Aug 2001 18:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269646AbRHTWMM>; Mon, 20 Aug 2001 18:12:12 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:43142 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S269645AbRHTWMC>; Mon, 20 Aug 2001 18:12:02 -0400
Date: Mon, 20 Aug 2001 15:12:17 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: lnz@dandelion.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: linux-2.4.9/drivers/block/DAC960.c to new module_{init,exit} interface
Message-ID: <20010820151217.A4863@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>I don't see any patch present as part of this message...

	Oops!  Sorry.  Here is the patch.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="DAC960.diffs"

--- linux-2.4.9/drivers/block/DAC960.c	Mon Aug  6 10:34:38 2001
+++ linux/drivers/block/DAC960.c	Sun Aug 19 06:22:08 2001
@@ -41,6 +41,7 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/pci.h>
+#include <linux/init.h>
 #include <asm/io.h>
 #include <asm/segment.h>
 #include <asm/uaccess.h>
@@ -2534,7 +2535,7 @@
   DAC960_Initialize initializes the DAC960 Driver.
 */
 
-void DAC960_Initialize(void)
+static int __init DAC960_Initialize(void)
 {
   int ControllerNumber;
   DAC960_DetectControllers(DAC960_BA_Controller);
@@ -2543,7 +2544,7 @@
   DAC960_DetectControllers(DAC960_PG_Controller);
   DAC960_DetectControllers(DAC960_PD_Controller);
   DAC960_SortControllers();
-  if (DAC960_ActiveControllerCount == 0) return;
+  if (DAC960_ActiveControllerCount == 0) return -ENODEV;
   for (ControllerNumber = 0;
        ControllerNumber < DAC960_ControllerCount;
        ControllerNumber++)
@@ -2559,6 +2560,7 @@
     }
   DAC960_CreateProcEntries();
   register_reboot_notifier(&DAC960_NotifierBlock);
+  return (DAC960_ActiveControllerCount > 0 ? 0 : -ENODEV);
 }
 
 
@@ -6609,24 +6611,10 @@
 }
 
 
-/*
-  Include Module support if requested.
-*/
-
-#ifdef MODULE
-
-
-int init_module(void)
-{
-  DAC960_Initialize();
-  return (DAC960_ActiveControllerCount > 0 ? 0 : -1);
-}
-
-
-void cleanup_module(void)
+void __exit DAC960_Exit(void)
 {
   DAC960_Finalize(&DAC960_NotifierBlock, SYS_RESTART, NULL);
 }
 
-
-#endif
+module_init(DAC960_Initialize);
+module_exit(DAC960_Exit);
--- linux-2.4.9/drivers/block/genhd.c	Thu Jul 19 17:48:15 2001
+++ linux/drivers/block/genhd.c	Mon Aug 20 07:33:10 2001
@@ -18,9 +18,6 @@
 #include <linux/init.h>
 
 extern int blk_dev_init(void);
-#ifdef CONFIG_BLK_DEV_DAC960
-extern void DAC960_Initialize(void);
-#endif
 #ifdef CONFIG_FUSION_BOOT
 extern int fusion_init(void);
 #endif
@@ -37,9 +34,6 @@
 	sti();
 #ifdef CONFIG_I2O
 	i2o_init();
-#endif
-#ifdef CONFIG_BLK_DEV_DAC960
-	DAC960_Initialize();
 #endif
 #ifdef CONFIG_FUSION_BOOT
 	fusion_init();

--/9DWx/yDrRhgMJTb--

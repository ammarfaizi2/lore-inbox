Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbRBGPGu>; Wed, 7 Feb 2001 10:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129186AbRBGPGb>; Wed, 7 Feb 2001 10:06:31 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:15626 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S129130AbRBGPGV>;
	Wed, 7 Feb 2001 10:06:21 -0500
Date: Wed, 7 Feb 2001 10:06:19 -0500
From: Zach Brown <zab@zabbo.net>
To: linux-kernel@vger.kernel.org
Subject: maestro3 patch, resent
Message-ID: <20010207100619.A8529@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

duh.  I sent this to rutgers originally..

--- 

Date: Mon, 5 Feb 2001 07:42:25 -0500
From: Zach Brown <zab@zabbo.net>
To: linux-kernel@vger.rutgers.edu
Subject: [PATCH] maestro3 2.4.1-ac2 shutdown fix

Its a wonder that anyone lets me write code.

The following fixes a goofy shutdown problem with the 2.4 maestro3 driver
as it appears in Alan's 2.4.1-ac2 patch.   If power management was
disabled the maestro3 driver would oops trying to save the dsp state as
the machine shut down.  

The full source for the up to date 2.4 driver can be found at:

	http://www.zabbo.net/maestro3/maestro3-2.4-20010204.tar.gz

thanks again to Andres Salomon for continuing to report my dumb bugs.
Hopefully this will be the last of the trivial bugs, this driver needs
some real meaningful cleaning up..

-- 
 zach

--- maestro3.c	Mon Feb  5 06:51:58 2001
+++ maestro3.c	Mon Feb  5 07:40:53 2001
@@ -28,6 +28,8 @@
  * Shouts go out to Mike "DJ XPCom" Ang.
  *
  * History
+ *  v1.21 - Feb 04 2001 - Zach Brown <zab@zabbo.net>
+ *   fix up really dumb notifier -> suspend oops
  *  v1.20 - Jan 30 2001 - Zach Brown <zab@zabbo.net>
  *   get rid of pm callback and use pci_dev suspend/resume instead
  *   m3_probe cleanups, including pm oops think-o
@@ -147,7 +149,7 @@
 
 #define M_DEBUG 1
 
-#define DRIVER_VERSION      "1.20"
+#define DRIVER_VERSION      "1.21"
 #define M3_MODULE_NAME      "maestro3"
 #define PFX                 M3_MODULE_NAME ": "
 
@@ -2763,7 +2765,6 @@
 static void m3_suspend(struct pci_dev *pci_dev)
 {
     unsigned long flags;
-    int index;
     int i;
     struct m3_card *card = pci_dev->driver_data;
 
@@ -2788,15 +2789,18 @@
 
     m3_assp_halt(card);
 
-    index = 0;
-    DPRINTK(DPMOD, "saving code\n");
-    for(i = REV_B_CODE_MEMORY_BEGIN ; i <= REV_B_CODE_MEMORY_END; i++)
-        card->suspend_mem[index++] = 
-            m3_assp_read(card, MEMTYPE_INTERNAL_CODE, i);
-    DPRINTK(DPMOD, "saving data\n");
-    for(i = REV_B_DATA_MEMORY_BEGIN ; i <= REV_B_DATA_MEMORY_END; i++)
-        card->suspend_mem[index++] = 
-            m3_assp_read(card, MEMTYPE_INTERNAL_DATA, i);
+    if(card->suspend_mem) {
+        int index = 0;
+
+        DPRINTK(DPMOD, "saving code\n");
+        for(i = REV_B_CODE_MEMORY_BEGIN ; i <= REV_B_CODE_MEMORY_END; i++)
+            card->suspend_mem[index++] = 
+                m3_assp_read(card, MEMTYPE_INTERNAL_CODE, i);
+        DPRINTK(DPMOD, "saving data\n");
+        for(i = REV_B_DATA_MEMORY_BEGIN ; i <= REV_B_DATA_MEMORY_END; i++)
+            card->suspend_mem[index++] = 
+                m3_assp_read(card, MEMTYPE_INTERNAL_DATA, i);
+    }
 
     DPRINTK(DPMOD, "powering down apci regs\n");
     m3_outw(card, 0xffff, 0x54);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

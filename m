Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129494AbRBIQwK>; Fri, 9 Feb 2001 11:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129943AbRBIQwA>; Fri, 9 Feb 2001 11:52:00 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:50189 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S129494AbRBIQvu>;
	Fri, 9 Feb 2001 11:51:50 -0500
Date: Fri, 9 Feb 2001 11:51:48 -0500
From: Zach Brown <zab@zabbo.net>
To: dilinger@mp3revolution.net
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, torvalds@transmeta.com
Subject: Re: [PATCH] maestro3 still oopses?
Message-ID: <20010209115148.B20335@tetsuo.zabbo.net>
In-Reply-To: <20010208223103.A432@incandescent.mp3revolution.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010208223103.A432@incandescent.mp3revolution.net>; from dilinger@mp3revolution.net on Thu, Feb 08, 2001 at 10:31:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The maestro3 driver, included in 2.4.2-pre2 (which I assume is the
> same as maestro3-2.4-20010204.tar.gz, I haven't bothered to try it;
> I'm perfectly happy w/ my patch), oopses upon shutdown.

the maestro3 snapshot in 2.4.2pre2 is not up to date.  I imagine it came
from alan, who got the jan30 patch, but didn't get the trivial feb 04
patch that fixes the oops you're seeing.

the proper patch to 2.4.2-pre2 (and 2.4ac-current, presumably)
is attached.  Does it fix you problem?  [it tries to do so without
duplicating code, you'll notice.]

> + *   use pci_module_init() instead of pci_register_driver().

I'd rather do this in a seperate patch that does lots of other cleanups
that are pending.

- z

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

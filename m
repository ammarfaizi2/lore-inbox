Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129306AbRBIDdO>; Thu, 8 Feb 2001 22:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129316AbRBIDdF>; Thu, 8 Feb 2001 22:33:05 -0500
Received: from saloma.stu.rpi.edu ([128.113.199.230]:5124 "HELO
	incandescent.mp3revolution.net") by vger.kernel.org with SMTP
	id <S129306AbRBIDcu>; Thu, 8 Feb 2001 22:32:50 -0500
From: dilinger@mp3revolution.net
Date: Thu, 8 Feb 2001 22:31:03 -0500
To: zab@zabbo.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] maestro3 still oopses?
Message-ID: <20010208223103.A432@incandescent.mp3revolution.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux incandescent 2.4.2-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The maestro3 driver, included in 2.4.2-pre2 (which I assume is the
same as maestro3-2.4-20010204.tar.gz, I haven't bothered to try it;
I'm perfectly happy w/ my patch), oopses upon shutdown.

I'm submitting my patch again, both to the maestro3 maintainer,
and to lk this time; please see fit to assimilate it into the official
driver release.

It's diff'd against an older maestro3 release (jan 30); it appears
as though the only changes in the new maestro3 release (feb 04) is
to fix this shutdown oops.

Both the patch (maestro3.c.diff) and Zach's original release
(maestro3-2.4-20010130.tar.gz) can be found at:

http://incandescent.mp3revolution.net/kernel/maestro3/.

There is a slight change between my originally submitted patch
and the patch attached was to increment the DRIVER_VERSION, which
I forgot to do initially.


-- 
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition
        -- found in the .sig of Rob Riggs, rriggs@tesser.com

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="maestro3.c.diff"

--- maestro3.c.old	Tue Jan 30 14:39:44 2001
+++ maestro3.c	Thu Feb  8 22:17:00 2001
@@ -28,6 +28,11 @@
  * Shouts go out to Mike "DJ XPCom" Ang.
  *
  * History
+ *  v1.22 - Jan 31 2001 - Andres Salomon <dilinger@mp3revolution.net>
+ *   changed m3_notifier() to shut down device manually, instead
+ *   of calling m3_suspend().. the state saving stuff caused
+ *   oopses on machines w/ pm disabled.
+ *   use pci_module_init() instead of pci_register_driver().
  *  v1.20 - Jan 30 2001 - Zach Brown <zab@zabbo.net>
  *   get rid of pm callback and use pci_dev suspend/resume instead
  *   m3_probe cleanups, including pm oops think-o
@@ -147,7 +152,7 @@
 
 #define M_DEBUG 1
 
-#define DRIVER_VERSION      "1.20"
+#define DRIVER_VERSION      "1.22"
 #define M3_MODULE_NAME      "maestro3"
 #define PFX                 M3_MODULE_NAME ": "
 
@@ -277,6 +282,11 @@
     wait_queue_head_t suspend_queue;
 };
 
+
+static int m3_notifier(struct notifier_block *nb, unsigned long event, void *buf);
+static void m3_suspend(struct pci_dev *pci_dev);
+static void check_suspend(struct m3_card *card);
+
 /*
  * an arbitrary volume we set the internal
  * volume settings to so that the ac97 volume
@@ -353,17 +363,11 @@
     return r;
 }
 
-static struct m3_card *devs = NULL;
-
-/*
- * I'm not very good at laying out functions in a file :)
- */
-static int m3_notifier(struct notifier_block *nb, unsigned long event, void *buf);
-static void m3_suspend(struct pci_dev *pci_dev);
-static void check_suspend(struct m3_card *card);
 
+static struct m3_card *devs = NULL;
 struct notifier_block m3_reboot_nb = {m3_notifier, NULL, 0};
 
+
 static void m3_outw(struct m3_card *card,
         u16 value, unsigned long reg)
 {
@@ -2750,12 +2754,32 @@
 static int m3_notifier(struct notifier_block *nb, unsigned long event, void *buf)
 {
     struct m3_card *card;
+    int i;
 
     DPRINTK(DPMOD, "notifier suspending all cards\n");
 
-    for(card = devs; card != NULL; card = card->next) {
-        if(!card->in_suspend)
-            m3_suspend(card->pcidev); /* XXX legal? */
+    for (card = devs; card != NULL; card = card->next) {
+        if (!card->in_suspend) {
+            for (i=0;i<NR_DSPS;i++) {
+                struct m3_state *s = &card->channels[i];
+
+                if (s->dev_audio == -1)
+                    continue;
+
+                DPRINTK(DPMOD, "stop_adc/dac() device %d\n",i);
+                stop_dac(s);
+                stop_adc(s);
+            }
+
+            mdelay(10); /* give the assp a chance to idle.. */
+
+            m3_assp_halt(card);
+
+            DPRINTK(DPMOD, "powering down apci regs\n");
+            m3_outw(card, 0xffff, 0x54);
+            m3_outw(card, 0xffff, 0x56);
+
+        }
     }
     return 0;
 }
@@ -2906,21 +2930,15 @@
 
 static int __init m3_init_module(void)
 {
-    if (!pci_present())   /* No PCI bus in this machine! */
-        return -ENODEV;
-
+    int status;
+   
     printk(KERN_INFO PFX "version " DRIVER_VERSION " built at " __TIME__ " " __DATE__ "\n");
 
-    if (register_reboot_notifier(&m3_reboot_nb)) {
-        printk(KERN_WARNING PFX "reboot notifier registration failed\n");
-        return -ENODEV; /* ? */
-    }
+    status = pci_module_init(&m3_pci_driver);
+    if (status == 0)
+        register_reboot_notifier(&m3_reboot_nb); /* never fails */
 
-    if (!pci_register_driver(&m3_pci_driver)) {
-        pci_unregister_driver(&m3_pci_driver);
-        return -ENODEV;
-    }
-    return 0;
+    return status;
 }
 
 static void __exit m3_cleanup_module(void)

--vkogqOf2sHV7VnPd--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

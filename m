Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRA3GYF>; Tue, 30 Jan 2001 01:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129175AbRA3GXq>; Tue, 30 Jan 2001 01:23:46 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:16143 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S129143AbRA3GXn>;
	Tue, 30 Jan 2001 01:23:43 -0500
Date: Tue, 30 Jan 2001 14:53:39 -0500
From: Zach Brown <zab@zabbo.net>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Subject: [PATCH] maestro3 PM update
Message-ID: <20010130145339.A29153@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This gets rid of the PM callback maestro3 was using to catch
suspend/resume events, and just uses the pci_dev callbacks instead.
It has minor cleanups in the _probe() path, including a braindead
oops fix.  It works on my laptop, but I'd really appreciate it seeing
more testing.

Alan, could you queue this for 2.4-testing and eventually Linus?

[most of the patch is noise from code blocks moving around :/]

Thanks to Andres Salomon for pointing out the oops case and motivating
the cleanup..

-- 
 zach

--- maestro3.c-1.10	Wed Jan 31 00:45:54 2001
+++ maestro3.c	Wed Jan 31 00:39:44 2001
@@ -28,6 +28,9 @@
  * Shouts go out to Mike "DJ XPCom" Ang.
  *
  * History
+ *  v1.20 - Jan 30 2001 - Zach Brown <zab@zabbo.net>
+ *   get rid of pm callback and use pci_dev suspend/resume instead
+ *   m3_probe cleanups, including pm oops think-o
  *  v1.10 - Jan 6 2001 - Zach Brown <zab@zabbo.net>
  *   revert to lame remap_page_range mmap() just to make it work
  *   record mmap fixed.
@@ -134,7 +137,6 @@
 #include <asm/hardirq.h>
 #include <linux/spinlock.h>
 #include <linux/ac97_codec.h>
-#include <linux/pm.h>
 
  /*
   * for crizappy mmap()
@@ -145,7 +147,7 @@
 
 #define M_DEBUG 1
 
-#define DRIVER_VERSION      "1.10"
+#define DRIVER_VERSION      "1.20"
 #define M3_MODULE_NAME      "maestro3"
 #define PFX                 M3_MODULE_NAME ": "
 
@@ -356,9 +358,8 @@
 /*
  * I'm not very good at laying out functions in a file :)
  */
-static int m3_pm_callback(struct pm_dev *dev, pm_request_t req, void *data);
 static int m3_notifier(struct notifier_block *nb, unsigned long event, void *buf);
-static int m3_suspend(struct m3_card *card);
+static void m3_suspend(struct pci_dev *pci_dev);
 static void check_suspend(struct m3_card *card);
 
 struct notifier_block m3_reboot_nb = {m3_notifier, NULL, 0};
@@ -2585,10 +2586,8 @@
     u32 n;
     int i;
     struct m3_card *card = NULL;
-    int num = 0;
     int ret = 0;
     int card_type = pci_id->driver_data;
-    struct pm_dev *pmdev;
 
     DPRINTK(DPMOD, "in maestro_install\n");
 
@@ -2606,7 +2605,7 @@
         printk(KERN_WARNING PFX "out of memory\n");
         return -ENOMEM;
     }
-    memset(card, 0, sizeof(*card));
+    memset(card, 0, sizeof(struct m3_card));
     card->pcidev = pci_dev;
     init_waitqueue_head(&card->suspend_queue);
 
@@ -2677,7 +2676,6 @@
             printk(KERN_WARNING PFX "initing a dsp device that is already in use?\n");
         /* register devices */
         if ((s->dev_audio = register_sound_dsp(&m3_audio_fops, -1)) < 0) {
-            num = i;
             break;
         }
     }
@@ -2690,20 +2688,11 @@
         goto out;
     }
 
-    pmdev = pm_register(PM_PCI_DEV, PM_PCI_ID(pci_dev), m3_pm_callback);
-
-    if( pmdev == NULL) {
-        printk(KERN_WARNING PFX "couldn't register pm callback, suspend/resume might not work.\n");
-        /* XXX do error stuff :) */
-    }
-
-    pmdev->data = card;
+    pci_dev->driver_data = card;
 
     m3_enable_ints(card);
     m3_assp_continue(card);
 
-    printk(KERN_INFO PFX "%d channels configured.\n", num);
-
 out:
     if(ret) {
         if(card->iobase)
@@ -2729,7 +2718,6 @@
 {
     struct m3_card *card;
 
-    pm_unregister_all(m3_pm_callback);
     unregister_reboot_notifier(&m3_reboot_nb);
 
     while ((card = devs)) {
@@ -2767,72 +2755,17 @@
 
     for(card = devs; card != NULL; card = card->next) {
         if(!card->in_suspend)
-            m3_suspend(card);
-    }
-    return 0;
-}
-
-MODULE_AUTHOR("Zach Brown <zab@zabbo.net>");
-MODULE_DESCRIPTION("ESS Maestro3/Allegro Driver");
-#ifdef M_DEBUG
-MODULE_PARM(debug,"i");
-#endif
-MODULE_PARM(external_amp,"i");
-
-static struct pci_driver m3_pci_driver = {
-    name:       "ess_m3_audio",
-    id_table:   m3_id_table,
-    probe:      m3_probe,
-    remove:     m3_remove,
-};
-
-static int __init m3_init_module(void)
-{
-    if (!pci_present())   /* No PCI bus in this machine! */
-        return -ENODEV;
-
-    printk(KERN_INFO PFX "version " DRIVER_VERSION " built at " __TIME__ " " __DATE__ "\n");
-
-    if (register_reboot_notifier(&m3_reboot_nb)) {
-        printk(KERN_WARNING PFX "reboot notifier registration failed\n");
-        return -ENODEV; /* ? */
-    }
-
-    if (!pci_register_driver(&m3_pci_driver)) {
-        pci_unregister_driver(&m3_pci_driver);
-        return -ENODEV;
+            m3_suspend(card->pcidev); /* XXX legal? */
     }
     return 0;
 }
 
-static void __exit m3_cleanup_module(void)
-{
-    pci_unregister_driver(&m3_pci_driver);
-}
-
-module_init(m3_init_module);
-module_exit(m3_cleanup_module);
-
-void check_suspend(struct m3_card *card)
-{
-    DECLARE_WAITQUEUE(wait, current);
-
-    if(!card->in_suspend) 
-        return;
-
-    card->in_suspend++;
-    add_wait_queue(&card->suspend_queue, &wait);
-    current->state = TASK_UNINTERRUPTIBLE;
-    schedule();
-    remove_wait_queue(&card->suspend_queue, &wait);
-    current->state = TASK_RUNNING;
-}
-
-static int m3_suspend(struct m3_card *card)
+static void m3_suspend(struct pci_dev *pci_dev)
 {
     unsigned long flags;
     int index;
     int i;
+    struct m3_card *card = pci_dev->driver_data;
 
     /* must be a better way.. */
     save_flags(flags);
@@ -2872,15 +2805,14 @@
     card->in_suspend = 1;
 
     restore_flags(flags);
-
-    return 0;
 }
 
-static int m3_resume(struct m3_card *card)
+static void m3_resume(struct pci_dev *pci_dev)
 {
     unsigned long flags;
     int index;
     int i;
+    struct m3_card *card = pci_dev->driver_data;
 
     save_flags(flags); /* paranoia */
     cli();
@@ -2954,31 +2886,62 @@
      * when we suspended
      */
     wake_up(&card->suspend_queue);
-
-    return 0;
 }
 
-int m3_pm_callback(struct pm_dev *dev, pm_request_t req, void *data)
-{
-    struct m3_card *card = (struct m3_card *) dev->data;
+MODULE_AUTHOR("Zach Brown <zab@zabbo.net>");
+MODULE_DESCRIPTION("ESS Maestro3/Allegro Driver");
+#ifdef M_DEBUG
+MODULE_PARM(debug,"i");
+#endif
+MODULE_PARM(external_amp,"i");
 
-    DPRINTK(DPMOD, "APM event 0x%x received on card 0x%p\n",
-            req, card);
+static struct pci_driver m3_pci_driver = {
+    name:       "ess_m3_audio",
+    id_table:   m3_id_table,
+    probe:      m3_probe,
+    remove:     m3_remove,
+    suspend:    m3_suspend,
+    resume:     m3_resume,
+};
 
-    if(card == NULL)
-        return 0;
+static int __init m3_init_module(void)
+{
+    if (!pci_present())   /* No PCI bus in this machine! */
+        return -ENODEV;
 
-    switch(req) {
-        case PM_SUSPEND:
-            m3_suspend(card);
-            break;
+    printk(KERN_INFO PFX "version " DRIVER_VERSION " built at " __TIME__ " " __DATE__ "\n");
 
-        case PM_RESUME:
-            m3_resume(card);
-            break;
-        default: 
-            break;
+    if (register_reboot_notifier(&m3_reboot_nb)) {
+        printk(KERN_WARNING PFX "reboot notifier registration failed\n");
+        return -ENODEV; /* ? */
     }
 
+    if (!pci_register_driver(&m3_pci_driver)) {
+        pci_unregister_driver(&m3_pci_driver);
+        return -ENODEV;
+    }
     return 0;
+}
+
+static void __exit m3_cleanup_module(void)
+{
+    pci_unregister_driver(&m3_pci_driver);
+}
+
+module_init(m3_init_module);
+module_exit(m3_cleanup_module);
+
+void check_suspend(struct m3_card *card)
+{
+    DECLARE_WAITQUEUE(wait, current);
+
+    if(!card->in_suspend) 
+        return;
+
+    card->in_suspend++;
+    add_wait_queue(&card->suspend_queue, &wait);
+    current->state = TASK_UNINTERRUPTIBLE;
+    schedule();
+    remove_wait_queue(&card->suspend_queue, &wait);
+    current->state = TASK_RUNNING;
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

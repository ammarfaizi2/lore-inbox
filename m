Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276745AbRJHB2N>; Sun, 7 Oct 2001 21:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276746AbRJHB1z>; Sun, 7 Oct 2001 21:27:55 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:20623 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S276745AbRJHB1g>; Sun, 7 Oct 2001 21:27:36 -0400
Date: Sun, 7 Oct 2001 21:28:01 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200110080128.f981S1P32470@devserv.devel.redhat.com>
To: Tim.Stadelmann@physics.ox.ac.uk, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dell Latitude C600 suspend problem
In-Reply-To: <mailman.1002472081.27755.linux-kernel2news@redhat.com>
In-Reply-To: <20011007115712.A4357@univn10.univ.ox.ac.uk> <E15qEdC-0005tB-00@the-village.bc.nu> <20011007170957.A536@univn10.univ.ox.ac.uk> <mailman.1002472081.27755.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Tim Stadelmann

> In any case, here's the patch:

Looks good, but I'd prefer just a tiny bit better.

1. asm-i386 instead of asm in filenames
2. replace space with tabs - Arjan used xterm paste or something?
3. I hate too long lines

The root of the evil is that the declaration of an external was
not in any header (because it would make a header dependent on
pm.h, and for the benefit of some obscure broken BIOS), and
sooner or later a mismatch happened.
Unfortunately, I see no good way to correct that.

-- Pete

diff -ur -X dontdiff linux-2.4.10/arch/i386/kernel/dmi_scan.c linux-2.4.10-e/arch/i386/kernel/dmi_scan.c
--- linux-2.4.10/arch/i386/kernel/dmi_scan.c	Mon Sep 17 22:52:35 2001
+++ linux-2.4.10-e/arch/i386/kernel/dmi_scan.c	Sun Oct  7 18:02:46 2001
@@ -369,15 +369,14 @@
  * was disabled before the suspend. Linux gets terribly confused by that.
  */
 
-typedef void (pm_kbd_func) (void);
-extern pm_kbd_func *pm_kbd_request_override;
+extern pm_callback pm_kbd_request_override;
 
 static __init int broken_ps2_resume(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_VT
 	if (pm_kbd_request_override == NULL)
 	{
-		pm_kbd_request_override = pckbd_pm_resume;
+		pm_kbd_request_override = pckbd_pm_callback;
 		printk(KERN_INFO "%s machine detected. Mousepad Resume Bug workaround enabled.\n", d->ident);
 	}
 #endif	
diff -ur -X dontdiff linux-2.4.10/drivers/char/keyboard.c linux-2.4.10-e/drivers/char/keyboard.c
--- linux-2.4.10/drivers/char/keyboard.c	Tue Sep 18 13:39:51 2001
+++ linux-2.4.10-e/drivers/char/keyboard.c	Sun Oct  7 18:12:45 2001
@@ -911,8 +911,6 @@
 EXPORT_SYMBOL(keyboard_tasklet);
 DECLARE_TASKLET_DISABLED(keyboard_tasklet, kbd_bh, 0);
 
-typedef void (pm_kbd_func) (void);
-
 pm_callback pm_kbd_request_override = NULL;
 
 int __init kbd_init(void)
@@ -937,7 +935,7 @@
 
 	tasklet_enable(&keyboard_tasklet);
 	tasklet_schedule(&keyboard_tasklet);
-	
+
 	pm_kbd = pm_register(PM_SYS_DEV, PM_SYS_KBC, pm_kbd_request_override);
 
 	return 0;
diff -ur -X dontdiff linux-2.4.10/drivers/char/pc_keyb.c linux-2.4.10-e/drivers/char/pc_keyb.c
--- linux-2.4.10/drivers/char/pc_keyb.c	Mon Sep 17 22:52:35 2001
+++ linux-2.4.10-e/drivers/char/pc_keyb.c	Sun Oct  7 17:57:43 2001
@@ -397,29 +397,33 @@
 	    return 0200;
 }
 
-void pckbd_pm_resume(void)
+int pckbd_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
 {
 #if defined CONFIG_PSMOUSE
        unsigned long flags;
 
-       if (queue) {                    /* Aux port detected */
-               if (aux_count == 0) {   /* Mouse not in use */ 
-                       spin_lock_irqsave(&kbd_controller_lock, flags);
-                       /*
-                        * Dell Lat. C600 A06 enables mouse after resume.
-                        * When user touches the pad, it posts IRQ 12
-                        * (which we do not process), thus holding keyboard.
-                        */
-                       kbd_write_command(KBD_CCMD_MOUSE_DISABLE);
-                       /* kbd_write_cmd(AUX_INTS_OFF); */ /* Config & lock */
-                       kb_wait();
-                       kbd_write_command(KBD_CCMD_WRITE_MODE);
-                       kb_wait();
-                       kbd_write_output(AUX_INTS_OFF);
-                       spin_unlock_irqrestore(&kbd_controller_lock, flags);
-               }
-       }
-#endif       
+	if (rqst != PM_RESUME)
+		return 0;
+
+	if (queue) {			/* Aux port detected */
+		if (aux_count == 0) {	/* Mouse not in use */ 
+			spin_lock_irqsave(&kbd_controller_lock, flags);
+			/*
+			 * Dell Lat. C600 A06 enables mouse after resume.
+			 * When user touches the pad, it posts IRQ 12
+			 * (which we do not process), thus holding keyboard.
+			 */
+			kbd_write_command(KBD_CCMD_MOUSE_DISABLE);
+			/* kbd_write_cmd(AUX_INTS_OFF); */ /* Config & lock */
+			kb_wait();
+			kbd_write_command(KBD_CCMD_WRITE_MODE);
+			kb_wait();
+			kbd_write_output(AUX_INTS_OFF);
+			spin_unlock_irqrestore(&kbd_controller_lock, flags);
+		}
+	}
+#endif
+	return 0;
 }
 
 
diff -ur -X dontdiff linux-2.4.10/include/asm-i386/keyboard.h linux-2.4.10-e/include/asm-i386/keyboard.h
--- linux-2.4.10/include/asm-i386/keyboard.h	Sun Sep 23 10:31:59 2001
+++ linux-2.4.10-e/include/asm-i386/keyboard.h	Sun Oct  7 17:53:28 2001
@@ -28,7 +28,7 @@
 extern char pckbd_unexpected_up(unsigned char keycode);
 extern void pckbd_leds(unsigned char leds);
 extern void pckbd_init_hw(void);
-extern void pckbd_pm_resume(void);
+extern int pckbd_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data);
 extern unsigned char pckbd_sysrq_xlate[128];
 
 #define kbd_setkeycode		pckbd_setkeycode

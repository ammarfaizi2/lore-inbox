Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSFDFI7>; Tue, 4 Jun 2002 01:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316459AbSFDFI6>; Tue, 4 Jun 2002 01:08:58 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:53339 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316423AbSFDFHz>; Tue, 4 Jun 2002 01:07:55 -0400
Date: Tue, 4 Jun 2002 01:07:56 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
Subject: Patch for broken Dell C600 and I5000
Message-ID: <20020604010756.A32059@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

Some time ago I had to work around broken BIOS in Dell C600
and Linus accepted the patch (it was before Marcelo, IIRC). All this
time BIOS writers continued to search for the bottom in the barrel
of brokenness and now we have I5000 brain damaged in a similar way.
Since I5000 is broken even before it sleeps, I made a different
workaround.

Attached patch implements the new workaround and removes the old one.

Please comment. If nobody objects I'll resend it for Marcelo
and do an equivalent patch for Linus tree.

Cheers,
-- Pete

diff -ur -X dontdiff linux-2.4.19-pre8/arch/i386/kernel/dmi_scan.c linux-2.4.19-pre8-p3/arch/i386/kernel/dmi_scan.c
--- linux-2.4.19-pre8/arch/i386/kernel/dmi_scan.c	Fri May 10 09:28:21 2002
+++ linux-2.4.19-pre8-p3/arch/i386/kernel/dmi_scan.c	Mon Jun  3 15:29:31 2002
@@ -457,26 +457,6 @@
 }
 
 /*
- * Some Bioses enable the PS/2 mouse (touchpad) at resume, even if it
- * was disabled before the suspend. Linux gets terribly confused by that.
- */
-
-typedef void (pm_kbd_func) (void);
-
-static __init int broken_ps2_resume(struct dmi_blacklist *d)
-{
-#ifdef CONFIG_VT
-	if (pm_kbd_request_override == NULL)
-	{
-		pm_kbd_request_override = pckbd_pm_resume;
-		printk(KERN_INFO "%s machine detected. Mousepad Resume Bug workaround enabled.\n", d->ident);
-	}
-#endif
-	return 0;
-}
-
-
-/*
  *	Simple "print if true" callback
  */
  
@@ -503,11 +483,6 @@
 			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
 #endif			
-	{ broken_ps2_resume, "Dell Latitude C600", {	/* Handle problems with APM on the C600 */
-		        MATCH(DMI_SYS_VENDOR, "Dell"),
-			MATCH(DMI_PRODUCT_NAME, "Latitude C600"),
-			NO_MATCH, NO_MATCH
-	                } },
 	{ broken_apm_power, "Dell Inspiron 5000e", {	/* Handle problems with APM on Inspiron 5000e */
 			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			MATCH(DMI_BIOS_VERSION, "A04"),
diff -ur -X dontdiff linux-2.4.19-pre8/drivers/char/keyboard.c linux-2.4.19-pre8-p3/drivers/char/keyboard.c
--- linux-2.4.19-pre8/drivers/char/keyboard.c	Fri May 10 09:28:30 2002
+++ linux-2.4.19-pre8-p3/drivers/char/keyboard.c	Mon Jun  3 15:40:43 2002
@@ -917,10 +917,6 @@
 EXPORT_SYMBOL(keyboard_tasklet);
 DECLARE_TASKLET_DISABLED(keyboard_tasklet, kbd_bh, 0);
 
-typedef void (pm_kbd_func) (void);
-
-pm_callback pm_kbd_request_override = NULL;
-
 int __init kbd_init(void)
 {
 	int i;
@@ -943,8 +939,8 @@
 
 	tasklet_enable(&keyboard_tasklet);
 	tasklet_schedule(&keyboard_tasklet);
-	
-	pm_kbd = pm_register(PM_SYS_DEV, PM_SYS_KBC, pm_kbd_request_override);
+
+	pm_kbd = pm_register(PM_SYS_DEV, PM_SYS_KBC, NULL);
 
 	return 0;
 }
diff -ur -X dontdiff linux-2.4.19-pre8/drivers/char/pc_keyb.c linux-2.4.19-pre8-p3/drivers/char/pc_keyb.c
--- linux-2.4.19-pre8/drivers/char/pc_keyb.c	Fri May 10 09:28:30 2002
+++ linux-2.4.19-pre8-p3/drivers/char/pc_keyb.c	Mon Jun  3 21:47:43 2002
@@ -67,6 +67,7 @@
 static void aux_write_ack(int val);
 static void __aux_write_ack(int val);
 static int aux_reconnect = 0;
+static int aux_pole = 0;
 #endif
 
 static spinlock_t kbd_controller_lock = SPIN_LOCK_UNLOCKED;
@@ -398,35 +399,6 @@
 	    return 0200;
 }
 
-int pckbd_pm_resume(struct pm_dev *dev, pm_request_t rqst, void *data) 
-{
-#if defined CONFIG_PSMOUSE
-       unsigned long flags;
-
-       if (rqst == PM_RESUME) {
-               if (queue) {                    /* Aux port detected */
-                       if (aux_count == 0) {   /* Mouse not in use */ 
-                               spin_lock_irqsave(&kbd_controller_lock, flags);
-			       /*
-				* Dell Lat. C600 A06 enables mouse after resume.
-				* When user touches the pad, it posts IRQ 12
-				* (which we do not process), thus holding keyboard.
-				*/
-			       kbd_write_command(KBD_CCMD_MOUSE_DISABLE);
-			       /* kbd_write_cmd(AUX_INTS_OFF); */ /* Config & lock */
-			       kb_wait();
-			       kbd_write_command(KBD_CCMD_WRITE_MODE);
-			       kb_wait();
-			       kbd_write_output(AUX_INTS_OFF);
-			       spin_unlock_irqrestore(&kbd_controller_lock, flags);
-		       }
-	       }
-       }
-#endif
-       return 0;
-}
-
-
 static inline void handle_mouse_event(unsigned char scancode)
 {
 #ifdef CONFIG_PSMOUSE
@@ -918,6 +890,24 @@
 
 #if defined CONFIG_PSMOUSE
 
+/*
+ * psaux-reconnect
+ *
+ * XXX Someone who knows the story fill this in, please.
+ *
+ * psaux-pole
+ *
+ * On Dell laptops such as Lattitude C600 with BIOS A06 and Inspiron 5000e
+ * with BIOS A08 the 8042 emulator in SMM BIOS is buggy. Sometimes it posts
+ * a mouse event even though we know that it is impossible and IRQ12
+ * handler is not installed. When a key is pressed, the emulator does
+ * not raise IRQ1 until mouse event is read, but we do not read anything,
+ * and keyboard gets locked up.
+ *
+ * The workaround is to emulate Windows and hog the IRQ12 at all times.
+ * The psaux-pole defaults to off to preserve Linux behaviour on sane machines.
+ */
+
 static int __init aux_reconnect_setup (char *str)
 {
 	aux_reconnect = 1;
@@ -926,6 +916,14 @@
 
 __setup("psaux-reconnect", aux_reconnect_setup);
 
+static int __init aux_pole_setup(char *str)
+{
+	aux_pole = 1;
+	return 1;
+}
+
+__setup("psaux-pole", aux_pole_setup);
+
 /*
  * Check if this is a dual port controller.
  */
@@ -1052,9 +1050,11 @@
 		unlock_kernel();
 		return 0;
 	}
-	kbd_write_cmd(AUX_INTS_OFF);			    /* Disable controller ints */
-	kbd_write_command_w(KBD_CCMD_MOUSE_DISABLE);
-	aux_free_irq(AUX_DEV);
+	if (!aux_pole) {
+		kbd_write_cmd(AUX_INTS_OFF);	/* Disable controller ints */
+		kbd_write_command_w(KBD_CCMD_MOUSE_DISABLE);
+		aux_free_irq(AUX_DEV);
+	}
 	unlock_kernel();
 	return 0;
 }
@@ -1064,25 +1064,32 @@
  * Enable auxiliary device.
  */
 
-static int open_aux(struct inode * inode, struct file * file)
+static void psaux_init_hw(void)
 {
-	if (aux_count++) {
-		return 0;
-	}
-	queue->head = queue->tail = 0;		/* Flush input queue */
-	if (aux_request_irq(keyboard_interrupt, AUX_DEV)) {
-		aux_count--;
-		return -EBUSY;
-	}
 	kbd_write_command_w(KBD_CCMD_MOUSE_ENABLE);	/* Enable the
 							   auxiliary port on
 							   controller. */
-	aux_write_ack(AUX_ENABLE_DEV); /* Enable aux device */
-	kbd_write_cmd(AUX_INTS_ON); /* Enable controller ints */
-	
+	aux_write_ack(AUX_ENABLE_DEV);	/* Enable aux device */
+	kbd_write_cmd(AUX_INTS_ON);	/* Enable controller ints */
+
 	mdelay(2);			/* Ensure we follow the kbc access delay rules.. */
 
 	send_data(KBD_CMD_ENABLE);	/* try to workaround toshiba4030cdt problem */
+}
+
+static int open_aux(struct inode * inode, struct file * file)
+{
+	if (aux_count++) {
+		return 0;
+	}
+	queue->head = queue->tail = 0;		/* Flush input queue */
+	if (!aux_pole) {
+		if (aux_request_irq(keyboard_interrupt, AUX_DEV)) {
+			aux_count--;
+			return -EBUSY;
+		}
+		psaux_init_hw();
+	}
 
 	return 0;
 }
@@ -1208,8 +1215,24 @@
 	aux_write_ack(3);			/* 8 counts per mm */
 	aux_write_ack(AUX_SET_SCALE21);		/* 2:1 scaling */
 #endif /* INITIALIZE_MOUSE */
-	kbd_write_command(KBD_CCMD_MOUSE_DISABLE); /* Disable aux device. */
-	kbd_write_cmd(AUX_INTS_OFF); /* Disable controller ints. */
+
+	if (aux_pole) {				/* Tie to the pole (laptop). */
+		if (aux_request_irq(keyboard_interrupt, AUX_DEV)) {
+			printk(KERN_WARNING "Mouse interrupt is busy,"
+			    " continuing in old mode\n");
+			/*
+			 * We are toast, but do last ditch effort to boot.
+			 * Perhaps user has network to access the box.
+			 */
+			aux_pole = 0;
+		}
+	}
+	if (aux_pole) {
+		psaux_init_hw();
+	} else {
+		kbd_write_command(KBD_CCMD_MOUSE_DISABLE); /* Disable aux device. */
+		kbd_write_cmd(AUX_INTS_OFF); /* Disable controller ints. */
+	}
 
 	return 0;
 }
diff -ur -X dontdiff linux-2.4.19-pre8/include/asm-i386/keyboard.h linux-2.4.19-pre8-p3/include/asm-i386/keyboard.h
--- linux-2.4.19-pre8/include/asm-i386/keyboard.h	Thu Nov 22 11:47:23 2001
+++ linux-2.4.19-pre8-p3/include/asm-i386/keyboard.h	Mon Jun  3 15:36:16 2002
@@ -16,7 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/kd.h>
-#include <linux/pm.h>
 #include <asm/io.h>
 
 #define KEYBOARD_IRQ			1
@@ -29,8 +28,6 @@
 extern char pckbd_unexpected_up(unsigned char keycode);
 extern void pckbd_leds(unsigned char leds);
 extern void pckbd_init_hw(void);
-extern int pckbd_pm_resume(struct pm_dev *, pm_request_t, void *);
-extern pm_callback pm_kbd_request_override;
 extern unsigned char pckbd_sysrq_xlate[128];
 
 #define kbd_setkeycode		pckbd_setkeycode
diff -ur -X dontdiff linux-2.4.19-pre8/include/asm-mips/keyboard.h linux-2.4.19-pre8-p3/include/asm-mips/keyboard.h
--- linux-2.4.19-pre8/include/asm-mips/keyboard.h	Fri May 10 09:29:14 2002
+++ linux-2.4.19-pre8-p3/include/asm-mips/keyboard.h	Mon Jun  3 15:36:08 2002
@@ -14,7 +14,6 @@
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/kd.h>
-#include <linux/pm.h>
 
 #define DISABLE_KBD_DURING_INTERRUPTS 0
 
@@ -27,8 +26,6 @@
 extern char pckbd_unexpected_up(unsigned char keycode);
 extern void pckbd_leds(unsigned char leds);
 extern void pckbd_init_hw(void);
-extern int pckbd_pm_resume(struct pm_dev *, pm_request_t, void *);
-extern pm_callback pm_kbd_request_override;
 extern unsigned char pckbd_sysrq_xlate[128];
 extern void kbd_forward_char (int ch);
 
diff -ur -X dontdiff linux-2.4.19-pre8/include/asm-mips64/keyboard.h linux-2.4.19-pre8-p3/include/asm-mips64/keyboard.h
--- linux-2.4.19-pre8/include/asm-mips64/keyboard.h	Fri May 10 09:29:15 2002
+++ linux-2.4.19-pre8-p3/include/asm-mips64/keyboard.h	Mon Jun  3 15:35:58 2002
@@ -14,7 +14,6 @@
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/kd.h>
-#include <linux/pm.h>
 
 #define DISABLE_KBD_DURING_INTERRUPTS 0
 
@@ -27,8 +26,6 @@
 extern char pckbd_unexpected_up(unsigned char keycode);
 extern void pckbd_leds(unsigned char leds);
 extern void pckbd_init_hw(void);
-extern int pckbd_pm_resume(struct pm_dev *, pm_request_t, void *);
-extern pm_callback pm_kbd_request_override;
 extern unsigned char pckbd_sysrq_xlate[128];
 extern void kbd_forward_char (int ch);
 

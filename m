Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276468AbRKAABe>; Wed, 31 Oct 2001 19:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276429AbRKAAB1>; Wed, 31 Oct 2001 19:01:27 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:34543 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S276369AbRKAABQ>;
	Wed, 31 Oct 2001 19:01:16 -0500
Date: Thu, 1 Nov 2001 01:51:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pascal Lengard <pascal.lengard@wanadoo.fr>
Cc: alan@lxorguk.ukuu.org.uk, suonpaa@iki.fi, linux-kernel@vger.kernel.org
Subject: Re: apm suspend broken ?
Message-Id: <20011101015136.084c65cd.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.33.0110310208410.2024-100000@co2.localdomain>
In-Reply-To: <E15yXjJ-0006Hr-00@the-village.bc.nu>
	<Pine.LNX.4.33.0110310208410.2024-100000@co2.localdomain>
X-Mailer: Sylpheed version 0.6.3claws18 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pascal,

On Wed, 31 Oct 2001 02:27:31 +0100 (CET) Pascal Lengard <pascal.lengard@wanadoo.fr> wrote:
>
> 2.4.10-pre11 ==> apm works
> 2.4.10-pre12 ==> apm broken

Can you try the following patch, please?  This is the relevant part of a
patch that was applied to Alan Cox's kernels.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--- 2.4.14-pre5/drivers/char/pc_keyb.c	Mon Sep 24 05:12:49 2001
+++ 2.4.13-ac5/drivers/char/pc_keyb.c	Tue Oct 30 17:42:28 2001
@@ -34,6 +34,7 @@
 #include <linux/vt_kern.h>
 #include <linux/smp_lock.h>
 #include <linux/kd.h>
+#include <linux/pm.h>
 
 #include <asm/keyboard.h>
 #include <asm/bitops.h>
@@ -397,29 +398,32 @@
 	    return 0200;
 }
 
-void pckbd_pm_resume(void)
+int pckbd_pm_resume(struct pm_dev *dev, pm_request_t rqst, void *data) 
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
+       if (rqst == PM_RESUME) {
+               if (queue) {                    /* Aux port detected */
+                       if (aux_count == 0) {   /* Mouse not in use */ 
+                               spin_lock_irqsave(&kbd_controller_lock, flags);
+			       /*
+				* Dell Lat. C600 A06 enables mouse after resume.
+				* When user touches the pad, it posts IRQ 12
+				* (which we do not process), thus holding keyboard.
+				*/
+			       kbd_write_command(KBD_CCMD_MOUSE_DISABLE);
+			       /* kbd_write_cmd(AUX_INTS_OFF); */ /* Config & lock */
+			       kb_wait();
+			       kbd_write_command(KBD_CCMD_WRITE_MODE);
+			       kb_wait();
+			       kbd_write_output(AUX_INTS_OFF);
+			       spin_unlock_irqrestore(&kbd_controller_lock, flags);
+		       }
+	       }
        }
-#endif       
+#endif
+       return 0;
 }
 
 
--- 2.4.14-pre5/include/asm-i386/keyboard.h	Wed Oct 24 22:05:26 2001
+++ 2.4.13-ac5/include/asm-i386/keyboard.h	Tue Oct 30 17:42:41 2001
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/kd.h>
+#include <linux/pm.h>
 #include <asm/io.h>
 
 #define KEYBOARD_IRQ			1
@@ -28,7 +29,8 @@
 extern char pckbd_unexpected_up(unsigned char keycode);
 extern void pckbd_leds(unsigned char leds);
 extern void pckbd_init_hw(void);
-extern void pckbd_pm_resume(void);
+extern int pckbd_pm_resume(struct pm_dev *, pm_request_t, void *);
+extern pm_callback pm_kbd_request_override;
 extern unsigned char pckbd_sysrq_xlate[128];
 
 #define kbd_setkeycode		pckbd_setkeycode

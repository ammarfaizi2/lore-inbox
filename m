Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276430AbRJGQ0L>; Sun, 7 Oct 2001 12:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276408AbRJGQ0C>; Sun, 7 Oct 2001 12:26:02 -0400
Received: from mail.physics.ox.ac.uk ([163.1.244.140]:63240 "EHLO
	janus.physics.ox.ac.uk") by vger.kernel.org with ESMTP
	id <S276430AbRJGQZ4>; Sun, 7 Oct 2001 12:25:56 -0400
Date: Sun, 7 Oct 2001 17:26:17 +0100
From: Tim Stadelmann <Tim.Stadelmann@physics.ox.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dell Latitude C600 suspend problem
Message-ID: <20011007172615.A550@univn10.univ.ox.ac.uk>
In-Reply-To: <20011007115712.A4357@univn10.univ.ox.ac.uk> <E15qEdC-0005tB-00@the-village.bc.nu> <20011007170957.A536@univn10.univ.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011007170957.A536@univn10.univ.ox.ac.uk>
User-Agent: Mutt/1.3.22i
X-AVtransport: scanmails_remote
X-AVwrapper: AMaViS (http://www.amavis.org/)
X-AVscanner: Sophos sweep (http://www.sophos.com/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 05:09:57PM +0100, Tim Stadelmann wrote:

> I've written a little patch (not included yet) that makes
> pckbd_pm_resume behave well in connection with the current incarnation
> of the power management code.  Suspend and resume work again without
> problems.
> 
> Unfortunatly, now the actual tweeks done by the callback seem to
> slightly confuse my keyboard driver...?  Will look into that soon.

Oh well... Can't reproduce the problem any more.  I probably
accidentially hit a couple of keys while reaching for the power
button.

In any case, here's the patch:

--- linux/include/asm/keyboard.h.bak	Sun Oct  7 16:38:23 2001
+++ linux/include/asm/keyboard.h	Sun Oct  7 16:37:45 2001
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/kd.h>
+#include <linux/pm.h>
 #include <asm/io.h>
 
 #define KEYBOARD_IRQ			1
@@ -28,7 +29,7 @@
 extern char pckbd_unexpected_up(unsigned char keycode);
 extern void pckbd_leds(unsigned char leds);
 extern void pckbd_init_hw(void);
-extern void pckbd_pm_resume(void);
+extern int pckbd_pm_resume(struct pm_dev *, pm_request_t, void *);
 extern unsigned char pckbd_sysrq_xlate[128];
 
 #define kbd_setkeycode		pckbd_setkeycode
--- linux/drivers/char/pc_keyb.c.bak	Sun Oct  7 17:18:45 2001
+++ linux/drivers/char/pc_keyb.c	Sun Oct  7 16:37:07 2001
@@ -397,29 +397,32 @@
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
 

				Greetings,

				Tim 



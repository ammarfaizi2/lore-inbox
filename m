Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271667AbRJKGBC>; Thu, 11 Oct 2001 02:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272080AbRJKGAw>; Thu, 11 Oct 2001 02:00:52 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:64790 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271667AbRJKGAj>; Thu, 11 Oct 2001 02:00:39 -0400
Date: Thu, 11 Oct 2001 02:01:12 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Patch to touch up on Dell C600 workaround
Message-ID: <20011011020112.A12557@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim's change was good but it did not go far enough. The root of
the evil was the type mismatch that went undetected because
definitions were not in a header, and, therefore, diverged.

-- Pete

diff -ur -X dontdiff linux-2.4.10-ac10/arch/i386/kernel/dmi_scan.c linux-2.4.10-ac10-e/arch/i386/kernel/dmi_scan.c
--- linux-2.4.10-ac10/arch/i386/kernel/dmi_scan.c	Wed Oct 10 21:51:38 2001
+++ linux-2.4.10-ac10-e/arch/i386/kernel/dmi_scan.c	Wed Oct 10 22:41:10 2001
@@ -7,7 +7,6 @@
 #include <linux/slab.h>
 #include <asm/io.h>
 #include <linux/pm.h>
-#include <linux/keyboard.h>
 #include <asm/keyboard.h>
 #include <asm/system.h>
 
@@ -400,10 +399,6 @@
  * Some Bioses enable the PS/2 mouse (touchpad) at resume, even if it
  * was disabled before the suspend. Linux gets terribly confused by that.
  */
-
-typedef void (pm_kbd_func) (void);
-extern pm_kbd_func *pm_kbd_request_override;
-
 static __init int broken_ps2_resume(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_VT
@@ -412,10 +407,9 @@
 		pm_kbd_request_override = pckbd_pm_resume;
 		printk(KERN_INFO "%s machine detected. Mousepad Resume Bug workaround enabled.\n", d->ident);
 	}
-#endif	
+#endif
 	return 0;
 }
-
 
 
 /*
diff -ur -X dontdiff linux-2.4.10-ac10/include/asm-i386/keyboard.h linux-2.4.10-ac10-e/include/asm-i386/keyboard.h
--- linux-2.4.10-ac10/include/asm-i386/keyboard.h	Wed Oct 10 21:52:11 2001
+++ linux-2.4.10-ac10-e/include/asm-i386/keyboard.h	Wed Oct 10 22:35:36 2001
@@ -30,6 +30,7 @@
 extern void pckbd_leds(unsigned char leds);
 extern void pckbd_init_hw(void);
 extern int pckbd_pm_resume(struct pm_dev *, pm_request_t, void *);
+extern pm_callback pm_kbd_request_override;
 extern unsigned char pckbd_sysrq_xlate[128];
 
 #define kbd_setkeycode		pckbd_setkeycode

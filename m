Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWJIUXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWJIUXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWJIUXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:23:34 -0400
Received: from hoboe2bl1.telenet-ops.be ([195.130.137.73]:46512 "EHLO
	hoboe2bl1.telenet-ops.be") by vger.kernel.org with ESMTP
	id S964822AbWJIUXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:23:33 -0400
Date: Mon, 9 Oct 2006 22:23:31 +0200
Message-Id: <200610092023.k99KNVoQ031477@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 617] m68k/Atari: Interrupt updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Misc Atari fixes:
  - initialize correct number of atari irqs
  - silence vbl interrupt until it's used by atafb
  - use mdelay() to read clock if necessary

Signed-Off-By: Roman Zippel <zippel@linux-m68k.org>
Signed-Off-By: Geert Uytterhoeven <geert@linux-m68k.org>

---
 atari/ataints.c |    9 +++++++--
 atari/time.c    |    9 +++++++--
 kernel/ints.c   |    1 +
 3 files changed, 15 insertions(+), 4 deletions(-)

--- linux/arch/m68k/atari/ataints.c	2006/01/28 21:33:28	1.14
+++ linux/arch/m68k/atari/ataints.c	2006/09/03 14:52:16	1.15
@@ -332,6 +332,9 @@ static void atari_shutdown_irq(unsigned 
 	atari_disable_irq(irq);
 	atari_turnoff_irq(irq);
 	m68k_irq_shutdown(irq);
+
+	if (irq == IRQ_AUTO_4)
+	    vectors[VEC_INT4] = falcon_hblhandler;
 }
 
 static struct irq_controller atari_irq_controller = {
@@ -356,7 +359,7 @@ static struct irq_controller atari_irq_c
 
 void __init atari_init_IRQ(void)
 {
-	m68k_setup_user_interrupt(VEC_USER, 192, NULL);
+	m68k_setup_user_interrupt(VEC_USER, NUM_ATARI_SOURCES - IRQ_USER, NULL);
 	m68k_setup_irq_controller(&atari_irq_controller, 1, NUM_ATARI_SOURCES - 1);
 
 	/* Initialize the MFP(s) */
@@ -403,8 +406,10 @@ void __init atari_init_IRQ(void)
 		 * gets overruns)
 		 */
 
-		if (!MACH_IS_HADES)
+		if (!MACH_IS_HADES) {
 			vectors[VEC_INT2] = falcon_hblhandler;
+			vectors[VEC_INT4] = falcon_hblhandler;
+		}
 	}
 
 	if (ATARIHW_PRESENT(PCM_8BIT) && ATARIHW_PRESENT(MICROWIRE)) {
--- linux/arch/m68k/atari/time.c	2006/01/14 23:07:09	1.1.1.7
+++ linux/arch/m68k/atari/time.c	2006/09/03 14:52:16	1.9
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
+#include <linux/delay.h>
 
 #include <asm/atariints.h>
 
@@ -212,8 +213,12 @@ int atari_tt_hwclk( int op, struct rtc_t
      * additionally the RTC_SET bit is set to prevent an update cycle.
      */
 
-    while( RTC_READ(RTC_FREQ_SELECT) & RTC_UIP )
-        schedule_timeout_interruptible(HWCLK_POLL_INTERVAL);
+    while( RTC_READ(RTC_FREQ_SELECT) & RTC_UIP ) {
+	if (in_atomic() || irqs_disabled())
+	    mdelay(1);
+	else
+	    schedule_timeout_interruptible(HWCLK_POLL_INTERVAL);
+    }
 
     local_irq_save(flags);
     RTC_WRITE( RTC_CONTROL, ctrl | RTC_SET );
--- linux/arch/m68k/kernel/ints.c	2006/01/31 00:57:35	1.10
+++ linux/arch/m68k/kernel/ints.c	2006/09/03 14:52:17	1.11
@@ -132,6 +132,7 @@ void __init m68k_setup_user_interrupt(un
 {
 	int i;
 
+	BUG_ON(IRQ_USER + cnt >= NR_IRQS);
 	m68k_first_user_vec = vec;
 	for (i = 0; i < cnt; i++)
 		irq_controller[IRQ_USER + i] = &user_irq_controller;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264780AbRGDJb0>; Wed, 4 Jul 2001 05:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265793AbRGDJbR>; Wed, 4 Jul 2001 05:31:17 -0400
Received: from yellow.jscc.ru ([195.208.40.129]:3081 "EHLO yellow.jscc.ru")
	by vger.kernel.org with ESMTP id <S264780AbRGDJbI>;
	Wed, 4 Jul 2001 05:31:08 -0400
Message-ID: <005501c1046c$047881b0$4d28d0c3@jscc.ru>
From: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] alpha - generic_init_pit - CTC calibration
Date: Wed, 4 Jul 2001 13:30:51 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Here is the patch against the buggy Cypress RTC which is found on some
Alpha boards. It's tested with 2.2.16 & 2.2.19 kernels and as seems should
work with 2.4.x kernels. This patch differs from initial Ivan's version by
the "cc" variable type & different calibrate divisor usage for better
accuracy.

    Please consider applying this patch against the 2.2.x tree. It's really
needed due to overall performance reasons.

Thanks,
    Oleg.

--- linux/arch/alpha/kernel/time.c.orig Mon Jul  2 14:05:09 2001
+++ linux/arch/alpha/kernel/time.c Mon Jul  2 15:47:45 2001
@@ -231,6 +231,49 @@
  outb(0x13, 0x42);
 }

+/*
+ * Calibrate CPU clock using legacy 8254 timer/counter. Stolen from
+ * arch/i386/time.c.
+ */
+
+#define CALIBRATE_DIVISOR 0xffff
+
+static unsigned long __init
+calibrate_cc(void)
+{
+ unsigned int cc;
+ unsigned long count = 0;
+
+ /* Set the Gate high, disable speaker */
+ outb((inb(0x61) & ~0x02) | 0x01, 0x61);
+
+ /*
+  * Now let's take care of CTC channel 2
+  *
+  * Set the Gate high, program CTC channel 2 for mode 0,
+  * (interrupt on terminal count mode), binary count,
+  * load maximum divisor we can get for accuracy - 65535
+  */
+
+ outb(0xb0, 0x43); /* binary, mode 0, LSB/MSB, Ch 2 */
+ outb(CALIBRATE_DIVISOR & 0xff, 0x42); /* LSB of count */
+ outb(CALIBRATE_DIVISOR >> 8, 0x42); /* MSB of count */
+
+ /* we still should not hang if timer not runing or N/A */
+ for (cc = rpcc(); (inb(0x61) & 0x20) == 0 && !(count >> 32); count++);
+
+ /* cycles delta */
+ cc = rpcc() - cc;
+
+ /* check for the reliable result */
+ if ((count < 1) || (count >> 32))
+     return 0;
+
+ /* and the final result in HZ */
+ return ((unsigned long)cc * CLOCK_TICK_RATE) / CALIBRATE_DIVISOR;
+}
+
+
 void
 time_init(void)
 {
@@ -239,6 +282,10 @@
  unsigned long cycle_freq, ppm_error;
  long diff;

+ /* Calibrate CPU clock using CTC. If this fails, use RTC. */
+ if (!est_cycle_freq)
+     est_cycle_freq = calibrate_cc();
+
  /*
   * The Linux interpretation of the CMOS clock register contents:
   * When the Update-In-Progress (UIP) flag goes from 1 to 0, the





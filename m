Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264381AbRGCNG5>; Tue, 3 Jul 2001 09:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264415AbRGCNGs>; Tue, 3 Jul 2001 09:06:48 -0400
Received: from yellow.jscc.ru ([195.208.40.129]:52241 "EHLO yellow.jscc.ru")
	by vger.kernel.org with ESMTP id <S264407AbRGCNGb>;
	Tue, 3 Jul 2001 09:06:31 -0400
Message-ID: <016c01c103c1$07f283f0$4d28d0c3@jscc.ru>
From: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>
Cc: <linux-kernel@vger.kernel.org>, "Richard Henderson" <rth@twiddle.net>
In-Reply-To: <022901c10095$f4fca650$4d28d0c3@jscc.ru> <20010629211931.A582@jurassic.park.msu.ru> <009801c102dc$c42d7a60$4d28d0c3@jscc.ru>
Subject: Re: alpha - generic_init_pit - why using RTC for calibration?
Date: Tue, 3 Jul 2001 17:06:52 +0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0169_01C103E2.8DEC7260"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0169_01C103E2.8DEC7260
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

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



------=_NextPart_000_0169_01C103E2.8DEC7260
Content-Type: application/octet-stream;
	name="linux-2.2.x.rtc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.2.x.rtc.patch"

--- linux/arch/alpha/kernel/time.c.orig	Mon Jul  2 14:05:09 2001=0A=
+++ linux/arch/alpha/kernel/time.c	Mon Jul  2 15:47:45 2001=0A=
@@ -231,6 +231,49 @@=0A=
 	outb(0x13, 0x42);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Calibrate CPU clock using legacy 8254 timer/counter. Stolen from=0A=
+ * arch/i386/time.c.=0A=
+ */=0A=
+=0A=
+#define CALIBRATE_DIVISOR	0xffff=0A=
+=0A=
+static unsigned long __init=0A=
+calibrate_cc(void)=0A=
+{=0A=
+	unsigned int cc;=0A=
+	unsigned long count =3D 0;=0A=
+	=0A=
+	/* Set the Gate high, disable speaker */=0A=
+	outb((inb(0x61) & ~0x02) | 0x01, 0x61);=0A=
+	=0A=
+	/*=0A=
+	 * Now let's take care of CTC channel 2=0A=
+	 *=0A=
+	 * Set the Gate high, program CTC channel 2 for mode 0,=0A=
+	 * (interrupt on terminal count mode), binary count,=0A=
+	 * load maximum divisor we can get for accuracy - 65535=0A=
+	 */=0A=
+	=0A=
+	outb(0xb0, 0x43);	/* binary, mode 0, LSB/MSB, Ch 2 */=0A=
+	outb(CALIBRATE_DIVISOR & 0xff, 0x42);	/* LSB of count */=0A=
+	outb(CALIBRATE_DIVISOR >> 8, 0x42);	/* MSB of count */=0A=
+=0A=
+	/* we still should not hang if timer not runing or N/A */=0A=
+	for (cc =3D rpcc(); (inb(0x61) & 0x20) =3D=3D 0 && !(count >> 32); =
count++);=0A=
+=0A=
+	/* cycles delta */=0A=
+	cc =3D rpcc() - cc;=0A=
+	=0A=
+	/* check for the reliable result */=0A=
+	if ((count < 1) || (count >> 32))=0A=
+	    return 0;=0A=
+=0A=
+	/* and the final result in HZ */=0A=
+	return ((unsigned long)cc * CLOCK_TICK_RATE) / CALIBRATE_DIVISOR;=0A=
+}=0A=
+=0A=
+=0A=
 void=0A=
 time_init(void)=0A=
 {=0A=
@@ -239,6 +282,10 @@=0A=
 	unsigned long cycle_freq, ppm_error;=0A=
 	long diff;=0A=
 =0A=
+	/* Calibrate CPU clock using CTC. If this fails, use RTC. */=0A=
+	if (!est_cycle_freq)=0A=
+	    est_cycle_freq =3D calibrate_cc();=0A=
+=0A=
 	/*=0A=
 	 * The Linux interpretation of the CMOS clock register contents:=0A=
 	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the=0A=
@@ -275,7 +322,7 @@=0A=
 	if (diff < 0)=0A=
 		diff =3D -diff;=0A=
 	ppm_error =3D (diff * 1000000L) / cycle_freq;=0A=
-#if 0=0A=
+#if 1=0A=
 	printk("Alpha clock init: HWRPB %lu, Measured %lu, error=3D%lu ppm.\n",=0A=
 	       hwrpb->cycle_freq, est_cycle_freq, ppm_error);=0A=
 #endif=0A=

------=_NextPart_000_0169_01C103E2.8DEC7260--


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264864AbRGEIh6>; Thu, 5 Jul 2001 04:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264865AbRGEIht>; Thu, 5 Jul 2001 04:37:49 -0400
Received: from yellow.jscc.ru ([195.208.40.129]:2575 "EHLO yellow.jscc.ru")
	by vger.kernel.org with ESMTP id <S264864AbRGEIha>;
	Thu, 5 Jul 2001 04:37:30 -0400
Message-ID: <00a001c1052d$a3201320$4d28d0c3@jscc.ru>
From: "Oleg I. Vdovikin" <vdovikin@jscc.ru>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: "Richard Henderson" <rth@twiddle.net>, <alan@redhat.com>,
        <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <022901c10095$f4fca650$4d28d0c3@jscc.ru> <20010629211931.A582@jurassic.park.msu.ru> <20010704114530.A1030@twiddle.net> <003e01c10522$1c9cf580$4d28d0c3@jscc.ru> <3B441618.638A3FC@mandrakesoft.com>
Subject: Re: [patch] Re: alpha - generic_init_pit - why using RTC for  calibration?
Date: Thu, 5 Jul 2001 12:36:50 +0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_009D_01C1054F.29CCD6D0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_009D_01C1054F.29CCD6D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

That's it.

Please also include my old rtc patch for 2.2.x series into official 2.2.20
kernel.

Thanks,
    Oleg.

-------------
From: "Jeff Garzik" <jgarzik@mandrakesoft.com>
Subject: Re: [patch] Re: alpha - generic_init_pit - why using RTC for
calibration?

> Oleg,
>
> The official kernel now carries Richard's version.  Can you post a diff
> on linux-kernel against version 2.4.7-pre2 perhaps, which cleans up
> Richard's code to yours?
> --
> Jeff Garzik      | Thalidomide, eh?
> Building 1024    | So you're saying the eggplant has an accomplice?
> MandrakeSoft     |
>

------=_NextPart_000_009D_01C1054F.29CCD6D0
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

------=_NextPart_000_009D_01C1054F.29CCD6D0
Content-Type: application/octet-stream;
	name="linux-2.4.7pre2.rtc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.4.7pre2.rtc.patch"

--- arch/alpha/kernel/time.c.orig	Thu Jul  5 12:18:48 2001=0A=
+++ arch/alpha/kernel/time.c	Thu Jul  5 12:24:11 2001=0A=
@@ -174,13 +174,12 @@=0A=
  * arch/i386/time.c.=0A=
  */=0A=
 =0A=
-#define CALIBRATE_LATCH	(52 * LATCH)=0A=
-#define CALIBRATE_TIME	(52 * 1000020 / HZ)=0A=
+#define CALIBRATE_LATCH	0xffff=0A=
 =0A=
 static unsigned long __init=0A=
 calibrate_cc_with_pic(void)=0A=
 {=0A=
-	int cc;=0A=
+	unsigned int cc;=0A=
 	unsigned long count =3D 0;=0A=
 =0A=
 	/* Set the Gate high, disable speaker */=0A=
@@ -191,39 +190,24 @@=0A=
 	 *=0A=
 	 * Set the Gate high, program CTC channel 2 for mode 0,=0A=
 	 * (interrupt on terminal count mode), binary count,=0A=
-	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.=0A=
+	 * load maximum divisor we can get for accuracy - 65535=0A=
 	 */=0A=
 	outb(0xb0, 0x43);		/* binary, mode 0, LSB/MSB, Ch 2 */=0A=
 	outb(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */=0A=
 	outb(CALIBRATE_LATCH >> 8, 0x42);	/* MSB of count */=0A=
-=0A=
-	cc =3D rpcc();=0A=
-	do {=0A=
-		count++;=0A=
-	} while ((inb(0x61) & 0x20) =3D=3D 0);=0A=
+	=0A=
+	/* we still should not hang if timer not runing or N/A */=0A=
+	for (cc =3D rpcc(); (inb(0x61) & 0x20) =3D=3D 0 && !(count >> 32); =
count++);=0A=
+	=0A=
+	/* cycles delta */=0A=
 	cc =3D rpcc() - cc;=0A=
-=0A=
-	/* Error: ECTCNEVERSET */=0A=
-	if (count <=3D 1)=0A=
-		goto bad_ctc;=0A=
-=0A=
-	/* Error: ECPUTOOFAST */=0A=
-	if (count >> 32)=0A=
-		goto bad_ctc;=0A=
-=0A=
-	/* Error: ECPUTOOSLOW */=0A=
-	if (cc <=3D CALIBRATE_TIME)=0A=
-		goto bad_ctc;=0A=
-=0A=
-	return ((long)cc * 1000000) / CALIBRATE_TIME;=0A=
-=0A=
-	/*=0A=
-	 * The CTC wasn't reliable: we got a hit on the very first read,=0A=
-	 * or the CPU was so fast/slow that the quotient wouldn't fit in=0A=
-	 * 32 bits..=0A=
-	 */=0A=
- bad_ctc:=0A=
-	return 0;=0A=
+	=0A=
+	/* check for the reliable result */=0A=
+	if ((count < 1) || (count >> 32))=0A=
+		return 0;=0A=
+		=0A=
+	/* and the final result in HZ */=0A=
+	return ((unsigned long)cc * CLOCK_TICK_RATE) / CALIBRATE_LATCH;=0A=
 }=0A=
 =0A=
 /* The Linux interpretation of the CMOS clock register contents:=0A=

------=_NextPart_000_009D_01C1054F.29CCD6D0--


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266129AbRGDSqa>; Wed, 4 Jul 2001 14:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266130AbRGDSqV>; Wed, 4 Jul 2001 14:46:21 -0400
Received: from are.twiddle.net ([64.81.246.98]:2944 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S266129AbRGDSqF>;
	Wed, 4 Jul 2001 14:46:05 -0400
Date: Wed, 4 Jul 2001 11:45:30 -0700
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, alan@redhat.com,
        torvalds@transmeta.com
Cc: "Oleg I. Vdovikin" <vdovikin@jscc.ru>, linux-kernel@vger.kernel.org
Subject: [patch] Re: alpha - generic_init_pit - why using RTC for calibration?
Message-ID: <20010704114530.A1030@twiddle.net>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	alan@redhat.com, torvalds@transmeta.com,
	"Oleg I. Vdovikin" <vdovikin@jscc.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <022901c10095$f4fca650$4d28d0c3@jscc.ru> <20010629211931.A582@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010629211931.A582@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Fri, Jun 29, 2001 at 09:19:31PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2001 at 09:19:31PM +0400, Ivan Kokshaysky wrote:
> Good idea. The patch below works reliably on my sx164.

Reasonable.  Here I've cleaned up time_init a tad as well.


r~



--- arch/alpha/kernel/time.c.orig	Fri Jun 29 11:24:03 2001
+++ arch/alpha/kernel/time.c	Fri Jun 29 11:35:52 2001
@@ -169,6 +169,77 @@ common_init_rtc(void)
 	init_rtc_irq();
 }
 
+/*
+ * Calibrate CPU clock using legacy 8254 timer/counter. Stolen from
+ * arch/i386/time.c.
+ */
+
+#define CALIBRATE_LATCH	(52 * LATCH)
+#define CALIBRATE_TIME	(52 * 1000020 / HZ)
+
+static unsigned long __init
+calibrate_cc_with_pic(void)
+{
+	int cc;
+	unsigned long count = 0;
+
+	/* Set the Gate high, disable speaker */
+	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
+
+	/*
+	 * Now let's take care of CTC channel 2
+	 *
+	 * Set the Gate high, program CTC channel 2 for mode 0,
+	 * (interrupt on terminal count mode), binary count,
+	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
+	 */
+	outb(0xb0, 0x43);		/* binary, mode 0, LSB/MSB, Ch 2 */
+	outb(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
+	outb(CALIBRATE_LATCH >> 8, 0x42);	/* MSB of count */
+
+	cc = rpcc();
+	do {
+		count++;
+	} while ((inb(0x61) & 0x20) == 0);
+	cc = rpcc() - cc;
+
+	/* Error: ECTCNEVERSET */
+	if (count <= 1)
+		goto bad_ctc;
+
+	/* Error: ECPUTOOFAST */
+	if (count >> 32)
+		goto bad_ctc;
+
+	/* Error: ECPUTOOSLOW */
+	if (cc <= CALIBRATE_TIME)
+		goto bad_ctc;
+
+	return ((long)cc * 1000000) / CALIBRATE_TIME;
+
+	/*
+	 * The CTC wasn't reliable: we got a hit on the very first read,
+	 * or the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+ bad_ctc:
+	return 0;
+}
+
+/* The Linux interpretation of the CMOS clock register contents:
+   When the Update-In-Progress (UIP) flag goes from 1 to 0, the
+   RTC registers show the second which has precisely just started.
+   Let's hope other operating systems interpret the RTC the same way.  */
+
+static unsigned long __init
+rpcc_after_update_in_progress(void)
+{
+	do { } while (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP));
+	do { } while (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
+
+	return rpcc();
+}
+
 void __init
 time_init(void)
 {
@@ -176,24 +247,15 @@ time_init(void)
 	unsigned long cycle_freq, one_percent;
 	long diff;
 
-	/*
-	 * The Linux interpretation of the CMOS clock register contents:
-	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
-	 * RTC registers show the second which has precisely just started.
-	 * Let's hope other operating systems interpret the RTC the same way.
-	 */
-	do { } while (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP));
-	do { } while (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
+	/* Calibrate CPU clock -- attempt #1.  */
+	if (!est_cycle_freq)
+		est_cycle_freq = calibrate_cc_with_pic();
 
-	/* Read cycle counter exactly on falling edge of update flag */
-	cc1 = rpcc();
+	cc1 = rpcc_after_update_in_progress();
 
+	/* Calibrate CPU clock -- attempt #2.  */
 	if (!est_cycle_freq) {
-		/* Sometimes the hwrpb->cycle_freq value is bogus. 
-		   Go another round to check up on it and see.  */
-		do { } while (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP));
-		do { } while (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
-		cc2 = rpcc();
+		cc2 = rpcc_after_update_in_progress();
 		est_cycle_freq = cc2 - cc1;
 		cc1 = cc2;
 	}

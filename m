Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278072AbRJZIl2>; Fri, 26 Oct 2001 04:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278068AbRJZIlJ>; Fri, 26 Oct 2001 04:41:09 -0400
Received: from t2.redhat.com ([199.183.24.243]:48115 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S278053AbRJZIlC>;
	Fri, 26 Oct 2001 04:41:02 -0400
Date: Fri, 26 Oct 2001 01:41:33 -0700
From: Richard Henderson <rth@redhat.com>
To: torvalds@transmeta.com, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: alpha 2.4.13: cycle detection sanity checks
Message-ID: <20011026014133.A1422@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky and others recently put in code to fix some cycle
counter detection problems on UP2000 systems.  It turns out that
PC164 and LX164 systems have different broken hardware, and the
new code turns up completely bogus numbers like 1.9GHz on those
systems.

The following adds some knowledge about what sort of hardware
actually exists, so that we can determine that the computed
value is completely out of line.

Worst case (say if someone overclocked their system) we'll fail
to believe both of our computations and accept (with a warning)
the value given by the PROM (which is sometimes wrong, which is
why we're trying to compute the value in the first place).


r~



--- linux/arch/alpha/kernel/time.c	Thu Oct  4 18:47:08 2001
+++ 2.4.13/arch/alpha/kernel/time.c	Thu Oct 25 13:37:24 2001
@@ -169,6 +169,50 @@ common_init_rtc(void)
 	init_rtc_irq();
 }
 
+
+/* Validate a computed cycle counter result against the known bounds for
+   the given processor core.  There's too much brokenness in the way of
+   timing hardware for any one method to work everywhere.  :-(
+
+   Return 0 if the result cannot be trusted, otherwise return the argument.  */
+
+static unsigned long __init
+validate_cc_value(unsigned long cc)
+{
+	static struct bounds {
+		unsigned int min, max;
+	} cpu_hz[] __initdata = {
+		[EV3_CPU]   = {  50000000, 200000000 },		/* guess */
+		[EV4_CPU]   = { 150000000, 300000000 },
+		[LCA4_CPU]  = { 150000000, 300000000 },		/* guess */
+		[EV45_CPU]  = { 200000000, 300000000 },
+		[EV5_CPU]   = { 266000000, 333333333 },
+		[EV56_CPU]  = { 366000000, 667000000 },
+		[PCA56_CPU] = { 400000000, 600000000 },		/* guess */
+		[PCA57_CPU] = { 500000000, 600000000 },		/* guess */
+		[EV6_CPU]   = { 466000000, 600000000 },
+		[EV67_CPU]  = { 600000000, 833333333 },		/* guess */
+		/* ??? EV68 is shipping.  No hwrpb value?
+		   Christopher C. Chimelis sez 667-833MHz.  */
+	};
+
+	struct percpu_struct *cpu;
+	unsigned int index;
+
+	cpu = (struct percpu_struct *)((char*)hwrpb + hwrpb->processor_offset);
+	index = cpu->type & 0xffffffff;
+
+	/* If index out of bounds, no way to validate.  */
+	if (index >= sizeof(cpu_hz)/sizeof(cpu_hz[0]))
+		return cc;
+
+	if (cc < cpu_hz[index].min || cc > cpu_hz[index].max)
+		return 0;
+
+	return cc;
+}
+
+
 /*
  * Calibrate CPU clock using legacy 8254 timer/counter. Stolen from
  * arch/i386/time.c.
@@ -180,8 +224,7 @@ common_init_rtc(void)
 static unsigned long __init
 calibrate_cc_with_pic(void)
 {
-	int cc;
-	unsigned long count = 0;
+	int cc, count = 0;
 
 	/* Set the Gate high, disable speaker */
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
@@ -200,30 +243,18 @@ calibrate_cc_with_pic(void)
 	cc = rpcc();
 	do {
 		count++;
-	} while ((inb(0x61) & 0x20) == 0);
+	} while ((inb(0x61) & 0x20) == 0 && count > 0);
 	cc = rpcc() - cc;
 
-	/* Error: ECTCNEVERSET */
+	/* Error: ECTCNEVERSET or ECPUTOOFAST.  */
 	if (count <= 1)
-		goto bad_ctc;
+		return 0;
 
-	/* Error: ECPUTOOFAST */
-	if (count >> 32)
-		goto bad_ctc;
-
-	/* Error: ECPUTOOSLOW */
+	/* Error: ECPUTOOSLOW.  */
 	if (cc <= CALIBRATE_TIME)
-		goto bad_ctc;
-
-	return ((long)cc * 1000000) / CALIBRATE_TIME;
+		return 0;
 
-	/*
-	 * The CTC wasn't reliable: we got a hit on the very first read,
-	 * or the CPU was so fast/slow that the quotient wouldn't fit in
-	 * 32 bits..
-	 */
- bad_ctc:
-	return 0;
+	return (cc * 1000000UL) / CALIBRATE_TIME;
 }
 
 /* The Linux interpretation of the CMOS clock register contents:
@@ -249,31 +280,35 @@ time_init(void)
 
 	/* Calibrate CPU clock -- attempt #1.  */
 	if (!est_cycle_freq)
-		est_cycle_freq = calibrate_cc_with_pic();
+		est_cycle_freq = validate_cc_value(calibrate_cc_with_pic());
 
 	cc1 = rpcc_after_update_in_progress();
 
 	/* Calibrate CPU clock -- attempt #2.  */
 	if (!est_cycle_freq) {
 		cc2 = rpcc_after_update_in_progress();
-		est_cycle_freq = cc2 - cc1;
+		est_cycle_freq = validate_cc_value(cc2 - cc1);
 		cc1 = cc2;
 	}
 
-	/* If the given value is within 1% of what we calculated, 
-	   accept it.  Otherwise, use what we found.  */
 	cycle_freq = hwrpb->cycle_freq;
-	one_percent = cycle_freq / 100;
-	diff = cycle_freq - est_cycle_freq;
-	if (diff < 0)
-		diff = -diff;
-	if (diff > one_percent) {
-		cycle_freq = est_cycle_freq;
-		printk("HWRPB cycle frequency bogus.  Estimated %lu Hz\n",
-		       cycle_freq);
-	}
-	else {
-		est_cycle_freq = 0;
+	if (est_cycle_freq) {
+		/* If the given value is within 1% of what we calculated, 
+		   accept it.  Otherwise, use what we found.  */
+		one_percent = cycle_freq / 100;
+		diff = cycle_freq - est_cycle_freq;
+		if (diff < 0)
+			diff = -diff;
+		if (diff > one_percent) {
+			cycle_freq = est_cycle_freq;
+			printk("HWRPB cycle frequency bogus.  "
+			       "Estimated %lu Hz\n", cycle_freq);
+		} else {
+			est_cycle_freq = 0;
+		}
+	} else if (! validate_cc_value (cycle_freq)) {
+		printk("HWRPB cycle frequency bogus, "
+		       "and unable to estimate a proper value!\n");
 	}
 
 	/* From John Bowman <bowman@math.ualberta.ca>: allow the values

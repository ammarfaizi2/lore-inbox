Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273429AbRINQtZ>; Fri, 14 Sep 2001 12:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273430AbRINQtQ>; Fri, 14 Sep 2001 12:49:16 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:31492 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S273429AbRINQtC>; Fri, 14 Sep 2001 12:49:02 -0400
Date: Fri, 14 Sep 2001 20:47:45 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Bob McElrath <mcelrath@draal.physics.wisc.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Wrong BogoMIPS on alpha
Message-ID: <20010914204745.A633@jurassic.park.msu.ru>
In-Reply-To: <20010904101318.B1458@draal.physics.wisc.edu> <20010904225942.A19434@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010904225942.A19434@twiddle.net>; from rth@twiddle.net on Tue, Sep 04, 2001 at 10:59:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 10:59:42PM -0700, Richard Henderson wrote:
> On Tue, Sep 04, 2001 at 10:13:18AM -0500, Bob McElrath wrote:
> > Recently the bogomips measurement has gone all haywire.  Every once in a
> > while when I boot up the bogomips measurement will be absurly high (i.e.
> > 5 Terahertz), with obvious associated problems.
> [...]
> > The system is:
> > Alpha LX164 (21164 chip) at 600MHz
> 
> Your clock chip has gone bad.  This happens regularly
> with the shitty chip they put in LX and SX systems.

Actually it was a problem with another chip - integrated 8254
timer on intel SIO bridge. It was triggered on lx164 and reportedly
on pc164 by the new clock calibration code. I've seen that myself on
lx164 two or three times before my vacation, but can't reproduce
it since then...  Anyway, better sanity check should fix that.
Also:
- 8254 naming changed to PIT (programmable interval timer) for
  consistency;
- reference to HZ removed for better accuracy;
- few unrelated compile and warning fixes for 2.4.10-pre9.

Ivan.

--- 2.4.10p9/include/asm-alpha/processor.h	Fri Sep 14 18:00:50 2001
+++ linux/include/asm-alpha/processor.h	Fri Sep 14 18:00:30 2001
@@ -7,6 +7,8 @@
 #ifndef __ASM_ALPHA_PROCESSOR_H
 #define __ASM_ALPHA_PROCESSOR_H
 
+#include <linux/personality.h>
+
 /*
  * Returns current instruction pointer ("program counter").
  */
--- 2.4.10p9/include/asm-alpha/hw_irq.h	Fri Sep 14 17:37:41 2001
+++ linux/include/asm-alpha/hw_irq.h	Fri Sep 14 19:10:00 2001
@@ -5,7 +5,7 @@
 
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
 
-extern volatile unsigned long irq_err_count;
+extern unsigned long irq_err_count;
 
 #ifdef CONFIG_ALPHA_GENERIC
 #define ACTUAL_NR_IRQS	alpha_mv.nr_irqs
--- 2.4.10p9/arch/alpha/mm/init.c	Fri May 25 02:20:18 2001
+++ linux/arch/alpha/mm/init.c	Fri Sep 14 18:41:14 2001
@@ -267,7 +267,7 @@ callback_init(void * kernel_end)
 
 		/* Let vmalloc know that we've allocated some space.  */
 		console_remap_vm.flags = VM_ALLOC;
-		console_remap_vm.addr = VMALLOC_START;
+		console_remap_vm.addr = (void *)VMALLOC_START;
 		console_remap_vm.size = vaddr - VMALLOC_START;
 		vmlist = &console_remap_vm;
 	}
--- 2.4.10p9/arch/alpha/kernel/time.c	Sun Aug 12 21:38:48 2001
+++ linux/arch/alpha/kernel/time.c	Fri Sep 14 19:03:09 2001
@@ -170,59 +170,52 @@ common_init_rtc(void)
 }
 
 /*
- * Calibrate CPU clock using legacy 8254 timer/counter. Stolen from
- * arch/i386/time.c.
+ * Calibrate CPU clock using legacy 8254 programmable interval timer.
+ * Based on arch/i386/time.c.
  */
 
-#define CALIBRATE_LATCH	(52 * LATCH)
-#define CALIBRATE_TIME	(52 * 1000020 / HZ)
+#define CALIBRATE_LATCH	0x10000
 
 static unsigned long __init
-calibrate_cc_with_pic(void)
+calibrate_cc_with_pit(void)
 {
-	int cc;
-	unsigned long count = 0;
+	int cc, count = 0;
+	unsigned long freq, hwrpbfreq = hwrpb->cycle_freq;
 
 	/* Set the Gate high, disable speaker */
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
 
 	/*
-	 * Now let's take care of CTC channel 2
+	 * Now let's take care of PIT channel 2
 	 *
-	 * Set the Gate high, program CTC channel 2 for mode 0,
+	 * Set the Gate high, program PIT channel 2 for mode 0,
 	 * (interrupt on terminal count mode), binary count,
-	 * load 5 * LATCH count, (LSB and MSB) to begin countdown.
+	 * load CALIBRATE_LATCH count (LSB and MSB) to begin countdown.
 	 */
 	outb(0xb0, 0x43);		/* binary, mode 0, LSB/MSB, Ch 2 */
-	outb(CALIBRATE_LATCH & 0xff, 0x42);	/* LSB of count */
-	outb(CALIBRATE_LATCH >> 8, 0x42);	/* MSB of count */
+	outb(CALIBRATE_LATCH & 0xff, 0x42);		/* LSB of count */
+	outb((CALIBRATE_LATCH >> 8) & 0xff, 0x42);	/* MSB of count */
 
 	cc = rpcc();
 	do {
 		count++;
-	} while ((inb(0x61) & 0x20) == 0);
+	} while (!(inb(0x61) & 0x20) && count > 0);
 	cc = rpcc() - cc;
 
-	/* Error: ECTCNEVERSET */
+	/* Error: EPITNEVERSET or ECPUTOOFAST */
 	if (count <= 1)
-		goto bad_ctc;
+		goto bad_pit;
 
-	/* Error: ECPUTOOFAST */
-	if (count >> 32)
-		goto bad_ctc;
+	freq = ((long)cc * CLOCK_TICK_RATE) / CALIBRATE_LATCH;
 
-	/* Error: ECPUTOOSLOW */
-	if (cc <= CALIBRATE_TIME)
-		goto bad_ctc;
+	/* CPU cycle frequency reported in the hwrpb is often bogus.
+	   However, even in the worst case the difference shouldn't
+	   exceed 30-40%, so we can still use hwrpb value to validate
+	   the frequency we've found with PIT. */
+	if ((max(freq, hwrpbfreq) + 1) / (min(freq, hwrpbfreq) + 1) < 2)
+		return freq;
 
-	return ((long)cc * 1000000) / CALIBRATE_TIME;
-
-	/*
-	 * The CTC wasn't reliable: we got a hit on the very first read,
-	 * or the CPU was so fast/slow that the quotient wouldn't fit in
-	 * 32 bits..
-	 */
- bad_ctc:
+ bad_pit:
 	return 0;
 }
 
@@ -249,7 +242,7 @@ time_init(void)
 
 	/* Calibrate CPU clock -- attempt #1.  */
 	if (!est_cycle_freq)
-		est_cycle_freq = calibrate_cc_with_pic();
+		est_cycle_freq = calibrate_cc_with_pit();
 
 	cc1 = rpcc_after_update_in_progress();
 
--- 2.4.10p9/arch/alpha/kernel/traps.c	Fri Sep 14 14:14:22 2001
+++ linux/arch/alpha/kernel/traps.c	Fri Sep 14 18:19:30 2001
@@ -299,6 +299,7 @@ do_entIF(unsigned long type, unsigned lo
 	      case 3: /* FEN fault */
 	      case 5: /* illoc */
 	      default: /* unexpected instruction-fault type */
+		break;
 	}
 	send_sig(SIGILL, current, 1);
 }
--- 2.4.10p9/arch/alpha/kernel/irq_alpha.c	Tue Jul  3 01:03:04 2001
+++ linux/arch/alpha/kernel/irq_alpha.c	Fri Sep 14 18:35:09 2001
@@ -18,8 +18,6 @@
 unsigned long __irq_attempt[NR_IRQS];
 #endif
 
-extern unsigned long irq_err_count;
-
 /* Hack minimum IPL during interrupt processing for broken hardware.  */
 #ifdef CONFIG_ALPHA_BROKEN_IRQ_MASK
 int __min_ipl;
@@ -151,7 +149,7 @@ process_mcheck_info(unsigned long vector
 #endif
 
 	if (expected) {
-		int cpu = smp_processor_id();
+		int cpu __attribute__((unused)) = smp_processor_id();
 		mcheck_expected(cpu) = 0;
 		mcheck_taken(cpu) = 1;
 		return;

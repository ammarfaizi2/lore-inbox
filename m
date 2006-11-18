Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756219AbWKRHXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219AbWKRHXH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 02:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756222AbWKRHXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 02:23:07 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:5295 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1756219AbWKRHXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 02:23:02 -0500
Date: Sat, 18 Nov 2006 08:22:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Hemminger <shemminger@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Regard MSRs in lapic_suspend()/lapic_resume()
Message-ID: <20061118072200.GA1471@elte.hu>
References: <200611180300.18581.fzu@wemgehoertderstaat.de> <20061118070310.GD32226@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118070310.GD32226@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
> 
> nice one! I'm tempted to suggest this for 2.6.19 merge because it 
> causes the kernel to do less (so it has little risk of breaking 
> something that is working) ... who knows what happens on certain 
> (older?) APICs when we try to write back those bogus values.
> 
>   Acked-by: Ingo Molnar <mingo@elte.hu>

Andrew, find below updated-i386-cleanup-apic-code.patch updated to come 
after Karsten's patch.

	Ingo

-------------------->
From: Thomas Gleixner <tglx@linutronix.de>

The apic code is quite unstructured and missing a lot of comments.

- Restructure the code into helper functions, timer, setup/shutdown,
  interrupt and power management blocks.
- Fixup comments.
- Namespace fixups
- Inline helpers for version and is_integrated
- Combine the ack_bad_irq functions

No functional changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Rohit Seth <rohitseth@google.com>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---
 arch/i386/kernel/apic.c    | 2071 ++++++++++++++++++++++-----------------------
 arch/i386/kernel/io_apic.c |    2 
 arch/i386/kernel/irq.c     |   22 
 arch/i386/kernel/smpboot.c |    4 
 include/asm-i386/apic.h    |    2 
 5 files changed, 1075 insertions(+), 1026 deletions(-)

Index: linux/arch/i386/kernel/apic.c
===================================================================
--- linux.orig/arch/i386/kernel/apic.c
+++ linux/arch/i386/kernel/apic.c
@@ -44,6 +44,13 @@
 #include "io_ports.h"
 
 /*
+ * Sanity check
+ */
+#if (SPURIOUS_APIC_VECTOR & 0x0F) != 0x0F
+# error SPURIOUS_APIC_VECTOR definition error
+#endif
+
+/*
  * cpu_mask that denotes the CPUs that needs timer interrupt coming in as
  * IPIs in place of local APIC timers
  */
@@ -51,561 +58,559 @@ static cpumask_t timer_bcast_ipi;
 
 /*
  * Knob to control our willingness to enable the local APIC.
+ *
+ * -1=force-disable, +1=force-enable
  */
-static int enable_local_apic __initdata = 0; /* -1=force-disable, +1=force-enable */
-
-static inline void lapic_disable(void)
-{
-	enable_local_apic = -1;
-	clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
-}
-
-static inline void lapic_enable(void)
-{
-	enable_local_apic = 1;
-}
+static int enable_local_apic __initdata = 0;
 
 /*
- * Debug level
+ * Debug level, exported for io_apic.c
  */
 int apic_verbosity;
 
-
 static void apic_pm_activate(void);
 
-static int modern_apic(void)
+
+/* Using APIC to generate smp_local_timer_interrupt? */
+int using_apic_timer __read_mostly = 0;
+
+/* Local APIC was disabled by the BIOS and enabled by the kernel */
+static int enabled_via_apicbase;
+
+/*
+ * Get the LAPIC version
+ */
+static inline int lapic_get_version(void)
 {
-	unsigned int lvr, version;
-	/* AMD systems use old APIC versions, so check the CPU */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
-		boot_cpu_data.x86 >= 0xf)
-		return 1;
-	lvr = apic_read(APIC_LVR);
-	version = GET_APIC_VERSION(lvr);
-	return version >= 0x14;
+	return GET_APIC_VERSION(apic_read(APIC_LVR));
 }
 
 /*
- * 'what should we do if we get a hw irq event on an illegal vector'.
- * each architecture has to answer this themselves.
+ * Check, if the APIC is integrated or a seperate chip
  */
-void ack_bad_irq(unsigned int irq)
+static inline int lapic_is_integrated(void)
 {
-	printk("unexpected IRQ trap at vector %02x\n", irq);
-	/*
-	 * Currently unexpected vectors happen only on SMP and APIC.
-	 * We _must_ ack these because every local APIC has only N
-	 * irq slots per priority level, and a 'hanging, unacked' IRQ
-	 * holds up an irq slot - in excessive cases (when multiple
-	 * unexpected vectors occur) that might lock up the APIC
-	 * completely.
-	 * But only ack when the APIC is enabled -AK
-	 */
-	if (cpu_has_apic)
-		ack_APIC_irq();
+	return APIC_INTEGRATED(lapic_get_version());
 }
 
-void __init apic_intr_init(void)
+/*
+ * Check, whether this is a modern or a first generation APIC
+ */
+static int modern_apic(void)
 {
-#ifdef CONFIG_SMP
-	smp_intr_init();
-#endif
-	/* self generated IPI for local APIC timer */
-	set_intr_gate(LOCAL_TIMER_VECTOR, apic_timer_interrupt);
-
-	/* IPI vectors for APIC spurious and error interrupts */
-	set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
-	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
-
-	/* thermal monitor LVT interrupt */
-#ifdef CONFIG_X86_MCE_P4THERMAL
-	set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
-#endif
+	/* AMD systems use old APIC versions, so check the CPU */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	    boot_cpu_data.x86 >= 0xf)
+		return 1;
+	return lapic_get_version() >= 0x14;
 }
 
-/* Using APIC to generate smp_local_timer_interrupt? */
-int using_apic_timer __read_mostly = 0;
-
-static int enabled_via_apicbase;
-
+/**
+ * enable_NMI_through_LVT0 - enable NMI through local vector table 0
+ */
 void enable_NMI_through_LVT0 (void * dummy)
 {
-	unsigned int v, ver;
+	unsigned int v = APIC_DM_NMI;
 
-	ver = apic_read(APIC_LVR);
-	ver = GET_APIC_VERSION(ver);
-	v = APIC_DM_NMI;			/* unmask and set to NMI */
-	if (!APIC_INTEGRATED(ver))		/* 82489DX */
+	/* Level triggered for 82489DX */
+	if (!lapic_is_integrated())
 		v |= APIC_LVT_LEVEL_TRIGGER;
 	apic_write_around(APIC_LVT0, v);
 }
 
+/**
+ * get_physical_broadcast - Get number of physical broadcast IDs
+ */
 int get_physical_broadcast(void)
 {
-	if (modern_apic())
-		return 0xff;
-	else
-		return 0xf;
+	return modern_apic() ? 0xff : 0xf;
 }
 
-int get_maxlvt(void)
+/**
+ * lapic_get_maxlvt - get the maximum number of local vector table entries
+ */
+int lapic_get_maxlvt(void)
 {
-	unsigned int v, ver, maxlvt;
+	unsigned int v = apic_read(APIC_LVR);
 
-	v = apic_read(APIC_LVR);
-	ver = GET_APIC_VERSION(v);
 	/* 82489DXs do not report # of LVT entries. */
-	maxlvt = APIC_INTEGRATED(ver) ? GET_APIC_MAXLVT(v) : 2;
-	return maxlvt;
+	return APIC_INTEGRATED(GET_APIC_VERSION(v)) ? GET_APIC_MAXLVT(v) : 2;
 }
 
-void clear_local_APIC(void)
+/*
+ * Local APIC timer
+ */
+
+/*
+ * This part sets up the APIC 32 bit clock in LVTT1, with HZ interrupts
+ * per second. We assume that the caller has already set up the local
+ * APIC.
+ *
+ * The APIC timer is not exactly sync with the external timer chip, it
+ * closely follows bus clocks.
+ */
+
+/*
+ * The timer chip is already set up at HZ interrupts per second here,
+ * but we do not accept timer interrupts yet. We only allow the BP
+ * to calibrate.
+ */
+static unsigned int __devinit get_8254_timer_count(void)
 {
-	int maxlvt;
-	unsigned long v;
+	unsigned long flags;
 
-	maxlvt = get_maxlvt();
+	unsigned int count;
 
-	/*
-	 * Masking an LVT entry can trigger a local APIC error
-	 * if the vector is zero. Mask LVTERR first to prevent this.
-	 */
-	if (maxlvt >= 3) {
-		v = ERROR_APIC_VECTOR; /* any non-zero vector will do */
-		apic_write_around(APIC_LVTERR, v | APIC_LVT_MASKED);
-	}
-	/*
-	 * Careful: we have to set masks only first to deassert
-	 * any level-triggered sources.
-	 */
-	v = apic_read(APIC_LVTT);
-	apic_write_around(APIC_LVTT, v | APIC_LVT_MASKED);
-	v = apic_read(APIC_LVT0);
-	apic_write_around(APIC_LVT0, v | APIC_LVT_MASKED);
-	v = apic_read(APIC_LVT1);
-	apic_write_around(APIC_LVT1, v | APIC_LVT_MASKED);
-	if (maxlvt >= 4) {
-		v = apic_read(APIC_LVTPC);
-		apic_write_around(APIC_LVTPC, v | APIC_LVT_MASKED);
-	}
+	spin_lock_irqsave(&i8253_lock, flags);
 
-/* lets not touch this if we didn't frob it */
-#ifdef CONFIG_X86_MCE_P4THERMAL
-	if (maxlvt >= 5) {
-		v = apic_read(APIC_LVTTHMR);
-		apic_write_around(APIC_LVTTHMR, v | APIC_LVT_MASKED);
-	}
-#endif
-	/*
-	 * Clean APIC state for other OSs:
-	 */
-	apic_write_around(APIC_LVTT, APIC_LVT_MASKED);
-	apic_write_around(APIC_LVT0, APIC_LVT_MASKED);
-	apic_write_around(APIC_LVT1, APIC_LVT_MASKED);
-	if (maxlvt >= 3)
-		apic_write_around(APIC_LVTERR, APIC_LVT_MASKED);
-	if (maxlvt >= 4)
-		apic_write_around(APIC_LVTPC, APIC_LVT_MASKED);
+	outb_p(0x00, PIT_MODE);
+	count = inb_p(PIT_CH0);
+	count |= inb_p(PIT_CH0) << 8;
 
-#ifdef CONFIG_X86_MCE_P4THERMAL
-	if (maxlvt >= 5)
-		apic_write_around(APIC_LVTTHMR, APIC_LVT_MASKED);
-#endif
-	v = GET_APIC_VERSION(apic_read(APIC_LVR));
-	if (APIC_INTEGRATED(v)) {	/* !82489DX */
-		if (maxlvt > 3)		/* Due to Pentium errata 3AP and 11AP. */
-			apic_write(APIC_ESR, 0);
-		apic_read(APIC_ESR);
-	}
-}
+	spin_unlock_irqrestore(&i8253_lock, flags);
 
-void __init connect_bsp_APIC(void)
-{
-	if (pic_mode) {
-		/*
-		 * Do not trust the local APIC being empty at bootup.
-		 */
-		clear_local_APIC();
-		/*
-		 * PIC mode, enable APIC mode in the IMCR, i.e.
-		 * connect BSP's local APIC to INT and NMI lines.
-		 */
-		apic_printk(APIC_VERBOSE, "leaving PIC mode, "
-				"enabling APIC mode.\n");
-		outb(0x70, 0x22);
-		outb(0x01, 0x23);
-	}
-	enable_apic_mode();
+	return count;
 }
 
-void disconnect_bsp_APIC(int virt_wire_setup)
+/* next tick in 8254 can be caught by catching timer wraparound */
+static void __devinit wait_8254_wraparound(void)
 {
-	if (pic_mode) {
-		/*
-		 * Put the board back into PIC mode (has an effect
-		 * only on certain older boards).  Note that APIC
-		 * interrupts, including IPIs, won't work beyond
-		 * this point!  The only exception are INIT IPIs.
-		 */
-		apic_printk(APIC_VERBOSE, "disabling APIC mode, "
-				"entering PIC mode.\n");
-		outb(0x70, 0x22);
-		outb(0x00, 0x23);
-	}
-	else {
-		/* Go back to Virtual Wire compatibility mode */
-		unsigned long value;
+	unsigned int curr_count, prev_count;
 
-		/* For the spurious interrupt use vector F, and enable it */
-		value = apic_read(APIC_SPIV);
-		value &= ~APIC_VECTOR_MASK;
-		value |= APIC_SPIV_APIC_ENABLED;
-		value |= 0xf;
-		apic_write_around(APIC_SPIV, value);
+	curr_count = get_8254_timer_count();
+	do {
+		prev_count = curr_count;
+		curr_count = get_8254_timer_count();
 
-		if (!virt_wire_setup) {
-			/* For LVT0 make it edge triggered, active high, external and enabled */
-			value = apic_read(APIC_LVT0);
-			value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING |
-				APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
-				APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED );
-			value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
-			value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_EXTINT);
-			apic_write_around(APIC_LVT0, value);
-		}
-		else {
-			/* Disable LVT0 */
-			apic_write_around(APIC_LVT0, APIC_LVT_MASKED);
-		}
+		/* workaround for broken Mercury/Neptune */
+		if (prev_count >= curr_count + 0x100)
+			curr_count = get_8254_timer_count();
 
-		/* For LVT1 make it edge triggered, active high, nmi and enabled */
-		value = apic_read(APIC_LVT1);
-		value &= ~(
-			APIC_MODE_MASK | APIC_SEND_PENDING |
-			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
-			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED);
-		value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
-		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_NMI);
-		apic_write_around(APIC_LVT1, value);
-	}
+	} while (prev_count >= curr_count);
 }
 
-void disable_local_APIC(void)
+/*
+ * Default initialization for 8254 timers. If we use other timers like HPET,
+ * we override this later
+ */
+void (*wait_timer_tick)(void) __devinitdata = wait_8254_wraparound;
+
+/*
+ * This function sets up the local APIC timer, with a timeout of
+ * 'clocks' APIC bus clock. During calibration we actually call
+ * this function twice on the boot CPU, once with a bogus timeout
+ * value, second time for real. The other (noncalibrating) CPUs
+ * call this function only once, with the real, calibrated value.
+ *
+ * We do reads before writes even if unnecessary, to get around the
+ * P5 APIC double write bug.
+ */
+
+#define APIC_DIVISOR 16
+
+static void __setup_APIC_LVTT(unsigned int clocks)
 {
-	unsigned long value;
+	unsigned int lvtt_value, tmp_value;
+	int cpu = smp_processor_id();
 
-	clear_local_APIC();
+	lvtt_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
+	if (!lapic_is_integrated())
+		lvtt_value |= SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV);
+
+	if (cpu_isset(cpu, timer_bcast_ipi))
+		lvtt_value |= APIC_LVT_MASKED;
+
+	apic_write_around(APIC_LVTT, lvtt_value);
 
 	/*
-	 * Disable APIC (implies clearing of registers
-	 * for 82489DX!).
+	 * Divide PICLK by 16
 	 */
-	value = apic_read(APIC_SPIV);
-	value &= ~APIC_SPIV_APIC_ENABLED;
-	apic_write_around(APIC_SPIV, value);
+	tmp_value = apic_read(APIC_TDCR);
+	apic_write_around(APIC_TDCR, (tmp_value
+				& ~(APIC_TDR_DIV_1 | APIC_TDR_DIV_TMBASE))
+				| APIC_TDR_DIV_16);
 
-	if (enabled_via_apicbase) {
-		unsigned int l, h;
-		rdmsr(MSR_IA32_APICBASE, l, h);
-		l &= ~MSR_IA32_APICBASE_ENABLE;
-		wrmsr(MSR_IA32_APICBASE, l, h);
-	}
+	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
 }
 
-/*
- * This is to verify that we're looking at a real local APIC.
- * Check these against your board if the CPUs aren't getting
- * started for no apparent reason.
- */
-int __init verify_local_APIC(void)
+static void __devinit setup_APIC_timer(unsigned int clocks)
 {
-	unsigned int reg0, reg1;
+	unsigned long flags;
+
+	local_irq_save(flags);
 
 	/*
-	 * The version register is read-only in a real APIC.
+	 * Wait for IRQ0's slice:
 	 */
-	reg0 = apic_read(APIC_LVR);
-	apic_printk(APIC_DEBUG, "Getting VERSION: %x\n", reg0);
-	apic_write(APIC_LVR, reg0 ^ APIC_LVR_MASK);
-	reg1 = apic_read(APIC_LVR);
-	apic_printk(APIC_DEBUG, "Getting VERSION: %x\n", reg1);
+	wait_timer_tick();
+
+	__setup_APIC_LVTT(clocks);
+
+	local_irq_restore(flags);
+}
+
+/*
+ * In this function we calibrate APIC bus clocks to the external
+ * timer. Unfortunately we cannot use jiffies and the timer irq
+ * to calibrate, since some later bootup code depends on getting
+ * the first irq? Ugh.
+ *
+ * We want to do the calibration only once since we
+ * want to have local timer irqs syncron. CPUs connected
+ * by the same APIC bus have the very same bus frequency.
+ * And we want to have irqs off anyways, no accidental
+ * APIC irq that way.
+ */
+
+static int __init calibrate_APIC_clock(void)
+{
+	unsigned long long t1 = 0, t2 = 0;
+	long tt1, tt2;
+	long result;
+	int i;
+	const int LOOPS = HZ/10;
+
+	apic_printk(APIC_VERBOSE, "calibrating APIC timer ...\n");
 
 	/*
-	 * The two version reads above should print the same
-	 * numbers.  If the second one is different, then we
-	 * poke at a non-APIC.
+	 * Put whatever arbitrary (but long enough) timeout
+	 * value into the APIC clock, we just want to get the
+	 * counter running for calibration.
 	 */
-	if (reg1 != reg0)
-		return 0;
+	__setup_APIC_LVTT(1000000000);
 
 	/*
-	 * Check if the version looks reasonably.
+	 * The timer chip counts down to zero. Let's wait
+	 * for a wraparound to start exact measurement:
+	 * (the current tick might have been already half done)
 	 */
-	reg1 = GET_APIC_VERSION(reg0);
-	if (reg1 == 0x00 || reg1 == 0xff)
-		return 0;
-	reg1 = get_maxlvt();
-	if (reg1 < 0x02 || reg1 == 0xff)
-		return 0;
+
+	wait_timer_tick();
 
 	/*
-	 * The ID register is read/write in a real APIC.
+	 * We wrapped around just now. Let's start:
 	 */
-	reg0 = apic_read(APIC_ID);
-	apic_printk(APIC_DEBUG, "Getting ID: %x\n", reg0);
+	if (cpu_has_tsc)
+		rdtscll(t1);
+	tt1 = apic_read(APIC_TMCCT);
 
 	/*
-	 * The next two are just to see if we have sane values.
-	 * They're only really relevant if we're in Virtual Wire
-	 * compatibility mode, but most boxes are anymore.
+	 * Let's wait LOOPS wraprounds:
 	 */
-	reg0 = apic_read(APIC_LVT0);
-	apic_printk(APIC_DEBUG, "Getting LVT0: %x\n", reg0);
-	reg1 = apic_read(APIC_LVT1);
-	apic_printk(APIC_DEBUG, "Getting LVT1: %x\n", reg1);
+	for (i = 0; i < LOOPS; i++)
+		wait_timer_tick();
 
-	return 1;
-}
+	tt2 = apic_read(APIC_TMCCT);
+	if (cpu_has_tsc)
+		rdtscll(t2);
 
-void __init sync_Arb_IDs(void)
-{
-	/* Unsupported on P4 - see Intel Dev. Manual Vol. 3, Ch. 8.6.1
-	   And not needed on AMD */
-	if (modern_apic())
-		return;
 	/*
-	 * Wait for idle.
+	 * The APIC bus clock counter is 32 bits only, it
+	 * might have overflown, but note that we use signed
+	 * longs, thus no extra care needed.
+	 *
+	 * underflown to be exact, as the timer counts down ;)
 	 */
-	apic_wait_icr_idle();
 
-	apic_printk(APIC_DEBUG, "Synchronizing Arb IDs.\n");
-	apic_write_around(APIC_ICR, APIC_DEST_ALLINC | APIC_INT_LEVELTRIG
-				| APIC_DM_INIT);
+	result = (tt1-tt2)*APIC_DIVISOR/LOOPS;
+
+	if (cpu_has_tsc)
+		apic_printk(APIC_VERBOSE, "..... CPU clock speed is "
+			"%ld.%04ld MHz.\n",
+			((long)(t2-t1)/LOOPS)/(1000000/HZ),
+			((long)(t2-t1)/LOOPS)%(1000000/HZ));
+
+	apic_printk(APIC_VERBOSE, "..... host bus clock speed is "
+		"%ld.%04ld MHz.\n",
+		result/(1000000/HZ),
+		result%(1000000/HZ));
+
+	return result;
 }
 
-extern void __error_in_apic_c (void);
+static unsigned int calibration_result;
 
-/*
- * An initial setup of the virtual wire mode.
- */
-void __init init_bsp_APIC(void)
+void __init setup_boot_APIC_clock(void)
 {
-	unsigned long value, ver;
+	unsigned long flags;
+	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n");
+	using_apic_timer = 1;
+
+	local_irq_save(flags);
 
+	calibration_result = calibrate_APIC_clock();
 	/*
-	 * Don't do the setup now if we have a SMP BIOS as the
-	 * through-I/O-APIC virtual wire mode might be active.
+	 * Now set up the timer for real.
 	 */
-	if (smp_found_config || !cpu_has_apic)
-		return;
+	setup_APIC_timer(calibration_result);
 
-	value = apic_read(APIC_LVR);
-	ver = GET_APIC_VERSION(value);
+	local_irq_restore(flags);
+}
 
-	/*
-	 * Do not trust the local APIC being empty at bootup.
-	 */
-	clear_local_APIC();
+void __devinit setup_secondary_APIC_clock(void)
+{
+	setup_APIC_timer(calibration_result);
+}
 
-	/*
-	 * Enable APIC.
-	 */
-	value = apic_read(APIC_SPIV);
-	value &= ~APIC_VECTOR_MASK;
-	value |= APIC_SPIV_APIC_ENABLED;
-	
-	/* This bit is reserved on P4/Xeon and should be cleared */
-	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 15))
-		value &= ~APIC_SPIV_FOCUS_DISABLED;
-	else
-		value |= APIC_SPIV_FOCUS_DISABLED;
-	value |= SPURIOUS_APIC_VECTOR;
-	apic_write_around(APIC_SPIV, value);
+void disable_APIC_timer(void)
+{
+	if (using_apic_timer) {
+		unsigned long v;
 
-	/*
-	 * Set up the virtual wire mode.
-	 */
-	apic_write_around(APIC_LVT0, APIC_DM_EXTINT);
-	value = APIC_DM_NMI;
-	if (!APIC_INTEGRATED(ver))		/* 82489DX */
-		value |= APIC_LVT_LEVEL_TRIGGER;
-	apic_write_around(APIC_LVT1, value);
+		v = apic_read(APIC_LVTT);
+		/*
+		 * When an illegal vector value (0-15) is written to an LVT
+		 * entry and delivery mode is Fixed, the APIC may signal an
+		 * illegal vector error, with out regard to whether the mask
+		 * bit is set or whether an interrupt is actually seen on
+		 * input.
+		 *
+		 * Boot sequence might call this function when the LVTT has
+		 * '0' vector value. So make sure vector field is set to
+		 * valid value.
+		 */
+		v |= (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
+		apic_write_around(APIC_LVTT, v);
+	}
 }
 
-void __devinit setup_local_APIC(void)
+void enable_APIC_timer(void)
 {
-	unsigned long oldvalue, value, ver, maxlvt;
-	int i, j;
+	int cpu = smp_processor_id();
 
-	/* Pound the ESR really hard over the head with a big hammer - mbligh */
-	if (esr_disable) {
-		apic_write(APIC_ESR, 0);
-		apic_write(APIC_ESR, 0);
-		apic_write(APIC_ESR, 0);
-		apic_write(APIC_ESR, 0);
+	if (using_apic_timer && !cpu_isset(cpu, timer_bcast_ipi)) {
+		unsigned long v;
+
+		v = apic_read(APIC_LVTT);
+		apic_write_around(APIC_LVTT, v & ~APIC_LVT_MASKED);
+	}
+}
+
+void switch_APIC_timer_to_ipi(void *cpumask)
+{
+	cpumask_t mask = *(cpumask_t *)cpumask;
+	int cpu = smp_processor_id();
+
+	if (cpu_isset(cpu, mask) &&
+	    !cpu_isset(cpu, timer_bcast_ipi)) {
+		disable_APIC_timer();
+		cpu_set(cpu, timer_bcast_ipi);
 	}
+}
+EXPORT_SYMBOL(switch_APIC_timer_to_ipi);
+
+void switch_ipi_to_APIC_timer(void *cpumask)
+{
+	cpumask_t mask = *(cpumask_t *)cpumask;
+	int cpu = smp_processor_id();
 
-	value = apic_read(APIC_LVR);
-	ver = GET_APIC_VERSION(value);
+	if (cpu_isset(cpu, mask) &&
+	    cpu_isset(cpu, timer_bcast_ipi)) {
+		cpu_clear(cpu, timer_bcast_ipi);
+		enable_APIC_timer();
+	}
+}
+EXPORT_SYMBOL(switch_ipi_to_APIC_timer);
 
-	if ((SPURIOUS_APIC_VECTOR & 0x0f) != 0x0f)
-		__error_in_apic_c();
+/*
+ * Local timer interrupt handler. It does both profiling and
+ * process statistics/rescheduling.
+ */
+inline void smp_local_timer_interrupt(void)
+{
+	profile_tick(CPU_PROFILING);
+#ifdef CONFIG_SMP
+	update_process_times(user_mode_vm(get_irq_regs()));
+#endif
 
 	/*
-	 * Double-check whether this APIC is really registered.
+	 * We take the 'long' return path, and there every subsystem
+	 * grabs the apropriate locks (kernel lock/ irq lock).
+	 *
+	 * we might want to decouple profiling from the 'long path',
+	 * and do the profiling totally in assembly.
+	 *
+	 * Currently this isn't too much of an issue (performance wise),
+	 * we can take more than 100K local irqs per second on a 100 MHz P5.
 	 */
-	if (!apic_id_registered())
-		BUG();
+}
+
+/*
+ * Local APIC timer interrupt. This is the most natural way for doing
+ * local interrupts, but local timer interrupts can be emulated by
+ * broadcast interrupts too. [in case the hw doesn't support APIC timers]
+ *
+ * [ if a single-CPU system runs an SMP kernel then we call the local
+ *   interrupt as well. Thus we cannot inline the local irq ... ]
+ */
+
+fastcall void smp_apic_timer_interrupt(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	int cpu = smp_processor_id();
 
 	/*
-	 * Intel recommends to set DFR, LDR and TPR before enabling
-	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
-	 * document number 292116).  So here it goes...
+	 * the NMI deadlock-detector uses this.
 	 */
-	init_apic_ldr();
+	per_cpu(irq_stat, cpu).apic_timer_irqs++;
 
 	/*
-	 * Set Task Priority to 'accept all'. We never change this
-	 * later on.
+	 * NOTE! We'd better ACK the irq immediately,
+	 * because timer handling can be slow.
 	 */
-	value = apic_read(APIC_TASKPRI);
-	value &= ~APIC_TPRI_MASK;
-	apic_write_around(APIC_TASKPRI, value);
-
+	ack_APIC_irq();
 	/*
-	 * After a crash, we no longer service the interrupts and a pending
-	 * interrupt from previous kernel might still have ISR bit set.
-	 *
-	 * Most probably by now CPU has serviced that pending interrupt and
-	 * it might not have done the ack_APIC_irq() because it thought,
-	 * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
-	 * does not clear the ISR bit and cpu thinks it has already serivced
-	 * the interrupt. Hence a vector might get locked. It was noticed
-	 * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
+	 * update_process_times() expects us to have done irq_enter().
+	 * Besides, if we don't timer interrupts ignore the global
+	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
-	for (i = APIC_ISR_NR - 1; i >= 0; i--) {
-		value = apic_read(APIC_ISR + i*0x10);
-		for (j = 31; j >= 0; j--) {
-			if (value & (1<<j))
-				ack_APIC_irq();
-		}
-	}
+	irq_enter();
+	smp_local_timer_interrupt();
+	irq_exit();
+	set_irq_regs(old_regs);
+}
 
-	/*
-	 * Now that we are all set up, enable the APIC
-	 */
-	value = apic_read(APIC_SPIV);
-	value &= ~APIC_VECTOR_MASK;
-	/*
-	 * Enable APIC
-	 */
-	value |= APIC_SPIV_APIC_ENABLED;
+#ifndef CONFIG_SMP
+static void up_apic_timer_interrupt_call(void)
+{
+	int cpu = smp_processor_id();
 
 	/*
-	 * Some unknown Intel IO/APIC (or APIC) errata is biting us with
-	 * certain networking cards. If high frequency interrupts are
-	 * happening on a particular IOAPIC pin, plus the IOAPIC routing
-	 * entry is masked/unmasked at a high rate as well then sooner or
-	 * later IOAPIC line gets 'stuck', no more interrupts are received
-	 * from the device. If focus CPU is disabled then the hang goes
-	 * away, oh well :-(
-	 *
-	 * [ This bug can be reproduced easily with a level-triggered
-	 *   PCI Ne2000 networking cards and PII/PIII processors, dual
-	 *   BX chipset. ]
-	 */
-	/*
-	 * Actually disabling the focus CPU check just makes the hang less
-	 * frequent as it makes the interrupt distributon model be more
-	 * like LRU than MRU (the short-term load is more even across CPUs).
-	 * See also the comment in end_level_ioapic_irq().  --macro
+	 * the NMI deadlock-detector uses this.
 	 */
-#if 1
-	/* Enable focus processor (bit==0) */
-	value &= ~APIC_SPIV_FOCUS_DISABLED;
+	per_cpu(irq_stat, cpu).apic_timer_irqs++;
+
+	smp_local_timer_interrupt();
+}
+#endif
+
+void smp_send_timer_broadcast_ipi(void)
+{
+	cpumask_t mask;
+
+	cpus_and(mask, cpu_online_map, timer_bcast_ipi);
+	if (!cpus_empty(mask)) {
+#ifdef CONFIG_SMP
+		send_IPI_mask(mask, LOCAL_TIMER_VECTOR);
 #else
-	/* Disable focus processor (bit==1) */
-	value |= APIC_SPIV_FOCUS_DISABLED;
+		/*
+		 * We can directly call the apic timer interrupt handler
+		 * in UP case. Minus all irq related functions
+		 */
+		up_apic_timer_interrupt_call();
 #endif
-	/*
-	 * Set spurious IRQ vector
-	 */
-	value |= SPURIOUS_APIC_VECTOR;
-	apic_write_around(APIC_SPIV, value);
+	}
+}
+
+int setup_profiling_timer(unsigned int multiplier)
+{
+	return -EINVAL;
+}
+
+/*
+ * Local APIC start and shutdown
+ */
+
+/**
+ * clear_local_APIC - shutdown the local APIC
+ *
+ * This is called, when a CPU is disabled and before rebooting, so the state of
+ * the local APIC has no dangling leftovers. Also used to cleanout any BIOS
+ * leftovers during boot.
+ */
+void clear_local_APIC(void)
+{
+	int maxlvt = lapic_get_maxlvt();
+	unsigned long v;
 
 	/*
-	 * Set up LVT0, LVT1:
-	 *
-	 * set up through-local-APIC on the BP's LINT0. This is not
-	 * strictly necessery in pure symmetric-IO mode, but sometimes
-	 * we delegate interrupts to the 8259A.
+	 * Masking an LVT entry can trigger a local APIC error
+	 * if the vector is zero. Mask LVTERR first to prevent this.
 	 */
+	if (maxlvt >= 3) {
+		v = ERROR_APIC_VECTOR; /* any non-zero vector will do */
+		apic_write_around(APIC_LVTERR, v | APIC_LVT_MASKED);
+	}
 	/*
-	 * TODO: set up through-local-APIC from through-I/O-APIC? --macro
+	 * Careful: we have to set masks only first to deassert
+	 * any level-triggered sources.
 	 */
-	value = apic_read(APIC_LVT0) & APIC_LVT_MASKED;
-	if (!smp_processor_id() && (pic_mode || !value)) {
-		value = APIC_DM_EXTINT;
-		apic_printk(APIC_VERBOSE, "enabled ExtINT on CPU#%d\n",
-				smp_processor_id());
-	} else {
-		value = APIC_DM_EXTINT | APIC_LVT_MASKED;
-		apic_printk(APIC_VERBOSE, "masked ExtINT on CPU#%d\n",
-				smp_processor_id());
+	v = apic_read(APIC_LVTT);
+	apic_write_around(APIC_LVTT, v | APIC_LVT_MASKED);
+	v = apic_read(APIC_LVT0);
+	apic_write_around(APIC_LVT0, v | APIC_LVT_MASKED);
+	v = apic_read(APIC_LVT1);
+	apic_write_around(APIC_LVT1, v | APIC_LVT_MASKED);
+	if (maxlvt >= 4) {
+		v = apic_read(APIC_LVTPC);
+		apic_write_around(APIC_LVTPC, v | APIC_LVT_MASKED);
 	}
-	apic_write_around(APIC_LVT0, value);
 
+	/* lets not touch this if we didn't frob it */
+#ifdef CONFIG_X86_MCE_P4THERMAL
+	if (maxlvt >= 5) {
+		v = apic_read(APIC_LVTTHMR);
+		apic_write_around(APIC_LVTTHMR, v | APIC_LVT_MASKED);
+	}
+#endif
 	/*
-	 * only the BP should see the LINT1 NMI signal, obviously.
+	 * Clean APIC state for other OSs:
 	 */
-	if (!smp_processor_id())
-		value = APIC_DM_NMI;
-	else
-		value = APIC_DM_NMI | APIC_LVT_MASKED;
-	if (!APIC_INTEGRATED(ver))		/* 82489DX */
-		value |= APIC_LVT_LEVEL_TRIGGER;
-	apic_write_around(APIC_LVT1, value);
-
-	if (APIC_INTEGRATED(ver) && !esr_disable) {		/* !82489DX */
-		maxlvt = get_maxlvt();
-		if (maxlvt > 3)		/* Due to the Pentium erratum 3AP. */
-			apic_write(APIC_ESR, 0);
-		oldvalue = apic_read(APIC_ESR);
+	apic_write_around(APIC_LVTT, APIC_LVT_MASKED);
+	apic_write_around(APIC_LVT0, APIC_LVT_MASKED);
+	apic_write_around(APIC_LVT1, APIC_LVT_MASKED);
+	if (maxlvt >= 3)
+		apic_write_around(APIC_LVTERR, APIC_LVT_MASKED);
+	if (maxlvt >= 4)
+		apic_write_around(APIC_LVTPC, APIC_LVT_MASKED);
 
-		value = ERROR_APIC_VECTOR;      // enables sending errors
-		apic_write_around(APIC_LVTERR, value);
-		/*
-		 * spec says clear errors after enabling vector.
-		 */
+#ifdef CONFIG_X86_MCE_P4THERMAL
+	if (maxlvt >= 5)
+		apic_write_around(APIC_LVTTHMR, APIC_LVT_MASKED);
+#endif
+	/* Integrated APIC (!82489DX) ? */
+	if (lapic_is_integrated()) {
 		if (maxlvt > 3)
+			/* Clear ESR due to Pentium errata 3AP and 11AP */
 			apic_write(APIC_ESR, 0);
-		value = apic_read(APIC_ESR);
-		if (value != oldvalue)
-			apic_printk(APIC_VERBOSE, "ESR value before enabling "
-				"vector: 0x%08lx  after: 0x%08lx\n",
-				oldvalue, value);
-	} else {
-		if (esr_disable)	
-			/* 
-			 * Something untraceble is creating bad interrupts on 
-			 * secondary quads ... for the moment, just leave the
-			 * ESR disabled - we can't do anything useful with the
-			 * errors anyway - mbligh
-			 */
-			printk("Leaving ESR disabled.\n");
-		else 
-			printk("No ESR for 82489DX.\n");
+		apic_read(APIC_ESR);
 	}
+}
 
-	setup_apic_nmi_watchdog(NULL);
-	apic_pm_activate();
+/**
+ * disable_local_APIC - clear and disable the local APIC
+ */
+void disable_local_APIC(void)
+{
+	unsigned long value;
+
+	clear_local_APIC();
+
+	/*
+	 * Disable APIC (implies clearing of registers
+	 * for 82489DX!).
+	 */
+	value = apic_read(APIC_SPIV);
+	value &= ~APIC_SPIV_APIC_ENABLED;
+	apic_write_around(APIC_SPIV, value);
+
+	/*
+	 * When LAPIC was disabled by the BIOS and enabled by the kernel,
+	 * restore the disabled state.
+	 */
+	if (enabled_via_apicbase) {
+		unsigned int l, h;
+
+		rdmsr(MSR_IA32_APICBASE, l, h);
+		l &= ~MSR_IA32_APICBASE_ENABLE;
+		wrmsr(MSR_IA32_APICBASE, l, h);
+	}
 }
 
 /*
- * If Linux enabled the LAPIC against the BIOS default
- * disable it down before re-entering the BIOS on shutdown.
- * Otherwise the BIOS may get confused and not power-off.
- * Additionally clear all LVT entries before disable_local_APIC
+ * If Linux enabled the LAPIC against the BIOS default disable it down before
+ * re-entering the BIOS on shutdown.  Otherwise the BIOS may get confused and
+ * not power-off.  Additionally clear all LVT entries before disable_local_APIC
  * for the case where Linux didn't enable the LAPIC.
  */
 void lapic_shutdown(void)
@@ -624,168 +629,296 @@ void lapic_shutdown(void)
 	local_irq_restore(flags);
 }
 
-#ifdef CONFIG_PM
-
-static struct {
-	int active;
-	/* r/w apic fields */
-	unsigned int apic_id;
-	unsigned int apic_taskpri;
-	unsigned int apic_ldr;
-	unsigned int apic_dfr;
-	unsigned int apic_spiv;
-	unsigned int apic_lvtt;
-	unsigned int apic_lvtpc;
-	unsigned int apic_lvt0;
-	unsigned int apic_lvt1;
-	unsigned int apic_lvterr;
-	unsigned int apic_tmict;
-	unsigned int apic_tdcr;
-	unsigned int apic_thmr;
-} apic_pm_state;
-
-static int lapic_suspend(struct sys_device *dev, pm_message_t state)
+/*
+ * This is to verify that we're looking at a real local APIC.
+ * Check these against your board if the CPUs aren't getting
+ * started for no apparent reason.
+ */
+int __init verify_local_APIC(void)
 {
-	unsigned long flags;
-	int maxlvt;
+	unsigned int reg0, reg1;
 
-	if (!apic_pm_state.active)
+	/*
+	 * The version register is read-only in a real APIC.
+	 */
+	reg0 = apic_read(APIC_LVR);
+	apic_printk(APIC_DEBUG, "Getting VERSION: %x\n", reg0);
+	apic_write(APIC_LVR, reg0 ^ APIC_LVR_MASK);
+	reg1 = apic_read(APIC_LVR);
+	apic_printk(APIC_DEBUG, "Getting VERSION: %x\n", reg1);
+
+	/*
+	 * The two version reads above should print the same
+	 * numbers.  If the second one is different, then we
+	 * poke at a non-APIC.
+	 */
+	if (reg1 != reg0)
 		return 0;
 
-	maxlvt = get_maxlvt();
+	/*
+	 * Check if the version looks reasonably.
+	 */
+	reg1 = GET_APIC_VERSION(reg0);
+	if (reg1 == 0x00 || reg1 == 0xff)
+		return 0;
+	reg1 = lapic_get_maxlvt();
+	if (reg1 < 0x02 || reg1 == 0xff)
+		return 0;
 
-	apic_pm_state.apic_id = apic_read(APIC_ID);
-	apic_pm_state.apic_taskpri = apic_read(APIC_TASKPRI);
-	apic_pm_state.apic_ldr = apic_read(APIC_LDR);
-	apic_pm_state.apic_dfr = apic_read(APIC_DFR);
-	apic_pm_state.apic_spiv = apic_read(APIC_SPIV);
-	apic_pm_state.apic_lvtt = apic_read(APIC_LVTT);
-	if (maxlvt >= 4)
-		apic_pm_state.apic_lvtpc = apic_read(APIC_LVTPC);
-	apic_pm_state.apic_lvt0 = apic_read(APIC_LVT0);
-	apic_pm_state.apic_lvt1 = apic_read(APIC_LVT1);
-	apic_pm_state.apic_lvterr = apic_read(APIC_LVTERR);
-	apic_pm_state.apic_tmict = apic_read(APIC_TMICT);
-	apic_pm_state.apic_tdcr = apic_read(APIC_TDCR);
-#ifdef CONFIG_X86_MCE_P4THERMAL
-	if (maxlvt >= 5)
-		apic_pm_state.apic_thmr = apic_read(APIC_LVTTHMR);
-#endif
-	
-	local_irq_save(flags);
-	disable_local_APIC();
-	local_irq_restore(flags);
-	return 0;
+	/*
+	 * The ID register is read/write in a real APIC.
+	 */
+	reg0 = apic_read(APIC_ID);
+	apic_printk(APIC_DEBUG, "Getting ID: %x\n", reg0);
+
+	/*
+	 * The next two are just to see if we have sane values.
+	 * They're only really relevant if we're in Virtual Wire
+	 * compatibility mode, but most boxes are anymore.
+	 */
+	reg0 = apic_read(APIC_LVT0);
+	apic_printk(APIC_DEBUG, "Getting LVT0: %x\n", reg0);
+	reg1 = apic_read(APIC_LVT1);
+	apic_printk(APIC_DEBUG, "Getting LVT1: %x\n", reg1);
+
+	return 1;
 }
 
-static int lapic_resume(struct sys_device *dev)
+/**
+ * sync_Arb_IDs - synchronize APIC bus arbitration IDs
+ */
+void __init sync_Arb_IDs(void)
 {
-	unsigned int l, h;
-	unsigned long flags;
-	int maxlvt;
+	/*
+	 * Unsupported on P4 - see Intel Dev. Manual Vol. 3, Ch. 8.6.1 And not
+	 * needed on AMD.
+	 */
+	if (modern_apic())
+		return;
+	/*
+	 * Wait for idle.
+	 */
+	apic_wait_icr_idle();
 
-	if (!apic_pm_state.active)
-		return 0;
+	apic_printk(APIC_DEBUG, "Synchronizing Arb IDs.\n");
+	apic_write_around(APIC_ICR, APIC_DEST_ALLINC | APIC_INT_LEVELTRIG
+				| APIC_DM_INIT);
+}
 
-	maxlvt = get_maxlvt();
+/*
+ * An initial setup of the virtual wire mode.
+ */
+void __init init_bsp_APIC(void)
+{
+	unsigned long value;
 
-	local_irq_save(flags);
+	/*
+	 * Don't do the setup now if we have a SMP BIOS as the
+	 * through-I/O-APIC virtual wire mode might be active.
+	 */
+	if (smp_found_config || !cpu_has_apic)
+		return;
 
 	/*
-	 * Make sure the APICBASE points to the right address
-	 *
-	 * FIXME! This will be wrong if we ever support suspend on
-	 * SMP! We'll need to do this as part of the CPU restore!
+	 * Do not trust the local APIC being empty at bootup.
 	 */
-	rdmsr(MSR_IA32_APICBASE, l, h);
-	l &= ~MSR_IA32_APICBASE_BASE;
-	l |= MSR_IA32_APICBASE_ENABLE | mp_lapic_addr;
-	wrmsr(MSR_IA32_APICBASE, l, h);
+	clear_local_APIC();
 
-	apic_write(APIC_LVTERR, ERROR_APIC_VECTOR | APIC_LVT_MASKED);
-	apic_write(APIC_ID, apic_pm_state.apic_id);
-	apic_write(APIC_DFR, apic_pm_state.apic_dfr);
-	apic_write(APIC_LDR, apic_pm_state.apic_ldr);
-	apic_write(APIC_TASKPRI, apic_pm_state.apic_taskpri);
-	apic_write(APIC_SPIV, apic_pm_state.apic_spiv);
-	apic_write(APIC_LVT0, apic_pm_state.apic_lvt0);
-	apic_write(APIC_LVT1, apic_pm_state.apic_lvt1);
-#ifdef CONFIG_X86_MCE_P4THERMAL
-	if (maxlvt >= 5)
-		apic_write(APIC_LVTTHMR, apic_pm_state.apic_thmr);
-#endif
-	if (maxlvt >= 4)
-		apic_write(APIC_LVTPC, apic_pm_state.apic_lvtpc);
-	apic_write(APIC_LVTT, apic_pm_state.apic_lvtt);
-	apic_write(APIC_TDCR, apic_pm_state.apic_tdcr);
-	apic_write(APIC_TMICT, apic_pm_state.apic_tmict);
-	apic_write(APIC_ESR, 0);
-	apic_read(APIC_ESR);
-	apic_write(APIC_LVTERR, apic_pm_state.apic_lvterr);
-	apic_write(APIC_ESR, 0);
-	apic_read(APIC_ESR);
-	local_irq_restore(flags);
-	return 0;
+	/*
+	 * Enable APIC.
+	 */
+	value = apic_read(APIC_SPIV);
+	value &= ~APIC_VECTOR_MASK;
+	value |= APIC_SPIV_APIC_ENABLED;
+
+	/* This bit is reserved on P4/Xeon and should be cleared */
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
+	    (boot_cpu_data.x86 == 15))
+		value &= ~APIC_SPIV_FOCUS_DISABLED;
+	else
+		value |= APIC_SPIV_FOCUS_DISABLED;
+	value |= SPURIOUS_APIC_VECTOR;
+	apic_write_around(APIC_SPIV, value);
+
+	/*
+	 * Set up the virtual wire mode.
+	 */
+	apic_write_around(APIC_LVT0, APIC_DM_EXTINT);
+	value = APIC_DM_NMI;
+	if (!lapic_is_integrated())		/* 82489DX */
+		value |= APIC_LVT_LEVEL_TRIGGER;
+	apic_write_around(APIC_LVT1, value);
 }
 
-/*
- * This device has no shutdown method - fully functioning local APICs
- * are needed on every CPU up until machine_halt/restart/poweroff.
+/**
+ * setup_local_APIC - setup the local APIC
  */
+void __devinit setup_local_APIC(void)
+{
+	unsigned long oldvalue, value, maxlvt, integrated;
+	int i, j;
 
-static struct sysdev_class lapic_sysclass = {
-	set_kset_name("lapic"),
-	.resume		= lapic_resume,
-	.suspend	= lapic_suspend,
-};
+	/* Pound the ESR really hard over the head with a big hammer - mbligh */
+	if (esr_disable) {
+		apic_write(APIC_ESR, 0);
+		apic_write(APIC_ESR, 0);
+		apic_write(APIC_ESR, 0);
+		apic_write(APIC_ESR, 0);
+	}
 
-static struct sys_device device_lapic = {
-	.id	= 0,
-	.cls	= &lapic_sysclass,
-};
+	integrated = lapic_is_integrated();
 
-static void __devinit apic_pm_activate(void)
-{
-	apic_pm_state.active = 1;
-}
+	/*
+	 * Double-check whether this APIC is really registered.
+	 */
+	if (!apic_id_registered())
+		BUG();
 
-static int __init init_lapic_sysfs(void)
-{
-	int error;
+	/*
+	 * Intel recommends to set DFR, LDR and TPR before enabling
+	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
+	 * document number 292116).  So here it goes...
+	 */
+	init_apic_ldr();
 
-	if (!cpu_has_apic)
-		return 0;
-	/* XXX: remove suspend/resume procs if !apic_pm_state.active? */
+	/*
+	 * Set Task Priority to 'accept all'. We never change this
+	 * later on.
+	 */
+	value = apic_read(APIC_TASKPRI);
+	value &= ~APIC_TPRI_MASK;
+	apic_write_around(APIC_TASKPRI, value);
 
-	error = sysdev_class_register(&lapic_sysclass);
-	if (!error)
-		error = sysdev_register(&device_lapic);
-	return error;
-}
-device_initcall(init_lapic_sysfs);
+	/*
+	 * After a crash, we no longer service the interrupts and a pending
+	 * interrupt from previous kernel might still have ISR bit set.
+	 *
+	 * Most probably by now CPU has serviced that pending interrupt and
+	 * it might not have done the ack_APIC_irq() because it thought,
+	 * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
+	 * does not clear the ISR bit and cpu thinks it has already serivced
+	 * the interrupt. Hence a vector might get locked. It was noticed
+	 * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
+	 */
+	for (i = APIC_ISR_NR - 1; i >= 0; i--) {
+		value = apic_read(APIC_ISR + i*0x10);
+		for (j = 31; j >= 0; j--) {
+			if (value & (1<<j))
+				ack_APIC_irq();
+		}
+	}
 
-#else	/* CONFIG_PM */
+	/*
+	 * Now that we are all set up, enable the APIC
+	 */
+	value = apic_read(APIC_SPIV);
+	value &= ~APIC_VECTOR_MASK;
+	/*
+	 * Enable APIC
+	 */
+	value |= APIC_SPIV_APIC_ENABLED;
 
-static void apic_pm_activate(void) { }
+	/*
+	 * Some unknown Intel IO/APIC (or APIC) errata is biting us with
+	 * certain networking cards. If high frequency interrupts are
+	 * happening on a particular IOAPIC pin, plus the IOAPIC routing
+	 * entry is masked/unmasked at a high rate as well then sooner or
+	 * later IOAPIC line gets 'stuck', no more interrupts are received
+	 * from the device. If focus CPU is disabled then the hang goes
+	 * away, oh well :-(
+	 *
+	 * [ This bug can be reproduced easily with a level-triggered
+	 *   PCI Ne2000 networking cards and PII/PIII processors, dual
+	 *   BX chipset. ]
+	 */
+	/*
+	 * Actually disabling the focus CPU check just makes the hang less
+	 * frequent as it makes the interrupt distributon model be more
+	 * like LRU than MRU (the short-term load is more even across CPUs).
+	 * See also the comment in end_level_ioapic_irq().  --macro
+	 */
 
-#endif	/* CONFIG_PM */
+	/* Enable focus processor (bit==0) */
+	value &= ~APIC_SPIV_FOCUS_DISABLED;
 
-/*
- * Detect and enable local APICs on non-SMP boards.
- * Original code written by Keir Fraser.
- */
+	/*
+	 * Set spurious IRQ vector
+	 */
+	value |= SPURIOUS_APIC_VECTOR;
+	apic_write_around(APIC_SPIV, value);
+
+	/*
+	 * Set up LVT0, LVT1:
+	 *
+	 * set up through-local-APIC on the BP's LINT0. This is not
+	 * strictly necessery in pure symmetric-IO mode, but sometimes
+	 * we delegate interrupts to the 8259A.
+	 */
+	/*
+	 * TODO: set up through-local-APIC from through-I/O-APIC? --macro
+	 */
+	value = apic_read(APIC_LVT0) & APIC_LVT_MASKED;
+	if (!smp_processor_id() && (pic_mode || !value)) {
+		value = APIC_DM_EXTINT;
+		apic_printk(APIC_VERBOSE, "enabled ExtINT on CPU#%d\n",
+				smp_processor_id());
+	} else {
+		value = APIC_DM_EXTINT | APIC_LVT_MASKED;
+		apic_printk(APIC_VERBOSE, "masked ExtINT on CPU#%d\n",
+				smp_processor_id());
+	}
+	apic_write_around(APIC_LVT0, value);
+
+	/*
+	 * only the BP should see the LINT1 NMI signal, obviously.
+	 */
+	if (!smp_processor_id())
+		value = APIC_DM_NMI;
+	else
+		value = APIC_DM_NMI | APIC_LVT_MASKED;
+	if (!integrated)		/* 82489DX */
+		value |= APIC_LVT_LEVEL_TRIGGER;
+	apic_write_around(APIC_LVT1, value);
+
+	if (integrated && !esr_disable) {		/* !82489DX */
+		maxlvt = lapic_get_maxlvt();
+		if (maxlvt > 3)		/* Due to the Pentium erratum 3AP. */
+			apic_write(APIC_ESR, 0);
+		oldvalue = apic_read(APIC_ESR);
+
+		/* enables sending errors */
+		value = ERROR_APIC_VECTOR;
+		apic_write_around(APIC_LVTERR, value);
+		/*
+		 * spec says clear errors after enabling vector.
+		 */
+		if (maxlvt > 3)
+			apic_write(APIC_ESR, 0);
+		value = apic_read(APIC_ESR);
+		if (value != oldvalue)
+			apic_printk(APIC_VERBOSE, "ESR value before enabling "
+				"vector: 0x%08lx  after: 0x%08lx\n",
+				oldvalue, value);
+	} else {
+		if (esr_disable)
+			/*
+			 * Something untraceble is creating bad interrupts on
+			 * secondary quads ... for the moment, just leave the
+			 * ESR disabled - we can't do anything useful with the
+			 * errors anyway - mbligh
+			 */
+			printk(KERN_INFO "Leaving ESR disabled.\n");
+		else
+			printk(KERN_INFO "No ESR for 82489DX.\n");
+	}
 
-static int __init apic_set_verbosity(char *str)
-{
-	if (strcmp("debug", str) == 0)
-		apic_verbosity = APIC_DEBUG;
-	else if (strcmp("verbose", str) == 0)
-		apic_verbosity = APIC_VERBOSE;
-	return 1;
+	setup_apic_nmi_watchdog(NULL);
+	apic_pm_activate();
 }
 
-__setup("apic=", apic_set_verbosity);
-
+/*
+ * Detect and initialize APIC
+ */
 static int __init detect_init_APIC (void)
 {
 	u32 h, l, features;
@@ -797,7 +930,7 @@ static int __init detect_init_APIC (void
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
 		if ((boot_cpu_data.x86 == 6 && boot_cpu_data.x86_model > 1) ||
-		    (boot_cpu_data.x86 == 15))	    
+		    (boot_cpu_data.x86 == 15))
 			break;
 		goto no_apic;
 	case X86_VENDOR_INTEL:
@@ -811,23 +944,23 @@ static int __init detect_init_APIC (void
 
 	if (!cpu_has_apic) {
 		/*
-		 * Over-ride BIOS and try to enable the local
-		 * APIC only if "lapic" specified.
+		 * Over-ride BIOS and try to enable the local APIC only if
+		 * "lapic" specified.
 		 */
 		if (enable_local_apic <= 0) {
-			printk("Local APIC disabled by BIOS -- "
+			printk(KERN_INFO "Local APIC disabled by BIOS -- "
 			       "you can enable it with \"lapic\"\n");
 			return -1;
 		}
 		/*
-		 * Some BIOSes disable the local APIC in the
-		 * APIC_BASE MSR. This can only be done in
-		 * software for Intel P6 or later and AMD K7
-		 * (Model > 1) or later.
+		 * Some BIOSes disable the local APIC in the APIC_BASE
+		 * MSR. This can only be done in software for Intel P6 or later
+		 * and AMD K7 (Model > 1) or later.
 		 */
 		rdmsr(MSR_IA32_APICBASE, l, h);
 		if (!(l & MSR_IA32_APICBASE_ENABLE)) {
-			printk("Local APIC disabled by BIOS -- reenabling.\n");
+			printk(KERN_INFO
+			       "Local APIC disabled by BIOS -- reenabling.\n");
 			l &= ~MSR_IA32_APICBASE_BASE;
 			l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
 			wrmsr(MSR_IA32_APICBASE, l, h);
@@ -840,463 +973,174 @@ static int __init detect_init_APIC (void
 	 */
 	features = cpuid_edx(1);
 	if (!(features & (1 << X86_FEATURE_APIC))) {
-		printk("Could not enable APIC!\n");
+		printk(KERN_WARNING "Could not enable APIC!\n");
 		return -1;
 	}
 	set_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
 
 	/* The BIOS may have set up the APIC at some other address */
-	rdmsr(MSR_IA32_APICBASE, l, h);
-	if (l & MSR_IA32_APICBASE_ENABLE)
-		mp_lapic_addr = l & MSR_IA32_APICBASE_BASE;
-
-	if (nmi_watchdog != NMI_NONE)
-		nmi_watchdog = NMI_LOCAL_APIC;
-
-	printk("Found and enabled local APIC!\n");
-
-	apic_pm_activate();
-
-	return 0;
-
-no_apic:
-	printk("No local APIC present or hardware disabled\n");
-	return -1;
-}
-
-void __init init_apic_mappings(void)
-{
-	unsigned long apic_phys;
-
-	/*
-	 * If no local APIC can be found then set up a fake all
-	 * zeroes page to simulate the local APIC and another
-	 * one for the IO-APIC.
-	 */
-	if (!smp_found_config && detect_init_APIC()) {
-		apic_phys = (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
-		apic_phys = __pa(apic_phys);
-	} else
-		apic_phys = mp_lapic_addr;
-
-	set_fixmap_nocache(FIX_APIC_BASE, apic_phys);
-	printk(KERN_DEBUG "mapped APIC to %08lx (%08lx)\n", APIC_BASE,
-	       apic_phys);
-
-	/*
-	 * Fetch the APIC ID of the BSP in case we have a
-	 * default configuration (or the MP table is broken).
-	 */
-	if (boot_cpu_physical_apicid == -1U)
-		boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
-
-#ifdef CONFIG_X86_IO_APIC
-	{
-		unsigned long ioapic_phys, idx = FIX_IO_APIC_BASE_0;
-		int i;
-
-		for (i = 0; i < nr_ioapics; i++) {
-			if (smp_found_config) {
-				ioapic_phys = mp_ioapics[i].mpc_apicaddr;
-				if (!ioapic_phys) {
-					printk(KERN_ERR
-					       "WARNING: bogus zero IO-APIC "
-					       "address found in MPTABLE, "
-					       "disabling IO/APIC support!\n");
-					smp_found_config = 0;
-					skip_ioapic_setup = 1;
-					goto fake_ioapic_page;
-				}
-			} else {
-fake_ioapic_page:
-				ioapic_phys = (unsigned long)
-					      alloc_bootmem_pages(PAGE_SIZE);
-				ioapic_phys = __pa(ioapic_phys);
-			}
-			set_fixmap_nocache(idx, ioapic_phys);
-			printk(KERN_DEBUG "mapped IOAPIC to %08lx (%08lx)\n",
-			       __fix_to_virt(idx), ioapic_phys);
-			idx++;
-		}
-	}
-#endif
-}
-
-/*
- * This part sets up the APIC 32 bit clock in LVTT1, with HZ interrupts
- * per second. We assume that the caller has already set up the local
- * APIC.
- *
- * The APIC timer is not exactly sync with the external timer chip, it
- * closely follows bus clocks.
- */
-
-/*
- * The timer chip is already set up at HZ interrupts per second here,
- * but we do not accept timer interrupts yet. We only allow the BP
- * to calibrate.
- */
-static unsigned int __devinit get_8254_timer_count(void)
-{
-	unsigned long flags;
-
-	unsigned int count;
-
-	spin_lock_irqsave(&i8253_lock, flags);
-
-	outb_p(0x00, PIT_MODE);
-	count = inb_p(PIT_CH0);
-	count |= inb_p(PIT_CH0) << 8;
-
-	spin_unlock_irqrestore(&i8253_lock, flags);
-
-	return count;
-}
-
-/* next tick in 8254 can be caught by catching timer wraparound */
-static void __devinit wait_8254_wraparound(void)
-{
-	unsigned int curr_count, prev_count;
-
-	curr_count = get_8254_timer_count();
-	do {
-		prev_count = curr_count;
-		curr_count = get_8254_timer_count();
-
-		/* workaround for broken Mercury/Neptune */
-		if (prev_count >= curr_count + 0x100)
-			curr_count = get_8254_timer_count();
-
-	} while (prev_count >= curr_count);
-}
-
-/*
- * Default initialization for 8254 timers. If we use other timers like HPET,
- * we override this later
- */
-void (*wait_timer_tick)(void) __devinitdata = wait_8254_wraparound;
-
-/*
- * This function sets up the local APIC timer, with a timeout of
- * 'clocks' APIC bus clock. During calibration we actually call
- * this function twice on the boot CPU, once with a bogus timeout
- * value, second time for real. The other (noncalibrating) CPUs
- * call this function only once, with the real, calibrated value.
- *
- * We do reads before writes even if unnecessary, to get around the
- * P5 APIC double write bug.
- */
-
-#define APIC_DIVISOR 16
-
-static void __setup_APIC_LVTT(unsigned int clocks)
-{
-	unsigned int lvtt_value, tmp_value, ver;
-	int cpu = smp_processor_id();
-
-	ver = GET_APIC_VERSION(apic_read(APIC_LVR));
-	lvtt_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
-	if (!APIC_INTEGRATED(ver))
-		lvtt_value |= SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV);
-
-	if (cpu_isset(cpu, timer_bcast_ipi))
-		lvtt_value |= APIC_LVT_MASKED;
-
-	apic_write_around(APIC_LVTT, lvtt_value);
-
-	/*
-	 * Divide PICLK by 16
-	 */
-	tmp_value = apic_read(APIC_TDCR);
-	apic_write_around(APIC_TDCR, (tmp_value
-				& ~(APIC_TDR_DIV_1 | APIC_TDR_DIV_TMBASE))
-				| APIC_TDR_DIV_16);
-
-	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
-}
-
-static void __devinit setup_APIC_timer(unsigned int clocks)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	/*
-	 * Wait for IRQ0's slice:
-	 */
-	wait_timer_tick();
-
-	__setup_APIC_LVTT(clocks);
-
-	local_irq_restore(flags);
-}
-
-/*
- * In this function we calibrate APIC bus clocks to the external
- * timer. Unfortunately we cannot use jiffies and the timer irq
- * to calibrate, since some later bootup code depends on getting
- * the first irq? Ugh.
- *
- * We want to do the calibration only once since we
- * want to have local timer irqs syncron. CPUs connected
- * by the same APIC bus have the very same bus frequency.
- * And we want to have irqs off anyways, no accidental
- * APIC irq that way.
- */
-
-static int __init calibrate_APIC_clock(void)
-{
-	unsigned long long t1 = 0, t2 = 0;
-	long tt1, tt2;
-	long result;
-	int i;
-	const int LOOPS = HZ/10;
-
-	apic_printk(APIC_VERBOSE, "calibrating APIC timer ...\n");
-
-	/*
-	 * Put whatever arbitrary (but long enough) timeout
-	 * value into the APIC clock, we just want to get the
-	 * counter running for calibration.
-	 */
-	__setup_APIC_LVTT(1000000000);
-
-	/*
-	 * The timer chip counts down to zero. Let's wait
-	 * for a wraparound to start exact measurement:
-	 * (the current tick might have been already half done)
-	 */
-
-	wait_timer_tick();
-
-	/*
-	 * We wrapped around just now. Let's start:
-	 */
-	if (cpu_has_tsc)
-		rdtscll(t1);
-	tt1 = apic_read(APIC_TMCCT);
-
-	/*
-	 * Let's wait LOOPS wraprounds:
-	 */
-	for (i = 0; i < LOOPS; i++)
-		wait_timer_tick();
-
-	tt2 = apic_read(APIC_TMCCT);
-	if (cpu_has_tsc)
-		rdtscll(t2);
-
-	/*
-	 * The APIC bus clock counter is 32 bits only, it
-	 * might have overflown, but note that we use signed
-	 * longs, thus no extra care needed.
-	 *
-	 * underflown to be exact, as the timer counts down ;)
-	 */
+	rdmsr(MSR_IA32_APICBASE, l, h);
+	if (l & MSR_IA32_APICBASE_ENABLE)
+		mp_lapic_addr = l & MSR_IA32_APICBASE_BASE;
 
-	result = (tt1-tt2)*APIC_DIVISOR/LOOPS;
+	if (nmi_watchdog != NMI_NONE)
+		nmi_watchdog = NMI_LOCAL_APIC;
 
-	if (cpu_has_tsc)
-		apic_printk(APIC_VERBOSE, "..... CPU clock speed is "
-			"%ld.%04ld MHz.\n",
-			((long)(t2-t1)/LOOPS)/(1000000/HZ),
-			((long)(t2-t1)/LOOPS)%(1000000/HZ));
+	printk(KERN_INFO "Found and enabled local APIC!\n");
 
-	apic_printk(APIC_VERBOSE, "..... host bus clock speed is "
-		"%ld.%04ld MHz.\n",
-		result/(1000000/HZ),
-		result%(1000000/HZ));
+	apic_pm_activate();
 
-	return result;
-}
+	return 0;
 
-static unsigned int calibration_result;
+no_apic:
+	printk(KERN_INFO "No local APIC present or hardware disabled\n");
+	return -1;
+}
 
-void __init setup_boot_APIC_clock(void)
+/**
+ * init_apic_mappings - initialize APIC mappings
+ */
+void __init init_apic_mappings(void)
 {
-	unsigned long flags;
-	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n");
-	using_apic_timer = 1;
-
-	local_irq_save(flags);
+	unsigned long apic_phys;
 
-	calibration_result = calibrate_APIC_clock();
 	/*
-	 * Now set up the timer for real.
+	 * If no local APIC can be found then set up a fake all
+	 * zeroes page to simulate the local APIC and another
+	 * one for the IO-APIC.
 	 */
-	setup_APIC_timer(calibration_result);
+	if (!smp_found_config && detect_init_APIC()) {
+		apic_phys = (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
+		apic_phys = __pa(apic_phys);
+	} else
+		apic_phys = mp_lapic_addr;
 
-	local_irq_restore(flags);
-}
+	set_fixmap_nocache(FIX_APIC_BASE, apic_phys);
+	printk(KERN_DEBUG "mapped APIC to %08lx (%08lx)\n", APIC_BASE,
+	       apic_phys);
 
-void __devinit setup_secondary_APIC_clock(void)
-{
-	setup_APIC_timer(calibration_result);
-}
+	/*
+	 * Fetch the APIC ID of the BSP in case we have a
+	 * default configuration (or the MP table is broken).
+	 */
+	if (boot_cpu_physical_apicid == -1U)
+		boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
 
-void disable_APIC_timer(void)
-{
-	if (using_apic_timer) {
-		unsigned long v;
+#ifdef CONFIG_X86_IO_APIC
+	{
+		unsigned long ioapic_phys, idx = FIX_IO_APIC_BASE_0;
+		int i;
 
-		v = apic_read(APIC_LVTT);
-		/*
-		 * When an illegal vector value (0-15) is written to an LVT
-		 * entry and delivery mode is Fixed, the APIC may signal an
-		 * illegal vector error, with out regard to whether the mask
-		 * bit is set or whether an interrupt is actually seen on input.
-		 *
-		 * Boot sequence might call this function when the LVTT has
-		 * '0' vector value. So make sure vector field is set to
-		 * valid value.
-		 */
-		v |= (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
-		apic_write_around(APIC_LVTT, v);
+		for (i = 0; i < nr_ioapics; i++) {
+			if (smp_found_config) {
+				ioapic_phys = mp_ioapics[i].mpc_apicaddr;
+				if (!ioapic_phys) {
+					printk(KERN_ERR
+					       "WARNING: bogus zero IO-APIC "
+					       "address found in MPTABLE, "
+					       "disabling IO/APIC support!\n");
+					smp_found_config = 0;
+					skip_ioapic_setup = 1;
+					goto fake_ioapic_page;
+				}
+			} else {
+fake_ioapic_page:
+				ioapic_phys = (unsigned long)
+					      alloc_bootmem_pages(PAGE_SIZE);
+				ioapic_phys = __pa(ioapic_phys);
+			}
+			set_fixmap_nocache(idx, ioapic_phys);
+			printk(KERN_DEBUG "mapped IOAPIC to %08lx (%08lx)\n",
+			       __fix_to_virt(idx), ioapic_phys);
+			idx++;
+		}
 	}
+#endif
 }
 
-void enable_APIC_timer(void)
+/*
+ * This initializes the IO-APIC and APIC hardware if this is
+ * a UP kernel.
+ */
+int __init APIC_init_uniprocessor (void)
 {
-	int cpu = smp_processor_id();
-
-	if (using_apic_timer &&
-	    !cpu_isset(cpu, timer_bcast_ipi)) {
-		unsigned long v;
-
-		v = apic_read(APIC_LVTT);
-		apic_write_around(APIC_LVTT, v & ~APIC_LVT_MASKED);
-	}
-}
+	if (enable_local_apic < 0)
+		clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
 
-void switch_APIC_timer_to_ipi(void *cpumask)
-{
-	cpumask_t mask = *(cpumask_t *)cpumask;
-	int cpu = smp_processor_id();
+	if (!smp_found_config && !cpu_has_apic)
+		return -1;
 
-	if (cpu_isset(cpu, mask) &&
-	    !cpu_isset(cpu, timer_bcast_ipi)) {
-		disable_APIC_timer();
-		cpu_set(cpu, timer_bcast_ipi);
+	/*
+	 * Complain if the BIOS pretends there is one.
+	 */
+	if (!cpu_has_apic &&
+	    APIC_INTEGRATED(apic_version[boot_cpu_physical_apicid])) {
+		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
+		       boot_cpu_physical_apicid);
+		clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
+		return -1;
 	}
-}
-EXPORT_SYMBOL(switch_APIC_timer_to_ipi);
 
-void switch_ipi_to_APIC_timer(void *cpumask)
-{
-	cpumask_t mask = *(cpumask_t *)cpumask;
-	int cpu = smp_processor_id();
+	verify_local_APIC();
 
-	if (cpu_isset(cpu, mask) &&
-	    cpu_isset(cpu, timer_bcast_ipi)) {
-		cpu_clear(cpu, timer_bcast_ipi);
-		enable_APIC_timer();
-	}
-}
-EXPORT_SYMBOL(switch_ipi_to_APIC_timer);
+	connect_bsp_APIC();
 
-#undef APIC_DIVISOR
+	/*
+	 * Hack: In case of kdump, after a crash, kernel might be booting
+	 * on a cpu with non-zero lapic id. But boot_cpu_physical_apicid
+	 * might be zero if read from MP tables. Get it from LAPIC.
+	 */
+#ifdef CONFIG_CRASH_DUMP
+	boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
+#endif
+	phys_cpu_present_map = physid_mask_of_physid(boot_cpu_physical_apicid);
 
-/*
- * Local timer interrupt handler. It does both profiling and
- * process statistics/rescheduling.
- *
- * We do profiling in every local tick, statistics/rescheduling
- * happen only every 'profiling multiplier' ticks. The default
- * multiplier is 1 and it can be changed by writing the new multiplier
- * value into /proc/profile.
- */
+	setup_local_APIC();
 
-inline void smp_local_timer_interrupt(void)
-{
-	profile_tick(CPU_PROFILING);
-#ifdef CONFIG_SMP
-	update_process_times(user_mode_vm(get_irq_regs()));
+#ifdef CONFIG_X86_IO_APIC
+	if (smp_found_config)
+		if (!skip_ioapic_setup && nr_ioapics)
+			setup_IO_APIC();
 #endif
+	setup_boot_APIC_clock();
 
-	/*
-	 * We take the 'long' return path, and there every subsystem
-	 * grabs the apropriate locks (kernel lock/ irq lock).
-	 *
-	 * we might want to decouple profiling from the 'long path',
-	 * and do the profiling totally in assembly.
-	 *
-	 * Currently this isn't too much of an issue (performance wise),
-	 * we can take more than 100K local irqs per second on a 100 MHz P5.
-	 */
+	return 0;
 }
 
 /*
- * Local APIC timer interrupt. This is the most natural way for doing
- * local interrupts, but local timer interrupts can be emulated by
- * broadcast interrupts too. [in case the hw doesn't support APIC timers]
- *
- * [ if a single-CPU system runs an SMP kernel then we call the local
- *   interrupt as well. Thus we cannot inline the local irq ... ]
+ * APIC command line parameters
  */
-
-fastcall void smp_apic_timer_interrupt(struct pt_regs *regs)
+static int __init parse_lapic(char *arg)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
-	int cpu = smp_processor_id();
-
-	/*
-	 * the NMI deadlock-detector uses this.
-	 */
-	per_cpu(irq_stat, cpu).apic_timer_irqs++;
-
-	/*
-	 * NOTE! We'd better ACK the irq immediately,
-	 * because timer handling can be slow.
-	 */
-	ack_APIC_irq();
-	/*
-	 * update_process_times() expects us to have done irq_enter().
-	 * Besides, if we don't timer interrupts ignore the global
-	 * interrupt lock, which is the WrongThing (tm) to do.
-	 */
-	irq_enter();
-	smp_local_timer_interrupt();
-	irq_exit();
-	set_irq_regs(old_regs);
+	enable_local_apic = 1;
+	return 0;
 }
+early_param("lapic", parse_lapic);
 
-#ifndef CONFIG_SMP
-static void up_apic_timer_interrupt_call(void)
+static int __init parse_nolapic(char *arg)
 {
-	int cpu = smp_processor_id();
-
-	/*
-	 * the NMI deadlock-detector uses this.
-	 */
-	per_cpu(irq_stat, cpu).apic_timer_irqs++;
-
-	smp_local_timer_interrupt();
+	enable_local_apic = -1;
+	clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
+	return 0;
 }
-#endif
+early_param("nolapic", parse_nolapic);
 
-void smp_send_timer_broadcast_ipi(void)
+static int __init apic_set_verbosity(char *str)
 {
-	cpumask_t mask;
-
-	cpus_and(mask, cpu_online_map, timer_bcast_ipi);
-	if (!cpus_empty(mask)) {
-#ifdef CONFIG_SMP
-		send_IPI_mask(mask, LOCAL_TIMER_VECTOR);
-#else
-		/*
-		 * We can directly call the apic timer interrupt handler
-		 * in UP case. Minus all irq related functions
-		 */
-		up_apic_timer_interrupt_call();
-#endif
-	}
+	if (strcmp("debug", str) == 0)
+		apic_verbosity = APIC_DEBUG;
+	else if (strcmp("verbose", str) == 0)
+		apic_verbosity = APIC_VERBOSE;
+	return 1;
 }
 
-int setup_profiling_timer(unsigned int multiplier)
-{
-	return -EINVAL;
-}
+__setup("apic=", apic_set_verbosity);
+
+
+/*
+ * Local APIC interrupts
+ */
 
 /*
  * This interrupt should _never_ happen with our APIC/SMP architecture
@@ -1316,15 +1160,14 @@ fastcall void smp_spurious_interrupt(str
 		ack_APIC_irq();
 
 	/* see sw-dev-man vol 3, chapter 7.4.13.5 */
-	printk(KERN_INFO "spurious APIC interrupt on CPU#%d, should never happen.\n",
-			smp_processor_id());
+	printk(KERN_INFO "spurious APIC interrupt on CPU#%d, "
+	       "should never happen.\n", smp_processor_id());
 	irq_exit();
 }
 
 /*
  * This interrupt should never happen with our APIC/SMP architecture
  */
-
 fastcall void smp_error_interrupt(struct pt_regs *regs)
 {
 	unsigned long v, v1;
@@ -1348,69 +1191,261 @@ fastcall void smp_error_interrupt(struct
 	   7: Illegal register address
 	*/
 	printk (KERN_DEBUG "APIC error on CPU%d: %02lx(%02lx)\n",
-	        smp_processor_id(), v , v1);
+		smp_processor_id(), v , v1);
 	irq_exit();
 }
 
 /*
- * This initializes the IO-APIC and APIC hardware if this is
- * a UP kernel.
+ * Initialize APIC interrupts
  */
-int __init APIC_init_uniprocessor (void)
+void __init apic_intr_init(void)
 {
-	if (enable_local_apic < 0)
-		clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
+#ifdef CONFIG_SMP
+	smp_intr_init();
+#endif
+	/* self generated IPI for local APIC timer */
+	set_intr_gate(LOCAL_TIMER_VECTOR, apic_timer_interrupt);
 
-	if (!smp_found_config && !cpu_has_apic)
-		return -1;
+	/* IPI vectors for APIC spurious and error interrupts */
+	set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
+	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
 
-	/*
-	 * Complain if the BIOS pretends there is one.
-	 */
-	if (!cpu_has_apic && APIC_INTEGRATED(apic_version[boot_cpu_physical_apicid])) {
-		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
-			boot_cpu_physical_apicid);
-		clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
-		return -1;
+	/* thermal monitor LVT interrupt */
+#ifdef CONFIG_X86_MCE_P4THERMAL
+	set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
+#endif
+}
+
+/**
+ * connect_bsp_APIC - attach the APIC to the interrupt system
+ */
+void __init connect_bsp_APIC(void)
+{
+	if (pic_mode) {
+		/*
+		 * Do not trust the local APIC being empty at bootup.
+		 */
+		clear_local_APIC();
+		/*
+		 * PIC mode, enable APIC mode in the IMCR, i.e.  connect BSP's
+		 * local APIC to INT and NMI lines.
+		 */
+		apic_printk(APIC_VERBOSE, "leaving PIC mode, "
+				"enabling APIC mode.\n");
+		outb(0x70, 0x22);
+		outb(0x01, 0x23);
 	}
+	enable_apic_mode();
+}
 
-	verify_local_APIC();
+/**
+ * disconnect_bsp_APIC - detach the APIC from the interrupt system
+ * @virt_wire_setup:	indicates, whether virtual wire mode is selected
+ *
+ * Virtual wire mode is necessary to deliver legacy interrupts even when the
+ * APIC is disabled.
+ */
+void disconnect_bsp_APIC(int virt_wire_setup)
+{
+	if (pic_mode) {
+		/*
+		 * Put the board back into PIC mode (has an effect only on
+		 * certain older boards).  Note that APIC interrupts, including
+		 * IPIs, won't work beyond this point!  The only exception are
+		 * INIT IPIs.
+		 */
+		apic_printk(APIC_VERBOSE, "disabling APIC mode, "
+				"entering PIC mode.\n");
+		outb(0x70, 0x22);
+		outb(0x00, 0x23);
+	} else {
+		/* Go back to Virtual Wire compatibility mode */
+		unsigned long value;
 
-	connect_bsp_APIC();
+		/* For the spurious interrupt use vector F, and enable it */
+		value = apic_read(APIC_SPIV);
+		value &= ~APIC_VECTOR_MASK;
+		value |= APIC_SPIV_APIC_ENABLED;
+		value |= 0xf;
+		apic_write_around(APIC_SPIV, value);
 
-	/*
-	 * Hack: In case of kdump, after a crash, kernel might be booting
-	 * on a cpu with non-zero lapic id. But boot_cpu_physical_apicid
-	 * might be zero if read from MP tables. Get it from LAPIC.
-	 */
-#ifdef CONFIG_CRASH_DUMP
-	boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
-#endif
-	phys_cpu_present_map = physid_mask_of_physid(boot_cpu_physical_apicid);
+		if (!virt_wire_setup) {
+			/*
+			 * For LVT0 make it edge triggered, active high,
+			 * external and enabled
+			 */
+			value = apic_read(APIC_LVT0);
+			value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING |
+				APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
+				APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED );
+			value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
+			value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_EXTINT);
+			apic_write_around(APIC_LVT0, value);
+		} else {
+			/* Disable LVT0 */
+			apic_write_around(APIC_LVT0, APIC_LVT_MASKED);
+		}
 
-	setup_local_APIC();
+		/*
+		 * For LVT1 make it edge triggered, active high, nmi and
+		 * enabled
+		 */
+		value = apic_read(APIC_LVT1);
+		value &= ~(
+			APIC_MODE_MASK | APIC_SEND_PENDING |
+			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
+			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED);
+		value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
+		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_NMI);
+		apic_write_around(APIC_LVT1, value);
+	}
+}
 
-#ifdef CONFIG_X86_IO_APIC
-	if (smp_found_config)
-		if (!skip_ioapic_setup && nr_ioapics)
-			setup_IO_APIC();
+/*
+ * Power management
+ */
+#ifdef CONFIG_PM
+
+static struct {
+	int active;
+	/* r/w apic fields */
+	unsigned int apic_id;
+	unsigned int apic_taskpri;
+	unsigned int apic_ldr;
+	unsigned int apic_dfr;
+	unsigned int apic_spiv;
+	unsigned int apic_lvtt;
+	unsigned int apic_lvtpc;
+	unsigned int apic_lvt0;
+	unsigned int apic_lvt1;
+	unsigned int apic_lvterr;
+	unsigned int apic_tmict;
+	unsigned int apic_tdcr;
+	unsigned int apic_thmr;
+} apic_pm_state;
+
+static int lapic_suspend(struct sys_device *dev, pm_message_t state)
+{
+	unsigned long flags;
+	int maxlvt;
+
+	if (!apic_pm_state.active)
+		return 0;
+
+	maxlvt = get_maxlvt();
+
+	apic_pm_state.apic_id = apic_read(APIC_ID);
+	apic_pm_state.apic_taskpri = apic_read(APIC_TASKPRI);
+	apic_pm_state.apic_ldr = apic_read(APIC_LDR);
+	apic_pm_state.apic_dfr = apic_read(APIC_DFR);
+	apic_pm_state.apic_spiv = apic_read(APIC_SPIV);
+	apic_pm_state.apic_lvtt = apic_read(APIC_LVTT);
+	if (maxlvt >= 4)
+		apic_pm_state.apic_lvtpc = apic_read(APIC_LVTPC);
+	apic_pm_state.apic_lvt0 = apic_read(APIC_LVT0);
+	apic_pm_state.apic_lvt1 = apic_read(APIC_LVT1);
+	apic_pm_state.apic_lvterr = apic_read(APIC_LVTERR);
+	apic_pm_state.apic_tmict = apic_read(APIC_TMICT);
+	apic_pm_state.apic_tdcr = apic_read(APIC_TDCR);
+#ifdef CONFIG_X86_MCE_P4THERMAL
+	if (maxlvt >= 5)
+		apic_pm_state.apic_thmr = apic_read(APIC_LVTTHMR);
 #endif
-	setup_boot_APIC_clock();
 
+	local_irq_save(flags);
+	disable_local_APIC();
+	local_irq_restore(flags);
 	return 0;
 }
 
-static int __init parse_lapic(char *arg)
+static int lapic_resume(struct sys_device *dev)
 {
-	lapic_enable();
+	unsigned int l, h;
+	unsigned long flags;
+	int maxlvt;
+
+	if (!apic_pm_state.active)
+		return 0;
+
+	maxlvt = get_maxlvt();
+
+	local_irq_save(flags);
+
+	/*
+	 * Make sure the APICBASE points to the right address
+	 *
+	 * FIXME! This will be wrong if we ever support suspend on
+	 * SMP! We'll need to do this as part of the CPU restore!
+	 */
+	rdmsr(MSR_IA32_APICBASE, l, h);
+	l &= ~MSR_IA32_APICBASE_BASE;
+	l |= MSR_IA32_APICBASE_ENABLE | mp_lapic_addr;
+	wrmsr(MSR_IA32_APICBASE, l, h);
+
+	apic_write(APIC_LVTERR, ERROR_APIC_VECTOR | APIC_LVT_MASKED);
+	apic_write(APIC_ID, apic_pm_state.apic_id);
+	apic_write(APIC_DFR, apic_pm_state.apic_dfr);
+	apic_write(APIC_LDR, apic_pm_state.apic_ldr);
+	apic_write(APIC_TASKPRI, apic_pm_state.apic_taskpri);
+	apic_write(APIC_SPIV, apic_pm_state.apic_spiv);
+	apic_write(APIC_LVT0, apic_pm_state.apic_lvt0);
+	apic_write(APIC_LVT1, apic_pm_state.apic_lvt1);
+#ifdef CONFIG_X86_MCE_P4THERMAL
+	if (maxlvt >= 5)
+		apic_write(APIC_LVTTHMR, apic_pm_state.apic_thmr);
+#endif
+	if (maxlvt >= 4)
+		apic_write(APIC_LVTPC, apic_pm_state.apic_lvtpc);
+	apic_write(APIC_LVTT, apic_pm_state.apic_lvtt);
+	apic_write(APIC_TDCR, apic_pm_state.apic_tdcr);
+	apic_write(APIC_TMICT, apic_pm_state.apic_tmict);
+	apic_write(APIC_ESR, 0);
+	apic_read(APIC_ESR);
+	apic_write(APIC_LVTERR, apic_pm_state.apic_lvterr);
+	apic_write(APIC_ESR, 0);
+	apic_read(APIC_ESR);
+	local_irq_restore(flags);
 	return 0;
 }
-early_param("lapic", parse_lapic);
 
-static int __init parse_nolapic(char *arg)
+/*
+ * This device has no shutdown method - fully functioning local APICs
+ * are needed on every CPU up until machine_halt/restart/poweroff.
+ */
+
+static struct sysdev_class lapic_sysclass = {
+	set_kset_name("lapic"),
+	.resume		= lapic_resume,
+	.suspend	= lapic_suspend,
+};
+
+static struct sys_device device_lapic = {
+	.id	= 0,
+	.cls	= &lapic_sysclass,
+};
+
+static void __devinit apic_pm_activate(void)
 {
-	lapic_disable();
-	return 0;
+	apic_pm_state.active = 1;
 }
-early_param("nolapic", parse_nolapic);
 
+static int __init init_lapic_sysfs(void)
+{
+	int error;
+
+	if (!cpu_has_apic)
+		return 0;
+	/* XXX: remove suspend/resume procs if !apic_pm_state.active? */
+
+	error = sysdev_class_register(&lapic_sysclass);
+	if (!error)
+		error = sysdev_register(&device_lapic);
+	return error;
+}
+device_initcall(init_lapic_sysfs);
+
+#else	/* CONFIG_PM */
+
+static void apic_pm_activate(void) { }
+
+#endif	/* CONFIG_PM */
Index: linux/arch/i386/kernel/io_apic.c
===================================================================
--- linux.orig/arch/i386/kernel/io_apic.c
+++ linux/arch/i386/kernel/io_apic.c
@@ -1592,7 +1592,7 @@ void /*__init*/ print_local_APIC(void * 
 	v = apic_read(APIC_LVR);
 	printk(KERN_INFO "... APIC VERSION: %08x\n", v);
 	ver = GET_APIC_VERSION(v);
-	maxlvt = get_maxlvt();
+	maxlvt = lapic_get_maxlvt();
 
 	v = apic_read(APIC_TASKPRI);
 	printk(KERN_DEBUG "... APIC TASKPRI: %08x (%02x)\n", v, v & APIC_TPRI_MASK);
Index: linux/arch/i386/kernel/irq.c
===================================================================
--- linux.orig/arch/i386/kernel/irq.c
+++ linux/arch/i386/kernel/irq.c
@@ -10,7 +10,6 @@
  * io_apic.c.)
  */
 
-#include <asm/uaccess.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
@@ -19,19 +18,34 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 
+#include <asm/apic.h>
+#include <asm/uaccess.h>
+
 DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_internodealigned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
-#ifndef CONFIG_X86_LOCAL_APIC
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
  * each architecture has to answer this themselves.
  */
 void ack_bad_irq(unsigned int irq)
 {
-	printk("unexpected IRQ trap at vector %02x\n", irq);
-}
+	printk(KERN_ERR "unexpected IRQ trap at vector %02x\n", irq);
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	/*
+	 * Currently unexpected vectors happen only on SMP and APIC.
+	 * We _must_ ack these because every local APIC has only N
+	 * irq slots per priority level, and a 'hanging, unacked' IRQ
+	 * holds up an irq slot - in excessive cases (when multiple
+	 * unexpected vectors occur) that might lock up the APIC
+	 * completely.
+	 * But only ack when the APIC is enabled -AK
+	 */
+	if (cpu_has_apic)
+		ack_APIC_irq();
 #endif
+}
 
 #ifdef CONFIG_4KSTACKS
 /*
Index: linux/arch/i386/kernel/smpboot.c
===================================================================
--- linux.orig/arch/i386/kernel/smpboot.c
+++ linux/arch/i386/kernel/smpboot.c
@@ -735,7 +735,7 @@ wakeup_secondary_cpu(int logical_apicid,
 	/*
 	 * Due to the Pentium erratum 3AP.
 	 */
-	maxlvt = get_maxlvt();
+	maxlvt = lapic_get_maxlvt();
 	if (maxlvt > 3) {
 		apic_read_around(APIC_SPIV);
 		apic_write(APIC_ESR, 0);
@@ -825,7 +825,7 @@ wakeup_secondary_cpu(int phys_apicid, un
 	 */
 	Dprintk("#startup loops: %d.\n", num_starts);
 
-	maxlvt = get_maxlvt();
+	maxlvt = lapic_get_maxlvt();
 
 	for (j = 1; j <= num_starts; j++) {
 		Dprintk("Sending STARTUP #%d.\n",j);
Index: linux/include/asm-i386/apic.h
===================================================================
--- linux.orig/include/asm-i386/apic.h
+++ linux/include/asm-i386/apic.h
@@ -86,7 +86,7 @@ static inline void ack_APIC_irq(void)
 
 extern void (*wait_timer_tick)(void);
 
-extern int get_maxlvt(void);
+extern int lapic_get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void connect_bsp_APIC (void);
 extern void disconnect_bsp_APIC (int virt_wire_setup);

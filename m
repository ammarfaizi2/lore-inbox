Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311839AbSEDKHb>; Sat, 4 May 2002 06:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311856AbSEDKHb>; Sat, 4 May 2002 06:07:31 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:19153 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311839AbSEDKH1>; Sat, 4 May 2002 06:07:27 -0400
Date: Sat, 4 May 2002 11:46:42 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] APIC meta LVT API
Message-ID: <Pine.LNX.4.44.0205041142160.12156-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is an attempt at providing an interface to use when setting up 
a local APIC LVT.

Although this is really 2.5 stuff i tested and developed on:
2.4.19-pre2-ac3-SMP 4-way i686
2.4.19-pre2-ac3-SMP 4-way w/ noapic i686
2.4.19-pre5-ac3-UP w/ Local-APIC/IO-APIC i686
2.4.19-pre2-ac3-UP w/ Local-APIC i686

The API provides the following interfaces:
void enable_apic_lvt(unsigned int lvt, unsigned int value);
void disable_apic_lvt(unsigned int lvt);
which also manipulate the vector:lvt mappings

void apic_mask_lvt(unsigned int lvt);
void apic_unmask_lvt(unsigned int lvt);

all comments (constructive, flames) welcome

Thanks,
	Zwane Mwaikambo

arch/i386/kernel/apic.c    |  194 ++++++++++++++++++++++++++++++++++++++-------
arch/i386/kernel/io_apic.c |   70 +---------------
include/asm-i386/apic.h    |   11 ++
include/asm-i386/hw_irq.h  |    3
4 files changed, 186 insertions(+), 92 deletions(-)

diff -ur linux-bochs-2.4-ac/arch/i386/kernel/apic.c linux-2.4-apic/arch/i386/kernel/apic.c
--- linux-bochs-2.4-ac/arch/i386/kernel/apic.c	Thu Mar 28 05:56:03 2002
+++ linux-2.4-apic/arch/i386/kernel/apic.c	Sat May  4 10:09:22 2002
@@ -10,6 +10,7 @@
  *					for testing these extensively.
  *	Maciej W. Rozycki	:	Various updates and fixes.
  *	Mikael Pettersson	:	Power Management for UP-APIC.
+ *	Zwane Mwaikambo		:	APIC LVT/vector meta-API.
  */
 
 #include <linux/config.h>
@@ -37,6 +38,33 @@
 int prof_old_multiplier[NR_CPUS] = { 1, };
 int prof_counter[NR_CPUS] = { 1, };
 
+spinlock_t lapic_lock = SPIN_LOCK_UNLOCKED;
+int vector_lvt[LAST_APIC_VECTOR];
+int irq_vector[NR_IRQS] = { FIRST_DEVICE_VECTOR , 0 };
+
+/* used by IO-APIC too */
+int assign_irq_vector(int irq)
+{
+	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
+	if (APIC_VECTOR(irq) > 0)
+		return APIC_VECTOR(irq);
+next:
+	current_vector += 8;
+	if (current_vector == SYSCALL_VECTOR)
+		goto next;
+
+	if (current_vector > FIRST_SYSTEM_VECTOR) {
+		offset++;
+		current_vector = FIRST_DEVICE_VECTOR + offset;
+	}
+
+	if (current_vector == FIRST_SYSTEM_VECTOR)
+		panic("ran out of interrupt sources!");
+
+	APIC_VECTOR(irq) = current_vector;
+	return current_vector;
+}
+
 int get_maxlvt(void)
 {
 	unsigned int v, ver, maxlvt;
@@ -48,6 +76,123 @@
 	return maxlvt;
 }
 
+void inline unmask_apic_lvt(unsigned int lvt)
+{
+	unsigned long reg;
+	reg = apic_read(lvt);
+	apic_write_around(lvt, reg & ~APIC_LVT_MASKED);
+}
+
+void inline mask_apic_lvt(unsigned int lvt)
+{
+	unsigned long reg;
+	reg = apic_read(lvt);
+	apic_write_around(lvt, reg | APIC_LVT_MASKED);
+}
+
+/* you can enable, but we don't enforce unmasking */
+void enable_apic_lvt(unsigned int lvt, unsigned int val)
+{
+	unsigned int vector;
+	unsigned long reg, flags;
+
+	spin_lock_irqsave(&lapic_lock, flags);
+	reg = apic_read(lvt);
+	vector = val & APIC_VECTOR_MASK;
+	if (vector)
+		Dprintk("...vector:%x -> LVT:%#x\n", vector, lvt);
+	Dprintk("LVT %#x before enable:%#x after:%#x\n", lvt, reg, val);
+
+	if (vector) {
+		if (vector < FIRST_DEVICE_VECTOR)
+			BUG();
+
+		vector_lvt[vector] = lvt;
+	}
+
+	apic_write_around(lvt, val);
+	spin_unlock_irqrestore(&lapic_lock, flags);
+}
+
+/* forces masking, and zeroes vector */
+void disable_apic_lvt(unsigned int lvt)
+{
+	unsigned long reg, flags;
+	unsigned int vector;
+
+	spin_lock_irqsave(&lapic_lock, flags);
+	mask_apic_lvt(lvt);
+	reg = apic_read(lvt);
+	vector = reg & APIC_VECTOR_MASK;
+	if (lvt != vector_lvt[vector])
+		Dprintk(KERN_ERR "APIC: Unmatched LVT:%#x vector:%#x", lvt, vector);
+
+	apic_write_around(lvt, reg & ~APIC_VECTOR_MASK);
+	vector_lvt[vector] = 0;
+	spin_unlock_irqrestore(&lapic_lock, flags);
+}
+
+void enable_lapic_irq(unsigned int irq)
+{
+	int vector;
+
+	vector = irq_vector[irq];
+	if (vector < FIRST_DEVICE_VECTOR)
+		BUG();
+
+	unmask_apic_lvt(vector_lvt[vector]);
+}
+
+void disable_lapic_irq(unsigned int irq)
+{
+	int vector;
+
+	vector = irq_vector[irq];
+	if (vector < FIRST_DEVICE_VECTOR)
+		BUG();
+
+	mask_apic_lvt(vector_lvt[vector]);
+}
+
+unsigned int startup_apic_irq(unsigned int irq)
+{
+	enable_lapic_irq(irq);
+	return 0;
+}
+
+void shutdown_apic_irq(unsigned int irq)
+{
+	disable_lapic_irq(irq);
+}
+
+
+void ack_lapic_irq(unsigned int irq)
+{
+	ack_APIC_irq();
+}
+
+void end_lapic_irq(unsigned int i) { /* nothing */ }
+
+struct hw_interrupt_type edge_lapic_irq_type = {
+	typename:	"local-APIC-edge",
+	/*startup:	startup_apic_irq,
+	shutdown:	shutdown_apic_irq,*/
+	enable:		enable_lapic_irq,
+	disable:	disable_lapic_irq,
+	ack:		ack_lapic_irq,
+	end:		end_lapic_irq
+};
+
+struct hw_interrupt_type level_lapic_irq_type = {
+	typename:	"local-APIC-level",
+	/* startup:	startup_apic_irq,
+	shutdown:	shutdown_apic_irq,*/
+	enable:		enable_lapic_irq,
+	disable:	disable_lapic_irq,
+	ack:		ack_lapic_irq,
+	end:		end_lapic_irq
+};
+
 void clear_local_APIC(void)
 {
 	int maxlvt;
@@ -67,16 +212,11 @@
 	 * Careful: we have to set masks only first to deassert
 	 * any level-triggered sources.
 	 */
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
+	mask_apic_lvt(APIC_LVTT);
+	mask_apic_lvt(APIC_LVT0);
+	mask_apic_lvt(APIC_LVT1);
+	if (maxlvt >= 4)
+		mask_apic_lvt(APIC_LVTPC);
 
 	/*
 	 * Clean APIC state for other OSs:
@@ -85,9 +225,9 @@
 	apic_write_around(APIC_LVT0, APIC_LVT_MASKED);
 	apic_write_around(APIC_LVT1, APIC_LVT_MASKED);
 	if (maxlvt >= 3)
-		apic_write_around(APIC_LVTERR, APIC_LVT_MASKED);
+		mask_apic_lvt(APIC_LVTERR);
 	if (maxlvt >= 4)
-		apic_write_around(APIC_LVTPC, APIC_LVT_MASKED);
+		mask_apic_lvt(APIC_LVTPC);
 	v = GET_APIC_VERSION(apic_read(APIC_LVR));
 	if (APIC_INTEGRATED(v)) {	/* !82489DX */
 		if (maxlvt > 3)
@@ -253,11 +393,11 @@
 	/*
 	 * Set up the virtual wire mode.
 	 */
-	apic_write_around(APIC_LVT0, APIC_DM_EXTINT);
+	enable_apic_lvt(APIC_LVT0, APIC_DM_EXTINT);
 	value = APIC_DM_NMI;
 	if (!APIC_INTEGRATED(ver))		/* 82489DX */
 		value |= APIC_LVT_LEVEL_TRIGGER;
-	apic_write_around(APIC_LVT1, value);
+	enable_apic_lvt(APIC_LVT1, value);
 }
 
 void __init setup_local_APIC (void)
@@ -377,7 +517,7 @@
 		value = APIC_DM_EXTINT | APIC_LVT_MASKED;
 		printk("masked ExtINT on CPU#%d\n", smp_processor_id());
 	}
-	apic_write_around(APIC_LVT0, value);
+	enable_apic_lvt(APIC_LVT0, value);
 
 	/*
 	 * only the BP should see the LINT1 NMI signal, obviously.
@@ -388,7 +528,7 @@
 		value = APIC_DM_NMI | APIC_LVT_MASKED;
 	if (!APIC_INTEGRATED(ver))		/* 82489DX */
 		value |= APIC_LVT_LEVEL_TRIGGER;
-	apic_write_around(APIC_LVT1, value);
+	enable_apic_lvt(APIC_LVT1, value);
 
 	if (APIC_INTEGRATED(ver) && !esr_disable) {		/* !82489DX */
 		maxlvt = get_maxlvt();
@@ -398,7 +538,7 @@
 		printk("ESR value before enabling vector: %08lx\n", value);
 
 		value = ERROR_APIC_VECTOR;      // enables sending errors
-		apic_write_around(APIC_LVTERR, value);
+		enable_apic_lvt(APIC_LVTERR, value);
 		/*
 		 * spec says clear errors after enabling vector.
 		 */
@@ -764,7 +904,9 @@
 
 	lvtt1_value = SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV) |
 			APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
-	apic_write_around(APIC_LVTT, lvtt1_value);
+	
+	irq_vector[0] = LOCAL_TIMER_VECTOR;
+	enable_apic_lvt(APIC_LVTT, lvtt1_value);
 
 	/*
 	 * Divide PICLK by 16
@@ -924,22 +1066,14 @@
 
 void __init disable_APIC_timer(void)
 {
-	if (using_apic_timer) {
-		unsigned long v;
-
-		v = apic_read(APIC_LVTT);
-		apic_write_around(APIC_LVTT, v | APIC_LVT_MASKED);
-	}
+	if (using_apic_timer)
+		mask_apic_lvt(APIC_LVTT);
 }
 
 void enable_APIC_timer(void)
 {
-	if (using_apic_timer) {
-		unsigned long v;
-
-		v = apic_read(APIC_LVTT);
-		apic_write_around(APIC_LVTT, v & ~APIC_LVT_MASKED);
-	}
+	if (using_apic_timer)
+		unmask_apic_lvt(APIC_LVTT);
 }
 
 /*
diff -ur linux-bochs-2.4-ac/arch/i386/kernel/io_apic.c linux-2.4-apic/arch/i386/kernel/io_apic.c
--- linux-bochs-2.4-ac/arch/i386/kernel/io_apic.c	Wed Nov 14 03:28:41 2001
+++ linux-2.4-apic/arch/i386/kernel/io_apic.c	Sat May  4 09:58:45 2002
@@ -17,6 +17,7 @@
  *					thanks to Eric Gilmore
  *					and Rolf G. Tews
  *					for testing these extensively
+ *	Zwane Mwaikambo		:	Updated to use APIC API
  */
 
 #include <linux/mm.h>
@@ -553,30 +554,6 @@
 	return 0;
 }
 
-int irq_vector[NR_IRQS] = { FIRST_DEVICE_VECTOR , 0 };
-
-static int __init assign_irq_vector(int irq)
-{
-	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
-	if (IO_APIC_VECTOR(irq) > 0)
-		return IO_APIC_VECTOR(irq);
-next:
-	current_vector += 8;
-	if (current_vector == SYSCALL_VECTOR)
-		goto next;
-
-	if (current_vector > FIRST_SYSTEM_VECTOR) {
-		offset++;
-		current_vector = FIRST_DEVICE_VECTOR + offset;
-	}
-
-	if (current_vector == FIRST_SYSTEM_VECTOR)
-		panic("ran out of interrupt sources!");
-
-	IO_APIC_VECTOR(irq) = current_vector;
-	return current_vector;
-}
-
 extern void (*interrupt[NR_IRQS])(void);
 static struct hw_interrupt_type ioapic_level_irq_type;
 static struct hw_interrupt_type ioapic_edge_irq_type;
@@ -1344,39 +1321,6 @@
 	}
 }
 
-static void enable_lapic_irq (unsigned int irq)
-{
-	unsigned long v;
-
-	v = apic_read(APIC_LVT0);
-	apic_write_around(APIC_LVT0, v & ~APIC_LVT_MASKED);
-}
-
-static void disable_lapic_irq (unsigned int irq)
-{
-	unsigned long v;
-
-	v = apic_read(APIC_LVT0);
-	apic_write_around(APIC_LVT0, v | APIC_LVT_MASKED);
-}
-
-static void ack_lapic_irq (unsigned int irq)
-{
-	ack_APIC_irq();
-}
-
-static void end_lapic_irq (unsigned int i) { /* nothing */ }
-
-static struct hw_interrupt_type lapic_irq_type = {
-	"local-APIC-edge",
-	NULL, /* startup_irq() not used for IRQ0 */
-	NULL, /* shutdown_irq() not used for IRQ0 */
-	enable_lapic_irq,
-	disable_lapic_irq,
-	ack_lapic_irq,
-	end_lapic_irq
-};
-
 static void enable_NMI_through_LVT0 (void * dummy)
 {
 	unsigned int v, ver;
@@ -1386,7 +1330,8 @@
 	v = APIC_DM_NMI;			/* unmask and set to NMI */
 	if (!APIC_INTEGRATED(ver))		/* 82489DX */
 		v |= APIC_LVT_LEVEL_TRIGGER;
-	apic_write_around(APIC_LVT0, v);
+
+	enable_apic_lvt(APIC_LVT0, v);
 }
 
 static void setup_nmi (void)
@@ -1554,22 +1499,23 @@
 	printk(KERN_INFO "...trying to set up timer as Virtual Wire IRQ...");
 
 	disable_8259A_irq(0);
-	irq_desc[0].handler = &lapic_irq_type;
-	apic_write_around(APIC_LVT0, APIC_DM_FIXED | vector);	/* Fixed mode */
+	irq_desc[0].handler = &edge_lapic_irq_type;
+	enable_apic_lvt(APIC_LVT0, APIC_DM_FIXED | vector);	/* Fixed mode */
 	enable_8259A_irq(0);
 
 	if (timer_irq_works()) {
 		printk(" works.\n");
 		return;
 	}
-	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_FIXED | vector);
+
+	disable_apic_lvt(APIC_LVT0);
 	printk(" failed.\n");
 
 	printk(KERN_INFO "...trying to set up timer as ExtINT IRQ...");
 
 	init_8259A(0);
 	make_8259A_irq(0);
-	apic_write_around(APIC_LVT0, APIC_DM_EXTINT);
+	enable_apic_lvt(APIC_LVT0, APIC_DM_EXTINT);
 
 	unlock_ExtINT_logic();
 
diff -ur linux-bochs-2.4-ac/include/asm-i386/apic.h linux-2.4-apic/include/asm-i386/apic.h
--- linux-bochs-2.4-ac/include/asm-i386/apic.h	Mon Apr 29 13:48:01 2002
+++ linux-2.4-apic/include/asm-i386/apic.h	Sat May  4 09:48:47 2002
@@ -81,10 +81,21 @@
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
+extern void enable_apic_lvt(unsigned int lvt, unsigned int value);
+extern void disable_apic_lvt(unsigned int lvt);
+extern void apic_mask_lvt(unsigned int lvt);
+extern void apic_unmask_lvt(unsigned int lvt);
+extern void disable_lapic_irq(unsigned int irq);
+extern void enable_lapic_irq(unsigned int irq);
+extern unsigned int startup_apic_irq(unsigned int irq);
+extern void shutdown_apic_irq(unsigned int irq);
 
+extern int assign_irq_vector(int irq);
 extern struct pm_dev *apic_pm_register(pm_dev_t, unsigned long, pm_callback);
 extern void apic_pm_unregister(struct pm_dev*);
 
+extern struct hw_interrupt_type edge_lapic_irq_type, level_lapic_irq_type;
+
 extern unsigned int apic_timer_irqs [NR_CPUS];
 extern int check_nmi_watchdog (void);
 
diff -ur linux-bochs-2.4-ac/include/asm-i386/hw_irq.h linux-2.4-apic/include/asm-i386/hw_irq.h
--- linux-bochs-2.4-ac/include/asm-i386/hw_irq.h	Sun Apr 28 10:01:23 2002
+++ linux-2.4-apic/include/asm-i386/hw_irq.h	Sat May  4 10:14:02 2002
@@ -58,9 +58,12 @@
  */
 #define FIRST_DEVICE_VECTOR	0x31
 #define FIRST_SYSTEM_VECTOR	0xef
+#define LAST_APIC_VECTOR	0xff
 
 extern int irq_vector[NR_IRQS];
+extern int vector_lvt[LAST_APIC_VECTOR];
 #define IO_APIC_VECTOR(irq)	irq_vector[irq]
+#define APIC_VECTOR(irq)	irq_vector[irq]
 
 /*
  * Various low-level irq details needed by irq.c, process.c,
		


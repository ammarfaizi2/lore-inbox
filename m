Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbTHTAjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 20:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTHTAjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 20:39:39 -0400
Received: from colin2.muc.de ([193.149.48.15]:9486 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261643AbTHTAjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 20:39:31 -0400
Date: 20 Aug 2003 02:39:29 +0200
Date: Wed, 20 Aug 2003 02:39:29 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@muc.de>,
       Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: [PATCH] physid_maskt for x86-64 was R[BUG][2.6.0-test3-bk7] x86-64 UP_IOAPIC panic caused by cpumask_t conversion
Message-ID: <20030820003929.GA75268@colin2.muc.de>
References: <mnCB.1md.29@gated-at.bofh.it> <m3y8xpqktd.fsf@averell.firstfloor.org> <20030819235126.GC4306@holomorphy.com> <20030819235759.GB65297@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819235759.GB65297@colin2.muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the UP boot problem in 2.6.0test3-bk7 for me. I just ported over
the physid_mask_t code from i386 for the IO-APIC ids. This avoids the problems
with the boolean cpumask on UP kernels.

Caveat: I only tested it with a UP kernel on a UP machine. SMP is untested.

-Andi


diff -u linux-2.5-amd64/arch/x86_64/kernel/apic.c-o linux-2.5-amd64/arch/x86_64/kernel/apic.c
--- linux-2.5-amd64/arch/x86_64/kernel/apic.c-o	2003-08-19 13:12:25.000000000 +0200
+++ linux-2.5-amd64/arch/x86_64/kernel/apic.c	2003-08-20 02:09:40.000000000 +0200
@@ -299,7 +299,7 @@
 	 * This is meaningless in clustered apic mode, so we skip it.
 	 */
 	if (!clustered_apic_mode &&
-		!cpu_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map))
+		!physid_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map))
 		BUG();
 
 	/*
@@ -993,7 +993,7 @@
 
 	connect_bsp_APIC();
 
-	phys_cpu_present_map = cpumask_of_cpu(0);
+	phys_cpu_present_map = physid_mask_of_physid(0);
 	apic_write_around(APIC_ID, boot_cpu_id);
 
 	setup_local_APIC();
diff -u linux-2.5-amd64/arch/x86_64/kernel/smpboot.c-o linux-2.5-amd64/arch/x86_64/kernel/smpboot.c
--- linux-2.5-amd64/arch/x86_64/kernel/smpboot.c-o	2003-08-19 13:12:26.000000000 +0200
+++ linux-2.5-amd64/arch/x86_64/kernel/smpboot.c	2003-08-20 02:06:23.000000000 +0200
@@ -734,10 +734,10 @@
 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
 
-	if (!cpu_isset(hard_smp_processor_id(), phys_cpu_present_map)) {
+	if (!physid_isset(hard_smp_processor_id(), phys_cpu_present_map)) {
 		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
 		       hard_smp_processor_id());
-		cpu_set(hard_smp_processor_id(), phys_cpu_present_map);
+		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
 	}
 
 	/*
@@ -748,7 +748,7 @@
 		printk(KERN_NOTICE "SMP motherboard not detected.\n");
 		io_apic_irqs = 0;
 		cpu_online_map = cpumask_of_cpu(0);
-		phys_cpu_present_map = cpumask_of_cpu(0);
+		phys_cpu_present_map = physid_mask_of_physid(0);
 		if (APIC_init_uniprocessor())
 			printk(KERN_NOTICE "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
@@ -759,10 +759,10 @@
 	 * Should not be necessary because the MP table should list the boot
 	 * CPU too, but we do it for the sake of robustness anyway.
 	 */
-	if (!cpu_isset(boot_cpu_id, phys_cpu_present_map)) {
+	if (!physid_isset(boot_cpu_id, phys_cpu_present_map)) {
 		printk(KERN_NOTICE "weird, boot CPU (#%d) not listed by the BIOS.\n",
 								 boot_cpu_id);
-		cpu_set(hard_smp_processor_id(), phys_cpu_present_map);
+		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
 	}
 
 	/*
@@ -774,7 +774,7 @@
 		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
 		io_apic_irqs = 0;
 		cpu_online_map = cpumask_of_cpu(0);
-		phys_cpu_present_map = cpumask_of_cpu(0);
+		phys_cpu_present_map = physid_mask_of_physid(0);
 		disable_apic = 1;
 		goto smp_done;
 	}
@@ -789,7 +789,7 @@
 		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
 		io_apic_irqs = 0;
 		cpu_online_map = cpumask_of_cpu(0);
-		phys_cpu_present_map = cpumask_of_cpu(0);
+		phys_cpu_present_map = physid_mask_of_physid(0);
 		disable_apic = 1;
 		goto smp_done;
 	}
@@ -803,7 +803,7 @@
 	/*
 	 * Now scan the CPU present map and fire up the other CPUs.
 	 */
-	Dprintk("CPU present map: %lx\n", phys_cpu_present_map);
+	Dprintk("CPU present map: %lx\n", physids_coerce(phys_cpu_present_map));
 
 	for (apicid = 0; apicid < NR_CPUS; apicid++) {
 		/*
diff -u linux-2.5-amd64/arch/x86_64/kernel/mpparse.c-o linux-2.5-amd64/arch/x86_64/kernel/mpparse.c
--- linux-2.5-amd64/arch/x86_64/kernel/mpparse.c-o	2003-08-20 00:20:35.000000000 +0200
+++ linux-2.5-amd64/arch/x86_64/kernel/mpparse.c	2003-08-20 02:06:24.000000000 +0200
@@ -67,7 +67,7 @@
 static unsigned int num_processors = 0;
 
 /* Bitmask of physically existing CPUs */
-cpumask_t phys_cpu_present_map = CPU_MASK_NONE;
+physid_mask_t phys_cpu_present_map = PHYSID_MASK_NONE;
 
 /* ACPI MADT entry parsing functions */
 #ifdef CONFIG_ACPI_BOOT
@@ -126,7 +126,7 @@
 	}
 	ver = m->mpc_apicver;
 
-	cpu_set(m->mpc_apicid, phys_cpu_present_map);
+	physid_set(m->mpc_apicid, phys_cpu_present_map);
 	/*
 	 * Validate version
 	 */
diff -u linux-2.5-amd64/arch/x86_64/kernel/io_apic.c-o linux-2.5-amd64/arch/x86_64/kernel/io_apic.c
--- linux-2.5-amd64/arch/x86_64/kernel/io_apic.c-o	2003-08-20 00:20:35.000000000 +0200
+++ linux-2.5-amd64/arch/x86_64/kernel/io_apic.c	2003-08-20 02:10:08.000000000 +0200
@@ -1014,7 +1014,7 @@
 static void __init setup_ioapic_ids_from_mpc (void)
 {
 	union IO_APIC_reg_00 reg_00;
-	cpumask_t phys_id_present_map = phys_cpu_present_map;
+	physid_mask_t phys_id_present_map = phys_cpu_present_map;
 	int apic;
 	int i;
 	unsigned char old_id;
@@ -1047,22 +1047,22 @@
 		 * system must have a unique ID or we get lots of nice
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
 	 	 */
-		if (cpu_isset(mp_ioapics[apic].mpc_apicid, phys_id_present_map)) {
+		if (physid_isset(mp_ioapics[apic].mpc_apicid, phys_id_present_map)) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			for (i = 0; i < 0xf; i++)
-				if (!cpu_isset(i, phys_id_present_map))
+				if (!physid_isset(i, phys_id_present_map))
 					break;
 			if (i >= 0xf)
 				panic("Max APIC ID exceeded!\n");
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
 				i);
-			cpu_set(i, phys_id_present_map);
+			physid_set(i, phys_id_present_map);
 			mp_ioapics[apic].mpc_apicid = i;
 		} else {
 			printk(KERN_INFO 
 			       "Using IO-APIC %d\n", mp_ioapics[apic].mpc_apicid);
-			cpu_set(mp_ioapics[apic].mpc_apicid, phys_id_present_map);
+			physid_set(mp_ioapics[apic].mpc_apicid, phys_id_present_map);
 		}
 
 
@@ -1642,7 +1642,7 @@
 int __init io_apic_get_unique_id (int ioapic, int apic_id)
 {
 	union IO_APIC_reg_00 reg_00;
-	static cpumask_t apic_id_map;
+	static physid_mask_t apic_id_map;
 	unsigned long flags;
 	int i = 0;
 
@@ -1655,7 +1655,7 @@
 	 *      advantage of new APIC bus architecture.
 	 */
 
-	if (!cpus_empty(apic_id_map))
+	if (!physids_empty(apic_id_map))
 		apic_id_map = phys_cpu_present_map;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
@@ -1672,10 +1672,10 @@
 	 * Every APIC in a system must have a unique ID or we get lots of nice 
 	 * 'stuck on smp_invalidate_needed IPI wait' messages.
 	 */
-	if (cpu_isset(apic_id, apic_id_map)) {
+	if (physid_isset(apic_id, apic_id_map)) {
 
 		for (i = 0; i < IO_APIC_MAX_ID; i++) {
-			if (!cpu_isset(i, apic_id_map))
+			if (!physid_isset(i, apic_id_map))
 				break;
 		}
 
@@ -1688,7 +1688,7 @@
 		apic_id = i;
 	} 
 
-	cpu_set(apic_id, apic_id_map);
+	physid_set(apic_id, apic_id_map);
 
 	if (reg_00.bits.ID != apic_id) {
 		reg_00.bits.ID = apic_id;
diff -u linux-2.5-amd64/include/asm-x86_64/mpspec.h-o linux-2.5-amd64/include/asm-x86_64/mpspec.h
--- linux-2.5-amd64/include/asm-x86_64/mpspec.h-o	2003-08-19 13:19:52.000000000 +0200
+++ linux-2.5-amd64/include/asm-x86_64/mpspec.h	2003-08-20 01:59:16.000000000 +0200
@@ -169,7 +169,6 @@
 extern cpumask_t mp_bus_to_cpumask [MAX_MP_BUSSES];
 
 extern unsigned int boot_cpu_physical_apicid;
-extern cpumask_t phys_cpu_present_map;
 extern int smp_found_config;
 extern void find_smp_config (void);
 extern void get_smp_config (void);
@@ -198,5 +197,49 @@
 
 extern int using_apic_timer;
 
+#define PHYSID_ARRAY_SIZE	BITS_TO_LONGS(MAX_APICS)
+
+struct physid_mask
+{
+	unsigned long mask[PHYSID_ARRAY_SIZE];
+};
+
+typedef struct physid_mask physid_mask_t;
+
+#define physid_set(physid, map)			set_bit(physid, (map).mask)
+#define physid_clear(physid, map)		clear_bit(physid, (map).mask)
+#define physid_isset(physid, map)		test_bit(physid, (map).mask)
+#define physid_test_and_set(physid, map)	test_and_set_bit(physid, (map).mask)
+
+#define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
+#define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
+#define physids_clear(map)			bitmap_clear((map).mask, MAX_APICS)
+#define physids_complement(map)			bitmap_complement((map).mask, MAX_APICS)
+#define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
+#define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
+#define physids_weight(map)			bitmap_weight((map).mask, MAX_APICS)
+#define physids_shift_right(d, s, n)		bitmap_shift_right((d).mask, (s).mask, n, MAX_APICS)
+#define physids_shift_left(d, s, n)		bitmap_shift_left((d).mask, (s).mask, n, MAX_APICS)
+#define physids_coerce(map)			((map).mask[0])
+
+#define physids_promote(physids)						\
+	({									\
+		physid_mask_t __physid_mask = PHYSID_MASK_NONE;			\
+		__physid_mask.mask[0] = physids;				\
+		__physid_mask;							\
+	})
+
+#define physid_mask_of_physid(physid)						\
+	({									\
+		physid_mask_t __physid_mask = PHYSID_MASK_NONE;			\
+		physid_set(physid, __physid_mask);				\
+		__physid_mask;							\
+	})
+
+#define PHYSID_MASK_ALL		{ {[0 ... PHYSID_ARRAY_SIZE-1] = ~0UL} }
+#define PHYSID_MASK_NONE	{ {[0 ... PHYSID_ARRAY_SIZE-1] = 0UL} }
+
+extern physid_mask_t phys_cpu_present_map;
+
 #endif
 

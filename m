Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265912AbTGDJiO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 05:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265967AbTGDJiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 05:38:14 -0400
Received: from holomorphy.com ([66.224.33.161]:52942 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265912AbTGDJfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 05:35:48 -0400
Date: Fri, 4 Jul 2003 02:50:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
Message-ID: <20030704095004.GB26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <3F054109.2050100@aitel.hist.no> <20030704093531.GA26348@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704093531.GA26348@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 02:35:31AM -0700, William Lee Irwin III wrote:
> Okay, now for the "final solution" wrt. sparse physical APIC ID's
> in addition to what I hope is a fix for your bug. This uses a separate
> bitmap type (of a NR_CPUS -independent width MAX_APICS) for physical
> APIC ID bitmaps.
> \begin{cross-fingers}

This time diffed against the right tree:


diff -prauN mm1-2.5.74-1/arch/i386/kernel/apic.c physid-2.5.74-1/arch/i386/kernel/apic.c
--- mm1-2.5.74-1/arch/i386/kernel/apic.c	2003-07-03 12:23:55.000000000 -0700
+++ physid-2.5.74-1/arch/i386/kernel/apic.c	2003-07-04 02:45:17.000000000 -0700
@@ -1137,7 +1137,7 @@ int __init APIC_init_uniprocessor (void)
 
 	connect_bsp_APIC();
 
-	phys_cpu_present_map = cpumask_of_cpu(boot_cpu_physical_apicid);
+	phys_cpu_present_map = physid_mask_of_physid(boot_cpu_physical_apicid);
 
 	setup_local_APIC();
 
diff -prauN mm1-2.5.74-1/arch/i386/kernel/io_apic.c physid-2.5.74-1/arch/i386/kernel/io_apic.c
--- mm1-2.5.74-1/arch/i386/kernel/io_apic.c	2003-07-03 12:23:55.000000000 -0700
+++ physid-2.5.74-1/arch/i386/kernel/io_apic.c	2003-07-04 02:45:17.000000000 -0700
@@ -1601,7 +1601,7 @@ void disable_IO_APIC(void)
 static void __init setup_ioapic_ids_from_mpc(void)
 {
 	union IO_APIC_reg_00 reg_00;
-	cpumask_t phys_id_present_map;
+	physid_mask_t phys_id_present_map;
 	int apic;
 	int i;
 	unsigned char old_id;
@@ -1615,8 +1615,7 @@ static void __init setup_ioapic_ids_from
 	 * This is broken; anything with a real cpu count has to
 	 * circumvent this idiocy regardless.
 	 */
-	phys_id_present_map =
-		ioapic_phys_id_map(mk_cpumask_const(phys_cpu_present_map));
+	phys_id_present_map = ioapic_phys_id_map(phys_cpu_present_map);
 
 	/*
 	 * Set the IOAPIC ID to the value stored in the MPC table.
@@ -1647,20 +1646,20 @@ static void __init setup_ioapic_ids_from
 					mp_ioapics[apic].mpc_apicid)) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
-			for (i = 0; i < 0xf; i++)
-				if (!cpu_isset(i, phys_id_present_map))
+			for (i = 0; i < APIC_BROADCAST_ID; i++)
+				if (!physid_isset(i, phys_id_present_map))
 					break;
-			if (i >= 0xf)
+			if (i >= APIC_BROADCAST_ID)
 				panic("Max APIC ID exceeded!\n");
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
 				i);
-			cpu_set(i, phys_id_present_map);
+			physid_set(i, phys_id_present_map);
 			mp_ioapics[apic].mpc_apicid = i;
 		} else {
-			cpumask_t tmp;
+			physid_mask_t tmp;
 			tmp = apicid_to_cpu_present(mp_ioapics[apic].mpc_apicid);
 			printk("Setting %d in the phys_id_present_map\n", mp_ioapics[apic].mpc_apicid);
-			cpus_or(phys_id_present_map, phys_id_present_map, tmp);
+			physids_or(phys_id_present_map, phys_id_present_map, tmp);
 		}
 
 
@@ -2230,8 +2229,8 @@ late_initcall(io_apic_bug_finalize);
 int __init io_apic_get_unique_id (int ioapic, int apic_id)
 {
 	union IO_APIC_reg_00 reg_00;
-	static cpumask_t apic_id_map = CPU_MASK_NONE;
-	cpumask_t tmp;
+	static physid_mask_t apic_id_map = CPU_MASK_NONE;
+	physid_mask_t tmp;
 	unsigned long flags;
 	int i = 0;
 
@@ -2244,8 +2243,8 @@ int __init io_apic_get_unique_id (int io
 	 *      advantage of new APIC bus architecture.
 	 */
 
-	if (cpus_empty(apic_id_map))
-		apic_id_map = ioapic_phys_id_map(mk_cpumask_const(phys_cpu_present_map));
+	if (physids_empty(apic_id_map))
+		apic_id_map = ioapic_phys_id_map(phys_cpu_present_map);
 
 	spin_lock_irqsave(&ioapic_lock, flags);
 	reg_00.raw = io_apic_read(ioapic, 0);
@@ -2278,7 +2277,7 @@ int __init io_apic_get_unique_id (int io
 	} 
 
 	tmp = apicid_to_cpu_present(apic_id);
-	cpus_or(apic_id_map, apic_id_map, tmp);
+	physids_or(apic_id_map, apic_id_map, tmp);
 
 	if (reg_00.bits.ID != apic_id) {
 		reg_00.bits.ID = apic_id;
diff -prauN mm1-2.5.74-1/arch/i386/kernel/mpparse.c physid-2.5.74-1/arch/i386/kernel/mpparse.c
--- mm1-2.5.74-1/arch/i386/kernel/mpparse.c	2003-07-03 12:23:55.000000000 -0700
+++ physid-2.5.74-1/arch/i386/kernel/mpparse.c	2003-07-04 02:45:17.000000000 -0700
@@ -71,7 +71,7 @@ unsigned int boot_cpu_logical_apicid = -
 static unsigned int __initdata num_processors;
 
 /* Bitmask of physically existing CPUs */
-cpumask_t phys_cpu_present_map;
+physid_mask_t phys_cpu_present_map;
 
 u8 bios_cpu_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
@@ -106,7 +106,7 @@ static struct mpc_config_translation *tr
 void __init MP_processor_info (struct mpc_config_processor *m)
 {
  	int ver, apicid;
-	cpumask_t tmp;
+	physid_mask_t tmp;
  	
 	if (!(m->mpc_cpuflag & CPU_ENABLED))
 		return;
@@ -178,7 +178,7 @@ void __init MP_processor_info (struct mp
 	ver = m->mpc_apicver;
 
 	tmp = apicid_to_cpu_present(apicid);
-	cpus_or(phys_cpu_present_map, phys_cpu_present_map, tmp);
+	physids_or(phys_cpu_present_map, phys_cpu_present_map, tmp);
 	
 	/*
 	 * Validate version
diff -prauN mm1-2.5.74-1/arch/i386/kernel/smpboot.c physid-2.5.74-1/arch/i386/kernel/smpboot.c
--- mm1-2.5.74-1/arch/i386/kernel/smpboot.c	2003-07-03 12:23:55.000000000 -0700
+++ physid-2.5.74-1/arch/i386/kernel/smpboot.c	2003-07-04 02:45:17.000000000 -0700
@@ -957,7 +957,7 @@ static void __init smp_boot_cpus(unsigne
 	if (!smp_found_config) {
 		printk(KERN_NOTICE "SMP motherboard not detected.\n");
 		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = cpumask_of_cpu(0);
+		phys_cpu_present_map = physid_mask_of_physid(0);
 		if (APIC_init_uniprocessor())
 			printk(KERN_NOTICE "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
@@ -984,7 +984,7 @@ static void __init smp_boot_cpus(unsigne
 			boot_cpu_physical_apicid);
 		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
 		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = cpumask_of_cpu(0);
+		phys_cpu_present_map = physid_mask_of_physid(0);
 		return;
 	}
 
@@ -997,7 +997,7 @@ static void __init smp_boot_cpus(unsigne
 		smp_found_config = 0;
 		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
 		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = cpumask_of_cpu(0);
+		phys_cpu_present_map = physid_mask_of_physid(0);
 		return;
 	}
 
@@ -1020,7 +1020,7 @@ static void __init smp_boot_cpus(unsigne
 	Dprintk("CPU present map: %lx\n", cpus_coerce(phys_cpu_present_map));
 
 	kicked = 1;
-	for (bit = 0; kicked < NR_CPUS && bit < 8*sizeof(cpumask_t); bit++) {
+	for (bit = 0; kicked < NR_CPUS && bit < MAX_APICS; bit++) {
 		apicid = cpu_present_to_apicid(bit);
 		/*
 		 * Don't even attempt to start the boot CPU!
diff -prauN mm1-2.5.74-1/include/asm-i386/genapic.h physid-2.5.74-1/include/asm-i386/genapic.h
--- mm1-2.5.74-1/include/asm-i386/genapic.h	2003-07-03 12:23:56.000000000 -0700
+++ physid-2.5.74-1/include/asm-i386/genapic.h	2003-07-04 02:48:52.000000000 -0700
@@ -27,18 +27,18 @@ struct genapic { 
 	int int_dest_mode; 
 	int apic_broadcast_id; 
 	int esr_disable;
-	unsigned long (*check_apicid_used)(cpumask_const_t bitmap, int apicid);
+	unsigned long (*check_apicid_used)(physid_mask_t bitmap, int apicid);
 	unsigned long (*check_apicid_present)(int apicid); 
 	int no_balance_irq;
 	void (*init_apic_ldr)(void);
-	cpumask_t (*ioapic_phys_id_map)(cpumask_const_t map);
+	physid_mask_t (*ioapic_phys_id_map)(physid_mask_t map);
 
 	void (*clustered_apic_check)(void);
 	int (*multi_timer_check)(int apic, int irq);
 	int (*apicid_to_node)(int logical_apicid); 
 	int (*cpu_to_logical_apicid)(int cpu);
 	int (*cpu_present_to_apicid)(int mps_cpu);
-	cpumask_t (*apicid_to_cpu_present)(int phys_apicid);
+	physid_mask_t (*apicid_to_cpu_present)(int phys_apicid);
 	int (*mpc_apic_id)(struct mpc_config_processor *m, 
 			   struct mpc_config_translation *t); 
 	void (*setup_portio_remap)(void); 
diff -prauN mm1-2.5.74-1/include/asm-i386/mach-bigsmp/mach_apic.h physid-2.5.74-1/include/asm-i386/mach-bigsmp/mach_apic.h
--- mm1-2.5.74-1/include/asm-i386/mach-bigsmp/mach_apic.h	2003-07-03 12:23:56.000000000 -0700
+++ physid-2.5.74-1/include/asm-i386/mach-bigsmp/mach_apic.h	2003-07-04 02:47:45.000000000 -0700
@@ -29,15 +29,15 @@ static inline cpumask_t target_cpus(void
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
-#define APIC_BROADCAST_ID     (0x0f)
-static inline unsigned long check_apicid_used(cpumask_const_t bitmap, int apicid)
+#define APIC_BROADCAST_ID     (0xff)
+static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)
 {
 	return 0;
 }
 
 static inline unsigned long check_apicid_present(int bit) 
 {
-	return cpu_isset(bit, phys_cpu_present_map);
+	return physid_isset(bit, phys_cpu_present_map);
 }
 
 #define apicid_cluster(apicid) (apicid & 0xF0)
@@ -89,9 +89,9 @@ static inline int cpu_present_to_apicid(
 	return (int) bios_cpu_apicid[mps_cpu];
 }
 
-static inline cpumask_t apicid_to_cpu_present(int phys_apicid)
+static inline physid_mask_t apicid_to_cpu_present(int phys_apicid)
 {
-	return cpumask_of_cpu(phys_apicid);
+	return physid_mask_of_physid(phys_apicid);
 }
 
 extern volatile u8 cpu_2_logical_apicid[];
@@ -112,10 +112,10 @@ static inline int mpc_apic_id(struct mpc
 	return m->mpc_apicid;
 }
 
-static inline cpumask_t ioapic_phys_id_map(cpumask_const_t phys_map)
+static inline physid_mask_t ioapic_phys_id_map(physid_mask_t phys_map)
 {
 	/* For clustered we don't have a good way to do this yet - hack */
-	return cpus_promote(0xFUL);
+	return physids_promote(0xFUL);
 }
 
 #define WAKE_SECONDARY_VIA_INIT
diff -prauN mm1-2.5.74-1/include/asm-i386/mach-default/mach_apic.h physid-2.5.74-1/include/asm-i386/mach-default/mach_apic.h
--- mm1-2.5.74-1/include/asm-i386/mach-default/mach_apic.h	2003-07-03 12:23:56.000000000 -0700
+++ physid-2.5.74-1/include/asm-i386/mach-default/mach_apic.h	2003-07-04 02:45:17.000000000 -0700
@@ -21,16 +21,20 @@ static inline cpumask_t target_cpus(void
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
+/*
+ * this isn't really broadcast, just a (potentially inaccurate) upper
+ * bound for valid physical APIC id's
+ */
 #define APIC_BROADCAST_ID      0x0F
 
-static inline unsigned long check_apicid_used(cpumask_const_t bitmap, int apicid)
+static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)
 {
-	return cpu_isset_const(apicid, bitmap);
+	return physid_isset(apicid, bitmap);
 }
 
 static inline unsigned long check_apicid_present(int bit)
 {
-	return cpu_isset(bit, phys_cpu_present_map);
+	return physid_isset(bit, phys_cpu_present_map);
 }
 
 /*
@@ -50,11 +54,9 @@ static inline void init_apic_ldr(void)
 	apic_write_around(APIC_LDR, val);
 }
 
-static inline cpumask_t ioapic_phys_id_map(cpumask_const_t phys_map)
+static inline physid_mask_t ioapic_phys_id_map(physid_mask_t phys_map)
 {
-	cpumask_t ret;
-	cpus_copy_const(ret, phys_map);
-	return ret;
+	return phys_map;
 }
 
 static inline void clustered_apic_check(void)
@@ -84,9 +86,9 @@ static inline int cpu_present_to_apicid(
 	return  mps_cpu;
 }
 
-static inline cpumask_t apicid_to_cpu_present(int phys_apicid)
+static inline physid_mask_t apicid_to_cpu_present(int phys_apicid)
 {
-	return cpumask_of_cpu(phys_apicid);
+	return physid_mask_of_physid(phys_apicid);
 }
 
 static inline int mpc_apic_id(struct mpc_config_processor *m, 
@@ -106,12 +108,12 @@ static inline void setup_portio_remap(vo
 
 static inline int check_phys_apicid_present(int boot_cpu_physical_apicid)
 {
-	return cpu_isset(boot_cpu_physical_apicid, phys_cpu_present_map);
+	return physid_isset(boot_cpu_physical_apicid, phys_cpu_present_map);
 }
 
 static inline int apic_id_registered(void)
 {
-	return cpu_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map);
+	return physid_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map);
 }
 
 static inline unsigned int cpu_mask_to_apicid(cpumask_const_t cpumask)
diff -prauN mm1-2.5.74-1/include/asm-i386/mach-es7000/mach_apic.h physid-2.5.74-1/include/asm-i386/mach-es7000/mach_apic.h
--- mm1-2.5.74-1/include/asm-i386/mach-es7000/mach_apic.h	2003-07-03 12:23:56.000000000 -0700
+++ physid-2.5.74-1/include/asm-i386/mach-es7000/mach_apic.h	2003-07-04 02:46:36.000000000 -0700
@@ -40,13 +40,13 @@ static inline cpumask_t target_cpus(void
 
 #define APIC_BROADCAST_ID	(0xff)
 
-static inline unsigned long check_apicid_used(cpumask_const_t bitmap, int apicid)
+static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)
 { 
 	return 0;
 } 
 static inline unsigned long check_apicid_present(int bit) 
 {
-	return cpu_isset(bit, phys_cpu_present_map);
+	return physid_isset(bit, phys_cpu_present_map);
 }
 
 #define apicid_cluster(apicid) (apicid & 0xF0)
@@ -110,12 +110,12 @@ static inline int cpu_present_to_apicid(
 		return (int) bios_cpu_apicid[mps_cpu];
 }
 
-static inline cpumask_t apicid_to_cpu_present(int phys_apicid)
+static inline physid_mask_t apicid_to_cpu_present(int phys_apicid)
 {
-	static int cpu = 0;
-	cpumask_t mask;
-	mask = cpumask_of_cpu(cpu);
-	++cpu;
+	static int id = 0;
+	physid_mask_t mask;
+	mask = physid_mask_of_physid(id);
+	++id;
 	return mask;
 }
 
@@ -136,10 +136,10 @@ static inline int mpc_apic_id(struct mpc
 	return (m->mpc_apicid);
 }
 
-static inline cpumask_t ioapic_phys_id_map(cpumask_const_t phys_map)
+static inline physid_mask_t ioapic_phys_id_map(physid_mask_t phys_map)
 {
 	/* For clustered we don't have a good way to do this yet - hack */
-	return cpus_promote(0xff);
+	return physids_promote(0xff);
 }
 
 
diff -prauN mm1-2.5.74-1/include/asm-i386/mach-numaq/mach_apic.h physid-2.5.74-1/include/asm-i386/mach-numaq/mach_apic.h
--- mm1-2.5.74-1/include/asm-i386/mach-numaq/mach_apic.h	2003-07-03 12:23:56.000000000 -0700
+++ physid-2.5.74-1/include/asm-i386/mach-numaq/mach_apic.h	2003-07-04 02:45:17.000000000 -0700
@@ -21,8 +21,8 @@ static inline cpumask_t target_cpus(void
 #define INT_DEST_MODE 0     /* physical delivery on LOCAL quad */
  
 #define APIC_BROADCAST_ID      0x0F
-#define check_apicid_used(bitmap, apicid) cpu_isset_const(apicid, bitmap)
-#define check_apicid_present(bit) cpu_isset(bit, phys_cpu_present_map)
+#define check_apicid_used(bitmap, apicid) physid_isset(apicid, bitmap)
+#define check_apicid_present(bit) physid_isset(bit, phys_cpu_present_map)
 #define apicid_cluster(apicid) (apicid & 0xF0)
 
 static inline int apic_id_registered(void)
@@ -50,10 +50,10 @@ static inline int multi_timer_check(int 
 	return apic != 0 && irq == 0;
 }
 
-static inline cpumask_t ioapic_phys_id_map(cpumask_const_t phys_map)
+static inline physid_mask_t ioapic_phys_id_map(physid_mask_t phys_map)
 {
 	/* We don't have a good way to do this yet - hack */
-	return cpus_promote(0xFUL);
+	return physids_promote(0xFUL);
 }
 
 /* Mapping from cpu number to logical apicid */
@@ -78,12 +78,12 @@ static inline int apicid_to_node(int log
 	return logical_apicid >> 4;
 }
 
-static inline cpumask_t apicid_to_cpu_present(int logical_apicid)
+static inline physid_mask_t apicid_to_cpu_present(int logical_apicid)
 {
 	int node = apicid_to_node(logical_apicid);
 	int cpu = __ffs(logical_apicid & 0xf);
 
-	return cpumask_of_cpu(cpu + 4*node);
+	return physid_mask_of_physid(cpu + 4*node);
 }
 
 static inline int mpc_apic_id(struct mpc_config_processor *m, 
diff -prauN mm1-2.5.74-1/include/asm-i386/mach-summit/mach_apic.h physid-2.5.74-1/include/asm-i386/mach-summit/mach_apic.h
--- mm1-2.5.74-1/include/asm-i386/mach-summit/mach_apic.h	2003-07-03 12:23:56.000000000 -0700
+++ physid-2.5.74-1/include/asm-i386/mach-summit/mach_apic.h	2003-07-04 02:47:00.000000000 -0700
@@ -28,8 +28,8 @@ static inline cpumask_t target_cpus(void
 #define INT_DELIVERY_MODE (dest_Fixed)
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
-#define APIC_BROADCAST_ID     (0x0F)
-static inline unsigned long check_apicid_used(cpumask_const_t bitmap, int apicid)
+#define APIC_BROADCAST_ID     (0xFF)
+static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)
 {
 	return 0;
 } 
@@ -88,15 +88,15 @@ static inline int cpu_present_to_apicid(
 	return (int) bios_cpu_apicid[mps_cpu];
 }
 
-static inline cpumask_t ioapic_phys_id_map(cpumask_const_t phys_id_map)
+static inline physid_mask_t ioapic_phys_id_map(physid_mask_t phys_id_map)
 {
 	/* For clustered we don't have a good way to do this yet - hack */
-	return cpus_promote(0x0F);
+	return physids_promote(0x0F);
 }
 
-static inline cpumask_t apicid_to_cpu_present(int apicid)
+static inline physid_mask_t apicid_to_cpu_present(int apicid)
 {
-	return cpumask_of_cpu(0);
+	return physid_mask_of_physid(0);
 }
 
 static inline int mpc_apic_id(struct mpc_config_processor *m, 
diff -prauN mm1-2.5.74-1/include/asm-i386/mach-visws/mach_apic.h physid-2.5.74-1/include/asm-i386/mach-visws/mach_apic.h
--- mm1-2.5.74-1/include/asm-i386/mach-visws/mach_apic.h	2003-07-03 12:23:56.000000000 -0700
+++ physid-2.5.74-1/include/asm-i386/mach-visws/mach_apic.h	2003-07-04 02:45:17.000000000 -0700
@@ -16,12 +16,12 @@
 #endif
 
 #define APIC_BROADCAST_ID      0x0F
-#define check_apicid_used(bitmap, apicid)	cpu_isset_const(apicid, bitmap)
-#define check_apicid_present(bit)		cpu_isset(bit, phys_cpu_present_map)
+#define check_apicid_used(bitmap, apicid)	physid_isset(apicid, bitmap)
+#define check_apicid_present(bit)		physid_isset(bit, phys_cpu_present_map)
 
 static inline int apic_id_registered(void)
 {
-	return cpu_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map);
+	return physid_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map);
 }
 
 /*
@@ -60,9 +60,9 @@ static inline int cpu_present_to_apicid(
 	return mps_cpu;
 }
 
-static inline cpumask_t apicid_to_cpu_present(int apicid)
+static inline physid_mask_t apicid_to_cpu_present(int apicid)
 {
-	return cpumask_of_cpu(apicid);
+	return physid_mask_of_physid(apicid);
 }
 
 #define WAKE_SECONDARY_VIA_INIT
@@ -77,7 +77,7 @@ static inline void enable_apic_mode(void
 
 static inline int check_phys_apicid_present(int boot_cpu_physical_apicid)
 {
-	return cpu_isset(boot_cpu_physical_apicid, phys_cpu_present_map);
+	return physid_isset(boot_cpu_physical_apicid, phys_cpu_present_map);
 }
 
 static inline unsigned int cpu_mask_to_apicid(cpumask_const_t cpumask)
diff -prauN mm1-2.5.74-1/include/asm-i386/mpspec.h physid-2.5.74-1/include/asm-i386/mpspec.h
--- mm1-2.5.74-1/include/asm-i386/mpspec.h	2003-07-03 12:23:56.000000000 -0700
+++ physid-2.5.74-1/include/asm-i386/mpspec.h	2003-07-04 02:45:17.000000000 -0700
@@ -12,7 +12,6 @@ extern int quad_local_to_mp_bus_id [NR_C
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 
 extern unsigned int boot_cpu_physical_apicid;
-extern cpumask_t phys_cpu_present_map;
 extern int smp_found_config;
 extern void find_smp_config (void);
 extern void get_smp_config (void);
@@ -42,5 +41,49 @@ extern void mp_config_ioapic_for_sci(int
 extern void mp_parse_prt (void);
 #endif /*CONFIG_ACPI_BOOT*/
 
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
 
diff -prauN mm1-2.5.74-1/include/asm-i386/smp.h physid-2.5.74-1/include/asm-i386/smp.h
--- mm1-2.5.74-1/include/asm-i386/smp.h	2003-07-03 12:23:56.000000000 -0700
+++ physid-2.5.74-1/include/asm-i386/smp.h	2003-07-04 02:45:17.000000000 -0700
@@ -32,7 +32,7 @@
  */
  
 extern void smp_alloc_memory(void);
-extern cpumask_t phys_cpu_present_map;
+extern physid_mask_t phys_cpu_present_map;
 extern int pic_mode;
 extern int smp_num_siblings;
 extern int cpu_sibling_map[];

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266650AbSLWG6O>; Mon, 23 Dec 2002 01:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266660AbSLWG6O>; Mon, 23 Dec 2002 01:58:14 -0500
Received: from franka.aracnet.com ([216.99.193.44]:13741 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266650AbSLWG6M>; Mon, 23 Dec 2002 01:58:12 -0500
Date: Sun, 22 Dec 2002 23:06:15 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PATCH] 8/8 Move NUMA-Q support into subarch
Message-ID: <71950000.1040627175@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Code mostly originally by James Cleverdon.
Abstracts out more clustered_apic_mode gunk into

ioapic_phys_id_map()
wakeup_secondary_cpu()
setup_portio_remap()

diff -urpN -X /home/fletch/.diff.exclude 16-numaq6/arch/i386/kernel/io_apic.c 17-numaq7/arch/i386/kernel/io_apic.c
--- 16-numaq6/arch/i386/kernel/io_apic.c	Sun Dec 22 12:09:41 2002
+++ 17-numaq7/arch/i386/kernel/io_apic.c	Sun Dec 22 12:11:57 2002
@@ -1135,7 +1135,7 @@ void disable_IO_APIC(void)
 static void __init setup_ioapic_ids_from_mpc (void)
 {
 	struct IO_APIC_reg_00 reg_00;
-	unsigned long phys_id_present_map = phys_cpu_present_map;
+	unsigned long phys_id_present_map;
 	int apic;
 	int i;
 	unsigned char old_id;
@@ -1145,9 +1145,8 @@ static void __init setup_ioapic_ids_from
 		/* This gets done during IOAPIC enumeration for ACPI. */
 		return;
 
-	if (clustered_apic_mode)
-		/* We don't have a good way to do this yet - hack */
-		phys_id_present_map = (u_long) 0xf;
+	phys_id_present_map = ioapic_phys_id_map(phys_cpu_present_map);
+
 	/*
 	 * Set the IOAPIC ID to the value stored in the MPC table.
 	 */
diff -urpN -X /home/fletch/.diff.exclude 16-numaq6/arch/i386/kernel/smpboot.c 17-numaq7/arch/i386/kernel/smpboot.c
--- 16-numaq6/arch/i386/kernel/smpboot.c	Sun Dec 22 12:08:42 2002
+++ 17-numaq7/arch/i386/kernel/smpboot.c	Sun Dec 22 12:11:57 2002
@@ -849,11 +849,7 @@ static void __init do_boot_cpu (int apic
 	/*
 	 * Starting actual IPI sequence...
 	 */
-
-	if (clustered_apic_mode)
-		boot_error = wakeup_secondary_via_NMI(apicid);
-	else 
-		boot_error = wakeup_secondary_via_INIT(apicid, start_eip);
+	wakeup_secondary_cpu(apicid, start_eip);
 
 	if (!boot_error) {
 		/*
@@ -1061,15 +1057,7 @@ static void __init smp_boot_cpus(unsigne
 	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_physical_apicid)
 		BUG();
 
-        if (clustered_apic_mode && (numnodes > 1)) {
-                printk("Remapping cross-quad port I/O for %d quads\n",
-			numnodes);
-                xquad_portio = ioremap (XQUAD_PORTIO_BASE, 
-			numnodes * XQUAD_PORTIO_QUAD);
-                printk("xquad_portio vaddr 0x%08lx, len %08lx\n",
-                        (u_long) xquad_portio, 
-			(u_long) numnodes * XQUAD_PORTIO_QUAD);
-        }
+	setup_portio_remap();
 
 	/*
 	 * Scan the CPU present map and fire up the other CPUs via do_boot_cpu
diff -urpN -X /home/fletch/.diff.exclude 16-numaq6/include/asm-i386/mach-default/mach_apic.h 17-numaq7/include/asm-i386/mach-default/mach_apic.h
--- 16-numaq6/include/asm-i386/mach-default/mach_apic.h	Sun Dec 22 12:10:33 2002
+++ 17-numaq7/include/asm-i386/mach-default/mach_apic.h	Sun Dec 22 12:11:57 2002
@@ -37,6 +37,11 @@ static inline void init_apic_ldr(void)
 	apic_write_around(APIC_LDR, val);
 }
 
+static inline ulong ioapic_phys_id_map(ulong phys_map)
+{
+	return phys_map;
+}
+
 static inline void clustered_apic_check(void)
 {
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
@@ -66,6 +71,13 @@ static inline int mpc_apic_id(struct mpc
 			(m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
 			m->mpc_apicver);
 	return (m->mpc_apicid);
+}
+
+#define wakeup_secondary_cpu(apicid, start_eip) \
+	wakeup_secondary_via_INIT(apicid, start_eip)
+
+static inline void setup_portio_remap(void)
+{
 }
 
 #endif /* __ASM_MACH_APIC_H */
diff -urpN -X /home/fletch/.diff.exclude 16-numaq6/include/asm-i386/mach-numaq/mach_apic.h 17-numaq7/include/asm-i386/mach-numaq/mach_apic.h
--- 16-numaq6/include/asm-i386/mach-numaq/mach_apic.h	Sun Dec 22 12:10:33 2002
+++ 17-numaq7/include/asm-i386/mach-numaq/mach_apic.h	Sun Dec 22 12:11:57 2002
@@ -31,6 +31,12 @@ static inline int multi_timer_check(int 
 	return (apic != 0 && irq == 0);
 }
 
+static inline ulong ioapic_phys_id_map(ulong phys_map)
+{
+	/* We don't have a good way to do this yet - hack */
+	return 0xf;
+}
+
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
 	return ( ((mps_cpu/4)*16) + (1<<(mps_cpu%4)) );
@@ -61,6 +67,20 @@ static inline int mpc_apic_id(struct mpc
 			(m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
 			m->mpc_apicver, quad, logical_apicid);
 	return logical_apicid;
+}
+
+#define wakeup_secondary_cpu(apicid, start_eip) \
+	wakeup_secondary_via_NMI(apicid)
+
+static inline void setup_portio_remap(void)
+{
+	if (numnodes <= 1)
+       		return;
+
+	printk("Remapping cross-quad port I/O for %d quads\n", numnodes);
+	xquad_portio = ioremap (XQUAD_PORTIO_BASE, numnodes*XQUAD_PORTIO_QUAD);
+	printk("xquad_portio vaddr 0x%08lx, len %08lx\n",
+		(u_long) xquad_portio, (u_long) numnodes*XQUAD_PORTIO_QUAD);
 }
 
 #endif /* __ASM_MACH_APIC_H */
diff -urpN -X /home/fletch/.diff.exclude 16-numaq6/include/asm-i386/mach-summit/mach_apic.h 17-numaq7/include/asm-i386/mach-summit/mach_apic.h
--- 16-numaq6/include/asm-i386/mach-summit/mach_apic.h	Sun Dec 22 12:10:33 2002
+++ 17-numaq7/include/asm-i386/mach-summit/mach_apic.h	Sun Dec 22 12:11:57 2002
@@ -40,12 +40,25 @@ static inline int cpu_present_to_apicid(
 		return mps_cpu;
 }
 
+static inline ulong ioapic_phys_id_map(ulong phys_map)
+{
+	/* For clustered we don't have a good way to do this yet - hack */
+	return (x86_summit ? 0x0F : phys_map);
+}
+
 static inline unsigned long apicid_to_phys_cpu_present(int apicid)
 {
 	if (x86_summit)
 		return (1ul << (((apicid >> 4) << 2) | (apicid & 0x3)));
 	else
 		return (1ul << apicid);
+}
+
+#define wakeup_secondary_cpu(apicid, start_eip) \
+	wakeup_secondary_via_INIT(apicid, start_eip)
+
+static inline void setup_portio_remap(void)
+{
 }
 
 #endif /* __ASM_MACH_APIC_H */


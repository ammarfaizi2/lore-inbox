Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261719AbSJMUmi>; Sun, 13 Oct 2002 16:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbSJMUmC>; Sun, 13 Oct 2002 16:42:02 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:54151 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261721AbSJMUkh>;
	Sun, 13 Oct 2002 16:40:37 -0400
Date: Sun, 13 Oct 2002 13:41:56 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Summit support for 2.5 [1/4]
Message-ID: <39830000.1034541716@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch originally by James Cleverdon

This patch changes clustered_apic_mode from a boolean to a switch
between three modes: CLUSTERED_APIC_NONE, CLUSTERED_APIC_NUMAQ
and CLUSTERED_APIC_XAPIC (for Summit).

It is written in such a way that it will optimise out at compile time unless you
select CONFIG_CLUSTERED_APIC, which nobody except Summit and NumaQ
does, so there will be no impact on other users (actually, it even optimises
away for NumaQ as well).

It also removes the duplicate definitons of clustered_apic_mode.

----------------

diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/apic.c summit-1/arch/i386/kernel/apic.c
--- virgin/arch/i386/kernel/apic.c	Fri Oct 11 18:03:30 2002
+++ summit-1/arch/i386/kernel/apic.c	Fri Oct 11 18:20:09 2002
@@ -322,7 +322,7 @@ void __init setup_local_APIC (void)
 	 * document number 292116).  So here it goes...
 	 */
 
-	if (!clustered_apic_mode) {
+	if (clustered_apic_mode != CLUSTERED_APIC_NUMAQ) {
 		/*
 		 * In clustered apic mode, the firmware does this for us 
 		 * Put the APIC into flat delivery mode.
diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/io_apic.c summit-1/arch/i386/kernel/io_apic.c
--- virgin/arch/i386/kernel/io_apic.c	Tue Oct  1 00:06:28 2002
+++ summit-1/arch/i386/kernel/io_apic.c	Fri Oct 11 18:20:09 2002
@@ -254,7 +254,7 @@ static inline void balance_irq(int irq)
 	irq_balance_t *entry = irq_balance + irq;
 	unsigned long now = jiffies;
 
-	if (clustered_apic_mode)
+	if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
 		return;
 
 	if (unlikely(time_after(now, entry->timestamp + IRQ_BALANCE_INTERVAL))) {
@@ -740,7 +740,7 @@ void __init setup_IO_APIC_irqs(void)
 		 * skip adding the timer int on secondary nodes, which causes
 		 * a small but painful rift in the time-space continuum
 		 */
-		if (clustered_apic_mode && (apic != 0) && (irq == 0))
+		if ((clustered_apic_mode == CLUSTERED_APIC_NUMAQ) && (apic != 0) && (irq == 0))
 			continue;
 		else
 			add_pin_to_irq(irq, apic, pin);
diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/mpparse.c summit-1/arch/i386/kernel/mpparse.c
--- virgin/arch/i386/kernel/mpparse.c	Fri Oct 11 18:03:30 2002
+++ summit-1/arch/i386/kernel/mpparse.c	Fri Oct 11 18:20:09 2002
@@ -69,6 +69,9 @@ static unsigned int __initdata num_proce
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;
 
+int clustered_apic = 0;
+int esr_disable = 0;
+
 /*
  * Intel MP BIOS table parsing routines:
  */
@@ -105,7 +108,7 @@ void __init MP_processor_info (struct mp
 		return;
 
 	logical_apicid = m->mpc_apicid;
-	if (clustered_apic_mode) {
+	if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ) {
 		quad = translation_table[mpc_record]->trans_quad;
 		logical_apicid = (quad << 4) + 
 			(m->mpc_apicid ? m->mpc_apicid << 1 : 1);
@@ -204,12 +207,12 @@ void __init MP_processor_info (struct mp
 static void __init MP_bus_info (struct mpc_config_bus *m)
 {
 	char str[7];
-	int quad;
+	int quad = 0;
 
 	memcpy(str, m->mpc_bustype, 6);
 	str[6] = 0;
 	
-	if (clustered_apic_mode) {
+	if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ) {
 		quad = translation_table[mpc_record]->trans_quad;
 		mp_bus_id_to_node[m->mpc_busid] = quad;
 		mp_bus_id_to_local[m->mpc_busid] = translation_table[mpc_record]->trans_local;
@@ -223,7 +226,7 @@ static void __init MP_bus_info (struct m
 	} else if (strncmp(str, BUSTYPE_EISA, sizeof(BUSTYPE_EISA)-1) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_EISA;
 	} else if (strncmp(str, BUSTYPE_PCI, sizeof(BUSTYPE_PCI)-1) == 0) {
-		if (clustered_apic_mode){
+		if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ) {
 			quad_local_to_mp_bus_id[quad][translation_table[mpc_record]->trans_local] = m->mpc_busid;
 		}
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_PCI;
@@ -397,7 +400,7 @@ static int __init smp_read_mpc(struct mp
 	if (!acpi_lapic)
 		mp_lapic_addr = mpc->mpc_lapic;
 
-	if (clustered_apic_mode && mpc->mpc_oemptr) {
+	if ((clustered_apic_mode == CLUSTERED_APIC_NUMAQ) && mpc->mpc_oemptr) {
 		/* We need to process the oem mpc tables to tell us which quad things are in ... */
 		mpc_record = 0;
 		smp_read_mpc_oem((struct mp_config_oemtable *) mpc->mpc_oemptr, mpc->mpc_oemsize);
diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/smpboot.c summit-1/arch/i386/kernel/smpboot.c
--- virgin/arch/i386/kernel/smpboot.c	Tue Oct  1 00:06:59 2002
+++ summit-1/arch/i386/kernel/smpboot.c	Fri Oct 11 18:21:20 2002
@@ -814,7 +814,7 @@ static void __init do_boot_cpu (int apic
 
 	Dprintk("Setting warm reset code and vector.\n");
 
-	if (clustered_apic_mode) {
+	if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ) {
 		/* stash the current NMI vector, so we can put things back */
 		nmi_high = *((volatile unsigned short *) TRAMPOLINE_HIGH);
 		nmi_low = *((volatile unsigned short *) TRAMPOLINE_LOW);
@@ -846,7 +846,7 @@ static void __init do_boot_cpu (int apic
 	 * Starting actual IPI sequence...
 	 */
 
-	if (clustered_apic_mode)
+	if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
 		boot_error = wakeup_secondary_via_NMI(apicid);
 	else 
 		boot_error = wakeup_secondary_via_INIT(apicid, start_eip);
@@ -900,7 +900,7 @@ static void __init do_boot_cpu (int apic
 	/* mark "stuck" area as not stuck */
 	*((volatile unsigned long *)phys_to_virt(8192)) = 0;
 
-	if(clustered_apic_mode) {
+	if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ) {
 		printk("Restoring NMI vector\n");
 		*((volatile unsigned short *) TRAMPOLINE_HIGH) = nmi_high;
 		*((volatile unsigned short *) TRAMPOLINE_LOW) = nmi_low;
@@ -1057,7 +1057,7 @@ static void __init smp_boot_cpus(unsigne
 	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_physical_apicid)
 		BUG();
 
-        if (clustered_apic_mode && (numnodes > 1)) {
+        if ((clustered_apic_mode == CLUSTERED_APIC_NUMAQ) && (numnodes > 1)) {
                 printk("Remapping cross-quad port I/O for %d quads\n",
 			numnodes);
                 xquad_portio = ioremap (XQUAD_PORTIO_BASE, 
diff -urpN -X /home/fletch/.diff.exclude virgin/include/asm-i386/smp.h summit-1/include/asm-i386/smp.h
--- virgin/include/asm-i386/smp.h	Fri Oct 11 18:03:41 2002
+++ summit-1/include/asm-i386/smp.h	Fri Oct 11 18:20:09 2002
@@ -34,15 +34,26 @@
 # define TARGET_CPUS 0x01
 #endif
 
-#ifndef clustered_apic_mode
- #ifdef CONFIG_CLUSTERED_APIC
-  #define clustered_apic_mode (1)
-  #define esr_disable (1)
- #else /* !CONFIG_CLUSTERED_APIC */
-  #define clustered_apic_mode (0)
-  #define esr_disable (0)
- #endif /* CONFIG_CLUSTERED_APIC */
-#endif 
+#define CLUSTERED_APIC_NONE	0x00
+#define CLUSTERED_APIC_NUMAQ	0x01
+#define CLUSTERED_APIC_XAPIC	0x02
+
+/* 
+ * The following makes all the clustered apic mode switches optimise out at 
+ * compile time for all systems except summit
+ */
+#ifdef CONFIG_CLUSTERED_APIC
+ #ifdef CONFIG_X86_NUMAQ
+  #define clustered_apic_mode CLUSTERED_APIC_NUMAQ
+ #else
+  #define clustered_apic_mode clustered_apic
+ #endif
+#else /* !CONFIG_CLUSTERED_APIC */
+ #define clustered_apic_mode (0)
+#endif /* CONFIG_CLUSTERED_APIC */
+
+extern int clustered_apic;
+extern int esr_disable;
 
 #ifdef CONFIG_SMP
 #ifndef __ASSEMBLY__
diff -urpN -X /home/fletch/.diff.exclude virgin/include/asm-i386/smpboot.h summit-1/include/asm-i386/smpboot.h
--- virgin/include/asm-i386/smpboot.h	Fri Oct 11 18:03:41 2002
+++ summit-1/include/asm-i386/smpboot.h	Fri Oct 11 18:29:04 2002
@@ -1,27 +1,21 @@
 #ifndef __ASM_SMPBOOT_H
 #define __ASM_SMPBOOT_H
 
-#ifndef clustered_apic_mode
- #ifdef CONFIG_CLUSTERED_APIC
-  #define clustered_apic_mode (1)
- #else /* !CONFIG_CLUSTERED_APIC */
-  #define clustered_apic_mode (0)
- #endif /* CONFIG_CLUSTERED_APIC */
-#endif 
- 
-#ifdef CONFIG_CLUSTERED_APIC
+#include "asm/smp.h"
+
+#ifdef CONFIG_X86_NUMAQ
  #define TRAMPOLINE_LOW phys_to_virt(0x8)
  #define TRAMPOLINE_HIGH phys_to_virt(0xa)
-#else /* !CONFIG_CLUSTERED_APIC */
+#else
  #define TRAMPOLINE_LOW phys_to_virt(0x467)
  #define TRAMPOLINE_HIGH phys_to_virt(0x469)
-#endif /* CONFIG_CLUSTERED_APIC */
+#endif
 
-#ifdef CONFIG_CLUSTERED_APIC
+#ifdef CONFIG_X86_NUMAQ
  #define boot_cpu_apicid boot_cpu_logical_apicid
-#else /* !CONFIG_CLUSTERED_APIC */
+#else 
  #define boot_cpu_apicid boot_cpu_physical_apicid
-#endif /* CONFIG_CLUSTERED_APIC */
+#endif
 
 /*
  * How to map from the cpu_present_map


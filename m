Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbTEXDXi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 23:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTEXDXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 23:23:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:43992 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262976AbTEXDXf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 23:23:35 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [PATCH][2.5] provisional 32-way x445 patches
Date: Fri, 23 May 2003 20:36:39 -0700
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305232036.39297.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's what it took to get 2.5.68 going on a 32-way x445.  It contains a 
kludge in setup_ioapic_ids_from_mps() that needs to be virtualized.

Note the code in init_apic_ldr() that breaks the connection between logical 
and physical APIC IDs.  That's there because the BIOS folks reserve the right 
to make the physical numbering scheme anything they want at > 16-way.  I 
suspect that other vendors will have the same problems (P4s only latch 6 bits 
of physical APIC ID on reset) and will come to entirely different solutions.  
Best to make a clean break and accept any scheme.

Martin, I'm taking a couple of extra days off past Memorial Day, so we'll have 
to discuss hiding the use of x86_summit later next week.


diff -pru 2.5.68/arch/i386/kernel/io_apic.c t68/arch/i386/kernel/io_apic.c
--- 2.5.68/arch/i386/kernel/io_apic.c	2003-04-19 22:49:09.000000000 -0400
+++ t68/arch/i386/kernel/io_apic.c	2003-05-07 11:12:49.000000000 -0400
@@ -1105,11 +1105,12 @@ static inline int IO_APIC_irq_trigger(in
 	return 0;
 }
 
-int irq_vector[NR_IRQS] = { FIRST_DEVICE_VECTOR , 0 };
+u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 
 static int __init assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
+	BUG_ON(irq >= sizeof(irq_vector)/sizeof(*irq_vector));
 	if (IO_APIC_VECTOR(irq) > 0)
 		return IO_APIC_VECTOR(irq);
 next:
@@ -1592,6 +1593,11 @@ static void __init setup_ioapic_ids_from
 			mp_ioapics[apic].mpc_apicid = reg_00.ID;
 		}
 
+		/* Temp kludge.  Anyway, the BIOS sets the IDs correctly on Summit boxen. 
*/
+		{ extern int x86_summit;
+		if (x86_summit)
+			continue;
+		}
 		/*
 		 * Sanity check, is the ID really free? Every APIC in a
 		 * system must have a unique ID or we get lots of nice
diff -pru 2.5.68/include/asm-i386/hw_irq.h t68/include/asm-i386/hw_irq.h
--- 2.5.68/include/asm-i386/hw_irq.h	2003-04-19 22:51:13.000000000 -0400
+++ t68/include/asm-i386/hw_irq.h	2003-05-07 11:01:13.000000000 -0400
@@ -24,8 +24,13 @@
  * Interrupt entry/exit code at both C and assembly level
  */
 
-extern int irq_vector[NR_IRQS];
-#define IO_APIC_VECTOR(irq)	irq_vector[irq]
+/* The upper limit of irq_vector's size is 16 + sum(num_RTEs_in_IO_APICs).
+ * On 32-way x445s this is already 266 without any I/O expansion boxes.
+ * This should eventually be dynamically allocated.
+ */
+#define NR_IRQ_VECTORS	(4 * NR_IRQS)
+extern u8 irq_vector[NR_IRQ_VECTORS];
+#define IO_APIC_VECTOR(irq)	(int)(irq_vector[irq])
 
 extern void (*interrupt[NR_IRQS])(void);
 
diff -pru 2.5.68/include/asm-i386/mach-summit/mach_apic.h 
t68/include/asm-i386/mach-summit/mach_apic.h
--- 2.5.68/include/asm-i386/mach-summit/mach_apic.h	2003-04-19 
22:50:06.000000000 -0400
+++ t68/include/asm-i386/mach-summit/mach_apic.h	2003-05-07 11:05:20.000000000 
-0400
@@ -9,9 +9,6 @@ extern int x86_summit;
 #define XAPIC_DEST_CPUS_MASK    0x0Fu
 #define XAPIC_DEST_CLUSTER_MASK 0xF0u
 
-#define xapic_phys_to_log_apicid(phys_apic) ( (1ul << ((phys_apic) & 0x3)) |\
-		((phys_apic) & XAPIC_DEST_CLUSTER_MASK) )
-
 #define APIC_DFR_VALUE	(x86_summit ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
 #define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_online_map)
 
@@ -25,14 +22,31 @@ extern int x86_summit;
 #define check_apicid_present(bit) (x86_summit ? 1 : (phys_cpu_present_map & 
(1 << bit))) 
 
 extern u8 bios_cpu_apicid[];
+extern volatile u8 cpu_2_logical_apicid[];
 
 static inline void init_apic_ldr(void)
 {
 	unsigned long val, id;
 
-	if (x86_summit)
-		id = xapic_phys_to_log_apicid(hard_smp_processor_id());
-	else
+	if (x86_summit) {
+		int i, count;
+		u8 lid;
+		u8 my_id = (u8)hard_smp_processor_id();
+		u8 my_cluster = my_id & XAPIC_DEST_CLUSTER_MASK;
+
+		for (count = 0, i = NR_CPUS; --i >= 0; ) {
+			lid = cpu_2_logical_apicid[i];
+			if (lid == BAD_APICID)
+				continue;
+			if ((lid & 0xF0) == my_cluster)
+				++count;	/* got one */
+		}
+		if (count > 3) {
+			printk("init_apic_ldr: Found %d CPUs in APIC cluster 0x%X! Kludging CPU 
0x%02X...\n", count, my_cluster, my_id);
+			count = 3;
+		}
+		id = my_cluster | (1UL << count);
+	} else
 		id = 1UL << smp_processor_id();
 	apic_write_around(APIC_DFR, APIC_DFR_VALUE);
 	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
@@ -62,7 +76,6 @@ static inline int apicid_to_node(int log
 }
 
 /* Mapping from cpu number to logical apicid */
-extern volatile u8 cpu_2_logical_apicid[];
 static inline int cpu_to_logical_apicid(int cpu)
 {
 	return (int)cpu_2_logical_apicid[cpu];


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267101AbTAOTOu>; Wed, 15 Jan 2003 14:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267102AbTAOTOu>; Wed, 15 Jan 2003 14:14:50 -0500
Received: from franka.aracnet.com ([216.99.193.44]:7055 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267101AbTAOTOr>; Wed, 15 Jan 2003 14:14:47 -0500
Date: Wed, 15 Jan 2003 11:23:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (5/5) Enable Summit in makefile, update summit subarch code
Message-ID: <16390000.1042658617@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the summit subarch hook to the config file, and updates various things
all inside the summit subarch directories (ie this can't possibly break 
anyone else ;-)). The Summit's subarch had got out of sync in a few places.



diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Tue Jan 14 11:03:53 2003
+++ b/arch/i386/Makefile	Tue Jan 14 11:03:53 2003
@@ -69,6 +69,10 @@
 mflags-$(CONFIG_X86_BIGSMP)	:= -Iinclude/asm-i386/mach-bigsmp
 mcore-$(CONFIG_X86_BIGSMP)	:= mach-default
 
+#Summit subarch support
+mflags-$(CONFIG_X86_SUMMIT) := -Iinclude/asm-i386/mach-summit
+mcore-$(CONFIG_X86_SUMMIT)  := mach-default
+
 # default subarch .h files
 mflags-y += -Iinclude/asm-i386/mach-default
 
diff -Nru a/include/asm-i386/mach-summit/mach_apic.h b/include/asm-i386/mach-summit/mach_apic.h
--- a/include/asm-i386/mach-summit/mach_apic.h	Tue Jan 14 11:03:53 2003
+++ b/include/asm-i386/mach-summit/mach_apic.h	Tue Jan 14 11:03:53 2003
@@ -4,6 +4,7 @@
 extern int x86_summit;
 
 #define esr_disable (1)
+#define no_balance_irq (0)
 
 #define XAPIC_DEST_CPUS_MASK    0x0Fu
 #define XAPIC_DEST_CLUSTER_MASK 0xF0u
@@ -11,17 +12,6 @@
 #define xapic_phys_to_log_apicid(phys_apic) ( (1ul << ((phys_apic) & 0x3)) |\
 		((phys_apic) & XAPIC_DEST_CLUSTER_MASK) )
 
-static inline unsigned long calculate_ldr(unsigned long old)
-{
-	unsigned long id;
-
-	if (x86_summit)
-		id = xapic_phys_to_log_apicid(hard_smp_processor_id());
-	else
-		id = 1UL << smp_processor_id();
-	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
-}
-
 #define APIC_DFR_VALUE	(x86_summit ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
 #define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_online_map)
 
@@ -34,6 +24,32 @@
 /* we don't use the phys_cpu_present_map to indicate apicid presence */
 #define check_apicid_present(bit) (1) 
 
+extern u8 bios_cpu_apicid[];
+
+static inline void init_apic_ldr(void)
+{
+	unsigned long val, id;
+
+	if (x86_summit)
+		id = xapic_phys_to_log_apicid(hard_smp_processor_id());
+	else
+		id = 1UL << smp_processor_id();
+	apic_write_around(APIC_DFR, APIC_DFR_VALUE);
+	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
+	val |= SET_APIC_LOGICAL_ID(id);
+	apic_write_around(APIC_LDR, val);
+}
+
+static inline int multi_timer_check(int apic, int irq)
+{
+	return 0;
+}
+
+static inline int apic_id_registered(void)
+{
+	return 1;
+}
+
 static inline void clustered_apic_check(void)
 {
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
@@ -66,12 +82,22 @@
 	return (x86_summit ? 0x0F : phys_map);
 }
 
-static inline unsigned long apicid_to_phys_cpu_present(int apicid)
+static inline unsigned long apicid_to_cpu_present(int apicid)
 {
 	if (x86_summit)
-		return (1ul << (((apicid >> 4) << 2) | (apicid & 0x3)));
+		return 1;
 	else
 		return (1ul << apicid);
+}
+
+static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
+{
+	printk("Processor #%d %ld:%ld APIC version %d\n",
+			m->mpc_apicid,
+			(m->mpc_cpufeature & CPU_FAMILY_MASK) >> 8,
+			(m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
+			m->mpc_apicver);
+	return (m->mpc_apicid);
 }
 
 static inline void setup_portio_remap(void)


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267276AbTANEKW>; Mon, 13 Jan 2003 23:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267442AbTANEKW>; Mon, 13 Jan 2003 23:10:22 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:14531 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S267276AbTANEKR>; Mon, 13 Jan 2003 23:10:17 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD8F2@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Pallipadi, Venkatesh'" <venkatesh.pallipadi@intel.com>,
       torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: RE: [PATCH][2.5.57] Clustered APIC setup for >8 CPU systems [RESE
	ND]
Date: Mon, 13 Jan 2003 22:18:59 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Venkatesh! I will test it for ES7000 right away and let you know of
results.

--Natalie Protasevich
Unisys

-----Original Message-----
From: Pallipadi, Venkatesh [mailto:venkatesh.pallipadi@intel.com]
Sent: Monday, January 13, 2003 9:04 PM
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org; Nakajima, Jun;
Natalie.Protasevich@UNISYS.com
Subject: [PATCH][2.5.57] Clustered APIC setup for >8 CPU systems
[RESEND]



Clustered APIC setup patch. Needed to support generic systems with more than
8 CPUs.

Motivation:
The current APIC destination mode ("Flat Logical") used in linux kernel has
an upper limit of 8 CPUs. For more than 8 CPUs, either "Clustered Logical"
or "Physical" mode has to be used.

The attached patch adds support such systems by organizing them into logical
clusters, with each cluster having 4 CPUs. This is activated by a new config
option "Support for other sub-arch SMP systems with more than 8 CPUs", under
Processor feature->Sub architecture.

The patch is made very simple and isolated, thanks to Martin J. Bligh's
patchsets, which has moved all APIC related functions into sub-arch macros.
Has zero impact on standard systems. 

This patch enables all 16 logical processors on a generic, non-quad based,
system that we have here. Also, by looking at SuSE source, I have also added
a special switch, to specifically support Unisys (ES7000). Just replacing
#define SEQUENTIAL_APICID by CLUSTERED_APICID in the patch should make it
work on ES7000(not tested).

Please apply.

Thanks,
-Venkatesh

diff -urN linux-2.5.54.mod/arch/i386/Kconfig
linux-2.5.54.patch/arch/i386/Kconfig
--- linux-2.5.54.mod/arch/i386/Kconfig	2003-01-07 19:31:50.000000000 -0800
+++ linux-2.5.54.patch/arch/i386/Kconfig	2003-01-08
15:24:30.000000000 -0800
@@ -75,6 +75,14 @@
 
 	  If you don't have one of these computers, you should say N here.
 
+config X86_BIGSMP
+	bool "Support for other sub-arch SMP systems with more than 8 CPUs"
+	help
+	  This option is needed for the systems that have more than 8 CPUs
+	  and if the system is not of any sub-arch type above.
+
+	  If you don't have such a system, you should say N here.
+
 # Visual Workstation support is utterly broken.
 # If you want to see it working mail an VW540 to hch@infradead.org 8)
 #config X86_VISWS
diff -urN linux-2.5.54.mod/arch/i386/Makefile
linux-2.5.54.patch/arch/i386/Makefile
--- linux-2.5.54.mod/arch/i386/Makefile	2003-01-01 19:21:44.000000000 -0800
+++ linux-2.5.54.patch/arch/i386/Makefile	2003-01-08
15:24:30.000000000 -0800
@@ -64,6 +64,10 @@
 mflags-$(CONFIG_X86_NUMAQ)	:= -Iinclude/asm-i386/mach-numaq
 mcore-$(CONFIG_X86_NUMAQ)	:= mach-default
 
+# BIGSMP subarch support
+mflags-$(CONFIG_X86_BIGSMP)	:= -Iinclude/asm-i386/mach-bigsmp
+mcore-$(CONFIG_X86_BIGSMP)	:= mach-default
+
 # default subarch .h files
 mflags-y += -Iinclude/asm-i386/mach-default
 
diff -urN linux-2.5.54.mod/include/asm-i386/mach-bigsmp/mach_apic.h
linux-2.5.54.patch/include/asm-i386/mach-bigsmp/mach_apic.h
--- linux-2.5.54.mod/include/asm-i386/mach-bigsmp/mach_apic.h	1969-12-31
16:00:00.000000000 -0800
+++ linux-2.5.54.patch/include/asm-i386/mach-bigsmp/mach_apic.h	2003-01-08
20:19:26.000000000 -0800
@@ -0,0 +1,106 @@
+#ifndef __ASM_MACH_APIC_H
+#define __ASM_MACH_APIC_H
+
+#define SEQUENTIAL_APICID
+#ifdef SEQUENTIAL_APICID
+#define xapic_phys_to_log_apicid(phys_apic) ( (1ul << ((phys_apic) & 0x3))
|\
+		((phys_apic<<2) & (~0xf)) )
+#elif CLUSTERED_APICID
+#define xapic_phys_to_log_apicid(phys_apic) ( (1ul << ((phys_apic) & 0x3))
|\
+		((phys_apic) & (~0xf)) )
+#endif
+
+#define no_balance_irq (1)
+#define esr_disable (1)
+
+static inline int apic_id_registered(void)
+{
+	        return (1);
+}
+
+#define APIC_DFR_VALUE	(APIC_DFR_CLUSTER)
+#define TARGET_CPUS	((cpu_online_map < 0xf)?cpu_online_map:0xf)
+
+#define APIC_BROADCAST_ID     (0x0f)
+#define check_apicid_used(bitmap, apicid) (0)
+
+static inline unsigned long calculate_ldr(unsigned long old)
+{
+	unsigned long id;
+	id = xapic_phys_to_log_apicid(hard_smp_processor_id());
+	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
+}
+
+/*
+ * Set up the logical destination ID.
+ *
+ * Intel recommends to set DFR, LDR and TPR before enabling
+ * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
+ * document number 292116).  So here it goes...
+ */
+static inline void init_apic_ldr(void)
+{
+	unsigned long val;
+
+	apic_write_around(APIC_DFR, APIC_DFR_VALUE);
+	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
+	val = calculate_ldr(val);
+	apic_write_around(APIC_LDR, val);
+}
+
+static inline void clustered_apic_check(void)
+{
+	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
+		"Cluster", nr_ioapics);
+}
+
+static inline int multi_timer_check(int apic, int irq)
+{
+	return 0;
+}
+
+static inline int apicid_to_node(int logical_apicid)
+{
+	return 0;
+}
+
+extern u8 raw_phys_apicid[];
+
+static inline int cpu_present_to_apicid(int mps_cpu)
+{
+	return (int) raw_phys_apicid[mps_cpu];
+}
+
+static inline unsigned long apicid_to_cpu_present(int phys_apicid)
+{
+	return (1ul << phys_apicid);
+}
+
+static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
+{
+	printk("Processor #%d %ld:%ld APIC version %d\n",
+	        m->mpc_apicid,
+	        (m->mpc_cpufeature & CPU_FAMILY_MASK) >> 8,
+	        (m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
+	        m->mpc_apicver);
+	return (m->mpc_apicid);
+}
+
+static inline ulong ioapic_phys_id_map(ulong phys_map)
+{
+	/* For clustered we don't have a good way to do this yet - hack */
+	return (0x0F);
+}
+
+#define WAKE_SECONDARY_VIA_INIT
+
+static inline void setup_portio_remap(void)
+{
+}
+
+static inline int check_phys_apicid_present(int boot_cpu_physical_apicid)
+{
+	return (1);
+}
+
+#endif /* __ASM_MACH_APIC_H */
diff -urN linux-2.5.54.mod/include/asm-i386/mach-bigsmp/mach_ipi.h
linux-2.5.54.patch/include/asm-i386/mach-bigsmp/mach_ipi.h
--- linux-2.5.54.mod/include/asm-i386/mach-bigsmp/mach_ipi.h	1969-12-31
16:00:00.000000000 -0800
+++ linux-2.5.54.patch/include/asm-i386/mach-bigsmp/mach_ipi.h	2003-01-01
19:21:13.000000000 -0800
@@ -0,0 +1,24 @@
+#ifndef __ASM_MACH_IPI_H
+#define __ASM_MACH_IPI_H
+
+static inline void send_IPI_mask_sequence(int mask, int vector);
+
+static inline void send_IPI_mask(int mask, int vector)
+{
+	send_IPI_mask_sequence(mask, vector);
+}
+
+static inline void send_IPI_allbutself(int vector)
+{
+	unsigned long mask = cpu_online_map & ~(1 << smp_processor_id());
+
+	if (mask)
+		send_IPI_mask(mask, vector);
+}
+
+static inline void send_IPI_all(int vector)
+{
+	send_IPI_mask(cpu_online_map, vector);
+}
+
+#endif /* __ASM_MACH_IPI_H */


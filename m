Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267740AbTATBKK>; Sun, 19 Jan 2003 20:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267745AbTATBKK>; Sun, 19 Jan 2003 20:10:10 -0500
Received: from holomorphy.com ([66.224.33.161]:37000 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267740AbTATBKG>;
	Sun, 19 Jan 2003 20:10:06 -0500
Date: Sun, 19 Jan 2003 17:19:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com
Cc: akpm@zip.com.au
Subject: Re: setup_ioapic_ids_from_mpc()
Message-ID: <20030120011906.GJ780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com,
	akpm@zip.com.au
References: <20030119130118.GC770@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119130118.GC770@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2003 at 05:01:18AM -0800, William Lee Irwin III wrote:
> 100% untested. I'll spin it sometime tomorrow.

This one is tested, and works.


Use NUMA-Q specific MP OEM tables to program the physical APIC ID's of
the IO-APIC's. This fixes boot-time panic()'s on NUMA-Q's in the stock
version of setup_ioapic_ids_from_mpc().

 arch/i386/kernel/io_apic.c                   |   40 ++++++++++++++++++++++++++-
 arch/i386/kernel/mpparse.c                   |    2 +
 include/asm-i386/mach-default/mach_mpparse.h |    5 +++
 include/asm-i386/mach-numaq/mach_mpparse.h   |   19 ++++++++++++
 include/asm-i386/mach-summit/mach_mpparse.h  |    5 +++
 include/asm-i386/mpspec.h                    |    3 ++
 6 files changed, 73 insertions(+), 1 deletion(-)


diff -urpN numaq-2.5.59-virgin/arch/i386/kernel/io_apic.c mpc-2.5.59-1/arch/i386/kernel/io_apic.c
--- numaq-2.5.59-virgin/arch/i386/kernel/io_apic.c	2003-01-19 17:14:25.000000000 -0800
+++ mpc-2.5.59-1/arch/i386/kernel/io_apic.c	2003-01-19 16:41:02.000000000 -0800
@@ -1438,7 +1438,44 @@ void disable_IO_APIC(void)
  * by Matt Domsch <Matt_Domsch@dell.com>  Tue Dec 21 12:25:05 CST 1999
  */
 
-static void __init setup_ioapic_ids_from_mpc (void)
+#ifdef CONFIG_X86_NUMAQ
+static void __init setup_ioapic_ids_from_mpc(void)
+{
+	int io_apic;
+
+	for (io_apic = 0; io_apic < nr_ioapics; ++io_apic) {
+		struct IO_APIC_reg_00 reg;
+		int node, local, global, *regval = (int *)&reg;
+		unsigned long flags;
+
+		global = mp_ioapics[io_apic].mpc_apicid;
+		local = 0;
+		for (node = 0; node < MAX_NUMNODES; ++node) {
+			if (mp_ioapic_id_map[node][0][0] == global)
+				local = mp_ioapic_id_map[node][0][1];
+			else if (mp_ioapic_id_map[node][1][0] == global)
+				local = mp_ioapic_id_map[node][1][1];
+		}
+
+		if (!local) {
+			printk("mystery IO-APIC, it will die\n");
+			continue;
+		}
+
+		
+		spin_lock_irqsave(&ioapic_lock, flags);
+		*regval = io_apic_read(io_apic, 0);
+		mb();				/* b/c regval aliases &reg */
+		if (reg.ID != local) {
+			reg.ID = local;
+			mb();			/* b/c regval aliases &reg */
+			io_apic_write(io_apic, 0, *regval);
+		}
+		spin_unlock_irqrestore(&ioapic_lock, flags);
+	}
+}
+#else /* !CONFIG_X86_NUMAQ */
+static void __init setup_ioapic_ids_from_mpc(void)
 {
 	struct IO_APIC_reg_00 reg_00;
 	unsigned long phys_id_present_map;
@@ -1531,6 +1568,7 @@ static void __init setup_ioapic_ids_from
 			printk(" ok.\n");
 	}
 }
+#endif
 
 /*
  * There is a nasty bug in some older SMP boards, their mptable lies
diff -urpN numaq-2.5.59-virgin/arch/i386/kernel/mpparse.c mpc-2.5.59-1/arch/i386/kernel/mpparse.c
--- numaq-2.5.59-virgin/arch/i386/kernel/mpparse.c	2003-01-19 17:14:25.000000000 -0800
+++ mpc-2.5.59-1/arch/i386/kernel/mpparse.c	2003-01-19 16:38:37.000000000 -0800
@@ -47,6 +47,7 @@ int mp_bus_id_to_node [MAX_MP_BUSSES];
 int mp_bus_id_to_local [MAX_MP_BUSSES];
 int quad_local_to_mp_bus_id [NR_CPUS/4][4];
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
+int mp_ioapic_id_map [MAX_NUMNODES][2][2];
 int mp_current_pci_id;
 
 /* I/O APIC entries */
@@ -232,6 +233,7 @@ static void __init MP_ioapic_info (struc
 		return;
 	}
 	mp_ioapics[nr_ioapics] = *m;
+	mpc_oem_ioapic(m, translation_table[mpc_record]);
 	nr_ioapics++;
 }
 
diff -urpN numaq-2.5.59-virgin/include/asm-i386/mach-default/mach_mpparse.h mpc-2.5.59-1/include/asm-i386/mach-default/mach_mpparse.h
--- numaq-2.5.59-virgin/include/asm-i386/mach-default/mach_mpparse.h	2003-01-16 18:22:39.000000000 -0800
+++ mpc-2.5.59-1/include/asm-i386/mach-default/mach_mpparse.h	2003-01-19 16:29:59.000000000 -0800
@@ -12,6 +12,11 @@ static inline void mpc_oem_pci_bus(struc
 {
 }
 
+static inline void mpc_oem_ioapic(struct mpc_config_ioapic *m, 
+				struct mpc_config_translation *translation)
+{
+}
+
 static inline void mps_oem_check(struct mp_config_table *mpc, char *oem, 
 		char *productid)
 {
diff -urpN numaq-2.5.59-virgin/include/asm-i386/mach-numaq/mach_mpparse.h mpc-2.5.59-1/include/asm-i386/mach-numaq/mach_mpparse.h
--- numaq-2.5.59-virgin/include/asm-i386/mach-numaq/mach_mpparse.h	2003-01-16 18:22:01.000000000 -0800
+++ mpc-2.5.59-1/include/asm-i386/mach-numaq/mach_mpparse.h	2003-01-19 16:36:46.000000000 -0800
@@ -24,6 +24,25 @@ static inline void mpc_oem_pci_bus(struc
 	quad_local_to_mp_bus_id[quad][local] = m->mpc_busid;
 }
 
+static inline void mpc_oem_ioapic(struct mpc_config_ioapic *m, 
+				struct mpc_config_translation *translation)
+{
+	int quad = translation->trans_quad;
+	int local = translation->trans_local;
+	int *info;
+
+	if (!mp_ioapic_id_map[quad][0][0])
+		info = mp_ioapic_id_map[quad][0];
+	else if (!mp_ioapic_id_map[quad][1][0])
+		info = mp_ioapic_id_map[quad][1];
+	else {
+		printk("bad IO-APIC! go to your quad!\n");
+		return;
+	}
+	info[0] = m->mpc_apicid;
+	info[1] = local;
+}
+
 static inline void mps_oem_check(struct mp_config_table *mpc, char *oem, 
 		char *productid)
 {
diff -urpN numaq-2.5.59-virgin/include/asm-i386/mach-summit/mach_mpparse.h mpc-2.5.59-1/include/asm-i386/mach-summit/mach_mpparse.h
--- numaq-2.5.59-virgin/include/asm-i386/mach-summit/mach_mpparse.h	2003-01-16 18:22:05.000000000 -0800
+++ mpc-2.5.59-1/include/asm-i386/mach-summit/mach_mpparse.h	2003-01-19 16:29:59.000000000 -0800
@@ -12,6 +12,11 @@ static inline void mpc_oem_pci_bus(struc
 {
 }
 
+static inline void mpc_oem_ioapic(struct mpc_config_ioapic *m, 
+				struct mpc_config_translation *translation)
+{
+}
+
 static inline void mps_oem_check(struct mp_config_table *mpc, char *oem, 
 		char *productid)
 {
diff -urpN numaq-2.5.59-virgin/include/asm-i386/mpspec.h mpc-2.5.59-1/include/asm-i386/mpspec.h
--- numaq-2.5.59-virgin/include/asm-i386/mpspec.h	2003-01-16 18:21:33.000000000 -0800
+++ mpc-2.5.59-1/include/asm-i386/mpspec.h	2003-01-19 16:34:43.000000000 -0800
@@ -1,6 +1,8 @@
 #ifndef __ASM_MPSPEC_H
 #define __ASM_MPSPEC_H
 
+#include <asm/numnodes.h>
+
 /*
  * Structure definitions for SMP machines following the
  * Intel Multiprocessing Specification 1.1 and 1.4.
@@ -204,6 +206,7 @@ extern int mp_bus_id_to_node [MAX_MP_BUS
 extern int mp_bus_id_to_local [MAX_MP_BUSSES];
 extern int quad_local_to_mp_bus_id [NR_CPUS/4][4];
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
+extern int mp_ioapic_id_map [MAX_NUMNODES][2][2];
 
 extern unsigned int boot_cpu_physical_apicid;
 extern unsigned long phys_cpu_present_map;

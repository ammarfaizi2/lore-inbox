Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbTASNUy>; Sun, 19 Jan 2003 08:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbTASNUy>; Sun, 19 Jan 2003 08:20:54 -0500
Received: from holomorphy.com ([66.224.33.161]:51334 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262813AbTASNUu>;
	Sun, 19 Jan 2003 08:20:50 -0500
Date: Sun, 19 Jan 2003 05:29:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com
Subject: Re: setup_ioapic_ids_from_mpc()
Message-ID: <20030119132951.GG780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com
References: <20030119130118.GC770@holomorphy.com> <20030119131556.GF780@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119131556.GF780@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2003 at 05:01:18AM -0800, William Lee Irwin III wrote:
>> 100% untested. I'll spin it sometime tomorrow.

On Sun, Jan 19, 2003 at 05:15:56AM -0800, William Lee Irwin III wrote:
> Take 2: I eyeballed a couple bogosities.

Take 3: flags undeclared, regval/reg aliasing might need barriers; speed
is not an issue at boot-time, so slap down the heaviest barrier imaginable.



===== arch/i386/kernel/io_apic.c 1.40 vs edited =====
--- 1.40/arch/i386/kernel/io_apic.c	Tue Jan 14 03:02:28 2003
+++ edited/arch/i386/kernel/io_apic.c	Sun Jan 19 05:27:35 2003
@@ -1132,7 +1132,44 @@
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
+		global = mp_ioapics[apic].mpc_apicid;
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
@@ -1225,6 +1262,7 @@
 			printk(" ok.\n");
 	}
 }
+#endif
 
 /*
  * There is a nasty bug in some older SMP boards, their mptable lies
===== arch/i386/kernel/mpparse.c 1.32 vs edited =====
--- 1.32/arch/i386/kernel/mpparse.c	Mon Jan 13 16:41:17 2003
+++ edited/arch/i386/kernel/mpparse.c	Sun Jan 19 04:19:09 2003
@@ -47,6 +47,7 @@
 int mp_bus_id_to_local [MAX_MP_BUSSES];
 int quad_local_to_mp_bus_id [NR_CPUS/4][4];
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
+int mp_ioapic_id_map [MAX_NUMNODES][2][2];
 int mp_current_pci_id;
 
 /* I/O APIC entries */
@@ -232,6 +233,7 @@
 		return;
 	}
 	mp_ioapics[nr_ioapics] = *m;
+	mpc_oem_ioapic(m, str, translation_table[mpc_record]);
 	nr_ioapics++;
 }
 
===== include/asm-i386/mpspec.h 1.11 vs edited =====
--- 1.11/include/asm-i386/mpspec.h	Tue Jan 14 03:02:28 2003
+++ edited/include/asm-i386/mpspec.h	Sun Jan 19 04:40:31 2003
@@ -204,6 +204,7 @@
 extern int mp_bus_id_to_local [MAX_MP_BUSSES];
 extern int quad_local_to_mp_bus_id [NR_CPUS/4][4];
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
+extern int mp_ioapic_id_map [MAX_NUMNODES][2][2];
 
 extern unsigned int boot_cpu_physical_apicid;
 extern unsigned long phys_cpu_present_map;
===== include/asm-i386/mach-default/mach_mpparse.h 1.2 vs edited =====
--- 1.2/include/asm-i386/mach-default/mach_mpparse.h	Mon Jan 13 16:41:17 2003
+++ edited/include/asm-i386/mach-default/mach_mpparse.h	Sun Jan 19 04:26:45 2003
@@ -12,6 +12,11 @@
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
===== include/asm-i386/mach-numaq/mach_mpparse.h 1.4 vs edited =====
--- 1.4/include/asm-i386/mach-numaq/mach_mpparse.h	Mon Jan 13 16:41:17 2003
+++ edited/include/asm-i386/mach-numaq/mach_mpparse.h	Sun Jan 19 04:57:29 2003
@@ -24,6 +24,25 @@
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
+	info[0] = global;
+	info[1] = local;
+}
+
 static inline void mps_oem_check(struct mp_config_table *mpc, char *oem, 
 		char *productid)
 {
===== include/asm-i386/mach-summit/mach_mpparse.h 1.3 vs edited =====
--- 1.3/include/asm-i386/mach-summit/mach_mpparse.h	Tue Jan 14 03:02:28 2003
+++ edited/include/asm-i386/mach-summit/mach_mpparse.h	Sun Jan 19 04:30:32 2003
@@ -12,6 +12,11 @@
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

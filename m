Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266972AbTAOTKH>; Wed, 15 Jan 2003 14:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbTAOTKH>; Wed, 15 Jan 2003 14:10:07 -0500
Received: from franka.aracnet.com ([216.99.193.44]:27786 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266972AbTAOTJy>; Wed, 15 Jan 2003 14:09:54 -0500
Date: Wed, 15 Jan 2003 11:18:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (2/5) Add ACPI hook, rename raw_phys_apicid to bios_cpu_apicid
Message-ID: <11640000.1042658324@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from James Cleverdon & John Stultz

This adds machine a type detection hook to the acpi code, and renames
raw_phys_apicid to bios_cpu_apicid (it's an array of apicid's to boot,
indexed by the bios' cpu numbering), and I other large machines will
need to use it later ... not necessarily using physical interrupts.

diff -Nru a/arch/i386/kernel/acpi.c b/arch/i386/kernel/acpi.c
--- a/arch/i386/kernel/acpi.c	Tue Jan 14 00:41:17 2003
+++ b/arch/i386/kernel/acpi.c	Tue Jan 14 00:41:17 2003
@@ -44,6 +44,8 @@
 #include <asm/io_apic.h>
 #include <asm/tlbflush.h>
 
+#include <mach_apic.h>
+#include <mach_mpparse.h>
 
 #define PREFIX			"ACPI: "
 
@@ -126,6 +128,8 @@
 	printk(KERN_INFO PREFIX "Local APIC address 0x%08x\n",
 		madt->lapic_address);
 
+	acpi_madt_oem_check(madt->header.oem_id, madt->header.oem_table_id);
+	
 	return 0;
 }
 
@@ -430,8 +434,10 @@
 #endif /*CONFIG_X86_IO_APIC*/
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	if (acpi_lapic && acpi_ioapic)
+	if (acpi_lapic && acpi_ioapic) {
 		smp_found_config = 1;
+		clustered_apic_check();
+	}
 #endif
 
 	return 0;
diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Tue Jan 14 00:41:17 2003
+++ b/arch/i386/kernel/mpparse.c	Tue Jan 14 00:41:17 2003
@@ -72,8 +72,8 @@
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;
 
-int summit_x86 = 0;
-u8 raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
+int x86_summit = 0;
+u8 bios_cpu_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
 /*
  * Intel MP BIOS table parsing routines:
@@ -186,7 +186,7 @@
 		ver = 0x10;
 	}
 	apic_version[m->mpc_apicid] = ver;
-	raw_phys_apicid[num_processors - 1] = m->mpc_apicid;
+	bios_cpu_apicid[num_processors - 1] = m->mpc_apicid;
 }
 
 static void __init MP_bus_info (struct mpc_config_bus *m)
diff -Nru a/include/asm-i386/mach-bigsmp/mach_apic.h b/include/asm-i386/mach-bigsmp/mach_apic.h
--- a/include/asm-i386/mach-bigsmp/mach_apic.h	Tue Jan 14 00:41:17 2003
+++ b/include/asm-i386/mach-bigsmp/mach_apic.h	Tue Jan 14 00:41:17 2003
@@ -67,11 +67,11 @@
 	return 0;
 }
 
-extern u8 raw_phys_apicid[];
+extern u8 bios_cpu_apicid[];
 
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
-	return (int) raw_phys_apicid[mps_cpu];
+	return (int) bios_cpu_apicid[mps_cpu];
 }
 
 static inline unsigned long apicid_to_cpu_present(int phys_apicid)
diff -Nru a/include/asm-i386/mach-default/mach_mpparse.h b/include/asm-i386/mach-default/mach_mpparse.h
--- a/include/asm-i386/mach-default/mach_mpparse.h	Tue Jan 14 00:41:17 2003
+++ b/include/asm-i386/mach-default/mach_mpparse.h	Tue Jan 14 00:41:17 2003
@@ -17,4 +17,10 @@
 {
 }
 
+/* Hook from generic ACPI tables.c */
+static inline void acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+}
+
+
 #endif /* __ASM_MACH_MPPARSE_H */
diff -Nru a/include/asm-i386/mach-numaq/mach_mpparse.h b/include/asm-i386/mach-numaq/mach_mpparse.h
--- a/include/asm-i386/mach-numaq/mach_mpparse.h	Tue Jan 14 00:41:17 2003
+++ b/include/asm-i386/mach-numaq/mach_mpparse.h	Tue Jan 14 00:41:17 2003
@@ -34,4 +34,9 @@
 				mpc->mpc_oemsize);
 }
 
+/* Hook from generic ACPI tables.c */
+static inline void acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+}
+
 #endif /* __ASM_MACH_MPPARSE_H */
diff -Nru a/include/asm-i386/mach-summit/mach_apic.h b/include/asm-i386/mach-summit/mach_apic.h
--- a/include/asm-i386/mach-summit/mach_apic.h	Tue Jan 14 00:41:17 2003
+++ b/include/asm-i386/mach-summit/mach_apic.h	Tue Jan 14 00:41:17 2003
@@ -45,7 +45,7 @@
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
 	if (x86_summit)
-		return (int) raw_phys_apicid[mps_cpu];
+		return (int) bios_cpu_apicid[mps_cpu];
 	else
 		return mps_cpu;
 }
diff -Nru a/include/asm-i386/mach-summit/mach_mpparse.h b/include/asm-i386/mach-summit/mach_mpparse.h
--- a/include/asm-i386/mach-summit/mach_mpparse.h	Tue Jan 14 00:41:17 2003
+++ b/include/asm-i386/mach-summit/mach_mpparse.h	Tue Jan 14 00:41:17 2003
@@ -19,4 +19,10 @@
 		x86_summit = 1;
 }
 
+/* Hook from generic ACPI tables.c */
+static inline void acpi_madt_oem_check(char *oem_id, char *oem_table_id)
+{
+	if (!strncmp(oem_id, "IBM", 3) && !strncmp(oem_table_id, "SERVIGIL", 8))
+		x86_summit = 1;
+}
 #endif /* __ASM_MACH_MPPARSE_H */


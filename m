Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267586AbSLMBeH>; Thu, 12 Dec 2002 20:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267587AbSLMBeG>; Thu, 12 Dec 2002 20:34:06 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:29902
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267586AbSLMBdb>; Thu, 12 Dec 2002 20:33:31 -0500
Date: Thu, 12 Dec 2002 20:44:03 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Martin Bligh <mbligh@us.ibm.com>
cc: James Cleverdon <jamesclv@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
Message-ID: <Pine.LNX.4.50.0212112105490.14901-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I've got an 32x SMP system which has an xAPIC but utilises flat
addressing. This patch is to rename what was formerly x86_summit to
x86_xapic (just to avoid confusion) and then select mask depending on
that.

Untested/uncompiled patch

Index: linux-2.5.51/include/asm-i386/apic.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.51/include/asm-i386/apic.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 apic.h
--- linux-2.5.51/include/asm-i386/apic.h	10 Dec 2002 12:47:44 -0000	1.1.1.1
+++ linux-2.5.51/include/asm-i386/apic.h	12 Dec 2002 17:10:51 -0000
@@ -90,6 +90,7 @@
 extern int check_nmi_watchdog (void);
 extern void enable_NMI_through_LVT0 (void * dummy);

+extern int x86_xapic;
 extern unsigned int nmi_watchdog;
 #define NMI_NONE	0
 #define NMI_IO_APIC	1
Index: linux-2.5.51/include/asm-i386/apicdef.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.51/include/asm-i386/apicdef.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 apicdef.h
--- linux-2.5.51/include/asm-i386/apicdef.h	10 Dec 2002 12:47:44 -0000	1.1.1.1
+++ linux-2.5.51/include/asm-i386/apicdef.h	12 Dec 2002 03:22:59 -0000
@@ -9,10 +9,11 @@
  */

 #define		APIC_DEFAULT_PHYS_BASE	0xfee00000
-
+extern int x86_xapic;
+#define		APIC_BROADCAST_ID     (x86_xapic ? 0xFF : 0x0F)
 #define		APIC_ID		0x20
-#define			APIC_ID_MASK		(0x0F<<24)
-#define			GET_APIC_ID(x)		(((x)>>24)&0x0F)
+#define			APIC_ID_MASK		(APIC_BROADCAST_ID<<24)
+#define			GET_APIC_ID(x)		(((x)>>24)&APIC_BROADCAST_ID)
 #define		APIC_LVR	0x30
 #define			APIC_LVR_MASK		0xFF00FF
 #define			GET_APIC_VERSION(x)	((x)&0xFF)
Index: linux-2.5.51/arch/i386/kernel/apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.51/arch/i386/kernel/apic.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 apic.c
--- linux-2.5.51/arch/i386/kernel/apic.c	10 Dec 2002 12:46:46 -0000	1.1.1.1
+++ linux-2.5.51/arch/i386/kernel/apic.c	12 Dec 2002 17:08:26 -0000
@@ -33,6 +33,8 @@
 #include <asm/arch_hooks.h>
 #include "mach_apic.h"

+int x86_xapic;
+
 void __init apic_intr_init(void)
 {
 #ifdef CONFIG_SMP
Index: linux-2.5.51/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.51/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 io_apic.c
--- linux-2.5.51/arch/i386/kernel/io_apic.c	10 Dec 2002 12:46:46 -0000	1.1.1.1
+++ linux-2.5.51/arch/i386/kernel/io_apic.c	12 Dec 2002 16:08:04 -0000
@@ -1147,7 +1147,7 @@

 	if (clustered_apic_mode)
 		/* We don't have a good way to do this yet - hack */
-		phys_id_present_map = (u_long) 0xf;
+		phys_id_present_map = (u_long) APIC_BROADCAST_ID;
 	/*
 	 * Set the IOAPIC ID to the value stored in the MPC table.
 	 */
@@ -1177,10 +1177,10 @@
 					mp_ioapics[apic].mpc_apicid)) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
-			for (i = 0; i < 0xf; i++)
+			for (i = 0; i < APIC_BROADCAST_ID; i++)
 				if (!(phys_id_present_map & (1 << i)))
 					break;
-			if (i >= 0xf)
+			if (i >= APIC_BROADCAST_ID)
 				panic("Max APIC ID exceeded!\n");
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
 				i);
Index: linux-2.5.51/arch/i386/kernel/mpparse.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.51/arch/i386/kernel/mpparse.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mpparse.c
--- linux-2.5.51/arch/i386/kernel/mpparse.c	10 Dec 2002 12:46:46 -0000	1.1.1.1
+++ linux-2.5.51/arch/i386/kernel/mpparse.c	12 Dec 2002 17:07:39 -0000
@@ -67,10 +67,9 @@
 /* Internal processor count */
 static unsigned int __initdata num_processors;

-/* Bitmask of physically existing CPUs */
+/* Bitmask of physically present CPUs and IOAPICs */
 unsigned long phys_cpu_present_map;

-int summit_x86 = 0;
 u8 raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };

 /*
@@ -394,7 +393,7 @@
 	str[12]=0;
 	printk("Product ID: %s ",str);

-	summit_check(oem, str);
+	smp_hardware_check(oem, str);

 	printk("APIC at: 0x%lX\n",mpc->mpc_lapic);

Index: linux-2.5.51/arch/i386/mach-generic/mach_apic.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.51/arch/i386/mach-generic/mach_apic.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mach_apic.h
--- linux-2.5.51/arch/i386/mach-generic/mach_apic.h	10 Dec 2002 12:46:46 -0000	1.1.1.1
+++ linux-2.5.51/arch/i386/mach-generic/mach_apic.h	12 Dec 2002 03:49:07 -0000
@@ -17,11 +17,15 @@
  #define TARGET_CPUS 0x01
 #endif

-#define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))

-static inline void summit_check(char *oem, char *productid)
+static inline void smp_hardware_check(char *oem, char *productid)
 {
+	unsigned long ver, reg = apic_read(APIC_LVR);
+
+	ver = GET_APIC_VERSION(reg);
+	if (ver == 0x14)
+		x86_xapic = 1;
 }

 static inline void clustered_apic_check(void)
Index: linux-2.5.51/arch/i386/mach-summit/mach_apic.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.51/arch/i386/mach-summit/mach_apic.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 mach_apic.h
--- linux-2.5.51/arch/i386/mach-summit/mach_apic.h	10 Dec 2002 12:46:46 -0000	1.1.1.1
+++ linux-2.5.51/arch/i386/mach-summit/mach_apic.h	12 Dec 2002 03:49:20 -0000
@@ -1,8 +1,6 @@
 #ifndef __ASM_MACH_APIC_H
 #define __ASM_MACH_APIC_H

-extern int x86_summit;
-
 #define XAPIC_DEST_CPUS_MASK    0x0Fu
 #define XAPIC_DEST_CLUSTER_MASK 0xF0u

@@ -13,34 +11,33 @@
 {
 	unsigned long id;

-	if (x86_summit)
+	if (x86_xapic)
 		id = xapic_phys_to_log_apicid(hard_smp_processor_id());
 	else
 		id = 1UL << smp_processor_id();
 	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
 }

-#define APIC_DFR_VALUE	(x86_summit ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
-#define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_online_map)
+#define APIC_DFR_VALUE	(x86_xapic ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
+#define TARGET_CPUS	(x86_xapic ? XAPIC_DEST_CPUS_MASK : cpu_online_map)

-#define APIC_BROADCAST_ID     (x86_summit ? 0xFF : 0x0F)
 #define check_apicid_used(bitmap, apicid) (0)

-static inline void summit_check(char *oem, char *productid)
+static inline void smp_hardware_check(char *oem, char *productid)
 {
 	if (!strncmp(oem, "IBM ENSW", 8) && !strncmp(str, "VIGIL SMP", 9))
-		x86_summit = 1;
+		x86_xapic = 1;
 }

 static inline void clustered_apic_check(void)
 {
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
-		(x86_summit ? "Summit" : "Flat"), nr_ioapics);
+		(x86_xapic ? "Summit" : "Flat"), nr_ioapics);
 }

 static inline int cpu_present_to_apicid(int mps_cpu)
 {
-	if (x86_summit)
+	if (x86_xapic)
 		return (int) raw_phys_apicid[mps_cpu];
 	else
 		return mps_cpu;
@@ -48,7 +45,7 @@

 static inline unsigned long apicid_to_phys_cpu_present(int apicid)
 {
-	if (x86_summit)
+	if (x86_xapic)
 		return (1ul << (((apicid >> 4) << 2) | (apicid & 0x3)));
 	else
 		return (1ul << apicid);

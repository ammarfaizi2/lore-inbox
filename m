Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262381AbSJNW0W>; Mon, 14 Oct 2002 18:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262390AbSJNW0W>; Mon, 14 Oct 2002 18:26:22 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:60615 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262381AbSJNW0T>; Mon, 14 Oct 2002 18:26:19 -0400
Date: Mon, 14 Oct 2002 15:27:46 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Summit support for 2.5 - now with subarch! [3/5]
Message-ID: <77190000.1034634466@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one sets up the apic broadcast id (the maximum allowable apic address)
properly for whichever platform. It also abstracts out check_apicid_used,
because that check doesn't work on Summit. Oh, and I bumped up 
MAX_IO_APICS, but only for NUMA x86 platforms.

diff -purN -X /home/mbligh/.diff.exclude subarch-2/arch/i386/kernel/io_apic.c subarch-3/arch/i386/kernel/io_apic.c
--- subarch-2/arch/i386/kernel/io_apic.c	Mon Oct 14 10:59:11 2002
+++ subarch-3/arch/i386/kernel/io_apic.c	Mon Oct 14 11:00:19 2002
@@ -1152,7 +1152,7 @@ static void __init setup_ioapic_ids_from
 		
 		old_id = mp_ioapics[apic].mpc_apicid;
 
-		if (mp_ioapics[apic].mpc_apicid >= 0xf) {
+		if (mp_ioapics[apic].mpc_apicid >= APIC_BROADCAST_ID) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC table!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
@@ -1165,7 +1165,8 @@ static void __init setup_ioapic_ids_from
 		 * system must have a unique ID or we get lots of nice
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
 		 */
-		if (phys_id_present_map & (1 << mp_ioapics[apic].mpc_apicid)) {
+		if (check_apicid_used(phys_id_present_map,
+					mp_ioapics[apic].mpc_apicid)) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			for (i = 0; i < 0xf; i++)
diff -purN -X /home/mbligh/.diff.exclude subarch-2/arch/i386/mach-generic/mach_apic.h subarch-3/arch/i386/mach-generic/mach_apic.h
--- subarch-2/arch/i386/mach-generic/mach_apic.h	Mon Oct 14 10:59:14 2002
+++ subarch-3/arch/i386/mach-generic/mach_apic.h	Mon Oct 14 11:00:46 2002
@@ -17,4 +17,7 @@ static inline unsigned long calculate_ld
  #define TARGET_CPUS 0x01
 #endif
 
+#define APIC_BROADCAST_ID      0x0F
+#define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
+
 #endif /* __ASM_MACH_APIC_H */
diff -purN -X /home/mbligh/.diff.exclude subarch-2/arch/i386/mach-summit/mach_apic.h subarch-3/arch/i386/mach-summit/mach_apic.h
--- subarch-2/arch/i386/mach-summit/mach_apic.h	Mon Oct 14 10:59:14 2002
+++ subarch-3/arch/i386/mach-summit/mach_apic.h	Mon Oct 14 11:01:00 2002
@@ -23,4 +23,7 @@ static inline unsigned long calculate_ld
 #define APIC_DFR_VALUE	(x86_summit ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
 #define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK : cpu_online_map)
 
+#define APIC_BROADCAST_ID     (x86_summit ? 0xFF : 0x0F)
+#define check_apicid_used(bitmap, apicid) (0)
+
 #endif /* __ASM_MACH_APIC_H */
diff -purN -X /home/mbligh/.diff.exclude subarch-2/include/asm-i386/apicdef.h subarch-3/include/asm-i386/apicdef.h
--- subarch-2/include/asm-i386/apicdef.h	Mon Oct 14 10:59:14 2002
+++ subarch-3/include/asm-i386/apicdef.h	Mon Oct 14 11:02:38 2002
@@ -110,7 +110,11 @@
 
 #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
 
-#define MAX_IO_APICS 8
+#ifdef CONFIG_X86_NUMA
+ #define MAX_IO_APICS 32
+#else
+ #define MAX_IO_APICS 8
+#endif
 
 /*
  * the local APIC register structure, memory mapped. Not terribly well


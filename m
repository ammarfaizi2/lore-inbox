Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267487AbTAGUdO>; Tue, 7 Jan 2003 15:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267489AbTAGUdC>; Tue, 7 Jan 2003 15:33:02 -0500
Received: from franka.aracnet.com ([216.99.193.44]:6349 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267487AbTAGUbE>; Tue, 7 Jan 2003 15:31:04 -0500
Date: Tue, 07 Jan 2003 12:34:12 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (7/7) nuke clustered_apic_mode and friends
Message-ID: <603700000.1041971652@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, the grand finale ... NUMA-Q is now moved into subarch, so we can
kill off the last vestiges - CONFIG_CLUSTERED_APIC, clustered_apic_mode,
and smpboot.h (which only contains machine specific stuff now anyway).
the esr_disable switch was the last bit, that goes to subarch too.

If you end up with an empty smpboot.h due to patch / bitkeeper interactions,
please remove it after this ...

diff -urpN -X /home/fletch/.diff.exclude 06-smpboot_cam/arch/i386/Kconfig 07-nuke_clustered_apic/arch/i386/Kconfig
--- 06-smpboot_cam/arch/i386/Kconfig	Thu Jan  2 22:04:58 2003
+++ 07-nuke_clustered_apic/arch/i386/Kconfig	Tue Jan  7 11:11:19 2003
@@ -456,11 +456,6 @@ config NR_CPUS
 	  This is purely to save memory - each supported CPU adds
 	  approximately eight kilobytes to the kernel image.

-config CLUSTERED_APIC
-	bool
-	depends on X86_NUMAQ || X86_SUMMIT
-	default y
-
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation Support"
diff -urpN -X /home/fletch/.diff.exclude 06-smpboot_cam/arch/i386/kernel/smp.c 07-nuke_clustered_apic/arch/i386/kernel/smp.c
--- 06-smpboot_cam/arch/i386/kernel/smp.c	Thu Jan  2 22:04:58 2003
+++ 07-nuke_clustered_apic/arch/i386/kernel/smp.c	Tue Jan  7 11:11:19 2003
@@ -23,7 +23,6 @@
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-#include <asm/smpboot.h>
 #include <mach_ipi.h>

 /*
diff -urpN -X /home/fletch/.diff.exclude 06-smpboot_cam/arch/i386/kernel/smpboot.c 07-nuke_clustered_apic/arch/i386/kernel/smpboot.c
--- 06-smpboot_cam/arch/i386/kernel/smpboot.c	Tue Jan  7 10:32:41 2003
+++ 07-nuke_clustered_apic/arch/i386/kernel/smpboot.c	Tue Jan  7 11:11:19 2003
@@ -47,7 +47,6 @@
 #include <linux/mc146818rtc.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-#include <asm/smpboot.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
 #include "smpboot_hooks.h"
diff -urpN -X /home/fletch/.diff.exclude 06-smpboot_cam/arch/i386/mach-voyager/voyager_smp.c 07-nuke_clustered_apic/arch/i386/mach-voyager/voyager_smp.c
--- 06-smpboot_cam/arch/i386/mach-voyager/voyager_smp.c	Thu Jan  2 22:04:58 2003
+++ 07-nuke_clustered_apic/arch/i386/mach-voyager/voyager_smp.c	Tue Jan  7 11:11:19 2003
@@ -28,7 +28,6 @@
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-#include <asm/smpboot.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>

diff -urpN -X /home/fletch/.diff.exclude 06-smpboot_cam/arch/i386/pci/numa.c 07-nuke_clustered_apic/arch/i386/pci/numa.c
--- 06-smpboot_cam/arch/i386/pci/numa.c	Sun Nov 17 20:29:27 2002
+++ 07-nuke_clustered_apic/arch/i386/pci/numa.c	Tue Jan  7 11:11:19 2003
@@ -127,7 +127,7 @@ static int __init pci_numa_init(void)
 		return 0;

 	pci_root_bus = pcibios_scan_root(0);
-	if (clustered_apic_mode && (numnodes > 1)) {
+	if (numnodes > 1) {
 		for (quad = 1; quad < numnodes; ++quad) {
 			printk("Scanning PCI bus %d for quad %d\n",
 				QUADLOCAL2BUS(quad,0), quad);
diff -urpN -X /home/fletch/.diff.exclude 06-smpboot_cam/include/asm-i386/mach-default/mach_apic.h 07-nuke_clustered_apic/include/asm-i386/mach-default/mach_apic.h
--- 06-smpboot_cam/include/asm-i386/mach-default/mach_apic.h	Tue Jan  7 09:30:08 2003
+++ 07-nuke_clustered_apic/include/asm-i386/mach-default/mach_apic.h	Tue Jan  7 11:11:19 2003
@@ -10,6 +10,7 @@
 #endif

 #define no_balance_irq (0)
+#define esr_disable (0)

 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
diff -urpN -X /home/fletch/.diff.exclude 06-smpboot_cam/include/asm-i386/mach-numaq/mach_apic.h 07-nuke_clustered_apic/include/asm-i386/mach-numaq/mach_apic.h
--- 06-smpboot_cam/include/asm-i386/mach-numaq/mach_apic.h	Tue Jan  7 09:30:08 2003
+++ 07-nuke_clustered_apic/include/asm-i386/mach-numaq/mach_apic.h	Tue Jan  7 11:11:19 2003
@@ -6,6 +6,7 @@
 #define TARGET_CPUS (0xf)

 #define no_balance_irq (1)
+#define esr_disable (1)

 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) ((bitmap) & (1 << (apicid)))
diff -urpN -X /home/fletch/.diff.exclude 06-smpboot_cam/include/asm-i386/mach-summit/mach_apic.h 07-nuke_clustered_apic/include/asm-i386/mach-summit/mach_apic.h
--- 06-smpboot_cam/include/asm-i386/mach-summit/mach_apic.h	Tue Jan  7 09:30:08 2003
+++ 07-nuke_clustered_apic/include/asm-i386/mach-summit/mach_apic.h	Tue Jan  7 11:11:19 2003
@@ -3,6 +3,8 @@

 extern int x86_summit;

+#define esr_disable (1)
+
 #define XAPIC_DEST_CPUS_MASK    0x0Fu
 #define XAPIC_DEST_CLUSTER_MASK 0xF0u

diff -urpN -X /home/fletch/.diff.exclude 06-smpboot_cam/include/asm-i386/numaq.h 07-nuke_clustered_apic/include/asm-i386/numaq.h
--- 06-smpboot_cam/include/asm-i386/numaq.h	Sun Nov 17 20:29:46 2002
+++ 07-nuke_clustered_apic/include/asm-i386/numaq.h	Tue Jan  7 11:11:19 2003
@@ -28,8 +28,6 @@

 #ifdef CONFIG_X86_NUMAQ

-#include <asm/smpboot.h>
-
 /*
  * for now assume that 64Gb is max amount of RAM for whole system
  *    64Gb / 4096bytes/page = 16777216 pages
diff -urpN -X /home/fletch/.diff.exclude 06-smpboot_cam/include/asm-i386/smp.h 07-nuke_clustered_apic/include/asm-i386/smp.h
--- 06-smpboot_cam/include/asm-i386/smp.h	Tue Jan  7 09:27:26 2003
+++ 07-nuke_clustered_apic/include/asm-i386/smp.h	Tue Jan  7 11:11:19 2003
@@ -28,16 +28,6 @@
  #define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
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
-
 #define BAD_APICID 0xFFu
 #ifdef CONFIG_SMP
 #ifndef __ASSEMBLY__
diff -urpN -X /home/fletch/.diff.exclude 06-smpboot_cam/include/asm-i386/smpboot.h 07-nuke_clustered_apic/include/asm-i386/smpboot.h
--- 06-smpboot_cam/include/asm-i386/smpboot.h	Tue Jan  7 09:30:49 2003
+++ 07-nuke_clustered_apic/include/asm-i386/smpboot.h	Wed Dec 31 16:00:00 1969
@@ -1,12 +0,0 @@
-#ifndef __ASM_SMPBOOT_H
-#define __ASM_SMPBOOT_H
-
-#ifndef clustered_apic_mode
- #ifdef CONFIG_CLUSTERED_APIC
-  #define clustered_apic_mode (1)
- #else /* !CONFIG_CLUSTERED_APIC */
-  #define clustered_apic_mode (0)
- #endif /* CONFIG_CLUSTERED_APIC */
-#endif
-
-#endif


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWCMSKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWCMSKU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWCMSKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:10:19 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:61964 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932287AbWCMSKQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:10:16 -0500
Date: Mon, 13 Mar 2006 10:09:54 -0800
Message-Id: <200603131809.k2DI9slZ005727@zach-dev.vmware.com>
Subject: [RFC, PATCH 14/24] i386 Vmi reboot fixes
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 13 Mar 2006 18:09:54.0466 (UTC) FILETIME=[54612020:01C646C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix reboot to work with the  VMI.  We must support fallback to the standard
BIOS reboot mechanism.  Turns out that this is required by kexec, and a good
idea for native hardware.  We simply insert the NOP VMI reboot hook before
calling the BIOS reboot.  While here, fix SMP reboot issues as well.  The
problem is the halt() macro in VMI has been defined to be equivalent to
safe_halt(), which enables interrupts.  Several call sites actually want to
disable interrupts and shutdown the processor, which is what VMI_Shutdown()
does.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/arch/i386/kernel/crash.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/crash.c	2006-03-08 11:34:53.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/crash.c	2006-03-08 11:38:09.000000000 -0800
@@ -113,7 +113,7 @@ static int crash_nmi_callback(struct pt_
 	disable_local_APIC();
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
-	halt();
+	shutdown_halt();
 	for(;;);
 
 	return 1;
Index: linux-2.6.16-rc5/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/process.c	2006-03-08 11:38:06.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/process.c	2006-03-08 11:38:09.000000000 -0800
@@ -156,7 +156,7 @@ static inline void play_dead(void)
 	 */
 	local_irq_disable();
 	while (1)
-		halt();
+		shutdown_halt();
 }
 #else
 static inline void play_dead(void)
Index: linux-2.6.16-rc5/arch/i386/kernel/reboot.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/reboot.c	2006-03-08 11:34:53.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/reboot.c	2006-03-08 11:38:09.000000000 -0800
@@ -146,14 +146,10 @@ real_mode_gdt_entries [3] =
 	0x000092000100ffffULL	/* 16-bit real-mode 64k data at 0x00000100 */
 };
 
-static struct
-{
-	unsigned short       size __attribute__ ((packed));
-	unsigned long long * base __attribute__ ((packed));
-}
-real_mode_gdt = { sizeof (real_mode_gdt_entries) - 1, real_mode_gdt_entries },
-real_mode_idt = { 0x3ff, NULL },
-no_idt = { 0, NULL };
+static struct Xgt_desc_struct
+real_mode_gdt = { sizeof (real_mode_gdt_entries) - 1, (unsigned long)real_mode_gdt_entries },
+real_mode_idt = { 0x3ff, 0 },
+no_idt = { 0, 0 };
 
 
 /* This is 16-bit protected mode code to disable paging and the cache,
@@ -322,6 +318,9 @@ void machine_shutdown(void)
 
 void machine_emergency_restart(void)
 {
+#ifdef CONFIG_X86_VMI
+	vmi_reboot(!reboot_thru_bios);
+#endif
 	if (!reboot_thru_bios) {
 		if (efi_enabled) {
 			efi.reset_system(EFI_RESET_COLD, EFI_SUCCESS, 0, NULL);
@@ -352,6 +351,7 @@ void machine_restart(char * __unused)
 
 void machine_halt(void)
 {
+	shutdown_halt();
 }
 
 void machine_power_off(void)
Index: linux-2.6.16-rc5/arch/i386/kernel/smp.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/smp.c	2006-03-08 11:34:53.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/smp.c	2006-03-08 11:38:09.000000000 -0800
@@ -575,7 +575,7 @@ static void stop_this_cpu (void * dummy)
 	local_irq_disable();
 	disable_local_APIC();
 	if (cpu_data[smp_processor_id()].hlt_works_ok)
-		for(;;) halt();
+		for(;;) shutdown_halt();
 	for (;;);
 }
 
Index: linux-2.6.16-rc5/arch/i386/mach-vmi/setup.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/mach-vmi/setup.c	2006-03-08 11:37:59.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/mach-vmi/setup.c	2006-03-08 11:38:32.000000000 -0800
@@ -31,6 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/bootmem.h>
 #include <linux/mm.h>
+#include <linux/pm.h>
 #include <asm/acpi.h>
 #include <asm/arch_hooks.h>
 #include <asm/processor.h>
@@ -205,7 +206,6 @@ void __init intr_init_hook(void)
 	setup_irq(2, &irq2);
 }
 
-
 /*
  * Probe for the VMI option ROM
  */
@@ -238,6 +238,13 @@ void __init probe_vmi_rom(void)
 	}
 }
 
+/* Simple shutdown routine to power down in a VM */
+void
+vmi_power_off(void)
+{
+	/* Shutdown halt powers off the CPU */
+	shutdown_halt();
+}
 
 /*
  * Activate the VMI interfaces
@@ -267,6 +274,9 @@ void __init vmi_init(void)
 		       "(kernel requires version >= %d.%d) "
 		       " - falling back to native mode\n",
 		       VMI_API_REV_MAJOR, MIN_VMI_API_REV_MINOR);
+
+	if (hypervisor_found)
+		pm_power_off = vmi_power_off;
 }
 
 

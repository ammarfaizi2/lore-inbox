Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWGRJ2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWGRJ2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWGRJ1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:27:38 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:34689 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932123AbWGRJU5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:20:57 -0400
Message-Id: <20060718091950.750213000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:09 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: [RFC PATCH 09/33] Add start-of-day setup hooks to subarch
Content-Disposition: inline; filename=i386-setup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the start-of-day subarchitecture setup hooks for booting on
Xen. Add subarch macros for determining loader type and initrd
location.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/setup.c                   |    2 +
 arch/i386/mach-default/Makefile            |    2 -
 arch/i386/mach-default/setup-memory.c      |   43 ++++++++++++++++++++++
 arch/i386/mach-default/setup.c             |   43 ----------------------
 arch/i386/mach-xen/Makefile                |    2 -
 arch/i386/mach-xen/setup-xen.c             |   54 ++++++++++++++++++++++++++++
 include/asm-i386/hypervisor.h              |    4 ++
 include/asm-i386/mach-default/mach_setup.h |   12 ++++++
 include/asm-i386/mach-xen/mach_setup.h     |   15 +++++++
 include/asm-i386/mach-xen/setup_arch.h     |    9 ++++
 include/asm-i386/setup.h                   |   20 ++++++----
 11 files changed, 153 insertions(+), 53 deletions(-)

diff -r a5848bce3730 arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Thu Jun 22 16:02:54 2006 -0400
+++ b/arch/i386/kernel/setup.c	Thu Jun 22 20:20:31 2006 -0400
@@ -458,6 +458,7 @@ static void __init print_memory_map(char
 	}
 }
 
+#ifndef HAVE_ARCH_E820_SANITIZE
 /*
  * Sanitize the BIOS e820 map.
  *
@@ -677,6 +678,7 @@ int __init copy_e820_map(struct e820entr
 	} while (biosmap++,--nr_map);
 	return 0;
 }
+#endif
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 struct edd edd;
diff -r a5848bce3730 arch/i386/mach-default/Makefile
--- a/arch/i386/mach-default/Makefile	Thu Jun 22 16:02:54 2006 -0400
+++ b/arch/i386/mach-default/Makefile	Thu Jun 22 20:20:31 2006 -0400
@@ -2,4 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-obj-y				:= setup.o
+obj-y				:= setup.o setup-memory.o
diff -r a5848bce3730 arch/i386/mach-default/setup.c
--- a/arch/i386/mach-default/setup.c	Thu Jun 22 16:02:54 2006 -0400
+++ b/arch/i386/mach-default/setup.c	Thu Jun 22 20:20:31 2006 -0400
@@ -8,8 +8,6 @@
 #include <linux/interrupt.h>
 #include <asm/acpi.h>
 #include <asm/arch_hooks.h>
-#include <asm/e820.h>
-#include <asm/setup.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define DEFAULT_SEND_IPI	(1)
@@ -132,44 +130,3 @@ static int __init print_ipi_mode(void)
 }
 
 late_initcall(print_ipi_mode);
-
-/**
- * machine_specific_memory_setup - Hook for machine specific memory setup.
- *
- * Description:
- *	This is included late in kernel/setup.c so that it can make
- *	use of all of the static functions.
- **/
-
-char * __init machine_specific_memory_setup(void)
-{
-	char *who;
-
-
-	who = "BIOS-e820";
-
-	/*
-	 * Try to copy the BIOS-supplied E820-map.
-	 *
-	 * Otherwise fake a memory map; one section from 0k->640k,
-	 * the next section from 1mb->appropriate_mem_k
-	 */
-	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
-	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
-		unsigned long mem_size;
-
-		/* compare results from other methods and take the greater */
-		if (ALT_MEM_K < EXT_MEM_K) {
-			mem_size = EXT_MEM_K;
-			who = "BIOS-88";
-		} else {
-			mem_size = ALT_MEM_K;
-			who = "BIOS-e801";
-		}
-
-		e820.nr_map = 0;
-		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
-		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
-  	}
-	return who;
-}
diff -r a5848bce3730 arch/i386/mach-xen/Makefile
--- a/arch/i386/mach-xen/Makefile	Thu Jun 22 16:02:54 2006 -0400
+++ b/arch/i386/mach-xen/Makefile	Thu Jun 22 20:20:31 2006 -0400
@@ -2,6 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-obj-y				:= setup.o
+obj-y				:= setup.o setup-xen.o
 
 setup-y				:= ../mach-default/setup.o
diff -r a5848bce3730 include/asm-i386/hypervisor.h
--- a/include/asm-i386/hypervisor.h	Thu Jun 22 16:02:54 2006 -0400
+++ b/include/asm-i386/hypervisor.h	Thu Jun 22 20:20:31 2006 -0400
@@ -55,6 +55,10 @@ extern struct shared_info *HYPERVISOR_sh
 extern struct shared_info *HYPERVISOR_shared_info;
 extern struct start_info *xen_start_info;
 
+/* arch/i386/mach-xen/entry.S */
+extern void hypervisor_callback(void);
+extern void failsafe_callback(void);
+
 /* arch/i386/mach-xen/evtchn.c */
 /* Force a proper event-channel callback from Xen. */
 extern void force_evtchn_callback(void);
diff -r a5848bce3730 include/asm-i386/setup.h
--- a/include/asm-i386/setup.h	Thu Jun 22 16:02:54 2006 -0400
+++ b/include/asm-i386/setup.h	Thu Jun 22 20:20:31 2006 -0400
@@ -49,10 +49,10 @@ extern unsigned char boot_params[PARAM_S
 #define VIDEO_MODE (*(unsigned short *) (PARAM+0x1FA))
 #define ORIG_ROOT_DEV (*(unsigned short *) (PARAM+0x1FC))
 #define AUX_DEVICE_INFO (*(unsigned char *) (PARAM+0x1FF))
-#define LOADER_TYPE (*(unsigned char *) (PARAM+0x210))
+#define LOADER_TYPE MACH_LOADER_TYPE
 #define KERNEL_START (*(unsigned long *) (PARAM+0x214))
-#define INITRD_START (*(unsigned long *) (PARAM+0x218))
-#define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
+#define INITRD_START MACH_INITRD_START
+#define INITRD_SIZE MACH_INITRD_SIZE
 #define EDID_INFO   (*(struct edid_info *) (PARAM+0x140))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
 #define EDD_MBR_SIG_NR (*(unsigned char *) (PARAM+EDD_MBR_SIG_NR_BUF))
@@ -65,15 +65,19 @@ extern unsigned char boot_params[PARAM_S
  */
 #define LOWMEMSIZE()	(0x9f000)
 
+extern unsigned long init_pg_tables_end;
+
 struct e820entry;
 
-char * __init machine_specific_memory_setup(void);
+char * machine_specific_memory_setup(void);
 
-int __init copy_e820_map(struct e820entry * biosmap, int nr_map);
-int __init sanitize_e820_map(struct e820entry * biosmap, char * pnr_map);
-void __init add_memory_region(unsigned long long start,
-			      unsigned long long size, int type);
+int copy_e820_map(struct e820entry * biosmap, int nr_map);
+int sanitize_e820_map(struct e820entry * biosmap, char * pnr_map);
+void add_memory_region(unsigned long long start,
+		       unsigned long long size, int type);
 
 #endif /* __ASSEMBLY__ */
 
+#include <mach_setup.h>
+
 #endif /* _i386_SETUP_H */
diff -r a5848bce3730 arch/i386/mach-default/setup-memory.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/arch/i386/mach-default/setup-memory.c	Thu Jun 22 20:20:31 2006 -0400
@@ -0,0 +1,44 @@
+#include <linux/init.h>
+#include <asm/e820.h>
+#include <asm/setup.h>
+
+/**
+ * machine_specific_memory_setup - Hook for machine specific memory setup.
+ *
+ * Description:
+ *	This is included late in kernel/setup.c so that it can make
+ *	use of all of the static functions.
+ **/
+
+char * __init machine_specific_memory_setup(void)
+{
+	char *who;
+
+
+	who = "BIOS-e820";
+
+	/*
+	 * Try to copy the BIOS-supplied E820-map.
+	 *
+	 * Otherwise fake a memory map; one section from 0k->640k,
+	 * the next section from 1mb->appropriate_mem_k
+	 */
+	sanitize_e820_map(E820_MAP, &E820_MAP_NR);
+	if (copy_e820_map(E820_MAP, E820_MAP_NR) < 0) {
+		unsigned long mem_size;
+
+		/* compare results from other methods and take the greater */
+		if (ALT_MEM_K < EXT_MEM_K) {
+			mem_size = EXT_MEM_K;
+			who = "BIOS-88";
+		} else {
+			mem_size = ALT_MEM_K;
+			who = "BIOS-e801";
+		}
+
+		e820.nr_map = 0;
+		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
+		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
+  	}
+	return who;
+}
diff -r a5848bce3730 arch/i386/mach-xen/setup-xen.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/arch/i386/mach-xen/setup-xen.c	Thu Jun 22 20:20:31 2006 -0400
@@ -0,0 +1,54 @@
+/*
+ *	Machine specific setup for xen
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+
+#include <asm/e820.h>
+#include <asm/setup.h>
+#include <asm/hypervisor.h>
+#include <asm/hypercall.h>
+
+#include <xen/interface/physdev.h>
+
+
+struct start_info *xen_start_info;
+EXPORT_SYMBOL(xen_start_info);
+
+/*
+ * Point at the empty zero page to start with. We map the real shared_info
+ * page as soon as fixmap is up and running.
+ */
+struct shared_info *HYPERVISOR_shared_info = (struct shared_info *)empty_zero_page;
+EXPORT_SYMBOL(HYPERVISOR_shared_info);
+
+/**
+ * machine_specific_memory_setup - Hook for machine specific memory setup.
+ **/
+
+char * __init machine_specific_memory_setup(void)
+{
+	unsigned long max_pfn = xen_start_info->nr_pages;
+
+	e820.nr_map = 0;
+	add_memory_region(0, PFN_PHYS(max_pfn), E820_RAM);
+
+	return "Xen";
+}
+
+void __init machine_specific_arch_setup(void)
+{
+#ifdef CONFIG_ACPI
+	if (!(xen_start_info->flags & SIF_INITDOMAIN)) {
+		printk(KERN_INFO "ACPI in unprivileged domain disabled\n");
+		acpi_disabled = 1;
+		acpi_ht = 0;
+	}
+#endif
+
+	memcpy(saved_command_line, xen_start_info->cmd_line,
+	       MAX_GUEST_CMDLINE > COMMAND_LINE_SIZE ?
+	       COMMAND_LINE_SIZE : MAX_GUEST_CMDLINE);
+}
diff -r a5848bce3730 include/asm-i386/mach-default/mach_setup.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-default/mach_setup.h	Thu Jun 22 20:20:31 2006 -0400
@@ -0,0 +1,12 @@
+#ifndef __ASM_MACH_SETUP_H
+#define __ASM_MACH_SETUP_H
+
+#ifndef __ASSEMBLY__
+
+#define MACH_LOADER_TYPE (*(unsigned char *) (PARAM+0x210))
+#define MACH_INITRD_START (*(unsigned long *) (PARAM+0x218))
+#define MACH_INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_MACH_SETUP_H */
diff -r a5848bce3730 include/asm-i386/mach-xen/mach_setup.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-xen/mach_setup.h	Thu Jun 22 20:20:31 2006 -0400
@@ -0,0 +1,15 @@
+#ifndef __ASM_MACH_SETUP_H
+#define __ASM_MACH_SETUP_H
+
+#ifndef __ASSEMBLY__
+
+#include <xen/interface/xen.h>
+
+#define MACH_LOADER_TYPE 0x6e6558	/* "Xen" */
+#define MACH_INITRD_START \
+	(xen_start_info->mod_start ? __pa(xen_start_info->mod_start) : 0)
+#define MACH_INITRD_SIZE (xen_start_info->mod_len)
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_MACH_SETUP_H */
diff -r a5848bce3730 include/asm-i386/mach-xen/setup_arch.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-xen/setup_arch.h	Thu Jun 22 20:20:31 2006 -0400
@@ -0,0 +1,9 @@
+
+#define ARCH_SETUP machine_specific_arch_setup();
+
+extern struct start_info *xen_start_info;
+extern struct shared_info *HYPERVISOR_shared_info;
+
+void __init machine_specific_arch_setup(void);
+
+#define HAVE_ARCH_E820_SANITIZE

--

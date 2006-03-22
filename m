Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWCVGjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWCVGjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWCVGiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:38:54 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:4227 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750930AbWCVGid
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:38:33 -0500
Message-Id: <20060322063750.020648000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:30:52 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 12/35] Add start-of-day setup hooks to subarch
Content-Disposition: inline; filename=11-i386-setup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the start-of-day subarchitecture setup hooks for booting on
Xen. Add subarch macros for determining loader type and initrd
location.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/setup.c                    |    5 ++
 include/asm-i386/hypervisor.h               |    4 +
 include/asm-i386/mach-default/mach_setup.h  |   12 +++++
 include/asm-i386/mach-xen/mach_setup.h      |   13 ++++++
 include/asm-i386/mach-xen/setup_arch_post.h |   60 ++++++++++++++++++++++++++++
 include/asm-i386/mach-xen/setup_arch_pre.h  |   22 ++++++++++
 include/asm-i386/setup.h                    |    8 ++-
 7 files changed, 121 insertions(+), 3 deletions(-)

--- xen-subarch-2.6.orig/arch/i386/kernel/setup.c
+++ xen-subarch-2.6/arch/i386/kernel/setup.c
@@ -456,6 +456,7 @@ static void __init print_memory_map(char
 	}
 }
 
+#ifndef HAVE_ARCH_E820_SANITIZE
 /*
  * Sanitize the BIOS e820 map.
  *
@@ -675,6 +676,7 @@ static int __init copy_e820_map(struct e
 	} while (biosmap++,--nr_map);
 	return 0;
 }
+#endif
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 struct edd edd;
@@ -1632,6 +1634,9 @@ void __init setup_arch(char **cmdline_p)
 	conswitchp = &dummy_con;
 #endif
 #endif
+#ifdef ARCH_FINAL_SETUP
+	ARCH_FINAL_SETUP
+#endif
 }
 
 #include "setup_arch_post.h"
--- xen-subarch-2.6.orig/include/asm-i386/hypervisor.h
+++ xen-subarch-2.6/include/asm-i386/hypervisor.h
@@ -53,6 +53,10 @@
 extern struct shared_info *HYPERVISOR_shared_info;
 extern struct start_info *xen_start_info;
 
+/* arch/i386/mach-xen/entry.S */
+extern void hypervisor_callback(void);
+extern void failsafe_callback(void);
+
 /* arch/i386/mach-xen/evtchn.c */
 /* Force a proper event-channel callback from Xen. */
 extern void force_evtchn_callback(void);
--- xen-subarch-2.6.orig/include/asm-i386/setup.h
+++ xen-subarch-2.6/include/asm-i386/setup.h
@@ -51,10 +51,10 @@ extern unsigned char boot_params[PARAM_S
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
@@ -63,4 +63,6 @@ extern unsigned char boot_params[PARAM_S
 
 #endif /* __ASSEMBLY__ */
 
+#include <mach_setup.h>
+
 #endif /* _i386_SETUP_H */
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/mach-default/mach_setup.h
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
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/mach-xen/mach_setup.h
@@ -0,0 +1,13 @@
+#ifndef __ASM_MACH_SETUP_H
+#define __ASM_MACH_SETUP_H
+
+#ifndef __ASSEMBLY__
+
+#define MACH_LOADER_TYPE 0x6e6558	/* "Xen" */
+#define MACH_INITRD_START \
+	(xen_start_info->mod_start ? __pa(xen_start_info->mod_start) : 0)
+#define MACH_INITRD_SIZE (xen_start_info->mod_len)
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_MACH_SETUP_H */
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/mach-xen/setup_arch_post.h
@@ -0,0 +1,60 @@
+/**
+ * machine_specific_memory_setup - Hook for machine specific memory setup.
+ *
+ * Description:
+ *	This is included late in kernel/setup.c so that it can make
+ *	use of all of the static functions.
+ **/
+
+#include <xen/interface/physdev.h>
+
+static char * __init machine_specific_memory_setup(void)
+{
+	unsigned long max_pfn = xen_start_info->nr_pages;
+
+	e820.nr_map = 0;
+	add_memory_region(0, PFN_PHYS(max_pfn), E820_RAM);
+
+	return "Xen";
+}
+
+static void __init machine_specific_arch_setup(void)
+{
+	struct physdev_op op;
+
+	HYPERVISOR_shared_info =
+		(struct shared_info *)__va(xen_start_info->shared_info);
+	memset(empty_zero_page, 0, sizeof(empty_zero_page));
+
+	HYPERVISOR_set_callbacks(
+	    __KERNEL_CS, (unsigned long)hypervisor_callback,
+	    __KERNEL_CS, (unsigned long)failsafe_callback);
+
+	init_pg_tables_end = __pa(xen_start_info->pt_base) +
+		PFN_PHYS(xen_start_info->nr_pt_frames);
+
+	op.cmd = PHYSDEVOP_SET_IOPL;
+	op.u.set_iopl.iopl = 1;
+	HYPERVISOR_physdev_op(&op);
+
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
+
+static void __init machine_specific_arch_final_setup(void)
+{
+	if (!(xen_start_info->flags & SIF_INITDOMAIN)) {
+		extern int console_use_vt;
+		console_use_vt = 0;
+		conswitchp = NULL;
+	}
+}
--- /dev/null
+++ xen-subarch-2.6/include/asm-i386/mach-xen/setup_arch_pre.h
@@ -0,0 +1,22 @@
+
+#include <xen/interface/xen.h>
+#include <asm/hypervisor.h>
+
+struct start_info *xen_start_info;
+EXPORT_SYMBOL(xen_start_info);
+
+/*
+ * Point at the empty zero page to start with. We map the real shared_info
+ * page as soon as fixmap is up and running.
+ */
+struct shared_info *HYPERVISOR_shared_info =
+	(struct shared_info *)empty_zero_page;
+EXPORT_SYMBOL(HYPERVISOR_shared_info);
+
+#define ARCH_SETUP machine_specific_arch_setup();
+#define ARCH_FINAL_SETUP machine_specific_arch_final_setup();
+
+static void __init machine_specific_arch_setup(void);
+static void __init machine_specific_arch_final_setup(void);
+
+#define HAVE_ARCH_E820_SANITIZE

--

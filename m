Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVASHjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVASHjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVASHjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:39:17 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49599 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261618AbVASHdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:11 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 26/29] crashdump-memory-preserving-reboot-using-kexec
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <crashdump-memory-preserving-reboot-using-kexec-11061198972518@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <crashdump-documentation-11061198972662@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
	<x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
	<x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
	<x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
	<x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
	<x86-64-config-kernel-start-11061198972987@ebiederm.dsl.xmission.com>
	<kexec-kexec-generic-11061198974111@ebiederm.dsl.xmission.com>
	<x86-machine-shutdown-1106119897775@ebiederm.dsl.xmission.com>
	<x86-kexec-11061198971773@ebiederm.dsl.xmission.com>
	<x86-crashkernel-1106119897532@ebiederm.dsl.xmission.com>
	<x86-64-machine-shutdown-11061198972282@ebiederm.dsl.xmission.com>
	<x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com>
	<x86-64-crashkernel-11061198971876@ebiederm.dsl.xmission.com>
	<kexec-ppc-support-11061198973302@ebiederm.dsl.xmission.com>
	<x86-crash-shutdown-nmi-shootdown-11061198973234@ebiederm.dsl.xmission.com>
	<x86-crash-shutdown-snapshot-registers-11061198972173@ebiederm.dsl.xmission.com>
	<x86-crash-shutdown-apic-shutdown-11061198971134@ebiederm.dsl.xmission.com>
	<crashdump-documentation-11061198972662@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With the recent refactoring of the kexec code this patch is a shadow
of it's former self.  The user space code in /sbin/kexec has been
enhanced so it can contain copy the first 640k.  And the strong tying
between the crashdump capturecode paths and the kexec on panic code
paths have been removed.

From: Hariprasad Nellitheertha <hari@in.ibm.com>

This patch contains the code that does the memory preserving reboot.  It
copies over the first 640k into a backup region before handing over to kexec. 
The second kernel will boot using only the backup region.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>
Signed off by Adam Litke <litke@us.ibm.com>

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 arch/i386/Kconfig             |   21 +++++++++++++++++++++
 arch/i386/kernel/setup.c      |    8 ++++++++
 include/asm-i386/crash_dump.h |   20 ++++++++++++++++++++
 include/linux/bootmem.h       |    3 +++
 include/linux/crash_dump.h    |   10 ++++++++++
 kernel/Makefile               |    1 +
 kernel/crash_dump.c           |   13 +++++++++++++
 mm/bootmem.c                  |    7 +++++++
 8 files changed, 83 insertions(+)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/arch/i386/Kconfig linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/arch/i386/Kconfig
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/arch/i386/Kconfig	Tue Jan 18 22:58:15 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/arch/i386/Kconfig	Tue Jan 18 23:16:24 2005
@@ -918,6 +918,27 @@
 	  support.  As of this writing the exact hardware interface is
 	  strongly in flux, so no good recommendation can be made.
 
+config CRASH_DUMP
+	bool "kernel crash dumps (EXPERIMENTAL)"
+	depends on EMBEDDED
+	depends on EXPERIMENTAL
+	help
+	  Generate crash dump after being started by kexec.
+
+config BACKUP_BASE
+	int "location from where the crash dumping kernel will boot (MB)"
+	depends on CRASH_DUMP
+	default 16
+	help
+	This is the location where the second kernel will boot from.
+
+config BACKUP_SIZE
+	int "Size of memory used by the crash dumping kernel (MB)"
+	depends on CRASH_DUMP
+	range 16 64
+	default 32
+	help
+	The size of the second kernel's memory.
 endmenu
 
 
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/arch/i386/kernel/setup.c linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/arch/i386/kernel/setup.c
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/arch/i386/kernel/setup.c	Tue Jan 18 22:58:33 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/arch/i386/kernel/setup.c	Tue Jan 18 23:16:24 2005
@@ -51,6 +51,7 @@
 #include <asm/io_apic.h>
 #include <asm/ist.h>
 #include <asm/io.h>
+#include <asm/crash_dump.h>
 #include "setup_arch_pre.h"
 #include <bios_ebda.h>
 
@@ -713,6 +714,13 @@
 			if (to != command_line)
 				to--;
 			if (!memcmp(from+7, "exactmap", 8)) {
+#ifdef CONFIG_CRASH_DUMP
+				/* If we are doing a crash dump, we
+				 * still need to know the real mem
+				 * size.
+				 */
+				set_saved_max_pfn();
+#endif
 				from += 8+7;
 				e820.nr_map = 0;
 				userdef = 1;
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/include/asm-i386/crash_dump.h linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/include/asm-i386/crash_dump.h
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/include/asm-i386/crash_dump.h	Wed Dec 31 17:00:00 1969
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/include/asm-i386/crash_dump.h	Tue Jan 18 23:16:24 2005
@@ -0,0 +1,20 @@
+/* asm-i386/crash_dump.h */
+#include <linux/bootmem.h>
+
+#ifdef CONFIG_CRASH_DUMP
+extern unsigned long __init find_max_low_pfn(void);
+extern void __init find_max_pfn(void);
+
+#define CRASH_BACKUP_BASE ((unsigned long)CONFIG_BACKUP_BASE * 0x100000)
+#define CRASH_BACKUP_SIZE ((unsigned long)CONFIG_BACKUP_SIZE * 0x100000)
+#define CRASH_RELOCATE_SIZE 0xa0000
+
+static inline void set_saved_max_pfn(void)
+{
+	find_max_pfn();
+	saved_max_pfn = find_max_low_pfn();
+}
+
+#else
+#define set_saved_max_pfn() do { } while(0)
+#endif
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/include/linux/bootmem.h linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/include/linux/bootmem.h
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/include/linux/bootmem.h	Fri Jan 14 04:28:48 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/include/linux/bootmem.h	Tue Jan 18 23:16:24 2005
@@ -21,6 +21,9 @@
  * highest page
  */
 extern unsigned long max_pfn;
+#ifdef CONFIG_CRASH_DUMP
+extern unsigned long saved_max_pfn;
+#endif 
 
 /*
  * node_bootmem_map is a map pointer - the bits represent all physical 
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/include/linux/crash_dump.h linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/include/linux/crash_dump.h
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/include/linux/crash_dump.h	Wed Dec 31 17:00:00 1969
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/include/linux/crash_dump.h	Tue Jan 18 23:16:24 2005
@@ -0,0 +1,10 @@
+#include <linux/kexec.h>
+#include <linux/smp_lock.h>
+#include <linux/device.h>
+#ifdef CONFIG_CRASH_DUMP
+#include <asm/crash_dump.h>
+#endif
+
+#ifdef CONFIG_CRASH_DUMP
+#else
+#endif
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/kernel/Makefile linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/kernel/Makefile
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/kernel/Makefile	Tue Jan 18 22:47:13 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/kernel/Makefile	Tue Jan 18 23:16:24 2005
@@ -29,6 +29,7 @@
 obj-$(CONFIG_KPROBES) += kprobes.o
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
+obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/kernel/crash_dump.c linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/kernel/crash_dump.c
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/kernel/crash_dump.c	Wed Dec 31 17:00:00 1969
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/kernel/crash_dump.c	Tue Jan 18 23:16:24 2005
@@ -0,0 +1,13 @@
+/*
+ *	kernel/crash_dump.c - Memory preserving reboot related code.
+ *
+ *	Created by: Hariprasad Nellitheertha (hari@in.ibm.com)
+ *	Copyright (C) IBM Corporation, 2004. All rights reserved
+ */
+
+#include <linux/smp_lock.h>
+#include <linux/errno.h>
+#include <linux/proc_fs.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/mm/bootmem.c linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/mm/bootmem.c
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-documentation/mm/bootmem.c	Fri Jan 14 04:28:50 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/mm/bootmem.c	Tue Jan 18 23:16:24 2005
@@ -28,6 +28,13 @@
 unsigned long max_low_pfn;
 unsigned long min_low_pfn;
 unsigned long max_pfn;
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * If we have booted due to a crash, max_pfn will be a very low value. We need
+ * to know the amount of memory that the previous kernel used.
+ */
+unsigned long saved_max_pfn;
+#endif
 
 EXPORT_SYMBOL(max_pfn);		/* This is exported so
 				 * dma_get_required_mask(), which uses

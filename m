Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVKQN3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVKQN3r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVKQN3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:29:47 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:34769 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750816AbVKQN3q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:29:46 -0500
Date: Thu, 17 Nov 2005 18:59:44 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: ak@suse.de, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 9/10] kdump: read previous kernel's memory
Message-ID: <20051117132944.GM3981@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051117131339.GD3981@in.ibm.com> <20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com> <20051117132138.GG3981@in.ibm.com> <20051117132315.GH3981@in.ibm.com> <20051117132437.GI3981@in.ibm.com> <20051117132557.GJ3981@in.ibm.com> <20051117132659.GK3981@in.ibm.com> <20051117132850.GL3981@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117132850.GL3981@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Moving the crash_dump.c file to arch dependent part as 
  kmap_atomic_pfn is specific to i386 and highmem may not 
  exist in other archs.

o Use ioremap for x86_64 to map the previous kernel memory.

o In copy_oldmem_page(), we now directly copy to the user/kernel
  buffer and avoid the unneccesary copy to a kmalloc'd page. 

Signed-off-by:Rachita Kothiyal <rachita@in.ibm.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 /dev/null                                                        |   61 ----------
 linux-2.6.15-rc1-1M-dynamic-root/arch/i386/kernel/Makefile       |    1 
 linux-2.6.15-rc1-1M-dynamic-root/arch/i386/kernel/crash_dump.c   |   47 +++++++
 linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/Makefile     |    1 
 linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/crash_dump.c |   47 +++++++
 linux-2.6.15-rc1-1M-dynamic-root/fs/proc/vmcore.c                |    3 
 linux-2.6.15-rc1-1M-dynamic-root/kernel/Makefile                 |    1 
 7 files changed, 99 insertions(+), 62 deletions(-)

diff -puN /dev/null arch/i386/kernel/crash_dump.c
--- /dev/null	2005-11-15 21:13:36.730096500 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/i386/kernel/crash_dump.c	2005-11-17 11:19:55.000000000 +0530
@@ -0,0 +1,47 @@
+/*
+ *	kernel/crash_dump.c - Memory preserving reboot related code.
+ *
+ *	Created by: Hariprasad Nellitheertha (hari@in.ibm.com)
+ *	Copyright (C) IBM Corporation, 2004. All rights reserved
+ */
+
+#include <linux/errno.h>
+#include <linux/highmem.h>
+#include <linux/crash_dump.h>
+
+#include <asm/uaccess.h>
+
+/**
+ * copy_oldmem_page - copy one page from "oldmem"
+ * @pfn: page frame number to be copied
+ * @buf: target memory address for the copy; this can be in kernel address
+ *	space or user address space (see @userbuf)
+ * @csize: number of bytes to copy
+ * @offset: offset in bytes into the page (based on pfn) to begin the copy
+ * @userbuf: if set, @buf is in user address space, use copy_to_user(),
+ *	otherwise @buf is in kernel address space, use memcpy().
+ *
+ * Copy a page from "oldmem". For this page, there is no pte mapped
+ * in the current kernel. We stitch up a pte, similar to kmap_atomic.
+ */
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
+                               size_t csize, unsigned long offset, int userbuf)
+{
+	void  *vaddr;
+
+	if (!csize)
+		return 0;
+
+	vaddr = kmap_atomic_pfn(pfn, KM_PTE0);
+
+	if (userbuf) {
+		if (copy_to_user(buf, (vaddr + offset), csize)) {
+			kunmap_atomic(vaddr, KM_PTE0);
+			return -EFAULT;
+		}
+	} else
+	memcpy(buf, (vaddr + offset), csize);
+
+	kunmap_atomic(vaddr, KM_PTE0);
+	return csize;
+}
diff -puN arch/i386/kernel/Makefile~read-previous-kernel-memory arch/i386/kernel/Makefile
--- linux-2.6.15-rc1-1M-dynamic/arch/i386/kernel/Makefile~read-previous-kernel-memory	2005-11-17 11:19:55.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/i386/kernel/Makefile	2005-11-17 11:19:55.000000000 +0530
@@ -25,6 +25,7 @@ obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o n
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_X86_REBOOTFIXUPS)	+= reboot_fixups.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
+obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT_NUMA)	+= summit.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
diff -puN /dev/null arch/x86_64/kernel/crash_dump.c
--- /dev/null	2005-11-15 21:13:36.730096500 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/crash_dump.c	2005-11-17 11:19:55.000000000 +0530
@@ -0,0 +1,47 @@
+/*
+ *	kernel/crash_dump.c - Memory preserving reboot related code.
+ *
+ *	Created by: Hariprasad Nellitheertha (hari@in.ibm.com)
+ *	Copyright (C) IBM Corporation, 2004. All rights reserved
+ */
+
+#include <linux/errno.h>
+#include <linux/crash_dump.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+/**
+ * copy_oldmem_page - copy one page from "oldmem"
+ * @pfn: page frame number to be copied
+ * @buf: target memory address for the copy; this can be in kernel address
+ *	space or user address space (see @userbuf)
+ * @csize: number of bytes to copy
+ * @offset: offset in bytes into the page (based on pfn) to begin the copy
+ * @userbuf: if set, @buf is in user address space, use copy_to_user(),
+ *	otherwise @buf is in kernel address space, use memcpy().
+ *
+ * Copy a page from "oldmem". For this page, there is no pte mapped
+ * in the current kernel. We stitch up a pte, similar to kmap_atomic.
+ */
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
+                               size_t csize, unsigned long offset, int userbuf)
+{
+	void  *vaddr;
+
+	if (!csize)
+		return 0;
+
+	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
+
+	if (userbuf) {
+		if (copy_to_user(buf, (vaddr + offset), csize)) {
+			iounmap(vaddr);
+			return -EFAULT;
+		}
+	} else
+	memcpy(buf, (vaddr + offset), csize);
+
+	iounmap(vaddr);
+	return csize;
+}
diff -puN arch/x86_64/kernel/Makefile~read-previous-kernel-memory arch/x86_64/kernel/Makefile
--- linux-2.6.15-rc1-1M-dynamic/arch/x86_64/kernel/Makefile~read-previous-kernel-memory	2005-11-17 11:19:55.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/Makefile	2005-11-17 11:19:55.000000000 +0530
@@ -21,6 +21,7 @@ obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o  
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o mpparse.o \
 		genapic.o genapic_cluster.o genapic_flat.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
+obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_PM)		+= suspend.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend_asm.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
diff -puN fs/proc/vmcore.c~read-previous-kernel-memory fs/proc/vmcore.c
--- linux-2.6.15-rc1-1M-dynamic/fs/proc/vmcore.c~read-previous-kernel-memory	2005-11-17 11:19:55.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/fs/proc/vmcore.c	2005-11-17 11:19:55.000000000 +0530
@@ -35,6 +35,9 @@ static size_t elfcorebuf_sz;
 /* Total size of vmcore file. */
 static u64 vmcore_size;
 
+/* Stores the physical address of elf header of crash image. */
+unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
+
 struct proc_dir_entry *proc_vmcore = NULL;
 
 /* Reads a page from the oldmem device from given offset. */
diff -L kernel/crash_dump.c -puN kernel/crash_dump.c~read-previous-kernel-memory /dev/null
--- linux-2.6.15-rc1-1M-dynamic/kernel/crash_dump.c
+++ /dev/null	2005-11-15 21:13:36.730096500 +0530
@@ -1,61 +0,0 @@
-/*
- *	kernel/crash_dump.c - Memory preserving reboot related code.
- *
- *	Created by: Hariprasad Nellitheertha (hari@in.ibm.com)
- *	Copyright (C) IBM Corporation, 2004. All rights reserved
- */
-
-#include <linux/smp_lock.h>
-#include <linux/errno.h>
-#include <linux/proc_fs.h>
-#include <linux/bootmem.h>
-#include <linux/highmem.h>
-#include <linux/crash_dump.h>
-
-#include <asm/io.h>
-#include <asm/uaccess.h>
-
-/* Stores the physical address of elf header of crash image. */
-unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
-
-/**
- * copy_oldmem_page - copy one page from "oldmem"
- * @pfn: page frame number to be copied
- * @buf: target memory address for the copy; this can be in kernel address
- *	space or user address space (see @userbuf)
- * @csize: number of bytes to copy
- * @offset: offset in bytes into the page (based on pfn) to begin the copy
- * @userbuf: if set, @buf is in user address space, use copy_to_user(),
- *	otherwise @buf is in kernel address space, use memcpy().
- *
- * Copy a page from "oldmem". For this page, there is no pte mapped
- * in the current kernel. We stitch up a pte, similar to kmap_atomic.
- */
-ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
-				size_t csize, unsigned long offset, int userbuf)
-{
-	void *page, *vaddr;
-
-	if (!csize)
-		return 0;
-
-	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	vaddr = kmap_atomic_pfn(pfn, KM_PTE0);
-	copy_page(page, vaddr);
-	kunmap_atomic(vaddr, KM_PTE0);
-
-	if (userbuf) {
-		if (copy_to_user(buf, (page + offset), csize)) {
-			kfree(page);
-			return -EFAULT;
-		}
-	} else {
-		memcpy(buf, (page + offset), csize);
-	}
-
-	kfree(page);
-	return csize;
-}
diff -puN kernel/Makefile~read-previous-kernel-memory kernel/Makefile
--- linux-2.6.15-rc1-1M-dynamic/kernel/Makefile~read-previous-kernel-memory	2005-11-17 11:19:55.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/kernel/Makefile	2005-11-17 11:19:55.000000000 +0530
@@ -29,7 +29,6 @@ obj-$(CONFIG_KPROBES) += kprobes.o
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_DETECT_SOFTLOCKUP) += softlockup.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
-obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 
_

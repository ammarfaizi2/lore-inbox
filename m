Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVASHxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVASHxR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVASHxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:53:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51135 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261624AbVASHdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:19 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 29/29] crashdump-linear-raw-format-dump-file-access
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <crashdump-linear-raw-format-dump-file-access-1106119897387@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <crashdump-elf-format-dump-file-access-11061198971254@ebiederm.dsl.xmission.com>
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
	<crashdump-memory-preserving-reboot-using-kexec-11061198972518@ebiederm.dsl.xmission.com>
	<crashdump-routines-for-copying-dump-pages-1106119897713@ebiederm.dsl.xmission.com>
	<crashdump-elf-format-dump-file-access-11061198971254@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hariprasad Nellitheertha <hari@in.ibm.com>

This patch contains the code that enables us to access the previous kernel's
memory as /dev/oldmem.


Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 Documentation/devices.txt |    1 
 drivers/char/mem.c        |   74 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-elf-format-dump-file-access/Documentation/devices.txt linux-2.6.11-rc1-mm1-nokexec-crashdump-linear-raw-format-dump-file-access/Documentation/devices.txt
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-elf-format-dump-file-access/Documentation/devices.txt	Fri Jan 14 04:32:22 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-linear-raw-format-dump-file-access/Documentation/devices.txt	Tue Jan 18 23:17:15 2005
@@ -100,6 +100,7 @@
 		  9 = /dev/urandom	Faster, less secure random number gen.
 		 10 = /dev/aio		Asyncronous I/O notification interface
 		 11 = /dev/kmsg		Writes to this come out as printk's
+		 12 = /dev/oldmem	Access to crash dump from kexec kernel
   1 block	RAM disk
 		  0 = /dev/ram0		First RAM disk
 		  1 = /dev/ram1		Second RAM disk
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-elf-format-dump-file-access/drivers/char/mem.c linux-2.6.11-rc1-mm1-nokexec-crashdump-linear-raw-format-dump-file-access/drivers/char/mem.c
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-elf-format-dump-file-access/drivers/char/mem.c	Fri Jan 14 04:32:23 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-linear-raw-format-dump-file-access/drivers/char/mem.c	Tue Jan 18 23:17:15 2005
@@ -23,6 +23,8 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ptrace.h>
 #include <linux/device.h>
+#include <linux/highmem.h>
+#include <linux/crash_dump.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -226,6 +228,62 @@
 	return 0;
 }
 
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * Read memory corresponding to the old kernel.
+ * If we are reading from the reserved section, which is
+ * actually used by the current kernel, we just return zeroes.
+ * Or if we are reading from the first 640k, we return from the
+ * backed up area.
+ */
+static ssize_t read_oldmem(struct file * file, char * buf,
+				size_t count, loff_t *ppos)
+{
+	unsigned long pfn;
+	unsigned backup_start, backup_end, relocate_start;
+	size_t read=0, csize;
+
+	backup_start = CRASH_BACKUP_BASE / PAGE_SIZE;
+	backup_end = backup_start + (CRASH_BACKUP_SIZE / PAGE_SIZE);
+	relocate_start = (CRASH_BACKUP_BASE + CRASH_BACKUP_SIZE) / PAGE_SIZE;
+
+	while(count) {
+		pfn = *ppos / PAGE_SIZE;
+
+		csize = (count > PAGE_SIZE) ? PAGE_SIZE : count;
+
+		/* Perform translation (see comment above) */
+		if ((pfn >= backup_start) && (pfn < backup_end)) {
+			if (clear_user(buf, csize)) {
+				read = -EFAULT;
+				goto done;
+			}
+
+			goto copy_done;
+		} else if (pfn < (CRASH_RELOCATE_SIZE / PAGE_SIZE))
+			pfn += relocate_start;
+
+		if (pfn > saved_max_pfn) {
+			read = 0;
+			goto done;
+		}
+
+		if (copy_oldmem_page(pfn, buf, csize, 1)) {
+			read = -EFAULT;
+			goto done;
+		}
+
+copy_done:
+		buf += csize;
+		*ppos += csize;
+		read += csize;
+		count -= csize;
+	}
+done:
+	return read;
+}
+#endif
+
 extern long vread(char *buf, char *addr, unsigned long count);
 extern long vwrite(char *buf, char *addr, unsigned long count);
 
@@ -530,6 +588,7 @@
 #define read_full       read_zero
 #define open_mem	open_port
 #define open_kmem	open_mem
+#define open_oldmem	open_mem
 
 #ifndef ARCH_HAS_DEV_MEM
 static struct file_operations mem_fops = {
@@ -578,6 +637,13 @@
 	.write		= write_full,
 };
 
+#ifdef CONFIG_CRASH_DUMP
+static struct file_operations oldmem_fops = {
+	.read	= read_oldmem,
+	.open	= open_oldmem,
+};
+#endif
+
 static ssize_t kmsg_write(struct file * file, const char __user * buf,
 			  size_t count, loff_t *ppos)
 {
@@ -632,6 +698,11 @@
 		case 11:
 			filp->f_op = &kmsg_fops;
 			break;
+#ifdef CONFIG_CRASH_DUMP
+		case 12:
+			filp->f_op = &oldmem_fops;
+			break;
+#endif
 		default:
 			return -ENXIO;
 	}
@@ -661,6 +732,9 @@
 	{8, "random",  S_IRUGO | S_IWUSR,           &random_fops},
 	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops},
 	{11,"kmsg",    S_IRUGO | S_IWUSR,           &kmsg_fops},
+#ifdef CONFIG_CRASH_DUMP
+	{12,"oldmem",    S_IRUSR | S_IWUSR | S_IRGRP, &oldmem_fops},
+#endif
 };
 
 static struct class_simple *mem_class;

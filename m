Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVASHfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVASHfD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVASHfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:35:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49343 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261617AbVASHdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:11 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 28/29] crashdump-elf-format-dump-file-access
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <crashdump-elf-format-dump-file-access-11061198971254@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <crashdump-routines-for-copying-dump-pages-1106119897713@ebiederm.dsl.xmission.com>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch has been refactored to more closely match the prevailing
style in the affected files.  And to clearly indicate the dependency
between /proc/kcore and proc/vmcore.c

From: Hariprasad Nellitheertha <hari@in.ibm.com>

This patch contains the code that provides an ELF format interface to the
previous kernel's memory post kexec reboot.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 fs/proc/Makefile           |    3 
 fs/proc/kcore.c            |   10 -
 fs/proc/proc_misc.c        |    8 +
 fs/proc/vmcore.c           |  239 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/crash_dump.h |   13 ++
 5 files changed, 267 insertions(+), 6 deletions(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/fs/proc/Makefile linux-2.6.11-rc1-mm1-nokexec-crashdump-elf-format-dump-file-access/fs/proc/Makefile
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/fs/proc/Makefile	Fri Jan 14 04:28:46 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-elf-format-dump-file-access/fs/proc/Makefile	Tue Jan 18 23:16:57 2005
@@ -10,5 +10,6 @@
 proc-y       += inode.o root.o base.o generic.o array.o \
 		kmsg.o proc_tty.o proc_misc.o
 
-proc-$(CONFIG_PROC_KCORE)	+= kcore.o
+kcore-$(CONFIG_CRASH_DUMP)	+= vmcore.o
+proc-$(CONFIG_PROC_KCORE)	+= kcore.o $(kcore-y)
 proc-$(CONFIG_PROC_DEVICETREE)	+= proc_devtree.o
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/fs/proc/kcore.c linux-2.6.11-rc1-mm1-nokexec-crashdump-elf-format-dump-file-access/fs/proc/kcore.c
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/fs/proc/kcore.c	Fri Jan 14 04:32:26 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-elf-format-dump-file-access/fs/proc/kcore.c	Tue Jan 18 23:16:57 2005
@@ -97,7 +97,7 @@
 /*
  * determine size of ELF note
  */
-static int notesize(struct memelfnote *en)
+int notesize(struct memelfnote *en)
 {
 	int sz;
 
@@ -112,7 +112,7 @@
 /*
  * store a note in the header buffer
  */
-static char *storenote(struct memelfnote *men, char *bufp)
+char *storenote(struct memelfnote *men, char *bufp)
 {
 	struct elf_note en;
 
@@ -139,7 +139,7 @@
  * store an ELF coredump header in the supplied buffer
  * nphdr is the number of elf_phdr to insert
  */
-static void elf_kcore_store_hdr(char *bufp, int nphdr, int dataoff)
+void elf_kcore_store_hdr(char *bufp, int nphdr, int dataoff, struct kcore_list *clist)
 {
 	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
 	struct elf_prpsinfo prpsinfo;	/* NT_PRPSINFO */
@@ -191,7 +191,7 @@
 	nhdr->p_align	= 0;
 
 	/* setup ELF PT_LOAD program header for every area */
-	for (m=kclist; m; m=m->next) {
+	for (m=clist; m; m=m->next) {
 		phdr = (struct elf_phdr *) bufp;
 		bufp += sizeof(struct elf_phdr);
 		offset += sizeof(struct elf_phdr);
@@ -287,7 +287,7 @@
 			return -ENOMEM;
 		}
 		memset(elf_buf, 0, elf_buflen);
-		elf_kcore_store_hdr(elf_buf, nphdr, elf_buflen);
+		elf_kcore_store_hdr(elf_buf, nphdr, elf_buflen, kclist);
 		read_unlock(&kclist_lock);
 		if (copy_to_user(buffer, elf_buf + *fpos, tsz)) {
 			kfree(elf_buf);
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/fs/proc/proc_misc.c linux-2.6.11-rc1-mm1-nokexec-crashdump-elf-format-dump-file-access/fs/proc/proc_misc.c
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/fs/proc/proc_misc.c	Fri Jan 14 04:28:46 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-elf-format-dump-file-access/fs/proc/proc_misc.c	Tue Jan 18 23:16:57 2005
@@ -44,6 +44,7 @@
 #include <linux/jiffies.h>
 #include <linux/sysrq.h>
 #include <linux/vmalloc.h>
+#include <linux/crash_dump.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -598,6 +599,13 @@
 		proc_root_kcore->size =
 				(size_t)high_memory - PAGE_OFFSET + PAGE_SIZE;
 	}
+# ifdef CONFIG_CRASH_DUMP
+	entry = create_proc_entry("vmcore", S_IRUSR, NULL);
+	if (entry) {
+		entry->proc_fops = &proc_vmcore_operations;
+		entry->size = (size_t)(saved_max_pfn << PAGE_SHIFT);
+	}
+# endif
 #endif
 #ifdef CONFIG_MAGIC_SYSRQ
 	entry = create_proc_entry("sysrq-trigger", S_IWUSR, NULL);
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/fs/proc/vmcore.c linux-2.6.11-rc1-mm1-nokexec-crashdump-elf-format-dump-file-access/fs/proc/vmcore.c
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/fs/proc/vmcore.c	Wed Dec 31 17:00:00 1969
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-elf-format-dump-file-access/fs/proc/vmcore.c	Tue Jan 18 23:16:57 2005
@@ -0,0 +1,239 @@
+/*
+ *	fs/proc/vmcore.c Interface for accessing the crash
+ * 				 dump from the system's previous life.
+ * 	Heavily borrowed from fs/proc/kcore.c
+ *	Created by: Hariprasad Nellitheertha (hari@in.ibm.com)
+ *	Copyright (C) IBM Corporation, 2004. All rights reserved
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/proc_fs.h>
+#include <linux/user.h>
+#include <linux/a.out.h>
+#include <linux/elf.h>
+#include <linux/elfcore.h>
+#include <linux/vmalloc.h>
+#include <linux/proc_fs.h>
+#include <linux/highmem.h>
+#include <linux/bootmem.h>
+#include <linux/init.h>
+#include <linux/crash_dump.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+/* This is to re-use the kcore header creation code */
+static struct kcore_list vmcore_mem;
+
+static int open_vmcore(struct inode * inode, struct file * filp)
+{
+	return 0;
+}
+
+static ssize_t read_vmcore(struct file *,char __user *,size_t, loff_t *);
+
+#define BACKUP_START CRASH_BACKUP_BASE
+#define BACKUP_END CRASH_BACKUP_BASE + CRASH_BACKUP_SIZE
+#define REG_SIZE sizeof(elf_gregset_t)
+
+struct file_operations proc_vmcore_operations = {
+	.read		= read_vmcore,
+	.open		= open_vmcore,
+};
+
+struct proc_dir_entry *proc_vmcore;
+
+struct memelfnote
+{
+	const char *name;
+	int type;
+	unsigned int datasz;
+	void *data;
+};
+
+static size_t get_vmcore_size(int *nphdr, size_t *elf_buflen)
+{
+	size_t size;
+
+	/* We need 1 PT_LOAD segment headers
+	 * In addition, we need one PT_NOTE header
+	 */
+	*nphdr = 2;
+	size = (size_t)(saved_max_pfn << PAGE_SHIFT);
+
+	*elf_buflen =	sizeof(struct elfhdr) +
+			(*nphdr + 2)*sizeof(struct elf_phdr) +
+			3 * sizeof(struct memelfnote) +
+			sizeof(struct elf_prstatus) +
+			sizeof(struct elf_prpsinfo) +
+			sizeof(struct task_struct);
+	*elf_buflen = PAGE_ALIGN(*elf_buflen);
+	return size + *elf_buflen;
+}
+
+/*
+ * Reads a page from the oldmem device from given offset.
+ */
+static ssize_t read_from_oldmem(char *buf, size_t count,
+			     loff_t *ppos, int userbuf)
+{
+	unsigned long pfn;
+	size_t read = 0;
+
+	pfn = (unsigned long)(*ppos / PAGE_SIZE);
+
+	if (pfn > saved_max_pfn) {
+		read = -EINVAL;
+		goto done;
+	}
+
+	count = (count > PAGE_SIZE) ? PAGE_SIZE : count;
+
+	if (copy_oldmem_page(pfn, buf, count, userbuf)) {
+		read = -EFAULT;
+		goto done;
+	}
+
+	*ppos += count;
+done:
+	return read;
+}
+
+/*
+ * store an ELF crash dump header in the supplied buffer
+ * nphdr is the number of elf_phdr to insert
+ */
+static void elf_vmcore_store_hdr(char *bufp, int nphdr, int dataoff)
+{
+	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
+	struct memelfnote notes[1];
+	char reg_buf[REG_SIZE];
+	loff_t reg_ppos;
+	char *buf = bufp;
+
+	vmcore_mem.addr = (unsigned long)__va(0);
+	vmcore_mem.size = saved_max_pfn << PAGE_SHIFT;
+	vmcore_mem.next = NULL;
+
+	/* Re-use the kcore code */
+	elf_kcore_store_hdr(bufp, nphdr, dataoff, &vmcore_mem);
+	buf += sizeof(struct elfhdr) + 2*sizeof(struct elf_phdr);
+
+	/* set up the process status */
+	notes[0].name = "CORE";
+	notes[0].type = NT_PRSTATUS;
+	notes[0].datasz = sizeof(struct elf_prstatus);
+	notes[0].data = &prstatus;
+
+	memset(&prstatus, 0, sizeof(struct elf_prstatus));
+
+	/* 1 - Get the registers from the reserved memory area */
+	reg_ppos = BACKUP_END + CRASH_RELOCATE_SIZE;
+	read_from_oldmem(reg_buf, REG_SIZE, &reg_ppos, 0);
+	elf_core_copy_regs(&prstatus.pr_reg, (struct pt_regs *)reg_buf);
+	buf = storenote(&notes[0], buf);
+}
+
+/*
+ * read from the ELF header and then the crash dump
+ */
+static ssize_t read_vmcore(
+struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
+{
+	ssize_t acc = 0;
+	size_t size, tsz;
+	size_t elf_buflen;
+	int nphdr;
+	unsigned long start;
+
+	tsz =  get_vmcore_size(&nphdr, &elf_buflen);
+	proc_vmcore->size = size = tsz + elf_buflen;
+	if (buflen == 0 || *fpos >= size) {
+		goto done;
+	}
+
+	/* trim buflen to not go beyond EOF */
+	if (buflen > size - *fpos)
+		buflen = size - *fpos;
+
+	/* construct an ELF core header if we'll need some of it */
+	if (*fpos < elf_buflen) {
+		char * elf_buf;
+
+		tsz = elf_buflen - *fpos;
+		if (buflen < tsz)
+			tsz = buflen;
+		elf_buf = kmalloc(elf_buflen, GFP_ATOMIC);
+		if (!elf_buf) {
+			acc = -ENOMEM;
+			goto done;
+		}
+		memset(elf_buf, 0, elf_buflen);
+		elf_vmcore_store_hdr(elf_buf, nphdr, elf_buflen);
+		if (copy_to_user(buffer, elf_buf + *fpos, tsz)) {
+			kfree(elf_buf);
+			acc = -EFAULT;
+			goto done;
+		}
+		kfree(elf_buf);
+		buflen -= tsz;
+		*fpos += tsz;
+		buffer += tsz;
+		acc += tsz;
+
+		/* leave now if filled buffer already */
+		if (buflen == 0) {
+			goto done;
+		}
+	}
+
+	start = *fpos - elf_buflen;
+	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
+		tsz = buflen;
+
+	while (buflen) {
+		unsigned long p;
+		loff_t pdup;
+
+		if ((start < 0) || (start >= size))
+			if (clear_user(buffer, tsz)) {
+				acc = -EFAULT;
+				goto done;
+			}
+
+		/* tsz contains actual len of dump to be read.
+		 * buflen is the total len that was requested.
+		 * This may contain part of ELF header. start
+		 * is the fpos for the oldmem region
+		 * If the file position corresponds to the second
+		 * kernel's memory, we just return zeroes
+		 */
+		p = start;
+		if ((p >= BACKUP_START) && (p < BACKUP_END)) {
+			if (clear_user(buffer, tsz)) {
+				acc = -EFAULT;
+				goto done;
+			}
+
+			goto read_done;
+		} else if (p < CRASH_RELOCATE_SIZE)
+			p += BACKUP_END;
+
+		pdup = p;
+		if (read_from_oldmem(buffer, tsz, &pdup, 1)) {
+			acc = -EINVAL;
+			goto done;
+		}
+
+read_done:
+		buflen -= tsz;
+		*fpos += tsz;
+		buffer += tsz;
+		acc += tsz;
+		start += tsz;
+		tsz = (buflen > PAGE_SIZE ? PAGE_SIZE : buflen);
+	}
+
+done:
+	return acc;
+}
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/include/linux/crash_dump.h linux-2.6.11-rc1-mm1-nokexec-crashdump-elf-format-dump-file-access/include/linux/crash_dump.h
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/include/linux/crash_dump.h	Tue Jan 18 23:16:24 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-elf-format-dump-file-access/include/linux/crash_dump.h	Tue Jan 18 23:16:57 2005
@@ -1,10 +1,23 @@
 #include <linux/kexec.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
+#include <linux/proc_fs.h>
 #ifdef CONFIG_CRASH_DUMP
 #include <asm/crash_dump.h>
 #endif
 
+extern unsigned long saved_max_pfn;
+extern struct memelfnote memelfnote;
+extern int notesize(struct memelfnote *);
+extern char *storenote(struct memelfnote *, char *);
+extern void elf_kcore_store_hdr(char *, int, int, struct kcore_list *);
+
 #ifdef CONFIG_CRASH_DUMP
+extern struct file_operations proc_vmcore_operations;
+extern struct proc_dir_entry *proc_vmcore;
+
+extern ssize_t copy_oldmem_page(unsigned long, char *, size_t, int);
+extern void crash_create_proc_entry(void);
 #else
+#define crash_create_proc_entry() do { } while(0)
 #endif

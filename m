Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUIONCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUIONCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUIONBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:01:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:17286 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266048AbUIOM41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:56:27 -0400
Date: Wed, 15 Sep 2004 18:26:31 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, mbligh@aracnet.com,
       ebiederm@xmission.com, litke@us.ibm.com
Subject: Re: [PATCH][5/6]ELF format dump file access
Message-ID: <20040915125631.GF15450@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040915125041.GA15450@in.ibm.com> <20040915125145.GB15450@in.ibm.com> <20040915125322.GC15450@in.ibm.com> <20040915125422.GD15450@in.ibm.com> <20040915125525.GE15450@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline
In-Reply-To: <20040915125525.GE15450@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore

--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kd-elf-269rc1-mm5.patch"



This patch contains the code that provides an ELF format interface to the
previous kernel's memory post kexec reboot.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>


---

 linux-2.6.9-rc1-hari/fs/proc/Makefile           |    1 
 linux-2.6.9-rc1-hari/fs/proc/kcore.c            |   10 -
 linux-2.6.9-rc1-hari/fs/proc/proc_misc.c        |   12 +
 linux-2.6.9-rc1-hari/fs/proc/vmcore.c           |  238 ++++++++++++++++++++++++
 linux-2.6.9-rc1-hari/include/linux/crash_dump.h |    8 
 linux-2.6.9-rc1-hari/include/linux/proc_fs.h    |    2 
 6 files changed, 266 insertions(+), 5 deletions(-)

diff -puN fs/proc/Makefile~kd-elf-269rc1-mm5 fs/proc/Makefile
--- linux-2.6.9-rc1/fs/proc/Makefile~kd-elf-269rc1-mm5	2004-09-15 17:36:53.000000000 +0530
+++ linux-2.6.9-rc1-hari/fs/proc/Makefile	2004-09-15 17:36:53.000000000 +0530
@@ -11,4 +11,5 @@ proc-y       += inode.o root.o base.o ge
 		kmsg.o proc_tty.o proc_misc.o
 
 proc-$(CONFIG_PROC_KCORE)	+= kcore.o
+proc-$(CONFIG_CRASH_DUMP)	+= vmcore.o
 proc-$(CONFIG_PROC_DEVICETREE)	+= proc_devtree.o
diff -puN fs/proc/kcore.c~kd-elf-269rc1-mm5 fs/proc/kcore.c
--- linux-2.6.9-rc1/fs/proc/kcore.c~kd-elf-269rc1-mm5	2004-09-15 17:36:53.000000000 +0530
+++ linux-2.6.9-rc1-hari/fs/proc/kcore.c	2004-09-15 17:36:53.000000000 +0530
@@ -114,7 +114,7 @@ static size_t get_kcore_size(int *nphdr,
 /*
  * determine size of ELF note
  */
-static int notesize(struct memelfnote *en)
+int notesize(struct memelfnote *en)
 {
 	int sz;
 
@@ -129,7 +129,7 @@ static int notesize(struct memelfnote *e
 /*
  * store a note in the header buffer
  */
-static char *storenote(struct memelfnote *men, char *bufp)
+char *storenote(struct memelfnote *men, char *bufp)
 {
 	struct elf_note en;
 
@@ -156,7 +156,7 @@ static char *storenote(struct memelfnote
  * store an ELF coredump header in the supplied buffer
  * nphdr is the number of elf_phdr to insert
  */
-static void elf_kcore_store_hdr(char *bufp, int nphdr, int dataoff)
+void elf_kcore_store_hdr(char *bufp, int nphdr, int dataoff, struct kcore_list *clist)
 {
 	struct elf_prstatus prstatus;	/* NT_PRSTATUS */
 	struct elf_prpsinfo prpsinfo;	/* NT_PRPSINFO */
@@ -208,7 +208,7 @@ static void elf_kcore_store_hdr(char *bu
 	nhdr->p_align	= 0;
 
 	/* setup ELF PT_LOAD program header for every area */
-	for (m=kclist; m; m=m->next) {
+	for (m=clist; m; m=m->next) {
 		phdr = (struct elf_phdr *) bufp;
 		bufp += sizeof(struct elf_phdr);
 		offset += sizeof(struct elf_phdr);
@@ -305,7 +305,7 @@ read_kcore(struct file *file, char __use
 			return -ENOMEM;
 		}
 		memset(elf_buf, 0, elf_buflen);
-		elf_kcore_store_hdr(elf_buf, nphdr, elf_buflen);
+		elf_kcore_store_hdr(elf_buf, nphdr, elf_buflen, kclist);
 		read_unlock(&kclist_lock);
 		if (copy_to_user(buffer, elf_buf + *fpos, tsz)) {
 			kfree(elf_buf);
diff -puN fs/proc/proc_misc.c~kd-elf-269rc1-mm5 fs/proc/proc_misc.c
--- linux-2.6.9-rc1/fs/proc/proc_misc.c~kd-elf-269rc1-mm5	2004-09-15 17:36:53.000000000 +0530
+++ linux-2.6.9-rc1-hari/fs/proc/proc_misc.c	2004-09-15 17:36:53.000000000 +0530
@@ -44,6 +44,7 @@
 #include <linux/jiffies.h>
 #include <linux/sysrq.h>
 #include <linux/vmalloc.h>
+#include <linux/bootmem.h>
 #include <linux/crash_dump.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -584,6 +585,7 @@ static struct file_operations proc_crash
 #endif
 
 struct proc_dir_entry *proc_root_kcore;
+struct proc_dir_entry *proc_vmcore;
 
 static void create_seq_entry(char *name, mode_t mode, struct file_operations *f)
 {
@@ -678,6 +680,16 @@ void __init proc_misc_init(void)
 				(size_t)high_memory - PAGE_OFFSET + PAGE_SIZE;
 	}
 #endif
+#ifdef CONFIG_CRASH_DUMP
+	if (dump_enabled) {
+		proc_vmcore = create_proc_entry("vmcore", S_IRUSR, NULL);
+		if (proc_vmcore) {
+			proc_vmcore->proc_fops = &proc_vmcore_operations;
+			proc_vmcore->size =
+			(size_t)(saved_max_pfn << PAGE_SHIFT);
+		}
+	}
+#endif
 #ifdef CONFIG_MAGIC_SYSRQ
 	entry = create_proc_entry("sysrq-trigger", S_IWUSR, NULL);
 	if (entry)
diff -puN /dev/null fs/proc/vmcore.c
--- /dev/null	2003-01-30 15:54:37.000000000 +0530
+++ linux-2.6.9-rc1-hari/fs/proc/vmcore.c	2004-09-15 17:36:53.000000000 +0530
@@ -0,0 +1,238 @@
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
+struct file_operations proc_vmcore_operations = {
+	.read		= read_vmcore,
+	.open		= open_vmcore,
+};
+
+#define BACKUP_START CRASH_BACKUP_BASE
+#define BACKUP_END CRASH_BACKUP_BASE + CRASH_BACKUP_SIZE
+#define REG_SIZE sizeof(elf_gregset_t)
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
+ * Reads from the oldmem device from given offset till
+ * given count
+ */
+static ssize_t read_from_oldmem(char *buf, size_t count,
+			     loff_t *ppos, int userbuf)
+{
+	unsigned long pfn, p = *ppos;
+	size_t read = 0;
+
+	pfn = p / PAGE_SIZE;
+	p = p % PAGE_SIZE;
+
+	if (pfn > saved_max_pfn) {
+		read = -EINVAL;
+		goto done;
+	}
+
+	if (count > PAGE_SIZE - p)
+		count = PAGE_SIZE - p;
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
+		if (read_from_oldmem(buffer, tsz, (loff_t *)&p, 1)) {
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
diff -puN include/linux/crash_dump.h~kd-elf-269rc1-mm5 include/linux/crash_dump.h
--- linux-2.6.9-rc1/include/linux/crash_dump.h~kd-elf-269rc1-mm5	2004-09-15 17:36:53.000000000 +0530
+++ linux-2.6.9-rc1-hari/include/linux/crash_dump.h	2004-09-15 17:36:53.000000000 +0530
@@ -1,8 +1,16 @@
 #include <linux/kexec.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
+#include <linux/proc_fs.h>
 #include <asm/crash_dump.h>
 
+extern unsigned long saved_max_pfn;
+extern struct memelfnote memelfnote;
+extern int notesize(struct memelfnote *);
+extern char *storenote(struct memelfnote *, char *);
+extern ssize_t copy_oldmem_page(unsigned long, char *, size_t, int);
+extern void elf_kcore_store_hdr(char *, int, int, struct kcore_list *);
+
 #ifdef CONFIG_CRASH_DUMP
 extern int crash_dump_on;
 static inline void crash_machine_kexec(void)
diff -puN include/linux/proc_fs.h~kd-elf-269rc1-mm5 include/linux/proc_fs.h
--- linux-2.6.9-rc1/include/linux/proc_fs.h~kd-elf-269rc1-mm5	2004-09-15 17:36:53.000000000 +0530
+++ linux-2.6.9-rc1-hari/include/linux/proc_fs.h	2004-09-15 17:36:53.000000000 +0530
@@ -82,6 +82,7 @@ extern struct proc_dir_entry *proc_net;
 extern struct proc_dir_entry *proc_bus;
 extern struct proc_dir_entry *proc_root_driver;
 extern struct proc_dir_entry *proc_root_kcore;
+extern struct proc_dir_entry *proc_vmcore;
 
 extern void proc_root_init(void);
 extern void proc_misc_init(void);
@@ -117,6 +118,7 @@ extern int proc_readdir(struct file *, v
 extern struct dentry *proc_lookup(struct inode *, struct dentry *, struct nameidata *);
 
 extern struct file_operations proc_kcore_operations;
+extern struct file_operations proc_vmcore_operations;
 extern struct file_operations proc_kmsg_operations;
 extern struct file_operations ppc_htab_operations;
 

_

--YkJPYEFdoxh/AXLE--

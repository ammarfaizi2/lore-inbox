Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVBPIuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVBPIuO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 03:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVBPIuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 03:50:14 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:12477 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261965AbVBPItv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 03:49:51 -0500
Date: Wed, 16 Feb 2005 17:49:51 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] /proc/cpumem
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <m14qgu81bw.fsf@ebiederm.dsl.xmission.com>
References: <20050203154433.18E4.ODA@valinux.co.jp> <m14qgu81bw.fsf@ebiederm.dsl.xmission.com>
Message-Id: <20050216170224.4C66.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eric and all

Attached is an implementation of /proc/cpumem.
/proc/cpumem shows the valid physical memory ranges.

* i386 and x86_64
* implement valid_phys_addr_range() and use it.
  (the first argument of the i386 version is little uncomfortable.)
* /dev/mem of the i386 version should be mofified. but not yet.

example: amd64 8GB Mem
# cat /proc/cpumem
0000000000000000 000000000009b800
0000000000100000 00000000fbe70000
0000000100000000 0000000100000000
#
start address and size. hex digit.

Any comments, recomendations and suggestions are welcom.

BTW, does not kexec/kdump run on 2.6.11-rc3-mm2 ?
How do I get and examine the latest kexec/kdump ?

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>

---
--- linux-2.6.11-rc3-mm2/drivers/char/mem.c	2005-02-16 15:36:31.000000000 +0900
+++ linux-2.6.11-rc3-mm2-test/drivers/char/mem.c	2005-02-16 23:32:15.244876816 +0900
@@ -25,6 +25,9 @@
 #include <linux/device.h>
 #include <linux/highmem.h>
 #include <linux/crash_dump.h>
+#include <linux/bootmem.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -759,3 +762,125 @@
 }
 
 fs_initcall(chr_dev_init);
+
+#ifdef CONFIG_PROC_FS
+/*
+ *  /proc/cpumem: show valid physical address range
+ */
+struct cpumem_info {
+	unsigned long long addr;
+	unsigned long long size;
+};
+
+static void *cpumem_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct cpumem_info *p = m->private;
+	unsigned long long end = (unsigned long long)max_pfn << PAGE_SHIFT;
+	unsigned long long addr;
+	size_t size;
+	int found = 0;
+
+	(*pos)++;
+
+	if (p->addr >= end) {
+		return NULL;
+	}
+
+	/* always start page boundary */
+	addr = ((p->addr + p->size + PAGE_SIZE - 1) >> PAGE_SHIFT) << PAGE_SHIFT;
+	size = 0xf0000000;
+
+	while (addr < end) {
+		if (valid_phys_addr_range(addr, &size)) {
+			if (!found) {
+				found = 1;
+				p->addr = addr;
+				p->size = size;
+			} else {
+				p->size += size;
+			}
+			addr += size;
+			size = 0xf0000000;
+		} else {
+			if (found) {
+				return p;
+			}
+			addr += PAGE_SIZE;
+		}
+	}
+
+	return found ? p : NULL;
+}
+
+static void *cpumem_start(struct seq_file *m, loff_t *pos)
+{
+	struct cpumem_info *p = m->private;
+	loff_t n = 0;
+
+	p->addr = 0;
+	p->size = 0;
+
+	while (n <= *pos) {
+		if (!cpumem_next(m, NULL, &n)) {
+			return NULL;
+		}
+	}
+
+	return p;
+}
+
+static void cpumem_stop(struct seq_file *m, void *v)
+{
+}
+
+static int cpumem_show(struct seq_file *m, void *v)
+{
+	struct cpumem_info *p = m->private;
+	unsigned long long end = (unsigned long long)max_pfn << PAGE_SHIFT;
+
+	if (p->addr < end) {
+		seq_printf(m, "%016llx %016llx\n", p->addr, p->size);
+	}
+	return 0;
+}
+
+struct seq_operations cpumem_op = {
+	.start	= cpumem_start,
+	.next	= cpumem_next,
+	.stop	= cpumem_stop,
+	.show	= cpumem_show
+};
+
+static int cpumem_open(struct inode *inode, struct file *file)
+{
+	int res = seq_open(file, &cpumem_op);
+	if (!res) {
+		struct seq_file *m = file->private_data;
+		m->private = kmalloc(sizeof(struct cpumem_info), GFP_KERNEL);
+		if (!m->private) {
+			seq_release(inode, file);
+			return -ENOMEM;
+		}
+	}
+	return res;
+}
+
+static struct file_operations proc_cpumem_operations = {
+	.open		= cpumem_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release_private
+};
+
+static int __init cpumem_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	entry = create_proc_entry("cpumem", 0, NULL);
+	if (entry) {
+		entry->proc_fops = &proc_cpumem_operations;
+	}
+	return 0;
+}
+__initcall(cpumem_init);
+#endif /* CONFIG_PROC_FS */

---
--- linux-2.6.11-rc3-mm2/arch/i386/mm/init.c	2005-02-16 15:36:29.000000000 +0900
+++ linux-2.6.11-rc3-mm2-test/arch/i386/mm/init.c	2005-02-16 23:32:29.499709752 +0900
@@ -248,6 +248,47 @@
 	return 0;
 }
 
+int valid_phys_addr_range(unsigned long long phys_addr, size_t *size)
+{
+	int i;
+	unsigned long long addr, end;
+	efi_memory_desc_t *md;
+
+	if (efi_enabled) {
+		for (i = 0; i < memmap.nr_map; i++) {
+			md = &memmap.map[i];
+			if (!is_available_memory(md)) {
+				continue;
+			}
+			addr = md->phys_addr;
+			end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT);
+			if ((phys_addr >= addr) && (phys_addr < end)) {
+				if (*size > end - phys_addr) {
+					*size = end - phys_addr;
+				}
+				return 1;
+			}
+		}
+		return 0;
+	}
+
+	for (i = 0; i < e820.nr_map; i++) {
+		if (e820.map[i].type != E820_RAM) {
+			continue;
+		}
+		addr = e820.map[i].addr;
+		end = e820.map[i].addr + e820.map[i].size;
+		if ((phys_addr >= addr) && (phys_addr < end)) {
+			if (*size > end - phys_addr) {
+				*size = end - phys_addr;
+			}
+			return 1;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL(valid_phys_addr_range);
+
 #ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
 pgprot_t kmap_prot;

---
--- linux-2.6.11-rc3-mm2/include/asm-i386/io.h	2004-12-25 06:35:40.000000000 +0900
+++ linux-2.6.11-rc3-mm2-test/include/asm-i386/io.h	2005-02-16 23:36:24.454991120 +0900
@@ -90,6 +90,12 @@
  */
 #define page_to_phys(page)    ((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
 
+/*
+ * for /dev/mem
+ */
+#define ARCH_HAS_VALID_PHYS_ADDR_RANGE
+extern int valid_phys_addr_range(unsigned long long, size_t *);
+
 extern void __iomem * __ioremap(unsigned long offset, unsigned long size, unsigned long flags);
 
 /**

---
--- linux-2.6.11-rc3-mm2/arch/x86_64/mm/init.c	2005-02-16 15:36:30.000000000 +0900
+++ linux-2.6.11-rc3-mm2-test/arch/x86_64/mm/init.c	2005-02-16 16:23:08.000000000 +0900
@@ -22,6 +22,7 @@
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
 #include <linux/proc_fs.h>
+#include <linux/module.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -395,6 +396,27 @@
 	return 0;
 }
 
+int valid_phys_addr_range(unsigned long phys_addr, size_t *size)
+{
+	int i;
+	unsigned long end;
+
+	for (i = 0; i < e820.nr_map; i++) {
+		if (e820.map[i].type != E820_RAM) {
+			continue;
+		}
+		end = e820.map[i].addr + e820.map[i].size;
+		if (phys_addr >= e820.map[i].addr && phys_addr < end) {
+			if (*size > end - phys_addr) {
+				*size = end - phys_addr;
+			}
+			return 1;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL(valid_phys_addr_range);
+
 extern int swiotlb_force;
 
 /*

---
--- linux-2.6.11-rc3-mm2/include/asm-x86_64/io.h	2005-02-16 15:36:12.000000000 +0900
+++ linux-2.6.11-rc3-mm2-test/include/asm-x86_64/io.h	2005-02-16 16:23:59.000000000 +0900
@@ -123,6 +123,9 @@
 {
 	return __va(address);
 }
+
+#define ARCH_HAS_VALID_PHYS_ADDR_RANGE
+extern int valid_phys_addr_range(unsigned long, size_t *);
 #endif
 
 /*

---


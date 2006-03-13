Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWCMSPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWCMSPb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWCMSPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:15:31 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:49677 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932294AbWCMSP3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:15:29 -0500
Date: Mon, 13 Mar 2006 10:15:25 -0800
Message-Id: <200603131815.k2DIFPa7005772@zach-dev.vmware.com>
Subject: [RFC, PATCH 21/24] i386 Vmi proc node
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
X-OriginalArrivalTime: 13 Mar 2006 18:15:25.0329 (UTC) FILETIME=[1996D010:01C646CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a /proc node for the VMI sub-arch, which gives information on the VMI ROM
detected using /proc/vmi/info and a list of kernel annotations in
/proc/vmi/annotations.

The timing information is VMware specific, and should probably be put into a
separate /proc node (and a separate patch for our internal use).

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/arch/i386/mach-vmi/proc.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/mach-vmi/proc.c	2006-03-08 11:02:57.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/mach-vmi/proc.c	2006-03-08 11:03:00.000000000 -0800
@@ -0,0 +1,194 @@
+/*
+ * VMI proc stats interface
+ *
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <asm/processor.h>
+#include <vmi.h>
+
+extern VROMHeader *vmi_rom;
+static struct proc_dir_entry *proc_vmi_root;
+
+struct pnp_header {
+	char sig[4];
+	char rev;
+	char size;
+	short next;
+	short res;
+	long devID;
+	unsigned short manufacturer_offset;
+	unsigned short product_offset;
+} __attribute__((packed));
+
+/* XXX This hack can only be used with passthrough TSC */
+static inline unsigned long long get_tsc(void)
+{
+        unsigned long long tsc;
+        asm volatile("rdtsc" : "=&A" (tsc));
+        return tsc;
+}
+
+static unsigned long long hypercall_cycles = 0xffffffffULL;
+static void time_hypercall(void)
+{
+	unsigned long long tsc_start, tsc_end, cycles;
+	int i;
+	for (i = 0; i < 1000; i++) {
+		tsc_start = get_tsc();
+		vmi_rdtsc();
+		tsc_end = get_tsc();
+		cycles = tsc_end - tsc_start;
+		if (cycles < hypercall_cycles)
+			hypercall_cycles = cycles;
+	}
+}
+
+static unsigned long long page_fault_cycles = 0xffffffffULL;
+static void time_page_fault(void)
+{
+	unsigned long long tsc_start, tsc_end, cycles;
+	int i;
+	for (i = 0; i < 1000; i++) {
+		tsc_start = get_tsc();
+		asm volatile(
+			"1:	mov %%eax,0	\n"
+			"2:			\n"
+			".section __ex_table,\"a\"\n"
+			"	.align 4	\n"
+			"	.long 1b,2b	\n"
+			".previous		\n"
+			::: "memory");
+		tsc_end = get_tsc();
+		cycles = tsc_end - tsc_start;
+		if (cycles < page_fault_cycles)
+			page_fault_cycles = cycles;
+	}
+}
+
+static int proc_vmi_info_show(struct seq_file *m, void *v)
+{
+	if (!hypervisor_found) 
+		seq_puts(m, "No VMI active\n");
+	else
+		seq_puts(m, "Hypervisor VMI active\n");
+	seq_printf(m, "Kernel VMI API version %d.%d\n", 
+		    VMI_API_REV_MAJOR, MIN_VMI_API_REV_MINOR);
+	if (vmi_rom) {
+		seq_printf(m, "VMI ROM API version: %d.%d\n",
+			 vmi_rom->APIVersionMajor, 
+			 vmi_rom->APIVersionMinor);
+		seq_printf(m, "        rom size: %d\n",
+			 vmi_rom->romLength * 512);
+		seq_printf(m, "        mapped at: %08x\n", (uint32_t)vmi_rom);
+		if (vmi_rom->pnpHeaderOffset) {
+			struct pnp_header *h = (struct pnp_header *)
+				((char *)vmi_rom+vmi_rom->pnpHeaderOffset);
+			seq_printf(m, "        manufacturer: %s\n",
+				 (char *)vmi_rom+h->manufacturer_offset);
+			seq_printf(m, "        product: %s\n",
+				 (char *)vmi_rom+h->product_offset);
+		}
+	}
+	time_hypercall();
+	seq_printf(m, "Hypercall cycle count: %lld\n", hypercall_cycles);
+	time_page_fault();
+	seq_printf(m, "Kernel #PF cycle count: %lld\n", page_fault_cycles);
+
+	return 0;
+}
+
+static int proc_vmi_info_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_vmi_info_show, NULL);
+}
+
+static struct file_operations proc_vmi_info_operations = {
+	.open		= proc_vmi_info_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#define VDEF(call) #call ,
+static char *vmi_call_name[] =  {
+   VMI_CALLS
+};
+#undef VDEF
+
+static void print_annotation(struct seq_file *m, struct vmi_annotation *a)
+{
+	seq_printf(m, "%s %p %d %p %d %d\n",
+		   vmi_call_name[a->vmi_call], a->nativeEIP, a->native_size,
+		   a->translationEIP, a->translation_size, a->nop_size);
+}
+
+static int proc_vmi_annotations_show(struct seq_file *m, void *v)
+{
+	struct vmi_annotation *start = __vmi_annotation;
+	struct vmi_annotation *end = __vmi_annotation_end;
+	struct vmi_annotation *a; 
+
+	for (a = start; a < end; a++) { 
+		print_annotation(m, a);
+	}
+	return 0;
+} 
+
+static int proc_vmi_annotations_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_vmi_annotations_show, NULL);
+}
+
+static struct file_operations proc_vmi_annotations_operations = {
+	.open		= proc_vmi_annotations_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init proc_vmi_init(void)
+{
+	struct proc_dir_entry *e;
+
+	proc_vmi_root = proc_mkdir("vmi", NULL);
+	if (proc_vmi_root) {
+		e = create_proc_entry("info", 0, proc_vmi_root);
+		if (e)
+			e->proc_fops = &proc_vmi_info_operations;
+		e = create_proc_entry("annotations", 0, proc_vmi_root);
+		if (e)
+			e->proc_fops = &proc_vmi_annotations_operations;
+	}
+	return 0;
+}
+
+__initcall(proc_vmi_init);
Index: linux-2.6.16-rc5/arch/i386/mach-vmi/Makefile
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/mach-vmi/Makefile	2006-03-08 11:02:43.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/mach-vmi/Makefile	2006-03-08 11:03:12.000000000 -0800
@@ -6,4 +6,4 @@ EXTRA_CFLAGS	+= -I../kernel
 
 export CFLAGS_stubs.o += -ffunction-sections
 
-obj-y	:= setup.o stubs.o stubs-asm.o smpboot_hooks.o
+obj-y	:= setup.o stubs.o stubs-asm.o smpboot_hooks.o proc.o

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWCMSGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWCMSGu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWCMSGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:06:49 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:36364 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932103AbWCMSGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:06:47 -0500
Date: Mon, 13 Mar 2006 10:06:45 -0800
Message-Id: <200603131806.k2DI6jlJ005700@zach-dev.vmware.com>
Subject: [RFC, PATCH 10/24] i386 Vmi descriptor changes
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
X-OriginalArrivalTime: 13 Mar 2006 18:06:45.0739 (UTC) FILETIME=[E3E3ABB0:01C646C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Descriptor and trap table cleanups.  Add cleanly written accessors for
IDT and GDT gates so the subarch may override them.  Note that this
allows the hypervisor to transparently tweak the DPL of the descriptors
as well as the RPL of segments in those descriptors, with no unnecessary
kernel code modification.  It also allows the hypervisor implementation
of the VMI to tweak the gates, allowing for custom exception frames or
extra layers of indirection above the guest fault / IRQ handlers.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/traps.c	2006-03-10 12:55:09.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/traps.c	2006-03-10 16:01:06.000000000 -0800
@@ -1043,20 +1043,6 @@ void __init trap_init_f00f_bug(void)
 }
 #endif
 
-#define _set_gate(gate_addr,type,dpl,addr,seg) \
-do { \
-  int __d0, __d1; \
-  __asm__ __volatile__ ("movw %%dx,%%ax\n\t" \
-	"movw %4,%%dx\n\t" \
-	"movl %%eax,%0\n\t" \
-	"movl %%edx,%1" \
-	:"=m" (*((long *) (gate_addr))), \
-	 "=m" (*(1+(long *) (gate_addr))), "=&a" (__d0), "=&d" (__d1) \
-	:"i" ((short) (0x8000+(dpl<<13)+(type<<8))), \
-	 "3" ((char *) (addr)),"2" ((seg) << 16)); \
-} while (0)
-
-
 /*
  * This needs to use 'idt_table' rather than 'idt', and
  * thus use the _nonmapped_ version of the IDT, as the
@@ -1065,7 +1051,7 @@ do { \
  */
 void set_intr_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,14,0,addr,__KERNEL_CS);
+	_set_gate(n, DESCTYPE_INT, addr, __KERNEL_CS);
 }
 
 /*
@@ -1073,22 +1059,22 @@ void set_intr_gate(unsigned int n, void 
  */
 static inline void set_system_intr_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n, 14, 3, addr, __KERNEL_CS);
+	_set_gate(n, DESCTYPE_INT | DESCTYPE_DPL3, addr, __KERNEL_CS);
 }
 
 static void __init set_trap_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,15,0,addr,__KERNEL_CS);
+	_set_gate(n, DESCTYPE_TRAP, addr, __KERNEL_CS);
 }
 
 static void __init set_system_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,15,3,addr,__KERNEL_CS);
+	_set_gate(n, DESCTYPE_TRAP | DESCTYPE_DPL3, addr, __KERNEL_CS);
 }
 
 static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
 {
-	_set_gate(idt_table+n,5,0,0,(gdt_entry<<3));
+	_set_gate(n, DESCTYPE_TASK, (void *)0, (gdt_entry<<3));
 }
 
 
Index: linux-2.6.16-rc5/include/asm-i386/desc.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/desc.h	2006-03-10 12:55:09.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/desc.h	2006-03-10 13:03:34.000000000 -0800
@@ -33,50 +33,66 @@ static inline struct desc_struct *get_cp
 	return (struct desc_struct *)per_cpu(cpu_gdt_descr, cpu).address;
 }
 
-#define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
-#define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
-
-#define load_gdt(dtr) __asm__ __volatile("lgdt %0"::"m" (*dtr))
-#define load_idt(dtr) __asm__ __volatile("lidt %0"::"m" (*dtr))
-#define load_tr(tr) __asm__ __volatile("ltr %0"::"mr" (tr))
-#define load_ldt(ldt) __asm__ __volatile("lldt %0"::"mr" (ldt))
-
-#define store_gdt(dtr) __asm__ ("sgdt %0":"=m" (*dtr))
-#define store_idt(dtr) __asm__ ("sidt %0":"=m" (*dtr))
-#define store_tr(tr) __asm__ ("str %0":"=mr" (tr))
-#define store_ldt(ldt) __asm__ ("sldt %0":"=mr" (ldt))
-
 /*
  * This is the ldt that every process will get unless we need
  * something other than this.
  */
 extern struct desc_struct default_ldt[];
+extern struct desc_struct idt_table[];
 extern void set_intr_gate(unsigned int irq, void * addr);
 
-#define _set_tssldt_desc(n,addr,limit,type) \
-__asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
-	"movw %w1,2(%2)\n\t" \
-	"rorl $16,%1\n\t" \
-	"movb %b1,4(%2)\n\t" \
-	"movb %4,5(%2)\n\t" \
-	"movb $0,6(%2)\n\t" \
-	"movb %h1,7(%2)\n\t" \
-	"rorl $16,%1" \
-	: "=m"(*(n)) : "q" (addr), "r"(n), "ir"(limit), "i"(type))
+static inline void pack_descriptor(__u32 *a, __u32 *b,
+	unsigned long base, unsigned long limit, unsigned char type, unsigned char flags)
+{
+	*a = ((base & 0xffff) << 16) | (limit & 0xffff);
+	*b = (base & 0xff000000) | ((base & 0xff0000) >> 16) |
+	     ((type & 0xff) << 8) | ((flags & 0xf) << 12);
+}
 
-static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
+static inline void pack_gate(__u32 *a, __u32 *b,
+	unsigned long base, unsigned short seg, unsigned char type, unsigned char flags)
 {
-	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[entry], (int)addr,
-		offsetof(struct tss_struct, __cacheline_filler) - 1, 0x89);
+	*a = (seg << 16) | (base & 0xffff);
+	*b = (base & 0xffff0000) | ((type & 0xff) << 8) | (flags & 0xff);
 }
 
-#define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
+#define DESCTYPE_LDT 	0x82	/* present, system, DPL-0, LDT */
+#define DESCTYPE_TSS 	0x89	/* present, system, DPL-0, 32-bit TSS */
+#define DESCTYPE_TASK	0x85	/* present, system, DPL-0, task gate */
+#define DESCTYPE_INT	0x8e	/* present, system, DPL-0, interrupt gate */
+#define DESCTYPE_TRAP	0x8f	/* present, system, DPL-0, trap gate */
+#define DESCTYPE_DPL3	0x60	/* DPL-3 */
+#define DESCTYPE_S	0x10	/* !system */
+
+#include <mach_desc.h>
+
+static inline void _set_gate(int gate, unsigned int type, void *addr, unsigned short seg)
+{
+	__u32 a, b;
+	pack_gate(&a, &b, (unsigned long)addr, seg, type, 0);
+	write_idt_entry(idt_table, gate, a, b);
+}
+
+static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, const void *addr)
+{
+	__u32 a, b;
+	pack_descriptor(&a, &b, (unsigned long)addr,
+			offsetof(struct tss_struct, __cacheline_filler) - 1,
+			DESCTYPE_TSS, 0);
+	write_gdt_entry(get_cpu_gdt_table(cpu), entry, a, b);
+}
 
-static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
+static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int entries)
 {
-	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
+	__u32 a, b;
+	pack_descriptor(&a, &b, (unsigned long)addr,
+			entries * sizeof(struct desc_struct) - 1,
+			DESCTYPE_LDT, 0);
+	write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, a, b);
 }
 
+#define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
+
 #define LDT_entry_a(info) \
 	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
 
@@ -102,24 +118,6 @@ static inline void set_ldt_desc(unsigned
 	(info)->seg_not_present	== 1	&& \
 	(info)->useable		== 0	)
 
-static inline void write_ldt_entry(void *ldt, int entry, __u32 entry_a, __u32 entry_b)
-{
-	__u32 *lp = (__u32 *)((char *)ldt + entry*8);
-	*lp = entry_a;
-	*(lp+1) = entry_b;
-}
-
-#if TLS_SIZE != 24
-# error update this code.
-#endif
-
-static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
-{
-#define C(i) get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
-	C(0); C(1); C(2);
-#undef C
-}
-
 static inline void clear_LDT(void)
 {
 	int cpu = get_cpu();
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_desc.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/mach_desc.h	2006-03-10 13:03:34.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_desc.h	2006-03-10 13:03:34.000000000 -0800
@@ -0,0 +1,171 @@
+/*
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
+#ifndef __MACH_DESC_H
+#define __MACH_DESC_H
+
+#include <vmi.h>
+
+#if !defined(CONFIG_X86_VMI)
+# error invalid sub-arch include
+#endif
+
+static inline void load_gdt(VMI_DTR *const dtr)
+{
+	vmi_wrap_call(
+		SetGDT, "lgdt (%0)",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1 (dtr),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline void load_idt(VMI_DTR *const dtr)
+{
+	vmi_wrap_call(
+		SetIDT, "lidt (%0)",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1 (dtr),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline void load_ldt(const VMI_SELECTOR sel)
+{
+	vmi_wrap_call(
+		SetLDT, "lldt %w0",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1 (sel),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline void load_tr(const VMI_SELECTOR sel)
+{
+	vmi_wrap_call(
+		SetTR, "ltr %w0",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1 (sel),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline void store_gdt(VMI_DTR *const dtr)
+{
+	vmi_wrap_call(
+		GetGDT, "sgdt (%0)",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1 (dtr),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline void store_idt(VMI_DTR *const dtr)
+{
+	vmi_wrap_call(GetIDT, "sidt (%0)",
+		VMI_NO_OUTPUT,
+		1, VMI_IREG1 (dtr),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline VMI_SELECTOR vmi_get_ldt(void)
+{
+	VMI_SELECTOR ret;
+	vmi_wrap_call(
+		GetLDT, "sldt %%ax",
+		VMI_OREG1 (ret),
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER(ONE_RETURN));
+	return ret;
+}
+
+static inline VMI_SELECTOR vmi_get_tr(void)
+{
+	VMI_SELECTOR ret;
+	vmi_wrap_call(
+		GetTR, "str %%ax",
+		VMI_OREG1 (ret),
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER(ONE_RETURN));
+	return ret;
+}
+
+#define load_TR_desc() load_tr(GDT_ENTRY_TSS*8)
+#define load_LDT_desc() load_ldt(GDT_ENTRY_LDT*8)
+
+#define store_tr(tr) do { (tr) = vmi_get_tr(); } while (0)
+#define store_ldt(ldt) do { (ldt) = vmi_get_ldt(); } while (0)
+
+static inline void vmi_write_gdt(void *gdt, unsigned entry, u32 descLo, u32 descHi)
+{
+	vmi_wrap_call(
+		WriteGDTEntry, "movl %2, (%0,%1,8);"
+			       "movl %3, 4(%0,%1,8);",
+		VMI_NO_OUTPUT,
+		4, XCONC(VMI_IREG1(gdt), VMI_IREG2(entry), VMI_IREG3(descLo), VMI_IREG4(descHi)),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline void vmi_write_ldt(void *ldt, unsigned entry, u32 descLo, u32 descHi)
+{
+	vmi_wrap_call(
+		WriteLDTEntry, "movl %2, (%0,%1,8);"
+			       "movl %3, 4(%0,%1,8);",
+		VMI_NO_OUTPUT,
+		4, XCONC(VMI_IREG1(ldt), VMI_IREG2(entry), VMI_IREG3(descLo), VMI_IREG4(descHi)),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline void vmi_write_idt(void *idt, unsigned entry, u32 descLo, u32 descHi)
+{
+	vmi_wrap_call(
+		WriteIDTEntry, "movl %2, (%0,%1,8);"
+			       "movl %3, 4(%0,%1,8);",
+		VMI_NO_OUTPUT,
+		4, XCONC(VMI_IREG1(idt), VMI_IREG2(entry), VMI_IREG3(descLo), VMI_IREG4(descHi)),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
+{
+	unsigned i;
+	struct desc_struct *gdt = get_cpu_gdt_table(cpu);
+	for (i = 0; i < TLS_SIZE / sizeof(struct desc_struct); i++) {
+		unsigned cur = i + GDT_ENTRY_TLS_MIN;
+		if (gdt[cur].a != t->tls_array[i].a || gdt[cur].b != t->tls_array[i].b) {
+			vmi_write_gdt(gdt, cur, t->tls_array[i].a, t->tls_array[i].b);
+		}
+        }
+}
+
+static inline void write_gdt_entry(void *gdt, int entry, __u32 entry_a, __u32 entry_b)
+{
+        vmi_write_gdt(gdt, entry, entry_a, entry_b);
+}
+
+static inline void write_ldt_entry(void *ldt, int entry, __u32 entry_a, __u32 entry_b)
+{
+	vmi_write_ldt(ldt, entry, entry_a, entry_b);
+}
+
+static inline void write_idt_entry(void *idt, int entry, __u32 entry_a, __u32 entry_b)
+{
+        vmi_write_idt(idt, entry, entry_a, entry_b);
+}
+#endif
Index: linux-2.6.16-rc5/include/asm-i386/mach-default/mach_desc.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-default/mach_desc.h	2006-03-10 13:03:34.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-default/mach_desc.h	2006-03-10 16:01:18.000000000 -0800
@@ -0,0 +1,39 @@
+#ifndef __MACH_DESC_H
+#define __MACH_DESC_H
+
+#define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
+#define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
+
+#define load_gdt(dtr) __asm__ __volatile("lgdt %0"::"m" (*dtr))
+#define load_idt(dtr) __asm__ __volatile("lidt %0"::"m" (*dtr))
+#define load_tr(tr) __asm__ __volatile("ltr %0"::"m" (tr))
+#define load_ldt(ldt) __asm__ __volatile("lldt %0"::"m" (ldt))
+
+#define store_gdt(dtr) __asm__ ("sgdt %0":"=m" (*dtr))
+#define store_idt(dtr) __asm__ ("sidt %0":"=m" (*dtr))
+#define store_tr(tr) __asm__ ("str %0":"=m" (tr))
+#define store_ldt(ldt) __asm__ ("sldt %0":"=m" (ldt))
+
+#if TLS_SIZE != 24
+# error update this code.
+#endif
+
+static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
+{
+#define C(i) get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
+	C(0); C(1); C(2);
+#undef C
+}
+
+static inline void write_dt_entry(void *dt, int entry, __u32 entry_a, __u32 entry_b)
+{
+	__u32 *lp = (__u32 *)((char *)dt + entry*8);
+	*lp = entry_a;
+	*(lp+1) = entry_b;
+}
+
+#define write_ldt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
+#define write_gdt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
+#define write_idt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
+
+#endif

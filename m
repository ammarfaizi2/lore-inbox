Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbWEIIyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWEIIyN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWEIItS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:49:18 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:49795 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751539AbWEIItC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:02 -0400
Message-Id: <20060509085155.177937000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:18 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 18/35] Support gdt/idt/ldt handling on Xen.
Content-Disposition: inline; filename=i386-desc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the macros which handle gdt/idt/ldt's into a subarch include
file and add implementations for running on Xen.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/asm-i386/desc.h                   |   65 ++--------------------------
 include/asm-i386/mach-default/mach_desc.h |   67 +++++++++++++++++++++++++++++
 include/asm-i386/mach-xen/mach_desc.h     |   69 ++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 60 deletions(-)

--- linus-2.6.orig/include/asm-i386/desc.h
+++ linus-2.6/include/asm-i386/desc.h
@@ -33,18 +33,7 @@ static inline struct desc_struct *get_cp
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
+#include <mach_desc.h>
 
 /*
  * This is the ldt that every process will get unless we need
@@ -53,30 +42,6 @@ static inline struct desc_struct *get_cp
 extern struct desc_struct default_ldt[];
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
-
-static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
-{
-	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[entry], (int)addr,
-		offsetof(struct tss_struct, __cacheline_filler) - 1, 0x89);
-}
-
-#define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
-
-static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
-{
-	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
-}
-
 #define LDT_entry_a(info) \
 	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
 
@@ -102,30 +67,11 @@ static inline void set_ldt_desc(unsigned
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
 
-	set_ldt_desc(cpu, &default_ldt[0], 5);
-	load_LDT_desc();
+	__set_ldt(cpu, DEFAULT_LDT, DEFAULT_LDT_SIZE);
 	put_cpu();
 }
 
@@ -138,12 +84,11 @@ static inline void load_LDT_nolock(mm_co
 	int count = pc->size;
 
 	if (likely(!count)) {
-		segments = &default_ldt[0];
-		count = 5;
+		segments = DEFAULT_LDT;
+		count = DEFAULT_LDT_SIZE;
 	}
 		
-	set_ldt_desc(cpu, segments, count);
-	load_LDT_desc();
+	__set_ldt(cpu, segments, count);
 }
 
 static inline void load_LDT(mm_context_t *pc)
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-default/mach_desc.h
@@ -0,0 +1,67 @@
+#ifndef __ASM_MACH_DESC_H
+#define __ASM_MACH_DESC_H
+
+#define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
+#define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
+
+#define load_gdt(dtr) __asm__ __volatile("lgdt %0"::"m" (*dtr))
+#define load_idt(dtr) __asm__ __volatile("lidt %0"::"m" (*dtr))
+#define load_tr(tr) __asm__ __volatile("ltr %0"::"mr" (tr))
+#define load_ldt(ldt) __asm__ __volatile("lldt %0"::"mr" (ldt))
+
+#define store_gdt(dtr) __asm__ ("sgdt %0":"=m" (*dtr))
+#define store_idt(dtr) __asm__ ("sidt %0":"=m" (*dtr))
+#define store_tr(tr) __asm__ ("str %0":"=mr" (tr))
+#define store_ldt(ldt) __asm__ ("sldt %0":"=mr" (ldt))
+
+#define _set_tssldt_desc(n,addr,limit,type) \
+__asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
+	"movw %w1,2(%2)\n\t" \
+	"rorl $16,%1\n\t" \
+	"movb %b1,4(%2)\n\t" \
+	"movb %4,5(%2)\n\t" \
+	"movb $0,6(%2)\n\t" \
+	"movb %h1,7(%2)\n\t" \
+	"rorl $16,%1" \
+	: "=m"(*(n)) : "q" (addr), "r"(n), "ir"(limit), "i"(type))
+
+static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
+{
+	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[entry], (int)addr,
+		offsetof(struct tss_struct, __cacheline_filler) - 1, 0x89);
+}
+
+#define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
+
+static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
+{
+	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
+}
+
+#define DEFAULT_LDT &default_ldt[0]
+#define DEFAULT_LDT_SIZE 5
+static inline void __set_ldt(unsigned int cpu, void *addr, unsigned int size)
+{
+	set_ldt_desc(cpu, addr, size);
+	load_LDT_desc();
+}
+
+static inline void write_ldt_entry(void *ldt, int entry, __u32 entry_a, __u32 entry_b)
+{
+	__u32 *lp = (__u32 *)((char *)ldt + entry*8);
+	*lp = entry_a;
+	*(lp+1) = entry_b;
+}
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
+#endif /* __ASM_MACH_DESC_H */
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-xen/mach_desc.h
@@ -0,0 +1,69 @@
+#ifndef __ASM_MACH_DESC_H
+#define __ASM_MACH_DESC_H
+
+extern struct trap_info xen_trap_table[];
+
+#define load_TR_desc()
+
+#define load_gdt(dtr) do {						\
+	struct Xgt_desc_struct *gdt_descr = (dtr);			\
+	unsigned long frames[16];					\
+	unsigned long va;						\
+	int f;								\
+									\
+	for (va = gdt_descr->address, f = 0;				\
+	     va < gdt_descr->address + gdt_descr->size;			\
+	     va += PAGE_SIZE, f++) {					\
+		frames[f] = virt_to_mfn(va);				\
+		make_lowmem_page_readonly(				\
+			(void *)va, XENFEAT_writable_descriptor_tables); \
+	}								\
+	if (HYPERVISOR_set_gdt(frames, gdt_descr->size / 8))		\
+		BUG();							\
+} while (0)
+
+#define load_idt(dtr) HYPERVISOR_set_trap_table(xen_trap_table)
+#define load_tr(tr) __asm__ __volatile("ltr %0"::"mr" (tr))
+#define load_ldt(ldt) __asm__ __volatile("lldt %0"::"mr" (ldt))
+
+#define store_gdt(dtr) __asm__ ("sgdt %0":"=m" (*dtr))
+#define store_idt(dtr) __asm__ ("sidt %0":"=m" (*dtr))
+#define store_tr(tr) __asm__ ("str %0":"=mr" (tr))
+#define store_ldt(ldt) __asm__ ("sldt %0":"=mr" (ldt))
+
+#define set_tss_desc(cpu,addr)
+
+static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
+{
+}
+
+#define DEFAULT_LDT NULL
+#define DEFAULT_LDT_SIZE 0
+static inline void __set_ldt(unsigned int cpu, void *addr, unsigned int size)
+{
+	struct mmuext_op op;
+	op.cmd = MMUEXT_SET_LDT;
+	op.arg1.linear_addr = (unsigned long)addr;
+	op.arg2.nr_ents = size;
+	BUG_ON(HYPERVISOR_mmuext_op(&op, 1, NULL, DOMID_SELF) < 0);
+}
+
+#define write_ldt_entry(ldt, entry, entry_a, entry_b) do {	\
+        __u32 *lp = (__u32 *)((char *)ldt + entry * 8);		\
+        maddr_t mach_lp = arbitrary_virt_to_machine(lp);	\
+        HYPERVISOR_update_descriptor(				\
+                mach_lp, (u64)entry_a | ((u64)entry_b<<32));	\
+} while (0)
+
+#if TLS_SIZE != 24
+# error update this code.
+#endif
+
+static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
+{
+#define C(i) HYPERVISOR_update_descriptor(virt_to_machine(&get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i]), *(u64 *)&t->tls_array[i])
+	C(0); C(1); C(2);
+#undef C
+}
+
+#endif /* __ASM_MACH_DESC_H */

--

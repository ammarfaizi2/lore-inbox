Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVHGBNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVHGBNm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 21:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVHGBMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 21:12:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61140 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261397AbVHGBK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 21:10:57 -0400
Date: Sat, 6 Aug 2005 18:10:43 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, hpa@zytor.com, Riley@Williams.Name,
       pratap@vmware.com, chrisl@vmware.com
Subject: Re: [PATCH] 5/8 Move descriptor table management into the sub-arch layer
Message-ID: <20050807011043.GJ7762@shell0.pdx.osdl.net>
References: <42F4643E.4030402@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F4643E.4030402@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> This change encapsulates descriptor and task register management.

These will need some merging together, will take a stab tomorrow.


--- linux-2.6.12-xen0-arch.orig/include/asm-i386/desc.h
+++ linux-2.6.12-xen0-arch/include/asm-i386/desc.h
@@ -14,9 +14,6 @@
 
 #include <asm/mmu.h>
 
-extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
-DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
-
 DECLARE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 
 struct Xgt_desc_struct {
@@ -37,30 +34,16 @@ extern struct Xgt_desc_struct idt_descr,
 extern struct desc_struct default_ldt[];
 extern void set_intr_gate(unsigned int irq, void * addr);
 
-#define _set_tssldt_desc(n,addr,limit,type) \
-__asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
-	"movw %%ax,2(%2)\n\t" \
-	"rorl $16,%%eax\n\t" \
-	"movb %%al,4(%2)\n\t" \
-	"movb %4,5(%2)\n\t" \
-	"movb $0,6(%2)\n\t" \
-	"movb %%ah,7(%2)\n\t" \
-	"rorl $16,%%eax" \
-	: "=m"(*(n)) : "a" (addr), "r"(n), "ir"(limit), "i"(type))
+#include <mach_desc.h>
 
 static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
 {
-	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[entry], (int)addr,
+	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[entry], (int)addr,
 		offsetof(struct tss_struct, __cacheline_filler) - 1, 0x89);
 }
 
 #define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
 
-static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
-{
-	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
-}
-
 #define LDT_entry_a(info) \
 	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
 
@@ -90,39 +73,6 @@ static inline void set_ldt_desc(unsigned
 # error update this code.
 #endif
 
-static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
-{
-#define C(i) per_cpu(cpu_gdt_table, cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
-	C(0); C(1); C(2);
-#undef C
-}
-
-static inline void clear_LDT(void)
-{
-	int cpu = get_cpu();
-
-	set_ldt_desc(cpu, &default_ldt[0], 5);
-	load_LDT_desc();
-	put_cpu();
-}
-
-/*
- * load one particular LDT into the current CPU
- */
-static inline void load_LDT_nolock(mm_context_t *pc, int cpu)
-{
-	void *segments = pc->ldt;
-	int count = pc->size;
-
-	if (likely(!count)) {
-		segments = &default_ldt[0];
-		count = 5;
-	}
-		
-	set_ldt_desc(cpu, segments, count);
-	load_LDT_desc();
-}
-
 static inline void load_LDT(mm_context_t *pc)
 {
 	int cpu = get_cpu();
--- /dev/null
+++ linux-2.6.12-xen0-arch/include/asm-i386/mach-default/mach_desc.h
@@ -0,0 +1,57 @@
+#ifndef __ASM_MACH_DESC_H
+#define __ASM_MACH_DESC_H
+
+extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
+DECLARE_PER_CPU(struct desc_struct, cpu_gdt_table[GDT_ENTRIES]);
+#define get_cpu_gdt_table(_cpu) per_cpu(cpu_gdt_table, cpu)
+
+#define _set_tssldt_desc(n,addr,limit,type) \
+__asm__ __volatile__ ("movw %w3,0(%2)\n\t" \
+	"movw %%ax,2(%2)\n\t" \
+	"rorl $16,%%eax\n\t" \
+	"movb %%al,4(%2)\n\t" \
+	"movb %4,5(%2)\n\t" \
+	"movb $0,6(%2)\n\t" \
+	"movb %%ah,7(%2)\n\t" \
+	"rorl $16,%%eax" \
+	: "=m"(*(n)) : "a" (addr), "r"(n), "ir"(limit), "i"(type))
+
+static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
+{
+	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
+}
+
+static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
+{
+#define C(i) get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
+	C(0); C(1); C(2);
+#undef C
+}
+
+static inline void clear_LDT(void)
+{
+	int cpu = get_cpu();
+
+	set_ldt_desc(cpu, &default_ldt[0], 5);
+	load_LDT_desc();
+	put_cpu();
+}
+
+/*
+ * load one particular LDT into the current CPU
+ */
+static inline void load_LDT_nolock(mm_context_t *pc, int cpu)
+{
+	void *segments = pc->ldt;
+	int count = pc->size;
+
+	if (likely(!count)) {
+		segments = &default_ldt[0];
+		count = 5;
+	}
+		
+	set_ldt_desc(cpu, segments, count);
+	load_LDT_desc();
+}
+
+#endif

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932683AbWHJTnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbWHJTnr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWHJTnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:43:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13804 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932685AbWHJTh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:29 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [128/145] i386: Descriptor and trap table cleanups.  
Message-Id: <20060810193727.D031C13B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:27 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Rusty Russell <rusty@rustcorp.com.au>

The implementation comes from Zach's [RFC, PATCH 10/24] i386 Vmi
descriptor changes:

Descriptor and trap table cleanups.  Add cleanly written accessors for
IDT and GDT gates so the subarch may override them.  Note that this
allows the hypervisor to transparently tweak the DPL of the descriptors
as well as the RPL of segments in those descriptors, with no unnecessary
kernel code modification.  It also allows the hypervisor implementation
of the VMI to tweak the gates, allowing for custom exception frames or
extra layers of indirection above the guest fault / IRQ handlers.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/traps.c |   24 +--------
 include/asm-i386/desc.h  |  119 +++++++++++++++++++++++++++++------------------
 2 files changed, 80 insertions(+), 63 deletions(-)

Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c
+++ linux/arch/i386/kernel/traps.c
@@ -1156,20 +1156,6 @@ void __init trap_init_f00f_bug(void)
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
@@ -1178,7 +1164,7 @@ do { \
  */
 void set_intr_gate(unsigned int n, void *addr)
 {
-	_set_gate(idt_table+n,14,0,addr,__KERNEL_CS);
+	_set_gate(n, DESCTYPE_INT, addr, __KERNEL_CS);
 }
 
 /*
@@ -1186,22 +1172,22 @@ void set_intr_gate(unsigned int n, void 
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
 
 
Index: linux/include/asm-i386/desc.h
===================================================================
--- linux.orig/include/asm-i386/desc.h
+++ linux/include/asm-i386/desc.h
@@ -33,50 +33,99 @@ static inline struct desc_struct *get_cp
 	return (struct desc_struct *)per_cpu(cpu_gdt_descr, cpu).address;
 }
 
+/*
+ * This is the ldt that every process will get unless we need
+ * something other than this.
+ */
+extern struct desc_struct default_ldt[];
+extern struct desc_struct idt_table[];
+extern void set_intr_gate(unsigned int irq, void * addr);
+
+static inline void pack_descriptor(__u32 *a, __u32 *b,
+	unsigned long base, unsigned long limit, unsigned char type, unsigned char flags)
+{
+	*a = ((base & 0xffff) << 16) | (limit & 0xffff);
+	*b = (base & 0xff000000) | ((base & 0xff0000) >> 16) |
+	     ((type & 0xff) << 8) | ((flags & 0xf) << 12);
+}
+
+static inline void pack_gate(__u32 *a, __u32 *b,
+	unsigned long base, unsigned short seg, unsigned char type, unsigned char flags)
+{
+	*a = (seg << 16) | (base & 0xffff);
+	*b = (base & 0xffff0000) | ((type & 0xff) << 8) | (flags & 0xff);
+}
+
+#define DESCTYPE_LDT 	0x82	/* present, system, DPL-0, LDT */
+#define DESCTYPE_TSS 	0x89	/* present, system, DPL-0, 32-bit TSS */
+#define DESCTYPE_TASK	0x85	/* present, system, DPL-0, task gate */
+#define DESCTYPE_INT	0x8e	/* present, system, DPL-0, interrupt gate */
+#define DESCTYPE_TRAP	0x8f	/* present, system, DPL-0, trap gate */
+#define DESCTYPE_DPL3	0x60	/* DPL-3 */
+#define DESCTYPE_S	0x10	/* !system */
+
 #define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
 #define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
 
 #define load_gdt(dtr) __asm__ __volatile("lgdt %0"::"m" (*dtr))
 #define load_idt(dtr) __asm__ __volatile("lidt %0"::"m" (*dtr))
-#define load_tr(tr) __asm__ __volatile("ltr %0"::"mr" (tr))
-#define load_ldt(ldt) __asm__ __volatile("lldt %0"::"mr" (ldt))
+#define load_tr(tr) __asm__ __volatile("ltr %0"::"m" (tr))
+#define load_ldt(ldt) __asm__ __volatile("lldt %0"::"m" (ldt))
 
 #define store_gdt(dtr) __asm__ ("sgdt %0":"=m" (*dtr))
 #define store_idt(dtr) __asm__ ("sidt %0":"=m" (*dtr))
-#define store_tr(tr) __asm__ ("str %0":"=mr" (tr))
-#define store_ldt(ldt) __asm__ ("sldt %0":"=mr" (ldt))
+#define store_tr(tr) __asm__ ("str %0":"=m" (tr))
+#define store_ldt(ldt) __asm__ ("sldt %0":"=m" (ldt))
 
-/*
- * This is the ldt that every process will get unless we need
- * something other than this.
- */
-extern struct desc_struct default_ldt[];
-extern void set_intr_gate(unsigned int irq, void * addr);
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
+#define write_ldt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
+#define write_gdt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
+#define write_idt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
 
-static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
+static inline void _set_gate(int gate, unsigned int type, void *addr, unsigned short seg)
 {
-	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[entry], (int)addr,
-		offsetof(struct tss_struct, __cacheline_filler) - 1, 0x89);
+	__u32 a, b;
+	pack_gate(&a, &b, (unsigned long)addr, seg, type, 0);
+	write_idt_entry(idt_table, gate, a, b);
 }
 
-#define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
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
 
@@ -102,24 +151,6 @@ static inline void set_ldt_desc(unsigned
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

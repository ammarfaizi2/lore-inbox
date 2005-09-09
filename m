Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbVIIH5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbVIIH5X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 03:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbVIIH5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 03:57:23 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:20436
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751438AbVIIH5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 03:57:22 -0400
Message-Id: <43215CC502000078000247E8@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 09:58:29 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix i386 double fault handler
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartFFDD90B5.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartFFDD90B5.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Make the double fault handler use CPU-specific stacks, add some
abstraction
to simplify future change of other exception handlers to go through
task
gates. Change the pointer validity checks in the double fault handler
to
account for the fact that both GDT and TSS aren't in static kernel
space
anymore.

This patch depends upon the presence of THREAD_ORDER, as added in a
previously submitted patch.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/i386/kernel/cpu/common.c
2.6.13-i386-double-fault/arch/i386/kernel/cpu/common.c
--- 2.6.13/arch/i386/kernel/cpu/common.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-i386-double-fault/arch/i386/kernel/cpu/common.c	2005-09-08
15:00:54.000000000 +0200
@@ -4,6 +4,7 @@
 #include <linux/smp.h>
 #include <linux/module.h>
 #include <linux/percpu.h>
+#include <linux/bootmem.h>
 #include <asm/semaphore.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
@@ -571,6 +572,7 @@ void __init early_cpu_init(void)
 void __devinit cpu_init(void)
 {
 	int cpu = smp_processor_id();
+	unsigned i;
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
 	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
@@ -635,8 +637,57 @@ void __devinit cpu_init(void)
 	load_TR_desc();
 	load_LDT(&init_mm.context);
 
-	/* Set up doublefault TSS pointer in the GDT */
-	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS,
&doublefault_tss);
+#if EXCEPTION_STACK_ORDER > THREAD_ORDER
+# error Assertion failed: EXCEPTION_STACK_ORDER <= THREAD_ORDER
+#endif
+	for (i = 0; i < N_EXCEPTION_TSS; ++i) {
+		unsigned long stack;
+
+		/* Set up exception handling TSS */
+		exception_tss[cpu][i].esp2 = cpu;
+		exception_tss[cpu][i].esi = (unsigned
long)&exception_tss[cpu][i];
+
+		/* Set up exception handling stacks */
+#ifdef CONFIG_SMP
+		if (cpu) {
+			stack = __get_free_pages(GFP_ATOMIC,
THREAD_ORDER);
+			if (!stack)
+				panic("Cannot allocate exception stack
%u %d\n",
+				      i,
+				      cpu);
+		}
+		else
+#endif
+			stack = (unsigned
long)__alloc_bootmem(EXCEPTION_STKSZ,
+			                                      
THREAD_SIZE,
+			                                      
__pa(MAX_DMA_ADDRESS));
+		stack += EXCEPTION_STKSZ;
+		exception_tss[cpu][i].esp = exception_tss[cpu][i].esp0 =
stack;
+#ifdef CONFIG_SMP
+		if (cpu) {
+			unsigned j;
+
+			for (j = EXCEPTION_STACK_ORDER; j <
THREAD_ORDER; ++j) {
+				/* set_page_refs sets the page count
only for the first
+				   page, but since we split the
larger-order page here,
+				   we need to adjust the page count
before freeing the
+				   pieces. */
+				struct page * page = virt_to_page((void
*)stack);
+
+				BUG_ON(page_count(page));
+				set_page_count(page, 1);
+				free_pages(stack, j);
+				stack += (PAGE_SIZE << j);
+			}
+		}
+		else
+#endif
+		if (EXCEPTION_STACK_ORDER > THREAD_ORDER)
+			free_bootmem(stack, THREAD_SIZE -
EXCEPTION_STKSZ);
+
+		/* Set up exception handling TSS pointer in the GDT */
+		__set_tss_desc(cpu, GDT_ENTRY_EXCEPTION_TSS + i,
&exception_tss[cpu][i]);
+	}
 
 	/* Clear %fs and %gs. */
 	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax,
%gs");
diff -Npru 2.6.13/arch/i386/kernel/doublefault.c
2.6.13-i386-double-fault/arch/i386/kernel/doublefault.c
--- 2.6.13/arch/i386/kernel/doublefault.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-i386-double-fault/arch/i386/kernel/doublefault.c	2005-09-09
09:37:02.000000000 +0200
@@ -9,13 +9,11 @@
 #include <asm/processor.h>
 #include <asm/desc.h>
 
-#define DOUBLEFAULT_STACKSIZE (1024)
-static unsigned long doublefault_stack[DOUBLEFAULT_STACKSIZE];
-#define STACK_START (unsigned
long)(doublefault_stack+DOUBLEFAULT_STACKSIZE)
+extern unsigned long max_low_pfn;
+#define ptr_ok(x, l) ((x) >= PAGE_OFFSET \
+                      && (x) + (l) <= PAGE_OFFSET + max_low_pfn *
PAGE_SIZE - 1)
 
-#define ptr_ok(x) ((x) > PAGE_OFFSET && (x) < PAGE_OFFSET +
0x1000000)
-
-static void doublefault_fn(void)
+void doublefault_fn(void)
 {
 	struct Xgt_desc_struct gdt_desc = {0, 0};
 	unsigned long gdt, tss;
@@ -23,43 +21,26 @@ static void doublefault_fn(void)
 	__asm__ __volatile__("sgdt %0": "=m" (gdt_desc): :"memory");
 	gdt = gdt_desc.address;
 
-	printk("double fault, gdt at %08lx [%d bytes]\n", gdt,
gdt_desc.size);
+	printk("double fault, gdt at %08lx [%d bytes]\n", gdt,
gdt_desc.size + 1);
 
-	if (ptr_ok(gdt)) {
+	if (ptr_ok(gdt, gdt_desc.size)) {
 		gdt += GDT_ENTRY_TSS << 3;
 		tss = *(u16 *)(gdt+2);
 		tss += *(u8 *)(gdt+4) << 16;
 		tss += *(u8 *)(gdt+7) << 24;
 		printk("double fault, tss at %08lx\n", tss);
 
-		if (ptr_ok(tss)) {
+		if (ptr_ok(tss, *(u16 *)gdt)) {
 			struct tss_struct *t = (struct tss_struct
*)tss;
 
 			printk("eip = %08lx, esp = %08lx\n", t->eip,
t->esp);
 
 			printk("eax = %08lx, ebx = %08lx, ecx = %08lx,
edx = %08lx\n",
 				t->eax, t->ebx, t->ecx, t->edx);
-			printk("esi = %08lx, edi = %08lx\n",
-				t->esi, t->edi);
+			printk("esi = %08lx, edi = %08lx, ebp =
%08lx\n",
+				t->esi, t->edi, t->ebp);
 		}
 	}
 
 	for (;;) /* nothing */;
 }
-
-struct tss_struct doublefault_tss __cacheline_aligned = {
-	.esp0		= STACK_START,
-	.ss0		= __KERNEL_DS,
-	.ldt		= 0,
-	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,
-
-	.eip		= (unsigned long) doublefault_fn,
-	.eflags		= X86_EFLAGS_SF | 0x2,	/* 0x2 bit is always set
*/
-	.esp		= STACK_START,
-	.es		= __USER_DS,
-	.cs		= __KERNEL_CS,
-	.ss		= __KERNEL_DS,
-	.ds		= __USER_DS,
-
-	.__cr3		= __pa(swapper_pg_dir)
-};
diff -Npru 2.6.13/arch/i386/kernel/head.S
2.6.13-i386-double-fault/arch/i386/kernel/head.S
--- 2.6.13/arch/i386/kernel/head.S	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-i386-double-fault/arch/i386/kernel/head.S	2005-09-01
13:06:01.000000000 +0200
@@ -475,9 +475,9 @@ ENTRY(boot_gdt_table)
 	.quad 0x00cf92000000ffff	/* kernel 4GB data at 0x00000000
*/
 
 /*
- * The Global Descriptor Table contains 28 quadwords, per-CPU.
+ * The Global Descriptor Table contains at least 31 quadwords,
per-CPU.
  */
-	.align PAGE_SIZE_asm
+	.align L1_CACHE_BYTES
 ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* NULL descriptor */
 	.quad 0x0000000000000000	/* 0x0b reserved */
@@ -515,9 +515,5 @@ ENTRY(cpu_gdt_table)
 	.quad 0x0040920000000000	/* 0xc8 APM DS    data */
 
 	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
-	.quad 0x0000000000000000	/* 0xd8 - unused */
-	.quad 0x0000000000000000	/* 0xe0 - unused */
-	.quad 0x0000000000000000	/* 0xe8 - unused */
-	.quad 0x0000000000000000	/* 0xf0 - unused */
-	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31:
double-fault TSS */
-
+	/* remaining entries run-time initialized */
+	.fill GDT_ENTRIES - (. - cpu_gdt_table) / 8, 8, 0
diff -Npru 2.6.13/arch/i386/kernel/traps.c
2.6.13-i386-double-fault/arch/i386/kernel/traps.c
--- 2.6.13/arch/i386/kernel/traps.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-i386-double-fault/arch/i386/kernel/traps.c	2005-09-07
15:08:32.000000000 +0200
@@ -62,6 +62,24 @@ asmlinkage int system_call(void);
 struct desc_struct default_ldt[] = { { 0, 0 }, { 0, 0 }, { 0, 0 },
 		{ 0, 0 }, { 0, 0 } };
 
+void doublefault_fn(void);
+
+struct tss_struct exception_tss[NR_CPUS][N_EXCEPTION_TSS]
__cacheline_aligned = {
+	[0 ... NR_CPUS-1] = {
+		[0 ... N_EXCEPTION_TSS-1] = {
+			.cs       = __KERNEL_CS,
+			.ss       = __KERNEL_DS,
+			.ss0      = __KERNEL_DS,
+			.__cr3    = __pa(swapper_pg_dir),
+			.io_bitmap_base = INVALID_IO_BITMAP_OFFSET,
+			.ds       = __USER_DS,
+			.es       = __USER_DS,
+			.eflags	  = X86_EFLAGS_SF | 0x2, /* 0x2 bit is
always set */
+		},
+		[DOUBLEFAULT_TSS].eip = (unsigned long)doublefault_fn
+	}
+};
+
 /* Do we ignore FPU interrupts ? */
 char ignore_fpu_irq = 0;
 
@@ -1083,7 +1101,7 @@ void __init trap_init(void)
 	set_system_gate(5,&bounds);
 	set_trap_gate(6,&invalid_op);
 	set_trap_gate(7,&device_not_available);
-	set_task_gate(8,GDT_ENTRY_DOUBLEFAULT_TSS);
+	set_task_gate(8,GDT_ENTRY_EXCEPTION_TSS + DOUBLEFAULT_TSS);
 	set_trap_gate(9,&coprocessor_segment_overrun);
 	set_trap_gate(10,&invalid_TSS);
 	set_trap_gate(11,&segment_not_present);
diff -Npru 2.6.13/include/asm-i386/processor.h
2.6.13-i386-double-fault/include/asm-i386/processor.h
--- 2.6.13/include/asm-i386/processor.h	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-i386-double-fault/include/asm-i386/processor.h	2005-09-01
13:14:48.000000000 +0200
@@ -86,7 +86,6 @@ struct cpuinfo_x86 {
 
 extern struct cpuinfo_x86 boot_cpu_data;
 extern struct cpuinfo_x86 new_cpu_data;
-extern struct tss_struct doublefault_tss;
 DECLARE_PER_CPU(struct tss_struct, init_tss);
 
 #ifdef CONFIG_SMP
@@ -479,6 +478,12 @@ struct thread_struct {
 	.io_bitmap	= { [ 0 ... IO_BITMAP_LONGS] = ~0
},		\
 }
 
+#define DOUBLEFAULT_TSS 0
+#define EXCEPTION_STACK_ORDER 0
+#define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
+
+extern struct tss_struct exception_tss[NR_CPUS][N_EXCEPTION_TSS];
+
 static inline void load_esp0(struct tss_struct *tss, struct
thread_struct *thread)
 {
 	tss->esp0 = thread->esp0;
diff -Npru 2.6.13/include/asm-i386/segment.h
2.6.13-i386-double-fault/include/asm-i386/segment.h
--- 2.6.13/include/asm-i386/segment.h	2005-08-29 01:41:01.000000000
+0200
+++
2.6.13-i386-double-fault/include/asm-i386/segment.h	2005-09-01
11:32:11.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_SEGMENT_H
 #define _ASM_SEGMENT_H
 
+#include <asm/cache.h>
+
 /*
  * The layout of the per-CPU GDT under Linux:
  *
@@ -43,7 +45,8 @@
  *  28 - unused
  *  29 - unused
  *  30 - unused
- *  31 - TSS for double fault handler
+ *  31 - TSS for first exception handler (double fault)
+ *  32+  TSSes for further exception handlers
  */
 #define GDT_ENTRY_TLS_ENTRIES	3
 #define GDT_ENTRY_TLS_MIN	6
@@ -74,12 +77,20 @@
 #define GDT_ENTRY_ESPFIX_SS		(GDT_ENTRY_KERNEL_BASE + 14)
 #define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8)
 
-#define GDT_ENTRY_DOUBLEFAULT_TSS	31
+#define GDT_ENTRY_EXCEPTION_TSS	31
+#define DOUBLEFAULT_TSS 0
+#define N_EXCEPTION_TSS 1
 
 /*
- * The GDT has 32 entries
+ * The GDT has 32+ entries
  */
-#define GDT_ENTRIES 32
+#if L1_CACHE_BYTES < 8
+# error Assertion failed: L1_CACHE_BYTES >= 8
+#endif
+#if L1_CACHE_BYTES & (L1_CACHE_BYTES - 1)
+# error Assertion failed: L1_CACHE_BYTES is power of two
+#endif
+#define GDT_ENTRIES ((31 + N_EXCEPTION_TSS + L1_CACHE_BYTES / 8 - 1) &
~(L1_CACHE_BYTES / 8 - 1))
 
 #define GDT_SIZE (GDT_ENTRIES * 8)
 
@@ -92,9 +103,7 @@
 #define __BOOT_DS	(GDT_ENTRY_BOOT_DS * 8)
 
 /*
- * The interrupt descriptor table has room for 256 idt's,
- * the global descriptor table is dependent on the number
- * of tasks we can have..
+ * The interrupt descriptor table has room for 256 idt's.
  */
 #define IDT_ENTRIES 256
 


--=__PartFFDD90B5.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-i386-double-fault.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-i386-double-fault.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCk1ha2UgdGhlIGRvdWJsZSBmYXVsdCBoYW5k
bGVyIHVzZSBDUFUtc3BlY2lmaWMgc3RhY2tzLCBhZGQgc29tZSBhYnN0cmFjdGlvbgp0byBzaW1w
bGlmeSBmdXR1cmUgY2hhbmdlIG9mIG90aGVyIGV4Y2VwdGlvbiBoYW5kbGVycyB0byBnbyB0aHJv
dWdoIHRhc2sKZ2F0ZXMuIENoYW5nZSB0aGUgcG9pbnRlciB2YWxpZGl0eSBjaGVja3MgaW4gdGhl
IGRvdWJsZSBmYXVsdCBoYW5kbGVyIHRvCmFjY291bnQgZm9yIHRoZSBmYWN0IHRoYXQgYm90aCBH
RFQgYW5kIFRTUyBhcmVuJ3QgaW4gc3RhdGljIGtlcm5lbCBzcGFjZQphbnltb3JlLgoKVGhpcyBw
YXRjaCBkZXBlbmRzIHVwb24gdGhlIHByZXNlbmNlIG9mIFRIUkVBRF9PUkRFUiwgYXMgYWRkZWQg
aW4gYQpwcmV2aW91c2x5IHN1Ym1pdHRlZCBwYXRjaC4KClNpZ25lZC1vZmYtYnk6IEphbiBCZXVs
aWNoIDxqYmV1bGljaEBub3ZlbGwuY29tPgoKZGlmZiAtTnBydSAyLjYuMTMvYXJjaC9pMzg2L2tl
cm5lbC9jcHUvY29tbW9uLmMgMi42LjEzLWkzODYtZG91YmxlLWZhdWx0L2FyY2gvaTM4Ni9rZXJu
ZWwvY3B1L2NvbW1vbi5jCi0tLSAyLjYuMTMvYXJjaC9pMzg2L2tlcm5lbC9jcHUvY29tbW9uLmMJ
MjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy1pMzg2LWRvdWJs
ZS1mYXVsdC9hcmNoL2kzODYva2VybmVsL2NwdS9jb21tb24uYwkyMDA1LTA5LTA4IDE1OjAwOjU0
LjAwMDAwMDAwMCArMDIwMApAQCAtNCw2ICs0LDcgQEAKICNpbmNsdWRlIDxsaW51eC9zbXAuaD4K
ICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KICNpbmNsdWRlIDxsaW51eC9wZXJjcHUuaD4KKyNp
bmNsdWRlIDxsaW51eC9ib290bWVtLmg+CiAjaW5jbHVkZSA8YXNtL3NlbWFwaG9yZS5oPgogI2lu
Y2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4KICNpbmNsdWRlIDxhc20vaTM4Ny5oPgpAQCAtNTcxLDYg
KzU3Miw3IEBAIHZvaWQgX19pbml0IGVhcmx5X2NwdV9pbml0KHZvaWQpCiB2b2lkIF9fZGV2aW5p
dCBjcHVfaW5pdCh2b2lkKQogewogCWludCBjcHUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7CisJdW5z
aWduZWQgaTsKIAlzdHJ1Y3QgdHNzX3N0cnVjdCAqIHQgPSAmcGVyX2NwdShpbml0X3RzcywgY3B1
KTsKIAlzdHJ1Y3QgdGhyZWFkX3N0cnVjdCAqdGhyZWFkID0gJmN1cnJlbnQtPnRocmVhZDsKIAlf
X3UzMiBzdGsxNl9vZmYgPSAoX191MzIpJnBlcl9jcHUoY3B1XzE2Yml0X3N0YWNrLCBjcHUpOwpA
QCAtNjM1LDggKzYzNyw1NyBAQCB2b2lkIF9fZGV2aW5pdCBjcHVfaW5pdCh2b2lkKQogCWxvYWRf
VFJfZGVzYygpOwogCWxvYWRfTERUKCZpbml0X21tLmNvbnRleHQpOwogCi0JLyogU2V0IHVwIGRv
dWJsZWZhdWx0IFRTUyBwb2ludGVyIGluIHRoZSBHRFQgKi8KLQlfX3NldF90c3NfZGVzYyhjcHUs
IEdEVF9FTlRSWV9ET1VCTEVGQVVMVF9UU1MsICZkb3VibGVmYXVsdF90c3MpOworI2lmIEVYQ0VQ
VElPTl9TVEFDS19PUkRFUiA+IFRIUkVBRF9PUkRFUgorIyBlcnJvciBBc3NlcnRpb24gZmFpbGVk
OiBFWENFUFRJT05fU1RBQ0tfT1JERVIgPD0gVEhSRUFEX09SREVSCisjZW5kaWYKKwlmb3IgKGkg
PSAwOyBpIDwgTl9FWENFUFRJT05fVFNTOyArK2kpIHsKKwkJdW5zaWduZWQgbG9uZyBzdGFjazsK
KworCQkvKiBTZXQgdXAgZXhjZXB0aW9uIGhhbmRsaW5nIFRTUyAqLworCQlleGNlcHRpb25fdHNz
W2NwdV1baV0uZXNwMiA9IGNwdTsKKwkJZXhjZXB0aW9uX3Rzc1tjcHVdW2ldLmVzaSA9ICh1bnNp
Z25lZCBsb25nKSZleGNlcHRpb25fdHNzW2NwdV1baV07CisKKwkJLyogU2V0IHVwIGV4Y2VwdGlv
biBoYW5kbGluZyBzdGFja3MgKi8KKyNpZmRlZiBDT05GSUdfU01QCisJCWlmIChjcHUpIHsKKwkJ
CXN0YWNrID0gX19nZXRfZnJlZV9wYWdlcyhHRlBfQVRPTUlDLCBUSFJFQURfT1JERVIpOworCQkJ
aWYgKCFzdGFjaykKKwkJCQlwYW5pYygiQ2Fubm90IGFsbG9jYXRlIGV4Y2VwdGlvbiBzdGFjayAl
dSAlZFxuIiwKKwkJCQkgICAgICBpLAorCQkJCSAgICAgIGNwdSk7CisJCX0KKwkJZWxzZQorI2Vu
ZGlmCisJCQlzdGFjayA9ICh1bnNpZ25lZCBsb25nKV9fYWxsb2NfYm9vdG1lbShFWENFUFRJT05f
U1RLU1osCisJCQkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUSFJFQURf
U0laRSwKKwkJCSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fcGEoTUFY
X0RNQV9BRERSRVNTKSk7CisJCXN0YWNrICs9IEVYQ0VQVElPTl9TVEtTWjsKKwkJZXhjZXB0aW9u
X3Rzc1tjcHVdW2ldLmVzcCA9IGV4Y2VwdGlvbl90c3NbY3B1XVtpXS5lc3AwID0gc3RhY2s7Cisj
aWZkZWYgQ09ORklHX1NNUAorCQlpZiAoY3B1KSB7CisJCQl1bnNpZ25lZCBqOworCisJCQlmb3Ig
KGogPSBFWENFUFRJT05fU1RBQ0tfT1JERVI7IGogPCBUSFJFQURfT1JERVI7ICsraikgeworCQkJ
CS8qIHNldF9wYWdlX3JlZnMgc2V0cyB0aGUgcGFnZSBjb3VudCBvbmx5IGZvciB0aGUgZmlyc3QK
KwkJCQkgICBwYWdlLCBidXQgc2luY2Ugd2Ugc3BsaXQgdGhlIGxhcmdlci1vcmRlciBwYWdlIGhl
cmUsCisJCQkJICAgd2UgbmVlZCB0byBhZGp1c3QgdGhlIHBhZ2UgY291bnQgYmVmb3JlIGZyZWVp
bmcgdGhlCisJCQkJICAgcGllY2VzLiAqLworCQkJCXN0cnVjdCBwYWdlICogcGFnZSA9IHZpcnRf
dG9fcGFnZSgodm9pZCAqKXN0YWNrKTsKKworCQkJCUJVR19PTihwYWdlX2NvdW50KHBhZ2UpKTsK
KwkJCQlzZXRfcGFnZV9jb3VudChwYWdlLCAxKTsKKwkJCQlmcmVlX3BhZ2VzKHN0YWNrLCBqKTsK
KwkJCQlzdGFjayArPSAoUEFHRV9TSVpFIDw8IGopOworCQkJfQorCQl9CisJCWVsc2UKKyNlbmRp
ZgorCQlpZiAoRVhDRVBUSU9OX1NUQUNLX09SREVSID4gVEhSRUFEX09SREVSKQorCQkJZnJlZV9i
b290bWVtKHN0YWNrLCBUSFJFQURfU0laRSAtIEVYQ0VQVElPTl9TVEtTWik7CisKKwkJLyogU2V0
IHVwIGV4Y2VwdGlvbiBoYW5kbGluZyBUU1MgcG9pbnRlciBpbiB0aGUgR0RUICovCisJCV9fc2V0
X3Rzc19kZXNjKGNwdSwgR0RUX0VOVFJZX0VYQ0VQVElPTl9UU1MgKyBpLCAmZXhjZXB0aW9uX3Rz
c1tjcHVdW2ldKTsKKwl9CiAKIAkvKiBDbGVhciAlZnMgYW5kICVncy4gKi8KIAlhc20gdm9sYXRp
bGUgKCJ4b3JsICVlYXgsICVlYXg7IG1vdmwgJWVheCwgJWZzOyBtb3ZsICVlYXgsICVncyIpOwpk
aWZmIC1OcHJ1IDIuNi4xMy9hcmNoL2kzODYva2VybmVsL2RvdWJsZWZhdWx0LmMgMi42LjEzLWkz
ODYtZG91YmxlLWZhdWx0L2FyY2gvaTM4Ni9rZXJuZWwvZG91YmxlZmF1bHQuYwotLS0gMi42LjEz
L2FyY2gvaTM4Ni9rZXJuZWwvZG91YmxlZmF1bHQuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAw
MDAwMCArMDIwMAorKysgMi42LjEzLWkzODYtZG91YmxlLWZhdWx0L2FyY2gvaTM4Ni9rZXJuZWwv
ZG91YmxlZmF1bHQuYwkyMDA1LTA5LTA5IDA5OjM3OjAyLjAwMDAwMDAwMCArMDIwMApAQCAtOSwx
MyArOSwxMSBAQAogI2luY2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4KICNpbmNsdWRlIDxhc20vZGVz
Yy5oPgogCi0jZGVmaW5lIERPVUJMRUZBVUxUX1NUQUNLU0laRSAoMTAyNCkKLXN0YXRpYyB1bnNp
Z25lZCBsb25nIGRvdWJsZWZhdWx0X3N0YWNrW0RPVUJMRUZBVUxUX1NUQUNLU0laRV07Ci0jZGVm
aW5lIFNUQUNLX1NUQVJUICh1bnNpZ25lZCBsb25nKShkb3VibGVmYXVsdF9zdGFjaytET1VCTEVG
QVVMVF9TVEFDS1NJWkUpCitleHRlcm4gdW5zaWduZWQgbG9uZyBtYXhfbG93X3BmbjsKKyNkZWZp
bmUgcHRyX29rKHgsIGwpICgoeCkgPj0gUEFHRV9PRkZTRVQgXAorICAgICAgICAgICAgICAgICAg
ICAgICYmICh4KSArIChsKSA8PSBQQUdFX09GRlNFVCArIG1heF9sb3dfcGZuICogUEFHRV9TSVpF
IC0gMSkKIAotI2RlZmluZSBwdHJfb2soeCkgKCh4KSA+IFBBR0VfT0ZGU0VUICYmICh4KSA8IFBB
R0VfT0ZGU0VUICsgMHgxMDAwMDAwKQotCi1zdGF0aWMgdm9pZCBkb3VibGVmYXVsdF9mbih2b2lk
KQordm9pZCBkb3VibGVmYXVsdF9mbih2b2lkKQogewogCXN0cnVjdCBYZ3RfZGVzY19zdHJ1Y3Qg
Z2R0X2Rlc2MgPSB7MCwgMH07CiAJdW5zaWduZWQgbG9uZyBnZHQsIHRzczsKQEAgLTIzLDQzICsy
MSwyNiBAQCBzdGF0aWMgdm9pZCBkb3VibGVmYXVsdF9mbih2b2lkKQogCV9fYXNtX18gX192b2xh
dGlsZV9fKCJzZ2R0ICUwIjogIj1tIiAoZ2R0X2Rlc2MpOiA6Im1lbW9yeSIpOwogCWdkdCA9IGdk
dF9kZXNjLmFkZHJlc3M7CiAKLQlwcmludGsoImRvdWJsZSBmYXVsdCwgZ2R0IGF0ICUwOGx4IFsl
ZCBieXRlc11cbiIsIGdkdCwgZ2R0X2Rlc2Muc2l6ZSk7CisJcHJpbnRrKCJkb3VibGUgZmF1bHQs
IGdkdCBhdCAlMDhseCBbJWQgYnl0ZXNdXG4iLCBnZHQsIGdkdF9kZXNjLnNpemUgKyAxKTsKIAot
CWlmIChwdHJfb2soZ2R0KSkgeworCWlmIChwdHJfb2soZ2R0LCBnZHRfZGVzYy5zaXplKSkgewog
CQlnZHQgKz0gR0RUX0VOVFJZX1RTUyA8PCAzOwogCQl0c3MgPSAqKHUxNiAqKShnZHQrMik7CiAJ
CXRzcyArPSAqKHU4ICopKGdkdCs0KSA8PCAxNjsKIAkJdHNzICs9ICoodTggKikoZ2R0KzcpIDw8
IDI0OwogCQlwcmludGsoImRvdWJsZSBmYXVsdCwgdHNzIGF0ICUwOGx4XG4iLCB0c3MpOwogCi0J
CWlmIChwdHJfb2sodHNzKSkgeworCQlpZiAocHRyX29rKHRzcywgKih1MTYgKilnZHQpKSB7CiAJ
CQlzdHJ1Y3QgdHNzX3N0cnVjdCAqdCA9IChzdHJ1Y3QgdHNzX3N0cnVjdCAqKXRzczsKIAogCQkJ
cHJpbnRrKCJlaXAgPSAlMDhseCwgZXNwID0gJTA4bHhcbiIsIHQtPmVpcCwgdC0+ZXNwKTsKIAog
CQkJcHJpbnRrKCJlYXggPSAlMDhseCwgZWJ4ID0gJTA4bHgsIGVjeCA9ICUwOGx4LCBlZHggPSAl
MDhseFxuIiwKIAkJCQl0LT5lYXgsIHQtPmVieCwgdC0+ZWN4LCB0LT5lZHgpOwotCQkJcHJpbnRr
KCJlc2kgPSAlMDhseCwgZWRpID0gJTA4bHhcbiIsCi0JCQkJdC0+ZXNpLCB0LT5lZGkpOworCQkJ
cHJpbnRrKCJlc2kgPSAlMDhseCwgZWRpID0gJTA4bHgsIGVicCA9ICUwOGx4XG4iLAorCQkJCXQt
PmVzaSwgdC0+ZWRpLCB0LT5lYnApOwogCQl9CiAJfQogCiAJZm9yICg7OykgLyogbm90aGluZyAq
LzsKIH0KLQotc3RydWN0IHRzc19zdHJ1Y3QgZG91YmxlZmF1bHRfdHNzIF9fY2FjaGVsaW5lX2Fs
aWduZWQgPSB7Ci0JLmVzcDAJCT0gU1RBQ0tfU1RBUlQsCi0JLnNzMAkJPSBfX0tFUk5FTF9EUywK
LQkubGR0CQk9IDAsCi0JLmlvX2JpdG1hcF9iYXNlCT0gSU5WQUxJRF9JT19CSVRNQVBfT0ZGU0VU
LAotCi0JLmVpcAkJPSAodW5zaWduZWQgbG9uZykgZG91YmxlZmF1bHRfZm4sCi0JLmVmbGFncwkJ
PSBYODZfRUZMQUdTX1NGIHwgMHgyLAkvKiAweDIgYml0IGlzIGFsd2F5cyBzZXQgKi8KLQkuZXNw
CQk9IFNUQUNLX1NUQVJULAotCS5lcwkJPSBfX1VTRVJfRFMsCi0JLmNzCQk9IF9fS0VSTkVMX0NT
LAotCS5zcwkJPSBfX0tFUk5FTF9EUywKLQkuZHMJCT0gX19VU0VSX0RTLAotCi0JLl9fY3IzCQk9
IF9fcGEoc3dhcHBlcl9wZ19kaXIpCi19OwpkaWZmIC1OcHJ1IDIuNi4xMy9hcmNoL2kzODYva2Vy
bmVsL2hlYWQuUyAyLjYuMTMtaTM4Ni1kb3VibGUtZmF1bHQvYXJjaC9pMzg2L2tlcm5lbC9oZWFk
LlMKLS0tIDIuNi4xMy9hcmNoL2kzODYva2VybmVsL2hlYWQuUwkyMDA1LTA4LTI5IDAxOjQxOjAx
LjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLWkzODYtZG91YmxlLWZhdWx0L2FyY2gvaTM4Ni9r
ZXJuZWwvaGVhZC5TCTIwMDUtMDktMDEgMTM6MDY6MDEuMDAwMDAwMDAwICswMjAwCkBAIC00NzUs
OSArNDc1LDkgQEAgRU5UUlkoYm9vdF9nZHRfdGFibGUpCiAJLnF1YWQgMHgwMGNmOTIwMDAwMDBm
ZmZmCS8qIGtlcm5lbCA0R0IgZGF0YSBhdCAweDAwMDAwMDAwICovCiAKIC8qCi0gKiBUaGUgR2xv
YmFsIERlc2NyaXB0b3IgVGFibGUgY29udGFpbnMgMjggcXVhZHdvcmRzLCBwZXItQ1BVLgorICog
VGhlIEdsb2JhbCBEZXNjcmlwdG9yIFRhYmxlIGNvbnRhaW5zIGF0IGxlYXN0IDMxIHF1YWR3b3Jk
cywgcGVyLUNQVS4KICAqLwotCS5hbGlnbiBQQUdFX1NJWkVfYXNtCisJLmFsaWduIEwxX0NBQ0hF
X0JZVEVTCiBFTlRSWShjcHVfZ2R0X3RhYmxlKQogCS5xdWFkIDB4MDAwMDAwMDAwMDAwMDAwMAkv
KiBOVUxMIGRlc2NyaXB0b3IgKi8KIAkucXVhZCAweDAwMDAwMDAwMDAwMDAwMDAJLyogMHgwYiBy
ZXNlcnZlZCAqLwpAQCAtNTE1LDkgKzUxNSw1IEBAIEVOVFJZKGNwdV9nZHRfdGFibGUpCiAJLnF1
YWQgMHgwMDQwOTIwMDAwMDAwMDAwCS8qIDB4YzggQVBNIERTICAgIGRhdGEgKi8KIAogCS5xdWFk
IDB4MDAwMDkyMDAwMDAwMDAwMAkvKiAweGQwIC0gRVNQRklYIDE2LWJpdCBTUyAqLwotCS5xdWFk
IDB4MDAwMDAwMDAwMDAwMDAwMAkvKiAweGQ4IC0gdW51c2VkICovCi0JLnF1YWQgMHgwMDAwMDAw
MDAwMDAwMDAwCS8qIDB4ZTAgLSB1bnVzZWQgKi8KLQkucXVhZCAweDAwMDAwMDAwMDAwMDAwMDAJ
LyogMHhlOCAtIHVudXNlZCAqLwotCS5xdWFkIDB4MDAwMDAwMDAwMDAwMDAwMAkvKiAweGYwIC0g
dW51c2VkICovCi0JLnF1YWQgMHgwMDAwMDAwMDAwMDAwMDAwCS8qIDB4ZjggLSBHRFQgZW50cnkg
MzE6IGRvdWJsZS1mYXVsdCBUU1MgKi8KLQorCS8qIHJlbWFpbmluZyBlbnRyaWVzIHJ1bi10aW1l
IGluaXRpYWxpemVkICovCisJLmZpbGwgR0RUX0VOVFJJRVMgLSAoLiAtIGNwdV9nZHRfdGFibGUp
IC8gOCwgOCwgMApkaWZmIC1OcHJ1IDIuNi4xMy9hcmNoL2kzODYva2VybmVsL3RyYXBzLmMgMi42
LjEzLWkzODYtZG91YmxlLWZhdWx0L2FyY2gvaTM4Ni9rZXJuZWwvdHJhcHMuYwotLS0gMi42LjEz
L2FyY2gvaTM4Ni9rZXJuZWwvdHJhcHMuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCAr
MDIwMAorKysgMi42LjEzLWkzODYtZG91YmxlLWZhdWx0L2FyY2gvaTM4Ni9rZXJuZWwvdHJhcHMu
YwkyMDA1LTA5LTA3IDE1OjA4OjMyLjAwMDAwMDAwMCArMDIwMApAQCAtNjIsNiArNjIsMjQgQEAg
YXNtbGlua2FnZSBpbnQgc3lzdGVtX2NhbGwodm9pZCk7CiBzdHJ1Y3QgZGVzY19zdHJ1Y3QgZGVm
YXVsdF9sZHRbXSA9IHsgeyAwLCAwIH0sIHsgMCwgMCB9LCB7IDAsIDAgfSwKIAkJeyAwLCAwIH0s
IHsgMCwgMCB9IH07CiAKK3ZvaWQgZG91YmxlZmF1bHRfZm4odm9pZCk7CisKK3N0cnVjdCB0c3Nf
c3RydWN0IGV4Y2VwdGlvbl90c3NbTlJfQ1BVU11bTl9FWENFUFRJT05fVFNTXSBfX2NhY2hlbGlu
ZV9hbGlnbmVkID0geworCVswIC4uLiBOUl9DUFVTLTFdID0geworCQlbMCAuLi4gTl9FWENFUFRJ
T05fVFNTLTFdID0geworCQkJLmNzICAgICAgID0gX19LRVJORUxfQ1MsCisJCQkuc3MgICAgICAg
PSBfX0tFUk5FTF9EUywKKwkJCS5zczAgICAgICA9IF9fS0VSTkVMX0RTLAorCQkJLl9fY3IzICAg
ID0gX19wYShzd2FwcGVyX3BnX2RpciksCisJCQkuaW9fYml0bWFwX2Jhc2UgPSBJTlZBTElEX0lP
X0JJVE1BUF9PRkZTRVQsCisJCQkuZHMgICAgICAgPSBfX1VTRVJfRFMsCisJCQkuZXMgICAgICAg
PSBfX1VTRVJfRFMsCisJCQkuZWZsYWdzCSAgPSBYODZfRUZMQUdTX1NGIHwgMHgyLCAvKiAweDIg
Yml0IGlzIGFsd2F5cyBzZXQgKi8KKwkJfSwKKwkJW0RPVUJMRUZBVUxUX1RTU10uZWlwID0gKHVu
c2lnbmVkIGxvbmcpZG91YmxlZmF1bHRfZm4KKwl9Cit9OworCiAvKiBEbyB3ZSBpZ25vcmUgRlBV
IGludGVycnVwdHMgPyAqLwogY2hhciBpZ25vcmVfZnB1X2lycSA9IDA7CiAKQEAgLTEwODMsNyAr
MTEwMSw3IEBAIHZvaWQgX19pbml0IHRyYXBfaW5pdCh2b2lkKQogCXNldF9zeXN0ZW1fZ2F0ZSg1
LCZib3VuZHMpOwogCXNldF90cmFwX2dhdGUoNiwmaW52YWxpZF9vcCk7CiAJc2V0X3RyYXBfZ2F0
ZSg3LCZkZXZpY2Vfbm90X2F2YWlsYWJsZSk7Ci0Jc2V0X3Rhc2tfZ2F0ZSg4LEdEVF9FTlRSWV9E
T1VCTEVGQVVMVF9UU1MpOworCXNldF90YXNrX2dhdGUoOCxHRFRfRU5UUllfRVhDRVBUSU9OX1RT
UyArIERPVUJMRUZBVUxUX1RTUyk7CiAJc2V0X3RyYXBfZ2F0ZSg5LCZjb3Byb2Nlc3Nvcl9zZWdt
ZW50X292ZXJydW4pOwogCXNldF90cmFwX2dhdGUoMTAsJmludmFsaWRfVFNTKTsKIAlzZXRfdHJh
cF9nYXRlKDExLCZzZWdtZW50X25vdF9wcmVzZW50KTsKZGlmZiAtTnBydSAyLjYuMTMvaW5jbHVk
ZS9hc20taTM4Ni9wcm9jZXNzb3IuaCAyLjYuMTMtaTM4Ni1kb3VibGUtZmF1bHQvaW5jbHVkZS9h
c20taTM4Ni9wcm9jZXNzb3IuaAotLS0gMi42LjEzL2luY2x1ZGUvYXNtLWkzODYvcHJvY2Vzc29y
LmgJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy1pMzg2LWRv
dWJsZS1mYXVsdC9pbmNsdWRlL2FzbS1pMzg2L3Byb2Nlc3Nvci5oCTIwMDUtMDktMDEgMTM6MTQ6
NDguMDAwMDAwMDAwICswMjAwCkBAIC04Niw3ICs4Niw2IEBAIHN0cnVjdCBjcHVpbmZvX3g4NiB7
CiAKIGV4dGVybiBzdHJ1Y3QgY3B1aW5mb194ODYgYm9vdF9jcHVfZGF0YTsKIGV4dGVybiBzdHJ1
Y3QgY3B1aW5mb194ODYgbmV3X2NwdV9kYXRhOwotZXh0ZXJuIHN0cnVjdCB0c3Nfc3RydWN0IGRv
dWJsZWZhdWx0X3RzczsKIERFQ0xBUkVfUEVSX0NQVShzdHJ1Y3QgdHNzX3N0cnVjdCwgaW5pdF90
c3MpOwogCiAjaWZkZWYgQ09ORklHX1NNUApAQCAtNDc5LDYgKzQ3OCwxMiBAQCBzdHJ1Y3QgdGhy
ZWFkX3N0cnVjdCB7CiAJLmlvX2JpdG1hcAk9IHsgWyAwIC4uLiBJT19CSVRNQVBfTE9OR1NdID0g
fjAgfSwJCVwKIH0KIAorI2RlZmluZSBET1VCTEVGQVVMVF9UU1MgMAorI2RlZmluZSBFWENFUFRJ
T05fU1RBQ0tfT1JERVIgMAorI2RlZmluZSBFWENFUFRJT05fU1RLU1ogKFBBR0VfU0laRSA8PCBF
WENFUFRJT05fU1RBQ0tfT1JERVIpCisKK2V4dGVybiBzdHJ1Y3QgdHNzX3N0cnVjdCBleGNlcHRp
b25fdHNzW05SX0NQVVNdW05fRVhDRVBUSU9OX1RTU107CisKIHN0YXRpYyBpbmxpbmUgdm9pZCBs
b2FkX2VzcDAoc3RydWN0IHRzc19zdHJ1Y3QgKnRzcywgc3RydWN0IHRocmVhZF9zdHJ1Y3QgKnRo
cmVhZCkKIHsKIAl0c3MtPmVzcDAgPSB0aHJlYWQtPmVzcDA7CmRpZmYgLU5wcnUgMi42LjEzL2lu
Y2x1ZGUvYXNtLWkzODYvc2VnbWVudC5oIDIuNi4xMy1pMzg2LWRvdWJsZS1mYXVsdC9pbmNsdWRl
L2FzbS1pMzg2L3NlZ21lbnQuaAotLS0gMi42LjEzL2luY2x1ZGUvYXNtLWkzODYvc2VnbWVudC5o
CTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMtaTM4Ni1kb3Vi
bGUtZmF1bHQvaW5jbHVkZS9hc20taTM4Ni9zZWdtZW50LmgJMjAwNS0wOS0wMSAxMTozMjoxMS4w
MDAwMDAwMDAgKzAyMDAKQEAgLTEsNiArMSw4IEBACiAjaWZuZGVmIF9BU01fU0VHTUVOVF9ICiAj
ZGVmaW5lIF9BU01fU0VHTUVOVF9ICiAKKyNpbmNsdWRlIDxhc20vY2FjaGUuaD4KKwogLyoKICAq
IFRoZSBsYXlvdXQgb2YgdGhlIHBlci1DUFUgR0RUIHVuZGVyIExpbnV4OgogICoKQEAgLTQzLDcg
KzQ1LDggQEAKICAqICAyOCAtIHVudXNlZAogICogIDI5IC0gdW51c2VkCiAgKiAgMzAgLSB1bnVz
ZWQKLSAqICAzMSAtIFRTUyBmb3IgZG91YmxlIGZhdWx0IGhhbmRsZXIKKyAqICAzMSAtIFRTUyBm
b3IgZmlyc3QgZXhjZXB0aW9uIGhhbmRsZXIgKGRvdWJsZSBmYXVsdCkKKyAqICAzMisgIFRTU2Vz
IGZvciBmdXJ0aGVyIGV4Y2VwdGlvbiBoYW5kbGVycwogICovCiAjZGVmaW5lIEdEVF9FTlRSWV9U
TFNfRU5UUklFUwkzCiAjZGVmaW5lIEdEVF9FTlRSWV9UTFNfTUlOCTYKQEAgLTc0LDEyICs3Nywy
MCBAQAogI2RlZmluZSBHRFRfRU5UUllfRVNQRklYX1NTCQkoR0RUX0VOVFJZX0tFUk5FTF9CQVNF
ICsgMTQpCiAjZGVmaW5lIF9fRVNQRklYX1NTIChHRFRfRU5UUllfRVNQRklYX1NTICogOCkKIAot
I2RlZmluZSBHRFRfRU5UUllfRE9VQkxFRkFVTFRfVFNTCTMxCisjZGVmaW5lIEdEVF9FTlRSWV9F
WENFUFRJT05fVFNTCTMxCisjZGVmaW5lIERPVUJMRUZBVUxUX1RTUyAwCisjZGVmaW5lIE5fRVhD
RVBUSU9OX1RTUyAxCiAKIC8qCi0gKiBUaGUgR0RUIGhhcyAzMiBlbnRyaWVzCisgKiBUaGUgR0RU
IGhhcyAzMisgZW50cmllcwogICovCi0jZGVmaW5lIEdEVF9FTlRSSUVTIDMyCisjaWYgTDFfQ0FD
SEVfQllURVMgPCA4CisjIGVycm9yIEFzc2VydGlvbiBmYWlsZWQ6IEwxX0NBQ0hFX0JZVEVTID49
IDgKKyNlbmRpZgorI2lmIEwxX0NBQ0hFX0JZVEVTICYgKEwxX0NBQ0hFX0JZVEVTIC0gMSkKKyMg
ZXJyb3IgQXNzZXJ0aW9uIGZhaWxlZDogTDFfQ0FDSEVfQllURVMgaXMgcG93ZXIgb2YgdHdvCisj
ZW5kaWYKKyNkZWZpbmUgR0RUX0VOVFJJRVMgKCgzMSArIE5fRVhDRVBUSU9OX1RTUyArIEwxX0NB
Q0hFX0JZVEVTIC8gOCAtIDEpICYgfihMMV9DQUNIRV9CWVRFUyAvIDggLSAxKSkKIAogI2RlZmlu
ZSBHRFRfU0laRSAoR0RUX0VOVFJJRVMgKiA4KQogCkBAIC05Miw5ICsxMDMsNyBAQAogI2RlZmlu
ZSBfX0JPT1RfRFMJKEdEVF9FTlRSWV9CT09UX0RTICogOCkKIAogLyoKLSAqIFRoZSBpbnRlcnJ1
cHQgZGVzY3JpcHRvciB0YWJsZSBoYXMgcm9vbSBmb3IgMjU2IGlkdCdzLAotICogdGhlIGdsb2Jh
bCBkZXNjcmlwdG9yIHRhYmxlIGlzIGRlcGVuZGVudCBvbiB0aGUgbnVtYmVyCi0gKiBvZiB0YXNr
cyB3ZSBjYW4gaGF2ZS4uCisgKiBUaGUgaW50ZXJydXB0IGRlc2NyaXB0b3IgdGFibGUgaGFzIHJv
b20gZm9yIDI1NiBpZHQncy4KICAqLwogI2RlZmluZSBJRFRfRU5UUklFUyAyNTYKIAo=

--=__PartFFDD90B5.0__=--

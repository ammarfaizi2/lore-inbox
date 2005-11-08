Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbVKHEbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbVKHEbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbVKHEbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:31:42 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:7955 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030281AbVKHEbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:31:41 -0500
Date: Mon, 7 Nov 2005 20:31:39 -0800
Message-Id: <200511080431.jA84Vdg5009909@zach-dev.vmware.com>
Subject: [PATCH 12/21] i386 Deprecate descriptor asm
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 08 Nov 2005 04:31:40.0084 (UTC) FILETIME=[50362F40:01C5E41D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ancient inline assembler that manipulates descriptor tables is unreadable
and has no type checking.  Doing this in C actually generates better code,
saves code space, and improves readability.

The fact that you must cast descriptors to (char *) for the inline assembler
to work properly caused me no end of grief working on these patches.

Note that GCC does not generate rotations to utilize %{a-d}h portions of
registers.  This is pointless on P4 cores, since %{a-d}h issues a shift u-op
internally, and the rorl + (implicit shift) is no faster than issuing
two shift operations.

Getting rid of the trickiness allows GCC to get better register allocation
and generate more compact code (and shorter code if constant base and
limit do not require transformations).  Compactness is all that is required;
none of these functions are on critical paths.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/include/asm-i386/desc.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/desc.h	2005-11-04 17:45:04.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/desc.h	2005-11-05 00:28:07.000000000 -0800
@@ -49,20 +49,68 @@ extern struct Xgt_desc_struct idt_descr,
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
+struct desc_internal_struct {
+	unsigned short	limit0;
+	unsigned short	base0;
+	unsigned char	base1;
+	unsigned char	type;
+	unsigned int	limit1 : 4;
+	unsigned int	flags : 4;
+	unsigned char	base2;
+} __attribute__((packed));
+
+static inline struct desc_internal_struct *desc_internal(struct desc_struct *d)
+{
+	return (struct desc_internal_struct *)d;
+}
+
+static inline unsigned long get_desc_base(struct desc_struct *desc)
+{
+	unsigned long base;
+	struct desc_internal_struct *dint = desc_internal(desc);
+	base = (dint->base0) | (dint->base1 << 16) | (dint->base2 << 24);
+	return base;
+}
+
+static inline unsigned long get_desc_limit(struct desc_struct *desc)
+{
+	unsigned long limit;
+	struct desc_internal_struct *dint = desc_internal(desc);
+	limit = (dint->limit0) | (dint->limit1 << 16);
+	return limit;
+}
+
+static inline void set_base(struct desc_struct *desc, void *base)
+{
+	struct desc_internal_struct *d = desc_internal(desc);
+	u32 addr = (u32)base;
+	d->base0 = addr & 0xffff;
+	d->base1 = (addr >> 16) & 0xff;
+	d->base2 = (addr >> 24) & 0xff;
+}
+
+static inline void set_limit(struct desc_struct *desc, unsigned limit)
+{
+	struct desc_internal_struct *d = desc_internal(desc);
+	d->limit0 = limit & 0xffff;
+	d->limit1 = (limit & 0xf0000) >> 16;
+}
+
+static inline void set_tssldt_desc(struct desc_struct *desc, unsigned long base, unsigned short limit, int type)
+{
+	struct desc_internal_struct *d = desc_internal(desc);
+	d->base0 = base & 0xffff;
+	d->base1 = (base >> 16) & 0xff;
+	d->base2 = (base >> 24) & 0xff;
+	d->limit0 = limit & 0xffff;
+	d->type = type;
+	d->limit1 = 0;
+	d->flags = 0;
+}
 
 static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
 {
-	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[entry], (int)addr,
+	set_tssldt_desc(&get_cpu_gdt_table(cpu)[entry], (int)addr,
 		offsetof(struct tss_struct, __cacheline_filler) - 1, 0x89);
 }
 
@@ -70,7 +118,7 @@ static inline void __set_tss_desc(unsign
 
 static inline void set_ldt_desc(unsigned int cpu, void *addr, unsigned int size)
 {
-	_set_tssldt_desc(&get_cpu_gdt_table(cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
+	set_tssldt_desc(&get_cpu_gdt_table(cpu)[GDT_ENTRY_LDT], (int)addr, ((size << 3)-1), 0x82);
 }
 
 #define LDT_entry_a(info) \
@@ -149,22 +197,13 @@ static inline void load_LDT(mm_context_t
 	put_cpu();
 }
 
-static inline unsigned long get_desc_base(unsigned long *desc)
-{
-	unsigned long base;
-	base = ((desc[0] >> 16)  & 0x0000ffff) |
-		((desc[1] << 16) & 0x00ff0000) |
-		(desc[1] & 0xff000000);
-	return base;
-}
-
 static inline void prepare_protected_segment(int cpu, int gdt_entry, void *base, u32 size)
 {
 	struct desc_struct *gdt = get_cpu_gdt_table(cpu);
 
 	/* Forced zero-length segments to 1-byte access at unmapped page zero */
-	set_base(gdt[gdt_entry], size > 0 ? (u32)base : 0);
-	set_limit(gdt[gdt_entry], size > 0 ? size - 1 : 0);
+	set_base(&gdt[gdt_entry], size > 0 ? base : 0);
+	set_limit(&gdt[gdt_entry], size > 0 ? size - 1 : 0);
 }
 
 struct bios_segment_save {
Index: linux-2.6.14-zach-work/include/asm-i386/system.h
===================================================================
--- linux-2.6.14-zach-work.orig/include/asm-i386/system.h	2005-11-04 17:45:05.000000000 -0800
+++ linux-2.6.14-zach-work/include/asm-i386/system.h	2005-11-04 17:45:31.000000000 -0800
@@ -28,33 +28,6 @@ extern struct task_struct * FASTCALL(__s
 		      "2" (prev), "d" (next));				\
 } while (0)
 
-#define _set_base(addr,base) do { unsigned long __pr; \
-__asm__ __volatile__ ("movw %%dx,%1\n\t" \
-	"rorl $16,%%edx\n\t" \
-	"movb %%dl,%2\n\t" \
-	"movb %%dh,%3" \
-	:"=&d" (__pr) \
-	:"m" (*((addr)+2)), \
-	 "m" (*((addr)+4)), \
-	 "m" (*((addr)+7)), \
-         "0" (base) \
-        ); } while(0)
-
-#define _set_limit(addr,limit) do { unsigned long __lr; \
-__asm__ __volatile__ ("movw %%dx,%1\n\t" \
-	"rorl $16,%%edx\n\t" \
-	"movb %2,%%dh\n\t" \
-	"andb $0xf0,%%dh\n\t" \
-	"orb %%dh,%%dl\n\t" \
-	"movb %%dl,%2" \
-	:"=&d" (__lr) \
-	:"m" (*(addr)), \
-	 "m" (*((addr)+6)), \
-	 "0" (limit) \
-        ); } while(0)
-
-#define set_base(ldt,base) _set_base( ((char *)&(ldt)) , (base) )
-#define set_limit(ldt,limit) _set_limit( ((char *)&(ldt)) , (limit) )
 
 /*
  * Load a segment. Fall back on loading the zero
Index: linux-2.6.14-zach-work/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/apm.c	2005-11-04 17:45:02.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/apm.c	2005-11-05 00:28:07.000000000 -0800
@@ -2256,11 +2256,11 @@ static int __init apm_init(void)
 	 */
 	for (i = 0; i < NR_CPUS; i++) {
 		struct desc_struct *gdt = get_cpu_gdt_table(i);
-		set_base(gdt[APM_CS >> 3],
+		set_base(&gdt[APM_CS >> 3],
 			 __va((unsigned long)apm_info.bios.cseg << 4));
-		set_base(gdt[APM_CS_16 >> 3],
+		set_base(&gdt[APM_CS_16 >> 3],
 			 __va((unsigned long)apm_info.bios.cseg_16 << 4));
-		set_base(gdt[APM_DS >> 3],
+		set_base(&gdt[APM_DS >> 3],
 			 __va((unsigned long)apm_info.bios.dseg << 4));
 	}
 
Index: linux-2.6.14-zach-work/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/cpu/common.c	2005-11-04 17:45:06.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/cpu/common.c	2005-11-05 00:28:07.000000000 -0800
@@ -604,7 +604,7 @@ void __devinit cpu_init(void)
 	 * even though they are called in protected mode.  The limit is
 	 * preset, we hardwire the base here.
 	 */
-	set_base(gdt[GDT_ENTRY_BAD_BIOS_CACHE], __va(BAD_BIOS_AREA));
+	set_base(&gdt[GDT_ENTRY_BAD_BIOS_CACHE], __va(BAD_BIOS_AREA));
 
 	/* Set up GDT entry for 16bit stack */
 	prepare_protected_segment(cpu, GDT_ENTRY_ESPFIX_SS, (void *) stk16_off,
Index: linux-2.6.14-zach-work/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/mm/fault.c	2005-11-04 16:54:41.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/mm/fault.c	2005-11-05 00:28:04.000000000 -0800
@@ -113,7 +113,7 @@ static inline unsigned long get_segment_
 	}
 
 	/* Decode the code segment base from the descriptor */
-	base = get_desc_base((unsigned long *)desc);
+	base = get_desc_base(desc);
 
 	if (seg & (1<<2)) { 
 		up(&current->mm->context.sem);
Index: linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c
===================================================================
--- linux-2.6.14-zach-work.orig/drivers/pnp/pnpbios/bioscalls.c	2005-11-04 17:45:04.000000000 -0800
+++ linux-2.6.14-zach-work/drivers/pnp/pnpbios/bioscalls.c	2005-11-05 00:28:07.000000000 -0800
@@ -510,8 +510,8 @@ void pnpbios_calls_init(union pnp_bios_i
 
 	for(i=0; i < NR_CPUS; i++) {
 		struct desc_struct *gdt = get_cpu_gdt_table(i);
-		set_base(gdt[GDT_ENTRY_PNPBIOS_CS32], &pnp_bios_callfunc);
-		set_base(gdt[GDT_ENTRY_PNPBIOS_CS16], __va(header->fields.pm16cseg));
-		set_base(gdt[GDT_ENTRY_PNPBIOS_DS], __va(header->fields.pm16dseg));
+		set_base(&gdt[GDT_ENTRY_PNPBIOS_CS32], &pnp_bios_callfunc);
+		set_base(&gdt[GDT_ENTRY_PNPBIOS_CS16], __va(header->fields.pm16cseg));
+		set_base(&gdt[GDT_ENTRY_PNPBIOS_DS], __va(header->fields.pm16dseg));
 	}
 }

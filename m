Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbUCAHkz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 02:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbUCAHkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 02:40:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37778 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262260AbUCAHka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 02:40:30 -0500
To: <linux-kernel@vger.kernel.org>
Subject: [CFT][PATCH] 2.6.4-rc1 remove x86 boot page tables
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Mar 2004 00:32:21 -0700
Message-ID: <m1vflp81kq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the discussion on removing the hard coded limits on the boot
page tables it occurred to me that on x86 they are totally
unnecessary.  A segment with an appropriately adjusted offset will
work just as well, will use less memory, will use less code, and allow
access to all memory below 4G in the machine.  So I sat down and coded
it up. 

I believe I have accounted for everything.  What I was looking for
were pieces of code that used the identity mapping present at
early boot on x86 and pieces of code that directly manipulated
the page tables early in boot.

I have tested this patch on a i386 with 6MB of RAM and an dual operton
with 5GB of RAM which tests most of the code paths.  And both worked
without a hitch. 

I think I have accounted for the sub architectures but I don't have
the hardware to test them.  For voyager and VISWS I actually changed
some code so I would appreciate a confirmation I didn't break
anything.  

I have rewritten and compiled tested the boot_ioremap code but I don't
have a configuration to test it. This effects the EFI code and the
numa srat code.   It might be worth replacing boot_ioremap with __va()
to reduce the amount of error checking necessary.

I have also carefully tested that I did not break the ignore_int code
that is used to catch early exceptions before our normal exception
handlers are setup.

Thanks to HPA who got the ball started :)

Eric

diff -uNrX linux-ignore-files linux-2.6.4-rc1/arch/i386/boot/tools/build.c linux-2.6.4-rc1.nobootpgtbl/arch/i386/boot/tools/build.c
--- linux-2.6.4-rc1/arch/i386/boot/tools/build.c	Wed Dec 17 19:58:49 2003
+++ linux-2.6.4-rc1.nobootpgtbl/arch/i386/boot/tools/build.c	Sun Feb 29 22:26:43 2004
@@ -150,10 +150,8 @@
 	sz = sb.st_size;
 	fprintf (stderr, "System is %d kB\n", sz/1024);
 	sys_size = (sz + 15) / 16;
-	/* 0x40000*16 = 4.0 MB, reasonable estimate for the current maximum */
-	if (sys_size > (is_big_kernel ? 0x40000 : DEF_SYSSIZE))
-		die("System is too big. Try using %smodules.",
-			is_big_kernel ? "" : "bzImage or ");
+	if (!is_big_kernel && sys_size > DEF_SYSSIZE)
+		die("System is too big. Try using bzImage or modules.");
 	while (sz > 0) {
 		int l, n;
 
diff -uNrX linux-ignore-files linux-2.6.4-rc1/arch/i386/kernel/head.S linux-2.6.4-rc1.nobootpgtbl/arch/i386/kernel/head.S
--- linux-2.6.4-rc1/arch/i386/kernel/head.S	Sun Feb 29 14:09:16 2004
+++ linux-2.6.4-rc1.nobootpgtbl/arch/i386/kernel/head.S	Sun Feb 29 21:45:40 2004
@@ -40,103 +40,45 @@
 #define X86_VENDOR_ID	CPU_PARAMS+36	/* offset dependent on NCAPINTS */
 
 /*
- * Initialize page tables
- */
-#define INIT_PAGE_TABLES \
-	movl $pg0 - __PAGE_OFFSET, %edi; \
-	/* "007" doesn't mean with license to kill, but	PRESENT+RW+USER */ \
-	movl $007, %eax; \
-2:	stosl; \
-	add $0x1000, %eax; \
-	cmp $empty_zero_page - __PAGE_OFFSET, %edi; \
-	jne 2b;
-
-/*
- * swapper_pg_dir is the main page directory, address 0x00101000
- *
- * On entry, %esi points to the real-mode code as a 32-bit pointer.
+ * On entry, %esi points to the real-mode code as a 32-bit pointer,
+ * and %bx is zero iff this is the boot CPU.
+ * %cs is a flat 32bit segment with a base of 0
  */
 ENTRY(startup_32)
-
-#ifdef CONFIG_X86_VISWS
 /*
- * On SGI Visual Workstations boot CPU starts in protected mode.
+ * Set segments to known values.
  */
-	orw %bx, %bx
-	jnz 1f
-	INIT_PAGE_TABLES
-	movl $swapper_pg_dir - __PAGE_OFFSET, %eax
-	movl %eax, %cr3
-	lgdt boot_gdt
-1:
-#endif
+	lgdt %cs:(boot_gdt - __PAGE_OFFSET)
 
-/*
- * Set segments to known values
- */
-	cld
-	movl $(__BOOT_DS),%eax
+	movl $__VIRT_DS,%eax		# only DS/ES are used
 	movl %eax,%ds
 	movl %eax,%es
+		
+	xorl %eax,%eax			# Clear FS/GS and LDT
 	movl %eax,%fs
 	movl %eax,%gs
-#ifdef CONFIG_SMP
-	orw %bx,%bx
-	jz 1f
+	lldt %ax
 
-/*
- *	New page tables may be in 4Mbyte page mode and may
- *	be using the global pages. 
- *
- *	NOTE! If we are on a 486 we may have no cr4 at all!
- *	So we do not try to touch it unless we really have
- *	some bits in it to set.  This won't work if the BSP
- *	implements cr4 but this AP does not -- very unlikely
- *	but be warned!  The same applies to the pse feature
- *	if not equally supported. --macro
- *
- *	NOTE! We have to correct for the fact that we're
- *	not yet offset PAGE_OFFSET..
- */
-#define cr4_bits mmu_cr4_features-__PAGE_OFFSET
-	cmpl $0,cr4_bits
-	je 3f
-	movl %cr4,%eax		# Turn on paging options (PSE,PAE,..)
-	orl cr4_bits,%eax
-	movl %eax,%cr4
-	jmp 3f
-1:
-#endif
-	INIT_PAGE_TABLES
-/*
- * Enable paging
- */
-3:
-	movl $swapper_pg_dir-__PAGE_OFFSET,%eax
-	movl %eax,%cr3		/* set the page table pointer.. */
-	movl %cr0,%eax
-	orl $0x80000000,%eax
-	movl %eax,%cr0		/* ..and set paging (PG) bit */
-	jmp 1f			/* flush the prefetch-queue */
-1:
-	movl $1f,%eax
-	jmp *%eax		/* make sure eip is relocated */
+	lidt boot_idt			# Setup the IDT
+	ljmp $__VIRT_CS, $1f		# normalize %eip
 1:
-	/* Set up the stack pointer */
-	lss stack_start,%esp
+	lss  stack_start, %esp		# Setup the stack pointer
+	
+	pushl $0			# Initialize eflags
+	popfl				# gcc2 wants the direction flag cleared at all times
 
-#ifdef CONFIG_SMP
-	orw  %bx,%bx
-	jz  1f				/* Initial CPU cleans BSS */
-	pushl $0
-	popfl
-	jmp checkCPUtype
-1:
-#endif /* CONFIG_SMP */
+#ifdef CONFIG_SMP	
+	orw %bx,%bx
+	jnz checkCPUtype
+#endif	
+
+/* 
+ * Initialization by the first CPU
+ */	
 
 /*
  * Clear BSS first so that there are no surprises...
- * No need to cld as DF is already clear from cld above...
+ * No need to cld as DF is already clear from above...
  */
 	xorl %eax,%eax
 	movl $__bss_start,%edi
@@ -151,22 +93,16 @@
  */
 	call setup_idt
 /*
- * Initialize eflags.  Some BIOS's leave bits like NT set.  This would
- * confuse the debugger if this code is traced.
- * XXX - best to initialize before switching to protected mode.
- */
-	pushl $0
-	popfl
-/*
  * Copy bootup parameters out of the way. First 2kB of
  * _empty_zero_page is for boot parameters, second 2kB
  * is for the command line.
  *
  * Note: %esi still has the pointer to the real-mode data.
+ * No need to cld as DF is already clear from above...
  */
+	addl $__PAGE_OFFSET, %esi	/* Make %esi virtual */
 	movl $empty_zero_page,%edi
 	movl $512,%ecx
-	cld
 	rep
 	movsl
 	xorl %eax,%eax
@@ -176,18 +112,21 @@
 	movl empty_zero_page+NEW_CL_POINTER,%esi
 	andl %esi,%esi
 	jnz 2f			# New command line protocol
-	cmpw $(OLD_CL_MAGIC),OLD_CL_MAGIC_ADDR
+	cmpw $(OLD_CL_MAGIC),OLD_CL_MAGIC_ADDR+__PAGE_OFFSET
 	jne 1f
-	movzwl OLD_CL_OFFSET,%esi
+	movzwl OLD_CL_OFFSET+__PAGE_OFFSET,%esi
 	addl $(OLD_CL_BASE_ADDR),%esi
 2:
+	addl $__PAGE_OFFSET, %esi	/* Make %esi virtual */
 	movl $empty_zero_page+2048,%edi
 	movl $512,%ecx
 	rep
 	movsl
 1:
 checkCPUtype:
-
+#ifdef CONFIG_SMP	
+	pushl %ebx			# Preserve boot cpu flag
+#endif	
 	movl $-1,X86_CPUID		#  -1 for no CPUID initially
 
 /* check if it is 486 or 386. */
@@ -249,37 +188,79 @@
 	movl %eax,%cr0
 
 	call check_x87
-	incb ready
-	lgdt cpu_gdt_descr
-	lidt idt_descr
-	ljmp $(__KERNEL_CS),$1f
-1:	movl $(__KERNEL_DS),%eax	# reload all the segment registers
-	movl %eax,%ss			# after changing gdt.
 
-	movl $(__USER_DS),%eax		# DS/ES contains default USER segment
-	movl %eax,%ds
-	movl %eax,%es
-
-	xorl %eax,%eax			# Clear FS/GS and LDT
-	movl %eax,%fs
-	movl %eax,%gs
-	lldt %ax
-	cld			# gcc2 wants the direction flag cleared at all times
 #ifdef CONFIG_SMP
-	movb ready, %cl	
-	cmpb $1,%cl
-	je 1f			# the first CPU calls start_kernel
+	popl %ebx		# Restore boot cpu
+	orw %bx,%bx
+	jz 1f			# the first CPU calls start_kernel
 				# all other CPUs call initialize_secondary
+	call paging_start	# after enabling paging
 	call initialize_secondary
 	jmp L6
-1:
-#endif
+1:	
+#endif	
 	call start_kernel
 L6:
 	jmp L6			# main should never return here, but
 				# just in case, we know what happens.
 
-ready:	.byte 0
+/*
+ * Enable paging _text - _stext is identity mapped page
+ */
+ENTRY(paging_start)
+	/* Set the page table pointer */
+	movl $(swapper_pg_dir - __PAGE_OFFSET), %eax
+	movl %eax, %cr3
+
+/*
+ *	New page tables may be in 4Mbyte page mode and may
+ *	be using the global pages. 
+ *
+ *	NOTE! If we are on a 486 we may have no cr4 at all!
+ *	So we do not try to touch it unless we really have
+ *	some bits in it to set.  This won't work if the BSP
+ *	implements cr4 but an AP does not -- very unlikely
+ *	but be warned!  The same applies to the pse feature
+ *	if not equally supported. --macro
+ */
+	
+	/* Set cr4 */
+	cmpl $0, mmu_cr4_features
+	je 1f
+	movl %cr4, %eax
+	orl mmu_cr4_features, %eax
+	movl %eax, %cr4
+1:
+	
+	/* DS/ES contain default USER segment */
+	movl $__USER_DS, %eax
+	movl %eax, %ds
+	movl %eax, %es
+
+	movl $__KERNEL_DS, %eax
+	movl %eax, %ss
+
+	 /* Normalize %cs */
+	ljmp $__KERNEL_CS, $(1f - __PAGE_OFFSET)
+1:			
+	/*
+	 * Enable paging
+	 */
+	movl %cr0, %eax
+	orl $0x80000000, %eax
+	movl %eax, %cr0
+
+	/* Clear prefetch and normalize %eip */	
+	ljmp $__KERNEL_CS, $1f
+1:
+
+	/* Reload the gdt pointer */
+	lgdt cpu_gdt_descr
+
+	/* Reload the idt pointer */
+	lidt idt_descr
+
+	ret
 
 /*
  * We depend on ET to be correct. This checks for 287/387.
@@ -303,32 +284,39 @@
 /*
  *  setup_idt
  *
- *  sets up a idt with 256 entries pointing to
- *  ignore_int, interrupt gates. It doesn't actually load
- *  idt - that can be done only after paging has been enabled
- *  and the kernel moved to PAGE_OFFSET. Interrupts
- *  are enabled elsewhere, when we can be relatively
- *  sure everything is ok.
+ *  sets up two idt's with 256 entries pointing to
+ *  ignore_int, interrupt gates.  boot_idt_table is only used
+ *  during early initialization before paging is enabled.
+ *  idt_table is the primary idt of the kernel and is later
+ *  updated as needed.
  */
 setup_idt:
 	lea ignore_int,%edx
 	movl $(__KERNEL_CS << 16),%eax
+	movl $(__VIRT_CS   << 16),%ecx
 	movw %dx,%ax		/* selector = 0x0010 = cs */
+	movw %dx,%cx
 	movw $0x8E00,%dx	/* interrupt gate - dpl=0, present */
 
-	lea idt_table,%edi
-	mov $256,%ecx
+	movl $idt_table,%edi
+	movl $boot_idt_table, %ebp
 rp_sidt:
 	movl %eax,(%edi)
+	movl %ecx,(%ebp)
 	movl %edx,4(%edi)
+	movl %edx,4(%ebp)
 	addl $8,%edi
-	dec %ecx
+	addl $8,%ebp
+	cmp  $(idt_table + 2048), %edi
 	jne rp_sidt
 	ret
 
+	/* The smp startup code modifies stack_start.esp to assign
+	 * new cpus their on stack.
+	 */
 ENTRY(stack_start)
 	.long init_thread_union+THREAD_SIZE
-	.long __BOOT_DS
+	.long __VIRT_DS
 
 /* This is the default interrupt "handler" :-) */
 int_msg:
@@ -341,7 +329,8 @@
 	pushl %edx
 	pushl %es
 	pushl %ds
-	movl $(__KERNEL_DS),%eax
+	/* SS is a known good data segment */
+	movl %ss, %eax
 	movl %eax,%ds
 	movl %eax,%es
 	pushl $int_msg
@@ -354,13 +343,37 @@
 	popl %eax
 	iret
 
+.section ".init.data"
+/* boot_gdt and boot_idt are boot time versions idt_desc and
+ * cpu_gdt_descr respectively.  For their 32-bit linear address they
+ * use physical rather than virtual addresses.
+ */	
+	ALIGN
+	.word 0				# 32 bit align idt_desc.address
+boot_idt:
+	.word IDT_ENTRIES*8-1
+	.long boot_idt_table - __PAGE_OFFSET
+		
+	.word 0				# 32 bit align gdt_desc.address
+boot_gdt:	
+	.word GDT_ENTRIES*8 - 1		
+	.long cpu_gdt_table - __PAGE_OFFSET
+
+/* idt_table is used for the entire lifetime of the kernel,
+ * so must use __KERNEL_CS and virtual address.  boot_idt_table
+ * is used before paging is initialized and uses __VIRT_CS.
+ * Initialized to 0.	
+ */
+boot_idt_table:
+	.fill 256,8,0
+		
 /*
  * The IDT and GDT 'descriptors' are a strange 48-bit object
  * only used by the lidt and lgdt instructions. They are not
  * like usual segment descriptors - they consist of a 16-bit
  * segment size, and 32-bit linear address value:
  */
-
+.data       
 .globl idt_descr
 .globl cpu_gdt_descr
 
@@ -378,77 +391,37 @@
 
 	.fill NR_CPUS-1,8,0		# space for the other GDT descriptors
 
-/*
- * This is initialized to create an identity-mapping at 0-8M (for bootup
- * purposes) and another mapping of the 0-8M area at virtual address
- * PAGE_OFFSET.
+ /*
+  * This is initialized by arch/i386/mm/init.c and is the pgd of the kernels
+  * page tables.  The values put here should be all invalid (zero)
  */
-.org 0x1000
+.balign 4096
 ENTRY(swapper_pg_dir)
-	.long 0x00102007
-	.long 0x00103007
-	.fill BOOT_USER_PGD_PTRS-2,4,0
-	/* default: 766 entries */
-	.long 0x00102007
-	.long 0x00103007
-	/* default: 254 entries */
-	.fill BOOT_KERNEL_PGD_PTRS-2,4,0
-
-/*
- * The page tables are initialized to only 8MB here - the final page
- * tables are set up later depending on memory size.
- */
-.org 0x2000
-ENTRY(pg0)
-
-.org 0x3000
-ENTRY(pg1)
+	.fill 1024,4,0
 
-/*
- * empty_zero_page must immediately follow the page tables ! (The
- * initialization loop counts until empty_zero_page)
- */
-
-.org 0x4000
+.balign 4096
 ENTRY(empty_zero_page)
-
-.org 0x5000
+	.fill 4096,1,0
 
 /*
  * Real beginning of normal "text" segment
  */
+.text
 ENTRY(stext)
 ENTRY(_stext)
 
 /*
- * This starts the data section. Note that the above is all
- * in the text section because it has alignment requirements
- * that we cannot fulfill any other way.
- */
-.data
-
-/*
  * The Global Descriptor Table contains 28 quadwords, per-CPU.
  */
-#if defined(CONFIG_SMP) || defined(CONFIG_X86_VISWS)
-/*
- * The boot_gdt_table must mirror the equivalent in setup.S and is
- * used only by the trampoline for booting other CPUs
- */
-	.align L1_CACHE_BYTES
-ENTRY(boot_gdt_table)
-	.fill GDT_ENTRY_BOOT_CS,8,0
-	.quad 0x00cf9a000000ffff	/* kernel 4GB code at 0x00000000 */
-	.quad 0x00cf92000000ffff	/* kernel 4GB data at 0x00000000 */
-#endif
+.data
 	.align L1_CACHE_BYTES
 ENTRY(cpu_gdt_table)
 	.quad 0x0000000000000000	/* NULL descriptor */
 	.quad 0x0000000000000000	/* 0x0b reserved */
 	.quad 0x0000000000000000	/* 0x13 reserved */
 	.quad 0x0000000000000000	/* 0x1b reserved */
-	.quad 0x0000000000000000	/* 0x20 unused */
-	.quad 0x0000000000000000	/* 0x28 unused */
+	.quad 0x40cf9a000000ffff	/* 0x20 kernel 4G code at 0-__PAGE_OFFSET */
+	.quad 0x40cf92000000ffff	/* 0x28 kernel 4G data at 0-__PAGE_OFFSET */
 	.quad 0x0000000000000000	/* 0x33 TLS entry 1 */
 	.quad 0x0000000000000000	/* 0x3b TLS entry 2 */
 	.quad 0x0000000000000000	/* 0x43 TLS entry 3 */
diff -uNrX linux-ignore-files linux-2.6.4-rc1/arch/i386/kernel/trampoline.S linux-2.6.4-rc1.nobootpgtbl/arch/i386/kernel/trampoline.S
--- linux-2.6.4-rc1/arch/i386/kernel/trampoline.S	Wed Dec 17 19:58:45 2003
+++ linux-2.6.4-rc1.nobootpgtbl/arch/i386/kernel/trampoline.S	Sun Feb 29 22:27:35 2004
@@ -14,10 +14,6 @@
  *	In fact we don't actually need a stack so we don't
  *	set one up.
  *
- *	We jump into the boot/compressed/head.S code. So you'd
- *	better be running a compressed kernel image or you
- *	won't get very far.
- *
  *	On entry to trampoline_data, the processor is in real mode
  *	with 16-bit addressing and 16-bit data.  CS has some value
  *	and IP is zero.  Thus, data addresses need to be absolute
@@ -56,9 +52,8 @@
 	lmsw	%ax		# into protected mode
 	jmp	flush_instr
 flush_instr:
-	ljmpl	$__BOOT_CS, $0x00100000
+	ljmpl	$__KERNEL_CS, $0x00100000
 			# jump to startup_32 in arch/i386/kernel/head.S
-
 boot_idt:
 	.word	0			# idt limit = 0
 	.word	0, 0			# idt base = 0L
@@ -67,9 +62,9 @@
 # NOTE: here we actually use CPU#0's GDT - but that is OK, we reload
 # the proper GDT shortly after booting up the secondary CPUs.
 #
-ENTRY(boot_gdt)
-	.word	__BOOT_DS + 7			# gdt limit
-	.long	boot_gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
+boot_gdt:
+	.word	GDT_ENTRIES*8-1			# gdt limit
+	.long	cpu_gdt_table-__PAGE_OFFSET	# gdt base = gdt (first SMP CPU)
 
 .globl trampoline_end
 trampoline_end:
diff -uNrX linux-ignore-files linux-2.6.4-rc1/arch/i386/mach-voyager/voyager_basic.c linux-2.6.4-rc1.nobootpgtbl/arch/i386/mach-voyager/voyager_basic.c
--- linux-2.6.4-rc1/arch/i386/mach-voyager/voyager_basic.c	Wed Dec 17 19:58:30 2003
+++ linux-2.6.4-rc1.nobootpgtbl/arch/i386/mach-voyager/voyager_basic.c	Sun Feb 29 22:28:49 2004
@@ -32,6 +32,8 @@
 #include <asm/tlbflush.h>
 #include <asm/arch_hooks.h>
 
+extern void * boot_ioremap(unsigned long, unsigned long);
+
 /*
  * Power off function, if any
  */
@@ -131,10 +133,9 @@
 	__u8 cmos[4];
 	ClickMap_t *map;
 	unsigned long map_addr;
-	unsigned long old;
 
 	if(region >= CLICK_ENTRIES) {
-		printk("Voyager: Illegal ClickMap region %d\n", region);
+		printk(KERN_WARNING "Voyager: Illegal ClickMap region %d\n", region);
 		return 0;
 	}
 
@@ -143,12 +144,13 @@
 
 	map_addr = *(unsigned long *)cmos;
 
-	/* steal page 0 for this */
-	old = pg0[0];
-	pg0[0] = ((map_addr & PAGE_MASK) | _PAGE_RW | _PAGE_PRESENT);
-	local_flush_tlb();
-	/* now clear everything out but page 0 */
-	map = (ClickMap_t *)(map_addr & (~PAGE_MASK));
+	/* map in the clickmap */
+	map = boot_ioremap(map_addr, sizeof(*map));
+	if (!map) {
+		printk(KERN_WARNING "Voyager: cannot map ClickMap\n");
+		return 0;
+	}
+		
 
 	/* zero length is the end of the clickmap */
 	if(map->Entry[region].Length != 0) {
@@ -156,10 +158,6 @@
 		*start = map->Entry[region].Address;
 		retval = 1;
 	}
-
-	/* replace the mapping */
-	pg0[0] = old;
-	local_flush_tlb();
 	return retval;
 }
 
diff -uNrX linux-ignore-files linux-2.6.4-rc1/arch/i386/mm/boot_ioremap.c linux-2.6.4-rc1.nobootpgtbl/arch/i386/mm/boot_ioremap.c
--- linux-2.6.4-rc1/arch/i386/mm/boot_ioremap.c	Wed Dec 17 20:00:02 2003
+++ linux-2.6.4-rc1.nobootpgtbl/arch/i386/mm/boot_ioremap.c	Sun Feb 29 22:29:42 2004
@@ -7,78 +7,26 @@
  * Written by Dave Hansen <haveblue@us.ibm.com>
  */
 
-
-/*
- * We need to use the 2-level pagetable functions, but CONFIG_X86_PAE
- * keeps that from happenning.  If anyone has a better way, I'm listening.
- *
- * boot_pte_t is defined only if this all works correctly
- */
-
 #include <linux/config.h>
-#undef CONFIG_X86_PAE
-#include <asm/page.h>
-#include <asm/pgtable.h>
-#include <asm/tlbflush.h>
 #include <linux/init.h>
 #include <linux/stddef.h>
-
-/* 
- * I'm cheating here.  It is known that the two boot PTE pages are 
- * allocated next to each other.  I'm pretending that they're just
- * one big array. 
- */
-
-#define BOOT_PTE_PTRS (PTRS_PER_PTE*2)
-#define boot_pte_index(address) \
-	     (((address) >> PAGE_SHIFT) & (BOOT_PTE_PTRS - 1))
-
-static inline boot_pte_t* boot_vaddr_to_pte(void *address)
-{
-	boot_pte_t* boot_pg = (boot_pte_t*)pg0;
-	return &boot_pg[boot_pte_index((unsigned long)address)];
-}
-
-/*
- * This is only for a caller who is clever enough to page-align
- * phys_addr and virtual_source, and who also has a preference
- * about which virtual address from which to steal ptes
- */
-static void __boot_ioremap(unsigned long phys_addr, unsigned long nrpages, 
-		    void* virtual_source)
-{
-	boot_pte_t* pte;
-	int i;
-	char *vaddr = virtual_source;
-
-	pte = boot_vaddr_to_pte(virtual_source);
-	for (i=0; i < nrpages; i++, phys_addr += PAGE_SIZE, pte++) {
-		set_pte(pte, pfn_pte(phys_addr>>PAGE_SHIFT, PAGE_KERNEL));
-		__flush_tlb_one(&vaddr[i*PAGE_SIZE]);
-	}
-}
-
-/* the virtual space we're going to remap comes from this array */
-#define BOOT_IOREMAP_PAGES 4
-#define BOOT_IOREMAP_SIZE (BOOT_IOREMAP_PAGES*PAGE_SIZE)
-__initdata char boot_ioremap_space[BOOT_IOREMAP_SIZE] 
-		__attribute__ ((aligned (PAGE_SIZE)));
+#include <asm/page.h>
 
 /*
  * This only applies to things which need to ioremap before paging_init()
  * bt_ioremap() and plain ioremap() are both useless at this point.
  * 
- * When used, we're still using the boot-time pagetables, which only
- * have 2 PTE pages mapping the first 8MB
+ * Early in the boot we just use segments instead of real page tables
+ * so all this needs to do is add __PAGE_OFFSET. 
  *
+ * In this implementation all mappings are alive simultaneously
+ * in other implementations only one mapping can be used at a time.
+ * 
  * There is no unmap.  The boot-time PTE pages aren't used after boot.
- * If you really want the space back, just remap it yourself.
- * boot_ioremap(&ioremap_space-PAGE_OFFSET, BOOT_IOREMAP_SIZE)
  */
 __init void* boot_ioremap(unsigned long phys_addr, unsigned long size)
 {
 	unsigned long last_addr, offset;
-	unsigned int nrpages;
 	
 	last_addr = phys_addr + size - 1;
 
@@ -87,11 +35,11 @@
 	phys_addr &= PAGE_MASK;
 	size = PAGE_ALIGN(last_addr) - phys_addr;
 	
-	nrpages = size >> PAGE_SHIFT;
-	if (nrpages > BOOT_IOREMAP_PAGES)
+	/* Don't allow mappings that cross 4G boundaries */
+	if (((phys_addr + __PAGE_OFFSET) > (phys_addr + __PAGE_OFFSET + size)) ||
+		(phys_addr > (phys_addr + size))) {
 		return NULL;
-	
-	__boot_ioremap(phys_addr, nrpages, boot_ioremap_space);
+	}
 
-	return &boot_ioremap_space[offset];
+	return __va(phys_addr);
 }
diff -uNrX linux-ignore-files linux-2.6.4-rc1/arch/i386/mm/init.c linux-2.6.4-rc1.nobootpgtbl/arch/i386/mm/init.c
--- linux-2.6.4-rc1/arch/i386/mm/init.c	Sun Feb 22 16:22:23 2004
+++ linux-2.6.4-rc1.nobootpgtbl/arch/i386/mm/init.c	Sun Feb 29 22:37:41 2004
@@ -288,6 +288,11 @@
 
 #ifdef CONFIG_X86_PAE
 	int i;
+	if (!cpu_has_pae)
+		panic("cannot execute a PAE-enabled kernel on a PAE-less CPU!");
+
+	set_in_cr4(X86_CR4_PAE);
+
 	/* Init entries of the first-level page table to the zero page */
 	for (i = 0; i < PTRS_PER_PGD; i++)
 		set_pgd(pgd_base + i, __pgd(__pa(empty_zero_page) | _PAGE_PRESENT));
@@ -316,16 +321,23 @@
 
 	permanent_kmaps_init(pgd_base);
 
-#ifdef CONFIG_X86_PAE
 	/*
-	 * Add low memory identity-mappings - SMP needs it when
-	 * starting up on an AP from real-mode. In the non-PAE
-	 * case we already have these mappings through head.S.
-	 * All user-space mappings are explicitly cleared after
+	 * Identity map the code between _text and _stext.  This
+	 * identity mapping needs to persist through SMP startup.
+	 *
+	 * The only real user is paging_start() which needs to
+	 * live on an identity mapped page to transition from physical
+	 * to virtual address mode.  paging_start() must be called
+	 * on each processor so this mapping needs to persist through
 	 * SMP startup.
+	 *
+	 * After SMP startup all user-space mappings are explicitly
+	 * cleared which removes the identity mapping.
+	 * 
+	 * Identity mapping the first pgd entry is overkill but it
+	 * is an extremely easy way to accomplish the needed mapping.
 	 */
 	pgd_base[0] = pgd_base[USER_PTRS_PER_PGD];
-#endif
 }
 
 void zap_low_mappings (void)
@@ -382,17 +394,7 @@
 {
 	pagetable_init();
 
-	load_cr3(swapper_pg_dir);
-
-#ifdef CONFIG_X86_PAE
-	/*
-	 * We will bail out later - printk doesn't work right now so
-	 * the user would just see a hanging kernel.
-	 */
-	if (cpu_has_pae)
-		set_in_cr4(X86_CR4_PAE);
-#endif
-	__flush_tlb_all();
+	paging_start();
 
 	kmap_init();
 	zone_sizes_init();
@@ -508,10 +510,6 @@
 		(unsigned long) (totalhigh_pages << (PAGE_SHIFT-10))
 	       );
 
-#ifdef CONFIG_X86_PAE
-	if (!cpu_has_pae)
-		panic("cannot execute a PAE-enabled kernel on a PAE-less CPU!");
-#endif
 	if (boot_cpu_data.wp_works_ok < 0)
 		test_wp_bit();
 
diff -uNrX linux-ignore-files linux-2.6.4-rc1/include/asm-i386/pgtable.h linux-2.6.4-rc1.nobootpgtbl/include/asm-i386/pgtable.h
--- linux-2.6.4-rc1/include/asm-i386/pgtable.h	Sun Feb 22 16:23:27 2004
+++ linux-2.6.4-rc1.nobootpgtbl/include/asm-i386/pgtable.h	Sun Feb 29 22:38:12 2004
@@ -42,6 +42,7 @@
 void pgd_dtor(void *, kmem_cache_t *, unsigned long);
 void pgtable_cache_init(void);
 void paging_init(void);
+void paging_start(void);
 
 #endif /* !__ASSEMBLY__ */
 
diff -uNrX linux-ignore-files linux-2.6.4-rc1/include/asm-i386/segment.h linux-2.6.4-rc1.nobootpgtbl/include/asm-i386/segment.h
--- linux-2.6.4-rc1/include/asm-i386/segment.h	Wed Dec 17 19:58:29 2003
+++ linux-2.6.4-rc1.nobootpgtbl/include/asm-i386/segment.h	Sun Feb 29 22:38:27 2004
@@ -88,6 +88,11 @@
 #define GDT_ENTRY_BOOT_DS		(GDT_ENTRY_BOOT_CS + 1)
 #define __BOOT_DS	(GDT_ENTRY_BOOT_DS * 8)
 
+/* Additional GDT entries for ..... */
+#define GDT_ENTRY_VIRT_CS		4
+#define __VIRT_CS	(GDT_ENTRY_VIRT_CS * 8)
+#define GDT_ENTRY_VIRT_DS		(GDT_ENTRY_VIRT_CS + 1)
+#define __VIRT_DS	(GDT_ENTRY_VIRT_DS * 8)
 /*
  * The interrupt descriptor table has room for 256 idt's,
  * the global descriptor table is dependent on the number






Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVEFMpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVEFMpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 08:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVEFMpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 08:45:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:26026 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261214AbVEFMnk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 08:43:40 -0400
Date: Fri, 6 May 2005 18:14:09 +0530
From: R Sharada <sharada@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, torvalds@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org, miltonm@bga.com
Subject: Re: [PATCH] ppc64: kexec support for ppc64
Message-ID: <20050506124409.GB2741@in.ibm.com>
Reply-To: sharada@in.ibm.com
References: <17019.3752.917407.742713@cargo.ozlabs.ibm.com> <20050506124158.GA2741@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506124158.GA2741@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the kexec support for ppc64



kexec support for ppc64 platforms.
                                                                                
A couple of notes:
                                                                                
1)  We copy the pages in virtual mode, using the full base kernel
    and a statically allocated stack.   At kexec_prepare time we
    scan the pages and if any overlap our (0, _end[]) range we
    return -ETXTBSY.
                                                                                
    On PowerPC 64 systems running in LPAR (logical partitioning)
    mode, only a small region of memory, referred to as the RMO,
    can be accessed in real mode.  Since Linux runs with only one
    zone of memory in the memory allocator, and it can be orders of
    magnitude more memory than the RMO, looping until we allocate
    pages in the source region is not feasible.  Copying in virtual
    means we don't have to write a hash table generation and call
    hypervisor to insert translations, instead we rely on the pinned
    kernel linear mapping.  The kernel already has move to linked
    location built in, so there is no requirement to load it at 0.
                                                                                
    If we want to load something other than a kernel, then a stub
    can be written to copy a linear chunk in real mode.

2)  The start entry point gets passed parameters from the kernel.
    Slaves are started at a fixed address after copying code from
    the entry point.
                                                                                
    All CPUs get passed their firmware assigned physical id in r3
    (most calling conventions use this register for the first
    argument).
                                                                                
    This is used to distinguish each CPU from all other CPUs.
    Since firmware is not around, there is no other way to obtain
    this information other than to pass it somewhere.
                                                                                
    A single CPU, referred to here as the master and the one executing
   the kexec call, branches to start with the address of start in r4.
    While this can be calculated, we have to load it through a gpr to
    branch to this point so defining the register this is contained
    in is free.  A stack of unspecified size is available at r1
    (also common calling convention).
                                                                                
    All remaining running CPUs are sent to start at absolute address
    0x60 after copying the first 0x100 bytes from start to address 0.
    This convention was chosen because it matches what the kernel
    has been doing itself.  (only gpr3 is defined).
                                                                                
    Note: This is not quite the convention of the kexec bootblock v2
    in the kernel.  A stub has been written to convert between them,
    and we may adjust the kernel in the future to allow this directly
    without any stub.
                                                                                
3)  Destination pages can be placed anywhere, even where they
    would not be accessible in real mode.  This will allow us to
    place ram disks above the RMO if we choose.

Signed-off-by: Milton Miller <miltonm@bga.com>

Signed-off-by: R Sharada <sharada@in.ibm.com>
---

 linux-2.6.12-rc3-mm3-sharada/arch/ppc64/Kconfig                |   17 
 linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/Makefile        |    1 
 linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/head.S          |    6 
 linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/machine_kexec.c |  301 +++++++++++++
 linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/misc.S          |  179 +++++++
 linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/mpic.c          |   29 +
 linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/mpic.h          |    3 
 linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/pSeries_setup.c |   10 
 linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/setup.c         |   19 
 linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/xics.c          |   25 +
 linux-2.6.12-rc3-mm3-sharada/include/asm-ppc64/kexec.h         |   45 +
 linux-2.6.12-rc3-mm3-sharada/include/asm-ppc64/machdep.h       |    1 
 linux-2.6.12-rc3-mm3-sharada/include/asm-ppc64/xics.h          |    1 
 13 files changed, 620 insertions(+), 17 deletions(-)

diff -puN arch/ppc64/Kconfig~kexec-ppc64 arch/ppc64/Kconfig
--- linux-2.6.12-rc3-mm3/arch/ppc64/Kconfig~kexec-ppc64	2005-05-05 20:22:00.380142336 +0530
+++ linux-2.6.12-rc3-mm3-sharada/arch/ppc64/Kconfig	2005-05-05 20:22:07.871202616 +0530
@@ -123,6 +123,23 @@ config PPC_SPLPAR
 	  processors, that is, which share physical processors between
 	  two or more partitions.
 
+config KEXEC
+	bool "kexec system call (EXPERIMENTAL)"
+	depends on PPC_MULTIPLATFORM && EXPERIMENTAL
+	help
+	  kexec is a system call that implements the ability to shutdown your
+	  current kernel, and to start another kernel.  It is like a reboot
+	  but it is indepedent of the system firmware.  And like a reboot
+	  you can start any kernel with it, not just Linux.
+
+	  The name comes from the similiarity to the exec system call.
+
+	  It is an ongoing process to be certain the hardware in a machine
+	  is properly shutdown, so do not be surprised if this code does not
+	  initially work for you.  It may help to enable device hotplugging
+	  support.  As of this writing the exact hardware interface is
+	  strongly in flux, so no good recommendation can be made.
+
 config IBMVIO
 	depends on PPC_PSERIES || PPC_ISERIES
 	bool
diff -puN arch/ppc64/kernel/Makefile~kexec-ppc64 arch/ppc64/kernel/Makefile
--- linux-2.6.12-rc3-mm3/arch/ppc64/kernel/Makefile~kexec-ppc64	2005-05-05 20:22:00.433134280 +0530
+++ linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/Makefile	2005-05-05 20:22:07.872202464 +0530
@@ -34,6 +34,7 @@ obj-$(CONFIG_PPC_PSERIES) += pSeries_pci
 			     pSeries_nvram.o rtasd.o ras.o pSeries_reconfig.o \
 			     xics.o rtas.o pSeries_setup.o pSeries_iommu.o
 
+obj-$(CONFIG_KEXEC)		+= machine_kexec.o
 obj-$(CONFIG_EEH)		+= eeh.o
 obj-$(CONFIG_PROC_FS)		+= proc_ppc64.o
 obj-$(CONFIG_RTAS_FLASH)	+= rtas_flash.o
diff -puN arch/ppc64/kernel/head.S~kexec-ppc64 arch/ppc64/kernel/head.S
--- linux-2.6.12-rc3-mm3/arch/ppc64/kernel/head.S~kexec-ppc64	2005-05-05 20:22:00.486126224 +0530
+++ linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/head.S	2005-05-05 20:22:07.875202008 +0530
@@ -1194,7 +1194,7 @@ _GLOBAL(pSeries_secondary_smp_init)
 	bl	.__restore_cpu_setup
 
 	/* Set up a paca value for this processor. Since we have the
-	 * physical cpu id in r3, we need to search the pacas to find
+	 * physical cpu id in r24, we need to search the pacas to find
 	 * which logical id maps to our physical one.
 	 */
 	LOADADDR(r13, paca) 		/* Get base vaddr of paca array	 */
@@ -1207,8 +1207,8 @@ _GLOBAL(pSeries_secondary_smp_init)
 	cmpwi	r5,NR_CPUS
 	blt	1b
 
-99:	HMT_LOW				/* Couldn't find our CPU id      */
-	b	99b
+	mr	r3,r24			/* not found, copy phys to r3	 */
+	b	.kexec_wait		/* next kernel might do better	 */
 
 2:	mtspr	SPRG3,r13		/* Save vaddr of paca in SPRG3	 */
 	/* From now on, r24 is expected to be logica cpuid */
diff -puN /dev/null arch/ppc64/kernel/machine_kexec.c
--- /dev/null	2005-04-25 18:25:42.651941720 +0530
+++ linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/machine_kexec.c	2005-05-05 20:22:07.878201552 +0530
@@ -0,0 +1,301 @@
+/*
+ * machine_kexec.c - handle transition of Linux booting another kernel
+ *
+ * Copyright (C) 2004-2005, IBM Corp.
+ *
+ * Created by: Milton D Miller II
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+
+#include <linux/cpumask.h>
+#include <linux/kexec.h>
+#include <linux/smp.h>
+#include <linux/thread_info.h>
+#include <linux/errno.h>
+
+#include <asm/page.h>
+#include <asm/current.h>
+#include <asm/machdep.h>
+#include <asm/cacheflush.h>
+#include <asm/paca.h>
+#include <asm/mmu.h>
+#include <asm/sections.h>	/* _end */
+#include <asm/prom.h>
+
+#define HASH_GROUP_SIZE 0x80	/* size of each hash group, asm/mmu.h */
+
+/* Have this around till we move it into crash specific file */
+note_buf_t crash_notes[NR_CPUS];
+
+/* Dummy for now. Not sure if we need to have a crash shutdown in here
+ * and if what it will achieve. Letting it be now to compile the code
+ * in generic kexec environment
+ */
+void machine_crash_shutdown(void)
+{
+	/* do nothing right now */
+	/* smp_relase_cpus() if we want smp on panic kernel */
+	/* cpu_irq_down to isolate us until we are ready */
+}
+
+int machine_kexec_prepare(struct kimage *image)
+{
+	int i;
+	unsigned long begin, end;	/* limits of segment */
+	unsigned long low, high;	/* limits of blocked memory range */
+	struct device_node *node;
+	unsigned long *basep;
+	unsigned int *sizep;
+
+	if (!ppc_md.hpte_clear_all)
+		return -ENOENT;
+
+	/*
+	 * Since we use the kernel fault handlers and paging code to
+	 * handle the virtual mode, we must make sure no destination
+	 * overlaps kernel static data or bss.
+	 */
+	for(i = 0; i < image->nr_segments; i++)
+		if (image->segment[i].mem < __pa(_end))
+			return -ETXTBSY;
+
+	/*
+	 * For non-LPAR, we absolutely can not overwrite the mmu hash
+	 * table, since we are still using the bolted entries in it to
+	 * do the copy.  Check that here.
+	 *
+	 * It is safe if the end is below the start of the blocked
+	 * region (end <= low), or if the beginning is after the
+	 * end of the blocked region (begin >= high).  Use the
+	 * boolean identity !(a || b)  === (!a && !b).
+	 */
+	if (htab_address) {
+		low = __pa(htab_address);
+		high = low + (htab_hash_mask + 1) * HASH_GROUP_SIZE;
+
+		for(i = 0; i < image->nr_segments; i++) {
+			begin = image->segment[i].mem;
+			end = begin + image->segment[i].memsz;
+
+			if ((begin < high) && (end > low))
+				return -ETXTBSY;
+		}
+	}
+
+	/* We also should not overwrite the tce tables */
+	for (node = of_find_node_by_type(NULL, "pci"); node != NULL;
+			node = of_find_node_by_type(node, "pci")) {
+		basep = (unsigned long *)get_property(node, "linux,tce-base",
+							NULL);
+		sizep = (unsigned int *)get_property(node, "linux,tce-size",
+							NULL);
+		if (basep == NULL || sizep == NULL)
+			continue;
+
+		low = *basep;
+		high = low + (*sizep);
+
+		for(i = 0; i < image->nr_segments; i++) {
+			begin = image->segment[i].mem;
+			end = begin + image->segment[i].memsz;
+
+			if ((begin < high) && (end > low))
+				return -ETXTBSY;
+		}
+	}
+
+	return 0;
+}
+
+void machine_kexec_cleanup(struct kimage *image)
+{
+	/* we do nothing in prepare that needs to be undone */
+}
+
+#define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)
+
+static void copy_segments(unsigned long ind)
+{
+	unsigned long entry;
+	unsigned long *ptr;
+	void *dest;
+	void *addr;
+
+	/*
+	 * We rely on kexec_load to create a lists that properly
+	 * initializes these pointers before they are used.
+	 * We will still crash if the list is wrong, but at least
+	 * the compiler will be quiet.
+	 */
+	ptr = NULL;
+	dest = NULL;
+
+	for (entry = ind; !(entry & IND_DONE); entry = *ptr++) {
+		addr = __va(entry & PAGE_MASK);
+
+		switch (entry & IND_FLAGS) {
+		case IND_DESTINATION:
+			dest = addr;
+			break;
+		case IND_INDIRECTION:
+			ptr = addr;
+			break;
+		case IND_SOURCE:
+			copy_page(dest, addr);
+			dest += PAGE_SIZE;
+		}
+	}
+}
+
+void kexec_copy_flush(struct kimage *image)
+{
+	long i, nr_segments = image->nr_segments;
+	struct  kexec_segment ranges[KEXEC_SEGMENT_MAX];
+
+	/* save the ranges on the stack to efficiently flush the icache */
+	memcpy(ranges, image->segment, sizeof(ranges));
+
+	/*
+	 * After this call we may not use anything allocated in dynamic
+	 * memory, including *image.
+	 *
+	 * Only globals and the stack are allowed.
+	 */
+	copy_segments(image->head);
+
+	/*
+	 * we need to clear the icache for all dest pages sometime,
+	 * including ones that were in place on the original copy
+	 */
+	for (i = 0; i < nr_segments; i++)
+		flush_icache_range(ranges[i].mem + KERNELBASE,
+				ranges[i].mem + KERNELBASE +
+				ranges[i].memsz);
+}
+
+#ifdef CONFIG_SMP
+
+/* FIXME: we should schedule this function to be called on all cpus based
+ * on calling the interrupts, but we would like to call it off irq level
+ * so that the interrupt controller is clean.
+ */
+void kexec_smp_down(void *arg)
+{
+	if (ppc_md.cpu_irq_down)
+		ppc_md.cpu_irq_down();
+
+	local_irq_disable();
+	kexec_smp_wait();
+	/* NOTREACHED */
+}
+
+static void kexec_prepare_cpus(void)
+{
+	int my_cpu, i, notified=-1;
+
+	smp_call_function(kexec_smp_down, NULL, 0, /* wait */0);
+	my_cpu = get_cpu();
+
+	/* check the others cpus are now down (via paca hw cpu id == -1) */
+	for (i=0; i < NR_CPUS; i++) {
+		if (i == my_cpu)
+			continue;
+
+		while (paca[i].hw_cpu_id != -1) {
+			if (!cpu_possible(i)) {
+				printk("kexec: cpu %d hw_cpu_id %d is not"
+						" possible, ignoring\n",
+						i, paca[i].hw_cpu_id);
+				break;
+			}
+			if (!cpu_online(i)) {
+				/* Fixme: this can be spinning in
+				 * pSeries_secondary_wait with a paca
+				 * waiting for it to go online.
+				 */
+				printk("kexec: cpu %d hw_cpu_id %d is not"
+						" online, ignoring\n",
+						i, paca[i].hw_cpu_id);
+				break;
+			}
+			if (i != notified) {
+				printk( "kexec: waiting for cpu %d (physical"
+						" %d) to go down\n",
+						i, paca[i].hw_cpu_id);
+				notified = i;
+			}
+		}
+	}
+
+	/* after we tell the others to go down */
+	if (ppc_md.cpu_irq_down)
+		ppc_md.cpu_irq_down();
+
+	put_cpu();
+
+	local_irq_disable();
+}
+
+#else /* ! SMP */
+
+static void kexec_prepare_cpus(void)
+{
+	/*
+	 * move the secondarys to us so that we can copy
+	 * the new kernel 0-0x100 safely
+	 *
+	 * do this if kexec in setup.c ?
+	 */
+	smp_relase_cpus();
+	if (ppc_md.cpu_irq_down)
+		ppc_md.cpu_irq_down();
+	local_irq_disable();
+}
+
+#endif /* SMP */
+
+/*
+ * kexec thread structure and stack.
+ *
+ * We need to make sure that this is 16384-byte aligned due to the
+ * way process stacks are handled.  It also must be statically allocated
+ * or allocated as part of the kimage, because everything else may be
+ * overwritten when we copy the kexec image.  We piggyback on the
+ * "init_task" linker section here to statically allocate a stack.
+ *
+ * We could use a smaller stack if we don't care about anything using
+ * current, but that audit has not been performed.
+ */
+union thread_union kexec_stack
+	__attribute__((__section__(".data.init_task"))) = { };
+
+/* Our assembly helper, in kexec_stub.S */
+extern NORET_TYPE void kexec_sequence(void *newstack, unsigned long start,
+	void *image, void *control, void (*clear_all)(void)) ATTRIB_NORET;
+
+/* too late to fail here */
+void machine_kexec(struct kimage *image)
+{
+
+	/* prepare control code if any */
+
+	/* shutdown other cpus into our wait loop and quiesce interrupts */
+	kexec_prepare_cpus();
+
+	/* switch to a staticly allocated stack.  Based on irq stack code.
+	 * XXX: the task struct will likely be invalid once we do the copy!
+	 */
+	kexec_stack.thread_info.task = current_thread_info()->task;
+	kexec_stack.thread_info.flags = 0;
+
+	/* Some things are best done in assembly.  Finding globals with
+	 * a toc is easier in C, so pass in what we can.
+	 */
+	kexec_sequence(&kexec_stack, image->start, image,
+			page_address(image->control_code_page),
+			ppc_md.hpte_clear_all);
+	/* NOTREACHED */
+}
diff -puN arch/ppc64/kernel/misc.S~kexec-ppc64 arch/ppc64/kernel/misc.S
--- linux-2.6.12-rc3-mm3/arch/ppc64/kernel/misc.S~kexec-ppc64	2005-05-05 20:22:00.590110416 +0530
+++ linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/misc.S	2005-05-05 20:22:07.882200944 +0530
@@ -680,6 +680,181 @@ _GLOBAL(kernel_thread)
 	ld	r30,-16(r1)
 	blr
 
+/* kexec_wait(phys_cpu)
+ *
+ * wait for the flag to change, indicating this kernel is going away but
+ * the slave code for the next one is at addresses 0 to 100.
+ *
+ * This is used by all slaves.
+ *
+ * Physical (hardware) cpu id should be in r3.
+ */
+_GLOBAL(kexec_wait)
+	bl	1f
+1:	mflr	r5
+	addi	r5,5,kexec_flag-1b
+
+99:	HMT_LOW
+#ifdef CONFIG_KEXEC		/* use no memory without kexec */
+	lwz	r4,0(r5)
+	cmpwi	0,r4,0
+	bnea	0x60
+#endif
+	b	99b
+
+/* this can be in text because we won't change it until we are
+ * running in real anyways
+ */
+kexec_flag:
+	.long	0
+
+
+#ifdef CONFIG_KEXEC
+
+/* kexec_smp_wait(void)
+ *
+ * call with interrupts off
+ * note: this is a terminal routine, it does not save lr
+ *
+ * get phys id from paca
+ * set paca id to -1 to say we got here
+ * switch to real mode
+ * join other cpus in kexec_wait(phys_id)
+ */
+_GLOBAL(kexec_smp_wait)
+	lhz	r3,PACAHWCPUID(r13)
+	li	r4,-1
+	sth	r4,PACAHWCPUID(r13)	/* let others know we left */
+	bl	real_mode
+	b	.kexec_wait
+
+/*
+ * switch to real mode (turn mmu off)
+ * we use the early kernel trick that the hardware ignores bits
+ * 0 and 1 (big endian) of the effective address in real mode
+ *
+ * don't overwrite r3 here, it is live for kexec_wait above.
+ */
+real_mode:	/* assume normal blr return */
+1:	li	r9,MSR_RI
+	li	r10,MSR_DR|MSR_IR
+	mflr	r11		/* return address to SRR0 */
+	mfmsr	r12
+	andc	r9,r12,r9
+	andc	r10,r12,r10
+
+	mtmsrd	r9,1
+	mtspr	SPRN_SRR1,r10
+	mtspr	SPRN_SRR0,r11
+	rfid
+
+
+/*
+ * kexec_sequence(newstack, start, image, control, clear_all())
+ *
+ * does the grungy work with stack switching and real mode switches
+ * also does simple calls to other code
+ */
+
+_GLOBAL(kexec_sequence)
+	mflr	r0
+	std	r0,16(r1)
+
+	/* switch stacks to newstack -- &kexec_stack.stack */
+	stdu	r1,THREAD_SIZE-112(r3)
+	mr	r1,r3
+
+	li	r0,0
+	std	r0,16(r1)
+
+	/* save regs for local vars on new stack.
+	 * yes, we won't go back, but ...
+	 */
+	std	r31,-8(r1)
+	std	r30,-16(r1)
+	std	r29,-24(r1)
+	std	r28,-32(r1)
+	std	r27,-40(r1)
+	std	r26,-48(r1)
+	std	r25,-56(r1)
+
+	stdu	r1,-112-64(r1)
+
+	/* save args into preserved regs */
+	mr	r31,r3			/* newstack (both) */
+	mr	r30,r4			/* start (real) */
+	mr	r29,r5			/* image (virt) */
+	mr	r28,r6			/* control, unused */
+	mr	r27,r7			/* clear_all() fn desc */
+	mr	r26,r8			/* spare */
+	lhz	r25,PACAHWCPUID(r13)	/* get our phys cpu from paca */
+
+	/* disable interrupts, we are overwriting kernel data next */
+	mfmsr	r3
+	rlwinm	r3,r3,0,17,15
+	mtmsrd	r3,1
+
+	/* copy dest pages, flush whole dest image */
+	mr	r3,r29
+	bl	.kexec_copy_flush	/* (image) */
+
+	/* turn off mmu */
+	bl	real_mode
+
+	/* clear out hardware hash page table and tlb */
+	ld	r5,0(r27)		/* deref function descriptor */
+	mtctr	r5
+	bctrl				/* ppc_md.hash_clear_all(void); */
+
+/*
+ *   kexec image calling is:
+ *      the first 0x100 bytes of the entry point are copied to 0
+ *
+ *      all slaves branch to slave = 0x60 (absolute)
+ *              slave(phys_cpu_id);
+ *
+ *      master goes to start = entry point
+ *              start(phys_cpu_id, start, 0);
+ *
+ *
+ *   a wrapper is needed to call existing kernels, here is an approximate
+ *   description of one method:
+ *
+ * v2: (2.6.10)
+ *   start will be near the boot_block (maybe 0x100 bytes before it?)
+ *   it will have a 0x60, which will b to boot_block, where it will wait
+ *   and 0 will store phys into struct boot-block and load r3 from there,
+ *   copy kernel 0-0x100 and tell slaves to back down to 0x60 again
+ *
+ * v1: (2.6.9)
+ *    boot block will have all cpus scanning device tree to see if they
+ *    are the boot cpu ?????
+ *    other device tree differences (prop sizes, va vs pa, etc)...
+ */
+
+	/* copy  0x100 bytes starting at start to 0 */
+	li	r3,0
+	mr	r4,r30
+	li	r5,0x100
+	li	r6,0
+	bl	.copy_and_flush	/* (dest, src, copy limit, start offset) */
+1:	/* assume normal blr return */
+
+	/* release other cpus to the new kernel secondary start at 0x60 */
+	mflr	r5
+	li	r6,1
+	stw	r6,kexec_flag-1b(5)
+	mr	r3,r25	# my phys cpu
+	mr	r4,r30	# start, aka phys mem offset
+	mtlr	4
+	li	r5,0
+	blr	/* image->start(physid, image->start, 0); */
+#endif /* CONFIG_KEXEC */
+
+#ifdef CONFIG_PPC_RTAS /* hack hack hack */
+#define ppc_rtas	sys_ni_syscall
+#endif
+
 /* Why isn't this a) automatic, b) written in 'C'? */	
 	.balign 8
 _GLOBAL(sys_call_table32)
@@ -951,7 +1126,7 @@ _GLOBAL(sys_call_table32)
 	.llong .compat_sys_mq_timedreceive /* 265 */
 	.llong .compat_sys_mq_notify
 	.llong .compat_sys_mq_getsetattr
-	.llong .sys_ni_syscall		/* 268 reserved for sys_kexec_load */
+	.llong .compat_sys_kexec_load		/* 268 reserved for sys_kexec_load */
 	.llong .sys32_add_key
 	.llong .sys32_request_key
 	.llong .compat_sys_keyctl
@@ -1233,7 +1408,7 @@ _GLOBAL(sys_call_table)
 	.llong .sys_mq_timedreceive	/* 265 */
 	.llong .sys_mq_notify
 	.llong .sys_mq_getsetattr
-	.llong .sys_ni_syscall		/* 268 reserved for sys_kexec_load */
+	.llong .sys_kexec_load		/* 268 reserved for sys_kexec_load */
 	.llong .sys_add_key
 	.llong .sys_request_key		/* 270 */
 	.llong .sys_keyctl
diff -puN arch/ppc64/kernel/mpic.c~kexec-ppc64 arch/ppc64/kernel/mpic.c
--- linux-2.6.12-rc3-mm3/arch/ppc64/kernel/mpic.c~kexec-ppc64	2005-05-05 20:22:00.643102360 +0530
+++ linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/mpic.c	2005-05-05 20:22:07.883200792 +0530
@@ -792,6 +792,35 @@ void mpic_setup_this_cpu(void)
 #endif /* CONFIG_SMP */
 }
 
+/*
+ * XXX: someone who knows mpic should check this.
+ * do we need to eoi the ipi here (see xics comments)?
+ * or can we reset the mpic in the new kernel?
+ */
+void mpic_teardown_this_cpu(void)
+{
+	struct mpic *mpic = mpic_primary;
+	unsigned long flags;
+	u32 msk = 1 << hard_smp_processor_id();
+	unsigned int i;
+
+	BUG_ON(mpic == NULL);
+
+	DBG("%s: teardown_this_cpu(%d)\n", mpic->name, hard_smp_processor_id());
+	spin_lock_irqsave(&mpic_lock, flags);
+
+	/* let the mpic know we don't want intrs.  */
+	for (i = 0; i < mpic->num_sources ; i++)
+		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
+			mpic_irq_read(i, MPIC_IRQ_DESTINATION) & ~msk);
+
+	/* Set current processor priority to max */
+	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0xf);
+
+	spin_unlock_irqrestore(&mpic_lock, flags);
+}
+
+
 void mpic_send_ipi(unsigned int ipi_no, unsigned int cpu_mask)
 {
 	struct mpic *mpic = mpic_primary;
diff -puN arch/ppc64/kernel/mpic.h~kexec-ppc64 arch/ppc64/kernel/mpic.h
--- linux-2.6.12-rc3-mm3/arch/ppc64/kernel/mpic.h~kexec-ppc64	2005-05-05 20:22:00.696094304 +0530
+++ linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/mpic.h	2005-05-05 20:22:07.884200640 +0530
@@ -255,6 +255,9 @@ extern unsigned int mpic_irq_get_priorit
 /* Setup a non-boot CPU */
 extern void mpic_setup_this_cpu(void);
 
+/* Clean up for kexec (or cpu offline or ...) */
+extern void mpic_teardown_this_cpu(void);
+
 /* Request IPIs on primary mpic */
 extern void mpic_request_ipis(void);
 
diff -puN arch/ppc64/kernel/pSeries_setup.c~kexec-ppc64 arch/ppc64/kernel/pSeries_setup.c
--- linux-2.6.12-rc3-mm3/arch/ppc64/kernel/pSeries_setup.c~kexec-ppc64	2005-05-05 20:22:00.751085944 +0530
+++ linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/pSeries_setup.c	2005-05-05 20:22:07.886200336 +0530
@@ -195,14 +195,16 @@ static void __init pSeries_setup_arch(vo
 {
 	/* Fixup ppc_md depending on the type of interrupt controller */
 	if (ppc64_interrupt_controller == IC_OPEN_PIC) {
-		ppc_md.init_IRQ       = pSeries_init_mpic; 
-		ppc_md.get_irq        = mpic_get_irq;
+		ppc_md.init_IRQ		= pSeries_init_mpic;
+		ppc_md.get_irq		= mpic_get_irq;
+	 	ppc_md.cpu_irq_down	= mpic_teardown_this_cpu;
 		/* Allocate the mpic now, so that find_and_init_phbs() can
 		 * fill the ISUs */
 		pSeries_setup_mpic();
 	} else {
-		ppc_md.init_IRQ       = xics_init_IRQ;
-		ppc_md.get_irq        = xics_get_irq;
+		ppc_md.init_IRQ		= xics_init_IRQ;
+		ppc_md.get_irq		= xics_get_irq;
+		ppc_md.cpu_irq_down	= xics_teardown_cpu;
 	}
 
 #ifdef CONFIG_SMP
diff -puN arch/ppc64/kernel/setup.c~kexec-ppc64 arch/ppc64/kernel/setup.c
--- linux-2.6.12-rc3-mm3/arch/ppc64/kernel/setup.c~kexec-ppc64	2005-05-05 20:22:00.804077888 +0530
+++ linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/setup.c	2005-05-05 20:22:07.888200032 +0530
@@ -677,29 +677,32 @@ void __init setup_system(void)
 	DBG(" <- setup_system()\n");
 }
 
-
-void machine_restart(char *cmd)
+/* also used by kexec */
+void machine_shutdown(void)
 {
 	if (ppc_md.nvram_sync)
 		ppc_md.nvram_sync();
+}
+
+void machine_restart(char *cmd)
+{
+	machine_shutdown();
 	ppc_md.restart(cmd);
 }
 
 EXPORT_SYMBOL(machine_restart);
-  
+
 void machine_power_off(void)
 {
-	if (ppc_md.nvram_sync)
-		ppc_md.nvram_sync();
+	machine_shutdown();
 	ppc_md.power_off();
 }
 
 EXPORT_SYMBOL(machine_power_off);
-  
+
 void machine_halt(void)
 {
-	if (ppc_md.nvram_sync)
-		ppc_md.nvram_sync();
+	machine_shutdown();
 	ppc_md.halt();
 }
 
diff -puN arch/ppc64/kernel/xics.c~kexec-ppc64 arch/ppc64/kernel/xics.c
--- linux-2.6.12-rc3-mm3/arch/ppc64/kernel/xics.c~kexec-ppc64	2005-05-05 20:22:00.857203984 +0530
+++ linux-2.6.12-rc3-mm3-sharada/arch/ppc64/kernel/xics.c	2005-05-05 20:22:07.890199728 +0530
@@ -647,6 +647,31 @@ static void xics_set_affinity(unsigned i
 	}
 }
 
+void xics_teardown_cpu(void)
+{
+	int cpu = smp_processor_id();
+	int status;
+
+	ops->cppr_info(cpu, 0x00);
+	iosync();
+
+	/*
+	 * we need to EOI the IPI if we got here from kexec down IPI
+	 *
+	 * xics doesn't care if we duplicate an EOI as long as we
+	 * don't EOI and raise priority.
+	 *
+	 * probably need to check all the other interrupts too
+	 * should we be flagging idle loop instead?
+	 * or creating some task to be scheduled?
+	 */
+	ops->xirr_info_set(cpu, XICS_IPI);
+
+	status = rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
+		(1UL << interrupt_server_size) - 1 - default_distrib_server, 0);
+	WARN_ON(status != 0);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 
 /* Interrupts are disabled. */
diff -puN /dev/null include/asm-ppc64/kexec.h
--- /dev/null	2005-04-25 18:25:42.651941720 +0530
+++ linux-2.6.12-rc3-mm3-sharada/include/asm-ppc64/kexec.h	2005-05-05 20:22:07.891199576 +0530
@@ -0,0 +1,45 @@
+#ifndef _PPC64_KEXEC_H
+#define _PPC64_KEXEC_H
+
+/*
+ * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
+ * I.e. Maximum page that is mapped directly into kernel memory,
+ * and kmap is not required.
+ *
+ * Someone correct me if FIXADDR_START - PAGEOFFSET is not the correct
+ * calculation for the amount of memory directly mappable into the
+ * kernel memory space.
+ */
+
+/* Maximum physical address we can use pages from */
+/* XXX: since we copy virt we can use any page we allocate */
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
+
+/* Maximum address we can reach in physical address mode */
+/* XXX: I want to allow initrd in highmem.  otherwise set to rmo on lpar */
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
+
+/* Maximum address we can use for the control code buffer */
+/* XXX: unused today, ppc32 uses TASK_SIZE, probably left over from use_mm  */
+#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
+
+/* XXX: today we don't use this at all, althogh we have a static stack */
+#define KEXEC_CONTROL_CODE_SIZE 4096
+
+/* The native architecture */
+#define KEXEC_ARCH KEXEC_ARCH_PPC64
+
+#define MAX_NOTE_BYTES 1024
+
+#ifndef __ASSEMBLY__
+
+typedef u32 note_buf_t[MAX_NOTE_BYTES/4];
+
+extern note_buf_t crash_notes[];
+
+extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
+					  master to copy new code to 0 */
+
+#endif /* __ASSEMBLY__ */
+#endif /* _PPC_KEXEC_H */
+
diff -puN include/asm-ppc64/machdep.h~kexec-ppc64 include/asm-ppc64/machdep.h
--- linux-2.6.12-rc3-mm3/include/asm-ppc64/machdep.h~kexec-ppc64	2005-05-05 20:22:00.960188328 +0530
+++ linux-2.6.12-rc3-mm3-sharada/include/asm-ppc64/machdep.h	2005-05-05 20:22:07.891199576 +0530
@@ -85,6 +85,7 @@ struct machdep_calls {
 
 	void		(*init_IRQ)(void);
 	int		(*get_irq)(struct pt_regs *);
+	void		(*cpu_irq_down)(void);
 
 	/* PCI stuff */
 	void		(*pcibios_fixup)(void);
diff -puN include/asm-ppc64/xics.h~kexec-ppc64 include/asm-ppc64/xics.h
--- linux-2.6.12-rc3-mm3/include/asm-ppc64/xics.h~kexec-ppc64	2005-05-05 20:22:01.013180272 +0530
+++ linux-2.6.12-rc3-mm3-sharada/include/asm-ppc64/xics.h	2005-05-05 20:22:07.892199424 +0530
@@ -17,6 +17,7 @@
 void xics_init_IRQ(void);
 int xics_get_irq(struct pt_regs *);
 void xics_setup_cpu(void);
+void xics_teardown_cpu(void);
 void xics_cause_IPI(int cpu);
 void xics_request_IPIs(void);
 void xics_migrate_irqs_away(void);
_

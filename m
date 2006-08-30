Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWH3MyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWH3MyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWH3MyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:54:01 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:19174 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750946AbWH3Mx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:53:57 -0400
Message-Id: <20060830125038.143821000@klappe.arndb.de>
References: <20060830124356.567568000@klappe.arndb.de>
Date: Wed, 30 Aug 2006 14:44:01 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
       Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH 5/6] sh64: remove the use of kernel syscalls
Content-Disposition: inline; filename=sh64-syscalls.diff
From: Paul Mundt <lethal@linux-sh.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sh64 is using system call macros to call some functions from the
kernel.

The old debug code can simply be removed, since we don't really have
that much of a need for it anymore, it was mostly something
that was handy during the initial bringup. This also brings us closer to
something that looks like readable code again..

I also added a sane kernel_thread() implementation that gets away from
this, so that should take care of sh64 at least.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-cg/arch/sh64/kernel/process.c
===================================================================
--- linux-cg.orig/arch/sh64/kernel/process.c	2006-08-29 20:01:54.000000000 +0200
+++ linux-cg/arch/sh64/kernel/process.c	2006-08-29 20:04:13.000000000 +0200
@@ -20,261 +20,16 @@
 /*
  * This file handles the architecture-dependent parts of process handling..
  */
-
-/* Temporary flags/tests. All to be removed/undefined. BEGIN */
-#define IDLE_TRACE
-#define VM_SHOW_TABLES
-#define VM_TEST_FAULT
-#define VM_TEST_RTLBMISS
-#define VM_TEST_WTLBMISS
-
-#undef VM_SHOW_TABLES
-#undef IDLE_TRACE
-/* Temporary flags/tests. All to be removed/undefined. END */
-
-#define __KERNEL_SYSCALLS__
-#include <stdarg.h>
-
-#include <linux/kernel.h>
-#include <linux/rwsem.h>
 #include <linux/mm.h>
-#include <linux/smp.h>
-#include <linux/smp_lock.h>
 #include <linux/ptrace.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/user.h>
-#include <linux/a.out.h>
-#include <linux/interrupt.h>
-#include <linux/unistd.h>
-#include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
-
+#include <linux/module.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/processor.h>		/* includes also <asm/registers.h> */
-#include <asm/mmu_context.h>
-#include <asm/elf.h>
-#include <asm/page.h>
-
-#include <linux/irq.h>
 
 struct task_struct *last_task_used_math = NULL;
 
-#ifdef IDLE_TRACE
-#ifdef VM_SHOW_TABLES
-/* For testing */
-static void print_PTE(long base)
-{
-	int i, skip=0;
-	long long x, y, *p = (long long *) base;
-
-	for (i=0; i< 512; i++, p++){
-		if (*p == 0) {
-			if (!skip) {
-				skip++;
-				printk("(0s) ");
-			}
-		} else {
-			skip=0;
-			x = (*p) >> 32;
-			y = (*p) & 0xffffffff;
-			printk("%08Lx%08Lx ", x, y);
-			if (!((i+1)&0x3)) printk("\n");
-		}
-	}
-}
-
-/* For testing */
-static void print_DIR(long base)
-{
-	int i, skip=0;
-	long *p = (long *) base;
-
-	for (i=0; i< 512; i++, p++){
-		if (*p == 0) {
-			if (!skip) {
-				skip++;
-				printk("(0s) ");
-			}
-		} else {
-			skip=0;
-			printk("%08lx ", *p);
-			if (!((i+1)&0x7)) printk("\n");
-		}
-	}
-}
-
-/* For testing */
-static void print_vmalloc_first_tables(void)
-{
-
-#define PRESENT	0x800	/* Bit 11 */
-
-	/*
-	 * Do it really dirty by looking at raw addresses,
-         * raw offsets, no types. If we used pgtable/pgalloc
-	 * macros/definitions we could hide potential bugs.
-	 *
-	 * Note that pointers are 32-bit for CDC.
-	 */
-	long pgdt, pmdt, ptet;
-
-	pgdt = (long) &swapper_pg_dir;
-	printk("-->PGD (0x%08lx):\n", pgdt);
-	print_DIR(pgdt);
-	printk("\n");
-
-	/* VMALLOC pool is mapped at 0xc0000000, second (pointer) entry in PGD */
-	pgdt += 4;
-	pmdt = (long) (* (long *) pgdt);
-	if (!(pmdt & PRESENT)) {
-		printk("No PMD\n");
-		return;
-	} else pmdt &= 0xfffff000;
-
-	printk("-->PMD (0x%08lx):\n", pmdt);
-	print_DIR(pmdt);
-	printk("\n");
-
-	/* Get the pmdt displacement for 0xc0000000 */
-	pmdt += 2048;
-
-	/* just look at first two address ranges ... */
-        /* ... 0xc0000000 ... */
-	ptet = (long) (* (long *) pmdt);
-	if (!(ptet & PRESENT)) {
-		printk("No PTE0\n");
-		return;
-	} else ptet &= 0xfffff000;
-
-	printk("-->PTE0 (0x%08lx):\n", ptet);
-	print_PTE(ptet);
-	printk("\n");
-
-        /* ... 0xc0001000 ... */
-	ptet += 4;
-	if (!(ptet & PRESENT)) {
-		printk("No PTE1\n");
-		return;
-	} else ptet &= 0xfffff000;
-	printk("-->PTE1 (0x%08lx):\n", ptet);
-	print_PTE(ptet);
-	printk("\n");
-}
-#else
-#define print_vmalloc_first_tables()
-#endif	/* VM_SHOW_TABLES */
-
-static void test_VM(void)
-{
-	void *a, *b, *c;
-
-#ifdef VM_SHOW_TABLES
-	printk("Initial PGD/PMD/PTE\n");
-#endif
-        print_vmalloc_first_tables();
-
-	printk("Allocating 2 bytes\n");
-	a = vmalloc(2);
-        print_vmalloc_first_tables();
-
-	printk("Allocating 4100 bytes\n");
-	b = vmalloc(4100);
-        print_vmalloc_first_tables();
-
-	printk("Allocating 20234 bytes\n");
-	c = vmalloc(20234);
-        print_vmalloc_first_tables();
-
-#ifdef VM_TEST_FAULT
-	/* Here you may want to fault ! */
-
-#ifdef VM_TEST_RTLBMISS
-	printk("Ready to fault upon read.\n");
-	if (* (char *) a) {
-		printk("RTLBMISSed on area a !\n");
-	}
-	printk("RTLBMISSed on area a !\n");
-#endif
-
-#ifdef VM_TEST_WTLBMISS
-	printk("Ready to fault upon write.\n");
-	*((char *) b) = 'L';
-	printk("WTLBMISSed on area b !\n");
-#endif
-
-#endif	/* VM_TEST_FAULT */
-
-	printk("Deallocating the 4100 byte chunk\n");
-	vfree(b);
-        print_vmalloc_first_tables();
-
-	printk("Deallocating the 2 byte chunk\n");
-	vfree(a);
-        print_vmalloc_first_tables();
-
-	printk("Deallocating the last chunk\n");
-	vfree(c);
-        print_vmalloc_first_tables();
-}
-
-extern unsigned long volatile jiffies;
-int once = 0;
-unsigned long old_jiffies;
-int pid = -1, pgid = -1;
-
-void idle_trace(void)
-{
-
-	_syscall0(int, getpid)
-	_syscall1(int, getpgid, int, pid)
-
-	if (!once) {
-        	/* VM allocation/deallocation simple test */
-		test_VM();
-		pid = getpid();
-
-        	printk("Got all through to Idle !!\n");
-        	printk("I'm now going to loop forever ...\n");
-        	printk("Any ! below is a timer tick.\n");
-		printk("Any . below is a getpgid system call from pid = %d.\n", pid);
-
-
-        	old_jiffies = jiffies;
-		once++;
-	}
-
-	if (old_jiffies != jiffies) {
-		old_jiffies = jiffies - old_jiffies;
-		switch (old_jiffies) {
-		case 1:
-			printk("!");
-			break;
-		case 2:
-			printk("!!");
-			break;
-		case 3:
-			printk("!!!");
-			break;
-		case 4:
-			printk("!!!!");
-			break;
-		default:
-			printk("(%d!)", (int) old_jiffies);
-		}
-		old_jiffies = jiffies;
-	}
-	pgid = getpgid(pid);
-	printk(".");
-}
-#else
-#define idle_trace()	do { } while (0)
-#endif	/* IDLE_TRACE */
-
 static int hlt_counter = 1;
 
 #define HARD_IDLE_TIMEOUT (HZ / 3)
@@ -323,7 +78,6 @@
 			local_irq_disable();
 			while (!need_resched()) {
 				local_irq_enable();
-				idle_trace();
 				hlt();
 				local_irq_disable();
 			}
@@ -619,6 +373,10 @@
 /*
  * Create a kernel thread
  */
+ATTRIB_NORET void kernel_thread_helper(void *arg, int (*fn)(void *))
+{
+	do_exit(fn(arg));
+}
 
 /*
  * This is the mechanism for creating a new kernel thread.
@@ -630,19 +388,17 @@
  */
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
-	/* A bit less processor dependent than older sh ... */
-	unsigned int reply;
+	struct pt_regs regs;
 
-static __inline__ _syscall2(int,clone,unsigned long,flags,unsigned long,newsp)
-static __inline__ _syscall1(int,exit,int,ret)
+	memset(&regs, 0, sizeof(regs));
+	regs.regs[2] = (unsigned long)arg;
+	regs.regs[3] = (unsigned long)fn;
 
-	reply = clone(flags | CLONE_VM, 0);
-	if (!reply) {
-		/* Child */
-		reply = exit(fn(arg));
-	}
+	regs.pc = (unsigned long)kernel_thread_helper;
+	regs.sr = (1 << 30);
 
-	return reply;
+	return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0,
+		       &regs, 0, NULL, NULL);
 }
 
 /*

--


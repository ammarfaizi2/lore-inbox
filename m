Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVHOXAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVHOXAF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVHOXAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:00:04 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:22789 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932334AbVHOW7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:59:55 -0400
Date: Mon, 15 Aug 2005 16:00:09 -0700
From: zach@vmware.com
Message-Id: <200508152300.j7FN090x005328@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, prasanna@in.ibm.com,
       pratap@vmware.com, virtualization@lists.osdl.org, zach@vmware.com,
       zwane@arm.linux.org.uk
Subject: [PATCH 4/6] i386 virtualization - Ldt kprobes bugfix
X-OriginalArrivalTime: 15 Aug 2005 22:59:53.0492 (UTC) FILETIME=[0C424D40:01C5A1ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While cleaning up the LDT code, I noticed that kprobes code was very bogus
with respect to segment handling.  Three bugs are fixed here.

1) Taking an int3 from v8086 mode could cause the kprobes code to read
   a non-existent LDT.
2) The CS value is not truncated to 16 bit, which could cause an access
   beyond the bounds of the LDT.
3) The LDT was being read without taking the mm->context semaphore, which
   means bogus and or non-existent vmalloc()ed pages could be read.

I've also included my latest version of the LDT test.

/*
 * Copyright (c) 2005, Zachary Amsden (zach@vmware.com)
 * This is licensed under the GPL.
 */

#include <stdio.h>
#include <signal.h>
#include <asm/ldt.h>
#include <asm/segment.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sched.h>
#define __KERNEL__
#include <asm/page.h>

/*
 * Spin modifying LDT entry 1 to get contention on the mm->context
 * semaphore.
 */
void evil_child(void *addr)
{
	struct user_desc desc;

	while (1) {
		desc.entry_number = 1;
		desc.base_addr = addr;
		desc.limit = 1;
		desc.seg_32bit = 1;
		desc.contents = MODIFY_LDT_CONTENTS_CODE;
		desc.read_exec_only = 0;
		desc.limit_in_pages = 1;
		desc.seg_not_present = 0;
		desc.useable = 1;
		if (modify_ldt(1, &desc, sizeof(desc)) != 0) {
			perror("modify_ldt");
			abort();
		}
	}
	exit(0);
}

void catch_sig(int signo, struct sigcontext ctx)
{
	return;
}

void main(void)
{
        struct user_desc desc;
        char *code;
        unsigned long long tsc;
	char *stack;
	pid_t child; 
	int i;
	unsigned long long lasttsc = 0;

        code = (char *)mmap(0, 8192, PROT_EXEC|PROT_READ|PROT_WRITE,
                                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

	/* Test 1 - CODE, 32-BIT, 2 page limit */
        desc.entry_number = 0;
        desc.base_addr = code;
        desc.limit = 1;
        desc.seg_32bit = 1;
        desc.contents = MODIFY_LDT_CONTENTS_CODE;
        desc.read_exec_only = 0;
        desc.limit_in_pages = 1;
        desc.seg_not_present = 0;
        desc.useable = 1;
        if (modify_ldt(1, &desc, sizeof(desc)) != 0) {
                perror("modify_ldt");
		abort();
        }
        printf("INFO: code base is 0x%08x\n", (unsigned)code);
        code[0x0ffe] = 0x0f;  /* rdtsc */
        code[0x0fff] = 0x31;
        code[0x1000] = 0xcb;  /* lret */
        __asm__ __volatile("lcall $7,$0xffe" : "=A" (tsc));
        printf("INFO: TSC is 0x%016llx\n", tsc);

	/*
	 * Fork an evil child that shares the same MM context
	 */
	stack = malloc(8192);
	child = clone(evil_child, stack, CLONE_VM, 0xb0b0);
	if (child == -1) {
		perror("clone");
		abort();
	}

	/* Test 2 - CODE, 32-BIT, 4097 byte limit */
        desc.entry_number = 512;
        desc.base_addr = code;
        desc.limit = 4096;
        desc.seg_32bit = 1;
        desc.contents = MODIFY_LDT_CONTENTS_CODE;
        desc.read_exec_only = 0;
        desc.limit_in_pages = 0;
        desc.seg_not_present = 0;
        desc.useable = 1;
        if (modify_ldt(1, &desc, sizeof(desc)) != 0) {
                perror("modify_ldt");
		abort();
        }
        code[0x0ffe] = 0x0f;  /* rdtsc */
        code[0x0fff] = 0x31;
        code[0x1000] = 0xcb;  /* lret */
        __asm__ __volatile("lcall $0x1007,$0xffe" : "=A" (tsc));

	/*
	 * Test 3 - CODE, 32-BIT, maximal LDT.  Race against evil
	 * child while taking debug traps on LDT CS.
	 */
	for (i = 0; i < 1000; i++) {
		signal(SIGTRAP, catch_sig);
		desc.entry_number = 8191;
		desc.base_addr = code;
		desc.limit = 4097;
		desc.seg_32bit = 1;
		desc.contents = MODIFY_LDT_CONTENTS_CODE;
		desc.read_exec_only = 0;
		desc.limit_in_pages = 0;
		desc.seg_not_present = 0;
		desc.useable = 1;
		if (modify_ldt(1, &desc, sizeof(desc)) != 0) {
			perror("modify_ldt");
			abort();
		}
		code[0x0ffe] = 0x0f;  /* rdtsc */
		code[0x0fff] = 0x31;
		code[0x1000] = 0xcc;  /* int3 */
        	code[0x1001] = 0xcb;  /* lret */
		__asm__ __volatile("lcall $0xffff,$0xffe" : "=A" (tsc));
		if (tsc < lasttsc) {
			printf("WARNING: TSC went backwards\n");
		}
		lasttsc = tsc;
	}
	if (kill(child, SIGTERM) != 0) {
		perror("kill");
		abort();
	}
	printf("PASS: LDT code segment\n");
}

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.13.orig/arch/i386/kernel/kprobes.c	2005-08-15 10:50:26.000000000 -0700
+++ linux-2.6.13/arch/i386/kernel/kprobes.c	2005-08-15 10:55:14.000000000 -0700
@@ -155,23 +155,37 @@
 {
 	struct kprobe *p;
 	int ret = 0;
+ 	unsigned seg = regs->xcs & 0xffff;
 	kprobe_opcode_t *addr = NULL;
 
-	/* We're in an interrupt, but this is clear and BUG()-safe. */
-	preempt_disable();
-	/* Check if the application is using LDT entry for its code segment and
-	 * calculate the address by reading the base address from the LDT entry.
-	 */
-	if (segment_from_ldt(regs->xcs) && (current->mm)) {
-		struct desc_struct *desc;
-		desc = &current->mm->context.ldt[segment_index(regs->xcs)];
-		addr = (kprobe_opcode_t *) (get_desc_base(desc) + regs->eip -
-						sizeof(kprobe_opcode_t));
-	} else {
-		addr = (kprobe_opcode_t *)(regs->eip - sizeof(kprobe_opcode_t));
-	}
-	/* Check we're not actually recursing */
-	if (kprobe_running()) {
+         /*
+ 	 * Must form address for V8086 mode and rule this out before testing
+ 	 * for LDT code segment.  Reading the base address from the LDT entry
+ 	 * requires getting the mm->context semaphore in the case of a shared
+ 	 * address space.  Since this could sleep, we have to temporarily
+ 	 * re-enable IRQs.  This is ok, since this is only done in the LDT
+ 	 * CS case, and only userspace can run with LDT code segments.
+  	 */
+ 	if (regs->eflags & VM_MASK) {
+ 		addr = (kprobe_opcode_t *)(((seg << 4) + regs->eip - 
+ 			sizeof(kprobe_opcode_t)) & 0xffff);
+ 	} else if (segment_from_ldt(seg) && (current->mm)) {
+  		struct desc_struct *desc;
+ 		local_irq_enable();
+ 		down(&current->mm->context.sem);
+ 		desc = &current->mm->context.ldt[segment_index(seg)];
+  		addr = (kprobe_opcode_t *) (get_desc_base(desc) + regs->eip -
+  						sizeof(kprobe_opcode_t));
+ 		up(&current->mm->context.sem);
+ 		local_irq_disable();
+  	} else {
+  		addr = (kprobe_opcode_t *)(regs->eip - sizeof(kprobe_opcode_t));
+  	}
+ 	/* We're in an interrupt, but this is clear and BUG()-safe. */
+ 	preempt_disable();
+ 
+  	/* Check we're not actually recursing */
+  	if (kprobe_running()) {
 		/* We *are* holding lock here, so this is safe.
 		   Disarm the probe we just hit, and ignore it. */
 		p = get_kprobe(addr);

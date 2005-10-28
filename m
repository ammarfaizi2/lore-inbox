Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbVJ1OId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbVJ1OId (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbVJ1OIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:08:32 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:5346 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751645AbVJ1OIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:08:31 -0400
Date: Fri, 28 Oct 2005 16:08:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 7/14] s390: remove pagex support.
Message-ID: <20051028140838.GG7300@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 7/14] s390: remove pagex support.

Remove pagex pseudo page fault code. It does not work together
with the system call speedup that makes the complete system
call path enabled for interrupts. To make pagex and the syscall
speedup code work together we would have to add code to the
program check handler to do a critical section cleanup like the
asynchronous interrupt code. This would make program checks
slower. No what we want.
Newers version of z/VM have the improved pfault pseudo page
fault interface. This replaces the old pagex interface and does
not have the problem. So its better to just rip out the pagex
code.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/traps.c |   29 +-----------
 arch/s390/mm/fault.c     |  113 -----------------------------------------------
 2 files changed, 5 insertions(+), 137 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2005-10-28 14:04:49.000000000 +0200
@@ -57,7 +57,6 @@ int sysctl_userprocess_debug = 0;
 
 extern pgm_check_handler_t do_protection_exception;
 extern pgm_check_handler_t do_dat_exception;
-extern pgm_check_handler_t do_pseudo_page_fault;
 #ifdef CONFIG_PFAULT
 extern int pfault_init(void);
 extern void pfault_fini(void);
@@ -676,20 +675,6 @@ asmlinkage void kernel_stack_overflow(st
 	panic("Corrupt kernel stack, can't continue.");
 }
 
-#ifndef CONFIG_ARCH_S390X
-static int
-pagex_reboot_event(struct notifier_block *this, unsigned long event, void *ptr)
-{
-	if (MACHINE_IS_VM)
-		cpcmd("SET PAGEX OFF", NULL, 0, NULL);
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block pagex_reboot_notifier = {
-	.notifier_call = &pagex_reboot_event,
-};
-#endif
-
 /* init is done in lowcore.S and head.S */
 
 void __init trap_init(void)
@@ -717,9 +702,7 @@ void __init trap_init(void)
         pgm_check_table[0x11] = &do_dat_exception;
         pgm_check_table[0x12] = &translation_exception;
         pgm_check_table[0x13] = &special_op_exception;
-#ifndef CONFIG_ARCH_S390X
- 	pgm_check_table[0x14] = &do_pseudo_page_fault;
-#else /* CONFIG_ARCH_S390X */
+#ifdef CONFIG_ARCH_S390X
         pgm_check_table[0x38] = &do_dat_exception;
 	pgm_check_table[0x39] = &do_dat_exception;
 	pgm_check_table[0x3A] = &do_dat_exception;
@@ -731,12 +714,10 @@ void __init trap_init(void)
 	pgm_check_table[0x40] = &do_monitor_call;
 
 	if (MACHINE_IS_VM) {
+#ifdef CONFIG_PFAULT
 		/*
-		 * First try to get pfault pseudo page faults going.
-		 * If this isn't available turn on pagex page faults.
+		 * Try to get pfault pseudo page faults going.
 		 */
-#ifdef CONFIG_PFAULT
-		/* request the 0x2603 external interrupt */
 		if (register_early_external_interrupt(0x2603, pfault_interrupt,
 						      &ext_int_pfault) != 0)
 			panic("Couldn't request external interrupt 0x2603");
@@ -748,9 +729,5 @@ void __init trap_init(void)
 		unregister_early_external_interrupt(0x2603, pfault_interrupt,
 						    &ext_int_pfault);
 #endif
-#ifndef CONFIG_ARCH_S390X
-		register_reboot_notifier(&pagex_reboot_notifier);
-		cpcmd("SET PAGEX ON", NULL, 0, NULL);
-#endif
 	}
 }
diff -urpN linux-2.6/arch/s390/mm/fault.c linux-2.6-patched/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/fault.c	2005-10-28 14:04:49.000000000 +0200
@@ -352,115 +352,6 @@ void do_dat_exception(struct pt_regs *re
 	do_exception(regs, error_code & 0xff, 0);
 }
 
-#ifndef CONFIG_ARCH_S390X
-
-typedef struct _pseudo_wait_t {
-       struct _pseudo_wait_t *next;
-       wait_queue_head_t queue;
-       unsigned long address;
-       int resolved;
-} pseudo_wait_t;
-
-static pseudo_wait_t *pseudo_lock_queue = NULL;
-static spinlock_t pseudo_wait_spinlock; /* spinlock to protect lock queue */
-
-/*
- * This routine handles 'pagex' pseudo page faults.
- */
-asmlinkage void
-do_pseudo_page_fault(struct pt_regs *regs, unsigned long error_code)
-{
-        pseudo_wait_t wait_struct;
-        pseudo_wait_t *ptr, *last, *next;
-        unsigned long address;
-
-        /*
-         * get the failing address
-         * more specific the segment and page table portion of
-         * the address
-         */
-        address = S390_lowcore.trans_exc_code & 0xfffff000;
-
-        if (address & 0x80000000) {
-                /* high bit set -> a page has been swapped in by VM */
-                address &= 0x7fffffff;
-                spin_lock(&pseudo_wait_spinlock);
-                last = NULL;
-                ptr = pseudo_lock_queue;
-                while (ptr != NULL) {
-                        next = ptr->next;
-                        if (address == ptr->address) {
-				 /*
-                                 * This is one of the processes waiting
-                                 * for the page. Unchain from the queue.
-                                 * There can be more than one process
-                                 * waiting for the same page. VM presents
-                                 * an initial and a completion interrupt for
-                                 * every process that tries to access a 
-                                 * page swapped out by VM. 
-                                 */
-                                if (last == NULL)
-                                        pseudo_lock_queue = next;
-                                else
-                                        last->next = next;
-                                /* now wake up the process */
-                                ptr->resolved = 1;
-                                wake_up(&ptr->queue);
-                        } else
-                                last = ptr;
-                        ptr = next;
-                }
-                spin_unlock(&pseudo_wait_spinlock);
-        } else {
-                /* Pseudo page faults in kernel mode is a bad idea */
-                if (!(regs->psw.mask & PSW_MASK_PSTATE)) {
-                        /*
-			 * VM presents pseudo page faults if the interrupted
-			 * state was not disabled for interrupts. So we can
-			 * get pseudo page fault interrupts while running
-			 * in kernel mode. We simply access the page here
-			 * while we are running disabled. VM will then swap
-			 * in the page synchronously.
-                         */
-                         if (check_user_space(regs, error_code) == 0)
-                                 /* dereference a virtual kernel address */
-                                 __asm__ __volatile__ (
-                                         "  ic 0,0(%0)"
-                                         : : "a" (address) : "0");
-                         else
-                                 /* dereference a virtual user address */
-                                 __asm__ __volatile__ (
-                                         "  la   2,0(%0)\n"
-                                         "  sacf 512\n"
-                                         "  ic   2,0(2)\n"
-					 "0:sacf 0\n"
-					 ".section __ex_table,\"a\"\n"
-					 "  .align 4\n"
-					 "  .long  0b,0b\n"
-					 ".previous"
-                                         : : "a" (address) : "2" );
-
-                        return;
-                }
-		/* initialize and add element to pseudo_lock_queue */
-                init_waitqueue_head (&wait_struct.queue);
-                wait_struct.address = address;
-                wait_struct.resolved = 0;
-                spin_lock(&pseudo_wait_spinlock);
-                wait_struct.next = pseudo_lock_queue;
-                pseudo_lock_queue = &wait_struct;
-                spin_unlock(&pseudo_wait_spinlock);
-		/*
-		 * The instruction that caused the program check will
-		 * be repeated. Don't signal single step via SIGTRAP.
-		 */
-		clear_tsk_thread_flag(current, TIF_SINGLE_STEP);
-                /* go to sleep */
-                wait_event(wait_struct.queue, wait_struct.resolved);
-        }
-}
-#endif /* CONFIG_ARCH_S390X */
-
 #ifdef CONFIG_PFAULT 
 /*
  * 'pfault' pseudo page faults routines.
@@ -508,7 +399,7 @@ int pfault_init(void)
 		"   .quad  0b,1b\n"
 #endif /* CONFIG_ARCH_S390X */
 		".previous"
-                : "=d" (rc) : "a" (&refbk) : "cc" );
+                : "=d" (rc) : "a" (&refbk), "m" (refbk) : "cc" );
         __ctl_set_bit(0, 9);
         return rc;
 }
@@ -532,7 +423,7 @@ void pfault_fini(void)
 		"   .quad  0b,0b\n"
 #endif /* CONFIG_ARCH_S390X */
 		".previous"
-		: : "a" (&refbk) : "cc" );
+		: : "a" (&refbk), "m" (refbk) : "cc" );
 }
 
 asmlinkage void

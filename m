Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbUCNXcO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 18:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbUCNXcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 18:32:14 -0500
Received: from waste.org ([209.173.204.2]:30597 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262053AbUCNXcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 18:32:09 -0500
Date: Sun, 14 Mar 2004 17:31:55 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: [patch] kill INIT_THREAD_SIZE
Message-ID: <20040314233155.GX20174@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This piece of the THREAD_SIZE cleanup got dropped. If you make
THREAD_SIZE > 8k, the init thread overlaps the .init section and gets
smashed. I've gone ahead and killed INIT_THREAD_SIZE throughout as it
wasn't doing much. This also saves 4k when we use 4k stacks. Please
apply. Couple more minor pieces remaining.


diff -puN ./include/asm-arm26/thread_info.h~kill-init_thread_size ./include/asm-arm26/thread_info.h


 test-mpm/./arch/parisc/kernel/process.c       |    2 +-
 test-mpm/./arch/sparc64/kernel/init_task.c    |    8 --------
 test-mpm/./include/asm-arm26/thread_info.h    |    2 --
 test-mpm/./include/asm-sparc/thread_info.h    |    3 ---
 test-mpm/./include/asm-um/processor-generic.h |    2 --
 test-mpm/./include/linux/sched.h              |    6 +-----
 6 files changed, 2 insertions(+), 21 deletions(-)

diff -puN ./arch/parisc/kernel/process.c~kill-init_thread_size ./arch/parisc/kernel/process.c
--- test/./arch/parisc/kernel/process.c~kill-init_thread_size	2004-03-13 15:02:12.000000000 -0600
+++ test-mpm/./arch/parisc/kernel/process.c	2004-03-13 15:02:12.000000000 -0600
@@ -315,7 +315,7 @@ copy_thread(int nr, unsigned long clone_
 
 		/* Use same stack depth as parent */
 		cregs->ksp = ((unsigned long)(ti))
-			+ (pregs->gr[21] & (INIT_THREAD_SIZE - 1));
+			+ (pregs->gr[21] & (THREAD_SIZE - 1));
 		cregs->gr[30] = usp;
 		if (p->personality == PER_HPUX) {
 #ifdef CONFIG_HPUX
diff -puN ./arch/sparc64/kernel/init_task.c~kill-init_thread_size ./arch/sparc64/kernel/init_task.c
--- test/./arch/sparc64/kernel/init_task.c~kill-init_thread_size	2004-03-13 15:02:12.000000000 -0600
+++ test-mpm/./arch/sparc64/kernel/init_task.c	2004-03-13 15:02:12.000000000 -0600
@@ -24,14 +24,6 @@ __asm__ (".text");
 union thread_union init_thread_union = { INIT_THREAD_INFO(init_task) };
 
 /*
- * This is to make the init_thread+stack be the right size for >8k pagesize.
- * The definition of thread_union in sched.h makes it 16k wide.
- */
-#if PAGE_SHIFT != 13
-char init_task_stack[THREAD_SIZE - INIT_THREAD_SIZE] = { 0 };
-#endif
-
-/*
  * Initial task structure.
  *
  * All other task structs will be allocated on slabs in fork.c
diff -puN ./include/asm-arm26/thread_info.h~kill-init_thread_size ./include/asm-arm26/thread_info.h
--- test/./include/asm-arm26/thread_info.h~kill-init_thread_size	2004-03-13 15:02:12.000000000 -0600
+++ test-mpm/./include/asm-arm26/thread_info.h	2004-03-13 15:02:12.000000000 -0600
@@ -81,8 +81,6 @@ static inline struct thread_info *curren
 
 /* FIXME - PAGE_SIZE < 32K */
 #define THREAD_SIZE		(8192)
-/*FIXME INIT_THREAD_SIZE - how big? */
-//#define INIT_THREAD_SIZE        (65536)
 #define __get_user_regs(x) (((struct pt_regs *)((unsigned long)(x) + THREAD_SIZE - 8)) - 1)
 
 extern struct thread_info *alloc_thread_info(struct task_struct *task);
diff -puN ./include/asm-i386/thread_info.h~kill-init_thread_size ./include/asm-i386/thread_info.h
diff -puN ./include/asm-sparc/thread_info.h~kill-init_thread_size ./include/asm-sparc/thread_info.h
--- test/./include/asm-sparc/thread_info.h~kill-init_thread_size	2004-03-13 15:02:12.000000000 -0600
+++ test-mpm/./include/asm-sparc/thread_info.h	2004-03-13 15:02:12.000000000 -0600
@@ -100,9 +100,6 @@ BTFIXUPDEF_CALL(void, free_thread_info, 
  * Size of kernel stack for each process.
  * Observe the order of get_free_pages() in alloc_thread_info().
  * The sun4 has 8K stack too, because it's short on memory, and 16K is a waste.
- *
- * XXX Watch how INIT_THREAD_SIZE evolves in linux/sched.h and elsewhere.
- *     On 2.5.24 it happens to match 8192 magically.
  */
 #define THREAD_SIZE		8192
 
diff -puN ./include/asm-um/processor-generic.h~kill-init_thread_size ./include/asm-um/processor-generic.h
--- test/./include/asm-um/processor-generic.h~kill-init_thread_size	2004-03-13 15:02:12.000000000 -0600
+++ test-mpm/./include/asm-um/processor-generic.h	2004-03-13 15:02:12.000000000 -0600
@@ -94,8 +94,6 @@ struct thread_struct {
 	.request		= { 0 } \
 }
 
-#define INIT_THREAD_SIZE ((1 << CONFIG_KERNEL_STACK_ORDER) * PAGE_SIZE)
-
 typedef struct {
 	unsigned long seg;
 } mm_segment_t;
diff -puN ./include/linux/sched.h~kill-init_thread_size ./include/linux/sched.h
--- test/./include/linux/sched.h~kill-init_thread_size	2004-03-13 15:02:12.000000000 -0600
+++ test-mpm/./include/linux/sched.h	2004-03-13 15:02:12.000000000 -0600
@@ -669,13 +669,9 @@ void yield(void);
  */
 extern struct exec_domain	default_exec_domain;
 
-#ifndef INIT_THREAD_SIZE
-# define INIT_THREAD_SIZE	2048*sizeof(long)
-#endif
-
 union thread_union {
 	struct thread_info thread_info;
-	unsigned long stack[INIT_THREAD_SIZE/sizeof(long)];
+	unsigned long stack[THREAD_SIZE/sizeof(long)];
 };
 
 #ifndef __HAVE_ARCH_KSTACK_END

_


-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268273AbRGWP4g>; Mon, 23 Jul 2001 11:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268274AbRGWP41>; Mon, 23 Jul 2001 11:56:27 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:43344 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268273AbRGWP4I>; Mon, 23 Jul 2001 11:56:08 -0400
Date: Mon, 23 Jul 2001 17:56:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Dike <jdike@karaya.com>, Linus Torvalds <torvalds@transmeta.com>
Cc: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: user-mode port 0.44-2.4.7
Message-ID: <20010723175635.L822@athlon.random>
In-Reply-To: <200107230508.AAA04621@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107230508.AAA04621@ccure.karaya.com>; from jdike@karaya.com on Mon, Jul 23, 2001 at 12:08:04AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 12:08:04AM -0500, Jeff Dike wrote:
> The user-mode port of 2.4.7 is available.

in my tree I did some further cleanup, here the ones that you can
interested about:

diff -urN uml-ref/arch/um/include/kern_util.h uml/arch/um/include/kern_util.h
--- uml-ref/arch/um/include/kern_util.h	Mon Jul 23 17:07:17 2001
+++ uml/arch/um/include/kern_util.h	Mon Jul 23 17:08:33 2001
@@ -28,7 +28,6 @@
 extern long execute_syscall(struct sys_pt_regs regs);
 extern void syscall_segv(int sig);
 extern int current_pid(void);
-extern void do_bh(void);
 extern void set_init_pid(int pid);
 extern unsigned long alloc_stack(void);
 extern int do_signal(unsigned long *error, int *again_out);
diff -urN uml-ref/arch/um/kernel/process_kern.c uml/arch/um/kernel/process_kern.c
--- uml-ref/arch/um/kernel/process_kern.c	Mon Jul 23 17:07:17 2001
+++ uml/arch/um/kernel/process_kern.c	Mon Jul 23 17:09:54 2001
@@ -217,25 +217,12 @@
 	return(current->thread.request.u.cswitch.from);
 }
 
-void do_bh(void)
-{
-#ifndef CONFIG_SMP
-	if (softirq_pending(0)){
-		do_softirq();
-		unblock_signals();
-	}
-#else
-#error Need to update do_bh
-#endif
-}
-
 void ret_from_sys_call(void *t)
 {
 	struct task_struct *task;
 
 	task = t;
 	if(task == NULL) task = current;
-	do_bh();
 	if(task->need_resched) schedule();
 	if(task->sigpending != 0) do_signal(NULL, NULL);
 }
diff -urN uml-ref/arch/um/kernel/time.c uml/arch/um/kernel/time.c
--- uml-ref/arch/um/kernel/time.c	Mon Jul 23 17:07:17 2001
+++ uml/arch/um/kernel/time.c	Mon Jul 23 17:08:36 2001
@@ -16,7 +16,7 @@
 #include "user.h"
 #include "process.h"
 
-extern struct timeval xtime;
+extern volatile struct timeval xtime;
 
 void timer_handler(int sig, void *sc, int usermode)
 {


this one for compiling uml with the gcc-3_0-branch of yesterday:

--- 2.4.7aa1/include/asm-um/pgalloc.h.~1~	Mon Jul 23 05:13:13 2001
+++ 2.4.7aa1/include/asm-um/pgalloc.h	Mon Jul 23 05:25:10 2001
@@ -21,7 +21,7 @@
  * Allocate and free page tables.
  */
 
-extern __inline__ pgd_t *get_pgd_slow(void)
+static __inline__ pgd_t *get_pgd_slow(void)
 {
 	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
 


BTW, Linus the _below_ patches against mainline are needed to compile
the x86 port with gcc-3_0-branch of yesterday, it is safe to include it
in mainline:

--- 2.4.7aa1/include/asm-i386/pgalloc.h.~1~	Mon Jul 23 04:34:24 2001
+++ 2.4.7aa1/include/asm-i386/pgalloc.h	Mon Jul 23 04:50:44 2001
@@ -23,7 +23,7 @@
 extern void *kmalloc(size_t, int);
 extern void kfree(const void *);
 
-extern __inline__ pgd_t *get_pgd_slow(void)
+static __inline__ pgd_t *get_pgd_slow(void)
 {
 	int i;
 	pgd_t *pgd = kmalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
@@ -48,7 +48,7 @@
 
 #else
 
-extern __inline__ pgd_t *get_pgd_slow(void)
+static __inline__ pgd_t *get_pgd_slow(void)
 {
 	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
 
--- 2.4.7aa1/include/asm-i386/siginfo.h.~1~	Mon Jul 23 04:34:24 2001
+++ 2.4.7aa1/include/asm-i386/siginfo.h	Mon Jul 23 04:51:30 2001
@@ -216,7 +216,7 @@
 #ifdef __KERNEL__
 #include <linux/string.h>
 
-extern inline void copy_siginfo(siginfo_t *to, siginfo_t *from)
+static inline void copy_siginfo(siginfo_t *to, siginfo_t *from)
 {
 	if (from->si_code < 0)
 		memcpy(to, from, sizeof(siginfo_t));
--- 2.4.7aa1/net/core/rtnetlink.c.~1~	Mon Feb 28 03:45:10 2000
+++ 2.4.7aa1/net/core/rtnetlink.c	Mon Jul 23 04:52:13 2001
@@ -274,7 +274,7 @@
 
 /* Process one rtnetlink message. */
 
-extern __inline__ int
+static __inline__ int
 rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, int *errp)
 {
 	struct rtnetlink_link *link;

--- 2.4.6pre2aa1/include/linux/sched.h.~1~	Wed Jun 13 00:44:45 2001
+++ 2.4.6pre2aa1/include/linux/sched.h	Wed Jun 13 00:47:23 2001
@@ -541,7 +541,7 @@
 extern unsigned long volatile jiffies;
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
-extern struct timeval xtime;
+extern volatile struct timeval xtime;
 extern void do_timer(struct pt_regs *);
 
 extern unsigned int * prof_buffer;

Andrea

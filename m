Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbVBDRjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbVBDRjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265857AbVBDRdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:33:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28615 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265630AbVBDRbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:31:01 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: Make switch_to() return previous task
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 04 Feb 2005 17:30:48 +0000
Message-ID: <28701.1107538248@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes switch_to() on the FRV pass through and return the
previous task pointer rather than trusting to luck that it'll be left in the
correct register/variable.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-switchto-2611rc3.diff 
 arch/frv/kernel/entry.S     |    3 +--
 arch/frv/kernel/switch_to.S |   34 ++++++++++++++++++++++------------
 include/asm-frv/processor.h |    2 +-
 include/asm-frv/system.h    |   17 ++++++++++-------
 4 files changed, 34 insertions(+), 22 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/entry.S linux-2.6.11-rc3-frv/arch/frv/kernel/entry.S
--- /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/entry.S	2005-02-04 11:49:30.000000000 +0000
+++ linux-2.6.11-rc3-frv/arch/frv/kernel/entry.S	2005-02-04 15:30:45.000000000 +0000
@@ -782,13 +782,12 @@ __entry_do_NMI:
 ###############################################################################
 #
 # the return path for a newly forked child process
-# - __switch_to() saved the old current pointer in GR27 for us
+# - __switch_to() saved the old current pointer in GR8 for us
 #
 ###############################################################################
 	.globl		ret_from_fork
 ret_from_fork:
 	LEDS		0x6100
-	ori.p		gr27,0,gr8
 	call		schedule_tail
 
 	# fork & co. return 0 to child
diff -uNrp /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/switch_to.S linux-2.6.11-rc3-frv/arch/frv/kernel/switch_to.S
--- /warthog/kernels/linux-2.6.11-rc3/arch/frv/kernel/switch_to.S	2005-02-04 11:49:30.000000000 +0000
+++ linux-2.6.11-rc3-frv/arch/frv/kernel/switch_to.S	2005-02-04 15:31:14.000000000 +0000
@@ -43,20 +43,22 @@ __kernel_current_task:
 
 ###############################################################################
 #
-# struct task_struct *__switch_to(struct thread_struct *prev, struct thread_struct *next)
+# struct task_struct *__switch_to(struct thread_struct *prev_thread,
+#				  struct thread_struct *next_thread,
+#				  struct task_struct *prev)
 #
 ###############################################################################
 	.globl		__switch_to
 __switch_to:
 	# save outgoing process's context
-	sethi.p		%hi(__switch_back),gr11
-	setlo		%lo(__switch_back),gr11
-	movsg		lr,gr10
+	sethi.p		%hi(__switch_back),gr13
+	setlo		%lo(__switch_back),gr13
+	movsg		lr,gr12
 
 	stdi		gr28,@(gr8,#__THREAD_FRAME)
 	sti		sp  ,@(gr8,#__THREAD_SP)
 	sti		fp  ,@(gr8,#__THREAD_FP)
-	stdi		gr10,@(gr8,#__THREAD_LR)
+	stdi		gr12,@(gr8,#__THREAD_LR)
 	stdi		gr16,@(gr8,#__THREAD_GR(16))
 	stdi		gr18,@(gr8,#__THREAD_GR(18))
 	stdi		gr20,@(gr8,#__THREAD_GR(20))
@@ -68,14 +70,14 @@ __switch_to:
 	ldi.p		@(gr8,#__THREAD_USER),gr8
 	call		save_user_regs
 	or		gr22,gr22,gr8
-
+	
 	# retrieve the new context
 	sethi.p		%hi(__kernel_frame0_ptr),gr6
 	setlo		%lo(__kernel_frame0_ptr),gr6
 	movsg		psr,gr4
 
 	lddi.p		@(gr9,#__THREAD_FRAME),gr10
-	or		gr29,gr29,gr27		; ret_from_fork needs to know old current
+	or		gr10,gr10,gr27		; save prev for the return value
 
 	ldi		@(gr11,#4),gr19		; get new_current->thread_info
 
@@ -88,8 +90,8 @@ __switch_to:
 	andi		gr4,#~PSR_ET,gr5
 	movgs		gr5,psr
 
-	or.p		gr10,gr0,gr28
-	or		gr11,gr0,gr29
+	or.p		gr10,gr0,gr28		; set __frame
+	or		gr11,gr0,gr29		; set __current
 	or.p		gr12,gr0,sp
 	or		gr13,gr0,fp
 	or		gr19,gr0,gr15		; set __current_thread_info
@@ -108,14 +110,17 @@ __switch_to:
 111:
 
 	# jump to __switch_back or ret_from_fork as appropriate
+	# - move prev to GR8
 	movgs		gr4,psr
-	jmpl		@(gr18,gr0)
+	jmpl.p		@(gr18,gr0)
+	or		gr27,gr27,gr8
 
 ###############################################################################
 #
 # restore incoming process's context
 # - on entry:
 #   - SP, FP, LR, GR15, GR28 and GR29 will have been set up appropriately
+#   - GR8 will point to the outgoing task_struct
 #   - GR9 will point to the incoming thread_struct
 #
 ###############################################################################
@@ -128,12 +133,16 @@ __switch_back:
 	lddi		@(gr9,#__THREAD_GR(26)),gr26
 
 	# fall through into restore_user_regs()
-	ldi		@(gr9,#__THREAD_USER),gr8
+	ldi.p		@(gr9,#__THREAD_USER),gr8
+	or		gr8,gr8,gr9
 
 ###############################################################################
 #
 # restore extra general regs and FP/Media regs
-# - void restore_user_regs(const struct user_context *target)
+# - void *restore_user_regs(const struct user_context *target, void *retval)
+# - on entry:
+#   - GR8 will point to the user context to swap in
+#   - GR9 will contain the value to be returned in GR8 (prev task on context switch)
 #
 ###############################################################################
 	.globl		restore_user_regs
@@ -245,6 +254,7 @@ __restore_skip_fr32_fr63:
 	lddi		@(gr8,#__FPMEDIA_FNER(0)),gr4
 	movsg		fner0,gr4
 	movsg		fner1,gr5
+	or.p		gr9,gr9,gr8
 	bralr
 
 	# the FR451 also has ACC8-11/ACCG8-11 regs (but not 4-7...)
diff -uNrp /warthog/kernels/linux-2.6.11-rc3/include/asm-frv/processor.h linux-2.6.11-rc3-frv/include/asm-frv/processor.h
--- /warthog/kernels/linux-2.6.11-rc3/include/asm-frv/processor.h	2005-02-04 11:50:21.000000000 +0000
+++ linux-2.6.11-rc3-frv/include/asm-frv/processor.h	2005-02-04 15:33:28.484022068 +0000
@@ -113,7 +113,7 @@ static inline void release_thread(struct
 
 extern asmlinkage int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 extern asmlinkage void save_user_regs(struct user_context *target);
-extern asmlinkage void restore_user_regs(const struct user_context *target);
+extern asmlinkage void *restore_user_regs(const struct user_context *target, ...);
 
 #define copy_segments(tsk, mm)		do { } while (0)
 #define release_segments(mm)		do { } while (0)
diff -uNrp /warthog/kernels/linux-2.6.11-rc3/include/asm-frv/system.h linux-2.6.11-rc3-frv/include/asm-frv/system.h
--- /warthog/kernels/linux-2.6.11-rc3/include/asm-frv/system.h	2005-02-04 11:50:21.000000000 +0000
+++ linux-2.6.11-rc3-frv/include/asm-frv/system.h	2005-02-04 16:12:47.113598875 +0000
@@ -26,13 +26,16 @@ struct thread_struct;
  * The `mb' is to tell GCC not to cache `current' across this call.
  */
 extern asmlinkage
-void __switch_to(struct thread_struct *prev, struct thread_struct *next);
-
-#define switch_to(prev, next, last)						\
-do {										\
-	prev->thread.sched_lr = (unsigned long) __builtin_return_address(0);	\
-	__switch_to(&prev->thread, &next->thread);				\
-	mb();									\
+struct task_struct *__switch_to(struct thread_struct *prev_thread,
+				struct thread_struct *next_thread,
+				struct task_struct *prev);
+
+#define switch_to(prev, next, last)					\
+do {									\
+	(prev)->thread.sched_lr =					\
+		(unsigned long) __builtin_return_address(0);		\
+	(last) = __switch_to(&(prev)->thread, &(next)->thread, (prev));	\
+	mb();								\
 } while(0)
 
 /*

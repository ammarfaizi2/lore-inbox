Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVFGTCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVFGTCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 15:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVFGTCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 15:02:20 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:63749 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261956AbVFGTCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 15:02:07 -0400
Message-ID: <42A5EF2D.5030905@stud.feec.vutbr.cz>
Date: Tue, 07 Jun 2005 21:02:05 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-20
References: <20050607110409.GA14613@elte.hu>
In-Reply-To: <20050607110409.GA14613@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------010601070906030004030808"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
   0.0 UPPERCASE_25_50        message body is 25-50% uppercase
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010601070906030004030808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
>  - performance feature: i've implemented a new scheduler feature called 
>    'delayed preemption', [...]

So far it's only for i386. On x84_64 the kernel doesn't compile.
Attached is my attempt to make it work on x86_64.
The diff is against RT-V0.7.47-26.

Warning: I don't know what I'm doing! But at least it compiles and boots 
for me.

Michich

--------------010601070906030004030808
Content-Type: text/plain;
 name="rt-x86_64-delayed-preemption.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt-x86_64-delayed-preemption.diff"

diff -Nurp -X linux-RT.mich/Documentation/dontdiff linux-RT/arch/x86_64/kernel/entry.S linux-RT.mich/arch/x86_64/kernel/entry.S
--- linux-RT/arch/x86_64/kernel/entry.S	2005-06-07 19:07:30.000000000 +0200
+++ linux-RT.mich/arch/x86_64/kernel/entry.S	2005-06-07 20:48:26.000000000 +0200
@@ -211,8 +211,8 @@ sysret_check:		
 	/* Handle reschedules */
 	/* edx:	work, edi: workmask */	
 sysret_careful:
-	bt $TIF_NEED_RESCHED,%edx
-	jnc sysret_signal
+	testl $(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED),%edx
+	jz sysret_signal
 	sti
 	pushq %rdi
 	call schedule
@@ -231,7 +231,7 @@ sysret_signal:
 	leaq -ARGOFFSET(%rsp),%rdi # &pt_regs -> arg1
 	xorl %esi,%esi # oldset -> arg2
 	call ptregscall_common
-1:	movl $_TIF_NEED_RESCHED,%edi
+1:	movl $(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED),%edi
 	jmp sysret_check
 	
 	/* Do syscall tracing */
@@ -280,8 +280,8 @@ int_with_check:
 	/* First do a reschedule test. */
 	/* edx:	work, edi: workmask */
 int_careful:
-	bt $TIF_NEED_RESCHED,%edx
-	jnc  int_very_careful
+	testl $(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED),%edx
+	jz int_very_careful
 	sti
 	pushq %rdi
 	call schedule
@@ -310,7 +310,7 @@ int_signal:
 	movq %rsp,%rdi		# &ptregs -> arg1
 	xorl %esi,%esi		# oldset -> arg2
 	call do_notify_resume
-1:	movl $_TIF_NEED_RESCHED,%edi	
+1:	movl $(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED),%edi	
 int_restore_rest:
 	RESTORE_REST
 	cli
@@ -478,8 +478,8 @@ bad_iret:
 	
 	/* edi: workmask, edx: work */	
 retint_careful:
-	bt    $TIF_NEED_RESCHED,%edx
-	jnc   retint_signal
+	testl $(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED),%edx
+	jz    retint_signal
 	sti
 	pushq %rdi
 	call  schedule
@@ -499,7 +499,7 @@ retint_signal:
 	call do_notify_resume
 	RESTORE_REST
 	cli
-	movl $_TIF_NEED_RESCHED,%edi
+	movl $(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED),%edi
 	GET_THREAD_INFO(%rcx)
 	jmp retint_check
 
diff -Nurp -X linux-RT.mich/Documentation/dontdiff linux-RT/include/asm-x86_64/thread_info.h linux-RT.mich/include/asm-x86_64/thread_info.h
--- linux-RT/include/asm-x86_64/thread_info.h	2005-06-07 14:05:32.000000000 +0200
+++ linux-RT.mich/include/asm-x86_64/thread_info.h	2005-06-07 19:12:01.000000000 +0200
@@ -103,6 +103,7 @@ static inline struct thread_info *stack_
 #define TIF_IRET		5	/* force IRET */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
+#define TIF_NEED_RESCHED_DELAYED	9	/* rescheduling necessary upon return to userspace */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_IA32		17	/* 32bit process */ 
 #define TIF_FORK		18	/* ret_from_fork */
@@ -117,6 +118,7 @@ static inline struct thread_info *stack_
 #define _TIF_IRET		(1<<TIF_IRET)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
+#define _TIF_NEED_RESCHED_DELAYED	(1<<TIF_NEED_RESCHED_DELAYED)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_IA32		(1<<TIF_IA32)
 #define _TIF_FORK		(1<<TIF_FORK)

--------------010601070906030004030808--

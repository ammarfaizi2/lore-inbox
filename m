Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbULHJeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbULHJeJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 04:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbULHJeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 04:34:09 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:58828 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261167AbULHJeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 04:34:01 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: phil.el@wanadoo.fr
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Date: Wed, 8 Dec 2004 18:34:38 +0900
User-Agent: KMail/1.5.4
Cc: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
References: <200412081830.51607.amgta@yacht.ocn.ne.jp>
In-Reply-To: <200412081830.51607.amgta@yacht.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412081834.38462.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 December 2004 18:30, Akinobu Mita wrote:

> Please apply this patch, or make oprofile initialize the backtrace
> operation in case of using timer interrupt in your preferable way.

Acutually, I want this change to work my own tailor-made profiler.
It simply moves the point where timer_hook is called.

e.g. move timer_hook to the entry point of schedule().

--- 2.6-mm/kernel/profile.c.orig	2004-12-07 23:52:56.000000000 +0900
+++ 2.6-mm/kernel/profile.c	2004-12-07 23:53:29.000000000 +0900
@@ -383,8 +383,6 @@ void profile_hit(int type, void *__pc)
 
 void profile_tick(int type, struct pt_regs *regs)
 {
-	if (type == CPU_PROFILING && timer_hook)
-		timer_hook(regs);
 	if (!user_mode(regs) && cpu_isset(smp_processor_id(), prof_cpu_mask))
 		profile_hit(type, (void *)profile_pc(regs));
 }
--- 2.6-mm/kernel/sched.c.orig	2004-12-08 16:08:13.000000000 +0900
+++ 2.6-mm/kernel/sched.c	2004-12-08 16:10:01.000000000 +0900
@@ -2665,6 +2665,30 @@ EXPORT_SYMBOL(sub_preempt_count);
 
 #endif
 
+#ifdef __i386__
+#define GET_CURRENT_REGS(regs)						\
+do {									\
+	__asm__ __volatile__("movl %%ebx,%0" : "=m"(regs.ebx));	\
+	__asm__ __volatile__("movl %%ecx,%0" : "=m"(regs.ecx));	\
+	__asm__ __volatile__("movl %%edx,%0" : "=m"(regs.edx));	\
+	__asm__ __volatile__("movl %%esi,%0" : "=m"(regs.esi));	\
+	__asm__ __volatile__("movl %%edi,%0" : "=m"(regs.edi));	\
+	__asm__ __volatile__("movl %%ebp,%0" : "=m"(regs.ebp));	\
+	__asm__ __volatile__("movl %%eax,%0" : "=m"(regs.eax));	\
+	__asm__ __volatile__("movl %%esp,%0" : "=m"(regs.esp));	\
+	__asm__ __volatile__("movw %%ss, %%ax;" :"=a"(regs.xss));	\
+	__asm__ __volatile__("movw %%cs, %%ax;" :"=a"(regs.xcs));	\
+	__asm__ __volatile__("movw %%ds, %%ax;" :"=a"(regs.xds));	\
+	__asm__ __volatile__("movw %%es, %%ax;" :"=a"(regs.xes));	\
+	__asm__ __volatile__("pushfl; popl %0" :"=m"(regs.eflags));	\
+									\
+	regs.eip = (unsigned long)current_text_addr();			\
+} while(0)
+
+#else
+#error please define get_current_regs()
+#endif
+
 /*
  * schedule() is the main scheduler function.
  */
@@ -2692,7 +2716,12 @@ asmlinkage void __sched schedule(void)
 			dump_stack();
 		}
 	}
-	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
+	if (timer_hook) {
+		struct pt_regs regs;
+
+		GET_CURRENT_REGS(regs);
+		timer_hook(&regs);
+	}
 
 need_resched:
 	preempt_disable();



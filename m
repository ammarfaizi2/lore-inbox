Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbTDEWIk (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 17:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbTDEWIk (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 17:08:40 -0500
Received: from siaab1ab.compuserve.com ([149.174.40.2]:39558 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262689AbTDEWIg (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 17:08:36 -0500
Date: Sat, 5 Apr 2003 17:17:33 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] New cpu macro and i386 cleanup
To: Robert Love <rml@tech9.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304051719_MC3-1-3328-B238@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:


> On a glance, it looked like at least some of them were.


Looks like do_rdmsr is not disabling preempt.  This should fix
it (compiled not tested.)


diff -u --exclude-from=/home/me/.exclude -r linux-2.5.66-ref/arch/i386/kernel/cpuid.c linux-2.5.66-uni/arch/i386/kernel/cpuid.c
--- linux-2.5.66-ref/arch/i386/kernel/cpuid.c	Sat Mar 29 09:16:32 2003
+++ linux-2.5.66-uni/arch/i386/kernel/cpuid.c	Fri Apr  4 18:45:19 2003
@ -56,7 +56,7 @
 {
   struct cpuid_command *cmd = (struct cpuid_command *) cmd_block;
   
-  if ( cmd->cpu == smp_processor_id() )
+  if ( is_current_cpu(cmd->cpu) )
     cpuid(cmd->reg, &cmd->data[0], &cmd->data[1], &cmd->data[2], &cmd->data[3]);
 }
 
@ -65,7 +65,7 @
   struct cpuid_command cmd;
   
   preempt_disable();
-  if ( cpu == smp_processor_id() ) {
+  if ( is_current_cpu(cpu) ) {
     cpuid(reg, &data[0], &data[1], &data[2], &data[3]);
   } else {
     cmd.cpu  = cpu;
diff -u --exclude-from=/home/me/.exclude -r linux-2.5.66-ref/arch/i386/kernel/msr.c linux-2.5.66-uni/arch/i386/kernel/msr.c
--- linux-2.5.66-ref/arch/i386/kernel/msr.c	Sat Mar 29 09:16:32 2003
+++ linux-2.5.66-uni/arch/i386/kernel/msr.c	Sat Apr  5 16:18:29 2003
@ -100,7 +100,7 @
 {
   struct msr_command *cmd = (struct msr_command *) cmd_block;
   
-  if ( cmd->cpu == smp_processor_id() )
+  if ( is_current_cpu(cmd->cpu) )
     cmd->err = wrmsr_eio(cmd->reg, cmd->data[0], cmd->data[1]);
 }
 
@ -108,7 +108,7 @
 {
   struct msr_command *cmd = (struct msr_command *) cmd_block;
   
-  if ( cmd->cpu == smp_processor_id() )
+  if ( is_current_cpu(cmd->cpu) )
     cmd->err = rdmsr_eio(cmd->reg, &cmd->data[0], &cmd->data[1]);
 }
 
@ -118,29 +118,31 @
   int ret;
 
   preempt_disable();
-  if ( cpu == smp_processor_id() ) {
+  if ( is_current_cpu(cpu) )
     ret = wrmsr_eio(reg, eax, edx);
-    preempt_enable();
-    return ret;
-  } else {
+  else {
     cmd.cpu = cpu;
     cmd.reg = reg;
     cmd.data[0] = eax;
     cmd.data[1] = edx;
     
     smp_call_function(msr_smp_wrmsr, &cmd, 1, 1);
-    preempt_enable();
-    return cmd.err;
+
+    ret = cmd.err;
   }
+  preempt_enable();
+  return ret;
 }
 
 static inline int do_rdmsr(int cpu, u32 reg, u32 *eax, u32 *edx)
 {
   struct msr_command cmd;
+  int ret;
 
-  if ( cpu == smp_processor_id() ) {
-    return rdmsr_eio(reg, eax, edx);
-  } else {
+  preempt_disable();
+  if ( is_current_cpu(cpu) )
+    ret = rdmsr_eio(reg, eax, edx);
+  else {
     cmd.cpu = cpu;
     cmd.reg = reg;
 
@ -148,9 +150,10 @
     
     *eax = cmd.data[0];
     *edx = cmd.data[1];
-
-    return cmd.err;
+    ret = cmd.err;
   }
+  preempt_enable();
+  return ret;
 }
 
 #else /* ! CONFIG_SMP */
diff -u --exclude-from=/home/me/.exclude -r linux-2.5.66-ref/include/linux/smp.h linux-2.5.66-uni/include/linux/smp.h
--- linux-2.5.66-ref/include/linux/smp.h	Tue Mar  4 22:29:21 2003
+++ linux-2.5.66-uni/include/linux/smp.h	Sat Apr  5 16:33:09 2003
@ -134,6 +134,12 @
 }
 #endif /* !SMP */
 
+	/* is_current_cpu() is not preempt-safe.
+	 * Use 'cpu == get_cpu()' and then put_cpu()
+	 * if preempt not already disabled.
+	 */
+#define is_current_cpu(cpu)	((cpu) == smp_processor_id())
+
 #define get_cpu()		({ preempt_disable(); smp_processor_id(); })
 #define put_cpu()		preempt_enable()
 #define put_cpu_no_resched()	preempt_enable_no_resched()
diff -u --exclude-from=/home/me/.exclude -r linux-2.5.66-ref/include/linux/threads.h linux-2.5.66-uni/include/linux/threads.h
--- linux-2.5.66-ref/include/linux/threads.h	Tue Mar  4 22:28:55 2003
+++ linux-2.5.66-uni/include/linux/threads.h	Sat Mar 29 11:01:55 2003
@ -20,6 +20,9 @
 #define NR_CPUS		1
 #endif
 
+#define FIRST_CPU	0
+#define LAST_CPU	(NR_CPUS - 1)
+
 #define MIN_THREADS_LEFT_FOR_ROOT 4
 
 /*



--
 Chuck
 I am not a number!

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbTDEAUx (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 19:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTDEAUx (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 19:20:53 -0500
Received: from siaab1aa.compuserve.com ([149.174.40.1]:54937 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S261521AbTDEAUs (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 19:20:48 -0500
Date: Fri, 4 Apr 2003 19:29:57 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH] New cpu macro and i386 cleanup
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304041931_MC3-1-3308-9B07@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This annoyed me just enough to try and fix it.  I'd
fix all the rest but I know how annoyed people get at
massive changes:


diff -u --exclude-from=/home/me/.exclude -r linux-2.5.66-ref/include/linux/smp.h linux-2.5.66-uni/include/linux/smp.h
--- linux-2.5.66-ref/include/linux/smp.h	Tue Mar  4 22:29:21 2003
+++ linux-2.5.66-uni/include/linux/smp.h	Sat Mar 29 15:05:56 2003
@ -134,6 +134,8 @
 }
 #endif /* !SMP */
 
+#define is_current_cpu(cpu)	((cpu) == smp_processor_id())
+
 #define get_cpu()		({ preempt_disable(); smp_processor_id(); })
 #define put_cpu()		preempt_enable()
 #define put_cpu_no_resched()	preempt_enable_no_resched()
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
+++ linux-2.5.66-uni/arch/i386/kernel/msr.c	Fri Apr  4 18:47:27 2003
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
 
@ -118,7 +118,7 @
   int ret;
 
   preempt_disable();
-  if ( cpu == smp_processor_id() ) {
+  if ( is_current_cpu(cpu) ) {
     ret = wrmsr_eio(reg, eax, edx);
     preempt_enable();
     return ret;
@ -138,7 +138,7 @
 {
   struct msr_command cmd;
 
-  if ( cpu == smp_processor_id() ) {
+  if ( is_current_cpu(cpu) ) {
     return rdmsr_eio(reg, eax, edx);
   } else {
     cmd.cpu = cpu;

--
 Chuck
 I am not a number!

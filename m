Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263844AbTEODVk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTEODS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:18:28 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:1004 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263773AbTEODSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:14 -0400
Date: Thu, 15 May 2003 04:31:02 +0100
Message-Id: <200305150331.h4F3V2WY000543@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Preemption fixes for x86 MSR driver.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wrmsr is ok, but needs cleans up, second part (rdmsr)
is currently broken.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/msr.c linux-2.5/arch/i386/kernel/msr.c
--- bk-linus/arch/i386/kernel/msr.c	2003-04-10 06:01:09.000000000 +0100
+++ linux-2.5/arch/i386/kernel/msr.c	2003-04-06 23:05:55.000000000 +0100
@@ -120,8 +120,6 @@ static inline int do_wrmsr(int cpu, u32 
   preempt_disable();
   if ( cpu == smp_processor_id() ) {
     ret = wrmsr_eio(reg, eax, edx);
-    preempt_enable();
-    return ret;
   } else {
     cmd.cpu = cpu;
     cmd.reg = reg;
@@ -129,17 +127,20 @@ static inline int do_wrmsr(int cpu, u32 
     cmd.data[1] = edx;
     
     smp_call_function(msr_smp_wrmsr, &cmd, 1, 1);
-    preempt_enable();
-    return cmd.err;
+    ret = cmd.err;
   }
+  preempt_enable();
+  return ret;
 }
 
 static inline int do_rdmsr(int cpu, u32 reg, u32 *eax, u32 *edx)
 {
   struct msr_command cmd;
+  int ret;
 
+  preempt_disable();
   if ( cpu == smp_processor_id() ) {
-    return rdmsr_eio(reg, eax, edx);
+    ret = rdmsr_eio(reg, eax, edx);
   } else {
     cmd.cpu = cpu;
     cmd.reg = reg;
@@ -149,8 +150,10 @@ static inline int do_rdmsr(int cpu, u32 
     *eax = cmd.data[0];
     *edx = cmd.data[1];
 
-    return cmd.err;
+    ret = cmd.err;
   }
+  preempt_enable();
+  return ret;
 }
 
 #else /* ! CONFIG_SMP */

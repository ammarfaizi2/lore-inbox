Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264263AbTCXQc0>; Mon, 24 Mar 2003 11:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264269AbTCXQbO>; Mon, 24 Mar 2003 11:31:14 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:32234 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264263AbTCXQas>; Mon, 24 Mar 2003 11:30:48 -0500
Message-Id: <200303241641.h2OGfw35008204@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:45 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: make x86 MSR driver preempt safe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/msr.c linux-2.5/arch/i386/kernel/msr.c
--- bk-linus/arch/i386/kernel/msr.c	2003-03-08 09:56:25.000000000 +0000
+++ linux-2.5/arch/i386/kernel/msr.c	2003-03-18 21:22:30.000000000 +0000
@@ -115,9 +115,13 @@ static void msr_smp_rdmsr(void *cmd_bloc
 static inline int do_wrmsr(int cpu, u32 reg, u32 eax, u32 edx)
 {
   struct msr_command cmd;
+  int ret;
 
+  preempt_disable();
   if ( cpu == smp_processor_id() ) {
-    return wrmsr_eio(reg, eax, edx);
+    ret = wrmsr_eio(reg, eax, edx);
+    preempt_enable();
+    return ret;
   } else {
     cmd.cpu = cpu;
     cmd.reg = reg;
@@ -125,6 +129,7 @@ static inline int do_wrmsr(int cpu, u32 
     cmd.data[1] = edx;
     
     smp_call_function(msr_smp_wrmsr, &cmd, 1, 1);
+    preempt_enable();
     return cmd.err;
   }
 }

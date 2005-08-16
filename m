Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbVHPPcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbVHPPcO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 11:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965269AbVHPPcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 11:32:14 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:13293 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964945AbVHPPcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 11:32:14 -0400
Subject: Re: 2.6.13-rc6-rt5
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050816121843.GA24308@elte.hu>
References: <20050816121843.GA24308@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 16 Aug 2005 11:31:56 -0400
Message-Id: <1124206316.5764.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following on compile:

cd ~/work/kernels/svn/linux_realtime_ernie/
make 
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-i386/asm_offsets.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC      kernel/latency.o
kernel/latency.c: In function 'check_critical_timing':
kernel/latency.c:1298: warning: 'flags' may be used uninitialized in this function
kernel/latency.c: In function '__start_critical_timing':
kernel/latency.c:1444: error: too few arguments to function '____trace'
kernel/latency.c: In function '__stop_critical_timing':
kernel/latency.c:1462: error: too few arguments to function '____trace'
make[1]: *** [kernel/latency.o] Error 1
make: *** [kernel] Error 2


Here's a patch.  I'm assuming this is what you want with flags.  I
haven't looked too deep into it ____trace. (I only look down a few '_'
not 4 of them :-)

-- Steve

Signed-off-by: Steven Rostedt

Index: linux_realtime_ernie/kernel/latency.c
===================================================================
--- linux_realtime_ernie/kernel/latency.c	(revision 293)
+++ linux_realtime_ernie/kernel/latency.c	(working copy)
@@ -1295,7 +1295,7 @@
 {
 	unsigned long latency, t0, t1;
 	cycles_t T0, T1, T2, delta;
-	unsigned long flags;
+	unsigned long flags = 0;
 
 	if (trace_user_triggered)
 		return;
@@ -1441,7 +1441,7 @@
 	_trace_cmdline(cpu, tr);
 
 	raw_local_save_flags(flags);
-	____trace(cpu, TRACE_FN, tr, eip, parent_eip, 0, 0, 0);
+	____trace(cpu, TRACE_FN, tr, eip, parent_eip, 0, 0, 0, flags);
 
 	atomic_dec(&tr->disabled);
 }
@@ -1459,7 +1459,7 @@
 
 	atomic_inc(&tr->disabled);
 	raw_local_save_flags(flags);
-	____trace(cpu, TRACE_FN, tr, eip, parent_eip, 0, 0, 0);
+	____trace(cpu, TRACE_FN, tr, eip, parent_eip, 0, 0, 0, flags);
 	check_critical_timing(cpu, tr, eip);
 	tr->critical_start = 0;
 	atomic_dec(&tr->disabled);



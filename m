Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUCDAQP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbUCDAQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:16:14 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10128 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261203AbUCDAOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:14:22 -0500
Subject: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@suse.de>,
       Ulrich Drepper <drepper@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <1078359191.10076.195.camel@cog.beaverton.ibm.com>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com>
	 <1078359137.10076.193.camel@cog.beaverton.ibm.com>
	 <1078359191.10076.195.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1078359248.10076.197.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 03 Mar 2004 16:14:08 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch implements the somewhat controversial vDSO hooks for
vsyscall-gtod. This makes LD_PRELOADing or changes to glibc unnecessary,
but requires that the system have a sysenter enabled glibc to see any
performance benifit. However the LD_PRELOAD method will still work as
well with this patch. This patch depends on both vsyscall-gtod_B3-part1
and vsyscall-gtod_B3-part2. 

thanks
-john

diff -Nru a/arch/i386/kernel/vsyscall-int80.S b/arch/i386/kernel/vsyscall-int80.S
--- a/arch/i386/kernel/vsyscall-int80.S	Wed Mar  3 15:40:05 2004
+++ b/arch/i386/kernel/vsyscall-int80.S	Wed Mar  3 15:40:05 2004
@@ -1,3 +1,6 @@
+#include <linux/config.h>
+#include <asm/unistd.h>
+#include <asm/vsyscall-gtod.h>
 /*
  * Code for the vsyscall page.  This version uses the old int $0x80 method.
  */
@@ -7,8 +10,26 @@
 	.type __kernel_vsyscall,@function
 __kernel_vsyscall:
 .LSTART_vsyscall:
+#ifdef CONFIG_VSYSCALL_GTOD
+	cmp $__NR_gettimeofday, %eax
+	je .Lvgettimeofday
+#endif /* CONFIG_VSYSCALL_GTOD */
 	int $0x80
 	ret
+
+#ifdef CONFIG_VSYSCALL_GTOD
+/* vsyscall-gettimeofday code */
+.Lvgettimeofday:
+	pushl %edx
+	pushl %ecx
+	pushl %ebx
+	call VSYSCALL_GTOD_START
+	popl %ebx
+	popl %ecx
+	popl %edx
+	ret
+#endif /* CONFIG_VSYSCALL_GTOD */
+
 .LEND_vsyscall:
 	.size __kernel_vsyscall,.-.LSTART_vsyscall
 	.previous
diff -Nru a/arch/i386/kernel/vsyscall-sysenter.S b/arch/i386/kernel/vsyscall-sysenter.S
--- a/arch/i386/kernel/vsyscall-sysenter.S	Wed Mar  3 15:40:05 2004
+++ b/arch/i386/kernel/vsyscall-sysenter.S	Wed Mar  3 15:40:05 2004
@@ -1,3 +1,6 @@
+#include <linux/config.h>
+#include <asm/unistd.h>
+#include <asm/vsyscall-gtod.h>
 /*
  * Code for the vsyscall page.  This version uses the sysenter instruction.
  */
@@ -7,6 +10,10 @@
 	.type __kernel_vsyscall,@function
 __kernel_vsyscall:
 .LSTART_vsyscall:
+#ifdef CONFIG_VSYSCALL_GTOD
+	cmp $__NR_gettimeofday, %eax
+	je .Lvgettimeofday
+#endif /* CONFIG_VSYSCALL_GTOD */
 	push %ecx
 .Lpush_ecx:
 	push %edx
@@ -31,6 +38,20 @@
 	pop %ecx
 .Lpop_ecx:
 	ret
+
+#ifdef CONFIG_VSYSCALL_GTOD
+/* vsyscall-gettimeofday code */
+.Lvgettimeofday:
+	pushl %edx
+	pushl %ecx
+	pushl %ebx
+	call VSYSCALL_GTOD_START
+	popl %ebx
+	popl %ecx
+	popl %edx
+	ret
+#endif /* CONFIG_VSYSCALL_GTOD */
+
 .LEND_vsyscall:
 	.size __kernel_vsyscall,.-.LSTART_vsyscall
 	.previous



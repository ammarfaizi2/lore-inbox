Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbTFWP64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 11:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264769AbTFWP64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 11:58:56 -0400
Received: from arbi.Informatik.Uni-Oldenburg.DE ([134.106.1.7]:46856 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id S264766AbTFWP6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 11:58:53 -0400
Subject: [sign BUG in 2.4.21]arch/sh/kernel/process.c & patch
To: linux-kernel@vger.kernel.org
Date: Mon, 23 Jun 2003 17:58:11 +0200 (MEST)
Cc: gniibe@m17n.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19UThr-0003PE-00@grossglockner.Informatik.Uni-Oldenburg.DE>
From: "Walter Harms" <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,
i have noticed a posible bug the the kernel_thread() implementation 
for sh-processors. Unfortunaly i dont have an SH and cant test it.

The return value for kernel_thread() is stored as unsigned long
but the actual type is pid_t (signed). 

if somebody can test this i would like to hear if this fixes the problem.
   
walter



--- arch/sh/kernel/process.c.org        2003-06-23 17:44:31.000000000 +0200
+++ arch/sh/kernel/process.c    2003-06-23 17:45:11.000000000 +0200
@@ -118,9 +118,9 @@
  * This is the mechanism for creating a new kernel thread.
  *
  */
-int arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
+pid_t arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {      /* Don't use this in BL=1(cli).  Or else, CPU resets! */
-       register unsigned long __sc0 __asm__ ("r0");
+       register  long __sc0 __asm__ ("r0");
        register unsigned long __sc3 __asm__ ("r3") = __NR_clone;
        register unsigned long __sc4 __asm__ ("r4") = (long) flags | CLONE_VM;
        register unsigned long __sc5 __asm__ ("r5") = 0;
@@ -140,7 +140,7 @@
                : "i" (__NR_exit), "r" (__sc3), "r" (__sc4), "r" (__sc5), 
                  "r" (__sc8), "r" (__sc9)
                : "memory", "t");
-       return __sc0;
+       return (pid_t) __sc0;
 }
 
 /*



-- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTGBCpw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 22:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbTGBCpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 22:45:52 -0400
Received: from codepoet.org ([166.70.99.138]:16592 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S264582AbTGBCps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 22:45:48 -0400
Date: Tue, 1 Jul 2003 21:00:14 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix 2.4.22-pre broken x86 math-emu
Message-ID: <20030702030013.GA3405@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of today's "fix up gcc 3.3 bits" patch [1], x86 math emulation
is now even more broken, since this latest patch has added some
mismatched quotes while still failing to address the actual
problems preventing this code from compiling with gcc 3.3.

This patch, first sent to you on Jun 21st, fixes the missing
semicolons and missing quotes in the x86 math-emu code, allowing
it to compile with gcc 3.3.  I have updated things to also fix
the mismatched quotes that were added today.  Unlike the patch
you applied earlier today, my patch is actually tested...

Please apply,

 -Erik

[1] http://www.kernel.org/diff/diffview.cgi?file=/pub/linux/kernel/v2.4/testing/cset/cset-alan@lxorguk.ukuu.org.uk|ChangeSet|20030701183359|14011.txt

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- linux/arch/i386/math-emu/poly.h.orig	2003-07-01 20:39:49.000000000 -0600
+++ linux/arch/i386/math-emu/poly.h	2003-07-01 20:39:57.000000000 -0600
@@ -64,7 +64,7 @@
 				      const unsigned long arg2)
 {
   int retval;
-  asm volatile ("mull %2; movl %%edx,%%eax" \
+  asm volatile ("mull %2; movl %%edx,%%eax; " \
 		:"=a" (retval) \
 		:"0" (arg1), "g" (arg2) \
 		:"dx");
@@ -75,11 +75,11 @@
 /* Add the 12 byte Xsig x2 to Xsig dest, with no checks for overflow. */
 static inline void add_Xsig_Xsig(Xsig *dest, const Xsig *x2)
 {
-  asm volatile ("movl %1,%%edi; movl %2,%%esi;" \
-                 movl (%%esi),%%eax; addl %%eax,(%%edi);" \
-                 movl 4(%%esi),%%eax; adcl %%eax,4(%%edi);" \
-                 movl 8(%%esi),%%eax; adcl %%eax,8(%%edi);"
-                 :"=g" (*dest):"g" (dest), "g" (x2)
+  asm volatile ("movl %1,%%edi; movl %2,%%esi; " \
+                 "movl (%%esi),%%eax; addl %%eax,(%%edi); " \
+                 "movl 4(%%esi),%%eax; adcl %%eax,4(%%edi); " \
+                 "movl 8(%%esi),%%eax; adcl %%eax,8(%%edi); " \
+                 :"=g" (*dest):"g" (dest), "g" (x2) \
                  :"ax","si","di");
 }
 
@@ -90,19 +90,19 @@
    problem, but keep fingers crossed! */
 static inline void add_two_Xsig(Xsig *dest, const Xsig *x2, long int *exp)
 {
-  asm volatile ("movl %2,%%ecx; movl %3,%%esi;
-                 movl (%%esi),%%eax; addl %%eax,(%%ecx);
-                 movl 4(%%esi),%%eax; adcl %%eax,4(%%ecx);
-                 movl 8(%%esi),%%eax; adcl %%eax,8(%%ecx);
-                 jnc 0f;
-		 rcrl 8(%%ecx); rcrl 4(%%ecx); rcrl (%%ecx)
-                 movl %4,%%ecx; incl (%%ecx)
-                 movl $1,%%eax; jmp 1f;
-                 0: xorl %%eax,%%eax;
-                 1:"
-		:"=g" (*exp), "=g" (*dest)
-		:"g" (dest), "g" (x2), "g" (exp)
-		:"cx","si","ax");
+  asm volatile ("movl %2,%%ecx; movl %3,%%esi; " \
+                 "movl (%%esi),%%eax; addl %%eax,(%%ecx); " \
+                 "movl 4(%%esi),%%eax; adcl %%eax,4(%%ecx); " \
+                 "movl 8(%%esi),%%eax; adcl %%eax,8(%%ecx); " \
+                 "jnc 0f; " \
+		 "rcrl 8(%%ecx); rcrl 4(%%ecx); rcrl (%%ecx); " \
+                 "movl %4,%%ecx; incl (%%ecx); " \
+                 "movl $1,%%eax; jmp 1f; " \
+                 "0: xorl %%eax,%%eax; " \
+                 "1: " \
+		:"=g" (*exp), "=g" (*dest) \
+		:"g" (dest), "g" (x2), "g" (exp) \
+		:"cx","si","ax"); 
 }
 
 
@@ -110,11 +110,11 @@
 /* This is faster in a loop on my 386 than using the "neg" instruction. */
 static inline void negate_Xsig(Xsig *x)
 {
-  asm volatile("movl %1,%%esi; "
-               "xorl %%ecx,%%ecx; "
-               "movl %%ecx,%%eax; subl (%%esi),%%eax; movl %%eax,(%%esi); "
-               "movl %%ecx,%%eax; sbbl 4(%%esi),%%eax; movl %%eax,4(%%esi); "
-               "movl %%ecx,%%eax; sbbl 8(%%esi),%%eax; movl %%eax,8(%%esi); "
+  asm volatile("movl %1,%%esi; " \
+               "xorl %%ecx,%%ecx; " \
+               "movl %%ecx,%%eax; subl (%%esi),%%eax; movl %%eax,(%%esi); " \
+               "movl %%ecx,%%eax; sbbl 4(%%esi),%%eax; movl %%eax,4(%%esi); " \
+               "movl %%ecx,%%eax; sbbl 8(%%esi),%%eax; movl %%eax,8(%%esi); " \
                :"=g" (*x):"g" (x):"si","ax","cx");
 }
 

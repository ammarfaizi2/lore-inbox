Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbTFUHQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 03:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265034AbTFUHQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 03:16:27 -0400
Received: from codepoet.org ([166.70.99.138]:12737 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S265027AbTFUHQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 03:16:25 -0400
Date: Sat, 21 Jun 2003 01:30:25 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] make x86 math-emu in 2.4.21 compile with gcc 3.3
Message-ID: <20030621073025.GA27921@codepoet.org>
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

I'm surprised this hasn't shown up before, but I guess nobody has
tried compiling 2.4.21 for i386 using gcc 3.3 yet.  Currently the
x86 math-emu code does not compile with gcc 3.3 due to some
missing semicolons and quotes.  This patch fixes things up so it
compiles once again.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- linux-2.4.21-erik/arch/i386/math-emu/poly.h.orig	2003-06-21 01:25:29.000000000 -0600
+++ linux-2.4.21-erik/arch/i386/math-emu/poly.h	2003-06-21 01:24:25.000000000 -0600
@@ -64,9 +64,9 @@
 				      const unsigned long arg2)
 {
   int retval;
-  asm volatile ("mull %2; movl %%edx,%%eax" \
-		:"=a" (retval) \
-		:"0" (arg1), "g" (arg2) \
+  asm volatile ("mull %2; movl %%edx,%%eax;"
+		:"=a" (retval)
+		:"0" (arg1), "g" (arg2)
 		:"dx");
   return retval;
 }
@@ -75,10 +75,10 @@
 /* Add the 12 byte Xsig x2 to Xsig dest, with no checks for overflow. */
 static inline void add_Xsig_Xsig(Xsig *dest, const Xsig *x2)
 {
-  asm volatile ("movl %1,%%edi; movl %2,%%esi;
-                 movl (%%esi),%%eax; addl %%eax,(%%edi);
-                 movl 4(%%esi),%%eax; adcl %%eax,4(%%edi);
-                 movl 8(%%esi),%%eax; adcl %%eax,8(%%edi);"
+  asm volatile ("movl %1,%%edi; movl %2,%%esi;"
+                 "movl (%%esi),%%eax; addl %%eax,(%%edi);"
+                 "movl 4(%%esi),%%eax; adcl %%eax,4(%%edi);"
+                 "movl 8(%%esi),%%eax; adcl %%eax,8(%%edi);"
                  :"=g" (*dest):"g" (dest), "g" (x2)
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
+  asm volatile ("movl %2,%%ecx; movl %3,%%esi;"
+                 "movl (%%esi),%%eax; addl %%eax,(%%ecx);"
+                 "movl 4(%%esi),%%eax; adcl %%eax,4(%%ecx);"
+                 "movl 8(%%esi),%%eax; adcl %%eax,8(%%ecx);"
+                 "jnc 0f;"
+		 "rcrl 8(%%ecx); rcrl 4(%%ecx); rcrl (%%ecx);"
+                 "movl %4,%%ecx; incl (%%ecx);"
+                 "movl $1,%%eax; jmp 1f;"
+                 "0: xorl %%eax,%%eax;"
+                 "1:"
 		:"=g" (*exp), "=g" (*dest)
 		:"g" (dest), "g" (x2), "g" (exp)
-		:"cx","si","ax");
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
+  asm volatile("movl %1,%%esi;"
+               "xorl %%ecx,%%ecx;"
+               "movl %%ecx,%%eax; subl (%%esi),%%eax; movl %%eax,(%%esi);"
+               "movl %%ecx,%%eax; sbbl 4(%%esi),%%eax; movl %%eax,4(%%esi);"
+               "movl %%ecx,%%eax; sbbl 8(%%esi),%%eax; movl %%eax,8(%%esi);"
                :"=g" (*x):"g" (x):"si","ax","cx");
 }
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261739AbSJHS5a>; Tue, 8 Oct 2002 14:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261753AbSJHS5a>; Tue, 8 Oct 2002 14:57:30 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11280 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261739AbSJHS4h>; Tue, 8 Oct 2002 14:56:37 -0400
Subject: PATCH: fix warnings in fpu code
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 19:53:45 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzUH-0004rA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/arch/i386/math-emu/poly.h linux.2.5.41-ac1/arch/i386/math-emu/poly.h
--- linux.2.5.41/arch/i386/math-emu/poly.h	2002-07-20 20:11:05.000000000 +0100
+++ linux.2.5.41-ac1/arch/i386/math-emu/poly.h	2002-10-06 22:24:42.000000000 +0100
@@ -75,10 +75,10 @@
 /* Add the 12 byte Xsig x2 to Xsig dest, with no checks for overflow. */
 static inline void add_Xsig_Xsig(Xsig *dest, const Xsig *x2)
 {
-  asm volatile ("movl %1,%%edi; movl %2,%%esi;
-                 movl (%%esi),%%eax; addl %%eax,(%%edi);
-                 movl 4(%%esi),%%eax; adcl %%eax,4(%%edi);
-                 movl 8(%%esi),%%eax; adcl %%eax,8(%%edi);"
+  asm volatile ("movl %1,%%edi; movl %2,%%esi;\n"
+                "movl (%%esi),%%eax; addl %%eax,(%%edi);\n"
+                "movl 4(%%esi),%%eax; adcl %%eax,4(%%edi);\n"
+                "movl 8(%%esi),%%eax; adcl %%eax,8(%%edi);\n"
                  :"=g" (*dest):"g" (dest), "g" (x2)
                  :"ax","si","di");
 }
@@ -90,16 +90,16 @@
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
+  asm volatile ("movl %2,%%ecx; movl %3,%%esi;\n"
+                "movl (%%esi),%%eax; addl %%eax,(%%ecx);\n"
+                "movl 4(%%esi),%%eax; adcl %%eax,4(%%ecx);\n"
+                "movl 8(%%esi),%%eax; adcl %%eax,8(%%ecx);\n"
+                "jnc 0f;\n"
+		"rcrl 8(%%ecx); rcrl 4(%%ecx); rcrl (%%ecx)\n"
+                "movl %4,%%ecx; incl (%%ecx)\n"
+                "movl $1,%%eax; jmp 1f;\n"
+                "0: xorl %%eax,%%eax;\n"
+                "1:\n"
 		:"=g" (*exp), "=g" (*dest)
 		:"g" (dest), "g" (x2), "g" (exp)
 		:"cx","si","ax");
@@ -110,11 +110,11 @@
 /* This is faster in a loop on my 386 than using the "neg" instruction. */
 static inline void negate_Xsig(Xsig *x)
 {
-  asm volatile("movl %1,%%esi; "
-               "xorl %%ecx,%%ecx; "
-               "movl %%ecx,%%eax; subl (%%esi),%%eax; movl %%eax,(%%esi); "
-               "movl %%ecx,%%eax; sbbl 4(%%esi),%%eax; movl %%eax,4(%%esi); "
-               "movl %%ecx,%%eax; sbbl 8(%%esi),%%eax; movl %%eax,8(%%esi); "
+  asm volatile("movl %1,%%esi;\n"
+               "xorl %%ecx,%%ecx;\n"
+               "movl %%ecx,%%eax; subl (%%esi),%%eax; movl %%eax,(%%esi);\n"
+               "movl %%ecx,%%eax; sbbl 4(%%esi),%%eax; movl %%eax,4(%%esi);\n"
+               "movl %%ecx,%%eax; sbbl 8(%%esi),%%eax; movl %%eax,8(%%esi);\n"
                :"=g" (*x):"g" (x):"si","ax","cx");
 }
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267922AbRGRUvL>; Wed, 18 Jul 2001 16:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267926AbRGRUvB>; Wed, 18 Jul 2001 16:51:01 -0400
Received: from d-dialin-271.addcom.de ([62.96.160.31]:34030 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267922AbRGRUus>; Wed, 18 Jul 2001 16:50:48 -0400
Date: Wed, 18 Jul 2001 22:43:44 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Julian Anastasov <ja@ssi.bg>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
In-Reply-To: <Pine.LNX.4.33.0107181014590.883-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0107182239050.1298-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2001, Linus Torvalds wrote:

> Can you try to do the following in the cpuid_xxx() functions:
>  - remove the dummy reads (ie leave just the one register in the asm that
>    we're actually interested in)
>  - add explicit clobbers for the other registers

I looked into this a little to improve my knowledge on inline asm. Anyway, 
I found one ugly work-around, i.e. using a makro instead of the inline 
function plus a local eax_in variable, but your idea seems way nicer and 
works as well.

Generated code looks okay now (using kgcc aka egcs-2.91.66):

    2002:       31 c0                   xor    %eax,%eax
    2004:       0f a2                   cpuid  
    2006:       89 46 08                mov    %eax,0x8(%esi)
    2009:       5b                      pop    %ebx
    200a:       5e                      pop    %esi
    200b:       c3                      ret    

Patch follows:

--Kai


diff -ur linux-2.4.7-pre7/include/asm-i386/processor.h linux-2.4.7-pre7.work/include/asm-i386/processor.h
--- linux-2.4.7-pre7/include/asm-i386/processor.h	Wed Jul 18 21:49:47 2001
+++ linux-2.4.7-pre7.work/include/asm-i386/processor.h	Wed Jul 18 22:38:20 2001
@@ -134,38 +134,42 @@
  */
 extern inline unsigned int cpuid_eax(unsigned int op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	unsigned int eax;
 
 	__asm__("cpuid"
-		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
-		: "a" (op));
+		: "=a" (eax)
+		: "a" (op)
+		: "ebx", "ecx", "edx");
 	return eax;
 }
 extern inline unsigned int cpuid_ebx(unsigned int op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	unsigned int ebx;
 
 	__asm__("cpuid"
-		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
-		: "a" (op));
+		: "=b" (ebx)
+		: "a" (op)
+		: "eax", "ecx", "edx");
 	return ebx;
 }
 extern inline unsigned int cpuid_ecx(unsigned int op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	unsigned int ecx;
 
 	__asm__("cpuid"
-		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
-		: "a" (op));
+		: "=c" (ecx)
+		: "a" (op)
+		: "eax", "ebx", "edx");
 	return ecx;
 }
 extern inline unsigned int cpuid_edx(unsigned int op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	unsigned int edx;
 
 	__asm__("cpuid"
-		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
-		: "a" (op));
+		: "=d" (edx)
+		: "a" (op)
+		: "eax", "ebx", "ecx");
 	return edx;
 }
 


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbRGRWFh>; Wed, 18 Jul 2001 18:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262355AbRGRWF1>; Wed, 18 Jul 2001 18:05:27 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:2571 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261651AbRGRWFN>; Wed, 18 Jul 2001 18:05:13 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 18 Jul 2001 15:04:20 -0700
Message-Id: <200107182204.f6IM4K001282@penguin.transmeta.com>
To: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org,
        Julian Anastasov <ja@ssi.bg>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
Newsgroups: linux.dev.kernel
In-Reply-To: <Pine.LNX.4.33.0107182239050.1298-100000@vaio>
In-Reply-To: <Pine.LNX.4.33.0107181014590.883-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0107182239050.1298-100000@vaio> you write:
>
>Generated code looks okay now (using kgcc aka egcs-2.91.66):
>
>    2002:       31 c0                   xor    %eax,%eax
>    2004:       0f a2                   cpuid  
>    2006:       89 46 08                mov    %eax,0x8(%esi)
>    2009:       5b                      pop    %ebx
>    200a:       5e                      pop    %esi
>    200b:       c3                      ret    
>
>Patch follows:

Can you verify with this alternate patch instead? Yours works ok on
older gcc's, but the gcc team feels that clobbers must never cover
inputs or outputs, so your patch really generates invalid asms.  Here's
a alternate, can you verify that it works for you guys, and perhaps
people can at the same time eye-ball it for any other issues they can
think of?

		Linus

----
--- pre7/linux/include/asm-i386/processor.h	Wed Jul 18 09:34:03 2001
+++ linux/include/asm-i386/processor.h	Wed Jul 18 14:58:45 2001
@@ -126,7 +126,7 @@
 		  "=b" (*ebx),
 		  "=c" (*ecx),
 		  "=d" (*edx)
-		: "a" (op));
+		: "0" (op));
 }
 
 /*
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
+		: "0" (op)
+		: "bx", "cx", "dx");
 	return eax;
 }
 extern inline unsigned int cpuid_ebx(unsigned int op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	unsigned int eax, ebx;
 
 	__asm__("cpuid"
-		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
-		: "a" (op));
+		: "=a" (eax), "=b" (ebx)
+		: "0" (op)
+		: "cx", "dx" );
 	return ebx;
 }
 extern inline unsigned int cpuid_ecx(unsigned int op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	unsigned int eax, ecx;
 
 	__asm__("cpuid"
-		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
-		: "a" (op));
+		: "=a" (eax), "=c" (ecx)
+		: "0" (op)
+		: "bx", "dx" );
 	return ecx;
 }
 extern inline unsigned int cpuid_edx(unsigned int op)
 {
-	unsigned int eax, ebx, ecx, edx;
+	unsigned int eax, edx;
 
 	__asm__("cpuid"
-		: "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
-		: "a" (op));
+		: "=a" (eax), "=d" (edx)
+		: "0" (op)
+		: "bx", "cx");
 	return edx;
 }
 

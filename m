Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUBZXjO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbUBZXiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:38:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35760 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261303AbUBZXhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:37:14 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com, davej@redhat.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: raid 5 with >= 5 members broken on x86
References: <orznb5leqs.fsf@free.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0402261329450.7830@ppc970.osdl.org>
	<or1xohpjzn.fsf@free.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0402261426460.7830@ppc970.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 26 Feb 2004 20:37:07 -0300
In-Reply-To: <Pine.LNX.4.58.0402261426460.7830@ppc970.osdl.org>
Message-ID: <orznb5e7ks.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

On Feb 26, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

> Ok. I did the silly one-liner, but if the "don't care" approach really 
> improves code generation, feel free to send one that fixes both the P5 and 
> PII cases..

Here's an updated patch that is supposed to apply cleanly after the
one-liner you've already checked in.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=i386-xor-stack-optimize.patch

--- include/asm-i386/xor.h.orig	2004-02-26 19:41:22.000000000 -0300
+++ include/asm-i386/xor.h	2004-02-26 19:48:24.000000000 -0300
@@ -182,11 +182,15 @@
 
 	kernel_fpu_begin();
 
-	/* need to save/restore p4/p5 manually otherwise gcc's 10 argument
-	   limit gets exceeded (+ counts as two arguments) */
+	/* Make sure GCC forgets anything it knows about p4 or p5,
+	   such that it won't pass to the asm volatile below a
+	   register that is shared with any other variable.  That's
+	   because we modify p4 and p5 there, but we can't mark them
+	   as read/write, otherwise we'd overflow the 10-asm-operands
+	   limit of GCC < 3.1.  */
+	__asm__ ("" : "+r" (p4), "+r" (p5));
+
 	__asm__ __volatile__ (
-		"  pushl %4\n"
-		"  pushl %5\n"
 #undef BLOCK
 #define BLOCK(i) \
 	LD(i,0)					\
@@ -229,13 +233,16 @@
 	"       addl $128, %5         ;\n"
 	"       decl %0               ;\n"
 	"       jnz 1b                ;\n"
-	"	popl %5\n"
-	"	popl %4\n"
 	: "+r" (lines),
 	  "+r" (p1), "+r" (p2), "+r" (p3)
 	: "r" (p4), "r" (p5) 
 	: "memory");
 
+	/* p4 and p5 were modified, and now the variables are dead.
+	   Clobber them just to be sure nobody does something stupid
+	   like assuming they have some legal value.  */
+	__asm__ ("" : "=r" (p4), "=r" (p5));
+
 	kernel_fpu_end();
 }
 
@@ -425,10 +432,15 @@
 
 	kernel_fpu_begin();
 
-	/* need to save p4/p5 manually to not exceed gcc's 10 argument limit */
+	/* Make sure GCC forgets anything it knows about p4 or p5,
+	   such that it won't pass to the asm volatile below a
+	   register that is shared with any other variable.  That's
+	   because we modify p4 and p5 there, but we can't mark them
+	   as read/write, otherwise we'd overflow the 10-asm-operands
+	   limit of GCC < 3.1.  */
+	__asm__ ("" : "+r" (p4), "+r" (p5));
+
 	__asm__ __volatile__ (
-	"	pushl %4\n"
-	"	pushl %5\n"        	
 	" .align 32,0x90             ;\n"
 	" 1:                         ;\n"
 	"       movq   (%1), %%mm0   ;\n"
@@ -487,13 +499,16 @@
 	"       addl $64, %5         ;\n"
 	"       decl %0              ;\n"
 	"       jnz 1b               ;\n"
-	"	popl %5\n"
-	"	popl %4\n"
 	: "+r" (lines),
 	  "+r" (p1), "+r" (p2), "+r" (p3)
 	: "r" (p4), "r" (p5)
 	: "memory");
 
+	/* p4 and p5 were modified, and now the variables are dead.
+	   Clobber them just to be sure nobody does something stupid
+	   like assuming they have some legal value.  */
+	__asm__ ("" : "=r" (p4), "=r" (p5));
+
 	kernel_fpu_end();
 }
 
@@ -757,10 +772,15 @@
 
 	XMMS_SAVE;
 
-	/* need to save p4/p5 manually to not exceed gcc's 10 argument limit */
+	/* Make sure GCC forgets anything it knows about p4 or p5,
+	   such that it won't pass to the asm volatile below a
+	   register that is shared with any other variable.  That's
+	   because we modify p4 and p5 there, but we can't mark them
+	   as read/write, otherwise we'd overflow the 10-asm-operands
+	   limit of GCC < 3.1.  */
+	__asm__ ("" : "+r" (p4), "+r" (p5));
+
         __asm__ __volatile__ (
-		" pushl %4\n"
-		" pushl %5\n"
 #undef BLOCK
 #define BLOCK(i) \
 		PF1(i)					\
@@ -817,13 +837,16 @@
         "       addl $256, %5           ;\n"
         "       decl %0                 ;\n"
         "       jnz 1b                  ;\n"
-	"	popl %5\n"	
-	"	popl %4\n"	
 	: "+r" (lines),
 	  "+r" (p1), "+r" (p2), "+r" (p3)
 	: "r" (p4), "r" (p5)
 	: "memory");
 
+	/* p4 and p5 were modified, and now the variables are dead.
+	   Clobber them just to be sure nobody does something stupid
+	   like assuming they have some legal value.  */
+	__asm__ ("" : "=r" (p4), "=r" (p5));
+
 	XMMS_RESTORE;
 }
 

--=-=-=


-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Happy GNU Year!                     oliva@{lsd.ic.unicamp.br, gnu.org}
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist                Professional serial bug killer

--=-=-=--

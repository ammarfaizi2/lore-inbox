Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbUBZVpH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 16:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUBZVo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 16:44:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:29323 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261166AbUBZVok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 16:44:40 -0500
Date: Thu, 26 Feb 2004 13:50:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com, davej@redhat.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: raid 5 with >= 5 members broken on x86
In-Reply-To: <orznb5leqs.fsf@free.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.LNX.4.58.0402261329450.7830@ppc970.osdl.org>
References: <orznb5leqs.fsf@free.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Alexandre Oliva wrote:
> 
> I suppose I could just change lines from +g to +r, like xor_pII_mmx_5,
> but avoiding the pushes and pops is more efficient, and making sure
> GCC doesn't get clever about sharing or reusing p4 and p5, it's just
> as safe.  This approach should probably be extended to the other uses
> of push and pop due to limitations in the number of operands.

You can't do this in a separate inline asm. There is nothing to say that 
gcc wouldn't do a re-load or something in between, so you really need to 
tell the _first_ ask about it.

> Yet another possibility is to just use +r for p4 and p5; this works in
> GCC 3.1 and above.  I wasn't sure the kernel was willing to require
> that, so I took the most conservative approach.

No, I don't think we're ready to force a bigger and slower compiler on x86 
for something like this. But your fix doesn't really work either.

One approach is to just do the loop _outside_ of the asm? I don't see much 
point to trying to force the small stuff. What's the difference if you do 
something like the appended?

Btw, the "xor_pII_mmx_5()" thing just uses "+r" for the line count, so why 
doesn't that work for this case?

		Linus

===== include/asm-i386/xor.h 1.14 vs edited =====
--- 1.14/include/asm-i386/xor.h	Tue Mar 11 18:15:03 2003
+++ edited/include/asm-i386/xor.h	Thu Feb 26 13:46:49 2004
@@ -426,74 +426,69 @@
 	kernel_fpu_begin();
 
 	/* need to save p4/p5 manually to not exceed gcc's 10 argument limit */
-	__asm__ __volatile__ (
-	"	pushl %4\n"
-	"	pushl %5\n"        	
-	" .align 32,0x90             ;\n"
-	" 1:                         ;\n"
-	"       movq   (%1), %%mm0   ;\n"
-	"       movq  8(%1), %%mm1   ;\n"
-	"       pxor   (%2), %%mm0   ;\n"
-	"       pxor  8(%2), %%mm1   ;\n"
-	"       movq 16(%1), %%mm2   ;\n"
-	"       pxor   (%3), %%mm0   ;\n"
-	"       pxor  8(%3), %%mm1   ;\n"
-	"       pxor 16(%2), %%mm2   ;\n"
-	"       pxor   (%4), %%mm0   ;\n"
-	"       pxor  8(%4), %%mm1   ;\n"
-	"       pxor 16(%3), %%mm2   ;\n"
-	"       movq 24(%1), %%mm3   ;\n"
-	"       pxor   (%5), %%mm0   ;\n"
-	"       pxor  8(%5), %%mm1   ;\n"
-	"       movq %%mm0,   (%1)   ;\n"
-	"       pxor 16(%4), %%mm2   ;\n"
-	"       pxor 24(%2), %%mm3   ;\n"
-	"       movq %%mm1,  8(%1)   ;\n"
-	"       pxor 16(%5), %%mm2   ;\n"
-	"       pxor 24(%3), %%mm3   ;\n"
-	"       movq 32(%1), %%mm4   ;\n"
-	"       movq %%mm2, 16(%1)   ;\n"
-	"       pxor 24(%4), %%mm3   ;\n"
-	"       pxor 32(%2), %%mm4   ;\n"
-	"       movq 40(%1), %%mm5   ;\n"
-	"       pxor 24(%5), %%mm3   ;\n"
-	"       pxor 32(%3), %%mm4   ;\n"
-	"       pxor 40(%2), %%mm5   ;\n"
-	"       movq %%mm3, 24(%1)   ;\n"
-	"       pxor 32(%4), %%mm4   ;\n"
-	"       pxor 40(%3), %%mm5   ;\n"
-	"       movq 48(%1), %%mm6   ;\n"
-	"       movq 56(%1), %%mm7   ;\n"
-	"       pxor 32(%5), %%mm4   ;\n"
-	"       pxor 40(%4), %%mm5   ;\n"
-	"       pxor 48(%2), %%mm6   ;\n"
-	"       pxor 56(%2), %%mm7   ;\n"
-	"       movq %%mm4, 32(%1)   ;\n"
-	"       pxor 48(%3), %%mm6   ;\n"
-	"       pxor 56(%3), %%mm7   ;\n"
-	"       pxor 40(%5), %%mm5   ;\n"
-	"       pxor 48(%4), %%mm6   ;\n"
-	"       pxor 56(%4), %%mm7   ;\n"
-	"       movq %%mm5, 40(%1)   ;\n"
-	"       pxor 48(%5), %%mm6   ;\n"
-	"       pxor 56(%5), %%mm7   ;\n"
-	"       movq %%mm6, 48(%1)   ;\n"
-	"       movq %%mm7, 56(%1)   ;\n"
-      
-	"       addl $64, %1         ;\n"
-	"       addl $64, %2         ;\n"
-	"       addl $64, %3         ;\n"
-	"       addl $64, %4         ;\n"
-	"       addl $64, %5         ;\n"
-	"       decl %0              ;\n"
-	"       jnz 1b               ;\n"
-	"	popl %5\n"
-	"	popl %4\n"
-	: "+g" (lines),
-	  "+r" (p1), "+r" (p2), "+r" (p3)
-	: "r" (p4), "r" (p5)
-	: "memory");
-
+	__asm__ __volatile(".align 32,0x90");
+	do {
+		__asm__ __volatile__ (
+		       "movq   (%0), %%mm0   ;\n"
+		"       movq  8(%0), %%mm1   ;\n"
+		"       pxor   (%1), %%mm0   ;\n"
+		"       pxor  8(%1), %%mm1   ;\n"
+		"       movq 16(%0), %%mm2   ;\n"
+		"       pxor   (%2), %%mm0   ;\n"
+		"       pxor  8(%2), %%mm1   ;\n"
+		"       pxor 16(%1), %%mm2   ;\n"
+		"       pxor   (%3), %%mm0   ;\n"
+		"       pxor  8(%3), %%mm1   ;\n"
+		"       pxor 16(%2), %%mm2   ;\n"
+		"       movq 24(%0), %%mm3   ;\n"
+		"       pxor   (%4), %%mm0   ;\n"
+		"       pxor  8(%4), %%mm1   ;\n"
+		"       movq %%mm0,   (%0)   ;\n"
+		"       pxor 16(%3), %%mm2   ;\n"
+		"       pxor 24(%1), %%mm3   ;\n"
+		"       movq %%mm1,  8(%0)   ;\n"
+		"       pxor 16(%4), %%mm2   ;\n"
+		"       pxor 24(%2), %%mm3   ;\n"
+		"       movq 32(%0), %%mm4   ;\n"
+		"       movq %%mm2, 16(%0)   ;\n"
+		"       pxor 24(%3), %%mm3   ;\n"
+		"       pxor 32(%1), %%mm4   ;\n"
+		"       movq 40(%0), %%mm5   ;\n"
+		"       pxor 24(%4), %%mm3   ;\n"
+		"       pxor 32(%2), %%mm4   ;\n"
+		"       pxor 40(%1), %%mm5   ;\n"
+		"       movq %%mm3, 24(%0)   ;\n"
+		"       pxor 32(%3), %%mm4   ;\n"
+		"       pxor 40(%2), %%mm5   ;\n"
+		"       movq 48(%0), %%mm6   ;\n"
+		"       movq 56(%0), %%mm7   ;\n"
+		"       pxor 32(%4), %%mm4   ;\n"
+		"       pxor 40(%3), %%mm5   ;\n"
+		"       pxor 48(%1), %%mm6   ;\n"
+		"       pxor 56(%1), %%mm7   ;\n"
+		"       movq %%mm4, 32(%0)   ;\n"
+		"       pxor 48(%2), %%mm6   ;\n"
+		"       pxor 56(%2), %%mm7   ;\n"
+		"       pxor 40(%4), %%mm5   ;\n"
+		"       pxor 48(%3), %%mm6   ;\n"
+		"       pxor 56(%3), %%mm7   ;\n"
+		"       movq %%mm5, 40(%0)   ;\n"
+		"       pxor 48(%4), %%mm6   ;\n"
+		"       pxor 56(%4), %%mm7   ;\n"
+		"       movq %%mm6, 48(%0)   ;\n"
+		"       movq %%mm7, 56(%0)   ;\n"
+	      
+		"       addl $64, %0         ;\n"
+		"       addl $64, %1         ;\n"
+		"       addl $64, %2         ;\n"
+		"       addl $64, %3         ;\n"
+		"       addl $64, %4         ;\n"
+		: "+r" (p1), "+r" (p2), "+r" (p3),
+		  "+r" (p4), "+r" (p5)
+		:
+		: "memory");
+	} while (--lines);
+	
 	kernel_fpu_end();
 }
 

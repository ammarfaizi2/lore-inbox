Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263328AbVFYEmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbVFYEmH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 00:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbVFYEmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 00:42:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:54963 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263328AbVFYElm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 00:41:42 -0400
Date: Sat, 25 Jun 2005 06:41:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050625044129.GA12440@elte.hu>
References: <20050608112801.GA31084@elte.hu> <200506212242.39113.gene.heskett@verizon.net> <20050622074054.GC16508@elte.hu> <200506220927.07874.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506220927.07874.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gene Heskett <gene.heskett@verizon.net> wrote:

> I can report that mode 4 is not at all well here.  I turned it on and 
> changed the extraversion, built it, and when it booted, it got to this 
> line and hung:
> 
> Checking to see if this processor honours the WP bit even in 
> supervisor mode... OK.

ok, could you try the patch below, ontop of whatever tree hung for you?

	Ingo

----
tree ca8b6bbafab35c5c1099c54696c36dc0b8c17cf7
parent 59a49e38711a146dc0bef4837c825b5422335460
author Linus Torvalds <torvalds@ppc970.osdl.org> Sat, 25 Jun 2005 00:39:17 -0700
committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat, 25 Jun 2005 00:39:17 -0700

Add "memory" clobbers to the x86 inline asm of strncmp and friends

They don't actually clobber memory, but gcc doesn't even know they
_read_ memory, so can apparently re-order memory accesses around them.

Which obviously does the wrong thing if the memory access happens to
change the memory that the compare function is accessing..

Verified to fix a strange boot problem by Jens Axboe.

 include/asm-i386/string.h |   32 ++++++++++++++++++++++----------
 1 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/asm-i386/string.h b/include/asm-i386/string.h
--- a/include/asm-i386/string.h
+++ b/include/asm-i386/string.h
@@ -116,7 +116,8 @@ __asm__ __volatile__(
 	"orb $1,%%al\n"
 	"3:"
 	:"=a" (__res), "=&S" (d0), "=&D" (d1)
-		     :"1" (cs),"2" (ct));
+	:"1" (cs),"2" (ct)
+	:"memory");
 return __res;
 }
 
@@ -138,8 +139,9 @@ __asm__ __volatile__(
 	"3:\tsbbl %%eax,%%eax\n\t"
 	"orb $1,%%al\n"
 	"4:"
-		     :"=a" (__res), "=&S" (d0), "=&D" (d1), "=&c" (d2)
-		     :"1" (cs),"2" (ct),"3" (count));
+	:"=a" (__res), "=&S" (d0), "=&D" (d1), "=&c" (d2)
+	:"1" (cs),"2" (ct),"3" (count)
+	:"memory");
 return __res;
 }
 
@@ -158,7 +160,9 @@ __asm__ __volatile__(
 	"movl $1,%1\n"
 	"2:\tmovl %1,%0\n\t"
 	"decl %0"
-	:"=a" (__res), "=&S" (d0) : "1" (s),"0" (c));
+	:"=a" (__res), "=&S" (d0)
+	:"1" (s),"0" (c)
+	:"memory");
 return __res;
 }
 
@@ -175,7 +179,9 @@ __asm__ __volatile__(
 	"leal -1(%%esi),%0\n"
 	"2:\ttestb %%al,%%al\n\t"
 	"jne 1b"
-	:"=g" (__res), "=&S" (d0), "=&a" (d1) :"0" (0),"1" (s),"2" (c));
+	:"=g" (__res), "=&S" (d0), "=&a" (d1)
+	:"0" (0),"1" (s),"2" (c)
+	:"memory");
 return __res;
 }
 
@@ -189,7 +195,9 @@ __asm__ __volatile__(
 	"scasb\n\t"
 	"notl %0\n\t"
 	"decl %0"
-	:"=c" (__res), "=&D" (d0) :"1" (s),"a" (0), "0" (0xffffffffu));
+	:"=c" (__res), "=&D" (d0)
+	:"1" (s),"a" (0), "0" (0xffffffffu)
+	:"memory");
 return __res;
 }
 
@@ -333,7 +341,9 @@ __asm__ __volatile__(
 	"je 1f\n\t"
 	"movl $1,%0\n"
 	"1:\tdecl %0"
-	:"=D" (__res), "=&c" (d0) : "a" (c),"0" (cs),"1" (count));
+	:"=D" (__res), "=&c" (d0)
+	:"a" (c),"0" (cs),"1" (count)
+	:"memory");
 return __res;
 }
 
@@ -369,7 +379,7 @@ __asm__ __volatile__(
 	"je 2f\n\t"
 	"stosb\n"
 	"2:"
-	: "=&c" (d0), "=&D" (d1)
+	:"=&c" (d0), "=&D" (d1)
 	:"a" (c), "q" (count), "0" (count/4), "1" ((long) s)
 	:"memory");
 return (s);	
@@ -392,7 +402,8 @@ __asm__ __volatile__(
 	"jne 1b\n"
 	"3:\tsubl %2,%0"
 	:"=a" (__res), "=&d" (d0)
-	:"c" (s),"1" (count));
+	:"c" (s),"1" (count)
+	:"memory");
 return __res;
 }
 /* end of additional stuff */
@@ -473,7 +484,8 @@ static inline void * memscan(void * addr
 		"dec %%edi\n"
 		"1:"
 		: "=D" (addr), "=c" (size)
-		: "0" (addr), "1" (size), "a" (c));
+		: "0" (addr), "1" (size), "a" (c)
+		: "memory");
 	return addr;
 }
 

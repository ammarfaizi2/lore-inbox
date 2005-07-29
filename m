Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVG2RS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVG2RS5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVG2RQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:16:48 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:37128 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S262620AbVG2RQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:16:34 -0400
Date: Fri, 29 Jul 2005 13:16:14 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Andrew Morton <akpm@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>, perex@suse.cz,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, rostedt@goodmis.org
Subject: Re: Linux 2.6.13-rc4 (snd-cs46xx)
In-Reply-To: <20050728213543.6264ca60.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0507291315010.869@lancer.cnet.absolutedigital.net>
References: <Pine.LNX.4.58.0507281625270.3307@g5.osdl.org>
 <Pine.LNX.4.61.0507282328520.966@lancer.cnet.absolutedigital.net>
 <20050728213543.6264ca60.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Andrew Morton wrote:

> The procfs inode IDR tree is scrogged.  I'd be suspecting a random memory
> scribble.  I'd suggest that you enable CONFIG_DEBUG_SLAB,
> CONFIG_DEBUG_PAGEALLOC, CONFIG_DEBUG_everything_else and retest.
> 
> If that doesn't show anything, try eliminating stuff from your kernel
> config.
> 
> If it _is_ a scribble then there's a good chance that changing the config
> will simply make it disappear, or will make it manifest in different ways.

Thanks Andrew! Indeed your suspicions are correct. Adding in all the 
debugging moved the problem around, it now shows itself when probing 
parport. Upon further investigation reverting the commit below seems to 
have nixed the problem.

thx,
-cp 

[PATCH] speed up on find_first_bit for i386 (let compiler do the work)

Avoid using "rep scas", just let the compiler select a sequence of
regular instructions.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

commit: cd85c8b4457a52d3545fdb9532082b2c1ebd5f21

--- ./include/asm-i386/bitops.h
+++ ./include/asm-i386/bitops.h
@@ -311,6 +311,20 @@ static inline int find_first_zero_bit(co
 int find_next_zero_bit(const unsigned long *addr, int size, int offset);
 
 /**
+ * __ffs - find first bit in word.
+ * @word: The word to search
+ *
+ * Undefined if no bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __ffs(unsigned long word)
+{
+	__asm__("bsfl %1,%0"
+		:"=r" (word)
+		:"rm" (word));
+	return word;
+}
+
+/**
  * find_first_bit - find the first set bit in a memory region
  * @addr: The address to start the search at
  * @size: The maximum size to search
@@ -320,22 +334,16 @@ int find_next_zero_bit(const unsigned lo
  */
 static inline int find_first_bit(const unsigned long *addr, unsigned size)
 {
-	int d0, d1;
-	int res;
-
-	/* This looks at memory. Mark it volatile to tell gcc not to move it around */
-	__asm__ __volatile__(
-		"xorl %%eax,%%eax\n\t"
-		"repe; scasl\n\t"
-		"jz 1f\n\t"
-		"leal -4(%%edi),%%edi\n\t"
-		"bsfl (%%edi),%%eax\n"
-		"1:\tsubl %%ebx,%%edi\n\t"
-		"shll $3,%%edi\n\t"
-		"addl %%edi,%%eax"
-		:"=a" (res), "=&c" (d0), "=&D" (d1)
-		:"1" ((size + 31) >> 5), "2" (addr), "b" (addr) : "memory");
-	return res;
+	int x = 0;
+	do {
+		if (*addr)
+			return __ffs(*addr) + x;
+		addr++;
+		if (x >= size)
+			break;
+		x += (sizeof(*addr)<<3);
+	} while (1);
+	return x;
 }
 
 /**
@@ -360,20 +368,6 @@ static inline unsigned long ffz(unsigned
 	return word;
 }
 
-/**
- * __ffs - find first bit in word.
- * @word: The word to search
- *
- * Undefined if no bit exists, so code should check against 0 first.
- */
-static inline unsigned long __ffs(unsigned long word)
-{
-	__asm__("bsfl %1,%0"
-		:"=r" (word)
-		:"rm" (word));
-	return word;
-}
-
 /*
  * fls: find last bit set.
  */

-- 
"Democracy can learn some things from Communism; for example,
   when a Communist politician is through, he is through."
                        -- Unknown

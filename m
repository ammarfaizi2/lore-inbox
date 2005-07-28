Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVG1Mqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVG1Mqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVG1Mqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:46:31 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:19174 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261406AbVG1Mpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:45:31 -0400
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
	the work)
From: Steven Rostedt <rostedt@goodmis.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Daniel Walker <dwalker@mvista.com>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1122551014.29823.205.camel@localhost.localdomain>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1122513928.29823.150.camel@localhost.localdomain>
	 <1122519999.29823.165.camel@localhost.localdomain>
	 <1122521538.29823.177.camel@localhost.localdomain>
	 <1122522328.29823.186.camel@localhost.localdomain>
	 <42E8564B.9070407@yahoo.com.au>
	 <1122551014.29823.205.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 28 Jul 2005 08:45:06 -0400
Message-Id: <1122554706.29823.228.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
>  static inline int find_first_bit(const unsigned long *addr, unsigned size)
>  {
[snip]
> +	int x = 0;
> +	do {
> +		if (*addr)
> +			return __ffs(*addr) + x;
> +		addr++;
> +		if (x >= size)
> +			break;
> +		x += 32;
The 32 looks like it may be problamatic.  Is there any i386 64 bit
machines.  Or is hard coding 32 OK?

> +	} while (1);
> +	return x;
>  }
>  

Just in case, I've updated the patch to use (sizeof(*addr)<<3)

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: vanilla_kernel/include/asm-i386/bitops.h
===================================================================
--- vanilla_kernel/include/asm-i386/bitops.h	(revision 263)
+++ vanilla_kernel/include/asm-i386/bitops.h	(working copy)
@@ -311,6 +311,20 @@
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
@@ -320,22 +334,16 @@
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
@@ -360,20 +368,6 @@
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



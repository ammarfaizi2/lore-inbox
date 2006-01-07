Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWAGDFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWAGDFd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 22:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWAGDFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 22:05:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28411 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030324AbWAGDFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 22:05:32 -0500
Date: Fri, 06 Jan 2006 22:04:34 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 06/21] mutex subsystem, add include/asm-arm/mutex.h
In-reply-to: <20060105153737.GG31013@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0601062149300.13870@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20060105153737.GG31013@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Ingo Molnar wrote:

> From: Nicolas Pitre <nico@cam.org>
> 
> add the ARM version of mutex.h, which is optimized in assembly for
> ARMv6, and uses the xchg implementation on pre-ARMv6.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Please consider the ARM cleanups below.  I was reviewing the generated 
code and found out that, from my original version, you changed:

	if (unlikely(__res | __ex_flag))

for:

	if (unlikely(__res || __ex_flag))

which produces worse code on ARM.  I therefore made it more explicit:

	__res |= __ex_flag;
	if (unlikely(__res != 0))

that the single | (bitwise or) was not a mistake.

I also made everything static inline rather than macros for better 
readability (both produce the same code after all).

And finally added missing \t from multi-line assembly code.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: linux-2.6/include/asm-arm/mutex.h
===================================================================
--- linux-2.6.orig/include/asm-arm/mutex.h
+++ linux-2.6/include/asm-arm/mutex.h
@@ -23,72 +23,71 @@
  * simply bail out immediately through the slow path where the lock will be
  * reattempted until it succeeds.
  */
-#define __mutex_fastpath_lock(count, fail_fn)				\
-do {									\
-	int __ex_flag, __res;						\
-									\
-	typecheck(atomic_t *, count);					\
-	typecheck_fn(fastcall void (*)(atomic_t *), fail_fn);		\
-									\
-	__asm__ (							\
-		"ldrex	%0, [%2]	\n"				\
-		"sub	%0, %0, #1	\n"				\
-		"strex	%1, %0, [%2]	\n"				\
-									\
-		: "=&r" (__res), "=&r" (__ex_flag)			\
-		: "r" (&(count)->counter)				\
-		: "cc","memory" );					\
-									\
-	if (unlikely(__res || __ex_flag))				\
-		fail_fn(count);						\
-} while (0)
-
-#define __mutex_fastpath_lock_retval(count, fail_fn)			\
-({									\
-	int __ex_flag, __res;						\
-									\
-	typecheck(atomic_t *, count);					\
-	typecheck_fn(fastcall int (*)(atomic_t *), fail_fn);		\
-									\
-	__asm__ (							\
-		"ldrex	%0, [%2]	\n"				\
-		"sub	%0, %0, #1	\n"				\
-		"strex	%1, %0, [%2]	\n"				\
-									\
-		: "=&r" (__res), "=&r" (__ex_flag)			\
-		: "r" (&(count)->counter)				\
-		: "cc","memory" );					\
-									\
-	__res |= __ex_flag;						\
-	if (unlikely(__res != 0))					\
-		__res = fail_fn(count);					\
-	__res;								\
-})
+static inline void
+__mutex_fastpath_lock(atomic_t *count, fastcall void (*fail_fn)(atomic_t *))
+{
+	int __ex_flag, __res;
+
+	__asm__ (
+
+		"ldrex	%0, [%2]	\n\t"
+		"sub	%0, %0, #1	\n\t"
+		"strex	%1, %0, [%2]	"
+
+		: "=&r" (__res), "=&r" (__ex_flag)
+		: "r" (&(count)->counter)
+		: "cc","memory" );
+
+	__res |= __ex_flag;
+	if (unlikely(__res != 0))
+		fail_fn(count);
+}
+
+static inline int
+__mutex_fastpath_lock_retval(atomic_t *count, fastcall int (*fail_fn)(atomic_t *))
+{
+	int __ex_flag, __res;
+
+	__asm__ (
+
+		"ldrex	%0, [%2]	\n\t"
+		"sub	%0, %0, #1	\n\t"
+		"strex	%1, %0, [%2]	"
+
+		: "=&r" (__res), "=&r" (__ex_flag)
+		: "r" (&(count)->counter)
+		: "cc","memory" );
+
+	__res |= __ex_flag;
+	if (unlikely(__res != 0))
+		__res = fail_fn(count);
+	return __res;
+}
 
 /*
  * Same trick is used for the unlock fast path. However the original value,
  * rather than the result, is used to test for success in order to have
  * better generated assembly.
  */
-#define __mutex_fastpath_unlock(count, fail_fn)				\
-do {									\
-	int __ex_flag, __res, __orig;					\
-									\
-	typecheck(atomic_t *, count);					\
-	typecheck_fn(fastcall void (*)(atomic_t *), fail_fn);		\
-									\
-	__asm__ (							\
-		"ldrex	%0, [%3]	\n"				\
-		"add	%1, %0, #1	\n"				\
-		"strex	%2, %1, [%3]	\n"				\
-									\
-		: "=&r" (__orig), "=&r" (__res), "=&r" (__ex_flag)	\
-		: "r" (&(count)->counter)				\
-		: "cc","memory" );					\
-									\
-	if (unlikely(__orig || __ex_flag))				\
-		fail_fn(count);						\
-} while (0)
+static inline void
+__mutex_fastpath_unlock(atomic_t *count, fastcall void (*fail_fn)(atomic_t *))
+{
+	int __ex_flag, __res, __orig;
+
+	__asm__ (
+
+		"ldrex	%0, [%3]	\n\t"
+		"add	%1, %0, #1	\n\t"
+		"strex	%2, %1, [%3]	"
+
+		: "=&r" (__orig), "=&r" (__res), "=&r" (__ex_flag)
+		: "r" (&(count)->counter)
+		: "cc","memory" );
+
+	__orig |= __ex_flag;
+	if (unlikely(__orig != 0))
+		fail_fn(count);
+}
 
 /*
  * If the unlock was done on a contended lock, or if the unlock simply fails
@@ -110,12 +109,12 @@ __mutex_fastpath_trylock(atomic_t *count
 
 	__asm__ (
 
-		"1: ldrex	%0, [%3]	\n"
-		"subs		%1, %0, #1	\n"
-		"strexeq	%2, %1, [%3]	\n"
-		"movlt		%0, #0		\n"
-		"cmpeq		%2, #0		\n"
-		"bgt		1b		\n"
+		"1: ldrex	%0, [%3]	\n\t"
+		"subs		%1, %0, #1	\n\t"
+		"strexeq	%2, %1, [%3]	\n\t"
+		"movlt		%0, #0		\n\t"
+		"cmpeq		%2, #0		\n\t"
+		"bgt		1b		"
 
 		: "=&r" (__orig), "=&r" (__res), "=&r" (__ex_flag)
 		: "r" (&count->counter)

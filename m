Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbVL2VEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbVL2VEk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 16:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVL2VEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 16:04:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54921 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750977AbVL2VEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 16:04:06 -0500
Date: Thu, 29 Dec 2005 22:03:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 04/13] mutex subsystem, add include/asm-x86_64/mutex.h
Message-ID: <20051229210346.GE665@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add the x86_64 version of mutex.h, optimized in assembly.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>

----

 include/asm-x86_64/mutex.h |   97 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+)

Index: linux/include/asm-x86_64/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-x86_64/mutex.h
@@ -0,0 +1,97 @@
+/*
+ * Assembly implementation of the mutex fastpath, based on atomic
+ * decrement/increment.
+ *
+ * started by Ingo Molnar:
+ *
+ *  Copyright (C) 2004, 2005 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ */
+#ifndef _ASM_MUTEX_H
+#define _ASM_MUTEX_H
+
+/**
+ * __mutex_fastpath_lock - decrement and call function if negative
+ * @v: pointer of type atomic_t
+ * @fn: function to call if the result is negative
+ *
+ * Atomically decrements @v and calls <fn> if the result is negative.
+ */
+#define __mutex_fastpath_lock(v, fn_name)				\
+do {									\
+	/* type-check the function too: */				\
+	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
+	unsigned long dummy;						\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, v);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK	"   decl (%%rdi)	\n"			\
+			"   js 2f		\n"			\
+			"1:			\n"			\
+									\
+		LOCK_SECTION_START("")					\
+			"2: call "#fn_name"	\n"			\
+			"   jmp 1b		\n"			\
+		LOCK_SECTION_END					\
+									\
+		:"=D" (dummy)						\
+		: "D" (v)						\
+		: "rax", "rsi", "rdx", "rcx",				\
+		  "r8", "r9", "r10", "r11", "memory");			\
+} while (0)
+
+/**
+ * __mutex_fastpath_unlock - increment and call function if nonpositive
+ * @v: pointer of type atomic_t
+ * @fn: function to call if the result is nonpositive
+ *
+ * Atomically increments @v and calls <fn> if the result is nonpositive.
+ */
+#define __mutex_fastpath_unlock(v, fn_name)				\
+do {									\
+	/* type-check the function too: */				\
+	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
+	unsigned long dummy;						\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, v);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK	"   incl (%%rdi)	\n"			\
+			"   jle 2f		\n"			\
+			"1:			\n"			\
+									\
+		LOCK_SECTION_START("")					\
+			"2: call "#fn_name"	\n"			\
+			"   jmp 1b		\n"			\
+		LOCK_SECTION_END					\
+									\
+		:"=D" (dummy)						\
+		: "D" (v)						\
+		: "rax", "rsi", "rdx", "rcx",				\
+		  "r8", "r9", "r10", "r11", "memory");			\
+} while (0)
+
+#define __mutex_slowpath_needs_to_unlock()	1
+
+/**
+ * __mutex_fastpath_trylock - try to acquire the mutex, without waiting
+ *
+ *  @count: pointer of type atomic_t
+ *  @fn: fallback function
+ *
+ * Change the count from 1 to 0 and return 1 (success), or return 0 (failure)
+ * if it wasn't 1 originally. [the fallback function is never used on
+ * x86_64, because all x86_64 CPUs have a CMPXCHG instruction.]
+ */
+static inline int
+__mutex_fastpath_trylock(atomic_t *count, int (*fn)(atomic_t *))
+{
+	if (likely(atomic_cmpxchg(count, 1, 0)) == 1)
+		return 1;
+	else
+		return 0;
+}
+
+#endif

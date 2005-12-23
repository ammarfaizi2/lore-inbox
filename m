Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030568AbVLWQTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030568AbVLWQTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 11:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVLWQSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 11:18:33 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51874 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932505AbVLWQSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 11:18:10 -0500
Date: Fri, 23 Dec 2005 17:17:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 04/11] mutex subsystem, add include/asm-x86_64/mutex.h
Message-ID: <20051223161723.GE26830@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add the x86_64 version of mutex.h, optimized in assembly.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>

----

 include/asm-x86_64/mutex.h |   74 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+)

Index: linux/include/asm-x86_64/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-x86_64/mutex.h
@@ -0,0 +1,74 @@
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
+		LOCK "decl (%%rdi)\n"					\
+		"js 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#fn_name"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=D" (dummy)						\
+		:"D" (v)						\
+		:"rax", "rsi", "rdx", "rcx",				\
+		 "r8", "r9", "r10", "r11", "memory");			\
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
+		LOCK "incl (%%rdi)\n"					\
+		"jle 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#fn_name"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=D" (dummy)						\
+		:"D" (v)						\
+		:"rax", "rsi", "rdx", "rcx",				\
+		 "r8", "r9", "r10", "r11", "memory");			\
+} while (0)
+
+#define __mutex_slowpath_needs_to_unlock()	1
+
+#endif

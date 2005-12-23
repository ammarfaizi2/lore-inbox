Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVLWQR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVLWQR5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 11:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVLWQR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 11:17:57 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42914 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932492AbVLWQR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 11:17:56 -0500
Date: Fri, 23 Dec 2005 17:17:17 +0100
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
Subject: [patch 03/11] mutex subsystem, add include/asm-i386/mutex.h
Message-ID: <20051223161717.GD26830@elte.hu>
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

add the i386 version of mutex.h, optimized in assembly.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-i386/mutex.h |  102 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 102 insertions(+)

Index: linux/include/asm-i386/mutex.h
===================================================================
--- /dev/null
+++ linux/include/asm-i386/mutex.h
@@ -0,0 +1,102 @@
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
+ *  __mutex_fastpath_lock - try to take the lock by moving the count
+ *                          from 1 to a 0 value
+ *  @count: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fn> if it
+ * wasn't 1 originally. This function MUST leave the value lower than 1
+ * even when the "1" assertion wasn't true.
+ */
+#define __mutex_fastpath_lock(count, fn_name)				\
+do {									\
+	/* type-check the function too: */				\
+	void fastcall (*__tmp)(atomic_t *) = fn_name;			\
+	unsigned int dummy;						\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, count);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK "decl (%%eax)\n"					\
+		"js 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#fn_name"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=a"(dummy)						\
+		:"a" (count)						\
+		:"memory", "ecx", "edx");				\
+} while (0)
+
+
+/**
+ *  __mutex_fastpath_lock_retval - try to take the lock by moving the count
+ *                                 from 1 to a 0 value
+ *  @count: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * Change the count from 1 to a value lower than 1, and call <fn> if it
+ * wasn't 1 originally. This function returns 0 if the fastpath succeeds,
+ * or anything the slow path function returns
+ */
+static inline int
+__mutex_fastpath_lock_retval(atomic_t *count,
+			     int fastcall (*fn_name)(atomic_t *))
+{
+	if (unlikely(atomic_dec_return(count) < 0))
+		return fn_name(count);
+	else
+		return 0;
+}
+
+/**
+ *  __mutex_fastpath_unlock - try to promote the mutex from 0 to 1
+ *  @count: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 0
+ *
+ * try to promote the mutex from 0 to 1. if it wasn't 0, call <fn>.
+ * In the failure case, this function is allowed to either set the value
+ * to 1, or to set it to a value lower than 1.
+ *
+ * If the implementation sets it to a value of lower than 1, the
+ * __mutex_slowpath_needs_to_unlock() macro needs to return 1, it needs
+ * to return 0 otherwise.
+ */
+#define __mutex_fastpath_unlock(count, fn_name)				\
+do {									\
+	/* type-check the function too: */				\
+	void fastcall (*__tmp)(atomic_t *) = fn_name;			\
+	unsigned int dummy;						\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, count);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK "incl (%%eax)\n"					\
+		"jle 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#fn_name"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:"=a" (dummy)						\
+		:"a" (count)						\
+		:"memory", "ecx", "edx");				\
+} while (0)
+
+#define __mutex_slowpath_needs_to_unlock()	1
+
+#endif

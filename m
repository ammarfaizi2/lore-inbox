Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbVLVXFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbVLVXFo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbVLVXFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:05:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:64730 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030358AbVLVXFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:05:36 -0500
Date: Fri, 23 Dec 2005 00:04:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 2/8] mutex subsystem, add asm-generic/mutex-[dec|xchg].h implementations
Message-ID: <20051222230451.GC13302@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add the two generic mutex fastpath implementations.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-generic/mutex-dec.h  |   66 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/mutex-xchg.h |   71 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)

Index: linux/include/asm-generic/mutex-dec.h
===================================================================
--- /dev/null
+++ linux/include/asm-generic/mutex-dec.h
@@ -0,0 +1,66 @@
+/*
+ * asm-generic/mutex-dec.h
+ *
+ * Generic wrappers for the mutex fastpath based on an xchg() implementation
+ *
+ */
+#ifndef _ASM_GENERIC_MUTEX_DEC_H
+#define _ASM_GENERIC_MUTEX_DEC_H
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
+	if (unlikely(atomic_dec_return(count) < 0))			\
+		fn_name(count);						\
+} while (0)
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
+			     int (*fn_name)(atomic_t *))
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
+ *  @fn: function to call if the original value was not 1
+ *
+ * try to promote the mutex from 0 to 1. if it wasn't 0, call <function>
+ * In the failure case, this function is allowed to either set the value to
+ * 1, or to set it to a value lower than one.
+ * If the implementation sets it to a value of lower than one, the
+ * __mutex_slowpath_needs_to_unlock() macro needs to return 1, it needs
+ * to return 0 otherwise.
+ */
+#define __mutex_fastpath_unlock(count, fn_name)				\
+do {									\
+	if (unlikely(atomic_inc_return(count) <= 0))			\
+		fn_name(count);						\
+} while (0)
+
+#define __mutex_slowpath_needs_to_unlock()		1
+
+#endif
Index: linux/include/asm-generic/mutex-xchg.h
===================================================================
--- /dev/null
+++ linux/include/asm-generic/mutex-xchg.h
@@ -0,0 +1,71 @@
+/*
+ * asm-generic/mutex-xchg.h
+ *
+ * Generic wrappers for the mutex fastpath based on an xchg() implementation
+ *
+ * NOTE: An xchg based implementation is less optimal than a
+ *       decrement/increment based implementation. If your architecture
+ *       has a reasonable atomic dec/inc then don't use this file, use
+ *       mutex-dec.h instead!
+ */
+#ifndef _ASM_GENERIC_MUTEX_XCHG_H
+#define _ASM_GENERIC_MUTEX_XCHG_H
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
+	if (unlikely(atomic_xchg(count, 0) != 1))			\
+		fn_name(count);						\
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
+			     int (*fn_name)(atomic_t *))
+{
+	if (unlikely(atomic_xchg(count, 0) != 1))
+		return fn_name(count);
+	else
+		return 0;
+}
+
+/**
+ *  __mutex_fastpath_unlock - try to promote the mutex from 0 to 1
+ *  @count: pointer of type atomic_t
+ *  @fn: function to call if the original value was not 1
+ *
+ * try to promote the mutex from 0 to 1. if it wasn't 0, call <function>
+ * In the failure case, this function is allowed to either set the value to
+ * 1, or to set it to a value lower than one.
+ * If the implementation sets it to a value of lower than one, the
+ * __mutex_slowpath_needs_to_unlock() macro needs to return 1, it needs
+ * to return 0 otherwise.
+ */
+#define __mutex_fastpath_unlock(count, fn_name)				\
+do {									\
+	if (unlikely(atomic_xchg(count, 1) != 0))			\
+		fn_name(count);						\
+} while (0)
+
+#define __mutex_slowpath_needs_to_unlock()		0
+
+#endif

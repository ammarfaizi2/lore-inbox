Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVLUP4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVLUP4O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 10:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVLUPzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 10:55:53 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:52891 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932456AbVLUPzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 10:55:42 -0500
Date: Wed, 21 Dec 2005 16:54:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: [patch 3/8] mutex subsystem, add atomic_*_call_if_*() to i386
Message-ID: <20051221155442.GD7243@elte.hu>
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

add two new atomic ops to i386: atomic_dec_call_if_negative() and
atomic_inc_call_if_nonpositive(), which are conditional-call-if
atomic operations. Needed by the new mutex code.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-i386/atomic.h |   55 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+)

Index: linux/include/asm-i386/atomic.h
===================================================================
--- linux.orig/include/asm-i386/atomic.h
+++ linux/include/asm-i386/atomic.h
@@ -240,6 +240,61 @@ static __inline__ int atomic_sub_return(
 #define atomic_inc_return(v)  (atomic_add_return(1,v))
 #define atomic_dec_return(v)  (atomic_sub_return(1,v))
 
+/**
+ * atomic_dec_call_if_negative - decrement and call function if negative
+ * @v: pointer of type atomic_t
+ * @fn: function to call if the result is negative
+ *
+ * Atomically decrements @v and calls a function if the result is negative.
+ */
+#define atomic_dec_call_if_negative(v, fn_name)				\
+do {									\
+	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, v);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK "decl (%%eax)\n"  					\
+		"js 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#fn_name"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:							\
+		:"a" (v)						\
+		:"memory","cx","dx");					\
+} while (0)
+
+/**
+ * atomic_inc_call_if_nonpositive - increment and call function if nonpositive
+ * @v: pointer of type atomic_t
+ * @fn: function to call if the result is nonpositive
+ *
+ * Atomically increments @v and calls a function if the result is nonpositive.
+ */
+#define atomic_inc_call_if_nonpositive(v, fn_name)			\
+do {									\
+	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
+									\
+	(void)__tmp;							\
+	typecheck(atomic_t *, v);					\
+									\
+	__asm__ __volatile__(						\
+		LOCK "incl (%%eax)\n"  					\
+		"jle 2f\n"						\
+		"1:\n"							\
+		LOCK_SECTION_START("")					\
+		"2: call "#fn_name"\n\t"				\
+		"jmp 1b\n"						\
+		LOCK_SECTION_END					\
+		:							\
+		:"a" (v)						\
+		:"memory","cx","dx");					\
+} while (0)
+
+
 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr) \
 __asm__ __volatile__(LOCK "andl %0,%1" \

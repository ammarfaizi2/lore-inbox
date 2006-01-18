Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWARGgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWARGgj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 01:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWARGgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 01:36:39 -0500
Received: from ns.suse.de ([195.135.220.2]:13287 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751349AbWARGgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 01:36:38 -0500
Date: Wed, 18 Jan 2006 07:36:37 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch 1/2] atomic_add_unless sadness
Message-ID: <20060118063636.GA14608@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason gcc 4 on at least i386 and ppc64 (that I have tested with)
emit two cmpxchges for atomic_add_unless unless we put branch hints in.
(it is unlikely for the "unless" case to trigger, and it is unlikely for
cmpxchg to fail).

So put these hints in for architectures which have a native cas, and
make the loop a bit more readable in the process.

So this patch isn't for inclusion just yet (incomplete, not widely tested),
however hopefully we can get some discussion about the best way to implement
this.

Index: linux-2.6/include/asm-i386/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-i386/atomic.h
+++ linux-2.6/include/asm-i386/atomic.h
@@ -231,9 +231,15 @@ static __inline__ int atomic_sub_return(
 ({								\
 	int c, old;						\
 	c = atomic_read(v);					\
-	while (c != (u) && (old = atomic_cmpxchg((v), c, c + (a))) != c) \
+	for (;;) {						\
+		if (unlikely(c == (u)))				\
+			break;					\
+		old = atomic_cmpxchg((v), c, c + (a));		\
+		if (likely(old == c))				\
+			break;					\
 		c = old;					\
-	c != (u);						\
+	}							\
+	likely(c != (u));					\
 })
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
Index: linux-2.6/include/asm-ia64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/atomic.h
+++ linux-2.6/include/asm-ia64/atomic.h
@@ -95,9 +95,15 @@ ia64_atomic64_sub (__s64 i, atomic64_t *
 ({								\
 	int c, old;						\
 	c = atomic_read(v);					\
-	while (c != (u) && (old = atomic_cmpxchg((v), c, c + (a))) != c) \
+	for (;;) {						\
+		if (unlikely(c == (u)))				\
+			break;					\
+		old = atomic_cmpxchg((v), c, c + (a));		\
+		if (likely(old == c))				\
+			break;					\
 		c = old;					\
-	c != (u);						\
+	}							\
+	likely(c != (u));					\
 })
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
Index: linux-2.6/include/asm-x86_64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/atomic.h
+++ linux-2.6/include/asm-x86_64/atomic.h
@@ -405,9 +405,15 @@ static __inline__ long atomic64_sub_retu
 ({								\
 	int c, old;						\
 	c = atomic_read(v);					\
-	while (c != (u) && (old = atomic_cmpxchg((v), c, c + (a))) != c) \
+	for (;;) {						\
+		if (unlikely(c == (u)))				\
+			break;					\
+		old = atomic_cmpxchg((v), c, c + (a));		\
+		if (likely(old == c))				\
+			break;					\
 		c = old;					\
-	c != (u);						\
+	}							\
+	likely(c != (u));					\
 })
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
Index: linux-2.6/include/asm-s390/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-s390/atomic.h
+++ linux-2.6/include/asm-s390/atomic.h
@@ -89,11 +89,16 @@ static __inline__ int atomic_cmpxchg(ato
 static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
-
 	c = atomic_read(v);
-	while (c != u && (old = atomic_cmpxchg(v, c, c + a)) != c)
+	for (;;) {
+		if (unlikely(c == u))
+			break;
+		old = atomic_cmpxchg(v, c, c + a);
+		if (likely(old == c))
+			break;
 		c = old;
-	return c != u;
+	}
+	return likely(c != u);
 }
 
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
Index: linux-2.6/include/asm-sparc64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/atomic.h
+++ linux-2.6/include/asm-sparc64/atomic.h
@@ -78,9 +78,15 @@ extern int atomic64_sub_ret(int, atomic6
 ({								\
 	int c, old;						\
 	c = atomic_read(v);					\
-	while (c != (u) && (old = atomic_cmpxchg((v), c, c + (a))) != c) \
+	for (;;) {						\
+		if (unlikely(c == (u)))				\
+			break;					\
+		old = atomic_cmpxchg((v), c, c + (a));		\
+		if (likely(old == c))				\
+			break;					\
 		c = old;					\
-	c != (u);						\
+	}							\
+	likely(c != (u));					\
 })
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
Index: linux-2.6/include/asm-m68k/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/atomic.h
+++ linux-2.6/include/asm-m68k/atomic.h
@@ -146,9 +146,15 @@ static inline void atomic_set_mask(unsig
 ({								\
 	int c, old;						\
 	c = atomic_read(v);					\
-	while (c != (u) && (old = atomic_cmpxchg((v), c, c + (a))) != c) \
+	for (;;) {						\
+		if (unlikely(c == (u)))				\
+			break;					\
+		old = atomic_cmpxchg((v), c, c + (a));		\
+		if (likely(old == c))				\
+			break;					\
 		c = old;					\
-	c != (u);						\
+	}							\
+	likely(c != (u));					\
 })
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 

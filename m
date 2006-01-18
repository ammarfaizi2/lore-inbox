Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWARGjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWARGjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 01:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWARGjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 01:39:23 -0500
Received: from ns1.suse.de ([195.135.220.2]:34023 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751351AbWARGjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 01:39:22 -0500
Date: Wed, 18 Jan 2006 07:39:21 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch 2/2] powerpc: native atomic_add_unless
Message-ID: <20060118063921.GB14608@wotan.suse.de>
References: <20060118063636.GA14608@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118063636.GA14608@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't convert LL/SC architectures so as to "encourage" them
to do atomic_add_unless natively. Here is my probably-wrong attempt
for powerpc.

Should I bring this up on the arch list? (IIRC cross posting 
between there and lkml is discouraged)

Index: linux-2.6/include/asm-powerpc/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/atomic.h
+++ linux-2.6/include/asm-powerpc/atomic.h
@@ -8,6 +8,7 @@
 typedef struct { volatile int counter; } atomic_t;
 
 #ifdef __KERNEL__
+#include <linux/compiler.h>
 #include <asm/synch.h>
 #include <asm/asm-compat.h>
 
@@ -176,20 +177,30 @@ static __inline__ int atomic_dec_return(
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns non-zero if @v was not @u, and zero otherwise.
  */
-#define atomic_add_unless(v, a, u)			\
-({							\
-	int c, old;					\
-	c = atomic_read(v);				\
-	for (;;) {					\
-		if (unlikely(c == (u)))			\
-			break;				\
-		old = atomic_cmpxchg((v), c, c + (a));	\
-		if (likely(old == c))			\
-			break;				\
-		c = old;				\
-	}						\
-	c != (u);					\
-})
+static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
+{
+	int t;
+	int dummy;
+
+	__asm__ __volatile__ (
+	LWSYNC_ON_SMP
+"1:	lwarx	%0,0,%2		# atomic_add_unless\n\
+	cmpw	0,%0,%4 \n\
+	beq-	2f \n\
+	add	%1,%3,%0 \n"
+	PPC405_ERR77(0,%2)
+"	stwcx.	%1,0,%2 \n\
+	bne-	1b \n"
+	ISYNC_ON_SMP
+	"\n\
+2:"
+	: "=&r" (t), "=&r" (dummy)
+	: "r" (&v->counter), "r" (a), "r" (u)
+	: "cc", "memory");
+
+	return likely(t != u);
+}
+
 #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
 
 #define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)

Return-Path: <linux-kernel-owner+w=401wt.eu-S1030374AbXALBpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbXALBpz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 20:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbXALBpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 20:45:55 -0500
Received: from tomts10-srv.bellnexxia.net ([209.226.175.54]:42885 "EHLO
	tomts10-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932654AbXALBpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 20:45:54 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [PATCH 07/09] atomic.h : Add atomic64 cmpxchg, xchg and add_unless to powerpc
Date: Thu, 11 Jan 2007 20:35:39 -0500
Message-Id: <1168565743571-git-send-email-mathieu.desnoyers@polymtl.ca>
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <11685657414033-git-send-email-mathieu.desnoyers@polymtl.ca>
References: <11685657414033-git-send-email-mathieu.desnoyers@polymtl.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

atomic.h : Add atomic64 cmpxchg, xchg and add_unless to powerpc

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-powerpc/atomic.h
+++ b/include/asm-powerpc/atomic.h
@@ -165,7 +165,8 @@ static __inline__ int atomic_dec_return(atomic_t *v)
 	return t;
 }
 
-#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_cmpxchg(v, o, n) \
+	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
@@ -411,6 +412,43 @@ static __inline__ long atomic64_dec_if_positive(atomic64_t *v)
 	return t;
 }
 
+#define atomic64_cmpxchg(v, o, n) \
+	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
+#define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
+
+/**
+ * atomic64_add_unless - add unless the number is a given value
+ * @v: pointer of type atomic64_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as it was not @u.
+ * Returns non-zero if @v was not @u, and zero otherwise.
+ */
+static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
+{
+	long t;
+
+	__asm__ __volatile__ (
+	LWSYNC_ON_SMP
+"1:	ldarx	%0,0,%1		# atomic_add_unless\n\
+	cmpd	0,%0,%3 \n\
+	beq-	2f \n\
+	add	%0,%2,%0 \n"
+"	stdcx.	%0,0,%1 \n\
+	bne-	1b \n"
+	ISYNC_ON_SMP
+"	subf	%0,%2,%0 \n\
+2:"
+	: "=&r" (t)
+	: "r" (&v->counter), "r" (a), "r" (u)
+	: "cc", "memory");
+
+	return t != u;
+}
+
+#define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
+
 #endif /* __powerpc64__ */
 
 #include <asm-generic/atomic.h>

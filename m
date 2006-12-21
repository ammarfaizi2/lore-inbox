Return-Path: <linux-kernel-owner+w=401wt.eu-S1161064AbWLUAMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbWLUAMJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWLUAMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:12:08 -0500
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:60802 "EHLO
	tomts20-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161064AbWLUAMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:12:07 -0500
Date: Wed, 20 Dec 2006 19:12:04 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, paulus@samba.org
Cc: ltt-dev@shafik.org, systemtap@sources.redhat.com, linuxppc-dev@ozlabs.org,
       Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 7/9] atomic.h : powerpc
Message-ID: <20061221001204.GM28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061221000351.GF28643@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:11:11 up 119 days, 21:18,  6 users,  load average: 2.22, 1.93, 1.42
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

64 bits cmpxchg, xchg and add_unless for powerpc.


Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-powerpc/atomic.h
+++ b/include/asm-powerpc/atomic.h
@@ -165,7 +165,8 @@ static __inline__ int atomic_dec_return(
 	return t;
 }
 
-#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_cmpxchg(v, o, n) \
+	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
@@ -411,6 +412,44 @@ static __inline__ long atomic64_dec_if_p
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
+	PPC405_ERR77(0,%2)
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

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

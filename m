Return-Path: <linux-kernel-owner+w=401wt.eu-S1161060AbWLUAIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbWLUAIQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWLUAIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:08:16 -0500
Received: from tomts20.bellnexxia.net ([209.226.175.74]:60371 "EHLO
	tomts20-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161063AbWLUAIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:08:15 -0500
Date: Wed, 20 Dec 2006 19:08:12 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>
Cc: ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/9] atomic.h : i386 "64 bits" ready fix.
Message-ID: <20061221000812.GI28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061221000351.GF28643@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:07:07 up 119 days, 21:14,  6 users,  load average: 1.43, 1.48, 1.17
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the cmpxchg, xchg and add_unless atomic operations on i386 so
they will still work if, for instance, they are cut'n'pasted to operate of
atomic64_t types. The correct fix might be to create inline functions for
cmpxchg for every architecture, but until then, it looks safer to put this kind
of automatic typing instead of using an integer.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-i386/atomic.h
+++ b/include/asm-i386/atomic.h
@@ -207,8 +207,9 @@ static __inline__ int atomic_sub_return(
 	return atomic_add_return(-i,v);
 }
 
-#define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define atomic_cmpxchg(v, old, new) \
+	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (old), (new)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), (new)))
 
 /**
  * atomic_add_unless - add unless the number is a given value
@@ -221,7 +222,7 @@ #define atomic_xchg(v, new) (xchg(&((v)-
  */
 #define atomic_add_unless(v, a, u)				\
 ({								\
-	int c, old;						\
+	__typeof__((v)->counter) c, old;			\
 	c = atomic_read(v);					\
 	for (;;) {						\
 		if (unlikely(c == (u)))				\

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

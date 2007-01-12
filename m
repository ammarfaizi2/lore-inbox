Return-Path: <linux-kernel-owner+w=401wt.eu-S932824AbXALBl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbXALBl1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 20:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbXALBlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 20:41:19 -0500
Received: from tomts22.bellnexxia.net ([209.226.175.184]:60868 "EHLO
	tomts22-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932640AbXALBky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 20:40:54 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [PATCH 03/09] atomic.h : i386 type safety fix
Date: Thu, 11 Jan 2007 20:35:35 -0500
Message-Id: <11685657424173-git-send-email-mathieu.desnoyers@polymtl.ca>
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <11685657414033-git-send-email-mathieu.desnoyers@polymtl.ca>
References: <11685657414033-git-send-email-mathieu.desnoyers@polymtl.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

atomic.h : i386 type safety fix

This patch removes an explicit cast to an integer type for the result returned
by cmpxchg. It is not per se a problem on the i386 architecture, because
sizeof(int) == sizeof(long), but whenever this code is cut'n'pasted to a
different architecture (which happened at least for x86_64), it would simply
accept passing an atomic64_t value as parameter to cmpxchg, xchg and
add_unless, having 64 bits inputs casted to 32 bits.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-i386/atomic.h
+++ b/include/asm-i386/atomic.h
@@ -207,8 +207,9 @@ static __inline__ int atomic_sub_return(int i, atomic_t *v)
 	return atomic_add_return(-i,v);
 }
 
-#define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define atomic_cmpxchg(v, old, new) \
+	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (old), (new)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), (new)))
 
 /**
  * atomic_add_unless - add unless the number is a given value
@@ -221,7 +222,7 @@ static __inline__ int atomic_sub_return(int i, atomic_t *v)
  */
 #define atomic_add_unless(v, a, u)				\
 ({								\
-	int c, old;						\
+	__typeof__((v)->counter) c, old;			\
 	c = atomic_read(v);					\
 	for (;;) {						\
 		if (unlikely(c == (u)))				\

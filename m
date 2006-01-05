Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWAEXGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWAEXGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWAEXGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:06:46 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:23211 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932249AbWAEXGp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:06:45 -0500
Message-ID: <43BDA672.4090704@austin.ibm.com>
Date: Thu, 05 Jan 2006 17:06:26 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>,
       PPC64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <20060105143502.GA16816@elte.hu> <43BD4C66.60001@austin.ibm.com> <20060105222106.GA26474@elte.hu>
In-Reply-To: <20060105222106.GA26474@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------000402040707040807030009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000402040707040807030009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> ISYNC_ON_SMP flushes all speculative reads currently in the queue - and 
> is hence a smp_rmb_backwards() primitive [per my previous mail] - but 
> does not affect writes - correct?
> 
> if that's the case, what prevents a store from within the critical 
> section going up to right after the EIEIO_ON_SMP, but before the 
> atomic-dec instructions? Does any of those instructions imply some 
> barrier perhaps? Are writes always ordered perhaps (like on x86 CPUs), 
> and hence the store before the bne is an effective write-barrier?

It really makes more sense after reading PowerPC Book II, which you can find at 
this link, it was written by people who explain this for a living: 
http://www-128.ibm.com/developerworks/eserver/articles/archguide.html

While isync technically doesn't order stores it does order instructions.  The 
previous bne- must complete, that bne- is dependent on the previous stwcx being 
complete.  So no stores are slipping up.  To get a better explanation you will 
have to read the document yourself.

Here is a first pass at a powerpc file for the fast paths just as an FYI/RFC. 
It is completely untested, but compiles.

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>




--------------000402040707040807030009
Content-Type: text/plain;
 name="powerpcmutex.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="powerpcmutex.patch"

Index: 2.6.15-mutex14/include/asm-powerpc/mutex.h
===================================================================
--- 2.6.15-mutex14.orig/include/asm-powerpc/mutex.h	2006-01-04 14:46:31.%N -0600
+++ 2.6.15-mutex14/include/asm-powerpc/mutex.h	2006-01-05 16:25:41.%N -0600
@@ -1,9 +1,83 @@
 /*
- * Pull in the generic implementation for the mutex fastpath.
+ * include/asm-powerpc/mutex.h
  *
- * TODO: implement optimized primitives instead, or leave the generic
- * implementation in place, or pick the atomic_xchg() based generic
- * implementation. (see asm-generic/mutex-xchg.h for details)
+ * PowerPC optimized mutex locking primitives
+ *
+ * Please look into asm-generic/mutex-xchg.h for a formal definition.
+ * Copyright (C) 2006 Joel Schopp <jschopp@austin.ibm.com>, IBM
  */
+#ifndef _ASM_MUTEX_H
+#define _ASM_MUTEX_H
+#define __mutex_fastpath_lock(count, fail_fn)\
+do{                                     \
+	long tmp;                       \
+	__asm__ __volatile__(		\
+"1:	lwarx		%0,0,%1\n"      \
+"	addic	        %0,%0,-1\n"     \
+"	stwcx.          %0,0,%1\n"      \
+"	bne-            1b\n"           \
+"	isync           \n"             \
+	: "=&r" (tmp)                   \
+	: "r" (&(count)->counter)       \
+	: "cr0", "memory");             \
+	if (unlikely(tmp < 0))          \
+		fail_fn(count);         \
+} while (0)                              
+
+#define __mutex_fastpath_unlock(count, fail_fn)\
+do{                                         \
+	long tmp;                           \
+	__asm__ __volatile__(SYNC_ON_SMP    \
+"1:	lwarx		%0,0,%1\n"          \
+"	addic	        %0,%0,1\n"          \
+"	stwcx.          %0,0,%1\n"          \
+"       bne-            1b\n"               \
+	: "=&r" (tmp)                       \
+	: "r" (&(count)->counter)           \
+	: "cr0", "memory");                 \
+	if (unlikely(tmp <= 0))             \
+		fail_fn(count);             \
+} while (0)
+
+
+static inline int 
+__mutex_fastpath_trylock(atomic_t* count, int (*fail_fn)(atomic_t*))
+{
+	long tmp;
+	__asm__ __volatile__(
+"1:     lwarx		%0,0,%1\n"
+"       cmpwi           0,%0,1\n"
+"       bne-            2f\n"
+"       stwcx.          %0,0,%1\n"
+"	bne-		1b\n"
+"	isync\n"
+"2:"
+	: "=&r" (tmp)
+	: "r" (&(count)->counter)
+	: "cr0", "memory");
+
+	return (int)tmp;
+
+}
+
+#define __mutex_slowpath_needs_to_unlock()		1
 
-#include <asm-generic/mutex-dec.h>
+static inline int 
+__mutex_fastpath_lock_retval(atomic_t* count, int (*fail_fn)(atomic_t *))
+{
+	long tmp;
+	__asm__ __volatile__(
+"1:	lwarx		%0,0,%1\n"
+"	addic	        %0,%0,-1\n"
+"	stwcx.          %0,0,%1\n"
+"	bne-            1b\n"
+"	isync           \n"
+	: "=&r" (tmp)
+	: "r" (&(count)->counter)
+	: "cr0", "memory");
+	if (unlikely(tmp < 0))
+		return fail_fn(count);
+	else
+		return 0;
+}
+#endif

--------------000402040707040807030009--

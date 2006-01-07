Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030513AbWAGRte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbWAGRte (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 12:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030517AbWAGRte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 12:49:34 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59278 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030513AbWAGRtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 12:49:33 -0500
Message-ID: <43BFFF1D.7030007@austin.ibm.com>
Date: Sat, 07 Jan 2006 11:49:17 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
CC: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>,
       PPC64-dev <linuxppc64-dev@ozlabs.org>
Subject: PowerPC fastpaths for mutex subsystem
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <20060105143502.GA16816@elte.hu> <43BD4C66.60001@austin.ibm.com> <20060105222106.GA26474@elte.hu> <43BDA672.4090704@austin.ibm.com> <20060106002919.GA29190@pb15.lixom.net>
In-Reply-To: <20060106002919.GA29190@pb15.lixom.net>
Content-Type: multipart/mixed;
 boundary="------------020807010105030907030001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020807010105030907030001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is the second pass at optimizing the fastpath for the new mutex subsystem 
on PowerPC.  I think it is ready to be included in the series with the other 
mutex patches now.  Tested on a 4 core (2 SMT threads/core) Power5 machine with 
gcc 3.3.2.

Test results from synchro-test.ko:

All tests run for default 5 seconds
Threads semaphores  mutexes     mutexes+attached
1       63,465,364  58,404,630  62,109,571
4       58,424,282  35,541,297  37,820,794
8       40,731,668  35,541,297  40,281,768
16      38,372,769  37,256,298  41,751,764
32      38,406,895  36,933,675  38,731,571
64      37,232,017  36,222,480  40,766,379

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>

--------------020807010105030907030001
Content-Type: text/plain;
 name="powerpcmutex.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="powerpcmutex.patch"

Index: 2.6.15-mutex14/include/asm-powerpc/mutex.h
===================================================================
--- 2.6.15-mutex14.orig/include/asm-powerpc/mutex.h	2006-01-04 14:46:31.%N -0600
+++ 2.6.15-mutex14/include/asm-powerpc/mutex.h	2006-01-06 17:36:09.%N -0600
@@ -1,9 +1,84 @@
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
+do{					\
+	int tmp;			\
+	__asm__ __volatile__(		\
+"1:	lwarx		%0,0,%1\n"	\
+"	addic		%0,%0,-1\n"	\
+"	stwcx.		%0,0,%1\n"	\
+"	bne-		1b\n"		\
+	ISYNC_ON_SMP			\
+	: "=&r" (tmp)			\
+	: "r" (&(count)->counter)	\
+	: "cr0", "memory");		\
+	if (unlikely(tmp < 0))		\
+		fail_fn(count);		\
+} while (0)
+
+#define __mutex_fastpath_unlock(count, fail_fn)\
+do{					\
+	int tmp;			\
+	__asm__ __volatile__(SYNC_ON_SMP\
+"1:	lwarx		%0,0,%1\n"	\
+"	addic		%0,%0,1\n"	\
+"	stwcx.		%0,0,%1\n"	\
+"	bne-		1b\n"		\
+	: "=&r" (tmp)			\
+	: "r" (&(count)->counter)	\
+	: "cr0", "memory");		\
+	if (unlikely(tmp <= 0))		\
+		fail_fn(count);		\
+} while (0)
+
+
+static inline int
+__mutex_fastpath_trylock(atomic_t* count, int (*fail_fn)(atomic_t*))
+{
+	int tmp;
+	__asm__ __volatile__(
+"1:	lwarx		%0,0,%1\n"
+"	cmpwi		0,%0,1\n"
+"	bne-		2f\n"
+"	addic		%0,%0,-1\n"
+"	stwcx.		%0,0,%1\n"
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
+	int tmp;
+	__asm__ __volatile__(
+"1:	lwarx		%0,0,%1\n"
+"	addic		%0,%0,-1\n"
+"	stwcx.		%0,0,%1\n"
+"	bne-		1b\n"
+"	isync		\n"
+	: "=&r" (tmp)
+	: "r" (&(count)->counter)
+	: "cr0", "memory");
+	if (unlikely(tmp < 0))
+		return fail_fn(count);
+	else
+		return 0;
+}
+#endif

--------------020807010105030907030001--

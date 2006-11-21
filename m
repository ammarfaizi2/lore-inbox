Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031038AbWKUP7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031038AbWKUP7r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 10:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031039AbWKUP7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 10:59:46 -0500
Received: from mathups.math.u-psud.fr ([129.175.52.4]:26599 "EHLO
	matups.math.u-psud.fr") by vger.kernel.org with ESMTP
	id S1031038AbWKUP7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 10:59:45 -0500
From: Duncan Sands <baldrick@free.fr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix asm constraints in i386 atomic_add_return
Date: Tue, 21 Nov 2006 16:59:05 +0100
User-Agent: KMail/1.9.5
Cc: Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KJyYF5dtMnD/Os4"
Message-Id: <200611211659.06576.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_KJyYF5dtMnD/Os4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Since v->counter is both read and written, it should be an
output as well as an input for the asm.  The current code
only gets away with this because counter is volatile.  Also,
according to Documents/atomic_ops.txt, atomic_add_return
should provide a memory barrier, in particular a compiler
barrier, so the asm should be marked as clobbering memory.
Test case attached.

Signed-off-by: Duncan Sands <baldrick@free.fr>

diff --git a/include/asm-i386/atomic.h b/include/asm-i386/atomic.h
index 51a1662..6aab7a1 100644
--- a/include/asm-i386/atomic.h
+++ b/include/asm-i386/atomic.h
@@ -187,9 +187,9 @@ static __inline__ int atomic_add_return(
 	/* Modern 486+ processor */
 	__i = i;
 	__asm__ __volatile__(
-		LOCK_PREFIX "xaddl %0, %1;"
-		:"=r"(i)
-		:"m"(v->counter), "0"(i));
+		LOCK_PREFIX "xaddl %0, %1"
+		:"+r" (i), "+m" (v->counter)
+		: : "memory");
 	return i + __i;
 
 #ifdef CONFIG_M386

--Boundary-00=_KJyYF5dtMnD/Os4
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="t.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="t.c"

#include <stdio.h>

typedef struct { int counter; } atomic_t; /* NB: no "volatile" */

#define ATOMIC_INIT(i)	{ (i) }

#define atomic_read(v)		((v)->counter)

static __inline__ int atomic_add_return(int i, atomic_t *v)
{
	int __i = i;

	__asm__ __volatile__(
		"lock; xaddl %0, %1;"
		:"=r"(i)
		:"m"(v->counter), "0"(i));
/*	__asm__ __volatile__(
		"lock; xaddl %0, %1"
		:"+r" (i), "+m" (v->counter)
		: : "memory"); */
	return i + __i;
}

int main (void) {
	atomic_t a = ATOMIC_INIT(0);
	int x;

	x = atomic_add_return (1, &a);
	if ((x!=1) || (atomic_read(&a)!=1))
		printf("fail: %i, %i\n", x, atomic_read(&a));
}

--Boundary-00=_KJyYF5dtMnD/Os4--

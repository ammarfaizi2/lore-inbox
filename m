Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129666AbRBTExy>; Mon, 19 Feb 2001 23:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129711AbRBTExp>; Mon, 19 Feb 2001 23:53:45 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:34055 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129666AbRBTExg>; Mon, 19 Feb 2001 23:53:36 -0500
Date: Mon, 19 Feb 2001 23:53:29 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: "Brian J. Watson" <Brian.J.Watson@compaq.com>
cc: <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] trylock for rw_semaphores: 2.4.1
In-Reply-To: <3A91DF45.593860E4@compaq.com>
Message-ID: <Pine.LNX.4.30.0102192346410.27247-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Brian J. Watson wrote:

> Here is an x86 implementation of down_read_trylock() and down_write_trylock()
> for read/write semaphores. As with down_trylock() for exclusive semaphores, they
> don't block if they fail to get the lock. They just return 1, as opposed to 0 in
> the success case.

How about the following instead?  Warning: compiled, not tested.

		-ben

diff -ur v2.4.2-pre3/include/asm-i386/semaphore.h trylock/include/asm-i386/semaphore.h
--- v2.4.2-pre3/include/asm-i386/semaphore.h	Mon Feb 12 16:04:59 2001
+++ trylock/include/asm-i386/semaphore.h	Mon Feb 19 23:50:03 2001
@@ -382,5 +382,32 @@
 	__up_write(sem);
 }

+/* returns 1 if it successfully obtained the semaphore for write */
+static inline int down_write_trylock(struct rw_semaphore *sem)
+{
+	int old = RW_LOCK_BIAS, new = 0;
+	int res;
+
+	res = cmpxchg(&sem->count.counter, old, new);
+	return (res == RW_LOCK_BIAS);
+}
+
+/* returns 1 if it successfully obtained the semaphore for read */
+static inline int down_read_trylock(struct rw_semaphore *sem)
+{
+	int ret = 1;
+	asm volatile(
+		LOCK "subl $1,%0
+		js 2f
+	1:
+		.section .text.lock,\"ax\"
+	2:"	LOCK "inc %0
+		subl %1,%1
+		jmp 1b
+		.previous"
+		:"=m" (*(volatile int *)sem), "=r" (ret) : "1" (ret) : "memory");
+	return ret;
+}
+
 #endif
 #endif


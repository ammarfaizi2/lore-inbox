Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbTLCRZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 12:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265107AbTLCRZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 12:25:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:49889 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265105AbTLCRZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 12:25:07 -0500
Date: Wed, 3 Dec 2003 09:25:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David =?iso-8859-1?q?Mart=EDnez=20Moreno?= <ender@debian.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Errors and later panics in 2.6.0-test11.
In-Reply-To: <200312031747.16927.ender@debian.org>
Message-ID: <Pine.LNX.4.58.0312030916080.6950@home.osdl.org>
References: <200312031417.18462.ender@debian.org> <Pine.LNX.4.58.0312030757120.5258@home.osdl.org>
 <200312031747.16927.ender@debian.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, David Martínez Moreno wrote:
>
> 	I've just rebooted about six hours ago, and it's giving panics elsewhere:
>
> [...]
> Ending XFS recovery on filesystem: md0 (dev: md0)
> b44: eth0: Link is down.
> b44: eth0: Link is up at 100 Mbps, full duplex.
> b44: eth0: Flow control is on for TX and on for RX.
> eth0: no IPv6 routers present
> Unable to handle kernel paging request at virtual address 00100104

That's the LIST_POISON stuff: 00100100 is the "bad list pointer". Somebody
tried to remove a page twice.

Doesn't mean a lot - if your "struct page" got corrupted, anything can
happen. Quite possibly it's a double free.

> 	I can rebuild the Debian mirror for not using the RAID and using the SATA
> disks separately, but will be tomorrow, it's a lot of space to move, and I
> need remote intervention.
>
> 	Anyway I'd love to know before doing if it will be useful, looking at what
> Jens has said just ten minutes ago about RAIDs 0/5. Will it help to you? Say
> so and I'll go for it.

It might be more useful to leave it as RAID0, if you're willing to try out
patches to try to debug this. The slab-debugging thing I sent out earlier
is one such patch (but may well cause out-of-memory problems under load),
and possibly the atomic-decrement checker patch (appended). And maybe Jens
and Neil can come up with something..

		Linus

----
===== arch/i386/lib/dec_and_lock.c 1.1 vs edited =====
--- 1.1/arch/i386/lib/dec_and_lock.c	Tue Feb  5 09:40:21 2002
+++ edited/arch/i386/lib/dec_and_lock.c	Sun Nov  2 09:07:53 2003
@@ -19,7 +19,7 @@
 	counter = atomic_read(atomic);
 	newcount = counter-1;

-	if (!newcount)
+	if (newcount <= 0)
 		goto slow_path;

 	asm volatile("lock; cmpxchgl %1,%2"
===== include/asm-i386/atomic.h 1.5 vs edited =====
--- 1.5/include/asm-i386/atomic.h	Mon Aug 18 19:46:23 2003
+++ edited/include/asm-i386/atomic.h	Sun Nov  2 09:40:42 2003
@@ -2,6 +2,8 @@
 #define __ARCH_I386_ATOMIC__

 #include <linux/config.h>
+#include <linux/kernel.h>
+#include <asm/bug.h>

 /*
  * Atomic operations that C can't guarantee us.  Useful for
@@ -136,12 +138,17 @@
  */
 static __inline__ int atomic_dec_and_test(atomic_t *v)
 {
-	unsigned char c;
+	static int count = 2;
+	unsigned char c, neg;

 	__asm__ __volatile__(
-		LOCK "decl %0; sete %1"
-		:"=m" (v->counter), "=qm" (c)
+		LOCK "decl %0; sete %1; sets %2"
+		:"=m" (v->counter), "=qm" (c), "=qm" (neg)
 		:"m" (v->counter) : "memory");
+	if (count && neg) {
+		count--;
+		WARN_ON(neg);
+	}
 	return c != 0;
 }


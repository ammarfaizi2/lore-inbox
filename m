Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbVIXCzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbVIXCzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 22:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVIXCzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 22:55:35 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:36713 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751376AbVIXCze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 22:55:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=qEM1Pu0vbMWvGgyf2OAGFVZFudqqF76N3YT1RBwv4P6YwEycGwhmBJE8HD7viNQXtxzXSwphvLvXAculJrbDnzQbkrnRJG3ZlrivwruyPnmF2s0txAuOxmGCkykmYG5R8/rqnd7mM2xfL/nOyuVdpNJIv+ZRodVq6N4OzoUjigI=  ;
Message-ID: <4334C048.6050905@yahoo.com.au>
Date: Sat, 24 Sep 2005 12:56:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4/4] convert dec_and_lock
References: <4334BCF3.1010908@yahoo.com.au> <4334BDC6.9000301@yahoo.com.au> <4334BE56.3050001@yahoo.com.au>
In-Reply-To: <4334BE56.3050001@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------020206020201080601020904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020206020201080601020904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

4/4

This also contains a small optimisation on UP machines
where a spinlock is a noop.

-- 
SUSE Labs, Novell Inc.


--------------020206020201080601020904
Content-Type: text/plain;
 name="atomic-dec_and_lock-use-atomic-primitives.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atomic-dec_and_lock-use-atomic-primitives.patch"

Index: linux-2.6/lib/dec_and_lock.c
===================================================================
--- linux-2.6.orig/lib/dec_and_lock.c
+++ linux-2.6/lib/dec_and_lock.c
@@ -1,47 +1,11 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
-#include <asm/system.h>
 
-#ifdef __HAVE_ARCH_CMPXCHG
 /*
  * This is an implementation of the notion of "decrement a
  * reference count, and return locked if it decremented to zero".
  *
- * This implementation can be used on any architecture that
- * has a cmpxchg, and where atomic->value is an int holding
- * the value of the atomic (i.e. the high bits aren't used
- * for a lock or anything like that).
- */
-int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
-{
-	int counter;
-	int newcount;
-
-	for (;;) {
-		counter = atomic_read(atomic);
-		newcount = counter - 1;
-		if (!newcount)
-			break;		/* do it the slow way */
-
-		newcount = cmpxchg(&atomic->counter, counter, newcount);
-		if (newcount == counter)
-			return 0;
-	}
-
-	spin_lock(lock);
-	if (atomic_dec_and_test(atomic))
-		return 1;
-	spin_unlock(lock);
-	return 0;
-}
-#else
-/*
- * This is an architecture-neutral, but slow,
- * implementation of the notion of "decrement
- * a reference count, and return locked if it
- * decremented to zero".
- *
  * NOTE NOTE NOTE! This is _not_ equivalent to
  *
  *	if (atomic_dec_and_test(&atomic)) {
@@ -52,21 +16,20 @@ int _atomic_dec_and_lock(atomic_t *atomi
  *
  * because the spin-lock and the decrement must be
  * "atomic".
- *
- * This slow version gets the spinlock unconditionally,
- * and releases it if it isn't needed. Architectures
- * are encouraged to come up with better approaches,
- * this is trivially done efficiently using a load-locked
- * store-conditional approach, for example.
  */
 int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 {
+#ifdef CONFIG_SMP
+	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
+	if (atomic_add_unless(atomic, -1, 1))
+		return 0;
+#endif
+	/* Otherwise do it the slow way */
 	spin_lock(lock);
 	if (atomic_dec_and_test(atomic))
 		return 1;
 	spin_unlock(lock);
 	return 0;
 }
-#endif
 
 EXPORT_SYMBOL(_atomic_dec_and_lock);

--------------020206020201080601020904--
Send instant messages to your online friends http://au.messenger.yahoo.com 

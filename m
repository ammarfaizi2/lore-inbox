Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVKEH5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVKEH5X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 02:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVKEH5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 02:57:23 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:32148 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751221AbVKEH5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 02:57:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=0mgXOifPREYse9JwM8Z7r3ecCW8JE0ogFOdXdINhC6RoxE2p280ldor5TeFifD9fSDlq6GL7U61V1Xqjs9yAK32PjvMzSItO+dJQ880exXZFVaV4uykNHFPjH45vfAreU71+LjAPUh1dzvtfAga0kQdTN+mXvQ6GY8pMAAIO7MM=  ;
Message-ID: <436C6660.90007@yahoo.com.au>
Date: Sat, 05 Nov 2005 18:59:28 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [patch 5/5] atomic: dec_and_lock use atomic
References: <436C655F.2080703@yahoo.com.au> <436C65B1.5020508@yahoo.com.au> <436C65E8.8080501@yahoo.com.au> <436C6612.30601@yahoo.com.au> <436C663B.1040409@yahoo.com.au>
In-Reply-To: <436C663B.1040409@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------080309050702030106090708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080309050702030106090708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

5/5

-- 
SUSE Labs, Novell Inc.


--------------080309050702030106090708
Content-Type: text/plain;
 name="atomic-dec_and_lock-use-atomic-primitives.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atomic-dec_and_lock-use-atomic-primitives.patch"

Use new atomic primitives for atomic_dec_and_lock

Signed-off-by: Nick Piggin <npiggin@suse.de>

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

--------------080309050702030106090708--
Send instant messages to your online friends http://au.messenger.yahoo.com 

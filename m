Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311838AbSCOH3T>; Fri, 15 Mar 2002 02:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311855AbSCOH3J>; Fri, 15 Mar 2002 02:29:09 -0500
Received: from [202.135.142.196] ([202.135.142.196]:16134 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S311838AbSCOH3D>; Fri, 15 Mar 2002 02:29:03 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin.Wirth@dlr.de
Cc: torvalds@transmeta.com, "Hubertus Franke" <frankeh@watson.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores) 
In-Reply-To: Your message of "Wed, 13 Mar 2002 10:12:33 BST."
             <3C8F1801.6070107@dlr.de> 
Date: Fri, 15 Mar 2002 18:31:43 +1100
Message-Id: <E16lmBj-0003v4-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3C8F1801.6070107@dlr.de> you write:
>  > > > On Tue, 12 Mar 2002, Rusty Russell wrote:
>  > > > > > > > You've convinced me.
>  > > > > > Damn.  Because now I've been playing with a different approach.
>  > > > I don't think your current patch is very useful.
> 
>  > I agree.  But your "Applied" EMail rushed me into posting it.
> 
> 
> The normal way to use multithreading under UNIX is the pthread
> library. Here the condition variables are the equivalent to kernel
> wait queues. So I think to really implement a fast pthread lib based
> on futexes one needs some means to implement condition variables
> (with synchronous futex release to implement  pthread_cond_wait(..)!).

Discussions with Ulrich have reaffirmed my opinion that pthreads are
crap.  Hence I'm not all that tempted to warp the (nice, clean,
usable) futex code too far to meet pthreads' wierd needs.

However, it's not too hard to implement condition variables using an
unavailable mutex, if we go for "full" semaphores: ie. not just
mutexes.  It requires a bit more of a stretch for kernel atomic ops...

Yet another untested patch,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7-pre1/kernel/futex.c working-2.5.7-pre1-sem/kernel/futex.c
--- linux-2.5.7-pre1/kernel/futex.c	Wed Mar 13 13:30:39 2002
+++ working-2.5.7-pre1-sem/kernel/futex.c	Fri Mar 15 18:18:37 2002
@@ -129,17 +129,18 @@
 	return page;
 }
 
-/* Try to decrement the user count to zero. */
-static int decrement_to_zero(struct page *page, unsigned int offset)
+/* Try to decrement the user count to >= zero. */
+static int decrement_futex(struct page *page, unsigned int offset)
 {
 	atomic_t *count;
 	int ret = 0;
 
 	count = kmap(page) + offset;
-	/* If we take the semaphore from 1 to 0, it's ours.  If it's
-           zero, decrement anyway, to indicate we are waiting.  If
-           it's negative, don't decrement so we don't wrap... */
-	if (atomic_read(count) >= 0 && atomic_dec_and_test(count))
+	/* If we take one from the sem, and it's still >= 0, it's
+           ours.  If it's zero, we decrement anyway to indicate we are
+           waiting.  If it's negative, don't decrement so we don't
+           wrap... */
+	if (atomic_read(count) >= 0 && !atomic_add_negative(-1, count))
 		ret = 1;
 	kunmap(page);
 	return ret;
@@ -173,12 +174,36 @@
 	return retval;
 }
 
+/* Atomically: Add 1 if already positive, otherwise set to 1. */
+static void futex_make_positive(atomic_t *count)
+{
+	int old_count, new_count;
+
+#ifndef CONFIG_SMP
+	preempt_disable();
+	old_count = atomic_read(count);
+	new_count = old_count > 0 ? old_count+1 : 1;
+	atomic_set(count, new_count);
+	preempt_enable();
+#elif defined(__HAVE_ARCH_CMPXCHG)
+	do {
+		old_count = atomic_read(count);
+		new_count = old_count > 0 ? old_count+1 : 1;
+	} while (cmpxchg(count, old_count, new_count) != old_count);
+#else
+	/* Do this one at a time.  You will need to implement
+	   atomic_add_positive(). */
+	while (!atomic_add_positive(count, 1));
+#endif
+}
+
 static int futex_up(struct list_head *head, struct page *page, int offset)
 {
 	atomic_t *count;
 
 	count = kmap(page) + offset;
-	atomic_set(count, 1);
+	/* set to MAX(count, 0) + 1 */
+	futex_make_positive(count);
 	smp_wmb();
 	kunmap(page);
 	wake_one_waiter(head, page, offset);

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315300AbSEAF3R>; Wed, 1 May 2002 01:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315301AbSEAF3Q>; Wed, 1 May 2002 01:29:16 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:39941 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315300AbSEAF3O>; Wed, 1 May 2002 01:29:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, Hubertus Franke <frankeh@watson.ibm.com>,
        Peter W <pwaechtler@loewe-komp.de>, Martin Wirth <martin.wirth@dlr.de>,
        drepper@redhat.com, matthew@hairy.beasts.org
Subject: [PATCH] Futex update...
Date: Wed, 01 May 2002 15:32:06 +1000
Message-Id: <E172mik-000280-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This does not include the async interface (FUTEX_AWAIT) which we still
don't agree on, but that's orthogonal.

Name: Futex Update
Author: Rusty Russell
Status: Beta

D: This changes futex semantics to a simple "sleep if this address
D: equals this value" interface, which is more convenient for building
D: other primitives.  It also adds a timeout value.
D:
D: Example library can be found at:
D:    http://www.kernel.org/pub/linux/kernel/people/rusty/futex-2.0.tar.gz

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7/include/linux/futex.h working-2.5.7-futex/include/linux/futex.h
--- linux-2.5.7/include/linux/futex.h	Thu Mar 21 14:14:54 2002
+++ working-2.5.7-futex/include/linux/futex.h	Tue Apr  2 10:56:40 2002
@@ -2,7 +2,7 @@
 #define _LINUX_FUTEX_H
 
 /* Second argument to futex syscall */
-#define FUTEX_UP (0)
-#define FUTEX_DOWN (1)
+#define FUTEX_WAIT (0)
+#define FUTEX_WAKE (1)
 
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.7/kernel/futex.c working-2.5.7-futex/kernel/futex.c
--- linux-2.5.7/kernel/futex.c	Thu Mar 21 14:14:56 2002
+++ working-2.5.7-futex/kernel/futex.c	Tue Apr  2 10:56:40 2002
@@ -32,7 +32,8 @@
 #include <linux/fs.h>
 #include <linux/futex.h>
 #include <linux/highmem.h>
-#include <asm/atomic.h>
+#include <linux/time.h>
+#include <asm/uaccess.h>
 
 /* These mutexes are a very simple counter: the winner is the one who
    decrements from 1 to 0.  The counter starts at 1 when the lock is
@@ -68,22 +69,27 @@
 	return &futex_queues[hash_long(h, FUTEX_HASHBITS)];
 }
 
-static inline void wake_one_waiter(struct list_head *head,
-				   struct page *page,
-				   unsigned int offset)
+static int futex_wake(struct list_head *head,
+		      struct page *page,
+		      unsigned int offset,
+		      int num)
 {
-	struct list_head *i;
+	struct list_head *i, *next;
+	int num_woken = 0;
 
 	spin_lock(&futex_lock);
-	list_for_each(i, head) {
+	list_for_each_safe(i, next, head) {
 		struct futex_q *this = list_entry(i, struct futex_q, list);
 
 		if (this->page == page && this->offset == offset) {
+			list_del_init(i);
 			wake_up_process(this->task);
-			break;
+			num_woken++;
+			if (num_woken >= num) break;
 		}
 	}
 	spin_unlock(&futex_lock);
+	return num_woken;
 }
 
 /* Add at end to avoid starvation */
@@ -101,11 +107,17 @@
 	spin_unlock(&futex_lock);
 }
 
-static inline void unqueue_me(struct futex_q *q)
+/* Return 1 if we were still queued (ie. 0 means we were woken) */
+static inline int unqueue_me(struct futex_q *q)
 {
+	int ret = 0;
 	spin_lock(&futex_lock);
-	list_del(&q->list);
+	if (!list_empty(&q->list)) {
+		list_del(&q->list);
+		ret = 1;
+	}
 	spin_unlock(&futex_lock);
+	return ret;
 }
 
 /* Get kernel address of the user page and pin it. */
@@ -129,74 +141,62 @@
 	return page;
 }
 
-/* Try to decrement the user count to zero. */
-static int decrement_to_zero(struct page *page, unsigned int offset)
-{
-	atomic_t *count;
-	int ret = 0;
-
-	count = kmap(page) + offset;
-	/* If we take the semaphore from 1 to 0, it's ours.  If it's
-           zero, decrement anyway, to indicate we are waiting.  If
-           it's negative, don't decrement so we don't wrap... */
-	if (atomic_read(count) >= 0 && atomic_dec_and_test(count))
-		ret = 1;
-	kunmap(page);
-	return ret;
-}
-
-/* Simplified from arch/ppc/kernel/semaphore.c: Paul M. is a genius. */
-static int futex_down(struct list_head *head, struct page *page, int offset)
+static int futex_wait(struct list_head *head,
+		      struct page *page,
+		      int offset,
+		      int val,
+		      unsigned long time)
 {
-	int retval = 0;
+	int *count;
 	struct futex_q q;
+	int ret = 0;
 
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	queue_me(head, &q, page, offset);
 
-	while (!decrement_to_zero(page, offset)) {
-		if (signal_pending(current)) {
-			retval = -EINTR;
-			break;
-		}
-		schedule();
-		current->state = TASK_INTERRUPTIBLE;
-	}
-	current->state = TASK_RUNNING;
-	unqueue_me(&q);
-	/* If we were signalled, we might have just been woken: we
-	   must wake another one.  Otherwise we need to wake someone
-	   else (if they are waiting) so they drop the count below 0,
-	   and when we "up" in userspace, we know there is a
-	   waiter. */
-	wake_one_waiter(head, page, offset);
-	return retval;
-}
-
-static int futex_up(struct list_head *head, struct page *page, int offset)
-{
-	atomic_t *count;
-
 	count = kmap(page) + offset;
-	atomic_set(count, 1);
-	smp_wmb();
+	if (*count != val) {
+		ret = -EWOULDBLOCK;
+		set_current_state(TASK_RUNNING);
+		goto out;
+	}
+	time = schedule_timeout(time);
+	if (time == 0) {
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+	if (signal_pending(current)) {
+		ret = -EINTR;
+		goto out;
+	}
+ out:
 	kunmap(page);
-	wake_one_waiter(head, page, offset);
-	return 0;
+	/* Were we woken up anyway? */
+	if (!unqueue_me(&q))
+		return 0;
+	return ret;
 }
 
-asmlinkage int sys_futex(void *uaddr, int op)
+asmlinkage int sys_futex(void *uaddr, int op, int val, struct timespec *utime)
 {
 	int ret;
 	unsigned long pos_in_page;
 	struct list_head *head;
 	struct page *page;
+	unsigned long time = MAX_SCHEDULE_TIMEOUT;
+
+	if (utime) {
+		struct timespec t;
+		if (copy_from_user(&t, utime, sizeof(t)) != 0)
+			return -EFAULT;
+		time = timespec_to_jiffies(&t) + 1;
+	}
 
 	pos_in_page = ((unsigned long)uaddr) % PAGE_SIZE;
 
 	/* Must be "naturally" aligned, and not on page boundary. */
-	if ((pos_in_page % __alignof__(atomic_t)) != 0
-	    || pos_in_page + sizeof(atomic_t) > PAGE_SIZE)
+	if ((pos_in_page % __alignof__(int)) != 0
+	    || pos_in_page + sizeof(int) > PAGE_SIZE)
 		return -EINVAL;
 
 	/* Simpler if it doesn't vanish underneath us. */
@@ -206,13 +206,12 @@
 
 	head = hash_futex(page, pos_in_page);
 	switch (op) {
-	case FUTEX_UP:
-		ret = futex_up(head, page, pos_in_page);
+	case FUTEX_WAIT:
+		ret = futex_wait(head, page, pos_in_page, val, time);
 		break;
-	case FUTEX_DOWN:
-		ret = futex_down(head, page, pos_in_page);
+	case FUTEX_WAKE:
+		ret = futex_wake(head, page, pos_in_page, val);
 		break;
-	/* Add other lock types here... */
 	default:
 		ret = -EINVAL;
 	}


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

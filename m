Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265043AbUETJi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbUETJi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 05:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUETJiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 05:38:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56038 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265043AbUETJiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 05:38:18 -0400
Date: Thu, 20 May 2004 05:38:17 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com
Subject: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Message-ID: <20040520093817.GX30909@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

FUTEX_REQUEUE operation has been added to the kernel mainly to improve
pthread_cond_broadcast which previously used FUTEX_WAKE INT_MAX op.
pthread_cond_broadcast releases internal condvar mutex before FUTEX_REQUEUE
operation, as otherwise the woken up thread most likely immediately sleeps
again on the internal condvar mutex until the broadcasting thread releases
it.
Unfortunately this is racy and causes e.g.
http://sources.redhat.com/cgi-bin/cvsweb.cgi/libc/nptl/tst-cond16.c?rev=1.1&content-type=text/x-cvsweb-markup&cvsroot=glibc
to hang on SMP.
http://listman.redhat.com/archives/phil-list/2004-May/msg00023.html
contains analysis how the hang happens, the problem is if any thread
does pthread_cond_*wait in between releasing of the internal condvar
mutex and FUTEX_REQUEUE operation, a wrong thread might be awaken (and
immediately go to sleep again because it doesn't satisfy conditions for
returning from pthread_cond_*wait) while the right thread requeued on
the associated mutex and there would be nobody to wake that thread up.

The patch below extends FUTEX_REQUEUE operation with something FUTEX_WAIT
already uses:
FUTEX_CMP_REQUEUE is passed an additional argument which is the expected
value of *futex.  Kernel then while holding the futex locks checks if
*futex != expected and returns -EAGAIN in that case, while if it is equal,
continues with a normal FUTEX_REQUEUE operation.
If the syscall returns -EAGAIN, NPTL can fall back to FUTEX_WAKE INT_MAX
operation which doesn't have this problem, but is less efficient, while
in the likely case that nobody hit the (small) window the efficient
FUTEX_REQUEUE operation is used.

--- linux-2.6.5/include/linux/futex.h.jj	2004-04-04 05:37:36.000000000 +0200
+++ linux-2.6.5/include/linux/futex.h	2004-05-05 09:57:09.200306101 +0200
@@ -8,9 +8,10 @@
 #define FUTEX_WAKE (1)
 #define FUTEX_FD (2)
 #define FUTEX_REQUEUE (3)
-
+#define FUTEX_CMP_REQUEUE (4)
 
 long do_futex(unsigned long uaddr, int op, int val,
-		unsigned long timeout, unsigned long uaddr2, int val2);
+		unsigned long timeout, unsigned long uaddr2, int val2,
+		int val3);
 
 #endif
--- linux-2.6.5/kernel/futex.c.jj	2004-04-04 05:36:52.000000000 +0200
+++ linux-2.6.5/kernel/futex.c	2004-05-05 12:23:33.481048623 +0200
@@ -96,6 +96,7 @@ struct futex_q {
  */
 struct futex_hash_bucket {
        spinlock_t              lock;
+       unsigned int	    nqueued;
        struct list_head       chain;
 };
 
@@ -318,13 +319,14 @@ out:
  * physical page.
  */
 static int futex_requeue(unsigned long uaddr1, unsigned long uaddr2,
-				int nr_wake, int nr_requeue)
+			 int nr_wake, int nr_requeue, int *valp)
 {
 	union futex_key key1, key2;
 	struct futex_hash_bucket *bh1, *bh2;
 	struct list_head *head1;
 	struct futex_q *this, *next;
 	int ret, drop_count = 0;
+	unsigned int nqueued;
 
 	down_read(&current->mm->mmap_sem);
 
@@ -338,12 +340,33 @@ static int futex_requeue(unsigned long u
 	bh1 = hash_futex(&key1);
 	bh2 = hash_futex(&key2);
 
+	nqueued = bh1->nqueued;
+	if (likely (valp != NULL)) {
+		int curval;
+
+		smp_mb ();
+
+		if (get_user(curval, (int *)uaddr1) != 0) {
+			ret = -EFAULT;
+			goto out;
+		}
+		if (curval != *valp) {
+			ret = -EAGAIN;
+			goto out;
+		}
+	}
+
 	if (bh1 < bh2)
 		spin_lock(&bh1->lock);
 	spin_lock(&bh2->lock);
 	if (bh1 > bh2)
 		spin_lock(&bh1->lock);
 
+	if (unlikely (nqueued != bh1->nqueued && valp != NULL)) {
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
+
 	head1 = &bh1->chain;
 	list_for_each_entry_safe(this, next, head1, list) {
 		if (!match_futex (&this->key, &key1))
@@ -365,6 +388,7 @@ static int futex_requeue(unsigned long u
 		}
 	}
 
+out_unlock:
 	spin_unlock(&bh1->lock);
 	if (bh1 != bh2)
 		spin_unlock(&bh2->lock);
@@ -398,6 +422,7 @@ static void queue_me(struct futex_q *q, 
 	q->lock_ptr = &bh->lock;
 
 	spin_lock(&bh->lock);
+	bh->nqueued++;
 	list_add_tail(&q->list, &bh->chain);
 	spin_unlock(&bh->lock);
 }
@@ -625,7 +650,7 @@ out:
 }
 
 long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout,
-		unsigned long uaddr2, int val2)
+		unsigned long uaddr2, int val2, int val3)
 {
 	int ret;
 
@@ -641,7 +666,10 @@ long do_futex(unsigned long uaddr, int o
 		ret = futex_fd(uaddr, val);
 		break;
 	case FUTEX_REQUEUE:
-		ret = futex_requeue(uaddr, uaddr2, val, val2);
+		ret = futex_requeue(uaddr, uaddr2, val, val2, NULL);
+		break;
+	case FUTEX_CMP_REQUEUE:
+		ret = futex_requeue(uaddr, uaddr2, val, val2, &val3);
 		break;
 	default:
 		ret = -ENOSYS;
@@ -651,7 +679,8 @@ long do_futex(unsigned long uaddr, int o
 
 
 asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
-			  struct timespec __user *utime, u32 __user *uaddr2)
+			  struct timespec __user *utime, u32 __user *uaddr2,
+			  int val3)
 {
 	struct timespec t;
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
@@ -665,11 +694,11 @@ asmlinkage long sys_futex(u32 __user *ua
 	/*
 	 * requeue parameter in 'utime' if op == FUTEX_REQUEUE.
 	 */
-	if (op == FUTEX_REQUEUE)
+	if (op >= FUTEX_REQUEUE)
 		val2 = (int) (long) utime;
 
 	return do_futex((unsigned long)uaddr, op, val, timeout,
-			(unsigned long)uaddr2, val2);
+			(unsigned long)uaddr2, val2, val3);
 }
 
 static struct super_block *
--- linux-2.6.5/kernel/compat.c.jj	2004-04-04 05:37:07.000000000 +0200
+++ linux-2.6.5/kernel/compat.c	2004-05-05 09:56:36.761119626 +0200
@@ -208,7 +208,7 @@ asmlinkage long compat_sys_sigprocmask(i
 
 #ifdef CONFIG_FUTEX
 asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
-		struct compat_timespec *utime, u32 *uaddr2)
+		struct compat_timespec *utime, u32 *uaddr2, int val3)
 {
 	struct timespec t;
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
@@ -219,11 +219,11 @@ asmlinkage long compat_sys_futex(u32 *ua
 			return -EFAULT;
 		timeout = timespec_to_jiffies(&t) + 1;
 	}
-	if (op == FUTEX_REQUEUE)
+	if (op >= FUTEX_REQUEUE)
 		val2 = (int) (long) utime;
 
 	return do_futex((unsigned long)uaddr, op, val, timeout,
-			(unsigned long)uaddr2, val2);
+			(unsigned long)uaddr2, val2, val3);
 }
 #endif
 

	Jakub

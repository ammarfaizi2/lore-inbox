Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbUEXIMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUEXIMu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 04:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUEXIMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 04:12:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:62603 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262874AbUEXIMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 04:12:41 -0400
Date: Mon, 24 May 2004 01:12:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: arnd@arndb.de, drepper@redhat.com, linux-kernel@vger.kernel.org,
       mingo@redhat.com, schwidefsky@de.ibm.com, bert hubert <ahu@ds9a.nl>
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Message-Id: <20040524011203.3be81d0a.akpm@osdl.org>
In-Reply-To: <20040524073407.GC4736@devserv.devel.redhat.com>
References: <20040520093817.GX30909@devserv.devel.redhat.com>
	<20040520233639.126125ef.akpm@osdl.org>
	<20040521074358.GG30909@devserv.devel.redhat.com>
	<200405221858.44752.arnd@arndb.de>
	<20040524073407.GC4736@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> wrote:
>
> That said, NPTL can deal with any of these variants and the decision
>  is up to Martin I think (assuming the base patch gets accepted, that is).

Well the race is real and does need a kernel fix, so I queued it up.  I
guess if the new argument to sys_futex() breaks some architecture they can
independently add a new syscall for it, or send a fix.  Mutter.

It's a bit of a shame that you need to be a rocket scientist to 
understand the futex syscall interface.  Bert, are you still maintaining
the manpage?  If so, is there enough info here to update it?




FUTEX_REQUEUE operation has been added to the kernel mainly to improve
pthread_cond_broadcast which previously used FUTEX_WAKE INT_MAX op. 
pthread_cond_broadcast releases internal condvar mutex before FUTEX_REQUEUE
operation, as otherwise the woken up thread most likely immediately sleeps
again on the internal condvar mutex until the broadcasting thread releases it.

Unfortunately this is racy and causes e.g. 
http://sources.redhat.com/cgi-bin/cvsweb.cgi/libc/nptl/tst-cond16.c?rev=1.1&content-type=text/x-cvsweb-markup&cvsroot=glibc
to hang on SMP.

http://listman.redhat.com/archives/phil-list/2004-May/msg00023.html contains
analysis how the hang happens, the problem is if any thread does
pthread_cond_*wait in between releasing of the internal condvar mutex and
FUTEX_REQUEUE operation, a wrong thread might be awaken (and immediately go to
sleep again because it doesn't satisfy conditions for returning from
pthread_cond_*wait) while the right thread requeued on the associated mutex
and there would be nobody to wake that thread up.

The patch below extends FUTEX_REQUEUE operation with something FUTEX_WAIT
already uses:

FUTEX_CMP_REQUEUE is passed an additional argument which is the expected value
of *futex.  Kernel then while holding the futex locks checks if *futex !=
expected and returns -EAGAIN in that case, while if it is equal, continues
with a normal FUTEX_REQUEUE operation.  If the syscall returns -EAGAIN, NPTL
can fall back to FUTEX_WAKE INT_MAX operation which doesn't have this problem,
but is less efficient, while in the likely case that nobody hit the (small)
window the efficient FUTEX_REQUEUE operation is used.


---

 25-akpm/include/linux/futex.h |    5 ++--
 25-akpm/kernel/compat.c       |    6 ++---
 25-akpm/kernel/futex.c        |   49 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 49 insertions(+), 11 deletions(-)

diff -puN include/linux/futex.h~add-futex_cmp_requeue-futex-op include/linux/futex.h
--- 25/include/linux/futex.h~add-futex_cmp_requeue-futex-op	2004-05-23 11:15:27.460533968 -0700
+++ 25-akpm/include/linux/futex.h	2004-05-23 11:15:27.467532904 -0700
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
diff -puN kernel/compat.c~add-futex_cmp_requeue-futex-op kernel/compat.c
--- 25/kernel/compat.c~add-futex_cmp_requeue-futex-op	2004-05-23 11:15:27.462533664 -0700
+++ 25-akpm/kernel/compat.c	2004-05-23 11:15:27.470532448 -0700
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
 
diff -puN kernel/futex.c~add-futex_cmp_requeue-futex-op kernel/futex.c
--- 25/kernel/futex.c~add-futex_cmp_requeue-futex-op	2004-05-23 11:15:27.463533512 -0700
+++ 25-akpm/kernel/futex.c	2004-05-23 11:15:27.469532600 -0700
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
 
@@ -338,12 +340,41 @@ static int futex_requeue(unsigned long u
 	bh1 = hash_futex(&key1);
 	bh2 = hash_futex(&key2);
 
+	nqueued = bh1->nqueued;
+	if (likely(valp != NULL)) {
+		int curval;
+
+		/* In order to avoid doing get_user while
+		   holding bh1->lock and bh2->lock, nqueued
+		   (monotonically increasing field) must be first
+		   read, then *uaddr1 fetched from userland and
+		   after acquiring lock nqueued field compared with
+		   the stored value.  The smp_mb () below
+		   makes sure that bh1->nqueued is read from memory
+		   before *uaddr1.  */
+		smp_mb();
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
 
+	if (unlikely(nqueued != bh1->nqueued && valp != NULL)) {
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
+
 	head1 = &bh1->chain;
 	list_for_each_entry_safe(this, next, head1, list) {
 		if (!match_futex (&this->key, &key1))
@@ -365,6 +396,7 @@ static int futex_requeue(unsigned long u
 		}
 	}
 
+out_unlock:
 	spin_unlock(&bh1->lock);
 	if (bh1 != bh2)
 		spin_unlock(&bh2->lock);
@@ -398,6 +430,7 @@ static void queue_me(struct futex_q *q, 
 	q->lock_ptr = &bh->lock;
 
 	spin_lock(&bh->lock);
+	bh->nqueued++;
 	list_add_tail(&q->list, &bh->chain);
 	spin_unlock(&bh->lock);
 }
@@ -625,7 +658,7 @@ out:
 }
 
 long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout,
-		unsigned long uaddr2, int val2)
+		unsigned long uaddr2, int val2, int val3)
 {
 	int ret;
 
@@ -641,7 +674,10 @@ long do_futex(unsigned long uaddr, int o
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
@@ -651,7 +687,8 @@ long do_futex(unsigned long uaddr, int o
 
 
 asmlinkage long sys_futex(u32 __user *uaddr, int op, int val,
-			  struct timespec __user *utime, u32 __user *uaddr2)
+			  struct timespec __user *utime, u32 __user *uaddr2,
+			  int val3)
 {
 	struct timespec t;
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
@@ -665,11 +702,11 @@ asmlinkage long sys_futex(u32 __user *ua
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

_


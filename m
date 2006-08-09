Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030534AbWHIG0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030534AbWHIG0d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030536AbWHIG0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:26:32 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:23372 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1030534AbWHIG0b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:26:31 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Ulrich Drepper <drepper@gmail.com>,
       Andi Kleen <ak@suse.de>, Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [RFC] NUMA futex hashing
Date: Wed, 9 Aug 2006 08:26:27 +0200
User-Agent: KMail/1.9.1
Cc: "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
References: <20060808070708.GA3931@localhost.localdomain> <a36005b50608080958n192e9324jb9d5a7a59b365eae@mail.gmail.com> <44D94142.3050703@yahoo.com.au>
In-Reply-To: <44D94142.3050703@yahoo.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UAY2EYia1ifUTA4"
Message-Id: <200608090826.28249.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_UAY2EYia1ifUTA4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Based on various discussions and feedbacks, I cooked a patch that implements 
the notion of private futexes (private to a process, in the spirit of POSIX 
pshared PTHREAD_PROCESS_PRIVATE )

[PATCH] futex : Add new PRIVATE futex primitives for performance improvements

When a futex is privately used by a process, we dont really need to lookup the 
list of vmas of the process in order to discover if the futex is backed by a 
inode or by the mm struct. We dont really need to keep a refcount on the 
inode or mm.

This patch introduces new futex calls, that could be used by user land (glibc 
of course) when private futexes are used.

Avoiding vmas lookup means avoiding taking the mmap_sem (and forcing cacheline 
bouncings).

Avoiding refcounting on underlying inode or mm struct also avoids cacheline 
bouncing.

Thats two cacheline bounces avoided per FUTEX syscall

glibc could use the new futex primitives introduced here (in particular for 
PTHREAD_PROCESS_PRIVATE semantic), and fallback to old one if running on 
older kernel. Fallback could set a global variable with the number of syscall 
so that only one failed syscall is done in the process lifetime.

Note : Compatibility should be maintained by this patch, as old applications 
will use the 'SHARED' functionality, unchanged.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--Boundary-00=_UAY2EYia1ifUTA4
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="futex_priv1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="futex_priv1.patch"

--- linux-2.6.18-rc4/include/linux/futex.h	2006-08-08 22:46:13.000000000 +0200
+++ linux-2.6.18-rc4-ed/include/linux/futex.h	2006-08-08 23:23:13.000000000 +0200
@@ -15,6 +15,11 @@
 #define FUTEX_LOCK_PI		6
 #define FUTEX_UNLOCK_PI		7
 #define FUTEX_TRYLOCK_PI	8
+#define FUTEX_WAIT_PRIVATE         9
+#define FUTEX_WAKE_PRIVATE        10
+#define FUTEX_REQUEUE_PRIVATE     11
+#define FUTEX_CMP_REQUEUE_PRIVATE 12
+#define FUTEX_WAKE_OP_PRIVATE     13
 
 /*
  * Support for robust futexes: the kernel cleans up held futexes at
--- linux-2.6.18-rc4/kernel/futex.c	2006-08-08 22:45:46.000000000 +0200
+++ linux-2.6.18-rc4-ed/kernel/futex.c	2006-08-09 07:26:19.000000000 +0200
@@ -60,8 +60,9 @@
  * Don't rearrange members without looking at hash_futex().
  *
  * offset is aligned to a multiple of sizeof(u32) (== 4) by definition.
- * We set bit 0 to indicate if it's an inode-based key.
  */
+#define OFF_INODE    1 /* We set bit 0 if it has a reference on inode */
+#define OFF_MMSHARED 2 /* We set bit 1 if it has a reference on mm */
 union futex_key {
 	struct {
 		unsigned long pgoff;
@@ -79,6 +80,8 @@
 		int offset;
 	} both;
 };
+#define FUT_SHARED  1 /* we should walk vmas */
+#define FUT_PRIVATE 0 /* private futex: no need to walk vmas*/
 
 /*
  * Priority Inheritance state:
@@ -140,7 +143,7 @@
 static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];
 
 /* Futex-fs vfsmount entry: */
-static struct vfsmount *futex_mnt;
+static struct vfsmount *futex_mnt __read_mostly;
 
 /*
  * We hash on the keys returned from get_futex_key (see below).
@@ -175,7 +178,7 @@
  *
  * Should be called with &current->mm->mmap_sem but NOT any spinlocks.
  */
-static int get_futex_key(u32 __user *uaddr, union futex_key *key)
+static int get_futex_key(u32 __user *uaddr, union futex_key *key, int shared)
 {
 	unsigned long address = (unsigned long)uaddr;
 	struct mm_struct *mm = current->mm;
@@ -191,6 +194,11 @@
 		return -EINVAL;
 	address -= key->both.offset;
 
+	if (shared == FUT_PRIVATE) {
+		key->private.mm = mm;
+		key->private.address = address;
+		return 0;
+	}
 	/*
 	 * The futex is hashed differently depending on whether
 	 * it's in a shared or private mapping.  So check vma first.
@@ -215,6 +223,7 @@
 	 * mappings of _writable_ handles.
 	 */
 	if (likely(!(vma->vm_flags & VM_MAYSHARE))) {
+		key->both.offset += OFF_MMSHARED; /* reference taken on mm */
 		key->private.mm = mm;
 		key->private.address = address;
 		return 0;
@@ -224,7 +233,7 @@
 	 * Linear file mappings are also simple.
 	 */
 	key->shared.inode = vma->vm_file->f_dentry->d_inode;
-	key->both.offset++; /* Bit 0 of offset indicates inode-based key. */
+	key->both.offset += OFF_INODE; /* reference taken on inode */
 	if (likely(!(vma->vm_flags & VM_NONLINEAR))) {
 		key->shared.pgoff = (((address - vma->vm_start) >> PAGE_SHIFT)
 				     + vma->vm_pgoff);
@@ -256,8 +265,8 @@
  */
 static inline void get_key_refs(union futex_key *key)
 {
-	if (key->both.ptr != 0) {
-		if (key->both.offset & 1)
+	if (key->both.offset & (OFF_INODE|OFF_MMSHARED)) {
+		if (key->both.offset & OFF_INODE)
 			atomic_inc(&key->shared.inode->i_count);
 		else
 			atomic_inc(&key->private.mm->mm_count);
@@ -270,8 +279,8 @@
  */
 static void drop_key_refs(union futex_key *key)
 {
-	if (key->both.ptr != 0) {
-		if (key->both.offset & 1)
+	if (key->both.offset & (OFF_INODE|OFF_MMSHARED)) {
+		if (key->both.offset & OFF_INODE)
 			iput(key->shared.inode);
 		else
 			mmdrop(key->private.mm);
@@ -650,7 +659,7 @@
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
  */
-static int futex_wake(u32 __user *uaddr, int nr_wake)
+static int futex_wake(u32 __user *uaddr, int nr_wake, int shared)
 {
 	struct futex_hash_bucket *hb;
 	struct futex_q *this, *next;
@@ -658,9 +667,10 @@
 	union futex_key key;
 	int ret;
 
-	down_read(&current->mm->mmap_sem);
+	if (shared)
+		down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr, &key);
+	ret = get_futex_key(uaddr, &key, shared);
 	if (unlikely(ret != 0))
 		goto out;
 
@@ -682,7 +692,8 @@
 
 	spin_unlock(&hb->lock);
 out:
-	up_read(&current->mm->mmap_sem);
+	if (shared)
+		up_read(&current->mm->mmap_sem);
 	return ret;
 }
 
@@ -692,7 +703,7 @@
  */
 static int
 futex_wake_op(u32 __user *uaddr1, u32 __user *uaddr2,
-	      int nr_wake, int nr_wake2, int op)
+	      int nr_wake, int nr_wake2, int op, int shared)
 {
 	union futex_key key1, key2;
 	struct futex_hash_bucket *hb1, *hb2;
@@ -703,10 +714,10 @@
 retryfull:
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr1, &key1);
+	ret = get_futex_key(uaddr1, &key1, shared);
 	if (unlikely(ret != 0))
 		goto out;
-	ret = get_futex_key(uaddr2, &key2);
+	ret = get_futex_key(uaddr2, &key2, shared);
 	if (unlikely(ret != 0))
 		goto out;
 
@@ -802,7 +813,7 @@
  * physical page.
  */
 static int futex_requeue(u32 __user *uaddr1, u32 __user *uaddr2,
-			 int nr_wake, int nr_requeue, u32 *cmpval)
+			 int nr_wake, int nr_requeue, u32 *cmpval, int shared)
 {
 	union futex_key key1, key2;
 	struct futex_hash_bucket *hb1, *hb2;
@@ -811,12 +822,13 @@
 	int ret, drop_count = 0;
 
  retry:
-	down_read(&current->mm->mmap_sem);
+	if (shared)
+		down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr1, &key1);
+	ret = get_futex_key(uaddr1, &key1, shared);
 	if (unlikely(ret != 0))
 		goto out;
-	ret = get_futex_key(uaddr2, &key2);
+	ret = get_futex_key(uaddr2, &key2, shared);
 	if (unlikely(ret != 0))
 		goto out;
 
@@ -839,7 +851,8 @@
 			 * If we would have faulted, release mmap_sem, fault
 			 * it in and start all over again.
 			 */
-			up_read(&current->mm->mmap_sem);
+			if (shared)
+				up_read(&current->mm->mmap_sem);
 
 			ret = get_user(curval, uaddr1);
 
@@ -888,7 +901,8 @@
 		drop_key_refs(&key1);
 
 out:
-	up_read(&current->mm->mmap_sem);
+	if (shared)
+		up_read(&current->mm->mmap_sem);
 	return ret;
 }
 
@@ -999,7 +1013,7 @@
 	drop_key_refs(&q->key);
 }
 
-static int futex_wait(u32 __user *uaddr, u32 val, unsigned long time)
+static int futex_wait(u32 __user *uaddr, u32 val, unsigned long time, int shared)
 {
 	struct task_struct *curr = current;
 	DECLARE_WAITQUEUE(wait, curr);
@@ -1010,9 +1024,10 @@
 
 	q.pi_state = NULL;
  retry:
-	down_read(&curr->mm->mmap_sem);
+	if (shared)
+		down_read(&curr->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr, &q.key);
+	ret = get_futex_key(uaddr, &q.key, shared);
 	if (unlikely(ret != 0))
 		goto out_release_sem;
 
@@ -1047,7 +1062,8 @@
 		 * If we would have faulted, release mmap_sem, fault it in and
 		 * start all over again.
 		 */
-		up_read(&curr->mm->mmap_sem);
+		if (shared)
+			up_read(&curr->mm->mmap_sem);
 
 		ret = get_user(uval, uaddr);
 
@@ -1066,7 +1082,8 @@
 	 * Now the futex is queued and we have checked the data, we
 	 * don't want to hold mmap_sem while we sleep.
 	 */
-	up_read(&curr->mm->mmap_sem);
+	if (shared)
+		up_read(&curr->mm->mmap_sem);
 
 	/*
 	 * There might have been scheduling since the queue_me(), as we
@@ -1108,7 +1125,8 @@
 	queue_unlock(&q, hb);
 
  out_release_sem:
-	up_read(&curr->mm->mmap_sem);
+	if (shared)
+		up_read(&curr->mm->mmap_sem);
 	return ret;
 }
 
@@ -1134,7 +1152,7 @@
  retry:
 	down_read(&curr->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr, &q.key);
+	ret = get_futex_key(uaddr, &q.key, FUT_SHARED);
 	if (unlikely(ret != 0))
 		goto out_release_sem;
 
@@ -1435,7 +1453,7 @@
 	 */
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr, &key);
+	ret = get_futex_key(uaddr, &key, FUT_SHARED);
 	if (unlikely(ret != 0))
 		goto out;
 
@@ -1551,7 +1569,7 @@
 	return ret;
 }
 
-static struct file_operations futex_fops = {
+static const struct file_operations futex_fops = {
 	.release	= futex_close,
 	.poll		= futex_poll,
 };
@@ -1600,7 +1618,7 @@
 	q->pi_state = NULL;
 
 	down_read(&current->mm->mmap_sem);
-	err = get_futex_key(uaddr, &q->key);
+	err = get_futex_key(uaddr, &q->key, FUT_SHARED);
 
 	if (unlikely(err != 0)) {
 		up_read(&current->mm->mmap_sem);
@@ -1742,7 +1760,7 @@
 		 */
 		if (!pi) {
 			if (uval & FUTEX_WAITERS)
-				futex_wake(uaddr, 1);
+				futex_wake(uaddr, 1, FUT_SHARED);
 		}
 	}
 	return 0;
@@ -1830,23 +1848,38 @@
 
 	switch (op) {
 	case FUTEX_WAIT:
-		ret = futex_wait(uaddr, val, timeout);
+		ret = futex_wait(uaddr, val, timeout, FUT_SHARED);
+		break;
+	case FUTEX_WAIT_PRIVATE:
+		ret = futex_wait(uaddr, val, timeout, FUT_PRIVATE);
 		break;
 	case FUTEX_WAKE:
-		ret = futex_wake(uaddr, val);
+		ret = futex_wake(uaddr, val, FUT_SHARED);
+		break;
+	case FUTEX_WAKE_PRIVATE:
+		ret = futex_wake(uaddr, val, FUT_PRIVATE);
 		break;
 	case FUTEX_FD:
 		/* non-zero val means F_SETOWN(getpid()) & F_SETSIG(val) */
 		ret = futex_fd(uaddr, val);
 		break;
 	case FUTEX_REQUEUE:
-		ret = futex_requeue(uaddr, uaddr2, val, val2, NULL);
+		ret = futex_requeue(uaddr, uaddr2, val, val2, NULL, FUT_SHARED);
+		break;
+	case FUTEX_REQUEUE_PRIVATE:
+		ret = futex_requeue(uaddr, uaddr2, val, val2, NULL, FUT_PRIVATE);
 		break;
 	case FUTEX_CMP_REQUEUE:
-		ret = futex_requeue(uaddr, uaddr2, val, val2, &val3);
+		ret = futex_requeue(uaddr, uaddr2, val, val2, &val3, FUT_SHARED);
+		break;
+	case FUTEX_CMP_REQUEUE_PRIVATE:
+		ret = futex_requeue(uaddr, uaddr2, val, val2, &val3, FUT_PRIVATE);
 		break;
 	case FUTEX_WAKE_OP:
-		ret = futex_wake_op(uaddr, uaddr2, val, val2, val3);
+		ret = futex_wake_op(uaddr, uaddr2, val, val2, val3, FUT_SHARED);
+		break;
+	case FUTEX_WAKE_OP_PRIVATE:
+		ret = futex_wake_op(uaddr, uaddr2, val, val2, val3, FUT_PRIVATE);
 		break;
 	case FUTEX_LOCK_PI:
 		ret = futex_lock_pi(uaddr, val, timeout, val2, 0);

--Boundary-00=_UAY2EYia1ifUTA4--

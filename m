Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTIHSe4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTIHSe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:34:56 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:49551 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263464AbTIHSer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:34:47 -0400
Date: Mon, 8 Sep 2003 19:34:16 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make futex waiters take an mm or inode reference
Message-ID: <20030908183416.GF27097@mail.jlokier.co.uk>
References: <20030908182021.GD27097@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908182021.GD27097@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> seems you forgot the patch...

Ahem!
-- Jamie

Subject: [PATCH] Make futex waiters take an mm or inode reference
Patch: futex-refs-2.6.0-test4-bk10-40jl

Rusty Russell wrote:
> But why not solve the problem by just holding an mm reference, too?

Rusty also wrote:
> Why not make the code a *whole* lot more readable (and only marginally
> slower, if at all) by doing it in two passes: pull them off onto a
> (on-stack) list in one pass, then requeue them all in another.

This patch makes each futex waiter hold a reference to the mm or inode
that a futex is keyed on.

This is very important, because otherwise a malicious or erroneous
program can use FUTEX_FD to create futexes on mms or inodes which are
recycled, and steal wakeups from other, unrelated programs.

It isn't entirely trivial, because we can't call mmdrop() or iput()
while holding the spinlock, I think.  (Does someone know to the
contrary?)  Rusty, you will be glad to see that I have reimplemented
futex_requeue() exactly as you suggest: in two passes.

Ulrich will be glad to hear tst-cond2 runs just fine :)

Linus, please apply unless there are objections.

Thanks,
-- Jamie


diff -urN --exclude-from=dontdiff newfut-2.6.0-test4/kernel/futex.c laptop-2.6.0-test4/kernel/futex.c
--- newfut-2.6.0-test4/kernel/futex.c	2003-09-06 18:51:55.000000000 +0100
+++ laptop-2.6.0-test4/kernel/futex.c	2003-09-08 16:58:49.757693547 +0100
@@ -43,6 +43,9 @@
 /*
  * Futexes are matched on equal values of this key.
  * The key type depends on whether it's a shared or private mapping.
+ *
+ * offset is aligned to a multiple of sizeof(u32) (== 4) by definition.
+ * We set bit 0 to indicate if it's an inode-based key.
  */
 union futex_key {
 	struct {
@@ -164,10 +167,12 @@
 		return 0;
 	}
 
+	key->both.offset++; /* Bit 0 of offset indicates inode-based key. */
+	key->shared.inode = vma->vm_file->f_dentry->d_inode;
+
 	/*
 	 * Linear mappings are also simple.
 	 */
-	key->shared.inode = vma->vm_file->f_dentry->d_inode;
 	if (likely(!(vma->vm_flags & VM_NONLINEAR))) {
 		key->shared.pgoff = (((uaddr - vma->vm_start) >> PAGE_SHIFT)
 				     + vma->vm_pgoff);
@@ -204,18 +209,58 @@
 		put_page(page);
 		return 0;
 	}
+
 	return err;
 }
 
+/*
+ * Take a reference to the resource addressed by a key.
+ *
+ * NOTE: mmap_sem MUST be held between get_futex_key() and calling this
+ * function, if it is called at all.  mmap_sem keeps key->shared.inode valid.
+ */
+static inline void get_key_refs(union futex_key *key)
+{
+	if (key->both.ptr != 0) {
+		if (key->both.offset & 1)
+			atomic_inc(&key->shared.inode->i_count);
+		else
+			atomic_inc(&key->private.mm->mm_count);
+	}
+}
+
+/*
+ * Drop a reference to the resource addressed by a key.
+ * futex_lock should not be held.
+ */
+static inline void drop_key_refs(union futex_key *key)
+{
+	if (key->both.ptr != 0) {
+		if (key->both.offset & 1)
+			iput(key->shared.inode);
+		else
+			mmdrop(key->private.mm);
+	}
+}
+
+/* futex_lock must be held when this is called. */
+static inline void wake_futex(struct futex_q *q)
+{
+	list_del_init(&q->list);
+	wake_up_all(&q->waiters);
+	if (q->filp)
+		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
+}
 
 /*
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
  */
-static int futex_wake(unsigned long uaddr, int num)
+static int futex_wake(unsigned long uaddr, int nr_wake)
 {
-	struct list_head *i, *next, *head;
 	union futex_key key;
+	struct futex_q *this, *next;
+	struct list_head *head;
 	int ret;
 
 	down_read(&current->mm->mmap_sem);
@@ -227,16 +272,10 @@
 	head = hash_futex(&key);
 
 	spin_lock(&futex_lock);
-	list_for_each_safe(i, next, head) {
-		struct futex_q *this = list_entry(i, struct futex_q, list);
-
+	list_for_each_entry_safe(this, next, head, list) {
 		if (match_futex (&this->key, &key)) {
-			list_del_init(i);
-			wake_up_all(&this->waiters);
-			if (this->filp)
-				send_sigio(&this->filp->f_owner, this->fd, POLL_IN);
-			ret++;
-			if (ret >= num)
+			wake_futex(this);
+			if (++ret >= nr_wake)
 				break;
 		}
 	}
@@ -254,8 +293,9 @@
 static int futex_requeue(unsigned long uaddr1, unsigned long uaddr2,
 				int nr_wake, int nr_requeue)
 {
-	struct list_head *i, *next, *head1, *head2;
 	union futex_key key1, key2;
+	struct list_head *head, moved;
+	struct futex_q *this, *next;
 	int ret;
 
 	down_read(&current->mm->mmap_sem);
@@ -267,47 +307,59 @@
 	if (unlikely(ret != 0))
 		goto out;
 
-	head1 = hash_futex(&key1);
-	head2 = hash_futex(&key2);
+	head = hash_futex(&key1);
+	INIT_LIST_HEAD(&moved);
 
 	spin_lock(&futex_lock);
-	list_for_each_safe(i, next, head1) {
-		struct futex_q *this = list_entry(i, struct futex_q, list);
-
+	list_for_each_entry_safe(this, next, head, list) {
 		if (match_futex (&this->key, &key1)) {
-			list_del_init(i);
 			if (++ret <= nr_wake) {
-				wake_up_all(&this->waiters);
-				if (this->filp)
-					send_sigio(&this->filp->f_owner,
-							this->fd, POLL_IN);
+				wake_futex(this);
 			} else {
-				list_add_tail(i, head2);
-				this->key = key2;
+				list_move_tail(&this->list, &moved);
 				if (ret - nr_wake >= nr_requeue)
 					break;
-				/* Make sure to stop if key1 == key2 */
-				if (head1 == head2 && head1 != next)
-					head1 = i;
 			}
 		}
 	}
 	spin_unlock(&futex_lock);
 
+	if (!list_empty(&moved)) {
+		head = hash_futex(&key2);
+		list_for_each_entry_safe(this, next, &moved, list) {
+			/* Don't hold futex_lock during drop_key_refs(). */
+			drop_key_refs(&this->key);
+			this->key = key2;
+			get_key_refs(&this->key);
+
+			spin_lock(&futex_lock);
+			list_add_tail (&this->list, head);
+			spin_unlock(&futex_lock);
+		}
+	}
+
 out:
 	up_read(&current->mm->mmap_sem);
 	return ret;
 }
 
-static inline void queue_me(struct futex_q *q, union futex_key *key,
-			    int fd, struct file *filp)
+/*
+ * queue_me and unqueue_me must be called as a pair, each
+ * exactly once.  They are called with futex_lock held.
+ */
+
+/* The key must be already stored in q->key. */
+static inline void queue_me(struct futex_q *q, int fd, struct file *filp)
 {
-	struct list_head *head = hash_futex(key);
+	struct list_head *head;
 
-	q->key = *key;
 	q->fd = fd;
 	q->filp = filp;
 
+	init_waitqueue_head(&q->waiters);
+	get_key_refs(&q->key);
+	head = hash_futex(&q->key);
+
 	spin_lock(&futex_lock);
 	list_add_tail(&q->list, head);
 	spin_unlock(&futex_lock);
@@ -324,6 +376,8 @@
 		ret = 1;
 	}
 	spin_unlock(&futex_lock);
+
+	drop_key_refs(&q->key);
 	return ret;
 }
 
@@ -331,19 +385,16 @@
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int ret, curval;
-	union futex_key key;
 	struct futex_q q;
 
  try_again:
-	init_waitqueue_head(&q.waiters);
-
 	down_read(&current->mm->mmap_sem);
 
-	ret = get_futex_key(uaddr, &key);
+	ret = get_futex_key(uaddr, &q.key);
 	if (unlikely(ret != 0))
 		goto out_release_sem;
 
-	queue_me(&q, &key, -1, NULL);
+	queue_me(&q, -1, NULL);
 
 	/*
 	 * Access the page after the futex is queued.
@@ -427,7 +478,7 @@
 	struct futex_q *q = filp->private_data;
 
 	unqueue_me(q);
-	kfree(filp->private_data);
+	kfree(q);
 	return 0;
 }
 
@@ -457,7 +508,6 @@
 static int futex_fd(unsigned long uaddr, int signal)
 {
 	struct futex_q *q;
-	union futex_key key;
 	struct file *filp;
 	int ret, err;
 
@@ -499,20 +549,21 @@
 	}
 
 	down_read(&current->mm->mmap_sem);
-	err = get_futex_key(uaddr, &key);
-	up_read(&current->mm->mmap_sem);
+	err = get_futex_key(uaddr, &q->key);
 
 	if (unlikely(err != 0)) {
+		up_read(&current->mm->mmap_sem);
 		put_unused_fd(ret);
 		put_filp(filp);
 		kfree(q);
 		return err;
 	}
 
-	init_waitqueue_head(&q->waiters);
+	/* queue_me() must be called before releasing mmap_sem, because
+	   key->shared.inode is valid without a reference until then. */
 	filp->private_data = q;
-
-	queue_me(q, &key, ret, filp);
+	queue_me(q, ret, filp);
+	up_read(&current->mm->mmap_sem);
 
 	/* Now we map fd to filp, so userspace can access it */
 	fd_install(ret, filp);


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316836AbSFFHXG>; Thu, 6 Jun 2002 03:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316852AbSFFHXF>; Thu, 6 Jun 2002 03:23:05 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:64455 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316836AbSFFHXD>; Thu, 6 Jun 2002 03:23:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com
Cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: [PATCH] Futex Asynchronous Interface
Date: Thu, 06 Jun 2002 17:26:35 +1000
Message-Id: <E17FrfH-0006Gt-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches (requiring the other patches I sent to the list
which can also be found on my kernel.org page) add the ability to tie
a futex to a file descriptor, for use with poll/select or SIGIO
(required by NGPT).

The method is: open /dev/futex, use sys_futex(FUTEX_AWAIT) to attach
it to a particular futex, then use select or poll (or set the fd up
for sigio signals, and expect a SIGIO).

You need to use FUTEX_AWAIT again after poll succeeds or SIGIO
(ie. it's oneshot).  Calling it while a futex is already outstanding
forgets about the old futex.

The reason for this method is that it's pretty convenient for
programs, and since each one pins a page down, tying that to a struct
file * means we have an implicit limit.

Code below.  Feedback welcome.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Waker can unpin page, rather than waiting process
Author: Rusty Russell
Status: Tested in 2.5.20
Depends: Futex/copy-from-user.patch.gz Futex/unpin-page-fix.patch.gz
Depends: Futex/waitq.patch.gz

D: This changes the implementation so that the waker actually unpins
D: the page.  This is preparation for the async interface, where the
D: process which registered interest is not in the kernel.


diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.20.19104/kernel/futex.c linux-2.5.20.19104.updated/kernel/futex.c
--- linux-2.5.20.19104/kernel/futex.c	Thu Jun  6 17:13:46 2002
+++ linux-2.5.20.19104.updated/kernel/futex.c	Thu Jun  6 17:14:30 2002
@@ -98,11 +98,13 @@
 		if (this->page == page && this->offset == offset) {
 			list_del_init(i);
 			tell_waiter(this);
+			unpin_page(this->page);
 			num_woken++;
 			if (num_woken >= num) break;
 		}
 	}
 	spin_unlock(&futex_lock);
+	unpin_page(page);
 	return num_woken;
 }
 
@@ -192,9 +194,10 @@
 	}
  out:
 	set_current_state(TASK_RUNNING);
-	/* Were we woken up anyway? */
+	/* Were we woken up anyway?  If so, it unpinned page. */
 	if (!unqueue_me(&q))
 		return 0;
+	unpin_page(page);
 	return ret;
 }
 
@@ -225,6 +228,7 @@
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
+	/* On success, these routines unpin the pages themselves. */
 	head = hash_futex(page, pos_in_page);
 	switch (op) {
 	case FUTEX_WAIT:
@@ -236,7 +240,8 @@
 	default:
 		ret = -EINVAL;
 	}
-	unpin_page(page);
+	if (ret < 0)
+		unpin_page(page);
 
 	return ret;
 }
Name: Asynchronous interface for futexes
Author: Rusty Russell
Status: Tested on 2.5.20
Depends: Futex/comment-fix.patch.gz Futex/copy-from-user.patch.gz
Depends: Futex/no-write-needed.patch.gz Futex/unpin-page-fix.patch.gz
Depends: Futex/waitq.patch.gz Futex/waker-unpin-page.patch.gz

D: This patch adds a FUTEX_AWAIT and /dev/futex, for attaching futexes
D: to file descriptors, which can be used with poll, select or SIGIO.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.20.15557/include/linux/futex.h linux-2.5.20.15557.updated/include/linux/futex.h
--- linux-2.5.20.15557/include/linux/futex.h	Sat May 25 14:34:59 2002
+++ linux-2.5.20.15557.updated/include/linux/futex.h	Wed Jun  5 22:01:44 2002
@@ -4,5 +4,6 @@
 /* Second argument to futex syscall */
 #define FUTEX_WAIT (0)
 #define FUTEX_WAKE (1)
+#define FUTEX_AWAIT (2)
 
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.20.15557/kernel/futex.c linux-2.5.20.15557.updated/kernel/futex.c
--- linux-2.5.20.15557/kernel/futex.c	Wed Jun  5 22:01:41 2002
+++ linux-2.5.20.15557.updated/kernel/futex.c	Wed Jun  5 22:02:09 2002
@@ -34,6 +34,10 @@
 #include <linux/highmem.h>
 #include <linux/time.h>
 #include <linux/pagemap.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/poll.h>
 #include <asm/uaccess.h>
 
 /* Simple "sleep if unchanged" interface. */
@@ -41,11 +45,18 @@
 /* FIXME: This may be way too small. --RR */
 #define FUTEX_HASHBITS 6
 
+extern void send_sigio(struct fown_struct *fown, int fd, int band);
+
 /* We use this instead of a normal wait_queue_t, so we can wake only
    the relevent ones (hashed queues may be shared) */
 struct futex_q {
 	struct list_head list;
 	wait_queue_head_t waiters;
+
+	/* For AWAIT, sigio sent using these. */
+	int fd;
+	struct file *filp;
+
 	/* Page struct and offset within it. */
 	struct page *page;
 	unsigned int offset;
@@ -54,6 +65,7 @@
 /* The key for the hash is the address + index + offset within page */
 static struct list_head futex_queues[1<<FUTEX_HASHBITS];
 static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
+extern struct file_operations futex_fops;
 
 static inline struct list_head *hash_futex(struct page *page,
 					   unsigned long offset)
@@ -73,9 +85,12 @@
 	page_cache_release(page);
 }
 
+/* Waiter may be sitting in FUTEX_WAIT or poll, or async */
 static inline void tell_waiter(struct futex_q *q)
 {
 	wake_up_all(&q->waiters);
+	if (q->fd != -1)
+		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
 }
 
 static int futex_wake(struct list_head *head,
@@ -113,6 +128,7 @@
 	add_wait_queue(&q->waiters, wait);
 	q->page = page;
 	q->offset = offset;
+	q->fd = -1;
 
 	spin_lock(&futex_lock);
 	list_add_tail(&q->list, head);
@@ -196,6 +212,38 @@
 	return ret;
 }
 
+static int futex_await(struct list_head *head,
+		       struct page *page,
+		       int offset,
+		       int fd)
+{
+	struct file *filp;
+	struct futex_q *q;
+
+	filp = fget(fd);
+	if (!filp || filp->f_op != &futex_fops)
+		return -EBADF;
+	q = filp->private_data;
+
+	spin_lock(&futex_lock);
+	/* Eliminate any old notification, wake any pollers, release page. */
+	if (!list_empty(&q->list)) {
+		list_del(&q->list);
+		wake_up_all(&q->waiters);
+		unpin_page(q->page);
+	}
+
+	q->filp = filp;
+	q->fd = fd;
+	q->page = page;
+	q->offset = offset;
+	list_add_tail(&q->list, head);
+	spin_unlock(&futex_lock);
+	fput(filp);
+
+	return 0;
+}
+
 asmlinkage int sys_futex(void *uaddr, int op, int val, struct timespec *utime)
 {
 	int ret;
@@ -229,6 +277,9 @@
 	case FUTEX_WAIT:
 		ret = futex_wait(head, page, pos_in_page, val, uaddr, time);
 		break;
+	case FUTEX_AWAIT:
+		ret = futex_await(head, page, pos_in_page, val);
+		break;
 	case FUTEX_WAKE:
 		ret = futex_wake(head, page, pos_in_page, val);
 		break;
@@ -241,12 +292,68 @@
 	return ret;
 }
 
+static int futex_open(struct inode *inode, struct file *filp)
+{
+	struct futex_q *q;
+
+	q = kmalloc(sizeof(*q), GFP_KERNEL);
+	if (!q)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&q->list);
+	init_waitqueue_head(&q->waiters);
+
+	filp->private_data = q;
+	return 0;
+}
+
+static int futex_close(struct inode *inode, struct file *filp)
+{
+	struct futex_q *q = filp->private_data;
+
+	spin_lock(&futex_lock);
+	if (!list_empty(&q->list)) {
+		list_del(&q->list);
+		unpin_page(q->page);
+		BUG_ON(waitqueue_active(&q->waiters));
+	}
+	spin_unlock(&futex_lock);
+	kfree(filp->private_data);
+	return 0;
+}
+
+/* You need to do a FUTEX_AWAIT to arm this after each successful poll */
+static unsigned int futex_poll(struct file *filp,
+			       struct poll_table_struct *wait)
+{
+	struct futex_q *q = filp->private_data;
+	int ret = 0;
+
+	spin_lock(&futex_lock);
+	if (!list_empty(&q->list))
+		poll_wait(filp, &q->waiters, wait);
+	else
+		ret = POLLIN | POLLRDNORM;
+	spin_unlock(&futex_lock);
+
+	return ret;
+}
+
+static struct file_operations futex_fops = {
+	open:		futex_open,
+	release:	futex_close,
+	poll:		futex_poll,
+};
+
 static int __init init(void)
 {
+	int futex_major;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(futex_queues); i++)
 		INIT_LIST_HEAD(&futex_queues[i]);
+	futex_major = devfs_register_chrdev(0, "futex", &futex_fops);
+	devfs_register(NULL, "futex", DEVFS_FL_NONE, futex_major,
+		       0, S_IFCHR | 0666, &futex_fops, NULL);
 	return 0;
 }
 __initcall(init);

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSFLFch>; Wed, 12 Jun 2002 01:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317631AbSFLFcg>; Wed, 12 Jun 2002 01:32:36 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:59083 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317603AbSFLFcd>; Wed, 12 Jun 2002 01:32:33 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
        alan@lxorguk.ukuu.org.uk, viro@math.psu.edu
Subject: Re: [PATCH] Futex Asynchronous Interface 
In-Reply-To: Your message of "Tue, 11 Jun 2002 09:53:14 MST."
             <Pine.LNX.4.44.0206110951380.2712-100000@home.transmeta.com> 
Date: Wed, 12 Jun 2002 15:32:01 +1000
Message-Id: <E17I0ji-0004xO-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0206110951380.2712-100000@home.transmeta.com> you wri
te:
> 
> Rusty,
>  this makes no sense:
> 
> D: This changes the implementation so that the waker actually unpins
> D: the page.  This is preparation for the async interface, where the
> D: process which registered interest is not in the kernel.
> 
> Whazzup? The closing of the fd will unpin the page, the waker has no
> reason to do so. It is very much against the linux philosophy (and a
> design disaster anyway) to have the waker muck with the data structures of
> anything waiting.

Good catch: now the fd is a "one-shot" thing anyway, making close
unpin the page makes more sense.  Tested patch below (against 2.5.21).

FYI: I already violate this philosophy as I remove the waiter from the
queue when I wake them: this allows them to tell that they were woken
(waker does a list_del_init() on the waiting entry, so waiting knows
if (list_empty()) I was woken).

It would be more natural for the waiter to examine the futex value,
and if it's still unchanged go back to sleep.  But this makes
assumptions about what they're using the futex value for.  For
example, we "PASS_THIS_DIRECTLY" value into the futex.  This requires
that one (and ONLY one) process waiting actually wakes up.

This is why coming up with a primitive which allowed us to build posix
threads and fair queueing as well as "normal" unfair semantics took so
damn long.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/include/linux/futex.h working-2.5.21-afutex/include/linux/futex.h
--- linux-2.5.21/include/linux/futex.h	Sat May 25 14:34:59 2002
+++ working-2.5.21-afutex/include/linux/futex.h	Wed Jun 12 12:32:18 2002
@@ -4,5 +4,6 @@
 /* Second argument to futex syscall */
 #define FUTEX_WAIT (0)
 #define FUTEX_WAKE (1)
+#define FUTEX_FD (2)
 
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/kernel/futex.c working-2.5.21-afutex/kernel/futex.c
--- linux-2.5.21/kernel/futex.c	Mon Jun 10 16:03:56 2002
+++ working-2.5.21-afutex/kernel/futex.c	Wed Jun 12 14:10:41 2002
@@ -34,6 +34,10 @@
 #include <linux/highmem.h>
 #include <linux/time.h>
 #include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/file.h>
+#include <linux/dcache.h>
 #include <asm/uaccess.h>
 
 /* Simple "sleep if unchanged" interface. */
@@ -41,6 +45,11 @@
 /* FIXME: This may be way too small. --RR */
 #define FUTEX_HASHBITS 6
 
+extern void send_sigio(struct fown_struct *fown, int fd, int band);
+
+/* Everyone needs a dentry and inode */
+static struct dentry *futex_dentry;
+
 /* We use this instead of a normal wait_queue_t, so we can wake only
    the relevent ones (hashed queues may be shared) */
 struct futex_q {
@@ -49,6 +58,9 @@
 	/* Page struct and offset within it. */
 	struct page *page;
 	unsigned int offset;
+	/* For fd, sigio sent using these. */
+	int fd;
+	struct file *filp;
 };
 
 /* The key for the hash is the address + index + offset within page */
@@ -65,9 +77,20 @@
 	return &futex_queues[hash_long(h, FUTEX_HASHBITS)];
 }
 
+/* Waiter either waiting in FUTEX_WAIT or poll(), or expecting signal */
 static inline void tell_waiter(struct futex_q *q)
 {
 	wake_up_all(&q->waiters);
+	if (q->filp)
+		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
+}
+
+static inline void unpin_page(struct page *page)
+{
+	/* Avoid releasing the page which is on the LRU list.  I don't
+           know if this is correct, but it stops the BUG() in
+           __free_pages_ok(). */
+	page_cache_release(page);
 }
 
 static int futex_wake(struct list_head *head,
@@ -95,14 +118,16 @@
 
 /* Add at end to avoid starvation */
 static inline void queue_me(struct list_head *head,
-			    wait_queue_t *wait,
 			    struct futex_q *q,
 			    struct page *page,
-			    unsigned int offset)
+			    unsigned int offset,
+			    int fd,
+			    struct file *filp)
 {
-	add_wait_queue(&q->waiters, wait);
 	q->page = page;
 	q->offset = offset;
+	q->fd = fd;
+	q->filp = filp;
 
 	spin_lock(&futex_lock);
 	list_add_tail(&q->list, head);
@@ -130,9 +155,9 @@
 	int err;
 
 	down_read(&mm->mmap_sem);
-	err = get_user_pages(current, current->mm, page_start,
+	err = get_user_pages(current, mm, page_start,
 			     1 /* one page */,
-			     1 /* writable */,
+			     0 /* writable not important */,
 			     0 /* don't force */,
 			     &page,
 			     NULL /* don't return vmas */);
@@ -156,7 +181,9 @@
 	int ret = 0;
 
 	set_current_state(TASK_INTERRUPTIBLE);
-	queue_me(head, &wait, &q, page, offset);
+	init_waitqueue_head(&q.waiters);
+	add_wait_queue(&q.waiters, &wait);
+	queue_me(head, &q, page, offset, -1, NULL);
 
 	/* Page is pinned, but may no longer be in this address space. */
 	if (get_user(curval, uaddr) != 0) {
@@ -185,6 +212,93 @@
 	return ret;
 }
 
+static int futex_close(struct inode *inode, struct file *filp)
+{
+	struct futex_q *q = filp->private_data;
+
+	spin_lock(&futex_lock);
+	if (!list_empty(&q->list)) {
+		list_del(&q->list);
+		/* Noone can be polling on us now. */
+		BUG_ON(waitqueue_active(&q->waiters));
+	}
+	spin_unlock(&futex_lock);
+	unpin_page(q->page);
+	kfree(filp->private_data);
+	return 0;
+}
+
+/* This is one-shot: once it's gone off you need a new fd */
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
+	release:	futex_close,
+	poll:		futex_poll,
+};
+
+/* Signal allows caller to avoid the race which would occur if they
+   set the sigio stuff up afterwards. */
+static int futex_fd(struct list_head *head,
+		    struct page *page,
+		    int offset,
+		    int signal)
+{
+	int fd;
+	struct futex_q *q;
+	struct file *filp;
+
+	if (signal < 0 || signal > _NSIG)
+		return -EINVAL;
+
+	fd = get_unused_fd();
+	if (fd < 0)
+		return fd;
+	filp = get_empty_filp();
+	if (!filp) {
+		put_unused_fd(fd);
+		return -ENFILE;
+	}
+	filp->f_op = &futex_fops;
+	filp->f_dentry = dget(futex_dentry);
+
+	if (signal) {
+		filp->f_owner.pid = current->pid;
+		filp->f_owner.uid = current->uid;
+		filp->f_owner.euid = current->euid;
+		filp->f_owner.signum = signal;
+	}
+
+	q = kmalloc(sizeof(*q), GFP_KERNEL);
+	if (!q) {
+		put_unused_fd(fd);
+		put_filp(filp);
+		return -ENOMEM;
+	}
+
+	/* Initialize queue structure, and add to hash table. */
+	filp->private_data = q;
+	init_waitqueue_head(&q->waiters);
+	queue_me(head, q, page, offset, fd, filp);
+
+	/* Now we map fd to filp, so userspace can access it */
+	fd_install(fd, filp);
+	return fd;
+}
+
 asmlinkage int sys_futex(void *uaddr, int op, int val, struct timespec *utime)
 {
 	int ret;
@@ -220,17 +334,70 @@
 	case FUTEX_WAKE:
 		ret = futex_wake(head, page, pos_in_page, val);
 		break;
+	case FUTEX_FD:
+		/* non-zero val means F_SETOWN(getpid()) & F_SETSIG(val) */
+		ret = futex_fd(head, page, pos_in_page, val);
+		if (ret >= 0)
+			/* Leave page pinned (attached to fd). */
+			return ret;
+		break;
 	default:
 		ret = -EINVAL;
 	}
-	page_cache_release(page);
+	unpin_page(page);
 
 	return ret;
 }
 
+/* FIXME: Oh yeah, makes sense to write a filesystem... */
+static struct super_operations futexfs_ops = { statfs: simple_statfs };
+
+/* Don't check error returns: we're dead if they happen */
+static int futexfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct inode *root;
+
+	sb->s_blocksize = 1024;
+	sb->s_blocksize_bits = 10;
+	sb->s_magic = 0xBAD1DEA;
+	sb->s_op = &futexfs_ops;
+
+	root = new_inode(sb);
+	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
+	root->i_uid = root->i_gid = 0;
+	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
+
+	sb->s_root = d_alloc(NULL, &(const struct qstr) { "futex", 5, 0 });
+	sb->s_root->d_sb = sb;
+	sb->s_root->d_parent = sb->s_root;
+	d_instantiate(sb->s_root, root);
+
+	/* We never let this drop to zero. */
+	futex_dentry = dget(sb->s_root);
+
+	return 0;
+}
+
+static struct super_block *
+futexfs_get_sb(struct file_system_type *fs_type,
+	       int flags, char *dev_name, void *data)
+{
+	return get_sb_nodev(fs_type, flags, data, futexfs_fill_super);
+}
+
+static struct file_system_type futex_fs_type = {
+	name:		"futexfs",
+	get_sb:		futexfs_get_sb,
+	kill_sb:	kill_anon_super,
+	fs_flags:	FS_NOMOUNT,
+};
+
 static int __init init(void)
 {
 	unsigned int i;
+
+	register_filesystem(&futex_fs_type);
+	kern_mount(&futex_fs_type);
 
 	for (i = 0; i < ARRAY_SIZE(futex_queues); i++)
 		INIT_LIST_HEAD(&futex_queues[i]);

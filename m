Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316964AbSFKJO7>; Tue, 11 Jun 2002 05:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316969AbSFKJO6>; Tue, 11 Jun 2002 05:14:58 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:61641 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316964AbSFKJOr>; Tue, 11 Jun 2002 05:14:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
        alan@lxorguk.ukuu.org.uk, viro@math.psu.edu
Subject: Re: [PATCH] Futex Asynchronous Interface 
In-Reply-To: Your message of "Sat, 08 Jun 2002 15:42:59 MST."
             <Pine.LNX.4.44.0206081531550.11630-100000@home.transmeta.com> 
Date: Tue, 11 Jun 2002 19:15:43 +1000
Message-Id: <E17Hhke-0007rs-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0206081531550.11630-100000@home.transmeta.com> you wr
ite:
> 
> 
> On Fri, 7 Jun 2002, Rusty Russell wrote:
> >
> > Linus, Al, is there an easier way to do this?  I stole this from sockfs,
> > but I balked at another 50 lines for a proper inode creation, so I just use
> > the same dentry and inode over and over.
> 
> There's nothing inherently wrong with re-using the inode and dentry -
> that's what /dev/futex would do too, of course.
> 
> > It's still an awful lot of irrelevant code: what can I cut?
> 
> I don't think it's a matter of cutting, as much as possibly a matter of
> tryign to share some common code. pipefs, sockfs and now this: they all do
> pretty much exactly the same thing, and there is nothing that says that
> they should have separate super_operations, for example, since they are
> all identical.

Yeah, that's a nice idea.  But sockfs is sufficiently different that
it's probably not worth it.  Left for Al's larger brain.

Here's the new (tested) futex patch (actually 4 minipatches but patch
-p1 < msg works fine).

Updated futex library at:
  http://www.[cc].kernel.org/pub/linux/kernel/people/rusty/futex-2.2.tar.gz

Name: Remove requirement for page to be writable.
Author: Rusty Russell
Status: Trivial

D: It's possible that someone could be passively monitoring: write
D: access is no longer strictly required (since new futex implementation).

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.20/kernel/futex.c working-2.5.20-afutex/kernel/futex.c
--- linux-2.5.20/kernel/futex.c	Sat May 25 14:35:00 2002
+++ working-2.5.20-afutex/kernel/futex.c	Wed Jun  5 18:42:17 2002
@@ -128,9 +158,9 @@
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

Name: Unpin page bug fix.
Author: Rusty Russell
Status: Tested on 2.5.20

D: This uses page_cache_release() instead of put_page(), as it might
D: be a pagecache page.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21.23289/kernel/futex.c linux-2.5.21.23289.updated/kernel/futex.c
--- linux-2.5.21.23289/kernel/futex.c	Mon Jun 10 16:03:56 2002
+++ linux-2.5.21.23289.updated/kernel/futex.c	Mon Jun 10 17:10:10 2002
@@ -70,6 +70,14 @@
 	wake_up_all(&q->waiters);
 }
 
+static inline void unpin_page(struct page *page)
+{
+	/* Avoid releasing the page which is on the LRU list.  I don't
+           know if this is correct, but it stops the BUG() in
+           __free_pages_ok(). */
+	page_cache_release(page);
+}
+
 static int futex_wake(struct list_head *head,
 		      struct page *page,
 		      unsigned int offset,
@@ -223,7 +231,7 @@
 	default:
 		ret = -EINVAL;
 	}
-	page_cache_release(page);
+	unpin_page(page);
 
 	return ret;
 }

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

Name: New asynchronous interface for futexes
Author: Rusty Russell
Status: Tested on 2.5.20
Depends: Futex/comment-fix.patch.gz Futex/copy-from-user.patch.gz
Depends: Futex/no-write-needed.patch.gz Futex/unpin-page-fix.patch.gz
Depends: Futex/waitq.patch.gz Futex/waker-unpin-page.patch.gz

D: This patch adds a FUTEX_FD call, for opening a file descriptor 
D: attached to a futex, which can be used with poll, select or SIGIO.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.21-pre-afutex/include/linux/futex.h working-2.5.21-afutex/include/linux/futex.h
--- working-2.5.21-pre-afutex/include/linux/futex.h	Sat May 25 14:34:59 2002
+++ working-2.5.21-afutex/include/linux/futex.h	Tue Jun 11 13:25:52 2002
@@ -4,5 +4,6 @@
 /* Second argument to futex syscall */
 #define FUTEX_WAIT (0)
 #define FUTEX_WAKE (1)
+#define FUTEX_FD (2)
 
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.21-pre-afutex/kernel/futex.c working-2.5.21-afutex/kernel/futex.c
--- working-2.5.21-pre-afutex/kernel/futex.c	Tue Jun 11 13:20:06 2002
+++ working-2.5.21-afutex/kernel/futex.c	Tue Jun 11 13:26:46 2002
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
@@ -65,9 +77,12 @@
 	return &futex_queues[hash_long(h, FUTEX_HASHBITS)];
 }
 
+/* Waiter either waiting in FUTEX_WAIT or poll(), or expecting signal */
 static inline void tell_waiter(struct futex_q *q)
 {
 	wake_up_all(&q->waiters);
+	if (q->filp)
+		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
 }
 
 static inline void unpin_page(struct page *page)
@@ -105,14 +120,16 @@
 
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
@@ -166,7 +183,9 @@
 	int ret = 0;
 
 	set_current_state(TASK_INTERRUPTIBLE);
-	queue_me(head, &wait, &q, page, offset);
+	init_waitqueue_head(&q.waiters);
+	add_wait_queue(&q.waiters, &wait);
+	queue_me(head, &q, page, offset, -1, NULL);
 
 	/* Page is pinned, but may no longer be in this address space. */
 	if (get_user(curval, uaddr) != 0) {
@@ -196,6 +215,95 @@
 	return ret;
 }
 
+static int futex_close(struct inode *inode, struct file *filp)
+{
+	struct futex_q *q = filp->private_data;
+
+	spin_lock(&futex_lock);
+	if (!list_empty(&q->list)) {
+		list_del(&q->list);
+		unpin_page(q->page);
+		/* Noone can be polling on us now. */
+		BUG_ON(waitqueue_active(&q->waiters));
+	}
+	spin_unlock(&futex_lock);
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
+	/* Initialize queue structure */
+	init_waitqueue_head(&q->waiters);
+	filp->private_data = q;
+
+	/* Go for it... */
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
@@ -232,6 +340,10 @@
 	case FUTEX_WAKE:
 		ret = futex_wake(head, page, pos_in_page, val);
 		break;
+	case FUTEX_FD:
+		/* non-zero val means F_SETOWN(getpid()) & F_SETSIG(val) */
+		ret = futex_fd(head, page, pos_in_page, val);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -241,9 +353,55 @@
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

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262335AbSKCT1r>; Sun, 3 Nov 2002 14:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262370AbSKCT1q>; Sun, 3 Nov 2002 14:27:46 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:6276 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262335AbSKCT0g>; Sun, 3 Nov 2002 14:26:36 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 3 Nov 2002 11:42:52 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] total-epoll r3 ...
Message-ID: <Pine.LNX.4.44.0211031132090.954-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changes :

*) EP_CTL_MOD drops an event if conditions events are met

*) The source file eventpoll.c moved from drivers/char to fs

*) Fixed a weirdness with tty's


Missing : system calls for arch != i386 ...


The patch looks stable on my UP and 2SMP. It ran all night with multiple
http servers and pipetest running w/out problems.



- Davide



drivers/char/Makefile     |    4
drivers/char/eventpoll.c  | 1438 ----------------------------------------------
fs/Makefile               |    4
fs/eventpoll.c            | 1293 +++++++++++++++++++++++++++++++++++++++++
fs/fcblist.c              |  146 ----
fs/file_table.c           |    6
fs/pipe.c                 |   36 -
fs/select.c               |    8
include/linux/eventpoll.h |   34 -
include/linux/fcblist.h   |   71 --
include/linux/fs.h        |    4
include/linux/pipe_fs_i.h |    4
include/linux/poll.h      |   18
include/net/sock.h        |   12
net/ipv4/tcp.c            |    4
15 files changed, 1342 insertions, 1740 deletions





diff -Nru linux-2.5.45.vanilla/drivers/char/Makefile linux-2.5.45.epoll/drivers/char/Makefile
--- linux-2.5.45.vanilla/drivers/char/Makefile	Wed Oct 30 16:43:43 2002
+++ linux-2.5.45.epoll/drivers/char/Makefile	Sun Nov  3 10:19:18 2002
@@ -7,14 +7,14 @@
 #
 FONTMAPFILE = cp437.uni

-obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o random.o eventpoll.o
+obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o random.o

 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.

 export-objs     :=	busmouse.o vt.o generic_serial.o ip2main.o \
 			ite_gpio.o keyboard.o misc.o nvram.o random.o rtc.o \
-			selection.o sonypi.o sysrq.o tty_io.o tty_ioctl.o eventpoll.o
+			selection.o sonypi.o sysrq.o tty_io.o tty_ioctl.o

 obj-$(CONFIG_VT) += vt_ioctl.o vc_screen.o consolemap.o consolemap_deftbl.o selection.o keyboard.o
 obj-$(CONFIG_HW_CONSOLE) += vt.o defkeymap.o
diff -Nru linux-2.5.45.vanilla/drivers/char/eventpoll.c linux-2.5.45.epoll/drivers/char/eventpoll.c
--- linux-2.5.45.vanilla/drivers/char/eventpoll.c	Wed Oct 30 16:42:27 2002
+++ linux-2.5.45.epoll/drivers/char/eventpoll.c	Wed Dec 31 16:00:00 1969
@@ -1,1438 +0,0 @@
-/*
- *  drivers/char/eventpoll.c ( Efficent event polling implementation )
- *  Copyright (C) 2001,...,2002  Davide Libenzi
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  Davide Libenzi <davidel@xmailserver.org>
- *
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include <linux/signal.h>
-#include <linux/errno.h>
-#include <linux/mm.h>
-#include <linux/vmalloc.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-#include <linux/miscdevice.h>
-#include <linux/random.h>
-#include <linux/smp_lock.h>
-#include <linux/wrapper.h>
-#include <linux/string.h>
-#include <linux/list.h>
-#include <linux/spinlock.h>
-#include <linux/wait.h>
-#include <linux/fcblist.h>
-#include <linux/rwsem.h>
-#include <asm/bitops.h>
-#include <asm/uaccess.h>
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/mman.h>
-#include <asm/atomic.h>
-#include <linux/eventpoll.h>
-
-
-
-#define EVENTPOLLFS_MAGIC 0x03111965 /* My birthday should work for this :) */
-
-#define DEBUG_EPOLL 0
-
-#if DEBUG_EPOLL > 0
-#define DPRINTK(x) printk x
-#define DNPRINTK(n, x) do { if ((n) <= DEBUG_EPOLL) printk x; } while (0)
-#else /* #if DEBUG_EPOLL > 0 */
-#define DPRINTK(x) (void) 0
-#define DNPRINTK(n, x) (void) 0
-#endif /* #if DEBUG_EPOLL > 0 */
-
-#define DEBUG_DPI 0
-
-#if DEBUG_DPI != 0
-#define DPI_SLAB_DEBUG (SLAB_DEBUG_FREE | SLAB_RED_ZONE /* | SLAB_POISON */)
-#else /* #if DEBUG_DPI != 0 */
-#define DPI_SLAB_DEBUG 0
-#endif /* #if DEBUG_DPI != 0 */
-
-#define INITIAL_HASH_BITS 7
-#define MAX_HASH_BITS 18
-#define RESIZE_LENGTH 2
-
-#define DPI_MEM_ALLOC()	(struct epitem *) kmem_cache_alloc(dpi_cache, SLAB_KERNEL)
-#define DPI_MEM_FREE(p) kmem_cache_free(dpi_cache, p)
-#define IS_FILE_EPOLL(f) ((f)->f_op == &eventpoll_fops)
-
-
-/*
- * Type used for versioning events snapshots inside the double buffer.
- */
-typedef unsigned long long event_version_t;
-
-/*
- * This structure is stored inside the "private_data" member of the file
- * structure and rapresent the main data sructure for the eventpoll
- * interface.
- */
-struct eventpoll {
-	/*
-	 * Protect the evenpoll interface from sys_epoll_ctl(2), ioctl(EP_POLL)
-	 * and ->write() concurrency. It basically serialize the add/remove/edit
-	 * of items in the interest set.
-	 */
-	struct rw_semaphore acsem;
-
-	/*
-	 * Protect the this structure access. When the "acsem" is acquired
-	 * togheter with this one, "acsem" should be acquired first. Or,
-	 * "lock" nests inside "acsem".
-	 */
-	rwlock_t lock;
-
-	/* Wait queue used by sys_epoll_wait() and ioctl(EP_POLL) */
-	wait_queue_head_t wq;
-
-	/* Wait queue used by file->poll() */
-	wait_queue_head_t poll_wait;
-
-	/* This is the hash used to store the "struct epitem" elements */
-	struct list_head *hash;
-
-	unsigned int hbits;
-	unsigned int hmask;
-	atomic_t hents;
-	atomic_t resize;
-
-	/* Number of pages currently allocated in each side of the double buffer */
-	int numpages;
-
-	/*
-	 * Current page set pointer, switched from "pages0" and "pages1" each time
-	 * ep_poll() returns events to the caller.
-	 */
-	char **pages;
-
-	/* Each one of these contains the pages allocated for each side of
-	 * the double buffer.
-	 */
-	char *pages0[MAX_EVENTPOLL_PAGES];
-	char *pages1[MAX_EVENTPOLL_PAGES];
-
-	/*
-	 * Variable containing the vma base address where the double buffer
-	 * pages are mapped onto.
-	 */
-	unsigned long vmabase;
-
-	/*
-	 * Certain functions cannot be called if the double buffer pages are
-	 * not allocated and if the memory mapping is not in place. This tells
-	 * us that everything is setup to fully use the interface.
-	 */
-	atomic_t mmapped;
-
-	/* Number of events currently available inside the current snapshot */
-	int eventcnt;
-
-	/*
-	 * Variable storing the current "version" of the snapshot. It is used
-	 * to validate the validity of the current slot pointed by the "index"
-	 * member of a "struct epitem".
-	 */
-	event_version_t ver;
-};
-
-/*
- * Each file descriptor added to the eventpoll interface will
- * have an entry of this type linked to the hash.
- */
-struct epitem {
-	/* List header used to link this structure to the eventpoll hash */
-	struct list_head llink;
-
-	/* The "container" of this item */
-	struct eventpoll *ep;
-
-	/* The file this item refers to */
-	struct file *file;
-
-	/* The structure that describe the interested events and the source fd */
-	struct pollfd pfd;
-
-	/*
-	 * The index inside the current double buffer that stores the active
-	 * event slot for this item ( file ).
-	 */
-	int index;
-
-	/*
-	 * The version that is used to validate if the current slot is still
-	 * valid or if it refers to an old snapshot. It is matches togheter
-	 * with the one inside the eventpoll structure.
-	 */
-	event_version_t ver;
-};
-
-
-
-
-static int ep_getfd(int *efd, struct inode **einode, struct file **efile);
-static int ep_alloc_pages(char **pages, int numpages);
-static int ep_free_pages(char **pages, int numpages);
-static int ep_init(struct eventpoll *ep);
-static void ep_free(struct eventpoll *ep);
-static struct epitem *ep_find_nl(struct eventpoll *ep, int fd);
-static struct epitem *ep_find(struct eventpoll *ep, int fd);
-static int ep_hashresize(struct eventpoll *ep, unsigned long *kflags);
-static int ep_insert(struct eventpoll *ep, struct pollfd *pfd);
-static int ep_remove(struct eventpoll *ep, struct epitem *dpi);
-static void notify_proc(struct file *file, void *data, unsigned long *local,
-			long *event);
-static int open_eventpoll(struct inode *inode, struct file *file);
-static int close_eventpoll(struct inode *inode, struct file *file);
-static unsigned int poll_eventpoll(struct file *file, poll_table *wait);
-static int write_eventpoll(struct file *file, const char *buffer, size_t count,
-			   loff_t *ppos);
-static int ep_poll(struct eventpoll *ep, struct evpoll *dvp);
-static int ep_do_alloc_pages(struct eventpoll *ep, int numpages);
-static int ioctl_eventpoll(struct inode *inode, struct file *file,
-			   unsigned int cmd, unsigned long arg);
-static void eventpoll_mm_open(struct vm_area_struct * vma);
-static void eventpoll_mm_close(struct vm_area_struct * vma);
-static int mmap_eventpoll(struct file *file, struct vm_area_struct *vma);
-static int eventpollfs_delete_dentry(struct dentry *dentry);
-static struct inode *get_eventpoll_inode(void);
-static struct super_block *eventpollfs_get_sb(struct file_system_type *fs_type,
-					      int flags, char *dev_name, void *data);
-
-
-
-/* Slab cache used to allocate "struct epitem" */
-static kmem_cache_t *dpi_cache;
-
-/* Virtual fs used to allocate inodes for eventpoll files */
-static struct vfsmount *eventpoll_mnt;
-
-/* File callbacks that implement the eventpoll file behaviour */
-static struct file_operations eventpoll_fops = {
-	.write		= write_eventpoll,
-	.ioctl		= ioctl_eventpoll,
-	.mmap		= mmap_eventpoll,
-	.open		= open_eventpoll,
-	.release	= close_eventpoll,
-	.poll		= poll_eventpoll
-};
-
-/* Memory mapping callbacks for the eventpoll file */
-static struct vm_operations_struct eventpoll_mmap_ops = {
-	.open		= eventpoll_mm_open,
-	.close		= eventpoll_mm_close,
-};
-
-/*
- * The "struct miscdevice" is used to register the eventpoll device
- * to make it suitable to be openend from a /dev file.
- */
-static struct miscdevice eventpoll_miscdev = {
-	EVENTPOLL_MINOR, "eventpoll", &eventpoll_fops
-};
-
-/*
- * This is used to register the virtual file system from where
- * eventpoll inodes are allocated.
- */
-static struct file_system_type eventpoll_fs_type = {
-	.name		= "eventpollfs",
-	.get_sb		= eventpollfs_get_sb,
-	.kill_sb	= kill_anon_super,
-};
-
-/* Very basic directory entry operations for the eventpoll virtual file system */
-static struct dentry_operations eventpollfs_dentry_operations = {
-	.d_delete	= eventpollfs_delete_dentry,
-};
-
-
-
-/*
- * It opens an eventpoll file descriptor by allocating space for "maxfds"
- * file descriptors. It is the kernel part of the userspace epoll_create(2).
- */
-asmlinkage int sys_epoll_create(int maxfds)
-{
-	int error = -EINVAL, fd;
-	unsigned long addr;
-	struct inode *inode;
-	struct file *file;
-	struct eventpoll *ep;
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d)\n",
-		     current, maxfds));
-
-	/*
-	 * It is not possible to store more than MAX_FDS_IN_EVENTPOLL file
-	 * descriptors inside the eventpoll interface.
-	 */
-	if (maxfds > MAX_FDS_IN_EVENTPOLL)
-		goto eexit_1;
-
-	/*
-	 * Creates all the items needed to setup an eventpoll file. That is,
-	 * a file structure, and inode and a free file descriptor.
-	 */
-	error = ep_getfd(&fd, &inode, &file);
-	if (error)
-		goto eexit_1;
-
-	/*
-	 * Calls the code to initialize the eventpoll file. This code is
-	 * the same as the "open" file operation callback because inside
-	 * ep_getfd() we did what the kernel usually does before invoking
-	 * corresponding file "open" callback.
-	 */
-	error = open_eventpoll(inode, file);
-	if (error)
-		goto eexit_2;
-
-	/* The "private_data" member is setup by open_eventpoll() */
-	ep = file->private_data;
-
-	/* Alloc pages for the event double buffer */
-	error = ep_do_alloc_pages(ep, EP_FDS_PAGES(maxfds + 1));
-	if (error)
-		goto eexit_2;
-
-	/*
-	 * Create a user space mapping of the event double buffer to
-	 * avoid kernel to user space memory copy when returning events
-	 * to the caller.
-	 */
-	down_write(&current->mm->mmap_sem);
-	addr = do_mmap_pgoff(file, 0, EP_MAP_SIZE(maxfds + 1), PROT_READ,
-			     MAP_PRIVATE, 0);
-	up_write(&current->mm->mmap_sem);
-	error = PTR_ERR((void *) addr);
-	if (IS_ERR((void *) addr))
-		goto eexit_2;
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d) = %d\n",
-		     current, maxfds, fd));
-
-	return fd;
-
-eexit_2:
-	sys_close(fd);
-eexit_1:
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d) = %d\n",
-		     current, maxfds, error));
-	return error;
-}
-
-
-/*
- * The following function implement the controller interface for the eventpoll
- * file that enable the insertion/removal/change of file descriptors inside
- * the interest set. It rapresents the kernel part of the user spcae epoll_ctl(2).
- */
-asmlinkage int sys_epoll_ctl(int epfd, int op, int fd, unsigned int events)
-{
-	int error = -EBADF;
-	struct file *file;
-	struct eventpoll *ep;
-	struct epitem *dpi;
-	struct pollfd pfd;
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_ctl(%d, %d, %d, %u)\n",
-		     current, epfd, op, fd, events));
-
-	file = fget(epfd);
-	if (!file)
-		goto eexit_1;
-
-	/*
-	 * We have to check that the file structure underneath the file descriptor
-	 * the user passed to us _is_ an eventpoll file.
-	 */
-	error = -EINVAL;
-	if (!IS_FILE_EPOLL(file))
-		goto eexit_2;
-
-	/*
-	 * At this point it is safe to assume that the "private_data" contains
-	 * our own data structure.
-	 */
-	ep = file->private_data;
-
-	down_write(&ep->acsem);
-
-	pfd.fd = fd;
-	pfd.events = events | POLLERR | POLLHUP;
-	pfd.revents = 0;
-
-	dpi = ep_find(ep, fd);
-
-	error = -EINVAL;
-	switch (op) {
-	case EP_CTL_ADD:
-		if (!dpi)
-			error = ep_insert(ep, &pfd);
-		else
-			error = -EEXIST;
-		break;
-	case EP_CTL_DEL:
-		if (dpi)
-			error = ep_remove(ep, dpi);
-		else
-			error = -ENOENT;
-		break;
-	case EP_CTL_MOD:
-		if (dpi) {
-			dpi->pfd.events = events;
-			error = 0;
-		} else
-			error = -ENOENT;
-		break;
-	}
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_ctl(%d, %d, %d, %u) = %d\n",
-		     current, epfd, op, fd, events, error));
-
-	up_write(&ep->acsem);
-
-eexit_2:
-	fput(file);
-eexit_1:
-	return error;
-}
-
-
-/*
- * Implement the event wait interface for the eventpoll file. It is the kernel
- * part of the user space epoll_wait(2).
- */
-asmlinkage int sys_epoll_wait(int epfd, struct pollfd const **events, int timeout)
-{
-	int error = -EBADF;
-	void *eaddr;
-	struct file *file;
-	struct eventpoll *ep;
-	struct evpoll dvp;
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d)\n",
-		     current, epfd, events, timeout));
-
-	file = fget(epfd);
-	if (!file)
-		goto eexit_1;
-
-	/*
-	 * We have to check that the file structure underneath the file descriptor
-	 * the user passed to us _is_ an eventpoll file.
-	 */
-	error = -EINVAL;
-	if (!IS_FILE_EPOLL(file))
-		goto eexit_2;
-
-	/*
-	 * At this point it is safe to assume that the "private_data" contains
-	 * our own data structure.
-	 */
-	ep = file->private_data;
-
-	/*
-	 * It is possible that the user created an eventpoll file by open()ing
-	 * the corresponding /dev/ file and he did not perform the correct
-	 * initialization required by the old /dev/epoll interface. This test
-	 * protect us from this scenario.
-	 */
-	error = -EINVAL;
-	if (!atomic_read(&ep->mmapped))
-		goto eexit_2;
-
-	dvp.ep_timeout = timeout;
-	error = ep_poll(ep, &dvp);
-	if (error > 0) {
-		eaddr = (void *) (ep->vmabase + dvp.ep_resoff);
-		if (copy_to_user(events, &eaddr, sizeof(struct pollfd *)))
-			error = -EFAULT;
-	}
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d) = %d\n",
-		     current, epfd, events, timeout, error));
-
-eexit_2:
-	fput(file);
-eexit_1:
-	return error;
-}
-
-
-/*
- * Creates the file descriptor to be used by the epoll interface.
- */
-static int ep_getfd(int *efd, struct inode **einode, struct file **efile)
-{
-	struct qstr this;
-	char name[32];
-	struct dentry *dentry;
-	struct inode *inode;
-	struct file *file;
-	int error, fd;
-
-	/* Get an ready to use file */
-	error = -ENFILE;
-	file = get_empty_filp();
-	if (!file)
-		goto eexit_1;
-
-	/* Allocates an inode from the eventpoll file system */
-	inode = get_eventpoll_inode();
-	error = PTR_ERR(inode);
-	if (IS_ERR(inode))
-		goto eexit_2;
-
-	/* Allocates a free descriptor to plug the file onto */
-	error = get_unused_fd();
-	if (error < 0)
-		goto eexit_3;
-	fd = error;
-
-	/*
-	 * Link the inode to a directory entry by creating a unique name
-	 * using the inode number.
-	 */
-	error = -ENOMEM;
-	sprintf(name, "[%lu]", inode->i_ino);
-	this.name = name;
-	this.len = strlen(name);
-	this.hash = inode->i_ino;
-	dentry = d_alloc(eventpoll_mnt->mnt_sb->s_root, &this);
-	if (!dentry)
-		goto eexit_4;
-	dentry->d_op = &eventpollfs_dentry_operations;
-	d_add(dentry, inode);
-	file->f_vfsmnt = mntget(eventpoll_mnt);
-	file->f_dentry = dget(dentry);
-
-	/*
-	 * Initialize the file as read/write because it could be used
-	 * with write() to add/remove/change interest sets.
-	 */
-	file->f_pos = 0;
-	file->f_flags = O_RDWR;
-	file->f_op = &eventpoll_fops;
-	file->f_mode = FMODE_READ | FMODE_WRITE;
-	file->f_version = 0;
-	file->private_data = NULL;
-
-	/* Install the new setup file into the allocated fd. */
-	fd_install(fd, file);
-
-	*efd = fd;
-	*einode = inode;
-	*efile = file;
-	return 0;
-
-eexit_4:
-	put_unused_fd(fd);
-eexit_3:
-	iput(inode);
-eexit_2:
-	put_filp(file);
-eexit_1:
-	return error;
-}
-
-
-static int ep_alloc_pages(char **pages, int numpages)
-{
-	int ii;
-
-	for (ii = 0; ii < numpages; ii++) {
-		pages[ii] = (char *) __get_free_pages(GFP_KERNEL, 0);
-		if (!pages[ii]) {
-			for (--ii; ii >= 0; ii--) {
-				ClearPageReserved(virt_to_page(pages[ii]));
-				free_pages((unsigned long) pages[ii], 0);
-			}
-			return -ENOMEM;
-		}
-		SetPageReserved(virt_to_page(pages[ii]));
-	}
-	return 0;
-}
-
-
-static int ep_free_pages(char **pages, int numpages)
-{
-	int ii;
-
-	for (ii = 0; ii < numpages; ii++) {
-		ClearPageReserved(virt_to_page(pages[ii]));
-		free_pages((unsigned long) pages[ii], 0);
-	}
-	return 0;
-}
-
-
-static int ep_init(struct eventpoll *ep)
-{
-	int ii, hentries;
-
-	init_rwsem(&ep->acsem);
-	rwlock_init(&ep->lock);
-	init_waitqueue_head(&ep->wq);
-	init_waitqueue_head(&ep->poll_wait);
-	ep->hbits = INITIAL_HASH_BITS;
-	ep->hmask = (1 << ep->hbits) - 1;
-	atomic_set(&ep->hents, 0);
-	atomic_set(&ep->resize, 0);
-	atomic_set(&ep->mmapped, 0);
-	ep->numpages = 0;
-	ep->vmabase = 0;
-	ep->pages = ep->pages0;
-	ep->eventcnt = 0;
-	ep->ver = 1;
-
-	hentries = ep->hmask + 1;
-	if (!(ep->hash = (struct list_head *) vmalloc(hentries * sizeof(struct list_head))))
-		return -ENOMEM;
-
-	for (ii = 0; ii < hentries; ii++)
-		INIT_LIST_HEAD(&ep->hash[ii]);
-
-	return 0;
-}
-
-
-static void ep_free(struct eventpoll *ep)
-{
-	int ii;
-	struct list_head *lsthead;
-
-	/*
-	 * Walks through the whole hash by unregistering file callbacks and
-	 * freeing each "struct epitem".
-	 */
-	for (ii = 0; ii <= ep->hmask; ii++) {
-		lsthead = &ep->hash[ii];
-		while (!list_empty(lsthead)) {
-			struct epitem *dpi = list_entry(lsthead->next, struct epitem, llink);
-
-			file_notify_delcb(dpi->file, notify_proc);
-			list_del(lsthead->next);
-			DPI_MEM_FREE(dpi);
-		}
-	}
-	/*
-	 * At this point we can free the hash and the pages used for the event
-	 * double buffer. The ep_free() function is called from the "close"
-	 * file operations callback, and this garanties us that the pages are
-	 * already unmapped.
-	 */
-	vfree(ep->hash);
-	if (ep->numpages > 0) {
-		ep_free_pages(ep->pages0, ep->numpages);
-		ep_free_pages(ep->pages1, ep->numpages);
-	}
-}
-
-
-/*
- * No lock version of ep_find(), used when the code had to acquire the lock
- * before calling the function.
- */
-static struct epitem *ep_find_nl(struct eventpoll *ep, int fd)
-{
-	struct epitem *dpi = NULL;
-	struct list_head *lsthead, *lnk;
-
-	lsthead = &ep->hash[fd & ep->hmask];
-	list_for_each(lnk, lsthead) {
-		dpi = list_entry(lnk, struct epitem, llink);
-
-		if (dpi->pfd.fd == fd) break;
-		dpi = NULL;
-	}
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_find(%d) -> %p\n",
-		     current, fd, dpi));
-
-	return dpi;
-}
-
-
-static struct epitem *ep_find(struct eventpoll *ep, int fd)
-{
-	struct epitem *dpi;
-	unsigned long flags;
-
-	read_lock_irqsave(&ep->lock, flags);
-
-	dpi = ep_find_nl(ep, fd);
-
-	read_unlock_irqrestore(&ep->lock, flags);
-
-	return dpi;
-}
-
-
-static int ep_hashresize(struct eventpoll *ep, unsigned long *kflags)
-{
-	struct list_head *hash, *oldhash;
-	unsigned int hbits = ep->hbits + 1;
-	unsigned int hmask = (1 << hbits) - 1;
-	int ii, res, hentries = hmask + 1;
-	unsigned long flags = *kflags;
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_hashresize(%p) bits=%u\n",
-		     current, ep, hbits));
-
-	write_unlock_irqrestore(&ep->lock, flags);
-
-	res = -ENOMEM;
-	if (!(hash = (struct list_head *) vmalloc(hentries * sizeof(struct list_head)))) {
-		write_lock_irqsave(&ep->lock, flags);
-		goto eexit_1;
-	}
-
-	for (ii = 0; ii < hentries; ii++)
-		INIT_LIST_HEAD(&hash[ii]);
-
-	write_lock_irqsave(&ep->lock, flags);
-
-	oldhash = ep->hash;
-	for (ii = 0; ii <= ep->hmask; ii++) {
-		struct list_head *oldhead = &oldhash[ii], *lnk;
-
-		while (!list_empty(oldhead)) {
-			struct epitem *dpi = list_entry(lnk = oldhead->next, struct epitem, llink);
-
-			list_del(lnk);
-			list_add(lnk, &hash[dpi->pfd.fd & hmask]);
-		}
-	}
-
-	ep->hash = hash;
-	ep->hbits = hbits;
-	ep->hmask = hmask;
-
-	write_unlock_irqrestore(&ep->lock, flags);
-	vfree(oldhash);
-	write_lock_irqsave(&ep->lock, flags);
-
-	res = 0;
-eexit_1:
-	*kflags = flags;
-	atomic_dec(&ep->resize);
-	return res;
-}
-
-
-static int ep_insert(struct eventpoll *ep, struct pollfd *pfd)
-{
-	int error;
-	struct epitem *dpi;
-	struct file *file;
-	unsigned long flags;
-
-	if (atomic_read(&ep->hents) >= (ep->numpages * POLLFD_X_PAGE))
-		return -E2BIG;
-
-	file = fget(pfd->fd);
-	if (!file)
-		return -EBADF;
-
-	error = -ENOMEM;
-	if (!(dpi = DPI_MEM_ALLOC()))
-		goto eexit_1;
-
-	INIT_LIST_HEAD(&dpi->llink);
-	dpi->ep = ep;
-	dpi->file = file;
-	dpi->pfd = *pfd;
-	dpi->index = -1;
-	dpi->ver = ep->ver - 1;
-
-	write_lock_irqsave(&ep->lock, flags);
-
-	list_add(&dpi->llink, &ep->hash[pfd->fd & ep->hmask]);
-	atomic_inc(&ep->hents);
-
-	if (!atomic_read(&ep->resize) &&
-	    (atomic_read(&ep->hents) >> ep->hbits) > RESIZE_LENGTH &&
-	    ep->hbits < MAX_HASH_BITS) {
-		atomic_inc(&ep->resize);
-		ep_hashresize(ep, &flags);
-	}
-
-	write_unlock_irqrestore(&ep->lock, flags);
-
-	file_notify_addcb(file, notify_proc, dpi);
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_insert(%p, %d)\n",
-		     current, ep, pfd->fd));
-
-	error = 0;
-eexit_1:
-	fput(file);
-
-	return error;
-}
-
-
-/*
- * Removes a "struct epitem" from the eventpoll hash and deallocates
- * all the associated resources.
- */
-static int ep_remove(struct eventpoll *ep, struct epitem *dpi)
-{
-	unsigned long flags;
-	struct pollfd *pfd, *lpfd;
-	struct epitem *ldpi;
-
-	/* First, removes the callback from the file callback list */
-	file_notify_delcb(dpi->file, notify_proc);
-
-	write_lock_irqsave(&ep->lock, flags);
-
-	list_del(&dpi->llink);
-	atomic_dec(&ep->hents);
-
-	/*
-	 * This is to remove stale events. We don't want that the removed file
-	 * has a pending event that might be associated with a file inserted
-	 * at a later time inside the eventpoll interface. this code checks
-	 * if the currently removed file has a valid pending event and, if it does,
-	 * manages things to remove it and decrement the currently available
-	 * event count.
-	 */
-	if (dpi->index >= 0 && dpi->ver == ep->ver && dpi->index < ep->eventcnt) {
-		pfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(dpi->index)] +
-					 EVENT_PAGE_OFFSET(dpi->index));
-		if (pfd->fd == dpi->pfd.fd && dpi->index < --ep->eventcnt) {
-			lpfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(ep->eventcnt)] +
-						  EVENT_PAGE_OFFSET(ep->eventcnt));
-			*pfd = *lpfd;
-
-			if ((ldpi = ep_find_nl(ep, pfd->fd))) ldpi->index = dpi->index;
-		}
-	}
-
-	write_unlock_irqrestore(&ep->lock, flags);
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_remove(%p, %d)\n",
-		     current, ep, dpi->pfd.fd));
-
-	/* At this point it is safe to free the eventpoll item */
-	DPI_MEM_FREE(dpi);
-
-	return 0;
-}
-
-
-/*
- * This is the event notify callback that is called from fs/fcblist.c because
- * of the registration ( file_notify_addcb() ) done in ep_insert().
- */
-static void notify_proc(struct file *file, void *data, unsigned long *local,
-			long *event)
-{
-	struct epitem *dpi = data;
-	struct eventpoll *ep = dpi->ep;
-	struct pollfd *pfd;
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: notify(%p, %p, %ld, %ld) ep=%p\n",
-		     current, file, data, event[0], event[1], ep));
-
-	/*
-	 * We don't need to disable IRQs here because the callback dispatch
-	 * routine inside fs/fcblist.c already call us with disabled IRQ.
-	 */
-	write_lock(&ep->lock);
-
-	/* We're not expecting any of those events. Jump out soon ... */
-	if (!(dpi->pfd.events & event[1]))
-		goto out;
-
-	/*
-	 * This logic determins if an active even slot is available for the
-	 * currently signaled file, or if we have to make space for a new one
-	 * and increment the number of ready file descriptors ( ep->eventcnt ).
-	 */
-	if (dpi->index < 0 || dpi->ver != ep->ver) {
-		if (ep->eventcnt >= (ep->numpages * POLLFD_X_PAGE))
-			goto out;
-		dpi->index = ep->eventcnt++;
-		dpi->ver = ep->ver;
-		pfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(dpi->index)] +
-					 EVENT_PAGE_OFFSET(dpi->index));
-		*pfd = dpi->pfd;
-	} else {
-		pfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(dpi->index)] +
-					 EVENT_PAGE_OFFSET(dpi->index));
-		if (pfd->fd != dpi->pfd.fd) {
-			if (ep->eventcnt >= (ep->numpages * POLLFD_X_PAGE))
-				goto out;
-			dpi->index = ep->eventcnt++;
-			pfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(dpi->index)] +
-						 EVENT_PAGE_OFFSET(dpi->index));
-			*pfd = dpi->pfd;
-		}
-	}
-
-	/*
-	 * Merge event bits into the corresponding event slot inside the
-	 * double buffer.
-	 */
-	pfd->revents |= (pfd->events & event[1]);
-
-	/*
-	 * Wake up ( if active ) both the eventpoll wait list and the ->poll()
-	 * wait list.
-	 */
-	if (waitqueue_active(&ep->wq))
-		wake_up(&ep->wq);
-	if (waitqueue_active(&ep->poll_wait))
-		wake_up(&ep->poll_wait);
-out:
-	write_unlock(&ep->lock);
-}
-
-
-static int open_eventpoll(struct inode *inode, struct file *file)
-{
-	int res;
-	struct eventpoll *ep;
-
-	if (!(ep = kmalloc(sizeof(struct eventpoll), GFP_KERNEL)))
-		return -ENOMEM;
-
-	memset(ep, 0, sizeof(*ep));
-	if ((res = ep_init(ep))) {
-		kfree(ep);
-		return res;
-	}
-
-	file->private_data = ep;
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: open() ep=%p\n", current, ep));
-	return 0;
-}
-
-
-static int close_eventpoll(struct inode *inode, struct file *file)
-{
-	struct eventpoll *ep = file->private_data;
-
-	if (ep) {
-		ep_free(ep);
-		kfree(ep);
-	}
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: close() ep=%p\n", current, ep));
-	return 0;
-}
-
-
-static unsigned int poll_eventpoll(struct file *file, poll_table *wait)
-{
-	struct eventpoll *ep = file->private_data;
-
-	poll_wait(file, &ep->poll_wait, wait);
-	if (ep->eventcnt)
-		return POLLIN | POLLRDNORM;
-
-	return 0;
-}
-
-
-static int write_eventpoll(struct file *file, const char *buffer, size_t count,
-			   loff_t *ppos)
-{
-	int rcount;
-	struct eventpoll *ep = file->private_data;
-	struct epitem *dpi;
-	struct pollfd pfd;
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: write(%p, %d)\n", current, ep, count));
-
-	/* The size of the write must be a multiple of sizeof(struct pollfd) */
-	rcount = -EINVAL;
-	if (count % sizeof(struct pollfd))
-		goto eexit_1;
-
-	/*
-	 * And we have also to verify that that area is correctly accessible
-	 * for the user.
-	 */
-	if ((rcount = verify_area(VERIFY_READ, buffer, count)))
-		goto eexit_1;
-
-	down_write(&ep->acsem);
-
-	rcount = 0;
-
-	while (count > 0) {
-		if (__copy_from_user(&pfd, buffer, sizeof(pfd))) {
-			rcount = -EFAULT;
-			goto eexit_2;
-		}
-
-		dpi = ep_find(ep, pfd.fd);
-
-		if (pfd.fd >= current->files->max_fds || !current->files->fd[pfd.fd])
-			pfd.events = POLLREMOVE;
-		if (pfd.events & POLLREMOVE) {
-			if (dpi) {
-				ep_remove(ep, dpi);
-				rcount += sizeof(pfd);
-			}
-		}
-		else if (dpi) {
-			dpi->pfd.events = pfd.events;
-			rcount += sizeof(pfd);
-		} else {
-			pfd.revents = 0;
-			if (!ep_insert(ep, &pfd))
-				rcount += sizeof(pfd);
-		}
-
-		buffer += sizeof(pfd);
-		count -= sizeof(pfd);
-	}
-
-eexit_2:
-	up_write(&ep->acsem);
-eexit_1:
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: write(%p, %d) = %d\n",
-		     current, ep, count, rcount));
-
-	return rcount;
-}
-
-
-static int ep_poll(struct eventpoll *ep, struct evpoll *dvp)
-{
-	int res = 0;
-	long timeout;
-	unsigned long flags;
-	wait_queue_t wait;
-
-	/*
-	 * We don't want ep_poll() to be called if the correct sequence
-	 * of operations are performed to initialize it. This won't happen
-	 * for the system call interface but it could happen using the
-	 * old /dev/epoll interface, that is maintained for compatibility.
-	 */
-	if (!atomic_read(&ep->mmapped))
-		return -EINVAL;
-
-	write_lock_irqsave(&ep->lock, flags);
-
-	res = 0;
-	if (!ep->eventcnt) {
-		/*
-		 * We don't have any available event to return to the caller.
-		 * We need to sleep here, and we will be wake up by
-		 * notify_proc() when events will become available.
-		 */
-		init_waitqueue_entry(&wait, current);
-		add_wait_queue(&ep->wq, &wait);
-
-		/*
-		 * Calculate the timeout by checking for the "infinite" value ( -1 )
-		 * and the overflow condition ( > MAX_SCHEDULE_TIMEOUT / HZ ). The
-		 * passed timeout is in milliseconds, that why (t * HZ) / 1000.
-		 */
-		timeout = dvp->ep_timeout == -1 || dvp->ep_timeout > MAX_SCHEDULE_TIMEOUT / HZ ?
-			MAX_SCHEDULE_TIMEOUT: (dvp->ep_timeout * HZ) / 1000;
-
-		for (;;) {
-			/*
-			 * We don't want to sleep if the notify_proc() sends us
-			 * a wakeup in between. That's why we set the task state
-			 * to TASK_INTERRUPTIBLE before doing the checks.
-			 */
-			set_current_state(TASK_INTERRUPTIBLE);
-			if (ep->eventcnt || !timeout)
-				break;
-			if (signal_pending(current)) {
-				res = -EINTR;
-				break;
-			}
-
-			write_unlock_irqrestore(&ep->lock, flags);
-			timeout = schedule_timeout(timeout);
-			write_lock_irqsave(&ep->lock, flags);
-		}
-		remove_wait_queue(&ep->wq, &wait);
-
-		set_current_state(TASK_RUNNING);
-	}
-
-	/*
-	 * If we've been wake up because of events became available, we need to:
-	 *
-	 * 1) null the number of available ready file descriptors
-	 * 2) increment the version of the current ( next ) snapshot
-	 * 3) swap the double buffer to return the current one to the caller
-	 * 4) set the current ( for the user, previous for the interface ) offset
-	 */
-	if (!res && ep->eventcnt) {
-		res = ep->eventcnt;
-		ep->eventcnt = 0;
-		++ep->ver;
-		if (ep->pages == ep->pages0) {
-			ep->pages = ep->pages1;
-			dvp->ep_resoff = 0;
-		} else {
-			ep->pages = ep->pages0;
-			dvp->ep_resoff = ep->numpages * PAGE_SIZE;
-		}
-	}
-
-	write_unlock_irqrestore(&ep->lock, flags);
-
-	return res;
-}
-
-
-static int ep_do_alloc_pages(struct eventpoll *ep, int numpages)
-{
-	int res, pgalloc, pgcpy;
-	unsigned long flags;
-	char **pages, **pages0, **pages1;
-
-	if (atomic_read(&ep->mmapped))
-		return -EBUSY;
-	if (numpages > MAX_EVENTPOLL_PAGES)
-		return -EINVAL;
-
-	pgalloc = numpages - ep->numpages;
-	if ((pages = (char **) vmalloc(2 * (pgalloc + 1) * sizeof(char *))) == NULL)
-		return -ENOMEM;
-	pages0 = &pages[0];
-	pages1 = &pages[pgalloc + 1];
-
-	if ((res = ep_alloc_pages(pages0, pgalloc)))
-		goto eexit_1;
-
-	if ((res = ep_alloc_pages(pages1, pgalloc))) {
-		ep_free_pages(pages0, pgalloc);
-		goto eexit_1;
-	}
-
-	write_lock_irqsave(&ep->lock, flags);
-	pgcpy = (ep->numpages + pgalloc) > numpages ? numpages - ep->numpages: pgalloc;
-	if (pgcpy > 0) {
-		memcpy(&ep->pages0[ep->numpages], pages0, pgcpy * sizeof(char *));
-		memcpy(&ep->pages1[ep->numpages], pages1, pgcpy * sizeof(char *));
-		ep->numpages += pgcpy;
-	}
-	write_unlock_irqrestore(&ep->lock, flags);
-
-	if (pgcpy < pgalloc) {
-		if (pgcpy < 0)
-			pgcpy = 0;
-		ep_free_pages(&pages0[pgcpy], pgalloc - pgcpy);
-		ep_free_pages(&pages1[pgcpy], pgalloc - pgcpy);
-	}
-
-eexit_1:
-	vfree(pages);
-	return res;
-}
-
-
-static int ioctl_eventpoll(struct inode *inode, struct file *file,
-			   unsigned int cmd, unsigned long arg)
-{
-	int res;
-	struct eventpoll *ep = file->private_data;
-	struct epitem *dpi;
-	unsigned long flags;
-	struct pollfd pfd;
-	struct evpoll dvp;
-
-	switch (cmd) {
-	case EP_ALLOC:
-		res = ep_do_alloc_pages(ep, EP_FDS_PAGES(arg));
-
-		DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ioctl(%p, EP_ALLOC, %lu) == %d\n",
-			     current, ep, arg, res));
-		return res;
-
-	case EP_FREE:
-		if (atomic_read(&ep->mmapped))
-			return -EBUSY;
-
-		res = -EINVAL;
-		write_lock_irqsave(&ep->lock, flags);
-		if (ep->numpages > 0) {
-			ep_free_pages(ep->pages0, ep->numpages);
-			ep_free_pages(ep->pages1, ep->numpages);
-			ep->numpages = 0;
-			ep->pages = ep->pages0;
-			res = 0;
-		}
-		write_unlock_irqrestore(&ep->lock, flags);
-
-		DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ioctl(%p, EP_FREE) == %d\n",
-			     current, ep, res));
-		return res;
-
-	case EP_POLL:
-		if (copy_from_user(&dvp, (void *) arg, sizeof(struct evpoll)))
-			return -EFAULT;
-
-		DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ioctl(%p, EP_POLL, %d)\n",
-			     current, ep, dvp.ep_timeout));
-
-		res = ep_poll(ep, &dvp);
-
-		DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ioctl(%p, EP_POLL, %d) == %d\n",
-			     current, ep, dvp.ep_timeout, res));
-
-		if (res > 0 && copy_to_user((void *) arg, &dvp, sizeof(struct evpoll)))
-			res = -EFAULT;
-
-		return res;
-
-	case EP_ISPOLLED:
-		if (copy_from_user(&pfd, (void *) arg, sizeof(struct pollfd)))
-			return 0;
-
-		read_lock_irqsave(&ep->lock, flags);
-
-		res = 0;
-		if (!(dpi = ep_find_nl(ep, pfd.fd)))
-			goto is_not_polled;
-
-		pfd = dpi->pfd;
-		res = 1;
-
-	is_not_polled:
-		read_unlock_irqrestore(&ep->lock, flags);
-
-		if (res)
-			copy_to_user((void *) arg, &pfd, sizeof(struct pollfd));
-
-		DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ioctl(%p, EP_ISPOLLED, %d) == %d\n",
-			     current, ep, pfd.fd, res));
-		return res;
-	}
-
-	return -EINVAL;
-}
-
-
-static void eventpoll_mm_open(struct vm_area_struct * vma)
-{
-	struct file *file = vma->vm_file;
-	struct eventpoll *ep = file->private_data;
-
-	if (ep) atomic_inc(&ep->mmapped);
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: mm_open(%p)\n", current, ep));
-}
-
-
-static void eventpoll_mm_close(struct vm_area_struct * vma)
-{
-	struct file *file = vma->vm_file;
-	struct eventpoll *ep = file->private_data;
-
-	if (ep && atomic_dec_and_test(&ep->mmapped))
-		ep->vmabase = 0;
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: mm_close(%p)\n", current, ep));
-}
-
-
-static int mmap_eventpoll(struct file *file, struct vm_area_struct *vma)
-{
-	struct eventpoll *ep = file->private_data;
-	unsigned long start;
-	int ii, res, numpages;
-	size_t mapsize;
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: mmap(%p, %lx, %lx)\n",
-		     current, ep, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT));
-
-	/*
-	 * We need the eventpoll file to be RW but we don't want it to be
-	 * mapped RW. This test perform the test and reject RW mmaping.
-	 */
-	if (vma->vm_flags & VM_WRITE)
-		return -EACCES;
-
-	if ((vma->vm_pgoff << PAGE_SHIFT) != 0)
-		return -EINVAL;
-
-	/*
-	 * We need to verify that the mapped area covers all the allocated
-	 * double buffer.
-	 */
-	mapsize = PAGE_ALIGN(vma->vm_end - vma->vm_start);
-	numpages = mapsize >> PAGE_SHIFT;
-
-	res = -EINVAL;
-	if (numpages != (2 * ep->numpages))
-		goto eexit_1;
-
-	/*
-	 * Map the double buffer starting from "vma->vm_start" up to
-	 * "vma->vm_start + ep->numpages * PAGE_SIZE".
-	 */
-	start = vma->vm_start;
-	for (ii = 0; ii < ep->numpages; ii++) {
-		if ((res = remap_page_range(vma, start, __pa(ep->pages0[ii]),
-					    PAGE_SIZE, vma->vm_page_prot)))
-			goto eexit_1;
-		start += PAGE_SIZE;
-	}
-	for (ii = 0; ii < ep->numpages; ii++) {
-		if ((res = remap_page_range(vma, start, __pa(ep->pages1[ii]),
-					    PAGE_SIZE, vma->vm_page_prot)))
-			goto eexit_1;
-		start += PAGE_SIZE;
-	}
-	vma->vm_ops = &eventpoll_mmap_ops;
-
-	/* Saves the base mapping address for later use in sys_epoll_wait(2) */
-	ep->vmabase = vma->vm_start;
-
-	/*
-	 * Ok, mapping has been done. We can open the door to functions that
-	 * requires the mapping to be in place.
-	 */
-	atomic_set(&ep->mmapped, 1);
-
-	res = 0;
-eexit_1:
-
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: mmap(%p, %lx, %lx) == %d\n",
-		     current, ep, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT, res));
-	return res;
-}
-
-
-static int eventpollfs_delete_dentry(struct dentry *dentry)
-{
-
-	return 1;
-}
-
-
-static struct inode *get_eventpoll_inode(void)
-{
-	int error = -ENOMEM;
-	struct inode *inode = new_inode(eventpoll_mnt->mnt_sb);
-
-	if (!inode)
-		goto eexit_1;
-
-	inode->i_fop = &eventpoll_fops;
-
-	/*
-	 * Mark the inode dirty from the very beginning,
-	 * that way it will never be moved to the dirty
-	 * list because "mark_inode_dirty()" will think
-	 * that it already _is_ on the dirty list.
-	 */
-	inode->i_state = I_DIRTY;
-	inode->i_mode = S_IRUSR | S_IWUSR;
-	inode->i_uid = current->fsuid;
-	inode->i_gid = current->fsgid;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-	inode->i_blksize = PAGE_SIZE;
-	return inode;
-
-eexit_1:
-	return ERR_PTR(error);
-}
-
-
-static struct super_block *eventpollfs_get_sb(struct file_system_type *fs_type,
-					      int flags, char *dev_name, void *data)
-{
-
-	return get_sb_pseudo(fs_type, "eventpoll:", NULL, EVENTPOLLFS_MAGIC);
-}
-
-
-static int __init eventpoll_init(void)
-{
-	int error;
-
-	/* Allocates slab cache used to allocate "struct epitem" items */
-	error = -ENOMEM;
-	dpi_cache = kmem_cache_create("eventpoll",
-				      sizeof(struct epitem),
-				      __alignof__(struct epitem),
-				      DPI_SLAB_DEBUG, NULL, NULL);
-	if (!dpi_cache)
-		goto eexit_1;
-
-	/*
-	 * Register the virtual file system that will be the source of inodes
-	 * for the eventpoll files
-	 */
-	error = register_filesystem(&eventpoll_fs_type);
-	if (error)
-		goto eexit_2;
-
-	/* Mount the above commented virtual file system */
-	eventpoll_mnt = kern_mount(&eventpoll_fs_type);
-	error = PTR_ERR(eventpoll_mnt);
-	if (IS_ERR(eventpoll_mnt))
-		goto eexit_3;
-
-	/*
-	 * This is to maintain compatibility with the old /dev/epoll interface.
-	 * We need to register a misc device so that the caller can open(2) it
-	 * through a file inside /dev.
-	 */
-	error = misc_register(&eventpoll_miscdev);
-	if (error)
-		goto eexit_4;
-
-	printk(KERN_INFO "[%p] eventpoll: driver installed.\n", current);
-
-	return error;
-
-eexit_4:
-	mntput(eventpoll_mnt);
-eexit_3:
-	unregister_filesystem(&eventpoll_fs_type);
-eexit_2:
-	kmem_cache_destroy(dpi_cache);
-eexit_1:
-
-	return error;
-}
-
-
-static void __exit eventpoll_exit(void)
-{
-	/* Undo all operations done inside eventpoll_init() */
-	unregister_filesystem(&eventpoll_fs_type);
-	mntput(eventpoll_mnt);
-	misc_deregister(&eventpoll_miscdev);
-	kmem_cache_destroy(dpi_cache);
-}
-
-module_init(eventpoll_init);
-module_exit(eventpoll_exit);
-
-MODULE_LICENSE("GPL");
-
diff -Nru linux-2.5.45.vanilla/fs/Makefile linux-2.5.45.epoll/fs/Makefile
--- linux-2.5.45.vanilla/fs/Makefile	Wed Oct 30 16:42:59 2002
+++ linux-2.5.45.epoll/fs/Makefile	Sun Nov  3 10:19:42 2002
@@ -6,14 +6,14 @@
 #

 export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o aio.o \
-                fcntl.o read_write.o dcookies.o fcblist.o
+                fcntl.o read_write.o dcookies.o

 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o aio.o fcblist.o
+		fs-writeback.o mpage.o direct-io.o aio.o eventpoll.o

 ifneq ($(CONFIG_NFSD),n)
 ifneq ($(CONFIG_NFSD),)
diff -Nru linux-2.5.45.vanilla/fs/eventpoll.c linux-2.5.45.epoll/fs/eventpoll.c
--- linux-2.5.45.vanilla/fs/eventpoll.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.45.epoll/fs/eventpoll.c	Sun Nov  3 11:16:54 2002
@@ -0,0 +1,1293 @@
+/*
+ *  drivers/char/eventpoll.c ( Efficent event polling implementation )
+ *  Copyright (C) 2001,...,2002	 Davide Libenzi
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  Davide Libenzi <davidel@xmailserver.org>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/signal.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/smp_lock.h>
+#include <linux/string.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <asm/bitops.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/mman.h>
+#include <asm/atomic.h>
+#include <linux/eventpoll.h>
+
+
+
+#define EVENTPOLLFS_MAGIC 0x03111965 /* My birthday should work for this :) */
+
+#define DEBUG_EPOLL 0
+
+#if DEBUG_EPOLL > 0
+#define DPRINTK(x) printk x
+#define DNPRINTK(n, x) do { if ((n) <= DEBUG_EPOLL) printk x; } while (0)
+#else /* #if DEBUG_EPOLL > 0 */
+#define DPRINTK(x) (void) 0
+#define DNPRINTK(n, x) (void) 0
+#endif /* #if DEBUG_EPOLL > 0 */
+
+#define DEBUG_DPI 0
+
+#if DEBUG_DPI != 0
+#define DPI_SLAB_DEBUG (SLAB_DEBUG_FREE | SLAB_RED_ZONE /* | SLAB_POISON */)
+#else /* #if DEBUG_DPI != 0 */
+#define DPI_SLAB_DEBUG 0
+#endif /* #if DEBUG_DPI != 0 */
+
+
+/* Maximum storage for the eventpoll interest set */
+#define EP_MAX_FDS_SIZE (1024 * 128)
+
+/* We don't want the hash to be smaller than this */
+#define EP_MIN_HASH_SIZE 101
+/*
+ * Event buffer dimension used to cache events before sending them in
+ * userspace with a __copy_to_user(). The event buffer is in stack,
+ * so keep this size fairly small.
+ */
+#define EP_EVENT_BUFF_SIZE 32
+
+/* Maximum number of wait queue we can attach to */
+#define EP_MAX_POLL_QUEUE 2
+
+/* Number of hash entries ( "struct list_head" ) inside a page */
+#define EP_HENTRY_X_PAGE (PAGE_SIZE / sizeof(struct list_head))
+
+/* Maximum size of the hash in pages */
+#define EP_MAX_HPAGES (EP_MAX_FDS_SIZE / EP_HENTRY_X_PAGE + 1)
+
+/* Macro to allocate a "struct epitem" from the slab cache */
+#define DPI_MEM_ALLOC()	(struct epitem *) kmem_cache_alloc(dpi_cache, SLAB_KERNEL)
+
+/* Macro to free a "struct epitem" to the slab cache */
+#define DPI_MEM_FREE(p) kmem_cache_free(dpi_cache, p)
+
+/* Fast test to see if the file is an evenpoll file */
+#define IS_FILE_EPOLL(f) ((f)->f_op == &eventpoll_fops)
+
+/*
+ * Remove the item from the list and perform its initialization.
+ * This is usefull for us because we can test if the item is linked
+ * using "EP_IS_LINKED(p)".
+ */
+#define EP_LIST_DEL(p) do { list_del(p); INIT_LIST_HEAD(p); } while (0)
+
+/* Tells us if the item is currently linked */
+#define EP_IS_LINKED(p) (!list_empty(p))
+
+/* Get the "struct epitem" from a wait queue pointer */
+#define EP_ITEM_FROM_WAIT(p) ((struct epitem *) container_of(p, struct eppoll_entry, wait)->base)
+
+
+
+
+
+/*
+ * This structure is stored inside the "private_data" member of the file
+ * structure and rapresent the main data sructure for the eventpoll
+ * interface.
+ */
+struct eventpoll {
+	/* Used to link to the "struct eventpoll" list ( eplist ) */
+	struct list_head llink;
+
+	/* Protect the this structure access */
+	rwlock_t lock;
+
+	/* Wait queue used by sys_epoll_wait() */
+	wait_queue_head_t wq;
+
+	/* Wait queue used by file->poll() */
+	wait_queue_head_t poll_wait;
+
+	/* List of ready file descriptors */
+	struct list_head rdllist;
+
+	/* Size of the hash */
+	int hsize;
+
+	/* Number of pages currently allocated for the hash */
+	int nhpages;
+
+	/* Pages for the "struct epitem" hash */
+	char *hpages[EP_MAX_HPAGES];
+};
+
+/* Wait structure used by the poll hooks */
+struct eppoll_entry {
+	/* The "base" pointer is set to the container "struct epitem" */
+	void *base;
+
+	/*
+	 * Wait queue item that will be linked to the target file wait
+	 * queue head.
+	 */
+	wait_queue_t wait;
+
+	/* The wait queue head that linked the "wait" wait queue item */
+	wait_queue_head_t *whead;
+};
+
+/*
+ * Each file descriptor added to the eventpoll interface will
+ * have an entry of this type linked to the hash.
+ */
+struct epitem {
+	/* List header used to link this structure to the eventpoll hash */
+	struct list_head llink;
+
+	/* List header used to link this structure to the eventpoll ready list */
+	struct list_head rdllink;
+
+	/* Number of active wait queue attached to poll operations */
+	int nwait;
+
+	/* Wait queue used to attach poll operations */
+	struct eppoll_entry wait[EP_MAX_POLL_QUEUE];
+
+	/* The "container" of this item */
+	struct eventpoll *ep;
+
+	/* The file this item refers to */
+	struct file *file;
+
+	/* The structure that describe the interested events and the source fd */
+	struct pollfd pfd;
+
+	/*
+	 * Used to keep track of the usage count of the structure. This avoids
+	 * that the structure will desappear from underneath our processing.
+	 */
+	atomic_t usecnt;
+};
+
+
+
+
+static int ep_is_prime(int n);
+static int ep_getfd(int *efd, struct inode **einode, struct file **efile);
+static int ep_alloc_pages(char **pages, int numpages);
+static int ep_free_pages(char **pages, int numpages);
+static int ep_file_init(struct file *file, int hsize);
+static int ep_hash_index(struct eventpoll *ep, struct file *file);
+static struct list_head *ep_hash_entry(struct eventpoll *ep, int index);
+static int ep_init(struct eventpoll *ep, int hsize);
+static void ep_free(struct eventpoll *ep);
+static struct epitem *ep_find(struct eventpoll *ep, struct file *file);
+static void ep_use_epitem(struct epitem *dpi);
+static void ep_release_epitem(struct epitem *dpi);
+static void ep_ptable_queue_proc(void *priv, wait_queue_head_t *whead);
+static int ep_insert(struct eventpoll *ep, struct pollfd *pfd, struct file *tfile);
+static unsigned int ep_get_file_events(struct file *file);
+static int ep_modify(struct eventpoll *ep, struct epitem *dpi, unsigned int events);
+static int ep_unlink(struct eventpoll *ep, struct epitem *dpi);
+static int ep_remove(struct eventpoll *ep, struct epitem *dpi);
+static int ep_poll_callback(wait_queue_t *wait, unsigned mode, int sync);
+static int ep_eventpoll_close(struct inode *inode, struct file *file);
+static unsigned int ep_eventpoll_poll(struct file *file, poll_table *wait);
+static int ep_events_transfer(struct eventpoll *ep, struct pollfd *events, int maxevents);
+static int ep_poll(struct eventpoll *ep, struct pollfd *events, int maxevents,
+		   int timeout);
+static int eventpollfs_delete_dentry(struct dentry *dentry);
+static struct inode *ep_eventpoll_inode(void);
+static struct super_block *eventpollfs_get_sb(struct file_system_type *fs_type,
+					      int flags, char *dev_name, void *data);
+
+
+/* Use to link togheter all the "struct eventpoll" */
+static struct list_head eplist;
+
+/* Serialize the access to "eplist" */
+static rwlock_t eplock;
+
+/* Slab cache used to allocate "struct epitem" */
+static kmem_cache_t *dpi_cache;
+
+/* Virtual fs used to allocate inodes for eventpoll files */
+static struct vfsmount *eventpoll_mnt;
+
+/* File callbacks that implement the eventpoll file behaviour */
+static struct file_operations eventpoll_fops = {
+	.release	= ep_eventpoll_close,
+	.poll		= ep_eventpoll_poll
+};
+
+/*
+ * This is used to register the virtual file system from where
+ * eventpoll inodes are allocated.
+ */
+static struct file_system_type eventpoll_fs_type = {
+	.name		= "eventpollfs",
+	.get_sb		= eventpollfs_get_sb,
+	.kill_sb	= kill_anon_super,
+};
+
+/* Very basic directory entry operations for the eventpoll virtual file system */
+static struct dentry_operations eventpollfs_dentry_operations = {
+	.d_delete	= eventpollfs_delete_dentry,
+};
+
+
+
+/* Report if the number is prime. Needed to correctly size the hash  */
+static int ep_is_prime(int n)
+{
+
+	if (n > 3) {
+		if (n & 1) {
+			int i, hn = n / 2;
+
+			for (i = 3; i < hn; i += 2)
+				if (!(n % i))
+					return 0;
+		} else
+			return 0;
+	}
+	return 1;
+}
+
+
+/*
+ * This is called from inside fs/file_table.c:__fput() to unlink files
+ * from the eventpoll interface. We need to have this facility to cleanup
+ * correctly files that are closed without being removed from the eventpoll
+ * interface.
+ */
+void ep_notify_file_close(struct file *file)
+{
+	unsigned long flags;
+	struct list_head *lnk;
+	struct eventpoll *ep;
+	struct epitem *dpi;
+
+	read_lock_irqsave(&eplock, flags);
+	list_for_each(lnk, &eplist) {
+		ep = list_entry(lnk, struct eventpoll, llink);
+
+		while ((dpi = ep_find(ep, file))) {
+			ep_remove(ep, dpi);
+			ep_release_epitem(dpi);
+		}
+	}
+	read_unlock_irqrestore(&eplock, flags);
+}
+
+
+/*
+ * It opens an eventpoll file descriptor by suggesting a storage of "size"
+ * file descriptors. It is the kernel part of the userspace epoll_create(2).
+ */
+asmlinkage int sys_epoll_create(int size)
+{
+	int error, fd;
+	struct inode *inode;
+	struct file *file;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d)\n",
+		     current, size));
+
+	/* Search the nearest prime number higher than "size" */
+	for (; !ep_is_prime(size); size++);
+	if (size < EP_MIN_HASH_SIZE)
+		size = EP_MIN_HASH_SIZE;
+
+	/*
+	 * Creates all the items needed to setup an eventpoll file. That is,
+	 * a file structure, and inode and a free file descriptor.
+	 */
+	error = ep_getfd(&fd, &inode, &file);
+	if (error)
+		goto eexit_1;
+
+	/* Setup the file internal data structure ( "struct eventpoll" ) */
+	error = ep_file_init(file, size);
+	if (error)
+		goto eexit_2;
+
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d) = %d\n",
+		     current, size, fd));
+
+	return fd;
+
+eexit_2:
+	sys_close(fd);
+eexit_1:
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d) = %d\n",
+		     current, size, error));
+	return error;
+}
+
+
+/*
+ * The following function implement the controller interface for the eventpoll
+ * file that enable the insertion/removal/change of file descriptors inside
+ * the interest set. It rapresents the kernel part of the user spcae epoll_ctl(2).
+ */
+asmlinkage int sys_epoll_ctl(int epfd, int op, int fd, unsigned int events)
+{
+	int error;
+	struct file *file, *tfile;
+	struct eventpoll *ep;
+	struct epitem *dpi;
+	struct pollfd pfd;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_ctl(%d, %d, %d, %u)\n",
+		     current, epfd, op, fd, events));
+
+	/* Get the "struct file *" for the eventpoll file */
+	error = -EBADF;
+	file = fget(epfd);
+	if (!file)
+		goto eexit_1;
+
+	/* Get the "struct file *" for the target file */
+	tfile = fget(fd);
+	if (!tfile)
+		goto eexit_2;
+
+	/* The target file descriptor must support poll */
+	error = -EPERM;
+	if (!tfile->f_op || !tfile->f_op->poll)
+		goto eexit_3;
+
+	/*
+	 * We have to check that the file structure underneath the file descriptor
+	 * the user passed to us _is_ an eventpoll file.
+	 */
+	error = -EINVAL;
+	if (!IS_FILE_EPOLL(file))
+		goto eexit_3;
+
+	/*
+	 * At this point it is safe to assume that the "private_data" contains
+	 * our own data structure.
+	 */
+	ep = file->private_data;
+
+	/*
+	 * Try to lookup the file inside our hash table. When an item is found
+	 * ep_find() increases the usage count of the item so that it won't
+	 * desappear underneath us. The only thing that might happen, if someone
+	 * tries very hard, is a double insertion of the same file descriptor.
+	 * This does not rapresent a problem though and we don't really want
+	 * to put an extra syncronization object to deal with this harmless condition.
+	 */
+	dpi = ep_find(ep, tfile);
+
+	error = -EINVAL;
+	switch (op) {
+	case EP_CTL_ADD:
+		if (!dpi) {
+			pfd.fd = fd;
+			pfd.events = events | POLLERR | POLLHUP;
+			pfd.revents = 0;
+
+			error = ep_insert(ep, &pfd, tfile);
+		} else
+			error = -EEXIST;
+		break;
+	case EP_CTL_DEL:
+		if (dpi)
+			error = ep_remove(ep, dpi);
+		else
+			error = -ENOENT;
+		break;
+	case EP_CTL_MOD:
+		if (dpi)
+			error = ep_modify(ep, dpi, events | POLLERR | POLLHUP);
+		else
+			error = -ENOENT;
+		break;
+	}
+
+	/*
+	 * The function ep_find() increments the usage count of the structure
+	 * so, if this is not NULL, we need to release it.
+	 */
+	if (dpi)
+		ep_release_epitem(dpi);
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_ctl(%d, %d, %d, %u) = %d\n",
+		     current, epfd, op, fd, events, error));
+
+eexit_3:
+	fput(tfile);
+eexit_2:
+	fput(file);
+eexit_1:
+	return error;
+}
+
+
+/*
+ * Implement the event wait interface for the eventpoll file. It is the kernel
+ * part of the user space epoll_wait(2).
+ */
+asmlinkage int sys_epoll_wait(int epfd, struct pollfd *events, int maxevents,
+			      int timeout)
+{
+	int error;
+	struct file *file;
+	struct eventpoll *ep;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d, %d)\n",
+		     current, epfd, events, maxevents, timeout));
+
+	/* Verify that the area passed by the user is writeable */
+	if ((error = verify_area(VERIFY_WRITE, events, maxevents * sizeof(struct pollfd))))
+		goto eexit_1;
+
+	/* Get the "struct file *" for the eventpoll file */
+	error = -EBADF;
+	file = fget(epfd);
+	if (!file)
+		goto eexit_1;
+
+	/*
+	 * We have to check that the file structure underneath the file descriptor
+	 * the user passed to us _is_ an eventpoll file.
+	 */
+	error = -EINVAL;
+	if (!IS_FILE_EPOLL(file))
+		goto eexit_2;
+
+	/*
+	 * At this point it is safe to assume that the "private_data" contains
+	 * our own data structure.
+	 */
+	ep = file->private_data;
+
+	/* Time to fish for events ... */
+	error = ep_poll(ep, events, maxevents, timeout);
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d, %d) = %d\n",
+		     current, epfd, events, maxevents, timeout, error));
+
+eexit_2:
+	fput(file);
+eexit_1:
+	return error;
+}
+
+
+/*
+ * Creates the file descriptor to be used by the epoll interface.
+ */
+static int ep_getfd(int *efd, struct inode **einode, struct file **efile)
+{
+	struct qstr this;
+	char name[32];
+	struct dentry *dentry;
+	struct inode *inode;
+	struct file *file;
+	int error, fd;
+
+	/* Get an ready to use file */
+	error = -ENFILE;
+	file = get_empty_filp();
+	if (!file)
+		goto eexit_1;
+
+	/* Allocates an inode from the eventpoll file system */
+	inode = ep_eventpoll_inode();
+	error = PTR_ERR(inode);
+	if (IS_ERR(inode))
+		goto eexit_2;
+
+	/* Allocates a free descriptor to plug the file onto */
+	error = get_unused_fd();
+	if (error < 0)
+		goto eexit_3;
+	fd = error;
+
+	/*
+	 * Link the inode to a directory entry by creating a unique name
+	 * using the inode number.
+	 */
+	error = -ENOMEM;
+	sprintf(name, "[%lu]", inode->i_ino);
+	this.name = name;
+	this.len = strlen(name);
+	this.hash = inode->i_ino;
+	dentry = d_alloc(eventpoll_mnt->mnt_sb->s_root, &this);
+	if (!dentry)
+		goto eexit_4;
+	dentry->d_op = &eventpollfs_dentry_operations;
+	d_add(dentry, inode);
+	file->f_vfsmnt = mntget(eventpoll_mnt);
+	file->f_dentry = dget(dentry);
+
+	/*
+	 * Initialize the file as read/write because it could be used
+	 * with write() to add/remove/change interest sets.
+	 */
+	file->f_pos = 0;
+	file->f_flags = O_RDONLY;
+	file->f_op = &eventpoll_fops;
+	file->f_mode = FMODE_READ;
+	file->f_version = 0;
+	file->private_data = NULL;
+
+	/* Install the new setup file into the allocated fd. */
+	fd_install(fd, file);
+
+	*efd = fd;
+	*einode = inode;
+	*efile = file;
+	return 0;
+
+eexit_4:
+	put_unused_fd(fd);
+eexit_3:
+	iput(inode);
+eexit_2:
+	put_filp(file);
+eexit_1:
+	return error;
+}
+
+
+static int ep_alloc_pages(char **pages, int numpages)
+{
+	int i;
+
+	for (i = 0; i < numpages; i++) {
+		pages[i] = (char *) __get_free_pages(GFP_KERNEL, 0);
+		if (!pages[i]) {
+			for (--i; i >= 0; i--) {
+				ClearPageReserved(virt_to_page(pages[i]));
+				free_pages((unsigned long) pages[i], 0);
+			}
+			return -ENOMEM;
+		}
+		SetPageReserved(virt_to_page(pages[i]));
+	}
+	return 0;
+}
+
+
+static int ep_free_pages(char **pages, int numpages)
+{
+	int i;
+
+	for (i = 0; i < numpages; i++) {
+		ClearPageReserved(virt_to_page(pages[i]));
+		free_pages((unsigned long) pages[i], 0);
+	}
+	return 0;
+}
+
+
+static int ep_file_init(struct file *file, int hsize)
+{
+	int error;
+	unsigned long flags;
+	struct eventpoll *ep;
+
+	if (!(ep = kmalloc(sizeof(struct eventpoll), GFP_KERNEL)))
+		return -ENOMEM;
+
+	memset(ep, 0, sizeof(*ep));
+
+	error = ep_init(ep, hsize);
+	if (error) {
+		kfree(ep);
+		return error;
+	}
+
+	file->private_data = ep;
+
+	/* Add the structure to the linked list that links "struct eventpoll" */
+	write_lock_irqsave(&eplock, flags);
+	list_add(&ep->llink, &eplist);
+	write_unlock_irqrestore(&eplock, flags);
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_file_init() ep=%p\n",
+		     current, ep));
+	return 0;
+}
+
+
+/*
+ * Calculate the index of the hash relative to "file".
+ */
+static int ep_hash_index(struct eventpoll *ep, struct file *file)
+{
+
+	return (int) ((((unsigned long) file) / sizeof(struct file)) % ep->hsize);
+}
+
+
+/*
+ * Returns the hash entry ( struct list_head * ) of the passed index.
+ */
+static struct list_head *ep_hash_entry(struct eventpoll *ep, int index)
+{
+
+	return (struct list_head *) (ep->hpages[index / EP_HENTRY_X_PAGE] +
+				     (index % EP_HENTRY_X_PAGE) * sizeof(struct list_head));
+}
+
+
+static int ep_init(struct eventpoll *ep, int hsize)
+{
+	int error, i;
+
+	INIT_LIST_HEAD(&ep->llink);
+	rwlock_init(&ep->lock);
+	init_waitqueue_head(&ep->wq);
+	init_waitqueue_head(&ep->poll_wait);
+	INIT_LIST_HEAD(&ep->rdllist);
+
+	/* Hash allocation and setup */
+	ep->hsize = hsize;
+	ep->nhpages = hsize / EP_HENTRY_X_PAGE + (hsize % EP_HENTRY_X_PAGE ? 1: 0);
+	error = ep_alloc_pages(ep->hpages, ep->nhpages);
+	if (error)
+		goto eexit_1;
+
+	/* Initialize hash buckets */
+	for (i = 0; i < ep->hsize; i++)
+		INIT_LIST_HEAD(ep_hash_entry(ep, i));
+
+	return 0;
+eexit_1:
+	return error;
+}
+
+
+static void ep_free(struct eventpoll *ep)
+{
+	int i;
+	unsigned long flags;
+	struct list_head *lsthead;
+
+	/*
+	 * Walks through the whole hash by unregistering file callbacks and
+	 * freeing each "struct epitem".
+	 */
+	for (i = 0; i < ep->hsize; i++) {
+		lsthead = ep_hash_entry(ep, i);
+
+		/*
+		 * We need to lock this because we could be hit by
+		 * ep_notify_file_close() while we're freeing this.
+		 */
+		write_lock_irqsave(&ep->lock, flags);
+
+		while (!list_empty(lsthead)) {
+			struct epitem *dpi = list_entry(lsthead->next, struct epitem, llink);
+
+			/* The function ep_unlink() must be called with held lock */
+			ep_unlink(ep, dpi);
+
+			/* We release the lock before releasing the "struct epitem" */
+			write_unlock_irqrestore(&ep->lock, flags);
+
+			ep_release_epitem(dpi);
+
+			/* And then we reaquire the lock ... */
+			write_lock_irqsave(&ep->lock, flags);
+		}
+
+		write_unlock_irqrestore(&ep->lock, flags);
+	}
+
+	/* Remove the structure to the linked list that links "struct eventpoll" */
+	write_lock_irqsave(&eplock, flags);
+	EP_LIST_DEL(&ep->llink);
+	write_unlock_irqrestore(&eplock, flags);
+
+	/* Free hash pages */
+	if (ep->nhpages > 0)
+		ep_free_pages(ep->hpages, ep->nhpages);
+}
+
+
+/*
+ * Search the file inside the eventpoll hash. It add usage count to
+ * the returned item, so the caller must call ep_release_epitem()
+ * after finished using the "struct epitem".
+ */
+static struct epitem *ep_find(struct eventpoll *ep, struct file *file)
+{
+	unsigned long flags;
+	struct list_head *lsthead, *lnk;
+	struct epitem *dpi = NULL;
+
+	read_lock_irqsave(&ep->lock, flags);
+
+	lsthead = ep_hash_entry(ep, ep_hash_index(ep, file));
+	list_for_each(lnk, lsthead) {
+		dpi = list_entry(lnk, struct epitem, llink);
+
+		if (dpi->file == file) {
+			ep_use_epitem(dpi);
+			break;
+		}
+		dpi = NULL;
+	}
+
+	read_unlock_irqrestore(&ep->lock, flags);
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_find(%p) -> %p\n",
+		     current, file, dpi));
+
+	return dpi;
+}
+
+
+/*
+ * Increment the usage count of the "struct epitem" making it sure
+ * that the user will have a valid pointer to reference.
+ */
+static void ep_use_epitem(struct epitem *dpi)
+{
+
+	atomic_inc(&dpi->usecnt);
+}
+
+
+/*
+ * Decrement ( release ) the usage count by signaling that the user
+ * has finished using the structure. It might lead to freeing the
+ * structure itself if the count goes to zero.
+ */
+static void ep_release_epitem(struct epitem *dpi)
+{
+
+	if (atomic_dec_and_test(&dpi->usecnt))
+		DPI_MEM_FREE(dpi);
+}
+
+
+/*
+ * This is the callback that is used to add our wait queue to the
+ * target file wakeup lists.
+ */
+static void ep_ptable_queue_proc(void *priv, wait_queue_head_t *whead)
+{
+	struct epitem *dpi = priv;
+
+	/* No more than EP_MAX_POLL_QUEUE wait queue are supported */
+	if (dpi->nwait < EP_MAX_POLL_QUEUE) {
+		add_wait_queue(whead, &dpi->wait[dpi->nwait].wait);
+		dpi->wait[dpi->nwait].whead = whead;
+		dpi->nwait++;
+	}
+}
+
+
+static int ep_insert(struct eventpoll *ep, struct pollfd *pfd, struct file *tfile)
+{
+	int error, i, revents;
+	unsigned long flags;
+	struct epitem *dpi;
+	poll_table pt;
+
+	error = -ENOMEM;
+	if (!(dpi = DPI_MEM_ALLOC()))
+		goto eexit_1;
+
+	/* Item initialization follow here ... */
+	INIT_LIST_HEAD(&dpi->llink);
+	INIT_LIST_HEAD(&dpi->rdllink);
+	dpi->ep = ep;
+	dpi->file = tfile;
+	dpi->pfd = *pfd;
+	atomic_set(&dpi->usecnt, 1);
+	dpi->nwait = 0;
+	for (i = 0; i < EP_MAX_POLL_QUEUE; i++) {
+		init_waitqueue_func_entry(&dpi->wait[i].wait, ep_poll_callback);
+		dpi->wait[i].whead = NULL;
+		dpi->wait[i].base = dpi;
+	}
+
+	/* Attach the item to the poll hooks */
+	poll_initwait_ex(&pt, 1, ep_ptable_queue_proc, dpi);
+	revents = tfile->f_op->poll(tfile, &pt);
+	poll_freewait(&pt);
+
+	/* We have to drop the new item inside our item list to keep track of it */
+	write_lock_irqsave(&ep->lock, flags);
+
+	list_add(&dpi->llink, ep_hash_entry(ep, ep_hash_index(ep, tfile)));
+
+	/* If the file is already "ready" we drop it inside the ready list */
+	if ((revents & pfd->events) && !EP_IS_LINKED(&dpi->rdllink))
+		list_add(&dpi->rdllink, &ep->rdllist);
+
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_insert(%p, %d)\n",
+		     current, ep, pfd->fd));
+
+	return 0;
+
+eexit_1:
+	return error;
+}
+
+
+/*
+ * Returns the current events of the given file. It uses the special
+ * poll table initialization to avoid any poll queue insertion.
+ */
+static unsigned int ep_get_file_events(struct file *file)
+{
+	unsigned int revents;
+	poll_table pt;
+
+	/*
+	 * This is a special poll table initialization that will
+	 * make poll_wait() to not perform any wait queue insertion when
+	 * called by file->f_op->poll(). This is a fast way to retrieve
+	 * file events with perform any queue insertion, hence saving CPU cycles.
+	 */
+	poll_initwait_ex(&pt, 0, NULL, NULL);
+
+	revents = file->f_op->poll(file, &pt);
+
+	poll_freewait(&pt);
+	return revents;
+}
+
+
+/*
+ * Modify the interest event mask by dropping an event if the new mask
+ * has a match in the current file status.
+ */
+static int ep_modify(struct eventpoll *ep, struct epitem *dpi, unsigned int events)
+{
+	unsigned int revents;
+	unsigned long flags;
+
+	revents = ep_get_file_events(dpi->file);
+
+	write_lock_irqsave(&ep->lock, flags);
+
+	dpi->pfd.events = events;
+
+	/* If the file is already "ready" we drop it inside the ready list */
+	if ((revents & events) && EP_IS_LINKED(&dpi->llink) && !EP_IS_LINKED(&dpi->rdllink))
+		list_add(&dpi->rdllink, &ep->rdllist);
+
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	return 0;
+}
+
+
+/*
+ * Unlink the "struct epitem" from all places it might have been hooked up.
+ * This function must be called with write IRQ lock on "ep->lock".
+ */
+static int ep_unlink(struct eventpoll *ep, struct epitem *dpi)
+{
+	int i;
+
+	/*
+	 * It can happen that this one is called for an item already unlinked.
+	 * The check protect us from doing a double unlink ( crash ).
+	 */
+	if (!EP_IS_LINKED(&dpi->llink))
+		goto not_linked;
+
+	/*
+	 * At this point is safe to do the job, unlink the item from our list.
+	 * This operation togheter with the above check closes the door to
+	 * double unlinks.
+	 */
+	EP_LIST_DEL(&dpi->llink);
+
+	/* Removes poll wait queue hooks */
+	for (i = 0; i < dpi->nwait; i++)
+		remove_wait_queue(dpi->wait[i].whead, &dpi->wait[i].wait);
+
+	/*
+	 * If the item we are going to remove is inside the ready file descriptors
+	 * we want to remove it from this list to avoid stale events.
+	 */
+	if (EP_IS_LINKED(&dpi->rdllink))
+		EP_LIST_DEL(&dpi->rdllink);
+
+not_linked:
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_unlink(%p, %d)\n",
+		     current, ep, dpi->pfd.fd));
+
+	return 0;
+}
+
+
+/*
+ * Removes a "struct epitem" from the eventpoll hash and deallocates
+ * all the associated resources.
+ */
+static int ep_remove(struct eventpoll *ep, struct epitem *dpi)
+{
+	int error;
+	unsigned long flags;
+
+	/* We need to acquire the write IRQ lock before calling ep_unlink() */
+	write_lock_irqsave(&ep->lock, flags);
+
+	/* Really unlink the item from the hash */
+	error = ep_unlink(ep, dpi);
+
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	if (error)
+		goto eexit_1;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_remove(%p, %d)\n",
+		     current, ep, dpi->pfd.fd));
+
+	/* At this point it is safe to free the eventpoll item */
+	ep_release_epitem(dpi);
+
+	error = 0;
+eexit_1:
+	return error;
+}
+
+
+/*
+ * This is the callback that is passed to the wait queue wakeup
+ * machanism. It is called by the stored file descriptors when they
+ * have events to report.
+ */
+static int ep_poll_callback(wait_queue_t *wait, unsigned mode, int sync)
+{
+	unsigned long flags;
+	struct epitem *dpi = EP_ITEM_FROM_WAIT(wait);
+	struct eventpoll *ep = dpi->ep;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: poll_callback(%p) dpi=%p ep=%p\n",
+		     current, dpi->file, dpi, ep));
+
+	write_lock_irqsave(&ep->lock, flags);
+
+	/* If this file is already in the ready list we exit soon */
+	if (EP_IS_LINKED(&dpi->rdllink))
+		goto is_linked;
+
+	list_add(&dpi->rdllink, &ep->rdllist);
+
+is_linked:
+	/*
+	 * Wake up ( if active ) both the eventpoll wait list and the ->poll()
+	 * wait list.
+	 */
+	if (waitqueue_active(&ep->wq))
+		wake_up(&ep->wq);
+	if (waitqueue_active(&ep->poll_wait))
+		wake_up(&ep->poll_wait);
+
+	write_unlock_irqrestore(&ep->lock, flags);
+	return 1;
+}
+
+
+static int ep_eventpoll_close(struct inode *inode, struct file *file)
+{
+	struct eventpoll *ep = file->private_data;
+
+	if (ep) {
+		ep_free(ep);
+		kfree(ep);
+	}
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: close() ep=%p\n", current, ep));
+	return 0;
+}
+
+
+static unsigned int ep_eventpoll_poll(struct file *file, poll_table *wait)
+{
+	unsigned int pollflags = 0;
+	unsigned long flags;
+	struct eventpoll *ep = file->private_data;
+
+	/* Insert inside our poll wait queue */
+	poll_wait(file, &ep->poll_wait, wait);
+
+	/* Check our condition */
+	read_lock_irqsave(&ep->lock, flags);
+	if (!list_empty(&ep->rdllist))
+		pollflags = POLLIN | POLLRDNORM;
+	read_unlock_irqrestore(&ep->lock, flags);
+
+	return pollflags;
+}
+
+
+/*
+ * Perform the transfer of events to user space. Optimize the copy by
+ * caching EP_EVENT_BUFF_SIZE events at a time and then copying it to user space.
+ */
+static int ep_events_transfer(struct eventpoll *ep, struct pollfd *events, int maxevents)
+{
+	int eventcnt, ebufcnt, revents;
+	unsigned long flags;
+	struct list_head *lsthead = &ep->rdllist;
+	struct pollfd eventbuf[EP_EVENT_BUFF_SIZE];
+	poll_table pt;
+
+	/*
+	 * This is a special poll table initialization that will
+	 * make poll_wait() to not perform any wait queue insertion when
+	 * called by file->f_op->poll(). This is a fast way to retrieve
+	 * file events with perform any queue insertion, hence saving CPU cycles.
+	 */
+	poll_initwait_ex(&pt, 0, NULL, NULL);
+
+	write_lock_irqsave(&ep->lock, flags);
+
+	for (eventcnt = 0, ebufcnt = 0; eventcnt < maxevents && !list_empty(lsthead);) {
+		struct epitem *dpi = list_entry(lsthead->next, struct epitem, rdllink);
+
+		/* Remove the item from the ready list */
+		EP_LIST_DEL(&dpi->rdllink);
+
+		/* Fetch event bits from the signaled file */
+		revents = dpi->file->f_op->poll(dpi->file, &pt);
+
+		if (revents & dpi->pfd.events) {
+			eventbuf[ebufcnt] = dpi->pfd;
+			eventbuf[ebufcnt].revents = revents & eventbuf[ebufcnt].events;
+			ebufcnt++;
+
+			/* If our buffer page is full we need to flush it to user space */
+			if (ebufcnt == EP_EVENT_BUFF_SIZE) {
+				/*
+				 * We need to drop the irqlock before using the function
+				 * __copy_to_user() because it might fault.
+				 */
+				write_unlock_irqrestore(&ep->lock, flags);
+				if (__copy_to_user(&events[eventcnt], eventbuf,
+						   ebufcnt * sizeof(struct pollfd))) {
+					poll_freewait(&pt);
+					return -EFAULT;
+				}
+				eventcnt += ebufcnt;
+				ebufcnt = 0;
+				write_lock_irqsave(&ep->lock, flags);
+			}
+		}
+	}
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	/* There might be still something inside our event buffer */
+	if (ebufcnt) {
+		if (__copy_to_user(&events[eventcnt], eventbuf,
+				   ebufcnt * sizeof(struct pollfd)))
+			eventcnt = -EFAULT;
+		else
+			eventcnt += ebufcnt;
+	}
+
+	poll_freewait(&pt);
+
+	return eventcnt;
+}
+
+
+static int ep_poll(struct eventpoll *ep, struct pollfd *events, int maxevents,
+		   int timeout)
+{
+	int res = 0, eavail;
+	unsigned long flags;
+	long jtimeout;
+	wait_queue_t wait;
+
+	/*
+	 * Calculate the timeout by checking for the "infinite" value ( -1 )
+	 * and the overflow condition ( > MAX_SCHEDULE_TIMEOUT / HZ ). The
+	 * passed timeout is in milliseconds, that why (t * HZ) / 1000.
+	 */
+	jtimeout = timeout == -1 || timeout > MAX_SCHEDULE_TIMEOUT / HZ ?
+		MAX_SCHEDULE_TIMEOUT: (timeout * HZ) / 1000;
+
+retry:
+	write_lock_irqsave(&ep->lock, flags);
+
+	res = 0;
+	if (list_empty(&ep->rdllist)) {
+		/*
+		 * We don't have any available event to return to the caller.
+		 * We need to sleep here, and we will be wake up by
+		 * ep_poll_callback() when events will become available.
+		 */
+		init_waitqueue_entry(&wait, current);
+		add_wait_queue(&ep->wq, &wait);
+
+		for (;;) {
+			/*
+			 * We don't want to sleep if the ep_poll_callback() sends us
+			 * a wakeup in between. That's why we set the task state
+			 * to TASK_INTERRUPTIBLE before doing the checks.
+			 */
+			set_current_state(TASK_INTERRUPTIBLE);
+			if (!list_empty(&ep->rdllist) || !jtimeout)
+				break;
+			if (signal_pending(current)) {
+				res = -EINTR;
+				break;
+			}
+
+			write_unlock_irqrestore(&ep->lock, flags);
+			jtimeout = schedule_timeout(jtimeout);
+			write_lock_irqsave(&ep->lock, flags);
+		}
+		remove_wait_queue(&ep->wq, &wait);
+
+		set_current_state(TASK_RUNNING);
+	}
+
+	/* Is it worth to try to dig for events ? */
+	eavail = !list_empty(&ep->rdllist);
+
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	/*
+	 * Try to transfer events to user space. In case we get 0 events and
+	 * there's still timeout left over, we go trying again in search of
+	 * more luck.
+	 */
+	if (!res && eavail &&
+	    !(res = ep_events_transfer(ep, events, maxevents)) && jtimeout)
+		goto retry;
+
+	return res;
+}
+
+
+static int eventpollfs_delete_dentry(struct dentry *dentry)
+{
+
+	return 1;
+}
+
+
+static struct inode *ep_eventpoll_inode(void)
+{
+	int error = -ENOMEM;
+	struct inode *inode = new_inode(eventpoll_mnt->mnt_sb);
+
+	if (!inode)
+		goto eexit_1;
+
+	inode->i_fop = &eventpoll_fops;
+
+	/*
+	 * Mark the inode dirty from the very beginning,
+	 * that way it will never be moved to the dirty
+	 * list because mark_inode_dirty() will think
+	 * that it already _is_ on the dirty list.
+	 */
+	inode->i_state = I_DIRTY;
+	inode->i_mode = S_IRUSR | S_IWUSR;
+	inode->i_uid = current->fsuid;
+	inode->i_gid = current->fsgid;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_blksize = PAGE_SIZE;
+	return inode;
+
+eexit_1:
+	return ERR_PTR(error);
+}
+
+
+static struct super_block *eventpollfs_get_sb(struct file_system_type *fs_type,
+					      int flags, char *dev_name, void *data)
+{
+
+	return get_sb_pseudo(fs_type, "eventpoll:", NULL, EVENTPOLLFS_MAGIC);
+}
+
+
+static int __init eventpoll_init(void)
+{
+	int error;
+
+	/* Initialize the list that will link "struct eventpoll" */
+	INIT_LIST_HEAD(&eplist);
+
+	/* Initialize the rwlock used to access "eplist" */
+	rwlock_init(&eplock);
+
+	/* Allocates slab cache used to allocate "struct epitem" items */
+	error = -ENOMEM;
+	dpi_cache = kmem_cache_create("eventpoll",
+				      sizeof(struct epitem),
+				      0,
+				      DPI_SLAB_DEBUG, NULL, NULL);
+	if (!dpi_cache)
+		goto eexit_1;
+
+	/*
+	 * Register the virtual file system that will be the source of inodes
+	 * for the eventpoll files
+	 */
+	error = register_filesystem(&eventpoll_fs_type);
+	if (error)
+		goto eexit_2;
+
+	/* Mount the above commented virtual file system */
+	eventpoll_mnt = kern_mount(&eventpoll_fs_type);
+	error = PTR_ERR(eventpoll_mnt);
+	if (IS_ERR(eventpoll_mnt))
+		goto eexit_3;
+
+	printk(KERN_INFO "[%p] eventpoll: driver installed.\n", current);
+
+	return 0;
+
+eexit_3:
+	unregister_filesystem(&eventpoll_fs_type);
+eexit_2:
+	kmem_cache_destroy(dpi_cache);
+eexit_1:
+
+	return error;
+}
+
+
+static void __exit eventpoll_exit(void)
+{
+	/* Undo all operations done inside eventpoll_init() */
+	unregister_filesystem(&eventpoll_fs_type);
+	mntput(eventpoll_mnt);
+	kmem_cache_destroy(dpi_cache);
+}
+
+module_init(eventpoll_init);
+module_exit(eventpoll_exit);
+
+MODULE_LICENSE("GPL");
+
diff -Nru linux-2.5.45.vanilla/fs/fcblist.c linux-2.5.45.epoll/fs/fcblist.c
--- linux-2.5.45.vanilla/fs/fcblist.c	Wed Oct 30 16:43:07 2002
+++ linux-2.5.45.epoll/fs/fcblist.c	Wed Dec 31 16:00:00 1969
@@ -1,146 +0,0 @@
-/*
- *  linux/fs/fcblist.c ( File event callbacks handling )
- *  Copyright (C) 2001,...,2002  Davide Libenzi
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  Davide Libenzi <davidel@xmailserver.org>
- *
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/poll.h>
-#include <asm/bitops.h>
-#include <linux/fcblist.h>
-
-
-long ion_band_table[NSIGPOLL] = {
-	ION_IN,		/* POLL_IN */
-	ION_OUT,	/* POLL_OUT */
-	ION_IN,		/* POLL_MSG */
-	ION_ERR,	/* POLL_ERR */
-	0,		/* POLL_PRI */
-	ION_HUP		/* POLL_HUP */
-};
-
-long poll_band_table[NSIGPOLL] = {
-	POLLIN | POLLRDNORM,			/* POLL_IN */
-	POLLOUT | POLLWRNORM | POLLWRBAND,	/* POLL_OUT */
-	POLLIN | POLLRDNORM | POLLMSG,		/* POLL_MSG */
-	POLLERR,				/* POLL_ERR */
-	POLLPRI | POLLRDBAND,			/* POLL_PRI */
-	POLLHUP | POLLERR			/* POLL_HUP */
-};
-
-
-
-/*
- * Walk through the file callback list by calling each registered callback
- * with the event that happened on the "filep" file. Callbacks are called
- * by holding a read lock on the callback list lock, and also by keeping
- * local IRQs disabled.
- */
-void file_notify_event(struct file *filep, long *event)
-{
-	unsigned long flags;
-	struct list_head *lnk, *lsthead;
-
-	read_lock_irqsave(&filep->f_cblock, flags);
-
-	lsthead = &filep->f_cblist;
-	list_for_each(lnk, lsthead) {
-		struct fcb_struct *fcbp = list_entry(lnk, struct fcb_struct, llink);
-
-		fcbp->cbproc(filep, fcbp->data, fcbp->local, event);
-	}
-
-	read_unlock_irqrestore(&filep->f_cblock, flags);
-}
-
-
-/*
- * Add a new callback to the list of file callbacks.
- */
-int file_notify_addcb(struct file *filep,
-		      void (*cbproc)(struct file *, void *, unsigned long *, long *),
-		      void *data)
-{
-	unsigned long flags;
-	struct fcb_struct *fcbp;
-
-	if (!(fcbp = (struct fcb_struct *) kmalloc(sizeof(struct fcb_struct), GFP_KERNEL)))
-		return -ENOMEM;
-
-	memset(fcbp, 0, sizeof(struct fcb_struct));
-	fcbp->cbproc = cbproc;
-	fcbp->data = data;
-
-	write_lock_irqsave(&filep->f_cblock, flags);
-	list_add_tail(&fcbp->llink, &filep->f_cblist);
-	write_unlock_irqrestore(&filep->f_cblock, flags);
-
-	return 0;
-}
-
-
-/*
- * Removes the callback "cbproc" from the file callback list.
- */
-int file_notify_delcb(struct file *filep,
-		      void (*cbproc)(struct file *, void *, unsigned long *, long *))
-{
-	unsigned long flags;
-	struct list_head *lnk, *lsthead;
-
-	write_lock_irqsave(&filep->f_cblock, flags);
-
-	lsthead = &filep->f_cblist;
-	list_for_each(lnk, lsthead) {
-		struct fcb_struct *fcbp = list_entry(lnk, struct fcb_struct, llink);
-
-		if (fcbp->cbproc == cbproc) {
-			list_del(lnk);
-			write_unlock_irqrestore(&filep->f_cblock, flags);
-			kfree(fcbp);
-			return 0;
-		}
-	}
-
-	write_unlock_irqrestore(&filep->f_cblock, flags);
-
-	return -ENOENT;
-}
-
-
-/*
- * It is called at file cleanup time and removes all the registered callbacks.
- */
-void file_notify_cleanup(struct file *filep)
-{
-	unsigned long flags;
-	struct list_head *lsthead;
-
-	write_lock_irqsave(&filep->f_cblock, flags);
-
-	lsthead = &filep->f_cblist;
-	while (!list_empty(lsthead)) {
-		struct fcb_struct *fcbp = list_entry(lsthead->next, struct fcb_struct, llink);
-
-		list_del(lsthead->next);
-		write_unlock_irqrestore(&filep->f_cblock, flags);
-		kfree(fcbp);
-		write_lock_irqsave(&filep->f_cblock, flags);
-	}
-
-	write_unlock_irqrestore(&filep->f_cblock, flags);
-}
-
diff -Nru linux-2.5.45.vanilla/fs/file_table.c linux-2.5.45.epoll/fs/file_table.c
--- linux-2.5.45.vanilla/fs/file_table.c	Wed Oct 30 16:41:39 2002
+++ linux-2.5.45.epoll/fs/file_table.c	Fri Nov  1 16:10:46 2002
@@ -8,12 +8,12 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/file.h>
-#include <linux/fcblist.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
 #include <linux/security.h>
+#include <linux/eventpoll.h>

 /* sysctl tunables... */
 struct files_stat_struct files_stat = {0, 0, NR_FILE};
@@ -59,7 +59,6 @@
 		f->f_gid = current->fsgid;
 		f->f_owner.lock = RW_LOCK_UNLOCKED;
 		list_add(&f->f_list, &anon_list);
-		file_notify_init(f);
 		file_list_unlock();
 		return f;
 	}
@@ -104,7 +103,6 @@
 	filp->f_uid    = current->fsuid;
 	filp->f_gid    = current->fsgid;
 	filp->f_op     = dentry->d_inode->i_fop;
-	file_notify_init(filp);
 	if (filp->f_op->open)
 		return filp->f_op->open(dentry->d_inode, filp);
 	else
@@ -126,7 +124,7 @@
 	struct vfsmount * mnt = file->f_vfsmnt;
 	struct inode * inode = dentry->d_inode;

-	file_notify_cleanup(file);
+	ep_notify_file_close(file);
 	locks_remove_flock(file);

 	if (file->f_op && file->f_op->release)
diff -Nru linux-2.5.45.vanilla/fs/pipe.c linux-2.5.45.epoll/fs/pipe.c
--- linux-2.5.45.vanilla/fs/pipe.c	Wed Oct 30 16:42:57 2002
+++ linux-2.5.45.epoll/fs/pipe.c	Fri Nov  1 12:09:00 2002
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/fcblist.h>

 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -48,7 +47,7 @@
 pipe_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	int do_wakeup, pfull;
+	int do_wakeup;
 	ssize_t ret;

 	/* pread is not allowed on pipes. */
@@ -64,7 +63,6 @@
 	down(PIPE_SEM(*inode));
 	for (;;) {
 		int size = PIPE_LEN(*inode);
-		pfull = PIPE_FULL(*inode);
 		if (size) {
 			char *pipebuf = PIPE_BASE(*inode) + PIPE_START(*inode);
 			ssize_t chars = PIPE_MAX_RCHUNK(*inode);
@@ -110,18 +108,12 @@
 			if (!ret) ret = -ERESTARTSYS;
 			break;
 		}
-		/* Send notification message */
-		if (pfull && !PIPE_FULL(*inode) && PIPE_WRITEFILE(*inode))
-			file_send_notify(PIPE_WRITEFILE(*inode), ION_OUT, POLLOUT | POLLWRNORM | POLLWRBAND);
 		if (do_wakeup) {
 			wake_up_interruptible_sync(PIPE_WAIT(*inode));
  			kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 		}
 		pipe_wait(inode);
 	}
-	/* Send notification message */
-	if (pfull && !PIPE_FULL(*inode) && PIPE_WRITEFILE(*inode))
-		file_send_notify(PIPE_WRITEFILE(*inode), ION_OUT, POLLOUT | POLLWRNORM | POLLWRBAND);
 	up(PIPE_SEM(*inode));
 	/* Signal writers asynchronously that there is more room.  */
 	if (do_wakeup) {
@@ -139,7 +131,7 @@
 	struct inode *inode = filp->f_dentry->d_inode;
 	ssize_t ret;
 	size_t min;
-	int do_wakeup, pempty;
+	int do_wakeup;

 	/* pwrite is not allowed on pipes. */
 	if (unlikely(ppos != &filp->f_pos))
@@ -157,7 +149,6 @@
 	down(PIPE_SEM(*inode));
 	for (;;) {
 		int free;
-		pempty = PIPE_EMPTY(*inode);
 		if (!PIPE_READERS(*inode)) {
 			send_sig(SIGPIPE, current, 0);
 			if (!ret) ret = -EPIPE;
@@ -203,9 +194,6 @@
 			if (!ret) ret = -ERESTARTSYS;
 			break;
 		}
-		/* Send notification message */
-		if (pempty && !PIPE_EMPTY(*inode) && PIPE_READFILE(*inode))
-			file_send_notify(PIPE_READFILE(*inode), ION_IN, POLLIN | POLLRDNORM);
 		if (do_wakeup) {
 			wake_up_interruptible_sync(PIPE_WAIT(*inode));
 			kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
@@ -215,9 +203,6 @@
 		pipe_wait(inode);
 		PIPE_WAITING_WRITERS(*inode)--;
 	}
-	/* Send notification message */
-	if (pempty && !PIPE_EMPTY(*inode) && PIPE_READFILE(*inode))
-		file_send_notify(PIPE_READFILE(*inode), ION_IN, POLLIN | POLLRDNORM);
 	up(PIPE_SEM(*inode));
 	if (do_wakeup) {
 		wake_up_interruptible(PIPE_WAIT(*inode));
@@ -281,22 +266,9 @@
 static int
 pipe_release(struct inode *inode, int decr, int decw)
 {
-	struct file *rdfile, *wrfile;
 	down(PIPE_SEM(*inode));
 	PIPE_READERS(*inode) -= decr;
 	PIPE_WRITERS(*inode) -= decw;
-	rdfile = PIPE_READFILE(*inode);
-	wrfile = PIPE_WRITEFILE(*inode);
- 	if (decr && !PIPE_READERS(*inode)) {
-		PIPE_READFILE(*inode) = NULL;
-		if (wrfile)
-			file_send_notify(wrfile, ION_HUP, POLLHUP);
-	}
-	if (decw && !PIPE_WRITERS(*inode)) {
-		PIPE_WRITEFILE(*inode) = NULL;
-		if (rdfile)
-			file_send_notify(rdfile, ION_HUP, POLLHUP);
-	}
 	if (!PIPE_READERS(*inode) && !PIPE_WRITERS(*inode)) {
 		struct pipe_inode_info *info = inode->i_pipe;
 		inode->i_pipe = NULL;
@@ -516,7 +488,6 @@
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
 	PIPE_WAITING_WRITERS(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
-	PIPE_READFILE(*inode) = PIPE_WRITEFILE(*inode) = NULL;
 	*PIPE_FASYNC_READERS(*inode) = *PIPE_FASYNC_WRITERS(*inode) = NULL;

 	return inode;
@@ -624,9 +595,6 @@
 	f2->f_op = &write_pipe_fops;
 	f2->f_mode = 2;
 	f2->f_version = 0;
-
-	PIPE_READFILE(*inode) = f1;
-	PIPE_WRITEFILE(*inode) = f2;

 	fd_install(i, f1);
 	fd_install(j, f2);
diff -Nru linux-2.5.45.vanilla/fs/select.c linux-2.5.45.epoll/fs/select.c
--- linux-2.5.45.vanilla/fs/select.c	Wed Oct 30 16:41:37 2002
+++ linux-2.5.45.epoll/fs/select.c	Fri Nov  1 14:15:44 2002
@@ -77,6 +77,14 @@
 {
 	struct poll_table_page *table = p->table;

+	if (!p->queue)
+		return;
+
+	if (p->qproc) {
+		p->qproc(p->priv, wait_address);
+		return;
+	}
+
 	if (!table || POLL_TABLE_FULL(table)) {
 		struct poll_table_page *new_table;

diff -Nru linux-2.5.45.vanilla/include/linux/eventpoll.h linux-2.5.45.epoll/include/linux/eventpoll.h
--- linux-2.5.45.vanilla/include/linux/eventpoll.h	Wed Oct 30 16:42:54 2002
+++ linux-2.5.45.epoll/include/linux/eventpoll.h	Sat Nov  2 17:38:49 2002
@@ -1,6 +1,6 @@
 /*
  *  include/linux/eventpoll.h ( Efficent event polling implementation )
- *  Copyright (C) 2001,...,2002  Davide Libenzi
+ *  Copyright (C) 2001,...,2002	 Davide Libenzi
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -14,37 +14,25 @@
 #ifndef _LINUX_EVENTPOLL_H
 #define _LINUX_EVENTPOLL_H

+/* Forward declarations to avoid compiler errors */
+struct file;
+struct pollfd;

-#define EVENTPOLL_MINOR	124
-#define POLLFD_X_PAGE (PAGE_SIZE / sizeof(struct pollfd))
-#define MAX_FDS_IN_EVENTPOLL (1024 * 128)
-#define MAX_EVENTPOLL_PAGES (MAX_FDS_IN_EVENTPOLL / POLLFD_X_PAGE)
-#define EVENT_PAGE_INDEX(n) ((n) / POLLFD_X_PAGE)
-#define EVENT_PAGE_REM(n) ((n) % POLLFD_X_PAGE)
-#define EVENT_PAGE_OFFSET(n) (((n) % POLLFD_X_PAGE) * sizeof(struct pollfd))
-#define EP_FDS_PAGES(n) (((n) + POLLFD_X_PAGE - 1) / POLLFD_X_PAGE)
-#define EP_MAP_SIZE(n) (EP_FDS_PAGES(n) * PAGE_SIZE * 2)
-
-
-struct evpoll {
-	int ep_timeout;
-	unsigned long ep_resoff;
-};
-
-#define EP_ALLOC _IOR('P', 1, int)
-#define EP_POLL _IOWR('P', 2, struct evpoll)
-#define EP_FREE _IO('P', 3)
-#define EP_ISPOLLED _IOWR('P', 4, struct pollfd)

+/* Valid opcodes to issue to sys_epoll_ctl() */
 #define EP_CTL_ADD 1
 #define EP_CTL_DEL 2
 #define EP_CTL_MOD 3


-asmlinkage int sys_epoll_create(int maxfds);
+/* Kernel space functions implementing the user space "epoll" API */
+asmlinkage int sys_epoll_create(int size);
 asmlinkage int sys_epoll_ctl(int epfd, int op, int fd, unsigned int events);
-asmlinkage int sys_epoll_wait(int epfd, struct pollfd const **events, int timeout);
+asmlinkage int sys_epoll_wait(int epfd, struct pollfd *events, int maxevents,
+			      int timeout);

+/* Used in fs/file_table.c:__fput() to unlink files from the eventpoll interface */
+void ep_notify_file_close(struct file *file);


 #endif
diff -Nru linux-2.5.45.vanilla/include/linux/fcblist.h linux-2.5.45.epoll/include/linux/fcblist.h
--- linux-2.5.45.vanilla/include/linux/fcblist.h	Wed Oct 30 16:43:34 2002
+++ linux-2.5.45.epoll/include/linux/fcblist.h	Wed Dec 31 16:00:00 1969
@@ -1,71 +0,0 @@
-/*
- *  include/linux/fcblist.h ( File event callbacks handling )
- *  Copyright (C) 2001,...,2002  Davide Libenzi
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  Davide Libenzi <davidel@xmailserver.org>
- *
- */
-
-#ifndef __LINUX_FCBLIST_H
-#define __LINUX_FCBLIST_H
-
-#include <linux/config.h>
-#include <linux/list.h>
-#include <linux/spinlock.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-
-
-
-/* file callback notification events */
-#define ION_IN		1
-#define ION_OUT		2
-#define ION_HUP		3
-#define ION_ERR		4
-
-#define FCB_LOCAL_SIZE	4
-
-
-struct fcb_struct {
-	struct list_head llink;
-	void (*cbproc)(struct file *, void *, unsigned long *, long *);
-	void *data;
-	unsigned long local[FCB_LOCAL_SIZE];
-};
-
-
-extern long ion_band_table[];
-extern long poll_band_table[];
-
-
-void file_notify_event(struct file *filep, long *event);
-
-int file_notify_addcb(struct file *filep,
-		      void (*cbproc)(struct file *, void *, unsigned long *, long *),
-		      void *data);
-
-int file_notify_delcb(struct file *filep,
-		      void (*cbproc)(struct file *, void *, unsigned long *, long *));
-
-void file_notify_cleanup(struct file *filep);
-
-
-static inline void file_notify_init(struct file *filep)
-{
-	rwlock_init(&filep->f_cblock);
-	INIT_LIST_HEAD(&filep->f_cblist);
-}
-
-static inline void file_send_notify(struct file *filep, long ioevt, long plevt)
-{
-	long event[] = { ioevt, plevt, -1 };
-
-	file_notify_event(filep, event);
-}
-
-#endif
diff -Nru linux-2.5.45.vanilla/include/linux/fs.h linux-2.5.45.epoll/include/linux/fs.h
--- linux-2.5.45.vanilla/include/linux/fs.h	Wed Oct 30 16:42:21 2002
+++ linux-2.5.45.epoll/include/linux/fs.h	Fri Nov  1 12:10:05 2002
@@ -504,10 +504,6 @@

 	/* needed for tty driver, and maybe others */
 	void			*private_data;
-
-	/* file callback list */
-	rwlock_t f_cblock;
-	struct list_head f_cblist;
 };
 extern spinlock_t files_lock;
 #define file_list_lock() spin_lock(&files_lock);
diff -Nru linux-2.5.45.vanilla/include/linux/pipe_fs_i.h linux-2.5.45.epoll/include/linux/pipe_fs_i.h
--- linux-2.5.45.vanilla/include/linux/pipe_fs_i.h	Wed Oct 30 16:43:07 2002
+++ linux-2.5.45.epoll/include/linux/pipe_fs_i.h	Fri Nov  1 12:10:38 2002
@@ -12,8 +12,6 @@
 	unsigned int waiting_writers;
 	unsigned int r_counter;
 	unsigned int w_counter;
-	struct file *rdfile;
-	struct file *wrfile;
 	struct fasync_struct *fasync_readers;
 	struct fasync_struct *fasync_writers;
 };
@@ -32,8 +30,6 @@
 #define PIPE_WAITING_WRITERS(inode)	((inode).i_pipe->waiting_writers)
 #define PIPE_RCOUNTER(inode)	((inode).i_pipe->r_counter)
 #define PIPE_WCOUNTER(inode)	((inode).i_pipe->w_counter)
-#define PIPE_READFILE(inode)	((inode).i_pipe->rdfile)
-#define PIPE_WRITEFILE(inode)	((inode).i_pipe->wrfile)
 #define PIPE_FASYNC_READERS(inode)     (&((inode).i_pipe->fasync_readers))
 #define PIPE_FASYNC_WRITERS(inode)     (&((inode).i_pipe->fasync_writers))

diff -Nru linux-2.5.45.vanilla/include/linux/poll.h linux-2.5.45.epoll/include/linux/poll.h
--- linux-2.5.45.vanilla/include/linux/poll.h	Wed Oct 30 16:42:54 2002
+++ linux-2.5.45.epoll/include/linux/poll.h	Fri Nov  1 14:28:06 2002
@@ -13,6 +13,9 @@
 struct poll_table_page;

 typedef struct poll_table_struct {
+	int queue;
+	void *priv;
+	void (*qproc)(void *, wait_queue_head_t *);
 	int error;
 	struct poll_table_page * table;
 } poll_table;
@@ -27,9 +30,24 @@

 static inline void poll_initwait(poll_table* pt)
 {
+	pt->queue = 1;
+	pt->qproc = NULL;
+	pt->priv = NULL;
 	pt->error = 0;
 	pt->table = NULL;
 }
+
+static inline void poll_initwait_ex(poll_table* pt, int queue,
+				    void (*qproc)(void *, wait_queue_head_t *),
+				    void *priv)
+{
+	pt->queue = queue;
+	pt->qproc = qproc;
+	pt->priv = priv;
+	pt->error = 0;
+	pt->table = NULL;
+}
+
 extern void poll_freewait(poll_table* pt);


diff -Nru linux-2.5.45.vanilla/include/net/sock.h linux-2.5.45.epoll/include/net/sock.h
--- linux-2.5.45.vanilla/include/net/sock.h	Wed Oct 30 16:43:33 2002
+++ linux-2.5.45.epoll/include/net/sock.h	Fri Nov  1 12:11:53 2002
@@ -52,9 +52,6 @@
 #include <asm/atomic.h>
 #include <net/dst.h>
 #include <net/scm.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include <linux/fcblist.h>

 /*
  * This structure really needs to be cleaned up.
@@ -769,13 +766,8 @@

 static inline void sk_wake_async(struct sock *sk, int how, int band)
 {
-	if (sk->socket) {
-		if (sk->socket->file)
-			file_send_notify(sk->socket->file, ion_band_table[band - POLL_IN],
-					 poll_band_table[band - POLL_IN]);
-		if (sk->socket->fasync_list)
-			sock_wake_async(sk->socket, how, band);
-	}
+	if (sk->socket && sk->socket->fasync_list)
+		sock_wake_async(sk->socket, how, band);
 }

 #define SOCK_MIN_SNDBUF 2048
diff -Nru linux-2.5.45.vanilla/net/ipv4/tcp.c linux-2.5.45.epoll/net/ipv4/tcp.c
--- linux-2.5.45.vanilla/net/ipv4/tcp.c	Wed Oct 30 16:42:21 2002
+++ linux-2.5.45.epoll/net/ipv4/tcp.c	Fri Nov  1 12:15:17 2002
@@ -476,8 +476,8 @@
 		if (sk->sleep && waitqueue_active(sk->sleep))
 			wake_up_interruptible(sk->sleep);

-		if (!(sk->shutdown & SEND_SHUTDOWN))
-			sk_wake_async(sk, 2, POLL_OUT);
+		if (sock->fasync_list && !(sk->shutdown & SEND_SHUTDOWN))
+			sock_wake_async(sock, 2, POLL_OUT);
 	}
 }



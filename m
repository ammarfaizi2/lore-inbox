Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbSJ1TOM>; Mon, 28 Oct 2002 14:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbSJ1TOL>; Mon, 28 Oct 2002 14:14:11 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:13219 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261515AbSJ1TNo>; Mon, 28 Oct 2002 14:13:44 -0500
Date: Mon, 28 Oct 2002 11:14:19 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, davidel@xmailserver.org,
       linux-aio@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: [PATCH] epoll more scalable than poll
Message-ID: <53100000.1035832459@w-hlinder>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, October 18, 2002 15:05:50 -0700 Linus Torvalds <torvalds@transmeta.com> wrote:

> I like it noticeably better as a system call, so it's maybe worth 
> discussing. It's not going to happen before I leave (very early tomorrow 
> morning), but if people involved agree on this and clean patches to 
> actiually add the code (not just system call stubs) can be made..
> 
> 		Linus

Linus,

	The results of our testing show not only does the system call 
interface to epoll perform as well as the /dev interface but also that epoll 
is many times better than standard poll. No other implementations of poll 
have performed as well as epoll in any measure. Testing details and results 
are published here, please take a minute to check it out: http://lse.sourceforge.net/epoll/index.html
	Davide Libenzi finished the system call interface to epoll including
the changes Andrew Morton requested early last week. See that thread here: http://marc.theaimsgroup.com/?t=103516170500003&r=1&w=2
	Please consider sys_epoll for inclusion in the next 2.5 kernel release.
The results clearly show epoll is the most scalable of all the existing poll implementations and the impact on existing code is minimal. 

Thank you.

Hanna 

ps- Did I mention there is a web site? http://lse.sf.net/epoll/index.html

-----
diff -Nru linux-2.5.44.vanilla/arch/i386/kernel/entry.S linux-2.5.44.epoll/arch/i386/kernel/entry.S
--- linux-2.5.44.vanilla/arch/i386/kernel/entry.S	Fri Oct 18 21:01:19 2002
+++ linux-2.5.44.epoll/arch/i386/kernel/entry.S	Sat Oct 19 21:16:19 2002
@@ -737,6 +737,10 @@
 	.long sys_free_hugepages
 	.long sys_exit_group
 	.long sys_lookup_dcookie
+	.long sys_epoll_create
+	.long sys_epoll_ctl	/* 255 */
+	.long sys_epoll_wait
+
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -Nru linux-2.5.44.vanilla/drivers/char/Makefile linux-2.5.44.epoll/drivers/char/Makefile
--- linux-2.5.44.vanilla/drivers/char/Makefile	Fri Oct 18 21:02:32 2002
+++ linux-2.5.44.epoll/drivers/char/Makefile	Tue Oct 22 10:08:40 2002
@@ -7,14 +7,14 @@
 #
 FONTMAPFILE = cp437.uni
 
-obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o random.o
+obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o random.o eventpoll.o
 
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
 export-objs     :=	busmouse.o vt.o generic_serial.o ip2main.o \
 			ite_gpio.o keyboard.o misc.o nvram.o random.o rtc.o \
-			selection.o sonypi.o sysrq.o tty_io.o tty_ioctl.o
+			selection.o sonypi.o sysrq.o tty_io.o tty_ioctl.o eventpoll.o
 
 obj-$(CONFIG_VT) += vt_ioctl.o vc_screen.o consolemap.o consolemap_deftbl.o selection.o keyboard.o
 obj-$(CONFIG_HW_CONSOLE) += vt.o defkeymap.o
diff -Nru linux-2.5.44.vanilla/drivers/char/eventpoll.c linux-2.5.44.epoll/drivers/char/eventpoll.c
--- linux-2.5.44.vanilla/drivers/char/eventpoll.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.epoll/drivers/char/eventpoll.c	Sun Oct 27 15:23:47 2002
@@ -0,0 +1,1136 @@
+/*
+ *  drivers/char/eventpoll.c ( Efficent event polling implementation )
+ *  Copyright (C) 2001,...,2002  Davide Libenzi
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
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+#include <linux/miscdevice.h>
+#include <linux/random.h>
+#include <linux/smp_lock.h>
+#include <linux/wrapper.h>
+#include <linux/string.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <linux/fcblist.h>
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
+#define INITIAL_HASH_BITS 7
+#define MAX_HASH_BITS 18
+#define RESIZE_LENGTH 2
+
+#define DPI_MEM_ALLOC()	(struct epitem *) kmem_cache_alloc(dpi_cache, SLAB_KERNEL)
+#define DPI_MEM_FREE(p) kmem_cache_free(dpi_cache, p)
+#define IS_FILE_EPOLL(f) ((f)->f_op == &eventpoll_fops)
+
+
+
+typedef unsigned long long event_version_t;
+
+struct eventpoll {
+	rwlock_t lock;
+	wait_queue_head_t wq;
+	wait_queue_head_t poll_wait;
+	struct list_head *hash;
+	unsigned int hbits;
+	unsigned int hmask;
+	atomic_t hents;
+	atomic_t resize;
+	int numpages;
+	char **pages;
+	char *pages0[MAX_EVENTPOLL_PAGES];
+	char *pages1[MAX_EVENTPOLL_PAGES];
+	unsigned long vmabase;
+	atomic_t mmapped;
+	int eventcnt;
+	event_version_t ver;
+};
+
+struct epitem {
+	struct list_head llink;
+	struct eventpoll *ep;
+	struct file *file;
+	struct pollfd pfd;
+	int index;
+	event_version_t ver;
+};
+
+
+
+
+static int ep_getfd(int *efd, struct inode **einode, struct file **efile);
+static int ep_alloc_pages(char **pages, int numpages);
+static int ep_free_pages(char **pages, int numpages);
+static int ep_init(struct eventpoll *ep);
+static void ep_free(struct eventpoll *ep);
+static struct epitem *ep_find_nl(struct eventpoll *ep, int fd);
+static struct epitem *ep_find(struct eventpoll *ep, int fd);
+static int ep_hashresize(struct eventpoll *ep, unsigned long *kflags);
+static int ep_insert(struct eventpoll *ep, struct pollfd *pfd);
+static int ep_remove(struct eventpoll *ep, struct epitem *dpi);
+static void notify_proc(struct file *file, void *data, unsigned long *local, long *event);
+static int open_eventpoll(struct inode *inode, struct file *file);
+static int close_eventpoll(struct inode *inode, struct file *file);
+static unsigned int poll_eventpoll(struct file *file, poll_table *wait);
+static int write_eventpoll(struct file *file, const char *buffer, size_t count,
+						   loff_t *ppos);
+static int ep_poll(struct eventpoll *ep, struct evpoll *dvp);
+static int ep_do_alloc_pages(struct eventpoll *ep, int numpages);
+static int ioctl_eventpoll(struct inode *inode, struct file *file,
+						   unsigned int cmd, unsigned long arg);
+static void eventpoll_mm_open(struct vm_area_struct * vma);
+static void eventpoll_mm_close(struct vm_area_struct * vma);
+static int mmap_eventpoll(struct file *file, struct vm_area_struct *vma);
+static int eventpollfs_delete_dentry(struct dentry *dentry);
+static struct inode *get_eventpoll_inode(void);
+static struct super_block *eventpollfs_get_sb(struct file_system_type *fs_type,
+											  int flags, char *dev_name, void *data);
+
+
+
+
+static kmem_cache_t *dpi_cache;
+static struct vfsmount *eventpoll_mnt;
+
+static struct file_operations eventpoll_fops = {
+	.write		= write_eventpoll,
+	.ioctl		= ioctl_eventpoll,
+	.mmap		= mmap_eventpoll,
+	.open		= open_eventpoll,
+	.release	= close_eventpoll,
+	.poll		= poll_eventpoll
+};
+
+static struct vm_operations_struct eventpoll_mmap_ops = {
+	.open		= eventpoll_mm_open,
+	.close		= eventpoll_mm_close,
+};
+
+static struct miscdevice eventpoll_miscdev = {
+	EVENTPOLL_MINOR, "eventpoll", &eventpoll_fops
+};
+
+static struct file_system_type eventpoll_fs_type = {
+	.name		= "eventpollfs",
+	.get_sb		= eventpollfs_get_sb,
+	.kill_sb	= kill_anon_super,
+};
+
+static struct dentry_operations eventpollfs_dentry_operations = {
+	.d_delete	= eventpollfs_delete_dentry,
+};
+
+
+
+asmlinkage int sys_epoll_create(int maxfds)
+{
+	int error = -EINVAL, fd;
+	unsigned long addr;
+	struct inode *inode;
+	struct file *file;
+	struct eventpoll *ep;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d)\n",
+				 current, maxfds));
+
+	if (maxfds > MAX_FDS_IN_EVENTPOLL)
+		goto eexit_1;
+	error = ep_getfd(&fd, &inode, &file);
+	if (error)
+		goto eexit_1;
+	error = open_eventpoll(inode, file);
+	if (error)
+		goto eexit_2;
+	ep = file->private_data;
+	error = ep_do_alloc_pages(ep, EP_FDS_PAGES(maxfds + 1));
+	if (error)
+		goto eexit_2;
+	down_write(&current->mm->mmap_sem);
+	addr = do_mmap_pgoff(file, 0, EP_MAP_SIZE(maxfds + 1), PROT_READ,
+						 MAP_PRIVATE, 0);
+	up_write(&current->mm->mmap_sem);
+	error = PTR_ERR((void *) addr);
+	if (IS_ERR((void *) addr))
+		goto eexit_2;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d) = %d\n",
+				 current, maxfds, fd));
+
+	return fd;
+
+eexit_2:
+	sys_close(fd);
+eexit_1:
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d) = %d\n",
+				 current, maxfds, error));
+	return error;
+}
+EXPORT_SYMBOL(sys_epoll_create);
+
+
+asmlinkage int sys_epoll_ctl(int epfd, int op, int fd, unsigned int events)
+{
+	int error = -EBADF;
+	struct file *file;
+	struct eventpoll *ep;
+	struct epitem *dpi;
+	struct pollfd pfd;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_ctl(%d, %d, %d, %u)\n",
+				 current, epfd, op, fd, events));
+
+	file = fget(epfd);
+	if (!file)
+		goto eexit_1;
+	error = -EINVAL;
+	if (!IS_FILE_EPOLL(file))
+		goto eexit_2;
+
+	ep = file->private_data;
+
+	pfd.fd = fd;
+	pfd.events = events;
+	pfd.revents = 0;
+
+	dpi = ep_find(ep, fd);
+
+	error = -EINVAL;
+	switch (op) {
+	case EP_CTL_ADD:
+		if (!dpi)
+			error = ep_insert(ep, &pfd);
+		else
+			error = -EEXIST;
+		break;
+	case EP_CTL_DEL:
+		if (dpi)
+			error = ep_remove(ep, dpi);
+		else
+			error = -ENOENT;
+		break;
+	case EP_CTL_MOD:
+		if (dpi) {
+			dpi->pfd.events = events;
+			error = 0;
+		} else
+			error = -ENOENT;
+		break;
+	}
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_ctl(%d, %d, %d, %u) = %d\n",
+				 current, epfd, op, fd, events, error));
+
+eexit_2:
+	fput(file);
+eexit_1:
+	return error;
+}
+EXPORT_SYMBOL(sys_epoll_ctl);
+
+
+asmlinkage int sys_epoll_wait(int epfd, struct pollfd const **events, int timeout)
+{
+	int error = -EBADF;
+	void *eaddr;
+	struct file *file;
+	struct eventpoll *ep;
+	struct evpoll dvp;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d)\n",
+				 current, epfd, events, timeout));
+
+	file = fget(epfd);
+	if (!file)
+		goto eexit_1;
+	error = -EINVAL;
+	if (!IS_FILE_EPOLL(file))
+		goto eexit_2;
+
+	ep = file->private_data;
+
+	error = -EINVAL;
+	if (!atomic_read(&ep->mmapped))
+		goto eexit_2;
+
+	dvp.ep_timeout = timeout;
+	error = ep_poll(ep, &dvp);
+	if (error > 0) {
+		eaddr = (void *) (ep->vmabase + dvp.ep_resoff);
+		if (copy_to_user(events, &eaddr, sizeof(struct pollfd *)))
+			error = -EFAULT;
+	}
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d) = %d\n",
+				 current, epfd, events, timeout, error));
+
+eexit_2:
+	fput(file);
+eexit_1:
+	return error;
+}
+EXPORT_SYMBOL(sys_epoll_wait);
+
+
+static int ep_getfd(int *efd, struct inode **einode, struct file **efile)
+{
+	struct qstr this;
+	char name[32];
+	struct dentry *dentry;
+	struct inode *inode;
+	struct file *file;
+	int error, fd;
+
+	error = -ENFILE;
+	file = get_empty_filp();
+	if (!file)
+		goto eexit_1;
+
+	inode = get_eventpoll_inode();
+	error = PTR_ERR(inode);
+	if (IS_ERR(inode))
+		goto eexit_2;
+
+	error = get_unused_fd();
+	if (error < 0)
+		goto eexit_3;
+	fd = error;
+
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
+	file->f_vfsmnt = mntget(mntget(eventpoll_mnt));
+	file->f_dentry = dget(dentry);
+
+	file->f_pos = 0;
+	file->f_flags = O_RDWR;
+	file->f_op = &eventpoll_fops;
+	file->f_mode = FMODE_READ | FMODE_WRITE;
+	file->f_version = 0;
+	file->private_data = NULL;
+
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
+	int ii;
+
+	for (ii = 0; ii < numpages; ii++) {
+		pages[ii] = (char *) __get_free_pages(GFP_KERNEL, 0);
+		if (!pages[ii]) {
+			for (--ii; ii >= 0; ii--) {
+				ClearPageReserved(virt_to_page(pages[ii]));
+				free_pages((unsigned long) pages[ii], 0);
+			}
+			return -ENOMEM;
+		}
+		SetPageReserved(virt_to_page(pages[ii]));
+	}
+	return 0;
+}
+
+
+static int ep_free_pages(char **pages, int numpages)
+{
+	int ii;
+
+	for (ii = 0; ii < numpages; ii++) {
+		ClearPageReserved(virt_to_page(pages[ii]));
+		free_pages((unsigned long) pages[ii], 0);
+	}
+	return 0;
+}
+
+
+static int ep_init(struct eventpoll *ep)
+{
+	int ii, hentries;
+
+	rwlock_init(&ep->lock);
+	init_waitqueue_head(&ep->wq);
+	init_waitqueue_head(&ep->poll_wait);
+	ep->hbits = INITIAL_HASH_BITS;
+	ep->hmask = (1 << ep->hbits) - 1;
+	atomic_set(&ep->hents, 0);
+	atomic_set(&ep->resize, 0);
+	atomic_set(&ep->mmapped, 0);
+	ep->numpages = 0;
+	ep->vmabase = 0;
+	ep->pages = ep->pages0;
+	ep->eventcnt = 0;
+	ep->ver = 1;
+
+	hentries = ep->hmask + 1;
+	if (!(ep->hash = (struct list_head *) vmalloc(hentries * sizeof(struct list_head))))
+		return -ENOMEM;
+
+	for (ii = 0; ii < hentries; ii++)
+		INIT_LIST_HEAD(&ep->hash[ii]);
+
+	return 0;
+}
+
+
+static void ep_free(struct eventpoll *ep)
+{
+	int ii;
+	struct list_head *lnk;
+
+	for (ii = 0; ii <= ep->hmask; ii++) {
+		while ((lnk = list_first(&ep->hash[ii]))) {
+			struct epitem *dpi = list_entry(lnk, struct epitem, llink);
+
+			file_notify_delcb(dpi->file, notify_proc);
+			list_del(lnk);
+			DPI_MEM_FREE(dpi);
+		}
+	}
+	vfree(ep->hash);
+	if (ep->numpages > 0) {
+		ep_free_pages(ep->pages0, ep->numpages);
+		ep_free_pages(ep->pages1, ep->numpages);
+	}
+}
+
+
+static struct epitem *ep_find_nl(struct eventpoll *ep, int fd)
+{
+	struct epitem *dpi = NULL;
+	struct list_head *lsthead, *lnk;
+
+	lsthead = &ep->hash[fd & ep->hmask];
+	list_for_each(lnk, lsthead) {
+		dpi = list_entry(lnk, struct epitem, llink);
+
+		if (dpi->pfd.fd == fd) break;
+		dpi = NULL;
+	}
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_find(%d) -> %p\n", current, fd, dpi));
+
+	return dpi;
+}
+
+
+static struct epitem *ep_find(struct eventpoll *ep, int fd)
+{
+	struct epitem *dpi;
+	unsigned long flags;
+
+	read_lock_irqsave(&ep->lock, flags);
+
+	dpi = ep_find_nl(ep, fd);
+
+	read_unlock_irqrestore(&ep->lock, flags);
+
+	return dpi;
+}
+
+
+static int ep_hashresize(struct eventpoll *ep, unsigned long *kflags)
+{
+	struct list_head *hash, *oldhash;
+	unsigned int hbits = ep->hbits + 1;
+	unsigned int hmask = (1 << hbits) - 1;
+	int ii, res, hentries = hmask + 1;
+	unsigned long flags = *kflags;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_hashresize(%p) bits=%u\n", current, ep, hbits));
+
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	res = -ENOMEM;
+	if (!(hash = (struct list_head *) vmalloc(hentries * sizeof(struct list_head)))) {
+		write_lock_irqsave(&ep->lock, flags);
+		goto eexit_1;
+	}
+
+	for (ii = 0; ii < hentries; ii++)
+		INIT_LIST_HEAD(&hash[ii]);
+
+	write_lock_irqsave(&ep->lock, flags);
+
+	oldhash = ep->hash;
+	for (ii = 0; ii <= ep->hmask; ii++) {
+		struct list_head *oldhead = &oldhash[ii], *lnk;
+
+		while ((lnk = list_first(oldhead))) {
+			struct epitem *dpi = list_entry(lnk, struct epitem, llink);
+
+			list_del(lnk);
+			list_add(lnk, &hash[dpi->pfd.fd & hmask]);
+		}
+	}
+
+	ep->hash = hash;
+	ep->hbits = hbits;
+	ep->hmask = hmask;
+
+	write_unlock_irqrestore(&ep->lock, flags);
+	vfree(oldhash);
+	write_lock_irqsave(&ep->lock, flags);
+
+	res = 0;
+eexit_1:
+	*kflags = flags;
+	atomic_dec(&ep->resize);
+	return res;
+}
+
+
+static int ep_insert(struct eventpoll *ep, struct pollfd *pfd)
+{
+	int error;
+	struct epitem *dpi;
+	struct file *file;
+	unsigned long flags;
+
+	if (atomic_read(&ep->hents) >= (ep->numpages * POLLFD_X_PAGE))
+		return -E2BIG;
+
+	file = fget(pfd->fd);
+	if (!file)
+		return -EBADF;
+
+	error = -ENOMEM;
+	if (!(dpi = DPI_MEM_ALLOC()))
+		goto eexit_1;
+
+	INIT_LIST_HEAD(&dpi->llink);
+	dpi->ep = ep;
+	dpi->file = file;
+	dpi->pfd = *pfd;
+	dpi->index = -1;
+	dpi->ver = ep->ver - 1;
+
+	write_lock_irqsave(&ep->lock, flags);
+
+	list_add(&dpi->llink, &ep->hash[pfd->fd & ep->hmask]);
+	atomic_inc(&ep->hents);
+
+	if (!atomic_read(&ep->resize) &&
+		(atomic_read(&ep->hents) >> ep->hbits) > RESIZE_LENGTH &&
+		ep->hbits < MAX_HASH_BITS) {
+		atomic_inc(&ep->resize);
+		ep_hashresize(ep, &flags);
+	}
+
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	file_notify_addcb(file, notify_proc, dpi);
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_insert(%p, %d)\n", current, ep, pfd->fd));
+
+	error = 0;
+eexit_1:
+	fput(file);
+
+	return error;
+}
+
+
+static int ep_remove(struct eventpoll *ep, struct epitem *dpi)
+{
+	unsigned long flags;
+	struct pollfd *pfd, *lpfd;
+	struct epitem *ldpi;
+
+	file_notify_delcb(dpi->file, notify_proc);
+
+	write_lock_irqsave(&ep->lock, flags);
+
+	list_del(&dpi->llink);
+	atomic_dec(&ep->hents);
+
+	if (dpi->index >= 0 && dpi->ver == ep->ver && dpi->index < ep->eventcnt) {
+		pfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(dpi->index)] +
+								 EVENT_PAGE_OFFSET(dpi->index));
+		if (pfd->fd == dpi->pfd.fd && dpi->index < --ep->eventcnt) {
+			lpfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(ep->eventcnt)] +
+									  EVENT_PAGE_OFFSET(ep->eventcnt));
+			*pfd = *lpfd;
+
+			if ((ldpi = ep_find_nl(ep, pfd->fd))) ldpi->index = dpi->index;
+		}
+	}
+
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_remove(%p, %d)\n",
+				 current, ep, dpi->pfd.fd));
+
+	DPI_MEM_FREE(dpi);
+
+	return 0;
+}
+
+
+static void notify_proc(struct file *file, void *data, unsigned long *local, long *event)
+{
+	struct epitem *dpi = data;
+	struct eventpoll *ep = dpi->ep;
+	struct pollfd *pfd;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: notify(%p, %p, %ld, %ld) ep=%p\n",
+				 current, file, data, event[0], event[1], ep));
+
+	write_lock(&ep->lock);
+	if (!(dpi->pfd.events & event[1]))
+		goto out;
+
+	if (dpi->index < 0 || dpi->ver != ep->ver) {
+		if (ep->eventcnt >= (ep->numpages * POLLFD_X_PAGE))
+			goto out;
+		dpi->index = ep->eventcnt++;
+		dpi->ver = ep->ver;
+		pfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(dpi->index)] +
+								 EVENT_PAGE_OFFSET(dpi->index));
+		*pfd = dpi->pfd;
+	} else {
+		pfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(dpi->index)] +
+								 EVENT_PAGE_OFFSET(dpi->index));
+		if (pfd->fd != dpi->pfd.fd) {
+			if (ep->eventcnt >= (ep->numpages * POLLFD_X_PAGE))
+				goto out;
+			dpi->index = ep->eventcnt++;
+			pfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(dpi->index)] +
+									 EVENT_PAGE_OFFSET(dpi->index));
+			*pfd = dpi->pfd;
+		}
+	}
+
+	pfd->revents |= (pfd->events & event[1]);
+
+	if (waitqueue_active(&ep->wq))
+		wake_up(&ep->wq);
+	if (waitqueue_active(&ep->poll_wait))
+		wake_up(&ep->poll_wait);
+out:
+	write_unlock(&ep->lock);
+}
+
+
+static int open_eventpoll(struct inode *inode, struct file *file)
+{
+	int res;
+	struct eventpoll *ep;
+
+	if (!(ep = kmalloc(sizeof(struct eventpoll), GFP_KERNEL)))
+		return -ENOMEM;
+
+	memset(ep, 0, sizeof(*ep));
+	if ((res = ep_init(ep))) {
+		kfree(ep);
+		return res;
+	}
+
+	file->private_data = ep;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: open() ep=%p\n", current, ep));
+	return 0;
+}
+
+
+static int close_eventpoll(struct inode *inode, struct file *file)
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
+static unsigned int poll_eventpoll(struct file *file, poll_table *wait)
+{
+	struct eventpoll *ep = file->private_data;
+
+	poll_wait(file, &ep->poll_wait, wait);
+	if (ep->eventcnt)
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+
+static int write_eventpoll(struct file *file, const char *buffer, size_t count,
+						   loff_t *ppos)
+{
+	int rcount;
+	struct eventpoll *ep = file->private_data;
+	struct epitem *dpi;
+	struct pollfd pfd;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: write(%p, %d)\n", current, ep, count));
+
+	rcount = -EINVAL;
+	if (count % sizeof(struct pollfd))
+		goto eexit_1;
+
+	if ((rcount = verify_area(VERIFY_READ, buffer, count)))
+		goto eexit_1;
+
+	rcount = 0;
+
+	while (count > 0) {
+		if (__copy_from_user(&pfd, buffer, sizeof(pfd))) {
+			rcount = -EFAULT;
+			goto eexit_1;
+		}
+
+		dpi = ep_find(ep, pfd.fd);
+
+		if (pfd.fd >= current->files->max_fds || !current->files->fd[pfd.fd])
+			pfd.events = POLLREMOVE;
+		if (pfd.events & POLLREMOVE) {
+			if (dpi) {
+				ep_remove(ep, dpi);
+				rcount += sizeof(pfd);
+			}
+		}
+		else if (dpi) {
+			dpi->pfd.events = pfd.events;
+			rcount += sizeof(pfd);
+		} else {
+			pfd.revents = 0;
+			if (!ep_insert(ep, &pfd))
+				rcount += sizeof(pfd);
+		}
+
+		buffer += sizeof(pfd);
+		count -= sizeof(pfd);
+	}
+
+eexit_1:
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: write(%p, %d) = %d\n",
+				 current, ep, count, rcount));
+
+	return rcount;
+}
+
+
+static int ep_poll(struct eventpoll *ep, struct evpoll *dvp)
+{
+	int res = 0;
+	long timeout;
+	unsigned long flags;
+	wait_queue_t wait;
+
+	if (!atomic_read(&ep->mmapped))
+		return -EINVAL;
+
+	write_lock_irqsave(&ep->lock, flags);
+
+	res = 0;
+	if (!ep->eventcnt) {
+		init_waitqueue_entry(&wait, current);
+		add_wait_queue(&ep->wq, &wait);
+		timeout = dvp->ep_timeout == -1 || dvp->ep_timeout > MAX_SCHEDULE_TIMEOUT / HZ ?
+			MAX_SCHEDULE_TIMEOUT: (dvp->ep_timeout * HZ) / 1000; 
+		for (;;) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			if (ep->eventcnt || !timeout)
+				break;
+			if (signal_pending(current)) {
+				res = -EINTR;
+				break;
+			}
+
+			write_unlock_irqrestore(&ep->lock, flags);
+			timeout = schedule_timeout(timeout);
+			write_lock_irqsave(&ep->lock, flags);
+		}
+		remove_wait_queue(&ep->wq, &wait);
+
+		set_current_state(TASK_RUNNING);
+	}
+
+	if (!res && ep->eventcnt) {
+		res = ep->eventcnt;
+		ep->eventcnt = 0;
+		++ep->ver;
+		if (ep->pages == ep->pages0) {
+			ep->pages = ep->pages1;
+			dvp->ep_resoff = 0;
+		} else {
+			ep->pages = ep->pages0;
+			dvp->ep_resoff = ep->numpages * PAGE_SIZE;
+		}
+	}
+
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	return res;
+}
+
+
+static int ep_do_alloc_pages(struct eventpoll *ep, int numpages)
+{
+	int res, pgalloc, pgcpy;
+	unsigned long flags;
+	char **pages, **pages0, **pages1;
+
+	if (atomic_read(&ep->mmapped))
+		return -EBUSY;
+	if (numpages > MAX_EVENTPOLL_PAGES)
+		return -EINVAL;
+
+	pgalloc = numpages - ep->numpages;
+	if ((pages = (char **) vmalloc(2 * (pgalloc + 1) * sizeof(char *))) == NULL)
+		return -ENOMEM;
+	pages0 = &pages[0];
+	pages1 = &pages[pgalloc + 1];
+
+	if ((res = ep_alloc_pages(pages0, pgalloc)))
+		goto eexit_1;
+
+	if ((res = ep_alloc_pages(pages1, pgalloc))) {
+		ep_free_pages(pages0, pgalloc);
+		goto eexit_1;
+	}
+
+	write_lock_irqsave(&ep->lock, flags);
+	pgcpy = (ep->numpages + pgalloc) > numpages ? numpages - ep->numpages: pgalloc;
+	if (pgcpy > 0) {
+		memcpy(&ep->pages0[ep->numpages], pages0, pgcpy * sizeof(char *));
+		memcpy(&ep->pages1[ep->numpages], pages1, pgcpy * sizeof(char *));
+		ep->numpages += pgcpy;
+	}
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	if (pgcpy < pgalloc) {
+		if (pgcpy < 0)
+			pgcpy = 0;
+		ep_free_pages(&pages0[pgcpy], pgalloc - pgcpy);
+		ep_free_pages(&pages1[pgcpy], pgalloc - pgcpy);
+	}
+
+eexit_1:
+	vfree(pages);
+	return res;
+}
+
+
+static int ioctl_eventpoll(struct inode *inode, struct file *file,
+						   unsigned int cmd, unsigned long arg)
+{
+	int res;
+	struct eventpoll *ep = file->private_data;
+	struct epitem *dpi;
+	unsigned long flags;
+	struct pollfd pfd;
+	struct evpoll dvp;
+
+	switch (cmd) {
+	case EP_ALLOC:
+		res = ep_do_alloc_pages(ep, EP_FDS_PAGES(arg));
+
+		DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ioctl(%p, EP_ALLOC, %lu) == %d\n",
+					 current, ep, arg, res));
+		return res;
+
+	case EP_FREE:
+		if (atomic_read(&ep->mmapped))
+			return -EBUSY;
+
+		res = -EINVAL;
+		write_lock_irqsave(&ep->lock, flags);
+		if (ep->numpages > 0) {
+			ep_free_pages(ep->pages0, ep->numpages);
+			ep_free_pages(ep->pages1, ep->numpages);
+			ep->numpages = 0;
+			ep->pages = ep->pages0;
+			res = 0;
+		}
+		write_unlock_irqrestore(&ep->lock, flags);
+
+		DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ioctl(%p, EP_FREE) == %d\n",
+					 current, ep, res));
+		return res;
+
+	case EP_POLL:
+		if (copy_from_user(&dvp, (void *) arg, sizeof(struct evpoll)))
+			return -EFAULT;
+
+		DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ioctl(%p, EP_POLL, %d)\n",
+					 current, ep, dvp.ep_timeout));
+
+		res = ep_poll(ep, &dvp);
+
+		DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ioctl(%p, EP_POLL, %d) == %d\n",
+					 current, ep, dvp.ep_timeout, res));
+
+		if (res > 0 && copy_to_user((void *) arg, &dvp, sizeof(struct evpoll)))
+			res = -EFAULT;
+
+		return res;
+
+	case EP_ISPOLLED:
+		if (copy_from_user(&pfd, (void *) arg, sizeof(struct pollfd)))
+			return 0;
+
+		read_lock_irqsave(&ep->lock, flags);
+
+		res = 0;
+		if (!(dpi = ep_find_nl(ep, pfd.fd)))
+			goto is_not_polled;
+
+		pfd = dpi->pfd;
+		res = 1;
+
+	is_not_polled:
+		read_unlock_irqrestore(&ep->lock, flags);
+
+		if (res)
+			copy_to_user((void *) arg, &pfd, sizeof(struct pollfd));
+
+		DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ioctl(%p, EP_ISPOLLED, %d) == %d\n",
+					 current, ep, pfd.fd, res));
+		return res;
+	}
+
+	return -EINVAL;
+}
+
+
+static void eventpoll_mm_open(struct vm_area_struct * vma)
+{
+	struct file *file = vma->vm_file;
+	struct eventpoll *ep = file->private_data;
+
+	if (ep) atomic_inc(&ep->mmapped);
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: mm_open(%p)\n", current, ep));
+}
+
+
+static void eventpoll_mm_close(struct vm_area_struct * vma)
+{
+	struct file *file = vma->vm_file;
+	struct eventpoll *ep = file->private_data;
+
+	if (ep && atomic_dec_and_test(&ep->mmapped))
+		ep->vmabase = 0;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: mm_close(%p)\n", current, ep));
+}
+
+
+static int mmap_eventpoll(struct file *file, struct vm_area_struct *vma)
+{
+	struct eventpoll *ep = file->private_data;
+	unsigned long start;
+	int ii, res, numpages;
+	size_t mapsize;
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: mmap(%p, %lx, %lx)\n",
+				 current, ep, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT));
+
+	if (vma->vm_flags & VM_WRITE)
+		return -EACCES;
+	if ((vma->vm_pgoff << PAGE_SHIFT) != 0)
+		return -EINVAL;
+
+	mapsize = PAGE_ALIGN(vma->vm_end - vma->vm_start);
+	numpages = mapsize >> PAGE_SHIFT;
+
+	res = -EINVAL;
+	if (numpages != (2 * ep->numpages))
+		goto eexit_1;
+
+	start = vma->vm_start;
+	for (ii = 0; ii < ep->numpages; ii++) {
+		if ((res = remap_page_range(vma, start, __pa(ep->pages0[ii]),
+									PAGE_SIZE, vma->vm_page_prot)))
+    		goto eexit_1;
+		start += PAGE_SIZE;
+	}
+	for (ii = 0; ii < ep->numpages; ii++) {
+		if ((res = remap_page_range(vma, start, __pa(ep->pages1[ii]),
+									PAGE_SIZE, vma->vm_page_prot)))
+    		goto eexit_1;
+		start += PAGE_SIZE;
+	}
+	vma->vm_ops = &eventpoll_mmap_ops;
+	ep->vmabase = vma->vm_start;
+	atomic_set(&ep->mmapped, 1);
+	res = 0;
+eexit_1:
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: mmap(%p, %lx, %lx) == %d\n",
+				 current, ep, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT, res));
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
+static struct inode *get_eventpoll_inode(void)
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
+	 * list because "mark_inode_dirty()" will think
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
+											  int flags, char *dev_name, void *data)
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
+	error = -ENOMEM;
+	dpi_cache = kmem_cache_create("eventpoll",
+								  sizeof(struct epitem),
+								  __alignof__(struct epitem),
+								  DPI_SLAB_DEBUG, NULL, NULL);
+	if (!dpi_cache)
+		goto eexit_1;
+
+	error = register_filesystem(&eventpoll_fs_type);
+	if (error)
+		goto eexit_2;
+
+	eventpoll_mnt = kern_mount(&eventpoll_fs_type);
+	error = PTR_ERR(eventpoll_mnt);
+	if (IS_ERR(eventpoll_mnt))
+		goto eexit_3;
+
+	error = misc_register(&eventpoll_miscdev);
+	if (error)
+		goto eexit_4;
+
+	printk(KERN_INFO "[%p] eventpoll: driver installed.\n", current);
+
+	return error;
+
+eexit_4:
+	mntput(eventpoll_mnt);
+eexit_3:
+	unregister_filesystem(&eventpoll_fs_type);
+eexit_2:
+	kmem_cache_destroy(dpi_cache);
+eexit_1:
+
+	return error;
+}
+
+static void __exit eventpoll_exit(void)
+{
+	unregister_filesystem(&eventpoll_fs_type);
+	mntput(eventpoll_mnt);
+	misc_deregister(&eventpoll_miscdev);
+	kmem_cache_destroy(dpi_cache);
+}
+
+module_init(eventpoll_init);
+module_exit(eventpoll_exit);
+
+MODULE_LICENSE("GPL");
+
+
diff -Nru linux-2.5.44.vanilla/fs/Makefile linux-2.5.44.epoll/fs/Makefile
--- linux-2.5.44.vanilla/fs/Makefile	Fri Oct 18 21:01:57 2002
+++ linux-2.5.44.epoll/fs/Makefile	Sat Oct 19 12:05:48 2002
@@ -6,14 +6,14 @@
 # 
 
 export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o aio.o \
-                fcntl.o read_write.o dcookies.o
+                fcntl.o read_write.o dcookies.o fcblist.o
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o aio.o
+		fs-writeback.o mpage.o direct-io.o aio.o fcblist.o
 
 ifneq ($(CONFIG_NFSD),n)
 ifneq ($(CONFIG_NFSD),)
diff -Nru linux-2.5.44.vanilla/fs/fcblist.c linux-2.5.44.epoll/fs/fcblist.c
--- linux-2.5.44.vanilla/fs/fcblist.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.epoll/fs/fcblist.c	Sun Oct 27 15:23:07 2002
@@ -0,0 +1,135 @@
+/*
+ *  linux/fs/fcblist.c ( File event callbacks handling )
+ *  Copyright (C) 2001,...,2002  Davide Libenzi
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
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/poll.h>
+#include <asm/bitops.h>
+#include <linux/fcblist.h>
+
+
+long ion_band_table[NSIGPOLL] = {
+	ION_IN,		/* POLL_IN */
+	ION_OUT,	/* POLL_OUT */
+	ION_IN,		/* POLL_MSG */
+	ION_ERR,	/* POLL_ERR */
+	0,			/* POLL_PRI */
+	ION_HUP		/* POLL_HUP */
+};
+EXPORT_SYMBOL(ion_band_table);
+
+long poll_band_table[NSIGPOLL] = {
+	POLLIN | POLLRDNORM,			/* POLL_IN */
+	POLLOUT | POLLWRNORM | POLLWRBAND,	/* POLL_OUT */
+	POLLIN | POLLRDNORM | POLLMSG,		/* POLL_MSG */
+	POLLERR,				/* POLL_ERR */
+	POLLPRI | POLLRDBAND,			/* POLL_PRI */
+	POLLHUP | POLLERR			/* POLL_HUP */
+};
+EXPORT_SYMBOL(poll_band_table);
+
+
+void file_notify_event(struct file *filep, long *event)
+{
+	unsigned long flags;
+	struct list_head *lnk, *lsthead;
+
+	fcblist_read_lock(filep, flags);
+
+	lsthead = &filep->f_cblist;
+	list_for_each(lnk, lsthead) {
+		struct fcb_struct *fcbp = list_entry(lnk, struct fcb_struct, llink);
+
+		fcbp->cbproc(filep, fcbp->data, fcbp->local, event);
+	}
+
+	fcblist_read_unlock(filep, flags);
+}
+EXPORT_SYMBOL(file_notify_event);
+
+
+int file_notify_addcb(struct file *filep,
+					  void (*cbproc)(struct file *, void *, unsigned long *, long *), void *data)
+{
+	unsigned long flags;
+	struct fcb_struct *fcbp;
+
+	if (!(fcbp = (struct fcb_struct *) kmalloc(sizeof(struct fcb_struct), GFP_KERNEL)))
+		return -ENOMEM;
+
+	memset(fcbp, 0, sizeof(struct fcb_struct));
+	fcbp->cbproc = cbproc;
+	fcbp->data = data;
+
+	fcblist_write_lock(filep, flags);
+	list_add_tail(&fcbp->llink, &filep->f_cblist);
+	fcblist_write_unlock(filep, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(file_notify_addcb);
+
+
+int file_notify_delcb(struct file *filep,
+					  void (*cbproc)(struct file *, void *, unsigned long *, long *))
+{
+	unsigned long flags;
+	struct list_head *lnk, *lsthead;
+
+	fcblist_write_lock(filep, flags);
+
+	lsthead = &filep->f_cblist;
+	list_for_each(lnk, lsthead) {
+		struct fcb_struct *fcbp = list_entry(lnk, struct fcb_struct, llink);
+
+		if (fcbp->cbproc == cbproc) {
+			list_del(lnk);
+			fcblist_write_unlock(filep, flags);
+			kfree(fcbp);
+			return 0;
+		}
+	}
+
+	fcblist_write_unlock(filep, flags);
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL(file_notify_delcb);
+
+
+void file_notify_cleanup(struct file *filep)
+{
+	unsigned long flags;
+	struct list_head *lnk, *lsthead;
+
+	fcblist_write_lock(filep, flags);
+
+	lsthead = &filep->f_cblist;
+	while ((lnk = list_first(lsthead))) {
+		struct fcb_struct *fcbp = list_entry(lnk, struct fcb_struct, llink);
+
+		list_del(lnk);
+		fcblist_write_unlock(filep, flags);
+		kfree(fcbp);
+		fcblist_write_lock(filep, flags);
+	}
+
+	fcblist_write_unlock(filep, flags);
+}
+EXPORT_SYMBOL(file_notify_cleanup);
+
diff -Nru linux-2.5.44.vanilla/fs/file_table.c linux-2.5.44.epoll/fs/file_table.c
--- linux-2.5.44.vanilla/fs/file_table.c	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44.epoll/fs/file_table.c	Sat Oct 19 12:01:33 2002
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/file.h>
+#include <linux/fcblist.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
@@ -58,6 +59,7 @@
 		f->f_gid = current->fsgid;
 		f->f_owner.lock = RW_LOCK_UNLOCKED;
 		list_add(&f->f_list, &anon_list);
+		file_notify_init(f);
 		file_list_unlock();
 		return f;
 	}
@@ -102,6 +104,7 @@
 	filp->f_uid    = current->fsuid;
 	filp->f_gid    = current->fsgid;
 	filp->f_op     = dentry->d_inode->i_fop;
+	file_notify_init(filp);
 	if (filp->f_op->open)
 		return filp->f_op->open(dentry->d_inode, filp);
 	else
@@ -123,6 +126,7 @@
 	struct vfsmount * mnt = file->f_vfsmnt;
 	struct inode * inode = dentry->d_inode;
 
+	file_notify_cleanup(file);
 	locks_remove_flock(file);
 
 	if (file->f_op && file->f_op->release)
diff -Nru linux-2.5.44.vanilla/fs/pipe.c linux-2.5.44.epoll/fs/pipe.c
--- linux-2.5.44.vanilla/fs/pipe.c	Fri Oct 18 21:01:56 2002
+++ linux-2.5.44.epoll/fs/pipe.c	Sat Oct 19 12:32:34 2002
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/fcblist.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -47,7 +48,7 @@
 pipe_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	int do_wakeup;
+	int do_wakeup, pfull;
 	ssize_t ret;
 
 	/* pread is not allowed on pipes. */
@@ -63,6 +64,7 @@
 	down(PIPE_SEM(*inode));
 	for (;;) {
 		int size = PIPE_LEN(*inode);
+		pfull = PIPE_FULL(*inode);
 		if (size) {
 			char *pipebuf = PIPE_BASE(*inode) + PIPE_START(*inode);
 			ssize_t chars = PIPE_MAX_RCHUNK(*inode);
@@ -108,12 +110,18 @@
 			if (!ret) ret = -ERESTARTSYS;
 			break;
 		}
+		/* Send notification message */
+		if (pfull && !PIPE_FULL(*inode) && PIPE_WRITEFILE(*inode))
+			file_send_notify(PIPE_WRITEFILE(*inode), ION_OUT, POLLOUT | POLLWRNORM | POLLWRBAND);
 		if (do_wakeup) {
 			wake_up_interruptible(PIPE_WAIT(*inode));
  			kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 		}
 		pipe_wait(inode);
 	}
+	/* Send notification message */
+	if (pfull && !PIPE_FULL(*inode) && PIPE_WRITEFILE(*inode))
+		file_send_notify(PIPE_WRITEFILE(*inode), ION_OUT, POLLOUT | POLLWRNORM | POLLWRBAND);
 	up(PIPE_SEM(*inode));
 	/* Signal writers asynchronously that there is more room.  */
 	if (do_wakeup) {
@@ -131,7 +139,7 @@
 	struct inode *inode = filp->f_dentry->d_inode;
 	ssize_t ret;
 	size_t min;
-	int do_wakeup;
+	int do_wakeup, pempty;
 
 	/* pwrite is not allowed on pipes. */
 	if (unlikely(ppos != &filp->f_pos))
@@ -149,6 +157,7 @@
 	down(PIPE_SEM(*inode));
 	for (;;) {
 		int free;
+		pempty = PIPE_EMPTY(*inode);
 		if (!PIPE_READERS(*inode)) {
 			send_sig(SIGPIPE, current, 0);
 			if (!ret) ret = -EPIPE;
@@ -194,6 +203,9 @@
 			if (!ret) ret = -ERESTARTSYS;
 			break;
 		}
+		/* Send notification message */
+		if (pempty && !PIPE_EMPTY(*inode) && PIPE_READFILE(*inode))
+			file_send_notify(PIPE_READFILE(*inode), ION_IN, POLLIN | POLLRDNORM);
 		if (do_wakeup) {
 			wake_up_interruptible_sync(PIPE_WAIT(*inode));
 			kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
@@ -203,6 +215,9 @@
 		pipe_wait(inode);
 		PIPE_WAITING_WRITERS(*inode)--;
 	}
+	/* Send notification message */
+	if (pempty && !PIPE_EMPTY(*inode) && PIPE_READFILE(*inode))
+		file_send_notify(PIPE_READFILE(*inode), ION_IN, POLLIN | POLLRDNORM);
 	up(PIPE_SEM(*inode));
 	if (do_wakeup) {
 		wake_up_interruptible(PIPE_WAIT(*inode));
@@ -266,9 +281,22 @@
 static int
 pipe_release(struct inode *inode, int decr, int decw)
 {
+	struct file *rdfile, *wrfile;
 	down(PIPE_SEM(*inode));
 	PIPE_READERS(*inode) -= decr;
 	PIPE_WRITERS(*inode) -= decw;
+	rdfile = PIPE_READFILE(*inode);
+	wrfile = PIPE_WRITEFILE(*inode);
+ 	if (decr && !PIPE_READERS(*inode)) {
+		PIPE_READFILE(*inode) = NULL;
+		if (wrfile)
+			file_send_notify(wrfile, ION_HUP, POLLHUP);
+	}
+	if (decw && !PIPE_WRITERS(*inode)) {
+		PIPE_WRITEFILE(*inode) = NULL;
+		if (rdfile)
+			file_send_notify(rdfile, ION_HUP, POLLHUP);
+	}
 	if (!PIPE_READERS(*inode) && !PIPE_WRITERS(*inode)) {
 		struct pipe_inode_info *info = inode->i_pipe;
 		inode->i_pipe = NULL;
@@ -488,6 +516,7 @@
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
 	PIPE_WAITING_WRITERS(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
+	PIPE_READFILE(*inode) = PIPE_WRITEFILE(*inode) = NULL;
 	*PIPE_FASYNC_READERS(*inode) = *PIPE_FASYNC_WRITERS(*inode) = NULL;
 
 	return inode;
@@ -595,6 +624,9 @@
 	f2->f_op = &write_pipe_fops;
 	f2->f_mode = 2;
 	f2->f_version = 0;
+
+	PIPE_READFILE(*inode) = f1;
+	PIPE_WRITEFILE(*inode) = f2;
 
 	fd_install(i, f1);
 	fd_install(j, f2);
diff -Nru linux-2.5.44.vanilla/include/asm-i386/poll.h linux-2.5.44.epoll/include/asm-i386/poll.h
--- linux-2.5.44.vanilla/include/asm-i386/poll.h	Fri Oct 18 21:01:52 2002
+++ linux-2.5.44.epoll/include/asm-i386/poll.h	Sat Oct 19 12:01:33 2002
@@ -15,6 +15,7 @@
 #define POLLWRNORM	0x0100
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
+#define POLLREMOVE	0x1000
 
 struct pollfd {
 	int fd;
diff -Nru linux-2.5.44.vanilla/include/asm-i386/unistd.h linux-2.5.44.epoll/include/asm-i386/unistd.h
--- linux-2.5.44.vanilla/include/asm-i386/unistd.h	Fri Oct 18 21:02:00 2002
+++ linux-2.5.44.epoll/include/asm-i386/unistd.h	Sat Oct 19 20:23:33 2002
@@ -258,6 +258,9 @@
 #define __NR_free_hugepages	251
 #define __NR_exit_group		252
 #define __NR_lookup_dcookie	253
+#define __NR_sys_epoll_create	254
+#define __NR_sys_epoll_ctl	255
+#define __NR_sys_epoll_wait	256
   
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
diff -Nru linux-2.5.44.vanilla/include/linux/eventpoll.h linux-2.5.44.epoll/include/linux/eventpoll.h
--- linux-2.5.44.vanilla/include/linux/eventpoll.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.epoll/include/linux/eventpoll.h	Sun Oct 27 15:23:37 2002
@@ -0,0 +1,51 @@
+/*
+ *  include/linux/eventpoll.h ( Efficent event polling implementation )
+ *  Copyright (C) 2001,...,2002  Davide Libenzi
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
+#ifndef _LINUX_EVENTPOLL_H
+#define _LINUX_EVENTPOLL_H
+
+
+#define EVENTPOLL_MINOR	124
+#define POLLFD_X_PAGE (PAGE_SIZE / sizeof(struct pollfd))
+#define MAX_FDS_IN_EVENTPOLL (1024 * 128)
+#define MAX_EVENTPOLL_PAGES (MAX_FDS_IN_EVENTPOLL / POLLFD_X_PAGE)
+#define EVENT_PAGE_INDEX(n) ((n) / POLLFD_X_PAGE)
+#define EVENT_PAGE_REM(n) ((n) % POLLFD_X_PAGE)
+#define EVENT_PAGE_OFFSET(n) (((n) % POLLFD_X_PAGE) * sizeof(struct pollfd))
+#define EP_FDS_PAGES(n) (((n) + POLLFD_X_PAGE - 1) / POLLFD_X_PAGE)
+#define EP_MAP_SIZE(n) (EP_FDS_PAGES(n) * PAGE_SIZE * 2)
+
+
+struct evpoll {
+	int ep_timeout;
+	unsigned long ep_resoff;
+};
+
+#define EP_ALLOC _IOR('P', 1, int)
+#define EP_POLL _IOWR('P', 2, struct evpoll)
+#define EP_FREE _IO('P', 3)
+#define EP_ISPOLLED _IOWR('P', 4, struct pollfd)
+
+#define EP_CTL_ADD 1
+#define EP_CTL_DEL 2
+#define EP_CTL_MOD 3
+
+
+asmlinkage int sys_epoll_create(int maxfds);
+asmlinkage int sys_epoll_ctl(int epfd, int op, int fd, unsigned int events);
+asmlinkage int sys_epoll_wait(int epfd, struct pollfd const **events, int timeout);
+
+
+
+#endif
+
diff -Nru linux-2.5.44.vanilla/include/linux/fcblist.h linux-2.5.44.epoll/include/linux/fcblist.h
--- linux-2.5.44.vanilla/include/linux/fcblist.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.epoll/include/linux/fcblist.h	Sun Oct 27 15:23:21 2002
@@ -0,0 +1,73 @@
+/*
+ *  include/linux/fcblist.h ( File event callbacks handling )
+ *  Copyright (C) 2001,...,2002  Davide Libenzi
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
+#ifndef __LINUX_FCBLIST_H
+#define __LINUX_FCBLIST_H
+
+#include <linux/config.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+
+
+
+/* file callback notification events */
+#define ION_IN		1
+#define ION_OUT		2
+#define ION_HUP		3
+#define ION_ERR		4
+
+#define FCB_LOCAL_SIZE	4
+
+#define fcblist_read_lock(fp, fl)		read_lock_irqsave(&(fp)->f_cblock, fl)
+#define fcblist_read_unlock(fp, fl)		read_unlock_irqrestore(&(fp)->f_cblock, fl)
+#define fcblist_write_lock(fp, fl)		write_lock_irqsave(&(fp)->f_cblock, fl)
+#define fcblist_write_unlock(fp, fl)	write_unlock_irqrestore(&(fp)->f_cblock, fl)
+
+struct fcb_struct {
+	struct list_head llink;
+	void (*cbproc)(struct file *, void *, unsigned long *, long *);
+	void *data;
+	unsigned long local[FCB_LOCAL_SIZE];
+};
+
+
+extern long ion_band_table[];
+extern long poll_band_table[];
+
+
+void file_notify_event(struct file *filep, long *event);
+
+int file_notify_addcb(struct file *filep,
+					  void (*cbproc)(struct file *, void *, unsigned long *, long *), void *data);
+
+int file_notify_delcb(struct file *filep,
+					  void (*cbproc)(struct file *, void *, unsigned long *, long *));
+
+void file_notify_cleanup(struct file *filep);
+
+
+static inline void file_notify_init(struct file *filep)
+{
+	rwlock_init(&filep->f_cblock);
+	INIT_LIST_HEAD(&filep->f_cblist);
+}
+
+static inline void file_send_notify(struct file *filep, long ioevt, long plevt) {
+	long event[] = { ioevt, plevt, -1 };
+
+	file_notify_event(filep, event);
+}
+
+#endif
diff -Nru linux-2.5.44.vanilla/include/linux/fs.h linux-2.5.44.epoll/include/linux/fs.h
--- linux-2.5.44.vanilla/include/linux/fs.h	Fri Oct 18 21:01:18 2002
+++ linux-2.5.44.epoll/include/linux/fs.h	Sat Oct 19 12:01:33 2002
@@ -506,6 +506,10 @@
 
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
+
+	/* file callback list */
+	rwlock_t f_cblock;
+	struct list_head f_cblist;
 };
 extern spinlock_t files_lock;
 #define file_list_lock() spin_lock(&files_lock);
diff -Nru linux-2.5.44.vanilla/include/linux/list.h linux-2.5.44.epoll/include/linux/list.h
--- linux-2.5.44.vanilla/include/linux/list.h	Fri Oct 18 21:01:07 2002
+++ linux-2.5.44.epoll/include/linux/list.h	Sat Oct 19 12:01:33 2002
@@ -319,6 +319,11 @@
 	for (pos = (head)->next, n = pos->next; pos != (head); \
 		pos = n, ({ read_barrier_depends(); 0;}), n = pos->next)
 
+#define list_first(head)	(((head)->next != (head)) ? (head)->next: (struct list_head *) 0)
+#define list_last(head)	(((head)->prev != (head)) ? (head)->prev: (struct list_head *) 0)
+#define list_next(pos, head)	(((pos)->next != (head)) ? (pos)->next: (struct list_head *) 0)
+#define list_prev(pos, head)	(((pos)->prev != (head)) ? (pos)->prev: (struct list_head *) 0)
+
 #endif /* __KERNEL__ || _LVM_H_INCLUDE */
 
 #endif
diff -Nru linux-2.5.44.vanilla/include/linux/pipe_fs_i.h linux-2.5.44.epoll/include/linux/pipe_fs_i.h
--- linux-2.5.44.vanilla/include/linux/pipe_fs_i.h	Fri Oct 18 21:02:24 2002
+++ linux-2.5.44.epoll/include/linux/pipe_fs_i.h	Sat Oct 19 12:01:33 2002
@@ -12,6 +12,8 @@
 	unsigned int waiting_writers;
 	unsigned int r_counter;
 	unsigned int w_counter;
+	struct file *rdfile;
+	struct file *wrfile;
 	struct fasync_struct *fasync_readers;
 	struct fasync_struct *fasync_writers;
 };
@@ -30,6 +32,8 @@
 #define PIPE_WAITING_WRITERS(inode)	((inode).i_pipe->waiting_writers)
 #define PIPE_RCOUNTER(inode)	((inode).i_pipe->r_counter)
 #define PIPE_WCOUNTER(inode)	((inode).i_pipe->w_counter)
+#define PIPE_READFILE(inode)	((inode).i_pipe->rdfile)
+#define PIPE_WRITEFILE(inode)	((inode).i_pipe->wrfile)
 #define PIPE_FASYNC_READERS(inode)     (&((inode).i_pipe->fasync_readers))
 #define PIPE_FASYNC_WRITERS(inode)     (&((inode).i_pipe->fasync_writers))
 
diff -Nru linux-2.5.44.vanilla/include/linux/sys.h linux-2.5.44.epoll/include/linux/sys.h
--- linux-2.5.44.vanilla/include/linux/sys.h	Fri Oct 18 21:01:49 2002
+++ linux-2.5.44.epoll/include/linux/sys.h	Sun Oct 20 15:13:06 2002
@@ -4,7 +4,7 @@
 /*
  * system call entry points ... but not all are defined
  */
-#define NR_syscalls 256
+#define NR_syscalls 260
 
 /*
  * These are system calls that will be removed at some time
diff -Nru linux-2.5.44.vanilla/include/net/sock.h linux-2.5.44.epoll/include/net/sock.h
--- linux-2.5.44.vanilla/include/net/sock.h	Fri Oct 18 21:02:27 2002
+++ linux-2.5.44.epoll/include/net/sock.h	Tue Oct 22 15:57:38 2002
@@ -52,6 +52,9 @@
 #include <asm/atomic.h>
 #include <net/dst.h>
 #include <net/scm.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/fcblist.h>
 
 /*
  * This structure really needs to be cleaned up.
@@ -766,8 +769,13 @@
 
 static inline void sk_wake_async(struct sock *sk, int how, int band)
 {
-	if (sk->socket && sk->socket->fasync_list)
-		sock_wake_async(sk->socket, how, band);
+	if (sk->socket) {
+		if (sk->socket->file)
+			file_send_notify(sk->socket->file, ion_band_table[band - POLL_IN],
+					poll_band_table[band - POLL_IN]);
+		if (sk->socket->fasync_list)
+			sock_wake_async(sk->socket, how, band);
+	}
 }
 
 #define SOCK_MIN_SNDBUF 2048
diff -Nru linux-2.5.44.vanilla/net/ipv4/tcp.c linux-2.5.44.epoll/net/ipv4/tcp.c
--- linux-2.5.44.vanilla/net/ipv4/tcp.c	Fri Oct 18 21:01:19 2002
+++ linux-2.5.44.epoll/net/ipv4/tcp.c	Sat Oct 19 12:01:33 2002
@@ -476,8 +476,8 @@
 		if (sk->sleep && waitqueue_active(sk->sleep))
 			wake_up_interruptible(sk->sleep);
 
-		if (sock->fasync_list && !(sk->shutdown & SEND_SHUTDOWN))
-			sock_wake_async(sock, 2, POLL_OUT);
+		if (!(sk->shutdown & SEND_SHUTDOWN))
+			sk_wake_async(sk, 2, POLL_OUT);
 	}
 }
 





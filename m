Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbSJOXdg>; Tue, 15 Oct 2002 19:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSJOXdg>; Tue, 15 Oct 2002 19:33:36 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:54229 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264646AbSJOXdR>;
	Tue, 15 Oct 2002 19:33:17 -0400
Date: Tue, 15 Oct 2002 16:43:04 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org, davidel@xmailserver.org
Subject: [PATCH] /dev/epoll port to 2.5.42
Message-ID: <3940000.1034725384@w-hlinder>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More fuel for the fire. 

Here is a port of Davide Libenzi's /dev/epoll patch from 
2.5.33 to 2.5.42. A solution of some sort would be nice to see 
in 2.6, please consider either /dev/epoll or asynch poll again.

Here is the link to Davide's performance results with /dev/epoll
http://www.xmailserver.org/linux-patches/nio-improve.html

(Putting on my asbestos overalls)

Hanna

-----

diff -Nru -X dontdiff linux-2.5.42/Makefile linux-2.5.42-epoll/Makefile
--- linux-2.5.42/Makefile	Fri Oct 11 21:21:32 2002
+++ linux-2.5.42-epoll/Makefile	Mon Oct 14 14:53:26 2002
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 5
 SUBLEVEL = 42
-EXTRAVERSION =
+EXTRAVERSION = epoll
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
diff -Nru -X dontdiff linux-2.5.42/drivers/char/Config.help linux-2.5.42-epoll/drivers/char/Config.help
--- linux-2.5.42/drivers/char/Config.help	Fri Oct 11 21:22:04 2002
+++ linux-2.5.42-epoll/drivers/char/Config.help	Mon Oct 14 13:33:14 2002
@@ -929,6 +929,25 @@
   The module will be called nvram.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
+CONFIG_EVENTPOLL
+  This option will allow for the creation of a '/dev/epoll' character
+  device, with major number 10 (MISC_MAJOR) and minor number 124
+  (EVENTPOLL_MINOR).
+
+  This device can be used to very efficiently handle incoming events 
+  on a socket, much more so than select() or poll(). There is a paper 
+  that describes this device and how to program for it (as well as 
+  including some very impressive benchmarks) at the following URL:
+  http://www.xmailserver.org/linux-patches/nio-improve.html
+
+  If you are writing very scalable servers and wish to code against
+  /dev/epoll for enhanced speed, say 'Y' or 'M' here. If you have
+  software in hand that requires (or can make use of) /dev/epoll,
+  also say 'Y' or 'M' here.
+
+  The vast majority of the planet can very safely say 'N' here
+  and breathe easily.
+
 CONFIG_NWBUTTON
   If you say Y here and create a character device node /dev/nwbutton
   with major and minor numbers 10 and 158 ("man mknod"), then every
diff -Nru -X dontdiff linux-2.5.42/drivers/char/Config.in linux-2.5.42-epoll/drivers/char/Config.in
--- linux-2.5.42/drivers/char/Config.in	Fri Oct 11 21:21:34 2002
+++ linux-2.5.42-epoll/drivers/char/Config.in	Mon Oct 14 13:22:52 2002
@@ -154,6 +154,7 @@
    dep_tristate 'AMD 768 Random Number Generator support' CONFIG_AMD_RNG $CONFIG_PCI
 fi
 tristate '/dev/nvram support' CONFIG_NVRAM
+tristate '/dev/epoll - Efficent file event polling method' CONFIG_EVENTPOLL
 tristate 'Enhanced Real Time Clock Support' CONFIG_RTC
 if [ "$CONFIG_RTC" != "y" ]; then
    tristate 'Generic /dev/rtc emulation' CONFIG_GEN_RTC      
diff -Nru -X dontdiff linux-2.5.42/drivers/char/Makefile linux-2.5.42-epoll/drivers/char/Makefile
--- linux-2.5.42/drivers/char/Makefile	Fri Oct 11 21:22:44 2002
+++ linux-2.5.42-epoll/drivers/char/Makefile	Mon Oct 14 13:22:52 2002
@@ -63,6 +63,7 @@
 ifeq ($(CONFIG_PPC),)
   obj-$(CONFIG_NVRAM) += nvram.o
 endif
+obj-$(CONFIG_EVENTPOLL) += eventpoll.o
 obj-$(CONFIG_TOSHIBA) += toshiba.o
 obj-$(CONFIG_I8K) += i8k.o
 obj-$(CONFIG_DS1620) += ds1620.o
diff -Nru -X dontdiff linux-2.5.42/drivers/char/eventpoll.c linux-2.5.42-epoll/drivers/char/eventpoll.c
--- linux-2.5.42/drivers/char/eventpoll.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.42-epoll/drivers/char/eventpoll.c	Mon Oct 14 13:22:52 2002
@@ -0,0 +1,800 @@
+/*
+ *  drivers/char/eventpoll.c
+ *
+ *  Copyright (C) 2001, Davide Libenzi <davidel@xmailserver.org>
+ *
+ *  Efficent event polling implementation
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
+#include <asm/atomic.h>
+
+#include <linux/eventpoll.h>
+
+
+
+
+
+#define DEBUG	0
+#ifdef DEBUG
+#define DPRINTK(x)	printk x
+#define DNPRINTK(n,x)	if (n <= DEBUG) printk x
+#else
+#define DPRINTK(x)
+#define DNPRINTK(n,x)
+#endif
+
+#define DEBUG_DPI	0
+
+#if DEBUG_DPI
+#define DPI_SLAB_DEBUG	(SLAB_DEBUG_FREE | SLAB_RED_ZONE /* | SLAB_POISON */)
+#else
+#define DPI_SLAB_DEBUG	0
+#endif
+
+#define INITIAL_HASH_BITS	7
+#define MAX_HASH_BITS	18
+#define RESIZE_LENGTH	2
+
+#define dpi_mem_alloc()	(struct epitem *) kmem_cache_alloc(dpi_cache, SLAB_KERNEL)
+#define dpi_mem_free(p) kmem_cache_free(dpi_cache, p)
+
+
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
+
+
+static int ep_alloc_pages(char **pages, int numpages);
+static int ep_free_pages(char **pages, int numpages);
+static int ep_init(struct eventpoll *ep);
+static void ep_free(struct eventpoll *ep);
+static inline struct epitem *ep_find_nl(struct eventpoll *ep, int fd);
+static struct epitem *ep_find(struct eventpoll *ep, int fd);
+static int ep_hashresize(struct eventpoll *ep, unsigned long *kflags);
+static int ep_insert(struct eventpoll *ep, struct pollfd *pfd);
+static int ep_remove(struct eventpoll *ep, struct epitem *dpi);
+static void notify_proc(struct file *file, void *data, unsigned long *local, long *event);
+static int open_eventpoll(struct inode *inode, struct file *file);
+static int close_eventpoll(struct inode *inode, struct file *file);
+static unsigned int poll_eventpoll(struct file *file, poll_table *wait);
+static int write_eventpoll(struct file *file, const char *buffer, size_t count,
+		loff_t *ppos);
+static int ep_poll(struct eventpoll *ep, void *arg);
+static int ioctl_eventpoll(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg);
+static void eventpoll_mm_open(struct vm_area_struct * vma);
+static void eventpoll_mm_close(struct vm_area_struct * vma);
+static int mmap_eventpoll(struct file *file, struct vm_area_struct *vma);
+
+
+
+
+static kmem_cache_t *dpi_cache;
+
+static struct file_operations eventpoll_fops = {
+	write: write_eventpoll,
+	ioctl: ioctl_eventpoll,
+	mmap: mmap_eventpoll,
+	open: open_eventpoll,
+	release: close_eventpoll,
+	poll: poll_eventpoll
+};
+
+static struct vm_operations_struct eventpoll_mmap_ops = {
+	open: eventpoll_mm_open,
+	close: eventpoll_mm_close,
+};
+
+static struct miscdevice eventpoll = {
+	EVENTPOLL_MINOR, "eventpoll", &eventpoll_fops
+};
+
+
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
+				clear_bit(PG_reserved, &virt_to_page(pages[ii])->flags);
+				free_pages((unsigned long) pages[ii], 0);
+			}
+			return -ENOMEM;
+		}
+		set_bit(PG_reserved, &virt_to_page(pages[ii])->flags);
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
+		clear_bit(PG_reserved, &virt_to_page(pages[ii])->flags);
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
+	lock_kernel();
+	for (ii = 0; ii <= ep->hmask; ii++) {
+		while ((lnk = list_first(&ep->hash[ii]))) {
+			struct epitem *dpi = list_entry(lnk, struct epitem, llink);
+
+			file_notify_delcb(dpi->file, notify_proc);
+			list_del(lnk);
+			dpi_mem_free(dpi);
+		}
+	}
+	vfree(ep->hash);
+	if (ep->numpages > 0) {
+		ep_free_pages(ep->pages0, ep->numpages);
+		ep_free_pages(ep->pages1, ep->numpages);
+	}
+	unlock_kernel();
+}
+
+
+static inline struct epitem *ep_find_nl(struct eventpoll *ep, int fd)
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
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: ep_find(%d) -> %p\n", current, fd, dpi));
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
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: ep_hashresize(%p) bits=%u\n", current, ep, hbits));
+
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	res = -ENOMEM;
+	if (!(hash = (struct list_head *) vmalloc(hentries * sizeof(struct list_head)))) {
+		write_lock_irqsave(&ep->lock, flags);
+		goto out;
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
+out:
+	*kflags = flags;
+	atomic_dec(&ep->resize);
+	return res;
+}
+
+
+static int ep_insert(struct eventpoll *ep, struct pollfd *pfd)
+{
+	struct epitem *dpi;
+	struct file *file;
+	unsigned long flags;
+
+	if (atomic_read(&ep->hents) >= (ep->numpages * POLLFD_X_PAGE))
+		return -E2BIG;
+
+	if (!(file = fcheck(pfd->fd)))
+		return -EINVAL;
+
+	if (!(dpi = dpi_mem_alloc()))
+		return -ENOMEM;
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
+			(atomic_read(&ep->hents) >> ep->hbits) > RESIZE_LENGTH &&
+			ep->hbits < MAX_HASH_BITS) {
+		atomic_inc(&ep->resize);
+		ep_hashresize(ep, &flags);
+	}
+
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	file_notify_addcb(file, notify_proc, dpi);
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: ep_insert(%p, %d)\n", current, ep, pfd->fd));
+
+	return 0;
+}
+
+
+static int ep_remove(struct eventpoll *ep, struct epitem *dpi)
+{
+	int fd = dpi->pfd.fd;
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
+	dpi_mem_free(dpi);
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: ep_remove(%p, %d)\n", current, ep, fd));
+
+	return 0;
+}
+
+
+static void notify_proc(struct file *file, void *data, unsigned long *local, long *event)
+{
+	struct epitem *dpi = (struct epitem *) data;
+	struct eventpoll *ep = dpi->ep;
+	struct pollfd *pfd;
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: notify(%p, %p, %ld, %ld) ep=%p\n",
+			current, file, data, event[0], event[1], ep));
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
+				EVENT_PAGE_OFFSET(dpi->index));
+		*pfd = dpi->pfd;
+	} else {
+		pfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(dpi->index)] +
+				EVENT_PAGE_OFFSET(dpi->index));
+		if (pfd->fd != dpi->pfd.fd) {
+			if (ep->eventcnt >= (ep->numpages * POLLFD_X_PAGE))
+				goto out;
+			dpi->index = ep->eventcnt++;
+			pfd = (struct pollfd *) (ep->pages[EVENT_PAGE_INDEX(dpi->index)] +
+					EVENT_PAGE_OFFSET(dpi->index));
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
+	MOD_INC_USE_COUNT;
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: open() ep=%p\n", current, ep));
+	return 0;
+}
+
+
+static int close_eventpoll(struct inode *inode, struct file *file)
+{
+	struct eventpoll *ep = file->private_data;
+
+	ep_free(ep);
+
+	kfree(ep);
+
+	MOD_DEC_USE_COUNT;
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: close() ep=%p\n", current, ep));
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
+		loff_t *ppos)
+{
+	int res, rcount;
+	struct eventpoll *ep = file->private_data;
+	struct epitem *dpi;
+	struct pollfd pfd;
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: write(%p, %d)\n", current, ep, count));
+
+	if (count % sizeof(struct pollfd))
+		return -EINVAL;
+
+	if ((res = verify_area(VERIFY_READ, buffer, count)))
+		return res;
+
+	rcount = 0;
+
+	lock_kernel();
+
+	while (count > 0) {
+		__copy_from_user(&pfd, buffer, sizeof(pfd));
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
+	unlock_kernel();
+
+	return rcount;
+}
+
+
+static int ep_poll(struct eventpoll *ep, void *arg)
+{
+	int res = 0;
+	long timeout;
+	unsigned long flags;
+	struct evpoll dvp;
+	wait_queue_t wait;
+
+	if (copy_from_user(&dvp, arg, sizeof(struct evpoll)))
+		return -EFAULT;
+
+	if (!atomic_read(&ep->mmapped))
+		return -EINVAL;
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: ioctl(%p, EP_POLL, %d)\n", current, ep, dvp.ep_timeout));
+
+	write_lock_irqsave(&ep->lock, flags);
+
+	res = 0;
+	if (!ep->eventcnt) {
+		init_waitqueue_entry(&wait, current);
+		add_wait_queue(&ep->wq, &wait);
+		timeout = dvp.ep_timeout == -1 || dvp.ep_timeout > MAX_SCHEDULE_TIMEOUT/HZ ?
+			MAX_SCHEDULE_TIMEOUT: (dvp.ep_timeout * HZ) / 1000; 
+		for (;;) {
+			if (ep->eventcnt || !timeout)
+				break;
+			if (signal_pending(current)) {
+				res = -EINTR;
+				break;
+			}
+
+			set_current_state(TASK_INTERRUPTIBLE);
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
+			dvp.ep_resoff = 0;
+		} else {
+			ep->pages = ep->pages0;
+			dvp.ep_resoff = ep->numpages * PAGE_SIZE;
+		}
+	}
+
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	if (res > 0)
+		copy_to_user(arg, &dvp, sizeof(struct evpoll));
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: ioctl(%p, EP_POLL, %d) == %d\n", current, ep, dvp.ep_timeout, res));
+	return res;
+}
+
+
+static int ioctl_eventpoll(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	int res, numpages;
+	struct eventpoll *ep = file->private_data;
+	struct epitem *dpi;
+	unsigned long flags;
+	struct pollfd pfd;
+
+	switch (cmd) {
+	case EP_ALLOC:
+		if (atomic_read(&ep->mmapped))
+			return -EBUSY;
+
+		numpages = EP_FDS_PAGES(arg);
+		if (numpages > MAX_EVENTPOLL_PAGES)
+			return -EINVAL;
+
+		res = 0;
+		write_lock_irqsave(&ep->lock, flags);
+		if (numpages > ep->numpages) {
+			if (!(res = ep_alloc_pages(&ep->pages0[ep->numpages], numpages - ep->numpages))) {
+				if (!(res = ep_alloc_pages(&ep->pages1[ep->numpages], numpages - ep->numpages))) {
+					ep->numpages = numpages;
+				} else {
+					ep_free_pages(&ep->pages0[ep->numpages], numpages - ep->numpages);
+				}
+			}
+		}
+		write_unlock_irqrestore(&ep->lock, flags);
+
+		DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: ioctl(%p, EP_ALLOC, %lu) == %d\n",
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
+		DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: ioctl(%p, EP_FREE) == %d\n",
+					 current, ep, res));
+		return res;
+
+	case EP_POLL:
+		return ep_poll(ep, (void *) arg);
+
+	case EP_ISPOLLED:
+		if (copy_from_user(&pfd, (void *) arg, sizeof(struct pollfd)))
+			return 0;
+
+		read_lock_irqsave(&ep->lock, flags);
+
+		res = 0;
+		if (!(dpi = ep_find_nl(ep, pfd.fd)))
+			goto out_ispolled;
+
+		pfd = dpi->pfd;
+		res = 1;
+
+	out_ispolled:
+		read_unlock_irqrestore(&ep->lock, flags);
+
+		if (res)
+			copy_to_user((void *) arg, &pfd, sizeof(struct pollfd));
+
+		DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: ioctl(%p, EP_ISPOLLED, %d) == %d\n",
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
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: mm_open(%p)\n", current, ep));
+}
+
+
+static void eventpoll_mm_close(struct vm_area_struct * vma)
+{
+	struct file *file = vma->vm_file;
+	struct eventpoll *ep = file->private_data;
+
+	if (ep) atomic_dec(&ep->mmapped);
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: mm_close(%p)\n", current, ep));
+}
+
+
+static int mmap_eventpoll(struct file *file, struct vm_area_struct *vma)
+{
+	struct eventpoll *ep = file->private_data;
+	unsigned long start, flags;
+	int ii, res;
+	int numpages;
+	size_t mapsize;
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: mmap(%p, %lx, %lx)\n",
+			current, ep, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT));
+
+	if ((vma->vm_pgoff << PAGE_SHIFT) != 0)
+		return -EINVAL;
+
+	mapsize = PAGE_ALIGN(vma->vm_end - vma->vm_start);
+	numpages = mapsize >> PAGE_SHIFT;
+
+	write_lock_irqsave(&ep->lock, flags);
+
+	res = -EINVAL;
+	if (numpages != (2 * ep->numpages))
+		goto out;
+
+	start = vma->vm_start;
+	for (ii = 0; ii < ep->numpages; ii++) {
+		if (remap_page_range(vma, start, __pa(ep->pages0[ii]),
+				PAGE_SIZE, vma->vm_page_prot))
+    		goto out;
+		start += PAGE_SIZE;
+	}
+	for (ii = 0; ii < ep->numpages; ii++) {
+		if (remap_page_range(vma, start, __pa(ep->pages1[ii]),
+				PAGE_SIZE, vma->vm_page_prot))
+    		goto out;
+		start += PAGE_SIZE;
+	}
+	vma->vm_ops = &eventpoll_mmap_ops;
+	atomic_set(&ep->mmapped, 1);
+	res = 0;
+out:
+	write_unlock_irqrestore(&ep->lock, flags);
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/epoll: mmap(%p, %lx, %lx) == %d\n",
+		 	current, ep, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT, res));
+	return res;
+}
+
+
+int __init eventpoll_init(void)
+{
+	dpi_cache = kmem_cache_create("eventpoll",
+			sizeof(struct epitem),
+			__alignof__(struct epitem),
+			DPI_SLAB_DEBUG, NULL, NULL);
+	if (!dpi_cache) {
+		printk(KERN_INFO "[%p] /dev/epoll: driver install failed.\n", current);
+		return -ENOMEM;
+	}
+
+	printk(KERN_INFO "[%p] /dev/epoll: driver installed.\n", current);
+
+	misc_register(&eventpoll);
+
+	return 0;
+}
+
+
+module_init(eventpoll_init);
+
+#ifdef MODULE
+
+void cleanup_module(void)
+{
+	misc_deregister(&eventpoll);
+	kmem_cache_destroy(dpi_cache);
+}
+
+#endif
+
+MODULE_LICENSE("GPL");
+
diff -Nru -X dontdiff linux-2.5.42/fs/Makefile linux-2.5.42-epoll/fs/Makefile
--- linux-2.5.42/fs/Makefile	Fri Oct 11 21:22:09 2002
+++ linux-2.5.42-epoll/fs/Makefile	Mon Oct 14 13:37:08 2002
@@ -6,14 +6,14 @@
 # 
 
 export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o aio.o \
-                fcntl.o read_write.o
+                fcntl.o read_write.o fcblist.o
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o aio.o
+		fs-writeback.o mpage.o direct-io.o aio.o fcblist.o
 
 ifneq ($(CONFIG_NFSD),n)
 ifneq ($(CONFIG_NFSD),)
diff -Nru -X dontdiff linux-2.5.42/fs/fcblist.c linux-2.5.42-epoll/fs/fcblist.c
--- linux-2.5.42/fs/fcblist.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.42-epoll/fs/fcblist.c	Mon Oct 14 13:22:53 2002
@@ -0,0 +1,130 @@
+/*
+ *  linux/fs/fcblist.c
+ *
+ *  Copyright (C) 2001, Davide Libenzi <davidel@xmailserver.org>
+ *
+ *  Handle file callbacks
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
+		void (*cbproc)(struct file *, void *, unsigned long *, long *), void *data)
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
+		void (*cbproc)(struct file *, void *, unsigned long *, long *))
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
diff -Nru -X dontdiff linux-2.5.42/fs/file_table.c linux-2.5.42-epoll/fs/file_table.c
--- linux-2.5.42/fs/file_table.c	Fri Oct 11 21:21:05 2002
+++ linux-2.5.42-epoll/fs/file_table.c	Mon Oct 14 13:22:53 2002
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/file.h>
+#include <linux/fcblist.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
@@ -59,6 +60,7 @@
 		f->f_gid = current->fsgid;
 		f->f_owner.lock = RW_LOCK_UNLOCKED;
 		list_add(&f->f_list, &anon_list);
+		file_notify_init(f);
 		file_list_unlock();
 		return f;
 	}
@@ -103,6 +105,7 @@
 	filp->f_uid    = current->fsuid;
 	filp->f_gid    = current->fsgid;
 	filp->f_op     = dentry->d_inode->i_fop;
+	file_notify_init(filp);
 	if (filp->f_op->open)
 		return filp->f_op->open(dentry->d_inode, filp);
 	else
@@ -124,6 +127,7 @@
 	struct vfsmount * mnt = file->f_vfsmnt;
 	struct inode * inode = dentry->d_inode;
 
+	file_notify_cleanup(file);
 	locks_remove_flock(file);
 
 	if (file->f_op && file->f_op->release)
diff -Nru -X dontdiff linux-2.5.42/fs/pipe.c linux-2.5.42-epoll/fs/pipe.c
--- linux-2.5.42/fs/pipe.c	Fri Oct 11 21:22:08 2002
+++ linux-2.5.42-epoll/fs/pipe.c	Mon Oct 14 14:50:18 2002
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
@@ -81,11 +82,13 @@
 			PIPE_START(*inode) += chars;
 			PIPE_START(*inode) &= (PIPE_SIZE - 1);
 			PIPE_LEN(*inode) -= chars;
+			pfull = PIPE_FULL(*inode);
 			count -= chars;
 			buf += chars;
 			do_wakeup = 1;
-		}
-		if (!count)
+		} else
+			pfull = PIPE_FULL(*inode);
+		if (!count) 
 			break;	/* common path: read succeeded */
 		if (PIPE_LEN(*inode)) /* test for cyclic buffers */
 			continue;
@@ -113,6 +116,10 @@
  			kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 		}
 		pipe_wait(inode);
+		/* Send notification message */
+		if (pfull && !PIPE_FULL(*inode) && PIPE_WRITEFILE(*inode))
+			file_send_notify(PIPE_WRITEFILE(*inode), ION_OUT, 
+					 POLLOUT | POLLWRNORM | POLLWRBAND);
 	}
 	up(PIPE_SEM(*inode));
 	/* Signal writers asynchronously that there is more room.  */
@@ -131,7 +138,7 @@
 	struct inode *inode = filp->f_dentry->d_inode;
 	ssize_t ret;
 	size_t min;
-	int do_wakeup;
+	int do_wakeup, pempty;
 
 	/* pwrite is not allowed on pipes. */
 	if (unlikely(ppos != &filp->f_pos))
@@ -176,6 +183,7 @@
 
 			ret += chars;
 			PIPE_LEN(*inode) += chars;
+			pempty = PIPE_EMPTY(*inode);
 			count -= chars;
 			buf += chars;
 		}
@@ -195,6 +203,10 @@
 			break;
 		}
 		if (do_wakeup) {
+			/* Send notification message */
+			if (pempty && !PIPE_EMPTY(*inode) && PIPE_READFILE(*inode))
+				file_send_notify(PIPE_READFILE(*inode), ION_IN, 
+						 POLLIN | POLLRDNORM);
 			wake_up_interruptible_sync(PIPE_WAIT(*inode));
 			kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
 			do_wakeup = 0;
@@ -202,9 +214,14 @@
 		PIPE_WAITING_WRITERS(*inode)++;
 		pipe_wait(inode);
 		PIPE_WAITING_WRITERS(*inode)--;
+		pempty = PIPE_EMPTY(*inode);
 	}
 	up(PIPE_SEM(*inode));
 	if (do_wakeup) {
+		/* Send notification message */
+		if (pempty && !PIPE_EMPTY(*inode) && PIPE_READFILE(*inode))
+			file_send_notify(PIPE_READFILE(*inode), ION_IN, 
+					 POLLIN | POLLRDNORM);
 		wake_up_interruptible(PIPE_WAIT(*inode));
 		kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
 	}
@@ -266,9 +283,22 @@
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
@@ -488,6 +518,7 @@
 	PIPE_READERS(*inode) = PIPE_WRITERS(*inode) = 0;
 	PIPE_WAITING_WRITERS(*inode) = 0;
 	PIPE_RCOUNTER(*inode) = PIPE_WCOUNTER(*inode) = 1;
+	PIPE_READFILE(*inode) = PIPE_WRITEFILE(*inode) = NULL;
 	*PIPE_FASYNC_READERS(*inode) = *PIPE_FASYNC_WRITERS(*inode) = NULL;
 
 	return inode;
@@ -595,6 +626,9 @@
 	f2->f_op = &write_pipe_fops;
 	f2->f_mode = 2;
 	f2->f_version = 0;
+
+	PIPE_READFILE(*inode) = f1;
+	PIPE_WRITEFILE(*inode) = f2;
 
 	fd_install(i, f1);
 	fd_install(j, f2);
diff -Nru -X dontdiff linux-2.5.42/include/asm-i386/poll.h linux-2.5.42-epoll/include/asm-i386/poll.h
--- linux-2.5.42/include/asm-i386/poll.h	Fri Oct 11 21:22:05 2002
+++ linux-2.5.42-epoll/include/asm-i386/poll.h	Mon Oct 14 13:22:53 2002
@@ -15,6 +15,7 @@
 #define POLLWRNORM	0x0100
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
+#define POLLREMOVE	0x1000
 
 struct pollfd {
 	int fd;
diff -Nru -X dontdiff linux-2.5.42/include/linux/eventpoll.h linux-2.5.42-epoll/include/linux/eventpoll.h
--- linux-2.5.42/include/linux/eventpoll.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.42-epoll/include/linux/eventpoll.h	Mon Oct 14 13:22:54 2002
@@ -0,0 +1,43 @@
+/*
+ *  include/linux/eventpoll.h
+ *
+ *  Copyright (C) 2001, Davide Libenzi <davidel@xmailserver.org>
+ *
+ *  Efficent event polling implementation
+ */
+
+
+#ifndef _LINUX_EVENTPOLL_H
+#define _LINUX_EVENTPOLL_H
+
+
+
+
+#define EVENTPOLL_MINOR	124
+#define POLLFD_X_PAGE	(PAGE_SIZE / sizeof(struct pollfd))
+#define MAX_FDS_IN_EVENTPOLL	(1024 * 128)
+#define MAX_EVENTPOLL_PAGES	(MAX_FDS_IN_EVENTPOLL / POLLFD_X_PAGE)
+#define EVENT_PAGE_INDEX(n)	((n) / POLLFD_X_PAGE)
+#define EVENT_PAGE_REM(n)	((n) % POLLFD_X_PAGE)
+#define EVENT_PAGE_OFFSET(n)	(((n) % POLLFD_X_PAGE) * sizeof(struct pollfd))
+#define EP_FDS_PAGES(n)	(((n) + POLLFD_X_PAGE - 1) / POLLFD_X_PAGE)
+#define EP_MAP_SIZE(n)	(EP_FDS_PAGES(n) * PAGE_SIZE * 2)
+
+
+
+
+
+struct evpoll {
+	int ep_timeout;
+	unsigned long ep_resoff;
+};
+
+#define EP_ALLOC	_IOR('P', 1, int)
+#define EP_POLL		_IOWR('P', 2, struct evpoll)
+#define EP_FREE		_IO('P', 3)
+#define EP_ISPOLLED	_IOWR('P', 4, struct pollfd)
+
+
+
+#endif
+
diff -Nru -X dontdiff linux-2.5.42/include/linux/fcblist.h linux-2.5.42-epoll/include/linux/fcblist.h
--- linux-2.5.42/include/linux/fcblist.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.42-epoll/include/linux/fcblist.h	Mon Oct 14 13:22:54 2002
@@ -0,0 +1,68 @@
+/*
+ *  include/linux/fcblist.h
+ *
+ *  Copyright (C) 2001, Davide Libenzi <davidel@xmailserver.org>
+ *
+ *  Handle file callbacks
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
+		void (*cbproc)(struct file *, void *, unsigned long *, long *), void *data);
+
+int file_notify_delcb(struct file *filep,
+		void (*cbproc)(struct file *, void *, unsigned long *, long *));
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
diff -Nru -X dontdiff linux-2.5.42/include/linux/fs.h linux-2.5.42-epoll/include/linux/fs.h
--- linux-2.5.42/include/linux/fs.h	Fri Oct 11 21:21:35 2002
+++ linux-2.5.42-epoll/include/linux/fs.h	Mon Oct 14 13:22:54 2002
@@ -505,6 +505,10 @@
 
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
+
+	/* file callback list */
+	rwlock_t f_cblock;
+	struct list_head f_cblist;
 };
 extern spinlock_t files_lock;
 #define file_list_lock() spin_lock(&files_lock);
diff -Nru -X dontdiff linux-2.5.42/include/linux/list.h linux-2.5.42-epoll/include/linux/list.h
--- linux-2.5.42/include/linux/list.h	Fri Oct 11 21:21:03 2002
+++ linux-2.5.42-epoll/include/linux/list.h	Mon Oct 14 13:22:56 2002
@@ -240,6 +240,11 @@
 	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
 		     prefetch(pos->member.next))
 
+#define list_first(head)	(((head)->next != (head)) ? (head)->next: (struct list_head *) 0)
+#define list_last(head)	(((head)->prev != (head)) ? (head)->prev: (struct list_head *) 0)
+#define list_next(pos, head)	(((pos)->next != (head)) ? (pos)->next: (struct list_head *) 0)
+#define list_prev(pos, head)	(((pos)->prev != (head)) ? (pos)->prev: (struct list_head *) 0)
+
 #endif /* __KERNEL__ || _LVM_H_INCLUDE */
 
 #endif
diff -Nru -X dontdiff linux-2.5.42/include/linux/pipe_fs_i.h linux-2.5.42-epoll/include/linux/pipe_fs_i.h
--- linux-2.5.42/include/linux/pipe_fs_i.h	Fri Oct 11 21:22:12 2002
+++ linux-2.5.42-epoll/include/linux/pipe_fs_i.h	Mon Oct 14 13:22:56 2002
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
 
diff -Nru -X dontdiff linux-2.5.42/include/net/sock.h linux-2.5.42-epoll/include/net/sock.h
--- linux-2.5.42/include/net/sock.h	Fri Oct 11 21:22:15 2002
+++ linux-2.5.42-epoll/include/net/sock.h	Mon Oct 14 13:22:58 2002
@@ -51,6 +51,9 @@
 
 #include <asm/atomic.h>
 #include <net/dst.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/fcblist.h>
 
 /*
  * This structure really needs to be cleaned up.
@@ -744,8 +747,13 @@
 
 static inline void sk_wake_async(struct sock *sk, int how, int band)
 {
-	if (sk->socket && sk->socket->fasync_list)
+	if (sk->socket) {
+		if (sk->socket->file)
+			file_send_notify(sk->socket->file, ion_band_table[band - POLL_IN],
+					poll_band_table[band - POLL_IN]);
+		if (sk->socket->fasync_list)
 		sock_wake_async(sk->socket, how, band);
+	}
 }
 
 #define SOCK_MIN_SNDBUF 2048
diff -Nru -X dontdiff linux-2.5.42/net/ipv4/tcp.c linux-2.5.42-epoll/net/ipv4/tcp.c
--- linux-2.5.42/net/ipv4/tcp.c	Fri Oct 11 21:21:36 2002
+++ linux-2.5.42-epoll/net/ipv4/tcp.c	Mon Oct 14 13:22:58 2002
@@ -474,8 +474,8 @@
 		if (sk->sleep && waitqueue_active(sk->sleep))
 			wake_up_interruptible(sk->sleep);
 
-		if (sock->fasync_list && !(sk->shutdown & SEND_SHUTDOWN))
-			sock_wake_async(sock, 2, POLL_OUT);
+		if (!(sk->shutdown & SEND_SHUTDOWN))
+			sk_wake_async(sk, 2, POLL_OUT);
 	}
 }
 


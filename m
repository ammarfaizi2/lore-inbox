Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSKBTaJ>; Sat, 2 Nov 2002 14:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbSKBTaJ>; Sat, 2 Nov 2002 14:30:09 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:56195 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261338AbSKBT3d>; Sat, 2 Nov 2002 14:29:33 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 2 Nov 2002 11:40:55 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] total-epoll r2 ...
Message-ID: <Pine.LNX.4.44.0211021126110.951-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The new epoll approach to event delivery seems stable on my machine an
result about performance look pretty good. The changes that the new design
introduce are :

*) Full support for all devices that support ->f_op->poll()

*) Multi-threaded support ( if you really like them )

*) The function epoll_ctl(EP_CTL_ADD) drops an event if conditions are met

*) Less intrusive design by hooking directly the poll support

*) The patch is smaller, and this is a good news

*) Looks even faster to me

*) The function epoll_create(int size) has been changed. Not the "size"
	parameter is just an hint to the kernel about how to dimension its
	own internal data structures. In theory you can call
	epoll_create(200) and stock 10000 fds inside epoll

I updated the man pages to reflect the new behaviour :

http://www.xmailserver.org/linux-patches/epoll.txt
http://www.xmailserver.org/linux-patches/epoll_create.txt
http://www.xmailserver.org/linux-patches/epoll_ctl.txt
http://www.xmailserver.org/linux-patches/epoll_wait.txt


Comments and testing results are very welcome ...


PS: Linus, this might be considered a merge candidate for 2.5.46



- Davide



drivers/char/eventpoll.c  | 1254 ++++++++++++++++++----------------------------
fs/Makefile               |    4
fs/fcblist.c              |  146 -----
fs/file_table.c           |    6
fs/pipe.c                 |   36 -
fs/select.c               |    8
include/linux/eventpoll.h |   32 -
include/linux/fcblist.h   |   71 --
include/linux/fs.h        |    4
include/linux/pipe_fs_i.h |    4
include/linux/poll.h      |   18
include/net/sock.h        |   12
net/ipv4/tcp.c            |    4
13 files changed, 558 insertions, 1041 deletions





diff -Nru linux-2.5.45.vanilla/drivers/char/eventpoll.c linux-2.5.45.epoll/drivers/char/eventpoll.c
--- linux-2.5.45.vanilla/drivers/char/eventpoll.c	Wed Oct 30 16:42:27 2002
+++ linux-2.5.45.epoll/drivers/char/eventpoll.c	Sat Nov  2 11:16:40 2002
@@ -20,7 +20,6 @@
 #include <linux/signal.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
-#include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/miscdevice.h>
@@ -31,7 +30,6 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
-#include <linux/fcblist.h>
 #include <linux/rwsem.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
@@ -63,19 +61,53 @@
 #define DPI_SLAB_DEBUG 0
 #endif /* #if DEBUG_DPI != 0 */

-#define INITIAL_HASH_BITS 7
-#define MAX_HASH_BITS 18
-#define RESIZE_LENGTH 2

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
 #define DPI_MEM_ALLOC()	(struct epitem *) kmem_cache_alloc(dpi_cache, SLAB_KERNEL)
+
+/* Macro to free a "struct epitem" to the slab cache */
 #define DPI_MEM_FREE(p) kmem_cache_free(dpi_cache, p)
-#define IS_FILE_EPOLL(f) ((f)->f_op == &eventpoll_fops)

+/* Fast test to see if the file is an evenpoll file */
+#define IS_FILE_EPOLL(f) ((f)->f_op == &eventpoll_fops)

 /*
- * Type used for versioning events snapshots inside the double buffer.
+ * Remove the item from the list and perform its initialization.
+ * This is usefull for us because we can test if the item is linked
+ * using "EP_IS_LINKED(p)".
  */
-typedef unsigned long long event_version_t;
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

 /*
  * This structure is stored inside the "private_data" member of the file
@@ -83,71 +115,36 @@
  * interface.
  */
 struct eventpoll {
-	/*
-	 * Protect the evenpoll interface from sys_epoll_ctl(2), ioctl(EP_POLL)
-	 * and ->write() concurrency. It basically serialize the add/remove/edit
-	 * of items in the interest set.
-	 */
-	struct rw_semaphore acsem;
+	/* Used to link to the "struct eventpoll" list ( eplist ) */
+	struct list_head llink;

-	/*
-	 * Protect the this structure access. When the "acsem" is acquired
-	 * togheter with this one, "acsem" should be acquired first. Or,
-	 * "lock" nests inside "acsem".
-	 */
+	/* Protect the this structure access */
 	rwlock_t lock;

-	/* Wait queue used by sys_epoll_wait() and ioctl(EP_POLL) */
+	/* Wait queue used by sys_epoll_wait() */
 	wait_queue_head_t wq;

 	/* Wait queue used by file->poll() */
 	wait_queue_head_t poll_wait;

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
+	/* List of ready file descriptors */
+	struct list_head rdllist;

-	/*
-	 * Variable containing the vma base address where the double buffer
-	 * pages are mapped onto.
-	 */
-	unsigned long vmabase;
+	/* Size of the hash */
+	int hsize;

-	/*
-	 * Certain functions cannot be called if the double buffer pages are
-	 * not allocated and if the memory mapping is not in place. This tells
-	 * us that everything is setup to fully use the interface.
-	 */
-	atomic_t mmapped;
+	/* Number of pages currently allocated for the hash */
+	int nhpages;

-	/* Number of events currently available inside the current snapshot */
-	int eventcnt;
+	/* Pages for the "struct epitem" hash */
+	char *hpages[EP_MAX_HPAGES];
+};

-	/*
-	 * Variable storing the current "version" of the snapshot. It is used
-	 * to validate the validity of the current slot pointed by the "index"
-	 * member of a "struct epitem".
-	 */
-	event_version_t ver;
+/* Wait structure used by the poll hooks */
+struct eppoll_entry {
+	void *base;
+	wait_queue_t wait;
+	wait_queue_head_t *whead;
 };

 /*
@@ -158,6 +155,15 @@
 	/* List header used to link this structure to the eventpoll hash */
 	struct list_head llink;

+	/* List header used to link this structure to the eventpoll ready list */
+	struct list_head rdllink;
+
+	/* Number of active wait queue attached to poll operations */
+	int nwait;
+
+	/* Wait queue used to attach poll operations */
+	struct eppoll_entry wait[EP_MAX_POLL_QUEUE];
+
 	/* The "container" of this item */
 	struct eventpoll *ep;

@@ -168,52 +174,48 @@
 	struct pollfd pfd;

 	/*
-	 * The index inside the current double buffer that stores the active
-	 * event slot for this item ( file ).
+	 * Used to keep track of the usage count of the structure. This avoids
+	 * that the structure will desappear from underneath our processing.
 	 */
-	int index;
-
-	/*
-	 * The version that is used to validate if the current slot is still
-	 * valid or if it refers to an old snapshot. It is matches togheter
-	 * with the one inside the eventpoll structure.
-	 */
-	event_version_t ver;
+	atomic_t usecnt;
 };




+static int ep_is_prime(int n);
 static int ep_getfd(int *efd, struct inode **einode, struct file **efile);
 static int ep_alloc_pages(char **pages, int numpages);
 static int ep_free_pages(char **pages, int numpages);
-static int ep_init(struct eventpoll *ep);
+static int ep_file_init(struct file *file, int maxfds);
+static int ep_hash_index(struct eventpoll *ep, struct file *file);
+static struct list_head *ep_hash_entry(struct eventpoll *ep, int index);
+static int ep_init(struct eventpoll *ep, int hsize);
 static void ep_free(struct eventpoll *ep);
-static struct epitem *ep_find_nl(struct eventpoll *ep, int fd);
-static struct epitem *ep_find(struct eventpoll *ep, int fd);
-static int ep_hashresize(struct eventpoll *ep, unsigned long *kflags);
-static int ep_insert(struct eventpoll *ep, struct pollfd *pfd);
+static struct epitem *ep_find(struct eventpoll *ep, struct file *file);
+static void ep_use_epitem(struct epitem *dpi);
+static void ep_release_epitem(struct epitem *dpi);
+static void ep_ptable_queue_proc(void *priv, wait_queue_head_t *whead);
+static int ep_insert(struct eventpoll *ep, struct pollfd *pfd, struct file *tfile);
+static int ep_unlink(struct eventpoll *ep, struct epitem *dpi);
 static int ep_remove(struct eventpoll *ep, struct epitem *dpi);
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
+static int ep_poll_callback(wait_queue_t *wait, unsigned mode, int sync);
+static int ep_eventpoll_close(struct inode *inode, struct file *file);
+static unsigned int ep_eventpoll_poll(struct file *file, poll_table *wait);
+static int ep_events_transfer(struct eventpoll *ep, struct pollfd *events, int maxevents);
+static int ep_poll(struct eventpoll *ep, struct pollfd *events, int maxevents,
+		   int timeout);
 static int eventpollfs_delete_dentry(struct dentry *dentry);
-static struct inode *get_eventpoll_inode(void);
+static struct inode *ep_eventpoll_inode(void);
 static struct super_block *eventpollfs_get_sb(struct file_system_type *fs_type,
 					      int flags, char *dev_name, void *data);


+/* Use to link togheter all the "struct eventpoll" */
+static struct list_head eplist;
+
+/* Serialize the access to "eplist" */
+static rwlock_t eplock;

 /* Slab cache used to allocate "struct epitem" */
 static kmem_cache_t *dpi_cache;
@@ -223,26 +225,8 @@

 /* File callbacks that implement the eventpoll file behaviour */
 static struct file_operations eventpoll_fops = {
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
+	.release	= ep_eventpoll_close,
+	.poll		= ep_eventpoll_poll
 };

 /*
@@ -262,27 +246,67 @@



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
 /*
- * It opens an eventpoll file descriptor by allocating space for "maxfds"
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
  * file descriptors. It is the kernel part of the userspace epoll_create(2).
  */
-asmlinkage int sys_epoll_create(int maxfds)
+asmlinkage int sys_epoll_create(int size)
 {
-	int error = -EINVAL, fd;
-	unsigned long addr;
+	int error, fd;
 	struct inode *inode;
 	struct file *file;
-	struct eventpoll *ep;

 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d)\n",
-		     current, maxfds));
+		     current, size));

-	/*
-	 * It is not possible to store more than MAX_FDS_IN_EVENTPOLL file
-	 * descriptors inside the eventpoll interface.
-	 */
-	if (maxfds > MAX_FDS_IN_EVENTPOLL)
-		goto eexit_1;
+	/* Search the nearest prime number higher than "size" */
+	for (; !ep_is_prime(size); size++);
+	if (size < EP_MIN_HASH_SIZE)
+		size = EP_MIN_HASH_SIZE;

 	/*
 	 * Creates all the items needed to setup an eventpoll file. That is,
@@ -292,39 +316,14 @@
 	if (error)
 		goto eexit_1;

-	/*
-	 * Calls the code to initialize the eventpoll file. This code is
-	 * the same as the "open" file operation callback because inside
-	 * ep_getfd() we did what the kernel usually does before invoking
-	 * corresponding file "open" callback.
-	 */
-	error = open_eventpoll(inode, file);
+	/* Setup the file internal data structure ( "struct eventpoll" ) */
+	error = ep_file_init(file, size);
 	if (error)
 		goto eexit_2;

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

 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d) = %d\n",
-		     current, maxfds, fd));
+		     current, size, fd));

 	return fd;

@@ -332,7 +331,7 @@
 	sys_close(fd);
 eexit_1:
 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_create(%d) = %d\n",
-		     current, maxfds, error));
+		     current, size, error));
 	return error;
 }

@@ -344,8 +343,8 @@
  */
 asmlinkage int sys_epoll_ctl(int epfd, int op, int fd, unsigned int events)
 {
-	int error = -EBADF;
-	struct file *file;
+	int error;
+	struct file *file, *tfile;
 	struct eventpoll *ep;
 	struct epitem *dpi;
 	struct pollfd pfd;
@@ -353,17 +352,29 @@
 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_ctl(%d, %d, %d, %u)\n",
 		     current, epfd, op, fd, events));

+	/* Get the "struct file *" for the eventpoll file */
+	error = -EBADF;
 	file = fget(epfd);
 	if (!file)
 		goto eexit_1;

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
 	/*
 	 * We have to check that the file structure underneath the file descriptor
 	 * the user passed to us _is_ an eventpoll file.
 	 */
 	error = -EINVAL;
 	if (!IS_FILE_EPOLL(file))
-		goto eexit_2;
+		goto eexit_3;

 	/*
 	 * At this point it is safe to assume that the "private_data" contains
@@ -371,20 +382,19 @@
 	 */
 	ep = file->private_data;

-	down_write(&ep->acsem);
-
-	pfd.fd = fd;
-	pfd.events = events | POLLERR | POLLHUP;
-	pfd.revents = 0;
-
-	dpi = ep_find(ep, fd);
+	/* Try to lookup the file inside our hash table */
+	dpi = ep_find(ep, tfile);

 	error = -EINVAL;
 	switch (op) {
 	case EP_CTL_ADD:
-		if (!dpi)
-			error = ep_insert(ep, &pfd);
-		else
+		if (!dpi) {
+			pfd.fd = fd;
+			pfd.events = events | POLLERR | POLLHUP;
+			pfd.revents = 0;
+
+			error = ep_insert(ep, &pfd, tfile);
+		} else
 			error = -EEXIST;
 		break;
 	case EP_CTL_DEL:
@@ -402,11 +412,18 @@
 		break;
 	}

+	/*
+	 * The function ep_find() increments the usage count of the structure
+	 * so, if this is not NULL, we need to release it.
+	 */
+	if (dpi)
+		ep_release_epitem(dpi);
+
 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_ctl(%d, %d, %d, %u) = %d\n",
 		     current, epfd, op, fd, events, error));

-	up_write(&ep->acsem);
-
+eexit_3:
+	fput(tfile);
 eexit_2:
 	fput(file);
 eexit_1:
@@ -418,17 +435,22 @@
  * Implement the event wait interface for the eventpoll file. It is the kernel
  * part of the user space epoll_wait(2).
  */
-asmlinkage int sys_epoll_wait(int epfd, struct pollfd const **events, int timeout)
+asmlinkage int sys_epoll_wait(int epfd, struct pollfd *events, int maxevents,
+			      int timeout)
 {
-	int error = -EBADF;
-	void *eaddr;
+	int error;
 	struct file *file;
 	struct eventpoll *ep;
-	struct evpoll dvp;

-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d)\n",
-		     current, epfd, events, timeout));
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d, %d)\n",
+		     current, epfd, events, maxevents, timeout));
+
+	/* Verify that the area passed by the user is writeable */
+	if ((error = verify_area(VERIFY_WRITE, events, maxevents * sizeof(struct pollfd))))
+		goto eexit_1;

+	/* Get the "struct file *" for the eventpoll file */
+	error = -EBADF;
 	file = fget(epfd);
 	if (!file)
 		goto eexit_1;
@@ -447,26 +469,11 @@
 	 */
 	ep = file->private_data;

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
+	/* Time to fish for events ... */
+	error = ep_poll(ep, events, maxevents, timeout);

-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d) = %d\n",
-		     current, epfd, events, timeout, error));
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d, %d) = %d\n",
+		     current, epfd, events, maxevents, timeout, error));

 eexit_2:
 	fput(file);
@@ -494,7 +501,7 @@
 		goto eexit_1;

 	/* Allocates an inode from the eventpoll file system */
-	inode = get_eventpoll_inode();
+	inode = ep_eventpoll_inode();
 	error = PTR_ERR(inode);
 	if (IS_ERR(inode))
 		goto eexit_2;
@@ -527,9 +534,9 @@
 	 * with write() to add/remove/change interest sets.
 	 */
 	file->f_pos = 0;
-	file->f_flags = O_RDWR;
+	file->f_flags = O_RDONLY;
 	file->f_op = &eventpoll_fops;
-	file->f_mode = FMODE_READ | FMODE_WRITE;
+	file->f_mode = FMODE_READ;
 	file->f_version = 0;
 	file->private_data = NULL;

@@ -548,7 +555,7 @@
 eexit_2:
 	put_filp(file);
 eexit_1:
-	return error;
+	return error;
 }


@@ -583,318 +590,348 @@
 }


-static int ep_init(struct eventpoll *ep)
+static int ep_file_init(struct file *file, int maxfds)
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
+	error = ep_init(ep, maxfds);
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
 {
-	int ii, hentries;

-	init_rwsem(&ep->acsem);
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
 	rwlock_init(&ep->lock);
 	init_waitqueue_head(&ep->wq);
 	init_waitqueue_head(&ep->poll_wait);
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
+	INIT_LIST_HEAD(&ep->rdllist);

-	hentries = ep->hmask + 1;
-	if (!(ep->hash = (struct list_head *) vmalloc(hentries * sizeof(struct list_head))))
-		return -ENOMEM;
+	/* Hash allocation and setup */
+	ep->hsize = hsize;
+	ep->nhpages = hsize / EP_HENTRY_X_PAGE + 1;
+	error = ep_alloc_pages(ep->hpages, ep->nhpages);
+	if (error)
+		goto eexit_1;

-	for (ii = 0; ii < hentries; ii++)
-		INIT_LIST_HEAD(&ep->hash[ii]);
+	for (i = 0; i < ep->hsize; i++)
+		INIT_LIST_HEAD(ep_hash_entry(ep, i));

 	return 0;
+eexit_1:
+	return error;
 }


 static void ep_free(struct eventpoll *ep)
 {
-	int ii;
+	int i;
+	unsigned long flags;
 	struct list_head *lsthead;

 	/*
 	 * Walks through the whole hash by unregistering file callbacks and
 	 * freeing each "struct epitem".
 	 */
-	for (ii = 0; ii <= ep->hmask; ii++) {
-		lsthead = &ep->hash[ii];
+	for (i = 0; i < ep->hsize; i++) {
+		lsthead = ep_hash_entry(ep, i);
+
+		/*
+		 * We need to lock this because we could be hit by
+		 * ep_notify_file_close() while we're freeing this.
+		 */
+		write_lock_irqsave(&ep->lock, flags);
+
 		while (!list_empty(lsthead)) {
 			struct epitem *dpi = list_entry(lsthead->next, struct epitem, llink);

-			file_notify_delcb(dpi->file, notify_proc);
-			list_del(lsthead->next);
-			DPI_MEM_FREE(dpi);
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
 		}
+
+		write_unlock_irqrestore(&ep->lock, flags);
 	}
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
+
+	/* Remove the structure to the linked list that links "struct eventpoll" */
+	write_lock_irqsave(&eplock, flags);
+	list_del(&ep->llink);
+	write_unlock_irqrestore(&eplock, flags);
+
+	/* Free hash pages */
+	if (ep->nhpages > 0)
+		ep_free_pages(ep->hpages, ep->nhpages);
 }


 /*
- * No lock version of ep_find(), used when the code had to acquire the lock
- * before calling the function.
+ * Search the file inside the eventpoll hash. It add usage count to
+ * the returned item, so the caller must call ep_release_epitem()
+ * after finished using the "struct epitem".
  */
-static struct epitem *ep_find_nl(struct eventpoll *ep, int fd)
+static struct epitem *ep_find(struct eventpoll *ep, struct file *file)
 {
-	struct epitem *dpi = NULL;
+	unsigned long flags;
 	struct list_head *lsthead, *lnk;
+	struct epitem *dpi = NULL;

-	lsthead = &ep->hash[fd & ep->hmask];
+	read_lock_irqsave(&ep->lock, flags);
+
+	lsthead = ep_hash_entry(ep, ep_hash_index(ep, file));
 	list_for_each(lnk, lsthead) {
 		dpi = list_entry(lnk, struct epitem, llink);

-		if (dpi->pfd.fd == fd) break;
+		if (dpi->file == file) {
+			ep_use_epitem(dpi);
+			break;
+		}
 		dpi = NULL;
 	}

-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_find(%d) -> %p\n",
-		     current, fd, dpi));
+	read_unlock_irqrestore(&ep->lock, flags);
+
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_find(%p) -> %p\n",
+		     current, file, dpi));

 	return dpi;
 }


-static struct epitem *ep_find(struct eventpoll *ep, int fd)
+/*
+ * Increment the usage count of the "struct epitem" making it sure
+ * that the user will have a valid pointer to reference.
+ */
+static void ep_use_epitem(struct epitem *dpi)
 {
-	struct epitem *dpi;
-	unsigned long flags;
-
-	read_lock_irqsave(&ep->lock, flags);
-
-	dpi = ep_find_nl(ep, fd);

-	read_unlock_irqrestore(&ep->lock, flags);
-
-	return dpi;
+	atomic_inc(&dpi->usecnt);
 }


-static int ep_hashresize(struct eventpoll *ep, unsigned long *kflags)
+/*
+ * Decrement ( release ) the usage count by signaling that the user
+ * has finished using the structure. It might lead to freeing the
+ * structure itself if the count goes to zero.
+ */
+static void ep_release_epitem(struct epitem *dpi)
 {
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
+	if (atomic_dec_and_test(&dpi->usecnt))
+		DPI_MEM_FREE(dpi);
+}

-	oldhash = ep->hash;
-	for (ii = 0; ii <= ep->hmask; ii++) {
-		struct list_head *oldhead = &oldhash[ii], *lnk;

-		while (!list_empty(oldhead)) {
-			struct epitem *dpi = list_entry(lnk = oldhead->next, struct epitem, llink);
+/*
+ * This is the callback that is used to add our wait queue to the
+ * target file wakeup lists.
+ */
+static void ep_ptable_queue_proc(void *priv, wait_queue_head_t *whead)
+{
+	struct epitem *dpi = priv;

-			list_del(lnk);
-			list_add(lnk, &hash[dpi->pfd.fd & hmask]);
-		}
+	/* No more than EP_MAX_POLL_QUEUE wait queue are supported */
+	if (dpi->nwait < EP_MAX_POLL_QUEUE) {
+		add_wait_queue(whead, &dpi->wait[dpi->nwait].wait);
+		dpi->wait[dpi->nwait].whead = whead;
+		dpi->nwait++;
 	}
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
 }


-static int ep_insert(struct eventpoll *ep, struct pollfd *pfd)
+static int ep_insert(struct eventpoll *ep, struct pollfd *pfd, struct file *tfile)
 {
-	int error;
-	struct epitem *dpi;
-	struct file *file;
+	int error, i, revents;
 	unsigned long flags;
-
-	if (atomic_read(&ep->hents) >= (ep->numpages * POLLFD_X_PAGE))
-		return -E2BIG;
-
-	file = fget(pfd->fd);
-	if (!file)
-		return -EBADF;
+	struct epitem *dpi;
+	poll_table pt;

 	error = -ENOMEM;
 	if (!(dpi = DPI_MEM_ALLOC()))
 		goto eexit_1;

+	/* Item initialization follow here ... */
 	INIT_LIST_HEAD(&dpi->llink);
+	INIT_LIST_HEAD(&dpi->rdllink);
 	dpi->ep = ep;
-	dpi->file = file;
+	dpi->file = tfile;
 	dpi->pfd = *pfd;
-	dpi->index = -1;
-	dpi->ver = ep->ver - 1;
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

+	/* We have to drop the new item inside our item list to keep track of it */
 	write_lock_irqsave(&ep->lock, flags);

-	list_add(&dpi->llink, &ep->hash[pfd->fd & ep->hmask]);
-	atomic_inc(&ep->hents);
+	list_add(&dpi->llink, ep_hash_entry(ep, ep_hash_index(ep, tfile)));

-	if (!atomic_read(&ep->resize) &&
-	    (atomic_read(&ep->hents) >> ep->hbits) > RESIZE_LENGTH &&
-	    ep->hbits < MAX_HASH_BITS) {
-		atomic_inc(&ep->resize);
-		ep_hashresize(ep, &flags);
-	}
+	/* If the file is already "ready" we drop him inside the ready list */
+	if (revents & pfd->events)
+		list_add(&dpi->rdllink, &ep->rdllist);

 	write_unlock_irqrestore(&ep->lock, flags);

-	file_notify_addcb(file, notify_proc, dpi);
-
 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_insert(%p, %d)\n",
 		     current, ep, pfd->fd));

-	error = 0;
-eexit_1:
-	fput(file);
+	return 0;

+eexit_1:
 	return error;
 }


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
+	 * At this point is safe to do the job, decrement the number of file
+	 * descriptors stored inside the interest set and unlink the item
+	 * from our list.
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
 /*
  * Removes a "struct epitem" from the eventpoll hash and deallocates
  * all the associated resources.
  */
 static int ep_remove(struct eventpoll *ep, struct epitem *dpi)
 {
+	int error;
 	unsigned long flags;
-	struct pollfd *pfd, *lpfd;
-	struct epitem *ldpi;
-
-	/* First, removes the callback from the file callback list */
-	file_notify_delcb(dpi->file, notify_proc);

 	write_lock_irqsave(&ep->lock, flags);

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
+	/* Really unlink the item from the hash */
+	error = ep_unlink(ep, dpi);

 	write_unlock_irqrestore(&ep->lock, flags);

+	if (error)
+		goto eexit_1;
+
 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_remove(%p, %d)\n",
 		     current, ep, dpi->pfd.fd));

 	/* At this point it is safe to free the eventpoll item */
-	DPI_MEM_FREE(dpi);
+	ep_release_epitem(dpi);

-	return 0;
+	error = 0;
+eexit_1:
+	return error;
 }


 /*
- * This is the event notify callback that is called from fs/fcblist.c because
- * of the registration ( file_notify_addcb() ) done in ep_insert().
+ * This is the callback that is passed to the wait queue wakeup
+ * machanism. It is called by the stored file descriptors when they
+ * have events to report.
  */
-static void notify_proc(struct file *file, void *data, unsigned long *local,
-			long *event)
+static int ep_poll_callback(wait_queue_t *wait, unsigned mode, int sync)
 {
-	struct epitem *dpi = data;
+	unsigned long flags;
+	struct epitem *dpi = EP_ITEM_FROM_WAIT(wait);
 	struct eventpoll *ep = dpi->ep;
-	struct pollfd *pfd;

-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: notify(%p, %p, %ld, %ld) ep=%p\n",
-		     current, file, data, event[0], event[1], ep));
-
-	/*
-	 * We don't need to disable IRQs here because the callback dispatch
-	 * routine inside fs/fcblist.c already call us with disabled IRQ.
-	 */
-	write_lock(&ep->lock);
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: poll_callback(%p) dpi=%p ep=%p\n",
+		     current, dpi->file, dpi, ep));

-	/* We're not expecting any of those events. Jump out soon ... */
-	if (!(dpi->pfd.events & event[1]))
-		goto out;
+	write_lock_irqsave(&ep->lock, flags);

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
+	/* If this file is already in the ready list we exit soon */
+	if (EP_IS_LINKED(&dpi->rdllink))
+		goto is_linked;

-	/*
-	 * Merge event bits into the corresponding event slot inside the
-	 * double buffer.
-	 */
-	pfd->revents |= (pfd->events & event[1]);
+	list_add(&dpi->rdllink, &ep->rdllist);

+is_linked:
 	/*
 	 * Wake up ( if active ) both the eventpoll wait list and the ->poll()
 	 * wait list.
@@ -903,33 +940,13 @@
 		wake_up(&ep->wq);
 	if (waitqueue_active(&ep->poll_wait))
 		wake_up(&ep->poll_wait);
-out:
-	write_unlock(&ep->lock);
-}
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
+	write_unlock_irqrestore(&ep->lock, flags);
+	return 1;
 }


-static int close_eventpoll(struct inode *inode, struct file *file)
+static int ep_eventpoll_close(struct inode *inode, struct file *file)
 {
 	struct eventpoll *ep = file->private_data;

@@ -943,107 +960,103 @@
 }


-static unsigned int poll_eventpoll(struct file *file, poll_table *wait)
+static unsigned int ep_eventpoll_poll(struct file *file, poll_table *wait)
 {
 	struct eventpoll *ep = file->private_data;

 	poll_wait(file, &ep->poll_wait, wait);
-	if (ep->eventcnt)
+	if (!list_empty(&ep->rdllist))
 		return POLLIN | POLLRDNORM;

 	return 0;
 }


-static int write_eventpoll(struct file *file, const char *buffer, size_t count,
-			   loff_t *ppos)
+/*
+ * Perform the transfer of events to user space. Optimize the copy by
+ * caching EP_EVENT_BUFF_SIZE events at a time and then copying it to user space.
+ */
+static int ep_events_transfer(struct eventpoll *ep, struct pollfd *events, int maxevents)
 {
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
+	int eventcnt, pagefill, revents;
+	unsigned long flags;
+	struct list_head *lsthead = &ep->rdllist;
+	struct pollfd eventbuf[EP_EVENT_BUFF_SIZE];
+	poll_table pt;

 	/*
-	 * And we have also to verify that that area is correctly accessible
-	 * for the user.
+	 * Attach the item to the poll hooks. This is a special poll table
+	 * initialization that will make poll_wait() to not perform any
+	 * wait queue insertion when called by file->f_op->poll(). This
+	 * is a fast way to retrieve file events with perform any queue
+	 * insertion, hence saving CPU cycles.
 	 */
-	if ((rcount = verify_area(VERIFY_READ, buffer, count)))
-		goto eexit_1;
+	poll_initwait_ex(&pt, 0, NULL, NULL);

-	down_write(&ep->acsem);
-
-	rcount = 0;
+	write_lock_irqsave(&ep->lock, flags);

-	while (count > 0) {
-		if (__copy_from_user(&pfd, buffer, sizeof(pfd))) {
-			rcount = -EFAULT;
-			goto eexit_2;
-		}
+	for (eventcnt = 0, pagefill = 0; eventcnt < maxevents && !list_empty(lsthead);) {
+		struct epitem *dpi = list_entry(lsthead->next, struct epitem, rdllink);

-		dpi = ep_find(ep, pfd.fd);
+		/* Remove the item from the ready list */
+		EP_LIST_DEL(&dpi->rdllink);

-		if (pfd.fd >= current->files->max_fds || !current->files->fd[pfd.fd])
-			pfd.events = POLLREMOVE;
-		if (pfd.events & POLLREMOVE) {
-			if (dpi) {
-				ep_remove(ep, dpi);
-				rcount += sizeof(pfd);
+		revents = dpi->file->f_op->poll(dpi->file, &pt);
+		if (revents & dpi->pfd.events) {
+			eventbuf[pagefill] = dpi->pfd;
+			eventbuf[pagefill].revents = revents & eventbuf[pagefill].events;
+			pagefill++;
+			/* If our buffer page is full we need to flush it to user space */
+			if (pagefill == EP_EVENT_BUFF_SIZE) {
+				/*
+				 * We need to drop the irqlock before using the function
+				 * __copy_to_user() because it might fault.
+				 */
+				write_unlock_irqrestore(&ep->lock, flags);
+				if (__copy_to_user(&events[eventcnt], eventbuf,
+						   pagefill * sizeof(struct pollfd))) {
+					poll_freewait(&pt);
+					return -EFAULT;
+				}
+				eventcnt += pagefill;
+				pagefill = 0;
+				write_lock_irqsave(&ep->lock, flags);
 			}
 		}
-		else if (dpi) {
-			dpi->pfd.events = pfd.events;
-			rcount += sizeof(pfd);
-		} else {
-			pfd.revents = 0;
-			if (!ep_insert(ep, &pfd))
-				rcount += sizeof(pfd);
-		}
+	}
+	write_unlock_irqrestore(&ep->lock, flags);

-		buffer += sizeof(pfd);
-		count -= sizeof(pfd);
+	/* There might be still something inside our buffer page */
+	if (pagefill) {
+		if (__copy_to_user(&events[eventcnt], eventbuf,
+				   pagefill * sizeof(struct pollfd)))
+			eventcnt = -EFAULT;
+		else
+			eventcnt += pagefill;
 	}

-eexit_2:
-	up_write(&ep->acsem);
-eexit_1:
-	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: write(%p, %d) = %d\n",
-		     current, ep, count, rcount));
+	poll_freewait(&pt);

-	return rcount;
+	return eventcnt;
 }


-static int ep_poll(struct eventpoll *ep, struct evpoll *dvp)
+static int ep_poll(struct eventpoll *ep, struct pollfd *events, int maxevents,
+		   int timeout)
 {
 	int res = 0;
-	long timeout;
 	unsigned long flags;
+	long jtimeout;
 	wait_queue_t wait;

-	/*
-	 * We don't want ep_poll() to be called if the correct sequence
-	 * of operations are performed to initialize it. This won't happen
-	 * for the system call interface but it could happen using the
-	 * old /dev/epoll interface, that is maintained for compatibility.
-	 */
-	if (!atomic_read(&ep->mmapped))
-		return -EINVAL;
-
 	write_lock_irqsave(&ep->lock, flags);

 	res = 0;
-	if (!ep->eventcnt) {
+	if (list_empty(&ep->rdllist)) {
 		/*
 		 * We don't have any available event to return to the caller.
 		 * We need to sleep here, and we will be wake up by
-		 * notify_proc() when events will become available.
+		 * ep_poll_callback() when events will become available.
 		 */
 		init_waitqueue_entry(&wait, current);
 		add_wait_queue(&ep->wq, &wait);
@@ -1053,17 +1066,17 @@
 		 * and the overflow condition ( > MAX_SCHEDULE_TIMEOUT / HZ ). The
 		 * passed timeout is in milliseconds, that why (t * HZ) / 1000.
 		 */
-		timeout = dvp->ep_timeout == -1 || dvp->ep_timeout > MAX_SCHEDULE_TIMEOUT / HZ ?
-			MAX_SCHEDULE_TIMEOUT: (dvp->ep_timeout * HZ) / 1000;
+		jtimeout = timeout == -1 || timeout > MAX_SCHEDULE_TIMEOUT / HZ ?
+			MAX_SCHEDULE_TIMEOUT: (timeout * HZ) / 1000;

 		for (;;) {
 			/*
-			 * We don't want to sleep if the notify_proc() sends us
+			 * We don't want to sleep if the ep_poll_callback() sends us
 			 * a wakeup in between. That's why we set the task state
 			 * to TASK_INTERRUPTIBLE before doing the checks.
 			 */
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (ep->eventcnt || !timeout)
+			if (!list_empty(&ep->rdllist) || !jtimeout)
 				break;
 			if (signal_pending(current)) {
 				res = -EINTR;
@@ -1071,7 +1084,7 @@
 			}

 			write_unlock_irqrestore(&ep->lock, flags);
-			timeout = schedule_timeout(timeout);
+			jtimeout = schedule_timeout(jtimeout);
 			write_lock_irqsave(&ep->lock, flags);
 		}
 		remove_wait_queue(&ep->wq, &wait);
@@ -1079,249 +1092,12 @@
 		set_current_state(TASK_RUNNING);
 	}

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
 	write_unlock_irqrestore(&ep->lock, flags);

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
+	/* Transfer events to user space */
+	if (!list_empty(&ep->rdllist))
+		res = ep_events_transfer(ep, events, maxevents);

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
 	return res;
 }

@@ -1333,7 +1109,7 @@
 }


-static struct inode *get_eventpoll_inode(void)
+static struct inode *ep_eventpoll_inode(void)
 {
 	int error = -ENOMEM;
 	struct inode *inode = new_inode(eventpoll_mnt->mnt_sb);
@@ -1346,7 +1122,7 @@
 	/*
 	 * Mark the inode dirty from the very beginning,
 	 * that way it will never be moved to the dirty
-	 * list because "mark_inode_dirty()" will think
+	 * list because mark_inode_dirty() will think
 	 * that it already _is_ on the dirty list.
 	 */
 	inode->i_state = I_DIRTY;
@@ -1374,11 +1150,17 @@
 {
 	int error;

+	/* Initialize the list that will link "struct eventpoll" */
+	INIT_LIST_HEAD(&eplist);
+
+	/* Initialize the rwlock used to access "eplist" */
+	rwlock_init(&eplock);
+
 	/* Allocates slab cache used to allocate "struct epitem" items */
 	error = -ENOMEM;
 	dpi_cache = kmem_cache_create("eventpoll",
 				      sizeof(struct epitem),
-				      __alignof__(struct epitem),
+				      0,
 				      DPI_SLAB_DEBUG, NULL, NULL);
 	if (!dpi_cache)
 		goto eexit_1;
@@ -1397,21 +1179,10 @@
 	if (IS_ERR(eventpoll_mnt))
 		goto eexit_3;

-	/*
-	 * This is to maintain compatibility with the old /dev/epoll interface.
-	 * We need to register a misc device so that the caller can open(2) it
-	 * through a file inside /dev.
-	 */
-	error = misc_register(&eventpoll_miscdev);
-	if (error)
-		goto eexit_4;
-
 	printk(KERN_INFO "[%p] eventpoll: driver installed.\n", current);

-	return error;
+	return 0;

-eexit_4:
-	mntput(eventpoll_mnt);
 eexit_3:
 	unregister_filesystem(&eventpoll_fs_type);
 eexit_2:
@@ -1427,7 +1198,6 @@
 	/* Undo all operations done inside eventpoll_init() */
 	unregister_filesystem(&eventpoll_fs_type);
 	mntput(eventpoll_mnt);
-	misc_deregister(&eventpoll_miscdev);
 	kmem_cache_destroy(dpi_cache);
 }

diff -Nru linux-2.5.45.vanilla/fs/Makefile linux-2.5.45.epoll/fs/Makefile
--- linux-2.5.45.vanilla/fs/Makefile	Wed Oct 30 16:42:59 2002
+++ linux-2.5.45.epoll/fs/Makefile	Fri Nov  1 12:06:33 2002
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
+		fs-writeback.o mpage.o direct-io.o aio.o

 ifneq ($(CONFIG_NFSD),n)
 ifneq ($(CONFIG_NFSD),)
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
+++ linux-2.5.45.epoll/include/linux/eventpoll.h	Sat Nov  2 10:27:50 2002
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








Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267203AbRGKEwm>; Wed, 11 Jul 2001 00:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267202AbRGKEwb>; Wed, 11 Jul 2001 00:52:31 -0400
Received: from sncgw.nai.com ([161.69.248.229]:27626 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S267201AbRGKEwO>;
	Wed, 11 Jul 2001 00:52:14 -0400
Message-ID: <XFMail.20010710215331.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.7.Linux:20010710215331:705=_"
Date: Tue, 10 Jul 2001 21:53:31 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Improving (network) IO performance ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.4.7.Linux:20010710215331:705=_
Content-Type: text/plain; charset=us-ascii


The reason of the current work is to analyze different methods for
efficent delivery of networks events from kernel mode to user mode.
Three methods are examined, poll() that has been chosen as the better
old-style method, standard /dev/poll interface and a new /dev/poll
that uses a quite different notification method.
RT signals have been discarded because they are not so efficent as
the old /dev/poll interface due the single event pickup way to pop
signals from the queue.
Provos and Lever have developed an interface to retire more than one
signal per system call but, even in this way, the interface resulted
a loser compared to the old /dev/poll.
This work is composed by :

1) the new /dev/poll kernel patch
2) the /dev/poll patch from Provos-Lever modified to work with 2.4.6
3) the HTTP server
4) the deadconn(tm) tool to create "dead" connections

As a measure tool httperf has been chosen coz, even if not perfect,
it offers a quite sufficent number of loading options.



                    The new /dev/poll kernel patch

The patch is quite simple and it adds notification callbacks to the
'struct file' data structure :

****** include/linux/fs.h

/* file callback notification events */
#define ION_IN          1
#define ION_OUT         2
#define ION_HUP         3
#define ION_ERR         4

#define FCB_LOCAL_SIZE  4

#define fcblist_read_lock(fp, fl)              \
read_lock_irqsave(&(fp)->f_cblock, fl)
#define fcblist_read_unlock(fp, fl)            \
read_unlock_irqrestore(&(fp)->f_cblock, fl)
#define fcblist_write_lock(fp, fl)             \
write_lock_irqsave(&(fp)->f_cblock, fl)
#define fcblist_write_unlock(fp, fl)           \
write_unlock_irqrestore(&(fp)->f_cblock, fl)

struct fcb_struct {
        struct list_head lnk;
        void (*cbproc)(struct file *, void *, unsigned long *, long *);
        void *data;
        unsigned long local[FCB_LOCAL_SIZE];
};

struct file {
        ...
        /* file callback list */
        rwlock_t f_cblock;
        struct list_head f_cblist;
};

The meaning of this callback list is to give lower IO layers the ability to
notify upper layers that will register their "interests" to the file structure.
In fs/file_table.c initialization and cleanups code has been added while
in fs/file.c the callback list handling code has been fit :

****** fs/file_table.c

struct file * get_empty_filp(void)
{
        ...
        rwlock_init(&f->f_cblock);
        INIT_LIST_HEAD(&f->f_cblist);
        ...
}

int init_private_file(struct file *filp, struct dentry *dentry, int mode)
{
        ...
        rwlock_init(&f->f_cblock);
        INIT_LIST_HEAD(&f->f_cblist);
        ...
}

void fput(struct file * file)
{
        ...
        file_notify_cleanup(file);
        ...
}


****** fs/file.c

void file_notify_event(struct file *filep, long *event)
{
        unsigned long flags;
        struct list_head *lnk;

        fcblist_read_lock(filep, flags);
        list_for_each(lnk, &filep->f_cblist) {
                struct fcb_struct *fcbp = list_entry(lnk, struct fcb_struct,
lnk);

                fcbp->cbproc(filep, fcbp->data, fcbp->local, event);
        }
        fcblist_read_unlock(filep, flags);
}

int file_notify_addcb(struct file *filep,
                void (*cbproc)(struct file *, void *, unsigned long *, long *),
void *data)
{
        unsigned long flags;
        struct fcb_struct *fcbp;

        if (!(fcbp = (struct fcb_struct *) kmalloc(sizeof(struct fcb_struct),
GFP_KERNEL)))
                return -ENOMEM;
        memset(fcbp, 0, sizeof(struct fcb_struct));
        fcbp->cbproc = cbproc;
        fcbp->data = data;
        fcblist_write_lock(filep, flags);
        list_add_tail(&fcbp->lnk, &filep->f_cblist);
        fcblist_write_unlock(filep, flags);
        return 0;
}

int file_notify_delcb(struct file *filep,
                void (*cbproc)(struct file *, void *, unsigned long *, long *))
{
        int error;
        unsigned long flags;
        struct list_head *lnk;

        fcblist_write_lock(filep, flags);
        error = -ENOENT;
        list_for_each(lnk, &filep->f_cblist) {
                struct fcb_struct *fcbp = list_entry(lnk, struct fcb_struct,
lnk);

                if (fcbp->cbproc == cbproc) {
                        list_del(lnk);
                        kfree(fcbp);
                        error = 0;
                        break;
                }
        }
        fcblist_write_unlock(filep, flags);
        return error;
}

void file_notify_cleanup(struct file *filep)
{
        unsigned long flags;
        struct list_head *lnk;

        fcblist_write_lock(filep, flags);
        while ((lnk = list_first(&filep->f_cblist))) {
                struct fcb_struct *fcbp = list_entry(lnk, struct fcb_struct,
lnk);

                list_del(lnk);
                kfree(fcbp);
        }
        fcblist_write_unlock(filep, flags);
}

The callbacks will receive a 'long *' whose first element is one of the
ION_* events while the nexts could store additionals params whose meaning
will vary depending on the first one.
This interface is a draft and I used it only to verify if the transport method
is "enough" efficent to work on.
At the current stage notifications has been plugged only inside the socket
files by adding :

****** include/net/sock.h

static inline void sk_wake_async(struct sock *sk, int how, int band)
{
        if (sk->socket) {
                if (sk->socket->file) {
                        extern long ion_band_table[];
                        extern long band_table[];
                        long event[] = { ion_band_table[band - POLL_IN],
band_table[band - POLL_IN], -1 };

                        file_notify_event(sk->socket->file, event);
                }
                if (sk->socket->fasync_list)
                        sock_wake_async(sk->socket, how, band);
        }
}

Even if it has been hooked only to network sockets it should not be a problem
to expand it to other files types.
The /dev/poll implementation resides in two new files driver/char/devpoll.c
and the include/linux/devpoll.h include file.
The interface of the new /dev/poll is quite different from the previous one
coz it works only by mmapping the devide file descriptor while the
copy-data-to-user-space has been discarded for efficiency reasons.
The initialization sequence is :

        if ((kdpfd = open("/dev/poll", O_RDWR)) == -1) {

        }
        if (ioctl(kdpfd, DP_ALLOC, maxfds))
        {

        }
        if ((map = (char *) mmap(NULL, DP_MAP_SIZE(maxfds), PROT_READ |
PROT_WRITE,
                        MAP_PRIVATE, kdpfd, 0)) == (char *) -1)
        {

        }

where  maxfds  is the maximum number of file descriptors that it's supposed
to stock inside the polling device.
Files are added to the interest set by :

        struct pollfd pfd;

        pfd.fd = fd;
        pfd.events = POLLIN | POLLOUT | POLLERR | POLLHUP;
        pfd.revents = 0;
        if (write(kdpfd, &pfd, sizeof(pfd)) != sizeof(pfd)) {
                ...
        }

and removed with :

        struct pollfd pfd;

        pfd.fd = fd;
        pfd.events = POLLREMOVE;
        pfd.revents = 0;
        if (write(kdpfd, &pfd, sizeof(pfd)) != sizeof(pfd)) {
                ...
        }

The core dispatching code looks like :

        struct pollfd *pfds;
        struct dvpoll dvp;

        for (;;) {
                dvp.dp_timeout = STD_SCHED_TIMEOUT;
                dvp.dp_resoff = 0;

                nfds = ioctl(kdpfd, DP_POLL, &dvp);
                pfds = (struct pollfd *) (map + dvp.dp_resoff);
                for (ii = 0; ii < nfds; ii++, pfds++) {
                        ...
                }
        }

Basically the driver allocates two sets of pages that it uses as a double buffer
to store files events.
The field  dp_resoff  will tell where, inside the map, the result set resides
so, while working on one set, the kernel can use the other one to store incoming
events.
There is no copy to userspace issues, events coming from the same file are
collapsed into a single slot and the DT_POLL function will never do a linear
scan of the interest set to perform a file->f_ops->poll().



                      The /dev/poll patch from Provos-Lever

There's very few things to say about this, only that a virt_to_page() bug has
been fixed to make the patch work.
I modified a patch for 2.4.3 that I found at the CITI web site and this should
be the port to 2.4.x of the original ( 2.2.x ) one used by Provos-Lever.
Niels, Charles, is it true ?



                               The HTTP server

The HTTP server is very simple(tm) and is based on event polling + coroutines
that make the server quite efficent.
The coroutine library implementation has been taken from :

http://lecker.essen.de/~froese/coro/

It's very small, simple and fast.
Again, it's very simple ( the server ) and emits always the same HTTP response
whose size can be programmed by a command line parameter.
Other two command line options enable You to set the listening port and the fd
set size.



                            The deadconn(tm) tool

If the server is simple this is even simpler and its purpose is to create
"dead" connections to the server to simulate a realistic load where a bunch of
slow links are connected.



                                  The test

The test machine is a PIII 600MHz, 128 Mb RAM, eepro100 network card connected
to a 100Mbps fast ethernet switch. The kernel is 2.4.6 over a RH 6.2 and the
coroutine library version is 1.1.0-pre2.
I used a dual PIII 1GHz, 256 Mb RAM and dual eepro100 as httperf machine, while
a dual PIII 900 MHz, 256 Mb RAM and dual eepro100 has been used as deadconn(tm)
machine.
Since httperf when used with an high number of num-conns goes very quickly to
fill the fds space ( modified to 8000 ) I used this command line :

--think-timeout 5 --timeout 5 --num-calls 2500 --num-conns 100 --hog --rate 100

This basically allocates 100 connections that will load the server under
different values of dead connections.
The other parameter I varied is the response size from 128, 512 and 1024.
Each of these numbers is the average of three runs.


[respsize=128]

        poll()

dead    resp     std
conns   rate     dev

0       22510    600
1000    14800    603
2000    10800    400
4000    7200     180

   old /dev/poll

dead    resp     std
conns   rate     dev

0       23500    500
1000    16000    800
2000    12600    500
4000    8900     350

   new /dev/poll

dead    resp     std
conns   rate     dev

0       27000    10
1000    26500    0
2000    26700    10
4000    26200    0


[respsize=512]

        poll()

dead    resp     std
conns   rate     dev

0       18000    200
1000    14800    650
2000    10900    390
4000    7200     200

   old /dev/poll

dead    resp     std
conns   rate     dev

0       18000    150
1000    15500    530
2000    12500    500
4000    8800     390

   new /dev/poll

dead    resp     std
conns   rate     dev

0       18200    40
1000    18200    30
2000    18150    60
4000    18140    60


[respsize=1024]

        poll()

dead    resp     std
conns   rate     dev

0       10300    70
1000    10000    300
2000    8400     1500
4000    7000     240

   old /dev/poll

dead    resp     std
conns   rate     dev

0       10400    40
1000    10150    350
2000    9600     720
4000    8500     300

   new /dev/poll

dead    resp     std
conns   rate     dev

0       10900    15
1000    10800    10
2000    10680    10
4000    10600    15


These numbers show that the new /dev/poll improve the efficency of the server
from a response rate point of view and from a CPU utilization point of view
( not shown here ).
I've not all the data for 7800 dead connections but a comparison between two
runs shown even more dramatic differences.
The standard deviation is also very low compared to poll() and old /dev/poll
and this let me think that 1) there's more power to be extracted 2) the method
has a predictable response over high loads.
Attached to this message You'll find the new /dev/poll patch, the modified old
/dev/poll patch, the HTTP server and the deadconn tool.
The coroutine library is here :

http://lecker.essen.de/~froese/coro/

and httperf is here :

http://www.hpl.hp.com/personal/David_Mosberger/httperf.html

The patch is not in final version coz I'm still working on it.
To use the /dev/poll interface You've to mknod such name with major=10
and minor=125.





- Davide


--_=XFMail.1.4.7.Linux:20010710215331:705=_
Content-Disposition: attachment; filename="olddp_patch-0.1.diff"
Content-Transfer-Encoding: 7bit
Content-Description: olddp_patch-0.1.diff
Content-Type: text/plain;
 charset=us-ascii; name=olddp_patch-0.1.diff; SizeOnDisk=32729

diff -NBbru linux-2.4.6.vanilla/Makefile linux-2.4.6.olddp/Makefile
--- linux-2.4.6.vanilla/Makefile	Wed Jul  4 10:44:28 2001
+++ linux-2.4.6.olddp/Makefile	Sun Jul  8 17:31:35 2001
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 6
-EXTRAVERSION =
+EXTRAVERSION = olddp
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
diff -NBbru linux-2.4.6.vanilla/drivers/char/Config.in linux-2.4.6.olddp/drivers
/char/Config.in
--- linux-2.4.6.vanilla/drivers/char/Config.in	Wed Jul  4 10:44:34 2001
+++ linux-2.4.6.olddp/drivers/char/Config.in	Sun Jul  8 17:29:02 2001
@@ -158,6 +158,7 @@
 
 dep_tristate 'Intel i8x0 Random Number Generator support' CONFIG_INTEL_RNG $CON
FIG_PCI
 tristate '/dev/nvram support' CONFIG_NVRAM
+tristate '/dev/poll support' CONFIG_DEVPOLL
 tristate 'Enhanced Real Time Clock Support' CONFIG_RTC
 if [ "$CONFIG_IA64" = "y" ]; then
    bool 'EFI Real Time Clock Services' CONFIG_EFI_RTC
diff -NBbru linux-2.4.6.vanilla/drivers/char/Makefile linux-2.4.6.olddp/drivers/
char/Makefile
--- linux-2.4.6.vanilla/drivers/char/Makefile	Wed May 16 10:27:02 2001
+++ linux-2.4.6.olddp/drivers/char/Makefile	Sun Jul  8 17:29:02 2001
@@ -191,6 +191,7 @@
 obj-$(CONFIG_H8) += h8.o
 obj-$(CONFIG_PPDEV) += ppdev.o
 obj-$(CONFIG_DZ) += dz.o
+obj-$(CONFIG_DEVPOLL) += devpoll.o
 obj-$(CONFIG_NWBUTTON) += nwbutton.o
 obj-$(CONFIG_NWFLASH) += nwflash.o
 
diff -NBbru linux-2.4.6.vanilla/drivers/char/devpoll.c linux-2.4.6.olddp/drivers
/char/devpoll.c
--- linux-2.4.6.vanilla/drivers/char/devpoll.c	Wed Dec 31 16:00:00 1969
+++ linux-2.4.6.olddp/drivers/char/devpoll.c	Sun Jul  8 19:04:13 2001
@@ -0,0 +1,742 @@
+/*
+ * /dev/poll
+ * by Niels Provos <provos@citi.umich.edu>
+ *
+ * provides poll() support via /dev/poll as in Solaris.
+ *
+ * Linux 2.3/2.4 port by Michal Ostrowski
+ *
+ * 10-apr-2001
+ * s/MAP_NR/virt_to_page/g - Kevin D. Clark (kdc@alumni.unh.edu)
+ *
+ * July-08-2001 - Davide Libenzi <davidel@xmailserver.org>
+ * <> wrong fix coz virt_to_page() return a page * not an index inside mem_map[
]
+ * <> fixed locking logic
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/file.h>
+#include <linux/signal.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/malloc.h>
+#include <linux/vmalloc.h>
+#include <linux/poll.h>
+#include <linux/miscdevice.h>
+#include <linux/random.h>
+#include <linux/smp_lock.h>
+#include <linux/wrapper.h>
+
+#include <linux/devpoll.h>
+
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/io.h>
+
+/*#define DEBUG 1 */
+#ifdef DEBUG
+#define DPRINTK(x)	printk x
+#define DNPRINTK(n,x)	if (n <= DEBUG) printk x
+#else
+#define DPRINTK(x)
+#define DNPRINTK(n,x)
+#endif
+
+/* Various utility functions */
+
+#define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)
+
+/* Do dynamic hashing */
+
+#define INITIAL_BUCKET_BITS 13
+#define MAX_BUCKET_BITS 16
+#define RESIZE_LENGTH	2
+
+
+static void free_pg_vec(struct devpoll *dp);
+
+
+/* Initalize the hash table */
+
+int
+dp_init(struct devpoll *dp)
+{
+	int i;
+	int num_buckets;
+	DNPRINTK(3,(KERN_INFO "/dev/poll: dp_init\n"));
+
+	dp->dp_lock = RW_LOCK_UNLOCKED;
+	dp->dp_entries = 0;
+	dp->dp_max = 0;
+	dp->dp_avg = dp->dp_count = 0;
+	dp->dp_cached = dp->dp_calls = 0;
+	dp->dp_bucket_bits = INITIAL_BUCKET_BITS;
+	dp->dp_bucket_mask = (1 << INITIAL_BUCKET_BITS) - 1;
+
+	num_buckets = (dp->dp_bucket_mask + 1);
+	dp->dp_tab = kmalloc(num_buckets * sizeof(struct list_head),
+			     GFP_KERNEL);
+
+	if (!dp->dp_tab)
+		return -ENOMEM;
+
+	for (i = 0; i < num_buckets ; i++) {
+		INIT_LIST_HEAD(&dp->dp_tab[i]);
+	}
+
+	return (0);
+}
+
+int
+dp_resize(struct devpoll *dp)
+{
+	u_int16_t new_mask, old_mask;
+	int i;
+	struct list_head *new_tab, *old_tab;
+	struct dp_fd *dpfd;
+	int num_buckets;
+
+	old_mask = dp->dp_bucket_mask;
+	new_mask = (old_mask + 1) * 2 - 1;
+	num_buckets = new_mask + 1;
+
+	DPRINTK((KERN_INFO "/dev/poll: resize %d -> %d\n",
+		 old_mask, new_mask));
+
+	new_tab = kmalloc( num_buckets * sizeof(struct list_head), GFP_KERNEL);
+	if (!new_tab)
+		return -ENOMEM;
+
+	for (i = 0; i < num_buckets; i++) {
+		INIT_LIST_HEAD(&new_tab[i]);
+	}
+
+	old_tab = dp->dp_tab;
+
+	/* Rehash all entries */
+	for (i = 0; i <= old_mask; i++) {
+		while(!list_empty(&old_tab[i])){
+			dpfd = list_entry(old_tab[i].next, struct dp_fd, next);
+			list_del(&dpfd->next);
+			list_add(&dpfd->next, &new_tab[dpfd->pfd.fd & new_mask]);
+		}
+	}
+
+	dp->dp_tab = new_tab;
+	dp->dp_bucket_bits++;
+	dp->dp_bucket_mask = new_mask;
+
+	kfree (old_tab);
+
+	return (0);
+}
+
+int
+dp_insert(struct devpoll *dp, struct pollfd *pfd)
+{
+	struct dp_fd *dpfd;
+	u_int16_t bucket;
+	unsigned long flags;
+	struct file *file;
+
+	dpfd = kmalloc(sizeof(struct dp_fd), GFP_KERNEL);
+	if (!dpfd)
+		return -ENOMEM;
+
+	dpfd->flags = 0;
+	set_bit(DPH_DIRTY, &dpfd->flags);
+	dpfd->pfd = *pfd;
+	dpfd->pfd.revents = 0;
+	INIT_LIST_HEAD(&dpfd->next);
+
+	write_lock_irqsave(&dp->dp_lock, flags);
+
+	bucket = pfd->fd & dp->dp_bucket_mask;
+	list_add(&dpfd->next,&dp->dp_tab[bucket]);
+
+	file = fcheck(pfd->fd);
+	if (file != NULL) {
+		write_lock(&(file)->f_dplock);
+		poll_backmap(pfd->fd, dpfd, &(file)->f_backmap);
+		write_unlock(&(file)->f_dplock);
+		set_bit(DPH_BACKMAP, &(dpfd)->flags);
+	}
+	dp->dp_entries++;
+	/* Check if we need to resize the hash table */
+	if ((dp->dp_entries >> dp->dp_bucket_bits) > RESIZE_LENGTH &&
+	    dp->dp_bucket_bits < MAX_BUCKET_BITS)
+		dp_resize(dp);
+
+	write_unlock_irqrestore(&dp->dp_lock, flags);
+
+	return (0);
+}
+
+struct dp_fd *
+dp_find(struct devpoll *dp, int fd)
+{
+	struct dp_fd *dpfd=NULL;
+	struct list_head *lh;
+	u_int16_t bucket = fd & dp->dp_bucket_mask;
+
+	read_lock(&dp->dp_lock);
+	list_for_each(lh,&dp->dp_tab[bucket]){
+		dpfd = list_entry(lh,struct dp_fd,next);
+		if(dpfd->pfd.fd == fd ) break;
+		dpfd = NULL;
+	}
+
+
+	read_unlock(&dp->dp_lock);
+	DNPRINTK(2, (KERN_INFO "dp_find: %d -> %p\n", fd, dpfd));
+
+	return dpfd;
+}
+
+void
+dp_delete(struct devpoll *dp, struct dp_fd *dpfd)
+{
+	unsigned long flags;
+	int fd;
+	struct file *filp;
+
+	write_lock_irqsave(&dp->dp_lock, flags);
+	list_del(&dpfd->next);
+
+	INIT_LIST_HEAD(&dpfd->next);
+
+	/* Remove backmaps if necessary */
+	if (current->files) {
+		fd = dpfd->pfd.fd;
+		filp = fcheck(fd);
+
+		if (test_bit(DPH_BACKMAP, &dpfd->flags) &&
+		    filp && filp->f_backmap){
+			write_lock(&filp->f_dplock);
+			poll_remove_backmap(&filp->f_backmap, fd,
+					    current->files);
+			write_unlock(&filp->f_dplock);
+		}
+	}
+	write_unlock_irqrestore(&dp->dp_lock, flags);
+
+	kfree (dpfd);
+
+	dp->dp_entries--;
+}
+
+void
+dp_free(struct devpoll *dp)
+{
+	int i;
+	struct dp_fd *dpfd = NULL;
+
+	lock_kernel();
+	for (i = 0; i <= dp->dp_bucket_mask; i++) {
+		while(!list_empty(&dp->dp_tab[i])){
+			dpfd = list_entry(dp->dp_tab[i].next,struct dp_fd,next);
+			dp_delete(dp, dpfd);
+		}
+	}
+	unlock_kernel();
+
+	kfree (dp->dp_tab);
+}
+
+
+/*
+ * poll the fds that we keep in our state, return after we reached
+ * max changed fds or are done.
+ * XXX - I do not like how the wait table stuff is done.
+ */
+
+int
+dp_poll(struct devpoll *dp, int max, poll_table *wait,
+	long timeout, struct pollfd *rfds, int usemmap)
+{
+	int count = 0;
+	lock_kernel();
+	read_lock(&dp->dp_lock);
+	for (;;) {
+		unsigned int j=0;
+		struct dp_fd *dpfd = NULL;
+		struct pollfd *fdpnt, pfd;
+		struct file *file;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		for (j = 0; (j <= dp->dp_bucket_mask) && count < max; j++) {
+			struct list_head *lh;
+			list_for_each(lh, &dp->dp_tab[j]){
+
+				int fd;
+				unsigned int mask = 0;
+				unsigned int rm =0;
+				dpfd = list_entry(lh,struct dp_fd,next);
+
+				if(count>=max){
+					break;
+				}
+
+				fdpnt = &dpfd->pfd;
+				fd = fdpnt->fd;
+
+				/* poll_wait increments f_count if needed */
+				file = fcheck(fd);
+				if (file == NULL) {
+					/* Got to move backward first;
+					 * dp_delete will remove lh from
+					 * the list otherwise
+					 */
+					lh = lh->prev;
+					dp_delete(dp, dpfd);
+					dpfd = NULL;
+					continue;
+				}
+
+				mask = fdpnt->revents;
+				if (test_and_clear_bit(DPH_DIRTY,
+						       &dpfd->flags) ||
+				    wait != NULL ||
+				    (mask & fdpnt->events))  {
+
+					mask = DEFAULT_POLLMASK;
+					if (file->f_op && file->f_op->poll)
+						mask = file->f_op->poll(file, wait);
+					/* if POLLHINT not supported by file
+					 * then set bit to dirty ---
+					 * must poll this file every time,
+					 * otherwise bit will be set by
+					 * calls to dp_add_hint
+					 */
+					if (!(mask & POLLHINT))
+						set_bit(DPH_DIRTY, &dpfd->flags);
+					fdpnt->revents = mask;
+				}else
+					dp->dp_cached++;
+
+
+				dp->dp_calls++;
+
+				mask &= fdpnt->events | POLLERR | POLLHUP;
+				if (mask) {
+					wait = NULL;
+					count++;
+
+					if (usemmap) {
+						*rfds = *fdpnt;
+						rfds->revents = mask;
+					} else {
+						pfd = *fdpnt;
+						pfd.revents = mask;
+						__copy_to_user(rfds, &pfd,
+							       sizeof(struct pollfd));
+					}
+
+					rfds++;
+				}
+			}
+		}
+
+		wait = NULL;
+		if (count || !timeout || signal_pending(current))
+			break;
+		read_unlock(&dp->dp_lock);
+		timeout = schedule_timeout(timeout);
+		read_lock(&dp->dp_lock);
+	}
+	set_current_state(TASK_RUNNING);
+	read_unlock(&dp->dp_lock);
+	unlock_kernel();
+
+	if( !count && signal_pending(current) )
+		return -EINTR;
+
+	return count;
+}
+
+/*
+ * close a /dev/poll
+ */
+
+static int
+close_devpoll(struct inode * inode, struct file * file)
+{
+	struct devpoll *dp = file->private_data;
+
+	DNPRINTK(1, (KERN_INFO "close /dev/poll, max: %d, avg: %d(%d/%d) %d/%d\n",
+		     dp->dp_max, dp->dp_avg/dp->dp_count,
+		     dp->dp_avg, dp->dp_count,
+		     dp->dp_cached, dp->dp_calls));
+
+	/* free allocated memory */
+	if (dp->dp_memvec)
+		free_pg_vec(dp);
+
+	/* Free the hash table */
+	dp_free(dp);
+
+	kfree(dp);
+
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+/*
+ * open a /dev/poll
+ */
+
+static int
+open_devpoll(struct inode * inode, struct file * file)
+{
+	struct devpoll *dp;
+	int r;
+
+	/* allocated state */
+	dp = kmalloc(sizeof(struct devpoll), GFP_KERNEL);
+	if (dp == NULL)
+		return -ENOMEM;
+
+	memset( dp, 0, sizeof(struct devpoll));
+	if ((r = dp_init(dp))) {
+		kfree (dp);
+		return r;
+	}
+
+	file->private_data = dp;
+
+	MOD_INC_USE_COUNT;
+
+	DNPRINTK(3, (KERN_INFO "open /dev/poll\n"));
+
+	return 0;
+}
+
+/*
+ * write to /dev/poll:
+ * a user writes struct pollfds and we add them to our list, or remove
+ * them if (events & POLLREMOVE) is true
+ */
+
+static int
+write_devpoll(struct file *file, const char *buffer, size_t count,
+	      loff_t *ppos)
+{
+	int r,rcount;
+	struct devpoll *dp = file->private_data;
+	struct pollfd pfd;
+	struct dp_fd *dpfd;
+#ifdef DEBUG
+	int add = 0, delete = 0, change = 0;
+#endif
+
+	DNPRINTK(3, (KERN_INFO "write /dev/poll %i\n",count));
+
+	if (count % sizeof(struct pollfd))
+		return -EINVAL;
+
+	if ((r = verify_area(VERIFY_READ, buffer, count)))
+		return r;
+
+	rcount = count;
+
+	lock_kernel();
+
+	while (count > 0) {
+		__copy_from_user(&pfd, buffer, sizeof(pfd)); /* no check */
+
+		dpfd = dp_find(dp, pfd.fd);
+
+		if (pfd.fd >= current->files->max_fds ||
+		    current->files->fd[pfd.fd] == NULL) {
+			/* Be tolerant, maybe the close happened already */
+			pfd.events = POLLREMOVE;
+		}
+		/* See if we need to remove the file descriptor.  If it
+		 * already exists OR the event fields, otherwise insert
+		 */
+		if (pfd.events & POLLREMOVE) {
+			if (dpfd)
+				dp_delete(dp, dpfd);
+#ifdef DEBUG
+			delete++;
+#endif
+		} else if (dpfd) {
+		  /* XXX dpfd->pfd.events |= pfd.events; */
+			dpfd->pfd.events = pfd.events;
+#ifdef DEBUG
+			change++;
+#endif
+		} else {
+			dp_insert(dp, &pfd);
+#ifdef DEBUG
+			add++;
+#endif
+		}
+
+		buffer += sizeof(pfd);
+		count -= sizeof(pfd);
+	}
+
+	unlock_kernel();
+
+	if (dp->dp_max < dp->dp_entries) {
+		dp->dp_max = dp->dp_entries;
+		DNPRINTK(2, (KERN_INFO "/dev/poll: new max %d\n", dp->dp_max));
+	}
+
+	DNPRINTK(3, (KERN_INFO "write /dev/poll: %d entries (%d/%d/%d)\n",
+		 dp->dp_entries, add, delete, change));
+
+	return (rcount);
+}
+
+static int
+ioctl_devpoll(struct inode *inode, struct file *file,
+	      unsigned int cmd, unsigned long arg)
+{
+	struct devpoll *dp = file->private_data;
+	unsigned mapsize=0;
+	unsigned num_pages=0;
+	int i=0;
+	switch (cmd) {
+	case DP_ALLOC:
+		if (dp->dp_mmap)
+			return -EPERM;
+
+		mapsize = DP_MMAP_SIZE(arg);
+
+		num_pages = ( PAGE_ALIGN(mapsize) >> PAGE_SHIFT);
+
+		dp->dp_memvec = kmalloc( num_pages * sizeof(unsigned long*),
+				 GFP_KERNEL);
+
+		if( dp->dp_memvec == NULL )
+			return -EINVAL;
+
+		memset(dp->dp_memvec, 0, num_pages * sizeof(unsigned long*));
+
+		for( i = 0 ; i < num_pages ; ++i){
+			dp->dp_memvec[i] = (u_char*)__get_free_pages(GFP_KERNEL,0);
+			if(!dp->dp_memvec[i]){
+				free_pg_vec(dp);
+				return -ENOMEM;
+			}
+			set_bit(PG_reserved, &virt_to_page(dp->dp_memvec[i])->flags);
+			++dp->dp_numvec;
+		}
+
+		dp->dp_nfds = arg;
+
+		DPRINTK((KERN_INFO "allocated %d pollfds\n", dp->dp_nfds));
+
+		return 0;
+	case DP_FREE:
+		if( atomic_read(&dp->dp_mmapped) ) 
+			return -EBUSY;
+		
+		if(dp->dp_memvec[i]){
+			free_pg_vec( dp );
+		}
+
+
+		DPRINTK((KERN_INFO "freed %d pollfds\n", dp->dp_nfds));
+		dp->dp_nfds = 0;
+
+		return 0;
+	case DP_ISPOLLED: {
+		struct pollfd pfd;
+		struct dp_fd *dpfd;
+
+		if (copy_from_user(&pfd, (void *)arg, sizeof(pfd)))
+			return -EFAULT;
+		dpfd = dp_find(dp, pfd.fd);
+		if (dpfd == NULL)
+			return (0);
+
+		/* We poll this fd, return the evens we poll on */
+		pfd.events = dpfd->pfd.events;
+		pfd.revents = 0;
+
+		if (copy_to_user((void *)arg, &pfd, sizeof(pfd)))
+			return -EFAULT;
+		return (1);
+	}
+	case DP_POLL: {
+		struct dvpoll dopoll;
+		int nfds, usemmap = 0;
+		unsigned long timeout;
+		poll_table wait;
+		struct pollfd *rpfds = NULL;
+		
+		if (copy_from_user(&dopoll, (void *)arg, sizeof(dopoll)))
+			return -EFAULT;
+
+		/* We do not need to check this value, its user space */
+		nfds = dopoll.dp_nfds;
+		if (nfds <= 0)
+			return -EINVAL;
+
+		if (dopoll.dp_fds == NULL) {
+			if (dp->dp_mmap == NULL )
+				return -EINVAL;
+			rpfds = (struct pollfd*)dp->dp_mmap;
+			usemmap = 1;
+		} else {
+			rpfds = dopoll.dp_fds;
+			if (verify_area(VERIFY_WRITE, rpfds,
+					nfds * sizeof(struct pollfd)))
+				return -EFAULT;
+			usemmap = 0;
+		}
+
+		timeout = dopoll.dp_timeout;
+		if (timeout) {
+			/* Careful about overflow in the intermediate values */
+			if ((unsigned long)timeout < MAX_SCHEDULE_TIMEOUT / HZ)
+				timeout = (timeout*HZ+999)/1000+1;
+			else /* Negative or overflow */
+				timeout = MAX_SCHEDULE_TIMEOUT;
+		}
+
+		/* Initalize wait table */
+		poll_initwait(&wait);
+
+
+
+		nfds = dp_poll(dp, nfds, &wait, timeout, rpfds, usemmap);
+
+		DNPRINTK(2, (KERN_INFO "poll time %ld -> %d\n", timeout, nfds));
+
+
+		poll_freewait(&wait);
+
+		dp->dp_avg += dp->dp_entries;
+		dp->dp_count++;
+
+		return nfds;
+	}
+	default:
+		DPRINTK((KERN_INFO "ioctl(%x) /dev/poll\n", cmd));
+		break;
+	}
+
+	return -EINVAL;
+}
+
+
+static void free_pg_vec(struct devpoll *dp)
+{
+	int i;
+
+	for (i=0; i< dp->dp_numvec; i++) {
+		if (dp->dp_memvec[i]) {
+			clear_bit(PG_reserved, &virt_to_page(dp->dp_memvec[i])->flags);
+			free_pages( (unsigned)dp->dp_memvec[i], 0);
+		}
+	}
+	kfree(dp->dp_memvec);
+	dp->dp_numvec = 0 ;
+}
+
+
+static void devpoll_mm_open( struct vm_area_struct * vma){
+	struct file *file = vma->vm_file;
+	struct devpoll *dp = file->private_data;
+	if(dp)
+		atomic_inc(&dp->dp_mmapped);
+}
+
+static void devpoll_mm_close( struct vm_area_struct * vma){
+	struct file *file = vma->vm_file;
+	struct devpoll *dp = file->private_data;
+	if(dp)
+		atomic_dec(&dp->dp_mmapped);
+}
+
+static struct vm_operations_struct devpoll_mmap_ops = {
+	open:	devpoll_mm_open,
+	close:	devpoll_mm_close,
+};
+
+/*
+ * mmap shared memory.  the first half is an array  of struct pollfd,
+ * followed by an array of ints to indicate which file descriptors
+ * changed status.
+ */
+
+static int
+mmap_devpoll(struct file *file, struct vm_area_struct *vma)
+{
+	struct devpoll *dp = file->private_data;
+	unsigned long start; /* Evil type to remap_page_range */
+	int  i=0;
+	int num_pages = 0;
+	size_t size, mapsize;
+
+	DPRINTK((KERN_INFO "mmap /dev/poll: %lx %lx\n",
+		 vma->vm_start, vma->vm_pgoff<<PAGE_SHIFT));
+
+	if ( (vma->vm_pgoff<<PAGE_SHIFT) != 0)
+		return -EINVAL;
+
+	/* Calculate how much memory we can map */
+	size = PAGE_ALIGN(DP_MMAP_SIZE(dp->dp_nfds));
+	mapsize = PAGE_ALIGN(vma->vm_end - vma->vm_start);
+	num_pages = mapsize >> PAGE_SHIFT;
+
+	/* Check if the requested size is within our size */
+	if (mapsize > dp->dp_numvec<<PAGE_SHIFT)
+		return -EINVAL;
+		
+
+	start = vma->vm_start;
+	atomic_set(&dp->dp_mmapped,1);
+	for( i = 0 ; i < num_pages ; ++i){
+		if( remap_page_range(start, __pa(dp->dp_memvec[i]),
+				     PAGE_SIZE,
+				     vma->vm_page_prot) )
+			return -EINVAL;
+		start += PAGE_SIZE;
+	}
+	dp->dp_mmap = (u_char*)vma->vm_start;
+	vma->vm_ops = &devpoll_mmap_ops;
+
+	DPRINTK((KERN_INFO "mmap /dev/poll: %lx %x\n", page, mapsize));
+	return 0;
+}
+
+
+
+struct file_operations devpoll_fops = {
+	write:write_devpoll,
+	ioctl: ioctl_devpoll,
+	mmap: mmap_devpoll,
+	open: open_devpoll,
+	release:close_devpoll
+};
+
+static struct miscdevice devpoll = {
+	DEVPOLL_MINOR, "devpoll", &devpoll_fops
+};
+
+int __init devpoll_init(void)
+{
+  printk(KERN_INFO "/dev/poll driver installed.\n");
+  misc_register(&devpoll);
+
+
+  return 0;
+}
+
+module_init(devpoll_init);
+#ifdef MODULE
+
+void cleanup_module(void)
+{
+	misc_deregister(&devpoll);
+}
+#endif
diff -NBbru linux-2.4.6.vanilla/fs/file_table.c linux-2.4.6.olddp/fs/file_table.
c
--- linux-2.4.6.vanilla/fs/file_table.c	Wed Apr 18 11:49:12 2001
+++ linux-2.4.6.olddp/fs/file_table.c	Sun Jul  8 17:29:02 2001
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
+#include <linux/spinlock.h>
 
 /* sysctl tunables... */
 struct files_stat_struct files_stat = {0, 0, NR_FILE};
diff -NBbru linux-2.4.6.vanilla/fs/open.c linux-2.4.6.olddp/fs/open.c
--- linux-2.4.6.vanilla/fs/open.c	Fri Feb  9 11:29:44 2001
+++ linux-2.4.6.olddp/fs/open.c	Sun Jul  8 17:29:02 2001
@@ -16,6 +16,8 @@
 #include <linux/tty.h>
 
 #include <asm/uaccess.h>
+#include <linux/poll.h>
+#include <linux/devpoll.h>
 
 #define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
 
diff -NBbru linux-2.4.6.vanilla/include/asm-i386/devpoll.h linux-2.4.6.olddp/inc
lude/asm-i386/devpoll.h
--- linux-2.4.6.vanilla/include/asm-i386/devpoll.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.6.olddp/include/asm-i386/devpoll.h	Sun Jul  8 17:29:02 2001
@@ -0,0 +1,87 @@
+/*
+ *
+ * /dev/poll
+ * by Niels Provos <provos@citi.umich.edu>
+ *
+ * Linux 2.3/2.4 port by Michal Ostrowski
+ */
+
+#ifndef _LINUX_DEVPOLL_H
+#define _LINUX_DEVPOLL_H
+
+#include <asm/bitops.h>
+#include <linux/list.h>
+#include <asm/atomic.h>
+
+#define DPH_DIRTY	0	/* entry is dirty - bit */
+#define DPH_BACKMAP	1	/* file has an fd back map - bit*/
+#ifdef __KERNEL__
+struct dp_fd {
+	struct list_head next;
+	struct pollfd pfd;
+	int flags;		/* for hinting */
+};
+
+
+struct devpoll {
+	struct list_head *dp_tab;
+	int dp_entries;		/* Entries in hash table */
+	int dp_max;		/* statistics */
+	int dp_avg;		/* more */
+	int dp_count;
+	int dp_cached;
+	int dp_calls;
+	int dp_bucket_bits;
+	int dp_bucket_mask;
+	int dp_nfds;		/* Number of poll fds */
+	u_char*  dp_mmap;	/* vaddr of mapped region */
+	atomic_t dp_mmapped;		/* Are we mmapped */
+	rwlock_t dp_lock;
+	u_char** dp_memvec;	/* Pointer to pages allocated for mmap */
+	int dp_numvec;		/* Size of above array */
+};
+#endif
+/* Match solaris */
+
+struct dvpoll {
+	struct pollfd * dp_fds;	/* Leave this ZERO for mmap */
+	int dp_nfds;
+	int dp_timeout;
+};
+	
+
+#define DEVPOLL_MINOR       125   /* Minor device # for /dev/poll */
+
+
+#define DP_MMAP_SIZE(x)	((x) * sizeof(struct pollfd))
+
+#define DP_ALLOC	_IOR('P', 1, int)
+#define DP_POLL		_IOWR('P', 2, struct dvpoll)
+#define DP_FREE		_IO('P', 3)
+#define DP_ISPOLLED	_IOWR('P', 4, struct pollfd)
+
+#ifdef __KERNEL__
+extern rwlock_t devpoll_lock;
+/* Function Prototypes */
+
+extern inline void
+dp_add_hint(struct poll_backmap ** map, rwlock_t *lock)
+{
+	struct poll_backmap *entry;
+	struct dp_fd *dpfd;
+	if (!map)
+		return;
+	
+	read_lock(lock);
+	entry = *map;
+	while (entry) {
+		dpfd = entry->arg;
+		set_bit(DPH_DIRTY, &dpfd->flags);	/* atomic */
+		entry = entry->next;
+	}
+	read_unlock(lock);
+}
+#endif /* __KERNEL__ */
+
+#endif
+
diff -NBbru linux-2.4.6.vanilla/include/asm-i386/poll.h linux-2.4.6.olddp/includ
e/asm-i386/poll.h
--- linux-2.4.6.vanilla/include/asm-i386/poll.h	Thu Jan 23 11:01:28 1997
+++ linux-2.4.6.olddp/include/asm-i386/poll.h	Sun Jul  8 17:29:02 2001
@@ -15,6 +15,8 @@
 #define POLLWRNORM	0x0100
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
+#define POLLREMOVE	0x1000
+#define POLLHINT	0x2000
 
 struct pollfd {
 	int fd;
diff -NBbru linux-2.4.6.vanilla/include/linux/dcache.h linux-2.4.6.olddp/include
/linux/dcache.h
--- linux-2.4.6.vanilla/include/linux/dcache.h	Wed Jul  4 10:44:54 2001
+++ linux-2.4.6.olddp/include/linux/dcache.h	Sun Jul  8 17:41:19 2001
@@ -5,7 +5,7 @@
 
 #include <asm/atomic.h>
 #include <linux/mount.h>
-
+#include <asm/system.h>
 /*
  * linux/include/linux/dcache.h
  *
diff -NBbru linux-2.4.6.vanilla/include/linux/devpoll.h linux-2.4.6.olddp/includ
e/linux/devpoll.h
--- linux-2.4.6.vanilla/include/linux/devpoll.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.6.olddp/include/linux/devpoll.h	Sun Jul  8 17:42:19 2001
@@ -0,0 +1,87 @@
+/*
+ *
+ * /dev/poll
+ * by Niels Provos <provos@citi.umich.edu>
+ *
+ * Linux 2.3/2.4 port by Michal Ostrowski
+ */
+
+#ifndef _LINUX_DEVPOLL_H
+#define _LINUX_DEVPOLL_H
+
+#include <asm/bitops.h>
+#include <linux/list.h>
+#include <asm/atomic.h>
+
+#define DPH_DIRTY	0	/* entry is dirty - bit */
+#define DPH_BACKMAP	1	/* file has an fd back map - bit*/
+#ifdef __KERNEL__
+struct dp_fd {
+	struct list_head next;
+	struct pollfd pfd;
+	int flags;		/* for hinting */
+};
+
+
+struct devpoll {
+	struct list_head *dp_tab;
+	int dp_entries;		/* Entries in hash table */
+	int dp_max;		/* statistics */
+	int dp_avg;		/* more */
+	int dp_count;
+	int dp_cached;
+	int dp_calls;
+	int dp_bucket_bits;
+	int dp_bucket_mask;
+	int dp_nfds;		/* Number of poll fds */
+	u_char*  dp_mmap;	/* vaddr of mapped region */
+	atomic_t dp_mmapped;		/* Are we mmapped */
+	rwlock_t dp_lock;
+	u_char** dp_memvec;	/* Pointer to pages allocated for mmap */
+	int dp_numvec;		/* Size of above array */
+};
+#endif
+/* Match solaris */
+
+struct dvpoll {
+	struct pollfd * dp_fds;	/* Leave this ZERO for mmap */
+	int dp_nfds;
+	int dp_timeout;
+};
+	
+
+#define DEVPOLL_MINOR       125   /* Minor device # for /dev/poll */
+
+
+#define DP_MMAP_SIZE(x)	((x) * sizeof(struct pollfd))
+
+#define DP_ALLOC	_IOR('P', 1, int)
+#define DP_POLL		_IOWR('P', 2, struct dvpoll)
+#define DP_FREE		_IO('P', 3)
+#define DP_ISPOLLED	_IOWR('P', 4, struct pollfd)
+
+#ifdef __KERNEL__
+extern rwlock_t devpoll_lock;
+/* Function Prototypes */
+
+extern inline void
+dp_add_hint(struct poll_backmap ** map, rwlock_t *lock)
+{
+	struct poll_backmap *entry;
+	struct dp_fd *dpfd;
+	if (!map)
+		return;
+	
+	read_lock(lock);
+	entry = *map;
+	while (entry) {
+		dpfd = entry->arg;
+		set_bit(DPH_DIRTY, &dpfd->flags);	/* atomic */
+		entry = entry->next;
+	}
+	read_unlock(lock);
+}
+#endif /* __KERNEL__ */
+
+#endif
+
diff -NBbru linux-2.4.6.vanilla/include/linux/fs.h linux-2.4.6.olddp/include/lin
ux/fs.h
--- linux-2.4.6.vanilla/include/linux/fs.h	Wed Jul  4 10:44:54 2001
+++ linux-2.4.6.olddp/include/linux/fs.h	Sun Jul  8 17:41:19 2001
@@ -510,6 +510,10 @@
 
 	unsigned long		f_version;
 
+	/* used by /dev/poll hinting */
+	struct poll_backmap	*f_backmap;
+	rwlock_t		f_dplock;
+
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
 };
diff -NBbru linux-2.4.6.vanilla/include/linux/poll.h linux-2.4.6.olddp/include/l
inux/poll.h
--- linux-2.4.6.vanilla/include/linux/poll.h	Fri May 25 18:01:43 2001
+++ linux-2.4.6.olddp/include/linux/poll.h	Sun Jul  8 17:41:33 2001
@@ -8,10 +8,18 @@
 #include <linux/wait.h>
 #include <linux/string.h>
 #include <linux/mm.h>
+#include <linux/malloc.h>
 #include <asm/uaccess.h>
 
 struct poll_table_page;
 
+struct poll_backmap {
+	struct poll_backmap *next;
+	void *arg;			/* pointer to devpoll */
+	struct files_struct *files;	/* files which has this file as */
+	int fd;				/* file descriptor number fd */
+};
+
 typedef struct poll_table_struct {
 	int error;
 	struct poll_table_page * table;
@@ -83,7 +91,89 @@
 	memset(fdset, 0, FDS_BYTES(nr));
 }
 
+extern inline void
+poll_backmap(int fd, void *arg, struct poll_backmap ** entry)
+{
+	struct poll_backmap *tmp;
+
+	if (!entry)
+		return;
+
+	/*
+	 * See if we have an entry in the backmap already, in general
+	 * we expect this linked list to be very short.
+	 */
+	tmp = *entry;
+	while (tmp != NULL) {
+		if (tmp->files == current->files && tmp->fd == fd && 
+		    arg==tmp->arg)
+			return;
+		tmp = tmp->next;
+	}
+
+	tmp = (struct poll_backmap *) kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (tmp == NULL)
+		return;
+
+	tmp->arg = arg;
+	tmp->files = current->files;
+	tmp->fd = fd;
+	tmp->next = *entry;
+
+	*entry = tmp;
+}
+
+extern inline void poll_remove_backmap(struct poll_backmap **map, int fd,
+				       struct files_struct *files)
+{
+	struct poll_backmap *tmp = *map, *old = NULL;
+	
+	while (tmp != NULL) {
+		if (tmp->files == files && tmp->fd == fd){
+			struct poll_backmap *next = tmp->next;
+			if( old==NULL )
+				*map = next;
+			else
+				old->next = next;
+			kfree(tmp);
+			tmp = next;
+		}else{
+			old = tmp;
+			tmp = tmp->next;
+		}
+	}
+	
+	if (!tmp)
+		return;
+	
+	if (old == NULL)
+		*map = tmp->next;
+	else 
+		old->next = tmp->next;
+
+	kfree (tmp);
+}
+
+extern inline void poll_clean_backmap(struct poll_backmap **map)
+{
+	struct poll_backmap *tmp = *map, *old;
+
+	printk("poll_clean_backmap: map %p\n", map);
+	printk("poll_clean_backmap: *map %p\n", *map);
+
+	while (tmp) {
+	  printk("poll_clean_backmap: tmp %p\n", tmp);
+		old = tmp;
+		tmp = tmp->next;
+		kfree (old);
+	}
+
+	*map = NULL;
+}
+
 extern int do_select(int n, fd_set_bits *fds, long *timeout);
+extern void poll_freewait(poll_table *p);
+
 
 #endif /* KERNEL */
 
diff -NBbru linux-2.4.6.vanilla/include/linux/spinlock.h linux-2.4.6.olddp/inclu
de/linux/spinlock.h
--- linux-2.4.6.vanilla/include/linux/spinlock.h	Fri May 25 18:01:27 2001
+++ linux-2.4.6.olddp/include/linux/spinlock.h	Sun Jul  8 17:41:19 2001
@@ -123,7 +123,7 @@
 #define read_unlock(lock)	do { } while(0)
 #define write_lock(lock)	(void)(lock) /* Not "unused variable". */
 #define write_unlock(lock)	do { } while(0)
-
+#define rwlock_init(lock)	do { } while(0)
 #endif /* !SMP */
 
 /* "lock on reference count zero" */
diff -NBbru linux-2.4.6.vanilla/include/net/sock.h linux-2.4.6.olddp/include/net
/sock.h
--- linux-2.4.6.vanilla/include/net/sock.h	Fri May 25 18:03:05 2001
+++ linux-2.4.6.olddp/include/net/sock.h	Sun Jul  8 17:41:35 2001
@@ -666,6 +666,10 @@
 	/* Identd and reporting IO signals */
 	struct socket		*socket;
 
+	/* For Poll hinting */
+	void			*backmap;
+	void			*dplock;
+
 	/* RPC layer private data */
 	void			*user_data;
   
diff -NBbru linux-2.4.6.vanilla/lib/dec_and_lock.c linux-2.4.6.olddp/lib/dec_and
_lock.c
--- linux-2.4.6.vanilla/lib/dec_and_lock.c	Fri Jul  7 16:22:48 2000
+++ linux-2.4.6.olddp/lib/dec_and_lock.c	Sun Jul  8 17:29:02 2001
@@ -1,6 +1,6 @@
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
-
+#include <asm/system.h>
 /*
  * This is an architecture-neutral, but slow,
  * implementation of the notion of "decrement
diff -NBbru linux-2.4.6.vanilla/net/core/datagram.c linux-2.4.6.olddp/net/core/d
atagram.c
--- linux-2.4.6.vanilla/net/core/datagram.c	Thu Apr 12 12:11:39 2001
+++ linux-2.4.6.olddp/net/core/datagram.c	Sun Jul  8 17:29:02 2001
@@ -420,7 +420,10 @@
 	unsigned int mask;
 
 	poll_wait(file, sk->sleep, wait);
-	mask = 0;
+	sk->backmap = &file->f_backmap;
+	sk->dplock  = &file->f_dplock;
+
+	mask = POLLHINT;
 
 	/* exceptional events? */
 	if (sk->err || !skb_queue_empty(&sk->error_queue))
diff -NBbru linux-2.4.6.vanilla/net/core/sock.c linux-2.4.6.olddp/net/core/sock.
c
--- linux-2.4.6.vanilla/net/core/sock.c	Wed Jul  4 10:44:56 2001
+++ linux-2.4.6.olddp/net/core/sock.c	Sun Jul  8 17:29:02 2001
@@ -109,6 +109,7 @@
 #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/init.h>
+#include <linux/devpoll.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -1095,16 +1096,20 @@
 void sock_def_wakeup(struct sock *sk)
 {
 	read_lock(&sk->callback_lock);
-	if (sk->sleep && waitqueue_active(sk->sleep))
+	if (sk->sleep && waitqueue_active(sk->sleep)){
+		dp_add_hint(sk->backmap, sk->dplock);
 		wake_up_interruptible_all(sk->sleep);
+	}
 	read_unlock(&sk->callback_lock);
 }
 
 void sock_def_error_report(struct sock *sk)
 {
 	read_lock(&sk->callback_lock);
-	if (sk->sleep && waitqueue_active(sk->sleep))
+	if (sk->sleep && waitqueue_active(sk->sleep)){
+		dp_add_hint(sk->backmap, sk->dplock);
 		wake_up_interruptible(sk->sleep);
+	}
 	sk_wake_async(sk,0,POLL_ERR); 
 	read_unlock(&sk->callback_lock);
 }
@@ -1112,8 +1117,10 @@
 void sock_def_readable(struct sock *sk, int len)
 {
 	read_lock(&sk->callback_lock);
-	if (sk->sleep && waitqueue_active(sk->sleep))
+	if (sk->sleep && waitqueue_active(sk->sleep)){
+		dp_add_hint(sk->backmap, sk->dplock);
 		wake_up_interruptible(sk->sleep);
+	}
 	sk_wake_async(sk,1,POLL_IN);
 	read_unlock(&sk->callback_lock);
 }
@@ -1126,9 +1133,10 @@
 	 * progress.  --DaveM
 	 */
 	if((atomic_read(&sk->wmem_alloc) << 1) <= sk->sndbuf) {
-		if (sk->sleep && waitqueue_active(sk->sleep))
+		if (sk->sleep && waitqueue_active(sk->sleep)){
+			dp_add_hint(sk->backmap, sk->dplock);
 			wake_up_interruptible(sk->sleep);
-
+		}
 		/* Should agree with poll, otherwise some programs break */
 		if (sock_writeable(sk))
 			sk_wake_async(sk, 2, POLL_OUT);
@@ -1157,6 +1165,9 @@
 	sk->state 	= 	TCP_CLOSE;
 	sk->zapped	=	1;
 	sk->socket	=	sock;
+
+	sk->backmap	=	NULL;
+	sk->dplock	=	NULL;
 
 	if(sock)
 	{
diff -NBbru linux-2.4.6.vanilla/net/ipv4/af_inet.c linux-2.4.6.olddp/net/ipv4/af
_inet.c
--- linux-2.4.6.vanilla/net/ipv4/af_inet.c	Wed Jul  4 10:44:56 2001
+++ linux-2.4.6.olddp/net/ipv4/af_inet.c	Sun Jul  8 17:29:02 2001
@@ -460,6 +460,7 @@
 		if (sk->linger && !(current->flags & PF_EXITING))
 			timeout = sk->lingertime;
 		sock->sk = NULL;
+		sk->backmap = NULL;
 		sk->prot->close(sk, timeout);
 	}
 	return(0);
diff -NBbru linux-2.4.6.vanilla/net/ipv4/tcp.c linux-2.4.6.olddp/net/ipv4/tcp.c
--- linux-2.4.6.vanilla/net/ipv4/tcp.c	Wed May 16 10:31:27 2001
+++ linux-2.4.6.olddp/net/ipv4/tcp.c	Sun Jul  8 17:29:02 2001
@@ -249,6 +249,7 @@
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/poll.h>
+#include <linux/devpoll.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 
@@ -380,8 +381,11 @@
 	struct tcp_opt *tp = &(sk->tp_pinfo.af_tcp);
 
 	poll_wait(file, sk->sleep, wait);
+	sk->backmap = &file->f_backmap;
+	sk->dplock  = &file->f_dplock;
+
 	if (sk->state == TCP_LISTEN)
-		return tcp_listen_poll(sk, wait);
+		return tcp_listen_poll(sk, wait) | POLLHINT;
 
 	/* Socket is not locked. We are protected from async events
 	   by poll logic and correct handling of state changes
@@ -454,7 +458,7 @@
 		if (tp->urg_data & TCP_URG_VALID)
 			mask |= POLLPRI;
 	}
-	return mask;
+	return mask |POLLHINT;
 }
 
 /*
diff -NBbru linux-2.4.6.vanilla/net/unix/af_unix.c linux-2.4.6.olddp/net/unix/af
_unix.c
--- linux-2.4.6.vanilla/net/unix/af_unix.c	Wed Jul  4 10:44:56 2001
+++ linux-2.4.6.olddp/net/unix/af_unix.c	Sun Jul  8 17:29:02 2001
@@ -107,6 +107,7 @@
 #include <net/scm.h>
 #include <linux/init.h>
 #include <linux/poll.h>
+#include <linux/devpoll.h>
 #include <linux/smp_lock.h>
 
 #include <asm/checksum.h>
@@ -299,8 +300,10 @@
 {
 	read_lock(&sk->callback_lock);
 	if (unix_writable(sk)) {
-		if (sk->sleep && waitqueue_active(sk->sleep))
+		if (sk->sleep && waitqueue_active(sk->sleep)){
+			dp_add_hint(sk->backmap,sk->dplock);
 			wake_up_interruptible(sk->sleep);
+		}
 		sk_wake_async(sk, 2, POLL_OUT);
 	}
 	read_unlock(&sk->callback_lock);
@@ -1698,7 +1701,10 @@
 	unsigned int mask;
 
 	poll_wait(file, sk->sleep, wait);
-	mask = 0;
+	sk->backmap = &file->f_backmap;
+	sk->dplock  = &file->f_dplock;
+	mask = POLLHINT;
+	
 
 	/* exceptional events? */
 	if (sk->err)

--_=XFMail.1.4.7.Linux:20010710215331:705=_
Content-Disposition: attachment; filename="dp_patch-0.7.diff"
Content-Transfer-Encoding: 7bit
Content-Description: dp_patch-0.7.diff
Content-Type: text/plain;
 charset=us-ascii; name=dp_patch-0.7.diff; SizeOnDisk=27725

diff -NBbru linux-2.4.6.vanilla/Makefile linux-2.4.6/Makefile
--- linux-2.4.6.vanilla/Makefile	Wed Jul  4 10:44:28 2001
+++ linux-2.4.6/Makefile	Wed Jul  4 10:48:53 2001
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 6
-EXTRAVERSION =
+EXTRAVERSION = dp01
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
diff -NBbru linux-2.4.6.vanilla/drivers/char/Config.in linux-2.4.6/drivers/char/
Config.in
--- linux-2.4.6.vanilla/drivers/char/Config.in	Wed Jul  4 10:44:34 2001
+++ linux-2.4.6/drivers/char/Config.in	Wed Jul  4 10:45:58 2001
@@ -158,6 +158,7 @@
 
 dep_tristate 'Intel i8x0 Random Number Generator support' CONFIG_INTEL_RNG $CON
FIG_PCI
 tristate '/dev/nvram support' CONFIG_NVRAM
+tristate '/dev/poll support' CONFIG_DEVPOLL
 tristate 'Enhanced Real Time Clock Support' CONFIG_RTC
 if [ "$CONFIG_IA64" = "y" ]; then
    bool 'EFI Real Time Clock Services' CONFIG_EFI_RTC
diff -NBbru linux-2.4.6.vanilla/drivers/char/Makefile linux-2.4.6/drivers/char/M
akefile
--- linux-2.4.6.vanilla/drivers/char/Makefile	Wed May 16 10:27:02 2001
+++ linux-2.4.6/drivers/char/Makefile	Mon Jul  2 18:55:01 2001
@@ -173,6 +173,7 @@
 ifeq ($(CONFIG_PPC),)
   obj-$(CONFIG_NVRAM) += nvram.o
 endif
+obj-$(CONFIG_DEVPOLL) += devpoll.o
 obj-$(CONFIG_TOSHIBA) += toshiba.o
 obj-$(CONFIG_DS1620) += ds1620.o
 obj-$(CONFIG_INTEL_RNG) += i810_rng.o
diff -NBbru linux-2.4.6.vanilla/drivers/char/devpoll.c linux-2.4.6/drivers/char/
devpoll.c
--- linux-2.4.6.vanilla/drivers/char/devpoll.c	Wed Dec 31 16:00:00 1969
+++ linux-2.4.6/drivers/char/devpoll.c	Mon Jul  9 19:20:39 2001
@@ -0,0 +1,732 @@
+/*
+ *
+ * /dev/poll support
+ * by Davide Libenzi <davidel@xmailserver.org>
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
+#include <linux/malloc.h>
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
+#include <asm/bitops.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/atomic.h>
+
+#include <linux/devpoll.h>
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
+#define MAX_HASH_BITS	16
+#define RESIZE_LENGTH	2
+
+#define dpi_mem_alloc()	(struct dpitem *) kmem_cache_alloc(dpi_cache, SLAB_KERN
EL)
+#define dpi_mem_free(p) kmem_cache_free(dpi_cache, p)
+
+
+
+
+
+typedef unsigned long long event_version_t;
+
+struct devpoll {
+	rwlock_t lock;
+	wait_queue_head_t wq;
+	atomic_t sleepers;
+	struct list_head *hash;
+	unsigned int hbits;
+	unsigned int hmask;
+	atomic_t hents;
+	int numpages;
+	char **pages;
+	char *pages0[MAX_DEVPOLL_PAGES];
+	char *pages1[MAX_DEVPOLL_PAGES];
+	atomic_t mmapped;
+	int eventcnt;
+	event_version_t ver;
+	int minevents;
+	unsigned long minjiffies;
+	unsigned long jiffies;
+
+};
+
+struct dpitem {
+	struct list_head lnk;
+	struct devpoll *dp;
+	struct pollfd pfd;
+	int index;
+	event_version_t ver;
+
+};
+
+
+
+
+
+
+static int dp_alloc_pages(char **pages, int numpages);
+static int dp_free_pages(char **pages, int numpages);
+static int dp_init(struct devpoll *dp);
+static void dp_free(struct devpoll *dp);
+static struct dpitem *dp_find(struct devpoll *dp, int fd);
+static int dp_hashresize(struct devpoll *dp);
+static int dp_insert(struct devpoll *dp, struct pollfd *pfd);
+static int dp_remove(struct devpoll *dp, struct dpitem *dpi);
+static void notify_proc(struct file *file, void *data, unsigned long *local, lo
ng *event);
+static int open_devpoll(struct inode *inode, struct file *file);
+static int close_devpoll(struct inode *inode, struct file *file);
+static int write_devpoll(struct file *file, const char *buffer, size_t count,
+		loff_t *ppos);
+static int dp_poll(struct devpoll *dp, void *arg);
+static int ioctl_devpoll(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg);
+static void devpoll_mm_open(struct vm_area_struct * vma);
+static void devpoll_mm_close(struct vm_area_struct * vma);
+static int mmap_devpoll(struct file *file, struct vm_area_struct *vma);
+
+
+
+
+static kmem_cache_t *dpi_cache;
+
+static struct file_operations devpoll_fops = {
+	write: write_devpoll,
+	ioctl: ioctl_devpoll,
+	mmap: mmap_devpoll,
+	open: open_devpoll,
+	release: close_devpoll
+};
+
+static struct vm_operations_struct devpoll_mmap_ops = {
+	open: devpoll_mm_open,
+	close: devpoll_mm_close,
+};
+
+static struct miscdevice devpoll = {
+	DEVPOLL_MINOR, "devpoll", &devpoll_fops
+};
+
+
+
+
+static int dp_alloc_pages(char **pages, int numpages)
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
+static int dp_free_pages(char **pages, int numpages)
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
+static int dp_init(struct devpoll *dp)
+{
+	int ii, hentries;
+
+	rwlock_init(&dp->lock);
+	init_waitqueue_head(&dp->wq);
+	atomic_set(&dp->sleepers, 0);
+	dp->hbits = INITIAL_HASH_BITS;
+	dp->hmask = (1 << dp->hbits) - 1;
+	atomic_set(&dp->hents, 0);
+	atomic_set(&dp->mmapped, 0);
+	dp->numpages = 0;
+	dp->pages = NULL;
+	dp->eventcnt = 0;
+	dp->ver = 1;
+	dp->minevents = 0;
+	dp->minjiffies = 0;
+	dp->jiffies = 0;
+
+	hentries = dp->hmask + 1;
+	if (!(dp->hash = (struct list_head *) kmalloc(hentries * sizeof(struct list_he
ad),
+			GFP_KERNEL)))
+		return -ENOMEM;
+
+	for (ii = 0; ii < hentries; ii++)
+		INIT_LIST_HEAD(&dp->hash[ii]);
+
+	return 0;
+}
+
+
+static void dp_free(struct devpoll *dp)
+{
+	int ii;
+	struct list_head *lnk;
+	struct file *file;
+
+	lock_kernel();
+	for (ii = 0; ii <= dp->hmask; ii++) {
+		while ((lnk = list_first(&dp->hash[ii]))) {
+			struct dpitem *dpi = list_entry(lnk, struct dpitem, lnk);
+
+			if (current->files && (file = fcheck(dpi->pfd.fd)))
+				file_notify_delcb(file, notify_proc);
+			list_del(lnk);
+			dpi_mem_free(dpi);
+		}
+	}
+	kfree(dp->hash);
+	if (dp->numpages > 0) {
+		dp_free_pages(dp->pages0, dp->numpages);
+		dp_free_pages(dp->pages1, dp->numpages);
+	}
+	unlock_kernel();
+}
+
+
+static struct dpitem *dp_find(struct devpoll *dp, int fd)
+{
+	struct dpitem *dpi = NULL;
+	struct list_head *head = &dp->hash[fd & dp->hmask], *lnk;
+	unsigned long flags;
+
+	read_lock_irqsave(&dp->lock, flags);
+
+	list_for_each(lnk, head) {
+		dpi = list_entry(lnk, struct dpitem, lnk);
+
+		if (dpi->pfd.fd == fd) break;
+		dpi = NULL;
+	}
+
+	read_unlock_irqrestore(&dp->lock, flags);
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: dp_find(%d) -> %p\n", current, fd, dpi
));
+
+	return dpi;
+}
+
+
+static int dp_hashresize(struct devpoll *dp)
+{
+	struct list_head *hash;
+	unsigned int hbits = dp->hbits + 1;
+	unsigned int hmask = (1 << hbits) - 1;
+	int ii, hentries = hmask + 1;
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: dp_hashresize(%p) bits=%u\n", current,
 dp, hbits));
+
+	if (!(hash = (struct list_head *) kmalloc(hentries * sizeof(struct list_head),
+			GFP_KERNEL)))
+		return -ENOMEM;
+
+	for (ii = 0; ii < hentries; ii++)
+		INIT_LIST_HEAD(&hash[ii]);
+
+	for (ii = 0; ii <= dp->hmask; ii++) {
+		struct list_head *oldhead = &dp->hash[ii], *lnk;
+
+		while ((lnk = list_first(oldhead))) {
+			struct dpitem *dpi = list_entry(lnk, struct dpitem, lnk);
+
+			list_del(lnk);
+			list_add(lnk, &hash[dpi->pfd.fd & hmask]);
+		}
+	}
+	kfree(dp->hash);
+
+	dp->hash = hash;
+	dp->hbits = hbits;
+	dp->hmask = hmask;
+
+	return 0;
+}
+
+
+static int dp_insert(struct devpoll *dp, struct pollfd *pfd)
+{
+	struct dpitem *dpi;
+	struct file *file;
+	unsigned long flags = 0;
+
+	if (atomic_read(&dp->hents) >= (dp->numpages * POLLFD_X_PAGE))
+		return -E2BIG;
+
+	if (!(file = fcheck(pfd->fd)))
+		return -EINVAL;
+
+	if (!(dpi = dpi_mem_alloc()))
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&dpi->lnk);
+	dpi->dp = dp;
+	dpi->pfd = *pfd;
+	dpi->index = -1;
+	dpi->ver = dp->ver - 1;
+
+	write_lock_irqsave(&dp->lock, flags);
+
+	list_add(&dpi->lnk, &dp->hash[pfd->fd & dp->hmask]);
+	atomic_inc(&dp->hents);
+
+	if ((atomic_read(&dp->hents) >> dp->hbits) > RESIZE_LENGTH &&
+			dp->hbits < MAX_HASH_BITS)
+		dp_hashresize(dp);
+
+	write_unlock_irqrestore(&dp->lock, flags);
+
+	file_notify_addcb(file, notify_proc, dpi);
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: dp_insert(%p, %d)\n", current, dp, pfd
->fd));
+
+	return 0;
+}
+
+
+static int dp_remove(struct devpoll *dp, struct dpitem *dpi)
+{
+	int fd = dpi->pfd.fd;
+	struct file *file;
+	unsigned long flags = 0;
+
+	write_lock_irqsave(&dp->lock, flags);
+
+	list_del(&dpi->lnk);
+	atomic_dec(&dp->hents);
+
+	write_unlock_irqrestore(&dp->lock, flags);
+
+	if ((file = fcheck(fd)))
+		file_notify_delcb(file, notify_proc);
+
+	dpi_mem_free(dpi);
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: dp_remove(%p, %d)\n", current, dp, fd)
);
+
+	return 0;
+}
+
+
+static void notify_proc(struct file *file, void *data, unsigned long *local, lo
ng *event)
+{
+	struct dpitem *dpi = (struct dpitem *) data;
+	struct devpoll *dp = dpi->dp;
+	struct pollfd *pfd;
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: notify(%p, %p, %ld, %ld) dp=%p\n",
+			current, file, data, event[0], event[1], dp));
+
+	write_lock(&dp->lock);
+	if (!(dpi->pfd.events & event[1]))
+		goto out;
+
+	if (dpi->index < 0 || dpi->ver != dp->ver) {
+		if (dp->eventcnt >= (dp->numpages * POLLFD_X_PAGE))
+			goto out;
+		dpi->index = dp->eventcnt++;
+		dpi->ver = dp->ver;
+		pfd = (struct pollfd *) (dp->pages[EVENT_PAGE_INDEX(dpi->index)] +
+				EVENT_PAGE_OFFSET(dpi->index));
+		*pfd = dpi->pfd;
+	} else {
+		pfd = (struct pollfd *) (dp->pages[EVENT_PAGE_INDEX(dpi->index)] +
+				EVENT_PAGE_OFFSET(dpi->index));
+		if (pfd->fd != dpi->pfd.fd) {
+			if (dp->eventcnt >= (dp->numpages * POLLFD_X_PAGE))
+				goto out;
+			dpi->index = dp->eventcnt++;
+			pfd = (struct pollfd *) (dp->pages[EVENT_PAGE_INDEX(dpi->index)] +
+					EVENT_PAGE_OFFSET(dpi->index));
+			*pfd = dpi->pfd;
+		}
+	}
+
+	pfd->revents |= (pfd->events & event[1]);
+
+	if (atomic_read(&dp->sleepers) &&
+			(dp->eventcnt > dp->minevents || (jiffies - dp->jiffies) >= dp->minjiffies))
 {
+		wake_up(&dp->wq);
+	}
+out:
+	write_unlock(&dp->lock);
+}
+
+
+static int open_devpoll(struct inode *inode, struct file *file)
+{
+	int res;
+	struct devpoll *dp;
+
+	if (!(dp = kmalloc(sizeof(struct devpoll), GFP_KERNEL)))
+		return -ENOMEM;
+
+	memset(dp, 0, sizeof(*dp));
+	if ((res = dp_init(dp))) {
+		kfree(dp);
+		return res;
+	}
+
+	file->private_data = dp;
+
+	MOD_INC_USE_COUNT;
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: open() dp=%p\n", current, dp));
+	return 0;
+}
+
+
+static int close_devpoll(struct inode *inode, struct file *file)
+{
+	struct devpoll *dp = file->private_data;
+
+	dp_free(dp);
+
+	kfree(dp);
+
+	MOD_DEC_USE_COUNT;
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: close() dp=%p\n", current, dp));
+	return 0;
+}
+
+
+static int write_devpoll(struct file *file, const char *buffer, size_t count,
+		loff_t *ppos)
+{
+	int res, rcount;
+	struct devpoll *dp = file->private_data;
+	struct dpitem *dpi;
+	struct pollfd pfd;
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: write(%p, %d)\n", current, dp, count))
;
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
+		dpi = dp_find(dp, pfd.fd);
+
+		if (pfd.fd >= current->files->max_fds || !current->files->fd[pfd.fd])
+			pfd.events = POLLREMOVE;
+		if (pfd.events & POLLREMOVE) {
+			if (dpi) {
+				dp_remove(dp, dpi);
+				rcount += sizeof(pfd);
+			}
+		}
+		else if (dpi) {
+			dpi->pfd.events = pfd.events;
+			rcount += sizeof(pfd);
+		}
+		else {
+			pfd.revents = 0;
+			if (!dp_insert(dp, &pfd))
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
+static int dp_poll(struct devpoll *dp, void *arg)
+{
+	int res = 0;
+	long timeout;
+	unsigned long flags;
+	struct dvpoll dvp;
+	wait_queue_t wait;
+
+	if (copy_from_user(&dvp, arg, sizeof(struct dvpoll)))
+		return -EFAULT;
+
+	if (!atomic_read(&dp->mmapped))
+		return -EINVAL;
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: ioctl(%p, DP_POLL, %d)\n", current, dp
, dvp.dp_timeout));
+
+	write_lock_irqsave(&dp->lock, flags);
+
+	init_waitqueue_entry(&wait, current);
+	add_wait_queue(&dp->wq, &wait);
+	atomic_inc(&dp->sleepers);
+	timeout = dvp.dp_timeout * HZ;
+	for (;;) {
+		if (dp->eventcnt > 0 && (jiffies - dp->jiffies) >= dp->minjiffies)
+			break;
+
+		if (!timeout || signal_pending(current))
+			break;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		write_unlock_irqrestore(&dp->lock, flags);
+		timeout = schedule_timeout(timeout);
+		write_lock_irqsave(&dp->lock, flags);
+	}
+	atomic_dec(&dp->sleepers);
+	remove_wait_queue(&dp->wq, &wait);
+
+	set_current_state(TASK_RUNNING);
+
+	res = -EINTR;
+	if (dp->eventcnt > 0) {
+		res = dp->eventcnt;
+		dp->eventcnt = 0;
+		dp->jiffies = jiffies;
+		++dp->ver;
+		if (dp->pages == dp->pages0) {
+			dp->pages = dp->pages1;
+			dvp.dp_resoff = 0;
+		} else {
+			dp->pages = dp->pages0;
+			dvp.dp_resoff = dp->numpages * PAGE_SIZE;
+		}
+
+		copy_to_user(arg, &dvp, sizeof(struct dvpoll));
+	}
+
+	write_unlock_irqrestore(&dp->lock, flags);
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: ioctl(%p, DP_POLL, %d) == %d\n", curre
nt, dp, dvp.dp_timeout, res));
+	return res;
+}
+
+
+static int ioctl_devpoll(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	int res, numpages;
+	struct devpoll *dp = file->private_data;
+	unsigned long flags;
+	struct dvtune dpt;
+
+	switch (cmd) {
+	case DP_ALLOC:
+		if (atomic_read(&dp->mmapped))
+			return -EBUSY;
+
+		numpages = DP_FDS_PAGES(arg);
+		if (numpages > MAX_DEVPOLL_PAGES)
+			return -EINVAL;
+
+		res = -EBUSY;
+		write_lock_irqsave(&dp->lock, flags);
+		if (dp->numpages == 0) {
+			if (!(res = dp_alloc_pages(dp->pages0, numpages))) {
+				if (!(res = dp_alloc_pages(dp->pages1, numpages))) {
+					dp->numpages = numpages;
+					dp->pages = dp->pages0;
+					res = 0;
+				} else {
+					dp_free_pages(dp->pages0, numpages);
+				}
+			}
+		}
+		write_unlock_irqrestore(&dp->lock, flags);
+
+		DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: ioctl(%p, DP_ALLOC, %lu) == %d\n", cu
rrent, dp, arg, res));
+		return res;
+
+	case DP_FREE:
+		if (atomic_read(&dp->mmapped))
+			return -EBUSY;
+
+		res = -EINVAL;
+		write_lock_irqsave(&dp->lock, flags);
+		if (dp->numpages > 0) {
+			dp_free_pages(dp->pages0, dp->numpages);
+			dp_free_pages(dp->pages1, dp->numpages);
+			dp->numpages = 0;
+			dp->pages = NULL;
+			res = 0;
+		}
+		write_unlock_irqrestore(&dp->lock, flags);
+
+		DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: ioctl(%p, DP_FREE) == %d\n", current,
 dp, res));
+		return res;
+
+	case DP_POLL:
+		return dp_poll(dp, (void *) arg);
+
+	case DP_TUNE:
+		if (copy_from_user(&dpt, arg, sizeof(struct dvtune)))
+			return -EFAULT;
+
+		write_lock_irqsave(&dp->lock, flags);
+		dp->minevents = dpt.dp_minevents;
+		dp->minjiffies = (dpt.dp_msminwait * HZ) / 1000;
+		write_unlock_irqrestore(&dp->lock, flags);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+
+static void devpoll_mm_open(struct vm_area_struct * vma)
+{
+	struct file *file = vma->vm_file;
+	struct devpoll *dp = file->private_data;
+
+	if (dp) atomic_inc(&dp->mmapped);
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: mm_open(%p)\n", current, dp));
+}
+
+
+static void devpoll_mm_close(struct vm_area_struct * vma)
+{
+	struct file *file = vma->vm_file;
+	struct devpoll *dp = file->private_data;
+
+	if (dp) atomic_dec(&dp->mmapped);
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: mm_close(%p)\n", current, dp));
+}
+
+
+static int mmap_devpoll(struct file *file, struct vm_area_struct *vma)
+{
+	struct devpoll *dp = file->private_data;
+	unsigned long start, flags;
+	int ii, res;
+	int numpages;
+	size_t mapsize;
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: mmap(%p, %lx, %lx)\n",
+			current, dp, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT));
+
+	if ((vma->vm_pgoff << PAGE_SHIFT) != 0)
+		return -EINVAL;
+
+	mapsize = PAGE_ALIGN(vma->vm_end - vma->vm_start);
+	numpages = mapsize >> PAGE_SHIFT;
+
+	write_lock_irqsave(&dp->lock, flags);
+
+	res = -EINVAL;
+	if (numpages != (2 * dp->numpages))
+		goto out;
+
+	start = vma->vm_start;
+	for (ii = 0; ii < dp->numpages; ii++) {
+		if (remap_page_range(start, __pa(dp->pages0[ii]),
+				PAGE_SIZE, vma->vm_page_prot))
+    		goto out;
+		start += PAGE_SIZE;
+	}
+	for (ii = 0; ii < dp->numpages; ii++) {
+		if (remap_page_range(start, __pa(dp->pages1[ii]),
+				PAGE_SIZE, vma->vm_page_prot))
+    		goto out;
+		start += PAGE_SIZE;
+	}
+	vma->vm_ops = &devpoll_mmap_ops;
+	atomic_set(&dp->mmapped, 1);
+	res = 0;
+out:
+	write_unlock_irqrestore(&dp->lock, flags);
+
+	DNPRINTK(3, (KERN_INFO "[%p] /dev/poll: mmap(%p, %lx, %lx) == %d\n",
+		 	current, dp, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT, res));
+	return res;
+}
+
+
+int __init devpoll_init(void)
+{
+	dpi_cache = kmem_cache_create("devpoll",
+			sizeof(struct dpitem),
+			__alignof__(struct dpitem),
+			DPI_SLAB_DEBUG, NULL, NULL);
+	if (!dpi_cache) {
+		printk(KERN_INFO "[%p] /dev/poll: driver install failed.\n", current);
+		return -ENOMEM;
+	}
+
+	printk(KERN_INFO "[%p] /dev/poll: driver installed.\n", current);
+
+	misc_register(&devpoll);
+
+	return 0;
+}
+
+
+module_init(devpoll_init);
+
+#ifdef MODULE
+
+void cleanup_module(void)
+{
+	misc_deregister(&devpoll);
+	kmem_cache_destroy(dpi_cache);
+}
+
+#endif
+
diff -NBbru linux-2.4.6.vanilla/fs/fcntl.c linux-2.4.6/fs/fcntl.c
--- linux-2.4.6.vanilla/fs/fcntl.c	Tue May 22 09:26:06 2001
+++ linux-2.4.6/fs/fcntl.c	Wed Jul  4 15:38:38 2001
@@ -360,7 +360,7 @@
 
 /* Table to convert sigio signal codes into poll band bitmaps */
 
-static long band_table[NSIGPOLL] = {
+long band_table[NSIGPOLL] = {
 	POLLIN | POLLRDNORM,			/* POLL_IN */
 	POLLOUT | POLLWRNORM | POLLWRBAND,	/* POLL_OUT */
 	POLLIN | POLLRDNORM | POLLMSG,		/* POLL_MSG */
diff -NBbru linux-2.4.6.vanilla/fs/file.c linux-2.4.6/fs/file.c
--- linux-2.4.6.vanilla/fs/file.c	Fri Feb  9 11:29:44 2001
+++ linux-2.4.6/fs/file.c	Mon Jul  2 17:12:56 2001
@@ -228,5 +228,84 @@
 		free_fdset(new_execset, nfds);
 	write_lock(&files->file_lock);
 	return error;
+}
+
+void file_notify_event(struct file *filep, long *event)
+{
+	unsigned long flags;
+	struct list_head *lnk;
+
+	fcblist_read_lock(filep, flags);
+
+	list_for_each(lnk, &filep->f_cblist) {
+		struct fcb_struct *fcbp = list_entry(lnk, struct fcb_struct, lnk);
+
+		fcbp->cbproc(filep, fcbp->data, fcbp->local, event);
+	}
+
+	fcblist_read_unlock(filep, flags);
+}
+
+int file_notify_addcb(struct file *filep,
+		void (*cbproc)(struct file *, void *, unsigned long *, long *), void *data)
+{
+	unsigned long flags;
+	struct fcb_struct *fcbp;
+
+	if (!(fcbp = (struct fcb_struct *) kmalloc(sizeof(struct fcb_struct), GFP_KERN
EL)))
+		return -ENOMEM;
+
+	memset(fcbp, 0, sizeof(struct fcb_struct));
+	fcbp->cbproc = cbproc;
+	fcbp->data = data;
+
+	fcblist_write_lock(filep, flags);
+	list_add_tail(&fcbp->lnk, &filep->f_cblist);
+	fcblist_write_unlock(filep, flags);
+
+	return 0;
+}
+
+int file_notify_delcb(struct file *filep,
+		void (*cbproc)(struct file *, void *, unsigned long *, long *))
+{
+	int error;
+	unsigned long flags;
+	struct list_head *lnk;
+
+	fcblist_write_lock(filep, flags);
+
+	error = -ENOENT;
+	list_for_each(lnk, &filep->f_cblist) {
+		struct fcb_struct *fcbp = list_entry(lnk, struct fcb_struct, lnk);
+
+		if (fcbp->cbproc == cbproc) {
+			list_del(lnk);
+			kfree(fcbp);
+			error = 0;
+			break;
+		}
+	}
+
+	fcblist_write_unlock(filep, flags);
+
+	return error;
+}
+
+void file_notify_cleanup(struct file *filep)
+{
+	unsigned long flags;
+	struct list_head *lnk;
+
+	fcblist_write_lock(filep, flags);
+
+	while ((lnk = list_first(&filep->f_cblist))) {
+		struct fcb_struct *fcbp = list_entry(lnk, struct fcb_struct, lnk);
+
+		list_del(lnk);
+		kfree(fcbp);
+	}
+
+	fcblist_write_unlock(filep, flags);
 }
 
diff -NBbru linux-2.4.6.vanilla/fs/file_table.c linux-2.4.6/fs/file_table.c
--- linux-2.4.6.vanilla/fs/file_table.c	Wed Apr 18 11:49:12 2001
+++ linux-2.4.6/fs/file_table.c	Mon Jul  2 16:27:29 2001
@@ -46,6 +46,8 @@
 		f->f_uid = current->fsuid;
 		f->f_gid = current->fsgid;
 		list_add(&f->f_list, &anon_list);
+		rwlock_init(&f->f_cblock);
+		INIT_LIST_HEAD(&f->f_cblist);
 		file_list_unlock();
 		return f;
 	}
@@ -90,6 +92,8 @@
 	filp->f_uid    = current->fsuid;
 	filp->f_gid    = current->fsgid;
 	filp->f_op     = dentry->d_inode->i_fop;
+	rwlock_init(&filp->f_cblock);
+	INIT_LIST_HEAD(&filp->f_cblist);
 	if (filp->f_op->open)
 		return filp->f_op->open(dentry->d_inode, filp);
 	else
@@ -103,6 +107,7 @@
 	struct inode * inode = dentry->d_inode;
 
 	if (atomic_dec_and_test(&file->f_count)) {
+		file_notify_cleanup(file);
 		locks_remove_flock(file);
 		if (file->f_op && file->f_op->release)
 			file->f_op->release(inode, file);
diff -NBbru linux-2.4.6.vanilla/include/asm-i386/poll.h linux-2.4.6/include/asm-
i386/poll.h
--- linux-2.4.6.vanilla/include/asm-i386/poll.h	Thu Jan 23 11:01:28 1997
+++ linux-2.4.6/include/asm-i386/poll.h	Tue Jul  3 17:09:21 2001
@@ -15,6 +15,7 @@
 #define POLLWRNORM	0x0100
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
+#define POLLREMOVE	0x1000
 
 struct pollfd {
 	int fd;
diff -NBbru linux-2.4.6.vanilla/include/linux/devpoll.h linux-2.4.6/include/linu
x/devpoll.h
--- linux-2.4.6.vanilla/include/linux/devpoll.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.6/include/linux/devpoll.h	Sat Jul  7 15:49:42 2001
@@ -0,0 +1,52 @@
+/*
+ *
+ * /dev/poll support
+ * by Davide Libenzi <davidel@xmailserver.org>
+ *
+ */
+
+#ifndef _LINUX_DEVPOLL_H
+#define _LINUX_DEVPOLL_H
+
+
+
+
+#define DEVPOLL_MINOR	125
+#define POLLFD_X_PAGE	(PAGE_SIZE / sizeof(struct pollfd))
+#define MAX_FDS_IN_DEVPOLL	32000
+#define MAX_DEVPOLL_PAGES	(MAX_FDS_IN_DEVPOLL / POLLFD_X_PAGE)
+#define EVENT_PAGE_INDEX(n)	((n) / POLLFD_X_PAGE)
+#define EVENT_PAGE_REM(n)	((n) % POLLFD_X_PAGE)
+#define EVENT_PAGE_OFFSET(n)	(((n) % POLLFD_X_PAGE) * sizeof(struct pollfd))
+#define DP_FDS_PAGES(n)	(((n) + POLLFD_X_PAGE - 1) / POLLFD_X_PAGE)
+#define DP_MAP_SIZE(n)	(DP_FDS_PAGES(n) * PAGE_SIZE * 2)
+
+
+#define __MIN(a, b)	(((a) < (b)) ? (a): (b))
+#define __MAX(a, b)	(((a) > (b)) ? (a): (b))
+
+
+
+
+
+struct dvpoll {
+	int dp_timeout;
+	unsigned long dp_resoff;
+};
+
+struct dvtune {
+	int dp_minevents;
+	unsigned long dp_msminwait;
+};
+
+#define DP_ALLOC	_IOR('P', 1, int)
+#define DP_POLL		_IOWR('P', 2, struct dvpoll)
+#define DP_FREE		_IO('P', 3)
+#define DP_ISPOLLED	_IOWR('P', 4, struct pollfd)
+#define DP_TUNE		_IOWR('P', 5, struct dvtune)
+
+
+
+
+#endif
+
diff -NBbru linux-2.4.6.vanilla/include/linux/file.h linux-2.4.6/include/linux/f
ile.h
--- linux-2.4.6.vanilla/include/linux/file.h	Wed Aug 23 11:22:26 2000
+++ linux-2.4.6/include/linux/file.h	Mon Jul  2 17:12:31 2001
@@ -96,5 +96,17 @@
 }
 
 void put_files_struct(struct files_struct *fs);
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
 
 #endif /* __LINUX_FILE_H */
diff -NBbru linux-2.4.6.vanilla/include/linux/fs.h linux-2.4.6/include/linux/fs.
h
--- linux-2.4.6.vanilla/include/linux/fs.h	Wed Jul  4 10:44:54 2001
+++ linux-2.4.6/include/linux/fs.h	Mon Jul  9 14:17:05 2001
@@ -494,6 +494,26 @@
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
 
+/* file callback notification events */
+#define ION_IN		1
+#define ION_OUT		2
+#define ION_HUP		3
+#define ION_ERR		4
+
+#define FCB_LOCAL_SIZE	4
+
+#define fcblist_read_lock(fp, fl)		read_lock_irqsave(&(fp)->f_cblock, fl)
+#define fcblist_read_unlock(fp, fl)		read_unlock_irqrestore(&(fp)->f_cblock, fl
)
+#define fcblist_write_lock(fp, fl)		write_lock_irqsave(&(fp)->f_cblock, fl)
+#define fcblist_write_unlock(fp, fl)	write_unlock_irqrestore(&(fp)->f_cblock, f
l)
+
+struct fcb_struct {
+	struct list_head lnk;
+	void (*cbproc)(struct file *, void *, unsigned long *, long *);
+	void *data;
+	unsigned long local[FCB_LOCAL_SIZE];
+};
+
 struct file {
 	struct list_head	f_list;
 	struct dentry		*f_dentry;
@@ -512,6 +532,10 @@
 
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
+
+	/* file callback list */
+	rwlock_t f_cblock;
+	struct list_head f_cblist;
 };
 extern spinlock_t files_lock;
 #define file_list_lock() spin_lock(&files_lock);
diff -NBbru linux-2.4.6.vanilla/include/linux/list.h linux-2.4.6/include/linux/l
ist.h
--- linux-2.4.6.vanilla/include/linux/list.h	Fri Feb 16 16:06:17 2001
+++ linux-2.4.6/include/linux/list.h	Mon Jul  2 16:14:27 2001
@@ -148,6 +148,10 @@
  */
 #define list_for_each(pos, head) \
 	for (pos = (head)->next; pos != (head); pos = pos->next)
+
+#define list_first(head)	(((head)->next != (head)) ? (head)->next: (struct list
_head *) 0)
+
+#define list_last(head)	(((head)->prev != (head)) ? (head)->prev: (struct list_
head *) 0)
 
 #endif /* __KERNEL__ || _LVM_H_INCLUDE */
 
diff -NBbru linux-2.4.6.vanilla/include/net/sock.h linux-2.4.6/include/net/sock.
h
--- linux-2.4.6.vanilla/include/net/sock.h	Fri May 25 18:03:05 2001
+++ linux-2.4.6/include/net/sock.h	Mon Jul  9 14:17:22 2001
@@ -105,6 +105,8 @@
 
 #include <asm/atomic.h>
 #include <net/dst.h>
+#include <linux/fs.h>
+#include <linux/file.h>
 
 
 /* The AF_UNIX specific socket options */
@@ -1230,8 +1232,17 @@
 
 static inline void sk_wake_async(struct sock *sk, int how, int band)
 {
-	if (sk->socket && sk->socket->fasync_list)
+	if (sk->socket) {
+		if (sk->socket->file) {
+			extern long ion_band_table[];
+			extern long band_table[];
+			long event[] = { ion_band_table[band - POLL_IN], band_table[band - POLL_IN],
 -1 };
+
+			file_notify_event(sk->socket->file, event);
+		}
+		if (sk->socket->fasync_list)
 		sock_wake_async(sk->socket, how, band);
+	}
 }
 
 #define SOCK_MIN_SNDBUF 2048
diff -NBbru linux-2.4.6.vanilla/net/core/sock.c linux-2.4.6/net/core/sock.c
--- linux-2.4.6.vanilla/net/core/sock.c	Wed Jul  4 10:44:56 2001
+++ linux-2.4.6/net/core/sock.c	Wed Jul  4 10:46:21 2001
@@ -142,6 +142,16 @@
 /* Maximal space eaten by iovec or ancilliary data plus some space */
 int sysctl_optmem_max = sizeof(unsigned long)*(2*UIO_MAXIOV + 512);
 
+/* Maps from band to file notification events ( used by sk_wake_async() ) */
+long ion_band_table[NSIGPOLL] = {
+	ION_IN,		/* POLL_IN */
+	ION_OUT,	/* POLL_OUT */
+	ION_IN,		/* POLL_MSG */
+	ION_ERR,	/* POLL_ERR */
+	0,			/* POLL_PRI */
+	ION_HUP		/* POLL_HUP */
+};
+
 static int sock_set_timeout(long *timeo_p, char *optval, int optlen)
 {
 	struct timeval tv;

--_=XFMail.1.4.7.Linux:20010710215331:705=_
Content-Disposition: attachment; filename="dphttpd.tar.gz"
Content-Transfer-Encoding: base64
Content-Description: dphttpd.tar.gz
Content-Type: application/octet-stream; name=dphttpd.tar.gz; SizeOnDisk=4071

H4sIAPnSSzsAA+0ba3PTSJKv9q8YsgVIiU3s8Fy8yZU3URYXxkk5Drt7QLkUSU5U2JJPkgMc5L9f
d89DM5LshLDA3l2mKrE0090z06/pnhn587Msm/v3vVvfrrTardbjhw9vtaA8ecx/2+K91XrQ3nq0
dav15MHW1pN2u/X4AcBvbT1o32KtbzgmVRZp5iaM3fLd89APpivggiT9HgP6vqX+kx9Mwihg4+Mj
Z+y8cgajw4N+v765zoyWo9Ee1rP1zVLTnvNKNtV/CiNvuvAD9kua+WF8/2zHrJqGJ2bdIgqhugTn
JqfFuiSMCnVuCjLJzLppOAuz1Kzzso/zwKzKwlmhZuJF2dSsCpIkKk4hPI3cAlj6Md3EHtJyNehW
VgFc6pxgY+9dUIT2zoIicwB0Ek4rCISxV5wBVs9mblTRWzANvIqxvXfDQm0UZCDqbDMsUHGTubuJ
LRXVkTsLQDYlQv5JqcdpXJDq6TQuQgUzd34WJ4U5e3FC0oGqCeijoaeFWc3jKedMEPnhhDAYV2Hf
MhXfZp8/m01CvW1D8Wabc/c0KKrjLO9IU8ho8WHTD86LY8hh1vyT6RTM4P7ZWp2KNK/dA5wP/HV3
X4yPev90arWn7Z+3VDs17j539saj3kvn4HhUq7WNxn7vaOQMBGqtvfVUte51R93xr8f7+85QNG+1
HubNL3uDcfe50wX6h91dRLaKGGyTtbfsHKP7B7Bqv3vcH433945qSBAKzQeMd+FlzJ+fjb04itin
ek1U4bTHZ4Hrs2n0rlOvhVHG0okvnoLzIMrSBkv4Q0ehoegXqJZs3Yuh2jsDH36ymEyC5HVxnG8F
sejkYxYgsTDygw+d+kWH8/o6qoB2HXoMyb7z5zheUUMDWQd17ei6VtJOMQ1UiYnP1oFCmiNoxGfu
B2hqsGgxg1+2zVodvRl6S8/GafjvQFWX+LpOQAbaLD1FHCAHGtGAUSQZPD9tPW01sEfgP7wW5MmZ
hdgoxTAKM+s8Dn27/olzNww712NlbRGhUw1AA+LoFPqf8/nobMuXJakA/nm2AOnDj+JbFb81REEY
ZrZ3OH7ZPSTdsPh07ZyIhiyGqKMK7qwzfI8nliFHu/N1/qUGSJZF+gRdxfMgstbQcZBTWWuwg/Fw
7/ehbbPtbdZs22hFtTmsUXFirRG0zXJwGEytlgTZIokAGF4uOH1aJHgnDeREt98/2JVit2EQOlUO
XCLrTeM04DQqulkx93oNBHbfn49n0EomzVVaVafQgCuQqK4a8Oh44DTYXcD4a0bLJcZ5D4KGni1u
xDaDlXNuDY77/YZUywY7HB6MxkNwjOwzf/592Bs5DaBbQ6U6HPZedeGdiQG3uLgUSZCbOWjqozTm
4qT3h46DxK48n0qvQ5O8bc25K7EKTgjm606nsWetVnIooHlL+xV9kNPROtH80WX9KFDRlcYrjmcj
jyrnV5skQUDzMyz6GqZYmy0ilAz8KeF/oWSkZhUYhe7kA5cAZwBfvoQf57W0HNQmcQLqH5ItgH9l
v8gmeNnYwEHu/dof9wa9Ea3zY1yurbtE63UYvoUh1GXfYEwXmvv2poEbLebKg/+1jvuafrgotUv8
MLLwG/nhJbJfIfpKyVfraIWKLhMTzwgseo1nbhg1aPnGXIM/zZM4i714qlZhvnQLPInD4RUs+qrJ
1D1FDWx3hMUS4jZ3T4bC5i44xWnv9w4Gv/YOwAETCZvdvYuuz7IkRUqjBOz4N2e03+dO8BfWAo4j
rAFxxCE49mdY4gZAH1akF4Qh7J9zN630d4p3ZEmmkiOW4ApyqG4SWmIaEJ9CYmQVQ9Z1/N+AwDNK
MxlkIZ9d3wfHDrnO+RgfG1Q5DaJxxvAdnkg4788gZYNlQFDH3+YO8UBDlQj6Ao/8pzwUK53eYDRE
CdWAAIS/i6AjQATMbYDp/tbtDVAwTKv8/eC4v8cZS/g6E2t8NGpBRj2FXAIXOHhyhkPx9Pz4kEOP
kyBdzAKahc1Di2pmJuDFl3KSVkSI2bkqU3Su9DhCvRQ8syIYE1HSuEZ4HIdryo9kVm9wHV5FJq/e
J2EWrGQW170rs4wT/Lvy7JoKVmCa63nBfKmxlsyUmxkir+vGKXyEdEPCLUpecp8qetLYyYlZub1D
ZCOp/nj+fqFO/ve5eS2fRblHwXuSvaWEicENW58sIo+EXKkjWoSaN6gA1QwuJIBtXzfTNQNu2jYw
w2Yib84dopFglgZc84DHDRnyrMuxVEeBpBHT6B1FJ1JpMTbgAecKhVlumRwrMTI3Xsf3VqBKgNAW
i5bE3RaG48UEM/bAn4NzQuE0GM+wSntdMvqngEmqakktcPI07+7e3kibN6guj4Rx2ne0nRKKi68n
P5DYfY2J+PqlLEQck4HIHu6qRWR5l/4LKWNAaaMDMN6JLXPgcoba6YOXaLA1VCuIJjIwCdwWD+OI
Ud70jE387Tv+m2itwbhxicyB2Lbn9Avagg7CD6aBWjy8mKpXyUGp8cYG36rCTlDOYEiKCkVPUUVa
IkyZDBatLPgQZtyYK432+hnLCgP8So1QJlalF0Pn5cEr5ztJn0RXKXw1RhKBJrQVypAH0jq2oQv1
WrNpCB3FZ2FaVOGmMY4b+27mLhettlkrsxPDq+ww6Zh5Nd/2tVmzuGktWAX+05t/NIAlL/gb2zDc
lmwUPq1pNNr5clvweZXgObThEi9YME0Dlk9N0lKSNqcGoUCBBVpwcSXm7OywNg8c/np24FwE5Vl8
Hvy9OC00yFI0VF6iErqlw8NJLVE1Y6QQxEBvpYXbGO3GtqbTle6PJ0TKSKbgb1YYCYeOEAomhUso
EqYtow67TfWdoo6IoeyYoycgwSRBDnXkLLFWiu7em+jeagEK+6uJsQraK4jSylQQI/BNDKvJ8McG
HIp5a3KyvHWHWtFS6P11s/0Wzenem+SeAGk2bY6nuHbvTeserxICIa5hxYVkyVXMk8yqdgJSwxMs
wkVU092R4CjYrWvAeWLDJVjhMedukgZA6F+LIF2S6WgKwWcggy4xT1OneNxY1FapO5rSXIpvJiGI
IoTMWavPtF6xS1CYaArLEWYmc0hzV2m+hobQkG6xbT4Ew5CwTbMMHB2v4nVibVAnYZYlnzfY4wc2
22SPH9psHf53+GZ3ah4NiC1shbP16DGPrFKxMiMGrMvPR6PDzfb9NttqtdjBizcJLMXIl7WjIDkP
YH3257QFFCR50y7khhAjNEcf58EzlgUfss351A2jMkQ/iE6zs2cMVnjVRk8NecjHByVyWTlctX5g
ROS5mRxsq7314OGjx0+e/oxPROgrK7nJyX6b28TPGrnlWi49GAU80Chs4bTzLRHup/kIBcolMSQ5
UbrWZIl3sMAvTgIRSdsHKNsiN+ntbcnMshKrCEnOKI9sZSAtZsE7q5wI33mIk6+fS62wITIOI9qx
yM/d1R4kU64OK+zyfoi2+8IFZJV2WyBu4Xskd/NtkdvmzqaRuVP/SnTaFooWhaoE5kJ3KCXulViA
TxDB+/p+cPkOwjr9316aOjbAwdI1hUred/RQev9gOHa6u88tykXpOItvcnAhKThIMoZ/cqAC0Qbj
MbixhIt9eppB7oB575WrSfUpTMn34j2jxTRIiof6DRbxw6hljBVdV15oyA/rKTuBn05xnYE6PPjF
G1HxAo99S1daOjkU2FU8mfDIDmojfopWPJbBCdIBMfmS2tLTTjrt3WAGbZ7ols7dInXq1sCsMd3Y
0KMmIVKlYgjR3KGjUhkAFTZOOIS61UIwWigv4GTQz195lLE8qRZRy0V5odUuHJUP1f5umhCpo1GO
KOt5Ndfrq6nN12sIXeP5P9EHeT75hfoAS7IhYMk8z5R7wcVqfnSVLhU0RJMD75w/eUJ+cyEUkI92
L4qflXO+m949DN8Sly512dd02oAmJV/YIMqblAbokjUgzO0iKBsbkrf0EsnnCxVWCXaAJEj1pKBK
JgLRbbvVahV9XpGjRA8iRsytStrvldS/MG48xSgahFe2iGYzUZMqWof3rc1jmX2oDclF6p4Gln4I
N09O8Y4rP1YubcYtUojb76TsdbMpQ1+RQlp3fPst1tOlu+gkyWvEnQZSbKrEMB7HKfpSIT2/safu
bAFD5JEYnvdThOMmp548YoXn89dvDcstHnblZhqdQlaOP9DwCVShdbEqbNTvqLSF7WHXutXR7QLI
MmZzi0YCZgccUoxZ0yNoAt7YUHS4EPMkzc3iUFHhQvS0c7SLFd0hy67Ql7gL+RUdcTFeZVrypuWl
nYncgmshAbbe6pvw8ixERtR0O1O7RZBDbulbYnkgLy6MdPfHvYEzAldxgGcwo6HTfamusClS+gUi
fRQPeASaBhmSi/FYFtXs6KA/Rnqc7njowGrT3dsbyrNFtdnNTxqR4iUkXjjOYbffe+Vcn0S/N/jN
wSGgqit0fLHJeaN630/DaDxxZ+H0I7BJ8KajtQldOcvAJVj4Yuut/IF+BNDU6g1w5uPu4E9b7P2f
oD+kEa7In/RMrEoW+rHpMuk8FJLHlTgQuVbhhrjd0XTIzMpE7mkzPSG97lAeaSl+Hl5Q70UU3S//
6C9l/jeL+vTgG/ax+vuv1sNH7Qf0/Vd7q/UQYOn7L/i5+f7rOxRMAiLKAiC6RWdwNH6efxOm1Wmf
pag4mM7a8OqBRcEQE+UTu8srGvKBXSzBNhGplFIGBNGj70KvJuXCRYh5Bm7qTd2PYVBv6kieqpo7
80HwAb03vXZU7SFEk3ntm/oFE9teLbtiBuDNLXCUId6uDM4h0Aaahe7KCVBNdoI4nRVgYoRItKMG
j5XaQLF31Ygv2tTot9QoOz/UerfoTUOVZC+d/nOkK5MlUYrs4c2wiBCU6GQJvdGV6ClKh8R2equg
dzyAdf6FtVQ2VmQyc26wpMgRzsvVHMEDdMg+ko+FnopDEkBqBvk78aajoRUUmgNePhLn5ejwT8vg
I03LEAIu4MuYd3TY7+06FmqklMclio21kzBJyaywXnYjp4OxBQe4vU2ItqK2xAamrklNV9olKC4h
6LPUEXj/mswR0AAw+cMnZADgmDQA12x1deIIKlsvVomMXNruAUgsnvpnqKzvzwr8XqcmGye3Ts26
ZZ/JAWkujMBLQNiqeT8FtHRovZHzEpSQlIK7U12bDL95WzhOfnfRcLSqqUrV9ntDoF2hq6Ywbku5
2uwfppye8SO9CtL9bhVlnbQaeZk0Ni0nzTeBYFLyhv0smJ0ExB/LwhqIly15YMiZYRmfTNjWXQXY
gv4EfjWL5N7UPE4190jpN1SVVR4r1az46zaBLnHAzmBvfLAvpGz0gdNBPPqOiTOpYoAD548yIteQ
vM8Cn7WW5Ww+HDqvVhKuEKDWogjX9S9RlcOof1rizDgblzWSH5JfkMoNox8dyt2Um3JTbspNuSk3
5abclJtyU27KTbkpS8t/AIaJ1tgAUAAA

--_=XFMail.1.4.7.Linux:20010710215331:705=_
Content-Disposition: attachment; filename="deadcon.c"
Content-Transfer-Encoding: 7bit
Content-Description: deadcon.c
Content-Type: text/plain; charset=us-ascii; name=deadcon.c; SizeOnDisk=2479


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/time.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/file.h>
#include <sys/socket.h>
#include <netdb.h>
#include <signal.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/sendfile.h>
#include <dirent.h>
#include <pthread.h>
#include <semaphore.h>






int
sockndelay(int sfd, int on)
{

	return ((on) ? fcntl(sfd, F_SETFL, fcntl(sfd, F_GETFL, 0) | O_NONBLOCK):
			fcntl(sfd, F_SETFL, fcntl(sfd, F_GETFL, 0) & ~O_NONBLOCK));

}




int
tconnect(struct in_addr const *paddr, int port, int timeout)
{

	int	sfd;
	struct sockaddr_in sin;
	fd_set wfds;
	struct timeval tv;

	if ((sfd = socket(AF_INET, SOCK_STREAM, 0)) == -1)
	{
		perror("socket");
		return (-1);
	}


	memset(&sin, 0, sizeof(sin));
	memcpy(&sin.sin_addr, &paddr->s_addr, 4);
	sin.sin_port = htons((short int) port);
	sin.sin_family = AF_INET;

	if (sockndelay(sfd, 1) == -1)
	{
		perror("sockndelay");
		close(sfd);
		return (-1);
	}

	if (connect(sfd, (struct sockaddr *) &sin, sizeof(sin)) == 0)
	{
		sockndelay(sfd, 0);
	    return (sfd);
	}

	if ((errno != EINPROGRESS) && (errno != EWOULDBLOCK))
	{
		perror("connect");
		close(sfd);
		return (-1);
	}

	FD_ZERO(&wfds);
	FD_SET(sfd, &wfds);
	tv.tv_sec = timeout;
	tv.tv_usec = 0;

	if (select(sfd + 1, (fd_set *) 0, &wfds, (fd_set *) 0, &tv) <= 0)
	{
	 	perror("select");
		close(sfd);
		return (-1);
	}

	if (FD_ISSET(sfd, &wfds))
	{
	 	sockndelay(sfd, 0);
	    return (sfd);
	}

	close(sfd);

	return (-1);

}





int
main(int argc, char *argv[])
{
	int ii;
	char *server;
	int port;
	int nconns, ccreat = 0;
	struct hostent *	he;
	struct in_addr	inadr;
	struct sockaddr_in sin;

	if (argc < 4)
	{
		printf("use: %s  server  port  numconns\n", argv[0]);
		return (1);
	}

	server = argv[1];
	port = atoi(argv[2]);
	nconns = atoi(argv[3]);

	if (inet_aton(server, &inadr) == 0)
	{
		if ((he = gethostbyname(server)) == NULL)
		{
		 	fprintf(stderr, "unable to resolve: %s\n", server);
		 	return (-1);
		}

		memcpy(&inadr.s_addr, he->h_addr_list[0], he->h_length);
	}

	for (ii = 0; ii < nconns; ii++)
	{
		int sfd = tconnect(&inadr, port, 30);

		if (sfd != -1)
		{
			char const *req = "GET / HTTP/1.0\r\n";

			write(sfd, req, strlen(req));

			++ccreat;
		}
	}

	printf("%d connections created ...\n", ccreat);

	while (1)
		sleep(10);

	return (0);

}

--_=XFMail.1.4.7.Linux:20010710215331:705=_--
End of MIME message

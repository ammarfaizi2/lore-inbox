Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbRF0TeB>; Wed, 27 Jun 2001 15:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbRF0Td4>; Wed, 27 Jun 2001 15:33:56 -0400
Received: from [213.221.172.237] ([213.221.172.237]:32649 "EHLO
	smtp-relay2.barrysworld.com") by vger.kernel.org with ESMTP
	id <S265382AbRF0Tdp>; Wed, 27 Jun 2001 15:33:45 -0400
Message-ID: <00bb01c0ff40$065816c0$470c0a0a@DEVPC01>
From: "Zarjazz" <zarjazz@barrysworld.com>
To: <linux-kernel@vger.kernel.org>
Cc: <kdc@nh.ultranet.com>, <linux-scalability@citi.umich.edu>
Subject: PATCH (2.4.5): /dev/poll support (3rd time lucky)
Date: Wed, 27 Jun 2001 20:33:21 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00B8_01C0FF48.6811D060"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00B8_01C0FF48.6811D060
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Not my day it seems ! Hopefully I remembered to attach the file this time :)

--

Hi,
    this patch adds Solaris 7/8 like /dev/poll support to the kernel.

I can claim no real credit for this as basically this is a fixed version of
a patch available from http://www.citi.umich.edu/projects/linux-scalability/
to compile correctly with 2.4.5 that only seemed to work with the 2.3.x
devel branch. The reason for this is so I can compile & test an application
on my home linux pc when I'm not around my nice work Solaris boxes :)

Please note, I have not got the knowledge of kernel development to know if
this patch is broken or badly written. It may be bugged and/or worse than
the standard poll() call but my application works so I'll leave profiling
etc to people more knowledgable than me.

Vince.



------=_NextPart_000_00B8_01C0FF48.6811D060
Content-Type: application/octet-stream;
	name="devpoll-2.4.5.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="devpoll-2.4.5.patch"

diff -rNu linux.orig/drivers/char/Config.in linux/drivers/char/Config.in=0A=
--- linux.orig/drivers/char/Config.in	Wed Mar  7 03:44:34 2001=0A=
+++ linux/drivers/char/Config.in	Wed Jun 27 16:41:00 2001=0A=
@@ -158,6 +158,7 @@=0A=
 =0A=
 dep_tristate 'Intel i8x0 Random Number Generator support' =
CONFIG_INTEL_RNG $CONFIG_PCI=0A=
 tristate '/dev/nvram support' CONFIG_NVRAM=0A=
+tristate '/dev/poll support' CONFIG_DEVPOLL=0A=
 tristate 'Enhanced Real Time Clock Support' CONFIG_RTC=0A=
 if [ "$CONFIG_IA64" =3D "y" ]; then=0A=
    bool 'EFI Real Time Clock Services' CONFIG_EFI_RTC=0A=
diff -rNu linux.orig/drivers/char/Makefile linux/drivers/char/Makefile=0A=
--- linux.orig/drivers/char/Makefile	Wed May 16 18:27:02 2001=0A=
+++ linux/drivers/char/Makefile	Wed Jun 27 16:43:07 2001=0A=
@@ -170,6 +170,7 @@=0A=
 obj-$(CONFIG_PC110_PAD) +=3D pc110pad.o=0A=
 obj-$(CONFIG_RTC) +=3D rtc.o=0A=
 obj-$(CONFIG_EFI_RTC) +=3D efirtc.o=0A=
+obj-$(CONFIG_DEVPOLL) +=3D devpoll.o=0A=
 ifeq ($(CONFIG_PPC),)=0A=
   obj-$(CONFIG_NVRAM) +=3D nvram.o=0A=
 endif=0A=
diff -rNu linux.orig/drivers/char/devpoll.c linux/drivers/char/devpoll.c=0A=
--- linux.orig/drivers/char/devpoll.c	Thu Jan  1 01:00:00 1970=0A=
+++ linux/drivers/char/devpoll.c	Wed Jun 27 18:55:30 2001=0A=
@@ -0,0 +1,756 @@=0A=
+/*=0A=
+ * /dev/poll=0A=
+ * by Niels Provos <provos@citi.umich.edu>=0A=
+ *=0A=
+ * provides poll() support via /dev/poll as in Solaris.=0A=
+ *=0A=
+ * Linux 2.3.x port by Michal Ostrowski=0A=
+ * Linux 2.4.x patches by Vincent Sweeney <v.sweeney@dexterus.com>=0A=
+ */=0A=
+=0A=
+#include <linux/module.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/sched.h>=0A=
+#include <linux/file.h>=0A=
+#include <linux/signal.h>=0A=
+#include <linux/errno.h>=0A=
+#include <linux/mm.h>=0A=
+#include <linux/malloc.h>=0A=
+#include <linux/vmalloc.h>=0A=
+#include <linux/poll.h>=0A=
+#include <linux/miscdevice.h>=0A=
+#include <linux/random.h>=0A=
+#include <linux/smp_lock.h>=0A=
+#include <linux/wrapper.h>=0A=
+=0A=
+#include <linux/devpoll.h>=0A=
+=0A=
+#include <asm/uaccess.h>=0A=
+#include <asm/system.h>=0A=
+#include <asm/io.h>=0A=
+=0A=
+/*#define DEBUG 1 */=0A=
+#ifdef DEBUG=0A=
+#define DPRINTK(x)	printk x=0A=
+#define DNPRINTK(n,x)	if (n <=3D DEBUG) printk x=0A=
+#else=0A=
+#define DPRINTK(x)=0A=
+#define DNPRINTK(n,x)=0A=
+#endif=0A=
+=0A=
+/* Various utility functions */=0A=
+=0A=
+#define DEFAULT_POLLMASK (POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM)=0A=
+=0A=
+/* Do dynamic hashing */=0A=
+=0A=
+#define INITIAL_BUCKET_BITS 6=0A=
+#define MAX_BUCKET_BITS 16=0A=
+#define RESIZE_LENGTH	2=0A=
+=0A=
+static void free_pg_vec(struct devpoll *dp);=0A=
+=0A=
+/* Initalize the hash table */=0A=
+=0A=
+int=0A=
+dp_init(struct devpoll *dp)=0A=
+{=0A=
+	int i;=0A=
+	int num_buckets;=0A=
+	DNPRINTK(3, (KERN_INFO "/dev/poll: dp_init\n"));=0A=
+=0A=
+	dp->dp_lock =3D RW_LOCK_UNLOCKED;=0A=
+	dp->dp_entries =3D 0;=0A=
+	dp->dp_max =3D 0;=0A=
+	dp->dp_avg =3D dp->dp_count =3D 0;=0A=
+	dp->dp_cached =3D dp->dp_calls =3D 0;=0A=
+	dp->dp_bucket_bits =3D INITIAL_BUCKET_BITS;=0A=
+	dp->dp_bucket_mask =3D (1 << INITIAL_BUCKET_BITS) - 1;=0A=
+=0A=
+	num_buckets =3D (dp->dp_bucket_mask + 1);=0A=
+	dp->dp_tab =3D kmalloc(num_buckets * sizeof (struct list_head),=0A=
+			     GFP_KERNEL);=0A=
+=0A=
+	if (!dp->dp_tab)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	for (i =3D 0; i < num_buckets; i++) {=0A=
+		INIT_LIST_HEAD(&dp->dp_tab[i]);=0A=
+	}=0A=
+=0A=
+	return (0);=0A=
+}=0A=
+=0A=
+int=0A=
+dp_resize(struct devpoll *dp)=0A=
+{=0A=
+	u_int16_t new_mask, old_mask;=0A=
+	int i;=0A=
+	struct list_head *new_tab, *old_tab;=0A=
+	struct dp_fd *dpfd;=0A=
+	unsigned long flags;=0A=
+	int num_buckets;=0A=
+=0A=
+	old_mask =3D dp->dp_bucket_mask;=0A=
+	new_mask =3D (old_mask + 1) * 2 - 1;=0A=
+	num_buckets =3D new_mask + 1;=0A=
+=0A=
+	DPRINTK((KERN_INFO "/dev/poll: resize %d -> %d\n", old_mask, =
new_mask));=0A=
+=0A=
+	new_tab =3D kmalloc(num_buckets * sizeof (struct list_head), =
GFP_KERNEL);=0A=
+	if (!new_tab)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	for (i =3D 0; i < num_buckets; i++) {=0A=
+		INIT_LIST_HEAD(&new_tab[i]);=0A=
+	}=0A=
+=0A=
+	old_tab =3D dp->dp_tab;=0A=
+=0A=
+	/* Rehash all entries */=0A=
+	write_lock_irqsave(&dp->dp_lock, flags);=0A=
+	for (i =3D 0; i <=3D old_mask; i++) {=0A=
+		while (!list_empty(&old_tab[i])) {=0A=
+			dpfd =3D list_entry(old_tab[i].next, struct dp_fd, next);=0A=
+			list_del(&dpfd->next);=0A=
+			INIT_LIST_HEAD(&dpfd->next);=0A=
+			list_add(&dpfd->next,=0A=
+				 &new_tab[dpfd->pfd.fd & new_mask]);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	dp->dp_tab =3D new_tab;=0A=
+	dp->dp_bucket_bits++;=0A=
+	dp->dp_bucket_mask =3D new_mask;=0A=
+	write_unlock_irqrestore(&dp->dp_lock, flags);=0A=
+=0A=
+	kfree(old_tab);=0A=
+=0A=
+	return (0);=0A=
+}=0A=
+=0A=
+int=0A=
+dp_insert(struct devpoll *dp, struct pollfd *pfd)=0A=
+{=0A=
+	struct dp_fd *dpfd;=0A=
+	u_int16_t bucket =3D pfd->fd & dp->dp_bucket_mask;=0A=
+	unsigned long flags;=0A=
+	struct file *file;=0A=
+=0A=
+	dpfd =3D kmalloc(sizeof (struct dp_fd), GFP_KERNEL);=0A=
+	if (!dpfd)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	dpfd->flags =3D 0;=0A=
+	set_bit(DPH_DIRTY, &dpfd->flags);=0A=
+	dpfd->pfd =3D *pfd;=0A=
+	dpfd->pfd.revents =3D 0;=0A=
+	INIT_LIST_HEAD(&dpfd->next);=0A=
+=0A=
+	write_lock_irqsave(&dp->dp_lock, flags);=0A=
+=0A=
+	list_add(&dpfd->next, &dp->dp_tab[bucket]);=0A=
+=0A=
+	file =3D fcheck(pfd->fd);=0A=
+	if (file !=3D NULL) {=0A=
+		write_lock(&(file)->f_dplock);=0A=
+		poll_backmap(pfd->fd, dpfd, &(file)->f_backmap);=0A=
+		write_unlock(&(file)->f_dplock);=0A=
+		set_bit(DPH_BACKMAP, &(dpfd)->flags);=0A=
+	}=0A=
+	write_unlock_irqrestore(&dp->dp_lock, flags);=0A=
+=0A=
+	dp->dp_entries++;=0A=
+	/* Check if we need to resize the hash table */=0A=
+	if ((dp->dp_entries >> dp->dp_bucket_bits) > RESIZE_LENGTH &&=0A=
+	    dp->dp_bucket_bits < MAX_BUCKET_BITS)=0A=
+		dp_resize(dp);=0A=
+=0A=
+	return (0);=0A=
+}=0A=
+=0A=
+struct dp_fd *=0A=
+dp_find(struct devpoll *dp, int fd)=0A=
+{=0A=
+	struct dp_fd *dpfd =3D NULL;=0A=
+	struct list_head *lh;=0A=
+	u_int16_t bucket =3D fd & dp->dp_bucket_mask;=0A=
+=0A=
+	read_lock(&dp->dp_lock);=0A=
+	list_for_each(lh, &dp->dp_tab[bucket]) {=0A=
+		dpfd =3D list_entry(lh, struct dp_fd, next);=0A=
+		if (dpfd->pfd.fd =3D=3D fd)=0A=
+			break;=0A=
+		dpfd =3D NULL;=0A=
+	}=0A=
+=0A=
+	read_unlock(&dp->dp_lock);=0A=
+	DNPRINTK(2, (KERN_INFO "dp_find: %d -> %p\n", fd, dpfd));=0A=
+=0A=
+	return dpfd;=0A=
+}=0A=
+=0A=
+void=0A=
+dp_delete(struct devpoll *dp, struct dp_fd *dpfd)=0A=
+{=0A=
+	unsigned long flags;=0A=
+	int fd;=0A=
+	struct file *filp;=0A=
+=0A=
+	write_lock_irqsave(&dp->dp_lock, flags);=0A=
+	list_del(&dpfd->next);=0A=
+=0A=
+	INIT_LIST_HEAD(&dpfd->next);=0A=
+=0A=
+	/* Remove backmaps if necessary */=0A=
+	if (current->files) {=0A=
+		fd =3D dpfd->pfd.fd;=0A=
+		filp =3D fcheck(fd);=0A=
+=0A=
+		if (test_bit(DPH_BACKMAP, &dpfd->flags) &&=0A=
+		    filp && filp->f_backmap) {=0A=
+			write_lock(&filp->f_dplock);=0A=
+			poll_remove_backmap(&filp->f_backmap, fd,=0A=
+					    current->files);=0A=
+			write_unlock(&filp->f_dplock);=0A=
+		}=0A=
+	}=0A=
+	write_unlock_irqrestore(&dp->dp_lock, flags);=0A=
+=0A=
+	kfree(dpfd);=0A=
+=0A=
+	dp->dp_entries--;=0A=
+}=0A=
+=0A=
+void=0A=
+dp_free(struct devpoll *dp)=0A=
+{=0A=
+	int i;=0A=
+	struct dp_fd *dpfd =3D NULL;=0A=
+=0A=
+	lock_kernel();=0A=
+	for (i =3D 0; i <=3D dp->dp_bucket_mask; i++) {=0A=
+		while (!list_empty(&dp->dp_tab[i])) {=0A=
+			dpfd =3D=0A=
+			    list_entry(dp->dp_tab[i].next, struct dp_fd, next);=0A=
+			dp_delete(dp, dpfd);=0A=
+		}=0A=
+	}=0A=
+	unlock_kernel();=0A=
+=0A=
+	kfree(dp->dp_tab);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * poll the fds that we keep in our state, return after we reached=0A=
+ * max changed fds or are done.=0A=
+ * XXX - I do not like how the wait table stuff is done.=0A=
+ */=0A=
+=0A=
+int=0A=
+dp_poll(struct devpoll *dp, int max, poll_table * wait,=0A=
+	long timeout, struct pollfd *rfds, int usemmap)=0A=
+{=0A=
+	int count =3D 0;=0A=
+	lock_kernel();=0A=
+	read_lock(&dp->dp_lock);=0A=
+	for (;;) {=0A=
+		unsigned int j =3D 0;=0A=
+		struct dp_fd *dpfd =3D NULL;=0A=
+		struct pollfd *fdpnt, pfd;=0A=
+		struct file *file;=0A=
+=0A=
+		set_current_state(TASK_INTERRUPTIBLE);=0A=
+		for (j =3D 0; (j <=3D dp->dp_bucket_mask) && count < max; j++) {=0A=
+			struct list_head *lh;=0A=
+			list_for_each(lh, &dp->dp_tab[j]) {=0A=
+=0A=
+				int fd;=0A=
+				unsigned int mask =3D 0;=0A=
+				dpfd =3D list_entry(lh, struct dp_fd, next);=0A=
+=0A=
+				if (count >=3D max) {=0A=
+					break;=0A=
+				}=0A=
+=0A=
+				fdpnt =3D &dpfd->pfd;=0A=
+				fd =3D fdpnt->fd;=0A=
+=0A=
+				/* poll_wait increments f_count if needed */=0A=
+				file =3D fcheck(fd);=0A=
+				if (file =3D=3D NULL) {=0A=
+					/* Got to move backward first;=0A=
+					 * dp_delete will remove lh from=0A=
+					 * the list otherwise=0A=
+					 */=0A=
+					lh =3D lh->prev;=0A=
+					dp_delete(dp, dpfd);=0A=
+					dpfd =3D NULL;=0A=
+					continue;=0A=
+				}=0A=
+=0A=
+				mask =3D fdpnt->revents;=0A=
+				if (test_and_clear_bit(DPH_DIRTY,=0A=
+						       &dpfd->flags) ||=0A=
+				    wait !=3D NULL || (mask & fdpnt->events)) {=0A=
+=0A=
+					mask =3D DEFAULT_POLLMASK;=0A=
+					if (file->f_op && file->f_op->poll)=0A=
+						mask =3D=0A=
+						    file->f_op->poll(file,=0A=
+								     wait);=0A=
+					/* if POLLHINT not supported by file=0A=
+					 * then set bit to dirty ---=0A=
+					 * must poll this file every time,=0A=
+					 * otherwise bit will be set by=0A=
+					 * calls to dp_add_hint=0A=
+					 */=0A=
+					if (!(mask & POLLHINT))=0A=
+						set_bit(DPH_DIRTY,=0A=
+							&dpfd->flags);=0A=
+					fdpnt->revents =3D mask;=0A=
+				} else=0A=
+					dp->dp_cached++;=0A=
+=0A=
+				dp->dp_calls++;=0A=
+=0A=
+				mask &=3D fdpnt->events | POLLERR | POLLHUP;=0A=
+				if (mask) {=0A=
+					wait =3D NULL;=0A=
+					count++;=0A=
+=0A=
+					if (usemmap) {=0A=
+						*rfds =3D *fdpnt;=0A=
+						rfds->revents =3D mask;=0A=
+					} else {=0A=
+						pfd =3D *fdpnt;=0A=
+						pfd.revents =3D mask;=0A=
+						__copy_to_user(rfds, &pfd,=0A=
+							       sizeof (struct=0A=
+								       pollfd));=0A=
+					}=0A=
+=0A=
+					rfds++;=0A=
+				}=0A=
+			}=0A=
+		}=0A=
+=0A=
+		wait =3D NULL;=0A=
+		if (count || !timeout || signal_pending(current))=0A=
+			break;=0A=
+		read_unlock(&dp->dp_lock);=0A=
+		timeout =3D schedule_timeout(timeout);=0A=
+		read_lock(&dp->dp_lock);=0A=
+	}=0A=
+	set_current_state(TASK_RUNNING);=0A=
+	read_unlock(&dp->dp_lock);=0A=
+	unlock_kernel();=0A=
+=0A=
+	if (!count && signal_pending(current))=0A=
+		return -EINTR;=0A=
+=0A=
+	return count;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * close a /dev/poll=0A=
+ */=0A=
+=0A=
+static int=0A=
+close_devpoll(struct inode *inode, struct file *file)=0A=
+{=0A=
+	struct devpoll *dp =3D file->private_data;=0A=
+=0A=
+	DNPRINTK(1,=0A=
+		 (KERN_INFO "close /dev/poll, max: %d, avg: %d(%d/%d) %d/%d\n",=0A=
+		  dp->dp_max, dp->dp_avg / dp->dp_count, dp->dp_avg,=0A=
+		  dp->dp_count, dp->dp_cached, dp->dp_calls));=0A=
+=0A=
+	/* free allocated memory */=0A=
+	if (dp->dp_memvec)=0A=
+		free_pg_vec(dp);=0A=
+=0A=
+	/* Free the hash table */=0A=
+	dp_free(dp);=0A=
+=0A=
+	kfree(dp);=0A=
+=0A=
+	MOD_DEC_USE_COUNT;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * open a /dev/poll=0A=
+ */=0A=
+=0A=
+static int=0A=
+open_devpoll(struct inode *inode, struct file *file)=0A=
+{=0A=
+	struct devpoll *dp;=0A=
+	int r;=0A=
+=0A=
+	/* allocated state */=0A=
+	dp =3D kmalloc(sizeof (struct devpoll), GFP_KERNEL);=0A=
+	if (dp =3D=3D NULL)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	memset(dp, 0, sizeof (struct devpoll));=0A=
+	if ((r =3D dp_init(dp))) {=0A=
+		kfree(dp);=0A=
+		return r;=0A=
+	}=0A=
+=0A=
+	file->private_data =3D dp;=0A=
+=0A=
+	MOD_INC_USE_COUNT;=0A=
+=0A=
+	DNPRINTK(3, (KERN_INFO "open /dev/poll\n"));=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * write to /dev/poll:=0A=
+ * a user writes struct pollfds and we add them to our list, or remove=0A=
+ * them if (events & POLLREMOVE) is true=0A=
+ */=0A=
+=0A=
+static int=0A=
+write_devpoll(struct file *file, const char *buffer, size_t count,=0A=
+	      loff_t * ppos)=0A=
+{=0A=
+	int r, rcount;=0A=
+	struct devpoll *dp =3D file->private_data;=0A=
+	struct pollfd pfd;=0A=
+	struct dp_fd *dpfd;=0A=
+#ifdef DEBUG=0A=
+	int add =3D 0, delete =3D 0, change =3D 0;=0A=
+#endif=0A=
+=0A=
+	DNPRINTK(3, (KERN_INFO "write /dev/poll %i\n", count));=0A=
+=0A=
+	if (count % sizeof (struct pollfd))=0A=
+		return -EINVAL;=0A=
+=0A=
+	if ((r =3D verify_area(VERIFY_READ, buffer, count)))=0A=
+		return r;=0A=
+=0A=
+	rcount =3D count;=0A=
+=0A=
+	lock_kernel();=0A=
+=0A=
+	while (count > 0) {=0A=
+		__copy_from_user(&pfd, buffer, sizeof (pfd));	/* no check */=0A=
+=0A=
+		dpfd =3D dp_find(dp, pfd.fd);=0A=
+=0A=
+		if (pfd.fd >=3D current->files->max_fds ||=0A=
+		    current->files->fd[pfd.fd] =3D=3D NULL) {=0A=
+			/* Be tolerant, maybe the close happened already */=0A=
+			pfd.events =3D POLLREMOVE;=0A=
+		}=0A=
+		/* See if we need to remove the file descriptor.  If it=0A=
+		 * already exists OR the event fields, otherwise insert=0A=
+		 */=0A=
+		if (pfd.events & POLLREMOVE) {=0A=
+			if (dpfd)=0A=
+				dp_delete(dp, dpfd);=0A=
+#ifdef DEBUG=0A=
+			delete++;=0A=
+#endif=0A=
+		} else if (dpfd) {=0A=
+			/* XXX dpfd->pfd.events |=3D pfd.events; */=0A=
+			dpfd->pfd.events =3D pfd.events;=0A=
+#ifdef DEBUG=0A=
+			change++;=0A=
+#endif=0A=
+		} else {=0A=
+			dp_insert(dp, &pfd);=0A=
+#ifdef DEBUG=0A=
+			add++;=0A=
+#endif=0A=
+		}=0A=
+=0A=
+		buffer +=3D sizeof (pfd);=0A=
+		count -=3D sizeof (pfd);=0A=
+	}=0A=
+=0A=
+	unlock_kernel();=0A=
+=0A=
+	if (dp->dp_max < dp->dp_entries) {=0A=
+		dp->dp_max =3D dp->dp_entries;=0A=
+		DNPRINTK(2, (KERN_INFO "/dev/poll: new max %d\n", dp->dp_max));=0A=
+	}=0A=
+=0A=
+	DNPRINTK(3, (KERN_INFO "write /dev/poll: %d entries (%d/%d/%d)\n",=0A=
+		     dp->dp_entries, add, delete, change));=0A=
+=0A=
+	return (rcount);=0A=
+}=0A=
+=0A=
+static int=0A=
+ioctl_devpoll(struct inode *inode, struct file *file,=0A=
+	      unsigned int cmd, unsigned long arg)=0A=
+{=0A=
+	struct devpoll *dp =3D file->private_data;=0A=
+	unsigned mapsize =3D 0;=0A=
+	unsigned num_pages =3D 0;=0A=
+	int i =3D 0;=0A=
+	switch (cmd) {=0A=
+	case DP_ALLOC:=0A=
+		if (arg > current->rlim[RLIMIT_NOFILE].rlim_cur)=0A=
+			return -EINVAL;=0A=
+		if (dp->dp_mmap)=0A=
+			return -EPERM;=0A=
+=0A=
+		mapsize =3D DP_MMAP_SIZE(arg);=0A=
+		num_pages =3D (PAGE_ALIGN(mapsize) >> PAGE_SHIFT);=0A=
+=0A=
+		dp->dp_memvec =3D kmalloc(num_pages * sizeof (unsigned long *),=0A=
+					GFP_KERNEL);=0A=
+=0A=
+		if (dp->dp_memvec =3D=3D NULL)=0A=
+			return -EINVAL;=0A=
+=0A=
+		memset(dp->dp_memvec, 0, num_pages * sizeof (unsigned long *));=0A=
+=0A=
+		for (i =3D 0; i < num_pages; ++i) {=0A=
+			struct page *page, *page_end;=0A=
+=0A=
+			dp->dp_memvec[i] =3D=0A=
+			    (u_char *) __get_free_pages(GFP_KERNEL, 0);=0A=
+			if (!dp->dp_memvec[i]) {=0A=
+				free_pg_vec(dp);=0A=
+				return -ENOMEM;=0A=
+			}=0A=
+=0A=
+			page_end =3D=0A=
+			    virt_to_page(dp->dp_memvec[i] + PAGE_SIZE - 1);=0A=
+			for (page =3D virt_to_page(dp->dp_memvec[i]);=0A=
+			     page <=3D page_end; page++)=0A=
+				set_bit(PG_reserved, &page->flags);=0A=
+=0A=
+			++dp->dp_numvec;=0A=
+		}=0A=
+=0A=
+		dp->dp_nfds =3D arg;=0A=
+=0A=
+		DPRINTK((KERN_INFO "allocated %d pollfds\n", dp->dp_nfds));=0A=
+=0A=
+		return 0;=0A=
+	case DP_FREE:=0A=
+		if (atomic_read(&dp->dp_mmapped))=0A=
+			return -EBUSY;=0A=
+=0A=
+		if (dp->dp_memvec[i]) {=0A=
+			free_pg_vec(dp);=0A=
+		}=0A=
+=0A=
+		DPRINTK((KERN_INFO "freed %d pollfds\n", dp->dp_nfds));=0A=
+		dp->dp_nfds =3D 0;=0A=
+=0A=
+		return 0;=0A=
+	case DP_ISPOLLED:{=0A=
+			struct pollfd pfd;=0A=
+			struct dp_fd *dpfd;=0A=
+=0A=
+			if (copy_from_user(&pfd, (void *) arg, sizeof (pfd)))=0A=
+				return -EFAULT;=0A=
+			dpfd =3D dp_find(dp, pfd.fd);=0A=
+			if (dpfd =3D=3D NULL)=0A=
+				return (0);=0A=
+=0A=
+			/* We poll this fd, return the evens we poll on */=0A=
+			pfd.events =3D dpfd->pfd.events;=0A=
+			pfd.revents =3D 0;=0A=
+=0A=
+			if (copy_to_user((void *) arg, &pfd, sizeof (pfd)))=0A=
+				return -EFAULT;=0A=
+			return (1);=0A=
+		}=0A=
+	case DP_POLL:{=0A=
+			struct dvpoll dopoll;=0A=
+			int nfds, usemmap =3D 0;=0A=
+			unsigned long timeout;=0A=
+			poll_table wait;=0A=
+			struct pollfd *rpfds =3D NULL;=0A=
+=0A=
+			if (copy_from_user=0A=
+			    (&dopoll, (void *) arg, sizeof (dopoll)))=0A=
+				return -EFAULT;=0A=
+=0A=
+			/* We do not need to check this value, its user space */=0A=
+			nfds =3D dopoll.dp_nfds;=0A=
+			if (nfds <=3D 0)=0A=
+				return -EINVAL;=0A=
+=0A=
+			if (dopoll.dp_fds =3D=3D NULL) {=0A=
+				if (dp->dp_mmap =3D=3D NULL)=0A=
+					return -EINVAL;=0A=
+				rpfds =3D (struct pollfd *) dp->dp_mmap;=0A=
+				usemmap =3D 1;=0A=
+			} else {=0A=
+				rpfds =3D dopoll.dp_fds;=0A=
+				if (verify_area(VERIFY_WRITE, rpfds,=0A=
+						nfds * sizeof (struct pollfd)))=0A=
+					return -EFAULT;=0A=
+				usemmap =3D 0;=0A=
+			}=0A=
+=0A=
+			timeout =3D dopoll.dp_timeout;=0A=
+			if (timeout) {=0A=
+				/* Careful about overflow in the intermediate values */=0A=
+				if ((unsigned long) timeout <=0A=
+				    MAX_SCHEDULE_TIMEOUT / HZ)=0A=
+					timeout =3D=0A=
+					    (timeout * HZ + 999) / 1000 + 1;=0A=
+				else	/* Negative or overflow */=0A=
+					timeout =3D MAX_SCHEDULE_TIMEOUT;=0A=
+			}=0A=
+=0A=
+			/* Initalize wait table */=0A=
+			poll_initwait(&wait);=0A=
+=0A=
+			nfds =3D=0A=
+			    dp_poll(dp, nfds, &wait, timeout, rpfds, usemmap);=0A=
+=0A=
+			DNPRINTK(2,=0A=
+				 (KERN_INFO "poll time %ld -> %d\n", timeout,=0A=
+				  nfds));=0A=
+=0A=
+			poll_freewait(&wait);=0A=
+=0A=
+			dp->dp_avg +=3D dp->dp_entries;=0A=
+			dp->dp_count++;=0A=
+=0A=
+			return nfds;=0A=
+		}=0A=
+	default:=0A=
+		DPRINTK((KERN_INFO "ioctl(%x) /dev/poll\n", cmd));=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	return -EINVAL;=0A=
+}=0A=
+=0A=
+static void=0A=
+free_pg_vec(struct devpoll *dp)=0A=
+{=0A=
+	int i;=0A=
+=0A=
+	for (i =3D 0; i < dp->dp_numvec; i++) {=0A=
+		if (dp->dp_memvec[i]) {=0A=
+			struct page *page, *page_end;=0A=
+=0A=
+			page_end =3D=0A=
+			    virt_to_page(dp->dp_memvec[i] + PAGE_SIZE - 1);=0A=
+			for (page =3D virt_to_page(dp->dp_memvec[i]);=0A=
+			     page <=3D page_end; page++)=0A=
+				clear_bit(PG_reserved, &page->flags);=0A=
+=0A=
+			free_pages((unsigned) dp->dp_memvec[i], 0);=0A=
+		}=0A=
+	}=0A=
+	kfree(dp->dp_memvec);=0A=
+	dp->dp_numvec =3D 0;=0A=
+}=0A=
+=0A=
+static void=0A=
+devpoll_mm_open(struct vm_area_struct *vma)=0A=
+{=0A=
+	struct file *file =3D vma->vm_file;=0A=
+	struct devpoll *dp =3D file->private_data;=0A=
+	if (dp)=0A=
+		atomic_inc(&dp->dp_mmapped);=0A=
+}=0A=
+=0A=
+static void=0A=
+devpoll_mm_close(struct vm_area_struct *vma)=0A=
+{=0A=
+	struct file *file =3D vma->vm_file;=0A=
+	struct devpoll *dp =3D file->private_data;=0A=
+	if (dp)=0A=
+		atomic_dec(&dp->dp_mmapped);=0A=
+}=0A=
+=0A=
+static struct vm_operations_struct devpoll_mmap_ops =3D {=0A=
+	open:devpoll_mm_open,=0A=
+	close:devpoll_mm_close,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * mmap shared memory.  the first half is an array  of struct pollfd,=0A=
+ * followed by an array of ints to indicate which file descriptors=0A=
+ * changed status.=0A=
+ */=0A=
+=0A=
+static int=0A=
+mmap_devpoll(struct file *file, struct vm_area_struct *vma)=0A=
+{=0A=
+	struct devpoll *dp =3D file->private_data;=0A=
+	unsigned long start;	/* Evil type to remap_page_range */=0A=
+	int i =3D 0;=0A=
+	int num_pages =3D 0;=0A=
+	size_t size, mapsize;=0A=
+=0A=
+	DPRINTK((KERN_INFO "mmap /dev/poll: %lx %lx\n",=0A=
+		 vma->vm_start, vma->vm_pgoff << PAGE_SHIFT));=0A=
+=0A=
+	if ((vma->vm_pgoff << PAGE_SHIFT) !=3D 0)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/* Calculate how much memory we can map */=0A=
+	size =3D PAGE_ALIGN(DP_MMAP_SIZE(dp->dp_nfds));=0A=
+	mapsize =3D PAGE_ALIGN(vma->vm_end - vma->vm_start);=0A=
+	num_pages =3D mapsize >> PAGE_SHIFT;=0A=
+=0A=
+	/* Check if the requested size is within our size */=0A=
+	if (mapsize > dp->dp_numvec << PAGE_SHIFT)=0A=
+		return -EINVAL;=0A=
+=0A=
+	start =3D vma->vm_start;=0A=
+	atomic_set(&dp->dp_mmapped, 1);=0A=
+	for (i =3D 0; i < num_pages; ++i) {=0A=
+		if (remap_page_range(start, __pa(dp->dp_memvec[i]),=0A=
+				     PAGE_SIZE, vma->vm_page_prot))=0A=
+			return -EINVAL;=0A=
+		start +=3D PAGE_SIZE;=0A=
+	}=0A=
+	dp->dp_mmap =3D (u_char *) vma->vm_start;=0A=
+	vma->vm_ops =3D &devpoll_mmap_ops;=0A=
+=0A=
+	DPRINTK((KERN_INFO "mmap /dev/poll: %lx %x\n", page, mapsize));=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+struct file_operations devpoll_fops =3D {=0A=
+	write:write_devpoll,=0A=
+	ioctl:ioctl_devpoll,=0A=
+	mmap:mmap_devpoll,=0A=
+	open:open_devpoll,=0A=
+	release:close_devpoll=0A=
+};=0A=
+=0A=
+static struct miscdevice devpoll =3D {=0A=
+	DEVPOLL_MINOR, "devpoll", &devpoll_fops=0A=
+};=0A=
+=0A=
+int __init=0A=
+devpoll_init(void)=0A=
+{=0A=
+	printk(KERN_INFO "/dev/poll driver installed.\n");=0A=
+	misc_register(&devpoll);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+module_init(devpoll_init);=0A=
+#ifdef MODULE=0A=
+=0A=
+void=0A=
+cleanup_module(void)=0A=
+{=0A=
+	misc_deregister(&devpoll);=0A=
+}=0A=
+#endif=0A=
diff -rNu linux.orig/fs/file_table.c linux/fs/file_table.c=0A=
--- linux.orig/fs/file_table.c	Wed Apr 18 19:49:12 2001=0A=
+++ linux/fs/file_table.c	Wed Jun 27 16:49:49 2001=0A=
@@ -11,6 +11,7 @@=0A=
 #include <linux/init.h>=0A=
 #include <linux/module.h>=0A=
 #include <linux/smp_lock.h>=0A=
+#include <linux/spinlock.h>=0A=
 =0A=
 /* sysctl tunables... */=0A=
 struct files_stat_struct files_stat =3D {0, 0, NR_FILE};=0A=
@@ -45,6 +46,7 @@=0A=
 		f->f_version =3D ++event;=0A=
 		f->f_uid =3D current->fsuid;=0A=
 		f->f_gid =3D current->fsgid;=0A=
+		rwlock_init(&f->f_dplock);=0A=
 		list_add(&f->f_list, &anon_list);=0A=
 		file_list_unlock();=0A=
 		return f;=0A=
diff -rNu linux.orig/fs/open.c linux/fs/open.c=0A=
--- linux.orig/fs/open.c	Fri Feb  9 19:29:44 2001=0A=
+++ linux/fs/open.c	Wed Jun 27 18:01:15 2001=0A=
@@ -14,6 +14,8 @@=0A=
 #include <linux/module.h>=0A=
 #include <linux/slab.h>=0A=
 #include <linux/tty.h>=0A=
+#include <linux/poll.h>=0A=
+#include <linux/devpoll.h>=0A=
 =0A=
 #include <asm/uaccess.h>=0A=
 =0A=
@@ -802,6 +805,14 @@=0A=
 		retval =3D filp->f_op->flush(filp);=0A=
 		unlock_kernel();=0A=
 	}=0A=
+=0A=
+	if (filp->f_backmap) {=0A=
+		unsigned long flags;=0A=
+		write_lock_irqsave(&filp->f_dplock,flags);=0A=
+		poll_clean_backmap(&filp->f_backmap);=0A=
+		write_unlock_irqrestore(&filp->f_dplock,flags);=0A=
+	}=0A=
+=0A=
 	fcntl_dirnotify(0, filp, 0);=0A=
 	locks_remove_posix(filp, id);=0A=
 	fput(filp);=0A=
@@ -828,6 +839,14 @@=0A=
 	FD_CLR(fd, files->close_on_exec);=0A=
 	__put_unused_fd(files, fd);=0A=
 	write_unlock(&files->file_lock);=0A=
+=0A=
+	if (filp->f_backmap) {=0A=
+		unsigned long flags;=0A=
+		write_lock_irqsave(&filp->f_dplock,flags);=0A=
+		poll_remove_backmap(&filp->f_backmap,fd, files);=0A=
+		write_unlock_irqrestore(&filp->f_dplock,flags);=0A=
+	}=0A=
+	=0A=
 	return filp_close(filp, files);=0A=
 =0A=
 out_unlock:=0A=
diff -rNu linux.orig/include/asm-i386/poll.h =
linux/include/asm-i386/poll.h=0A=
--- linux.orig/include/asm-i386/poll.h	Thu Jan 23 19:01:28 1997=0A=
+++ linux/include/asm-i386/poll.h	Wed Jun 27 17:16:57 2001=0A=
@@ -15,6 +15,8 @@=0A=
 #define POLLWRNORM	0x0100=0A=
 #define POLLWRBAND	0x0200=0A=
 #define POLLMSG		0x0400=0A=
+#define POLLREMOVE	0x1000=0A=
+#define POLLHINT	0x2000=0A=
 =0A=
 struct pollfd {=0A=
 	int fd;=0A=
diff -rNu linux.orig/include/linux/devpoll.h =
linux/include/linux/devpoll.h=0A=
--- linux.orig/include/linux/devpoll.h	Thu Jan  1 01:00:00 1970=0A=
+++ linux/include/linux/devpoll.h	Wed Jun 27 19:58:52 2001=0A=
@@ -0,0 +1,85 @@=0A=
+/*=0A=
+ * /dev/poll=0A=
+ * by Niels Provos <provos@citi.umich.edu>=0A=
+ *=0A=
+ * provides poll() support via /dev/poll as in Solaris.=0A=
+ *=0A=
+ * Linux 2.3.x port by Michal Ostrowski=0A=
+ * Linux 2.4.x patches by Vincent Sweeney <v.sweeney@dexterus.com>=0A=
+ */=0A=
+=0A=
+#ifndef _LINUX_DEVPOLL_H=0A=
+#define _LINUX_DEVPOLL_H=0A=
+=0A=
+#include <asm/bitops.h>=0A=
+#include <linux/list.h>=0A=
+#include <asm/atomic.h>=0A=
+=0A=
+#define DPH_DIRTY	0	/* entry is dirty - bit */=0A=
+#define DPH_BACKMAP	1	/* file has an fd back map - bit */=0A=
+#ifdef __KERNEL__=0A=
+struct dp_fd {=0A=
+	struct list_head next;=0A=
+	struct pollfd pfd;=0A=
+	int flags;		/* for hinting */=0A=
+};=0A=
+=0A=
+struct devpoll {=0A=
+	struct list_head *dp_tab;=0A=
+	int dp_entries;		/* Entries in hash table */=0A=
+	int dp_max;		/* statistics */=0A=
+	int dp_avg;		/* more */=0A=
+	int dp_count;=0A=
+	int dp_cached;=0A=
+	int dp_calls;=0A=
+	int dp_bucket_bits;=0A=
+	int dp_bucket_mask;=0A=
+	int dp_nfds;		/* Number of poll fds */=0A=
+	u_char *dp_mmap;	/* vaddr of mapped region */=0A=
+	atomic_t dp_mmapped;	/* Are we mmapped */=0A=
+	rwlock_t dp_lock;=0A=
+	u_char **dp_memvec;	/* Pointer to pages allocated for mmap */=0A=
+	int dp_numvec;		/* Size of above array */=0A=
+};=0A=
+#endif=0A=
+/* Match solaris */=0A=
+=0A=
+struct dvpoll {=0A=
+	struct pollfd *dp_fds;	/* Leave this ZERO for mmap */=0A=
+	int dp_nfds;=0A=
+	int dp_timeout;=0A=
+};=0A=
+=0A=
+#define DEVPOLL_MINOR       125	/* Minor device # for /dev/poll */=0A=
+=0A=
+#define DP_MMAP_SIZE(x)	((x) * sizeof(struct pollfd))=0A=
+=0A=
+#define DP_ALLOC	_IOR('P', 1, int)=0A=
+#define DP_POLL		_IOWR('P', 2, struct dvpoll)=0A=
+#define DP_FREE		_IO('P', 3)=0A=
+#define DP_ISPOLLED	_IOWR('P', 4, struct pollfd)=0A=
+=0A=
+#ifdef __KERNEL__=0A=
+extern rwlock_t devpoll_lock;=0A=
+/* Function Prototypes */=0A=
+=0A=
+extern inline void=0A=
+dp_add_hint (struct poll_backmap **map, rwlock_t * lock)=0A=
+{=0A=
+	struct poll_backmap *entry;=0A=
+	struct dp_fd *dpfd;=0A=
+	if (!map)=0A=
+		return;=0A=
+=0A=
+	read_lock (lock);=0A=
+	entry =3D *map;=0A=
+	while (entry) {=0A=
+		dpfd =3D entry->arg;=0A=
+		set_bit (DPH_DIRTY, &dpfd->flags);	/* atomic */=0A=
+		entry =3D entry->next;=0A=
+	}=0A=
+	read_unlock (lock);=0A=
+}=0A=
+#endif				/* __KERNEL__ */=0A=
+=0A=
+#endif=0A=
diff -rNu linux.orig/include/linux/fs.h linux/include/linux/fs.h=0A=
--- linux.orig/include/linux/fs.h	Sat May 26 02:01:28 2001=0A=
+++ linux/include/linux/fs.h	Wed Jun 27 19:20:36 2001=0A=
@@ -502,6 +502,10 @@=0A=
 	int			f_error;=0A=
 =0A=
 	unsigned long		f_version;=0A=
+	=0A=
+	/* used by /dev/poll hinting */=0A=
+	struct poll_backmap	*f_backmap;=0A=
+	rwlock_t		f_dplock;=0A=
 =0A=
 	/* needed for tty driver, and maybe others */=0A=
 	void			*private_data;=0A=
diff -rNu linux.orig/include/linux/poll.h linux/include/linux/poll.h=0A=
--- linux.orig/include/linux/poll.h	Sat May 26 02:01:43 2001=0A=
+++ linux/include/linux/poll.h	Wed Jun 27 19:21:05 2001=0A=
@@ -8,10 +8,18 @@=0A=
 #include <linux/wait.h>=0A=
 #include <linux/string.h>=0A=
 #include <linux/mm.h>=0A=
+#include <linux/malloc.h>=0A=
 #include <asm/uaccess.h>=0A=
 =0A=
 struct poll_table_page;=0A=
 =0A=
+struct poll_backmap {=0A=
+	struct poll_backmap *next;=0A=
+	void *arg;			/* pointer to devpoll */=0A=
+	struct files_struct *files;	/* files which has this file as */=0A=
+	int fd;				/* file descriptor number fd */=0A=
+};=0A=
+=0A=
 typedef struct poll_table_struct {=0A=
 	int error;=0A=
 	struct poll_table_page * table;=0A=
@@ -83,7 +91,88 @@=0A=
 	memset(fdset, 0, FDS_BYTES(nr));=0A=
 }=0A=
 =0A=
+extern inline void=0A=
+poll_backmap(int fd, void *arg, struct poll_backmap ** entry)=0A=
+{=0A=
+	struct poll_backmap *tmp;=0A=
+=0A=
+	if (!entry)=0A=
+		return;=0A=
+=0A=
+	/*=0A=
+	 * See if we have an entry in the backmap already, in general=0A=
+	 * we expect this linked list to be very short.=0A=
+	 */=0A=
+	tmp =3D *entry;=0A=
+	while (tmp !=3D NULL) {=0A=
+		if (tmp->files =3D=3D current->files && tmp->fd =3D=3D fd && =0A=
+		    arg=3D=3Dtmp->arg)=0A=
+			return;=0A=
+		tmp =3D tmp->next;=0A=
+	}=0A=
+=0A=
+	tmp =3D (struct poll_backmap *) kmalloc(sizeof(*entry), GFP_KERNEL);=0A=
+	if (tmp =3D=3D NULL)=0A=
+		return;=0A=
+=0A=
+	tmp->arg =3D arg;=0A=
+	tmp->files =3D current->files;=0A=
+	tmp->fd =3D fd;=0A=
+	tmp->next =3D *entry;=0A=
+=0A=
+	*entry =3D tmp;=0A=
+}=0A=
+=0A=
+extern inline void poll_remove_backmap(struct poll_backmap **map, int =
fd,=0A=
+				       struct files_struct *files)=0A=
+{=0A=
+	struct poll_backmap *tmp =3D *map, *old =3D NULL;=0A=
+	=0A=
+	while (tmp !=3D NULL) {=0A=
+		if (tmp->files =3D=3D files && tmp->fd =3D=3D fd) {=0A=
+			struct poll_backmap *next =3D tmp->next;=0A=
+			if( old=3D=3DNULL )=0A=
+				*map =3D next;=0A=
+			else=0A=
+				old->next =3D next;=0A=
+			kfree(tmp);=0A=
+			tmp =3D next;=0A=
+		} else {=0A=
+			old =3D tmp;=0A=
+			tmp =3D tmp->next;=0A=
+		}=0A=
+	}=0A=
+	=0A=
+	if (!tmp)=0A=
+		return;=0A=
+	=0A=
+	if (old =3D=3D NULL)=0A=
+		*map =3D tmp->next;=0A=
+	else =0A=
+		old->next =3D tmp->next;=0A=
+=0A=
+	kfree (tmp);=0A=
+}=0A=
+=0A=
+extern inline void poll_clean_backmap(struct poll_backmap **map)=0A=
+{=0A=
+	struct poll_backmap *tmp =3D *map, *old;=0A=
+=0A=
+	printk("poll_clean_backmap: map %p\n", map);=0A=
+	printk("poll_clean_backmap: *map %p\n", *map);=0A=
+=0A=
+	while (tmp) {=0A=
+	  printk("poll_clean_backmap: tmp %p\n", tmp);=0A=
+		old =3D tmp;=0A=
+		tmp =3D tmp->next;=0A=
+		kfree (old);=0A=
+	}=0A=
+=0A=
+	*map =3D NULL;=0A=
+}=0A=
+=0A=
 extern int do_select(int n, fd_set_bits *fds, long *timeout);=0A=
+extern void poll_freewait(poll_table *p);=0A=
 =0A=
 #endif /* KERNEL */=0A=
 =0A=
diff -rNu linux.orig/include/net/sock.h linux/include/net/sock.h=0A=
--- linux.orig/include/net/sock.h	Sat May 26 02:03:05 2001=0A=
+++ linux/include/net/sock.h	Wed Jun 27 19:21:05 2001=0A=
@@ -666,6 +666,10 @@=0A=
 	/* Identd and reporting IO signals */=0A=
 	struct socket		*socket;=0A=
 =0A=
+	/* For Poll hinting */=0A=
+	void			*backmap;=0A=
+	void			*dplock;=0A=
+=0A=
 	/* RPC layer private data */=0A=
 	void			*user_data;=0A=
   =0A=
diff -rNu linux.orig/net/core/datagram.c linux/net/core/datagram.c=0A=
--- linux.orig/net/core/datagram.c	Thu Apr 12 20:11:39 2001=0A=
+++ linux/net/core/datagram.c	Wed Jun 27 17:28:29 2001=0A=
@@ -402,8 +402,6 @@=0A=
 	return -EFAULT;=0A=
 }=0A=
 =0A=
-=0A=
-=0A=
 /*=0A=
  *	Datagram poll: Again totally generic. This also handles=0A=
  *	sequenced packet sockets providing the socket receive queue=0A=
@@ -420,7 +418,10 @@=0A=
 	unsigned int mask;=0A=
 =0A=
 	poll_wait(file, sk->sleep, wait);=0A=
-	mask =3D 0;=0A=
+	mask =3D POLLHINT;=0A=
+	=0A=
+	sk->backmap =3D &file->f_backmap;=0A=
+	sk->dplock  =3D &file->f_dplock;=0A=
 =0A=
 	/* exceptional events? */=0A=
 	if (sk->err || !skb_queue_empty(&sk->error_queue))=0A=
diff -rNu linux.orig/net/core/sock.c linux/net/core/sock.c=0A=
--- linux.orig/net/core/sock.c	Wed Apr 25 22:57:39 2001=0A=
+++ linux/net/core/sock.c	Wed Jun 27 18:04:44 2001=0A=
@@ -108,6 +108,7 @@=0A=
 #include <linux/interrupt.h>=0A=
 #include <linux/poll.h>=0A=
 #include <linux/init.h>=0A=
+#include <linux/devpoll.h>=0A=
 =0A=
 #include <asm/uaccess.h>=0A=
 #include <asm/system.h>=0A=
@@ -1100,16 +1101,20 @@=0A=
 void sock_def_wakeup(struct sock *sk)=0A=
 {=0A=
 	read_lock(&sk->callback_lock);=0A=
-	if (sk->sleep && waitqueue_active(sk->sleep))=0A=
+	if (sk->sleep && waitqueue_active(sk->sleep)) {=0A=
+		dp_add_hint(sk->backmap, sk->dplock);=0A=
 		wake_up_interruptible_all(sk->sleep);=0A=
+	}=0A=
 	read_unlock(&sk->callback_lock);=0A=
 }=0A=
 =0A=
 void sock_def_error_report(struct sock *sk)=0A=
 {=0A=
 	read_lock(&sk->callback_lock);=0A=
-	if (sk->sleep && waitqueue_active(sk->sleep))=0A=
+	if (sk->sleep && waitqueue_active(sk->sleep)) {=0A=
+		dp_add_hint(sk->backmap, sk->dplock);=0A=
 		wake_up_interruptible(sk->sleep);=0A=
+	}=0A=
 	sk_wake_async(sk,0,POLL_ERR); =0A=
 	read_unlock(&sk->callback_lock);=0A=
 }=0A=
@@ -1117,8 +1122,10 @@=0A=
 void sock_def_readable(struct sock *sk, int len)=0A=
 {=0A=
 	read_lock(&sk->callback_lock);=0A=
-	if (sk->sleep && waitqueue_active(sk->sleep))=0A=
+	if (sk->sleep && waitqueue_active(sk->sleep)) {=0A=
+		dp_add_hint(sk->backmap, sk->dplock);=0A=
 		wake_up_interruptible(sk->sleep);=0A=
+	}=0A=
 	sk_wake_async(sk,1,POLL_IN);=0A=
 	read_unlock(&sk->callback_lock);=0A=
 }=0A=
@@ -1131,8 +1138,10 @@=0A=
 	 * progress.  --DaveM=0A=
 	 */=0A=
 	if((atomic_read(&sk->wmem_alloc) << 1) <=3D sk->sndbuf) {=0A=
-		if (sk->sleep && waitqueue_active(sk->sleep))=0A=
+		if (sk->sleep && waitqueue_active(sk->sleep)) {=0A=
+			dp_add_hint(sk->backmap, sk->dplock);		=0A=
 			wake_up_interruptible(sk->sleep);=0A=
+		}=0A=
 =0A=
 		/* Should agree with poll, otherwise some programs break */=0A=
 		if (sock_writeable(sk))=0A=
@@ -1163,6 +1172,9 @@=0A=
 	sk->zapped	=3D	1;=0A=
 	sk->socket	=3D	sock;=0A=
 =0A=
+	sk->backmap	=3D	NULL;=0A=
+	sk->dplock	=3D	NULL;=0A=
+	=0A=
 	if(sock)=0A=
 	{=0A=
 		sk->type	=3D	sock->type;=0A=
diff -rNu linux.orig/net/ipv4/af_inet.c linux/net/ipv4/af_inet.c=0A=
--- linux.orig/net/ipv4/af_inet.c	Wed May  2 04:59:24 2001=0A=
+++ linux/net/ipv4/af_inet.c	Wed Jun 27 18:06:43 2001=0A=
@@ -444,6 +444,7 @@=0A=
 		if (sk->linger && !(current->flags & PF_EXITING))=0A=
 			timeout =3D sk->lingertime;=0A=
 		sock->sk =3D NULL;=0A=
+		sk->backmap =3D NULL;=0A=
 		sk->prot->close(sk, timeout);=0A=
 	}=0A=
 	return(0);=0A=
diff -rNu linux.orig/net/ipv4/tcp.c linux/net/ipv4/tcp.c=0A=
--- linux.orig/net/ipv4/tcp.c	Wed May 16 18:31:27 2001=0A=
+++ linux/net/ipv4/tcp.c	Wed Jun 27 17:37:22 2001=0A=
@@ -249,6 +249,7 @@=0A=
 #include <linux/types.h>=0A=
 #include <linux/fcntl.h>=0A=
 #include <linux/poll.h>=0A=
+#include <linux/devpoll.h>=0A=
 #include <linux/init.h>=0A=
 #include <linux/smp_lock.h>=0A=
 =0A=
@@ -380,8 +381,12 @@=0A=
 	struct tcp_opt *tp =3D &(sk->tp_pinfo.af_tcp);=0A=
 =0A=
 	poll_wait(file, sk->sleep, wait);=0A=
+=0A=
+	sk->backmap =3D &file->f_backmap;=0A=
+	sk->dplock  =3D &file->f_dplock;=0A=
+=0A=
 	if (sk->state =3D=3D TCP_LISTEN)=0A=
-		return tcp_listen_poll(sk, wait);=0A=
+		return tcp_listen_poll(sk, wait) | POLLHINT;=0A=
 =0A=
 	/* Socket is not locked. We are protected from async events=0A=
 	   by poll logic and correct handling of state changes=0A=
@@ -454,7 +459,7 @@=0A=
 		if (tp->urg_data & TCP_URG_VALID)=0A=
 			mask |=3D POLLPRI;=0A=
 	}=0A=
-	return mask;=0A=
+	return mask | POLLHINT;=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -467,8 +472,10 @@=0A=
 	if (tcp_wspace(sk) >=3D tcp_min_write_space(sk) && sock) {=0A=
 		clear_bit(SOCK_NOSPACE, &sock->flags);=0A=
 =0A=
-		if (sk->sleep && waitqueue_active(sk->sleep))=0A=
+		if (sk->sleep && waitqueue_active(sk->sleep)) {=0A=
+			dp_add_hint(sk->backmap, sk->dplock);=0A=
 			wake_up_interruptible(sk->sleep);=0A=
+		}=0A=
 =0A=
 		if (sock->fasync_list && !(sk->shutdown&SEND_SHUTDOWN))=0A=
 			sock_wake_async(sock, 2, POLL_OUT);=0A=
diff -rNu linux.orig/net/unix/af_unix.c linux/net/unix/af_unix.c=0A=
--- linux.orig/net/unix/af_unix.c	Thu Apr 12 20:11:39 2001=0A=
+++ linux/net/unix/af_unix.c	Wed Jun 27 17:39:17 2001=0A=
@@ -107,6 +107,7 @@=0A=
 #include <net/scm.h>=0A=
 #include <linux/init.h>=0A=
 #include <linux/poll.h>=0A=
+#include <linux/devpoll.h>=0A=
 #include <linux/smp_lock.h>=0A=
 =0A=
 #include <asm/checksum.h>=0A=
@@ -299,8 +300,10 @@=0A=
 {=0A=
 	read_lock(&sk->callback_lock);=0A=
 	if (unix_writable(sk)) {=0A=
-		if (sk->sleep && waitqueue_active(sk->sleep))=0A=
+		if (sk->sleep && waitqueue_active(sk->sleep)) {=0A=
+			dp_add_hint(sk->backmap,sk->dplock);=0A=
 			wake_up_interruptible(sk->sleep);=0A=
+		}=0A=
 		sk_wake_async(sk, 2, POLL_OUT);=0A=
 	}=0A=
 	read_unlock(&sk->callback_lock);=0A=
@@ -1698,7 +1701,10 @@=0A=
 	unsigned int mask;=0A=
 =0A=
 	poll_wait(file, sk->sleep, wait);=0A=
-	mask =3D 0;=0A=
+	mask =3D POLLHINT;=0A=
+=0A=
+	sk->backmap =3D &file->f_backmap;=0A=
+	sk->dplock  =3D &file->f_dplock;=0A=
 =0A=
 	/* exceptional events? */=0A=
 	if (sk->err)=0A=

------=_NextPart_000_00B8_01C0FF48.6811D060--


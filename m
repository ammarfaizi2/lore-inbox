Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290962AbSBFXmi>; Wed, 6 Feb 2002 18:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290953AbSBFXmZ>; Wed, 6 Feb 2002 18:42:25 -0500
Received: from panoramix.vasoftware.com ([198.186.202.147]:2030 "EHLO
	mail2.vasoftware.com") by vger.kernel.org with ESMTP
	id <S290958AbSBFXla>; Wed, 6 Feb 2002 18:41:30 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15457.48373.737875.173842@argo.ozlabs.ibm.com>
Date: Thu, 7 Feb 2002 10:32:05 +1100 (EST)
To: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH] PPP fixes for 2.4.18-pre8
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes the deadlock and scheduling-in-interrupt
problems in the PPP code.  It also includes Andrew Morton's fix for
the memory leak that happened when packet decompression errors
occurred.

Instead of using a linked list for the ppp units, I now use a wide
tree (32-way branching at each level) with a bitmap at each level so I
can find the lowest unused unit number quickly.  This should make it
much more efficient when there are large numbers of PPP interfaces.

This patch is against 2.4.18-pre8.  It nearly applies to 2.5.4-pre1,
but not quite, so I will post a separate patch for 2.5.4-pre1.

This patch fixes all the SMP locking problems that I am aware of in
the generic PPP code and the async-tty and sync-tty PPP line
disciplines.  It also includes changes to pppoe.c and if_pppox.h from
Michal Ostrowski that are needed because now ppp_unregister_channel
must be called from process context, not from interrupt context.

It would be good if people could test this patch, particularly those
who are using PPP on SMP boxes and/or with a large number of
connections at once.  Please let me know how it goes.

Paul.

diff -urN linux-2.4.18-pre8/drivers/net/ppp_async.c linux/drivers/net/ppp_async.c
--- linux-2.4.18-pre8/drivers/net/ppp_async.c	Wed Oct 10 12:39:02 2001
+++ linux/drivers/net/ppp_async.c	Fri Jan 25 18:07:28 2002
@@ -17,7 +17,7 @@
  * PPP driver, written by Michael Callahan and Al Longyear, and
  * subsequently hacked by Paul Mackerras.
  *
- * ==FILEVERSION 20000227==
+ * ==FILEVERSION 20020125==
  */
 
 #include <linux/module.h>
@@ -33,7 +33,7 @@
 #include <linux/init.h>
 #include <asm/uaccess.h>
 
-#define PPP_VERSION	"2.4.1"
+#define PPP_VERSION	"2.4.2"
 
 #define OBUFSIZE	256
 
@@ -62,6 +62,8 @@
 	struct sk_buff	*rpkt;
 	int		lcp_fcs;
 
+	atomic_t	refcnt;
+	struct semaphore dead_sem;
 	struct ppp_channel chan;	/* interface to generic ppp layer */
 	unsigned char	obuf[OBUFSIZE];
 };
@@ -108,6 +110,35 @@
  */
 
 /*
+ * We have a potential race on dereferencing tty->disc_data,
+ * because the tty layer provides no locking at all - thus one
+ * cpu could be running ppp_asynctty_receive while another
+ * calls ppp_asynctty_close, which zeroes tty->disc_data and
+ * frees the memory that ppp_asynctty_receive is using.  The best
+ * way to fix this is to use a rwlock in the tty struct, but for now
+ * we use a single global rwlock for all ttys in ppp line discipline.
+ */
+static rwlock_t disc_data_lock = RW_LOCK_UNLOCKED;
+
+static struct asyncppp *ap_get(struct tty_struct *tty)
+{
+	struct asyncppp *ap;
+
+	read_lock(&disc_data_lock);
+	ap = tty->disc_data;
+	if (ap != NULL)
+		atomic_inc(&ap->refcnt);
+	read_unlock(&disc_data_lock);
+	return ap;
+}
+
+static void ap_put(struct asyncppp *ap)
+{
+	if (atomic_dec_and_test(&ap->refcnt))
+		up(&ap->dead_sem);
+}
+
+/*
  * Called when a tty is put into PPP line discipline.
  */
 static int
@@ -135,6 +166,9 @@
 	ap->olim = ap->obuf;
 	ap->lcp_fcs = -1;
 
+	atomic_set(&ap->refcnt, 1);
+	init_MUTEX_LOCKED(&ap->dead_sem);
+
 	ap->chan.private = ap;
 	ap->chan.ops = &async_ops;
 	ap->chan.mtu = PPP_MRU;
@@ -155,19 +189,34 @@
 
 /*
  * Called when the tty is put into another line discipline
- * or it hangs up.
- * We assume that while we are in this routine, the tty layer
- * won't call any of the other line discipline entries for the
- * same tty.
+ * or it hangs up.  We have to wait for any cpu currently
+ * executing in any of the other ppp_asynctty_* routines to
+ * finish before we can call ppp_unregister_channel and free
+ * the asyncppp struct.  This routine must be called from
+ * process context, not interrupt or softirq context.
  */
 static void
 ppp_asynctty_close(struct tty_struct *tty)
 {
-	struct asyncppp *ap = tty->disc_data;
+	struct asyncppp *ap;
 
+	write_lock(&disc_data_lock);
+	ap = tty->disc_data;
+	tty->disc_data = 0;
+	write_unlock(&disc_data_lock);
 	if (ap == 0)
 		return;
-	tty->disc_data = 0;
+
+	/*
+	 * We have now ensured that nobody can start using ap from now
+	 * on, but we have to wait for all existing users to finish.
+	 * Note that ppp_unregister_channel ensures that no calls to
+	 * our channel ops (i.e. ppp_async_send/ioctl) are in progress
+	 * by the time it returns.
+	 */
+	if (!atomic_dec_and_test(&ap->refcnt))
+		down(&ap->dead_sem);
+
 	ppp_unregister_channel(&ap->chan);
 	if (ap->rpkt != 0)
 		kfree_skb(ap->rpkt);
@@ -203,9 +252,11 @@
 ppp_asynctty_ioctl(struct tty_struct *tty, struct file *file,
 		   unsigned int cmd, unsigned long arg)
 {
-	struct asyncppp *ap = tty->disc_data;
+	struct asyncppp *ap = ap_get(tty);
 	int err, val;
 
+	if (ap == 0)
+		return -ENXIO;
 	err = -EFAULT;
 	switch (cmd) {
 	case PPPIOCGCHAN:
@@ -251,6 +302,7 @@
 		err = -ENOIOCTLCMD;
 	}
 
+	ap_put(ap);
 	return err;
 }
 
@@ -271,13 +323,14 @@
 ppp_asynctty_receive(struct tty_struct *tty, const unsigned char *buf,
 		  char *flags, int count)
 {
-	struct asyncppp *ap = tty->disc_data;
+	struct asyncppp *ap = ap_get(tty);
 
 	if (ap == 0)
 		return;
 	spin_lock_bh(&ap->recv_lock);
 	ppp_async_input(ap, buf, flags, count);
 	spin_unlock_bh(&ap->recv_lock);
+	ap_put(ap);
 	if (test_and_clear_bit(TTY_THROTTLED, &tty->flags)
 	    && tty->driver.unthrottle)
 		tty->driver.unthrottle(tty);
@@ -286,13 +339,14 @@
 static void
 ppp_asynctty_wakeup(struct tty_struct *tty)
 {
-	struct asyncppp *ap = tty->disc_data;
+	struct asyncppp *ap = ap_get(tty);
 
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	if (ap == 0)
 		return;
 	if (ppp_async_push(ap))
 		ppp_output_wakeup(&ap->chan);
+	ap_put(ap);
 }
 
 
diff -urN linux-2.4.18-pre8/drivers/net/ppp_generic.c linux/drivers/net/ppp_generic.c
--- linux-2.4.18-pre8/drivers/net/ppp_generic.c	Wed Oct 24 23:05:06 2001
+++ linux/drivers/net/ppp_generic.c	Tue Feb  5 16:43:42 2002
@@ -1,7 +1,7 @@
 /*
  * Generic PPP layer for Linux.
  *
- * Copyright 1999-2000 Paul Mackerras.
+ * Copyright 1999-2002 Paul Mackerras.
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -19,7 +19,7 @@
  * PPP driver, written by Michael Callahan and Al Longyear, and
  * subsequently hacked by Paul Mackerras.
  *
- * ==FILEVERSION 20000902==
+ * ==FILEVERSION 20020205==
  */
 
 #include <linux/config.h>
@@ -43,10 +43,12 @@
 #include <linux/tcp.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
+#include <linux/rwsem.h>
+#include <linux/stddef.h>
 #include <net/slhc_vj.h>
 #include <asm/atomic.h>
 
-#define PPP_VERSION	"2.4.1"
+#define PPP_VERSION	"2.4.2"
 
 /*
  * Network protocols we support.
@@ -75,11 +77,11 @@
 	wait_queue_head_t rwait;	/* for poll on reading /dev/ppp */
 	atomic_t	refcnt;		/* # refs (incl /dev/ppp attached) */
 	int		hdrlen;		/* space to leave for headers */
-	struct list_head list;		/* link in all_* list */
 	int		index;		/* interface unit / channel number */
+	int		dead;		/* unit/channel has been shut down */
 };
 
-#define PF_TO_X(pf, X)	((X *)((char *)(pf)-(unsigned long)(&((X *)0)->file)))
+#define PF_TO_X(pf, X)		((X *)((char *)(pf) - offsetof(X, file)))
 
 #define PF_TO_PPP(pf)		PF_TO_X(pf, struct ppp)
 #define PF_TO_CHANNEL(pf)	PF_TO_X(pf, struct channel)
@@ -93,26 +95,27 @@
  * It can have 0 or more ppp channels connected to it.
  */
 struct ppp {
-	struct ppp_file	file;		/* stuff for read/write/poll */
-	struct list_head channels;	/* list of attached channels */
-	int		n_channels;	/* how many channels are attached */
-	spinlock_t	rlock;		/* lock for receive side */
-	spinlock_t	wlock;		/* lock for transmit side */
-	int		mru;		/* max receive unit */
-	unsigned int	flags;		/* control bits */
-	unsigned int	xstate;		/* transmit state bits */
-	unsigned int	rstate;		/* receive state bits */
-	int		debug;		/* debug flags */
+	struct ppp_file	file;		/* stuff for read/write/poll 0 */
+	struct file	*owner;		/* file that owns this unit 48 */
+	struct list_head channels;	/* list of attached channels 4c */
+	int		n_channels;	/* how many channels are attached 54 */
+	spinlock_t	rlock;		/* lock for receive side 58 */
+	spinlock_t	wlock;		/* lock for transmit side 5c */
+	int		mru;		/* max receive unit 60 */
+	unsigned int	flags;		/* control bits 64 */
+	unsigned int	xstate;		/* transmit state bits 68 */
+	unsigned int	rstate;		/* receive state bits 6c */
+	int		debug;		/* debug flags 70 */
 	struct slcompress *vj;		/* state for VJ header compression */
-	enum NPmode	npmode[NUM_NP];	/* what to do with each net proto */
-	struct sk_buff	*xmit_pending;	/* a packet ready to go out */
-	struct compressor *xcomp;	/* transmit packet compressor */
-	void		*xc_state;	/* its internal state */
-	struct compressor *rcomp;	/* receive decompressor */
-	void		*rc_state;	/* its internal state */
-	unsigned long	last_xmit;	/* jiffies when last pkt sent */
-	unsigned long	last_recv;	/* jiffies when last pkt rcvd */
-	struct net_device *dev;		/* network interface device */
+	enum NPmode	npmode[NUM_NP];	/* what to do with each net proto 78 */
+	struct sk_buff	*xmit_pending;	/* a packet ready to go out 88 */
+	struct compressor *xcomp;	/* transmit packet compressor 8c */
+	void		*xc_state;	/* its internal state 90 */
+	struct compressor *rcomp;	/* receive decompressor 94 */
+	void		*rc_state;	/* its internal state 98 */
+	unsigned long	last_xmit;	/* jiffies when last pkt sent 9c */
+	unsigned long	last_recv;	/* jiffies when last pkt rcvd a0 */
+	struct net_device *dev;		/* network interface device a4 */
 #ifdef CONFIG_PPP_MULTILINK
 	int		nxchan;		/* next channel to send something on */
 	u32		nxseq;		/* next sequence number to send */
@@ -144,11 +147,13 @@
  */
 struct channel {
 	struct ppp_file	file;		/* stuff for read/write/poll */
+	struct list_head list;		/* link in all/new_channels list */
 	struct ppp_channel *chan;	/* public channel data structure */
+	struct rw_semaphore chan_sem;	/* protects `chan' during chan ioctl */
 	spinlock_t	downl;		/* protects `chan', file.xq dequeue */
 	struct ppp	*ppp;		/* ppp unit we're connected to */
 	struct list_head clist;		/* link in list of channels per unit */
-	rwlock_t	upl;		/* protects `ppp' and `ulist' */
+	rwlock_t	upl;		/* protects `ppp' */
 #ifdef CONFIG_PPP_MULTILINK
 	u8		avail;		/* flag used in multilink stuff */
 	u8		had_frag;	/* >= 1 fragments have been sent */
@@ -166,12 +171,35 @@
  */
 
 /*
- * all_ppp_lock protects the all_ppp_units.
- * It also ensures that finding a ppp unit in the all_ppp_units list
+ * A cardmap represents a mapping from unsigned integers to pointers,
+ * and provides a fast "find lowest unused number" operation.
+ * It uses a broad (32-way) tree with a bitmap at each level.
+ * It is designed to be space-efficient for small numbers of entries
+ * and time-efficient for large numbers of entries.
+ */
+#define CARDMAP_ORDER	5
+#define CARDMAP_WIDTH	(1U << CARDMAP_ORDER)
+#define CARDMAP_MASK	(CARDMAP_WIDTH - 1)
+
+struct cardmap {
+	int shift;
+	unsigned long inuse;
+	struct cardmap *parent;
+	void *ptr[CARDMAP_WIDTH];
+};
+static void *cardmap_get(struct cardmap *map, unsigned int nr);
+static void cardmap_set(struct cardmap **map, unsigned int nr, void *ptr);
+static unsigned int cardmap_find_first_free(struct cardmap *map);
+static void cardmap_destroy(struct cardmap **map);
+
+/*
+ * all_ppp_sem protects the all_ppp_units mapping.
+ * It also ensures that finding a ppp unit in the all_ppp_units map
  * and updating its file.refcnt field is atomic.
  */
-static spinlock_t all_ppp_lock = SPIN_LOCK_UNLOCKED;
-static LIST_HEAD(all_ppp_units);
+static DECLARE_MUTEX(all_ppp_sem);
+static struct cardmap *all_ppp_units;
+static atomic_t ppp_unit_count = ATOMIC_INIT(0);
 
 /*
  * all_channels_lock protects all_channels and last_channel_index,
@@ -180,7 +208,9 @@
  */
 static spinlock_t all_channels_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(all_channels);
+static LIST_HEAD(new_channels);
 static int last_channel_index;
+static atomic_t channel_count = ATOMIC_INIT(0);
 
 /* Get the PPP protocol number from a skb */
 #define PPP_PROTO(skb)	(((skb)->data[0] << 8) + (skb)->data[1])
@@ -205,10 +235,6 @@
 #define seq_after(a, b)		((s32)((a) - (b)) > 0)
 
 /* Prototypes. */
-static ssize_t ppp_file_read(struct ppp_file *pf, struct file *file,
-			     char *buf, size_t count);
-static ssize_t ppp_file_write(struct ppp_file *pf, const char *buf,
-			      size_t count);
 static int ppp_unattached_ioctl(struct ppp_file *pf, struct file *file,
 				unsigned int cmd, unsigned long arg);
 static void ppp_xmit_process(struct ppp *ppp);
@@ -235,6 +261,7 @@
 static void ppp_get_stats(struct ppp *ppp, struct ppp_stats *st);
 static struct ppp *ppp_create_interface(int unit, int *retp);
 static void init_ppp_file(struct ppp_file *pf, int kind);
+static void ppp_shutdown_interface(struct ppp *ppp);
 static void ppp_destroy_interface(struct ppp *ppp);
 static struct ppp *ppp_find_unit(int unit);
 static struct channel *ppp_find_channel(int unit);
@@ -303,7 +330,6 @@
 #define ppp_unlock(ppp)		do { ppp_recv_unlock(ppp); \
 				     ppp_xmit_unlock(ppp); } while (0)
 
-
 /*
  * /dev/ppp device routines.
  * The /dev/ppp device is used by pppd to control the ppp unit.
@@ -323,11 +349,16 @@
 
 static int ppp_release(struct inode *inode, struct file *file)
 {
-	struct ppp_file *pf = (struct ppp_file *) file->private_data;
+	struct ppp_file *pf = file->private_data;
+	struct ppp *ppp;
 
-	lock_kernel();
 	if (pf != 0) {
 		file->private_data = 0;
+		if (pf->kind == INTERFACE) {
+			ppp = PF_TO_PPP(pf);
+			if (file == ppp->owner)
+				ppp_shutdown_interface(ppp);
+		}
 		if (atomic_dec_and_test(&pf->refcnt)) {
 			switch (pf->kind) {
 			case INTERFACE:
@@ -339,37 +370,27 @@
 			}
 		}
 	}
-	unlock_kernel();
 	return 0;
 }
 
 static ssize_t ppp_read(struct file *file, char *buf,
 			size_t count, loff_t *ppos)
 {
-	struct ppp_file *pf = (struct ppp_file *) file->private_data;
-
-	return ppp_file_read(pf, file, buf, count);
-}
-
-static ssize_t ppp_file_read(struct ppp_file *pf, struct file *file,
-			     char *buf, size_t count)
-{
+	struct ppp_file *pf = file->private_data;
 	DECLARE_WAITQUEUE(wait, current);
 	ssize_t ret;
 	struct sk_buff *skb = 0;
 
-	ret = -ENXIO;
 	if (pf == 0)
-		goto out;		/* not currently attached */
-
+		return -ENXIO;
 	add_wait_queue(&pf->rwait, &wait);
-	current->state = TASK_INTERRUPTIBLE;
 	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		skb = skb_dequeue(&pf->rq);
 		if (skb)
 			break;
 		ret = 0;
-		if (pf->kind == CHANNEL && PF_TO_CHANNEL(pf)->chan == 0)
+		if (pf->dead)
 			break;
 		ret = -EAGAIN;
 		if (file->f_flags & O_NONBLOCK)
@@ -379,7 +400,7 @@
 			break;
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&pf->rwait, &wait);
 
 	if (skb == 0)
@@ -402,21 +423,12 @@
 static ssize_t ppp_write(struct file *file, const char *buf,
 			 size_t count, loff_t *ppos)
 {
-	struct ppp_file *pf = (struct ppp_file *) file->private_data;
-
-	return ppp_file_write(pf, buf, count);
-}
-
-static ssize_t ppp_file_write(struct ppp_file *pf, const char *buf,
-			      size_t count)
-{
+	struct ppp_file *pf = file->private_data;
 	struct sk_buff *skb;
 	ssize_t ret;
 
-	ret = -ENXIO;
 	if (pf == 0)
-		goto out;
-
+		return -ENXIO;
 	ret = -ENOMEM;
 	skb = alloc_skb(count + pf->hdrlen, GFP_KERNEL);
 	if (skb == 0)
@@ -448,7 +460,7 @@
 /* No kernel lock - fine */
 static unsigned int ppp_poll(struct file *file, poll_table *wait)
 {
-	struct ppp_file *pf = (struct ppp_file *) file->private_data;
+	struct ppp_file *pf = file->private_data;
 	unsigned int mask;
 
 	if (pf == 0)
@@ -457,18 +469,15 @@
 	mask = POLLOUT | POLLWRNORM;
 	if (skb_peek(&pf->rq) != 0)
 		mask |= POLLIN | POLLRDNORM;
-	if (pf->kind == CHANNEL) {
-		struct channel *pch = PF_TO_CHANNEL(pf);
-		if (pch->chan == 0)
-			mask |= POLLHUP;
-	}
+	if (pf->dead)
+		mask |= POLLHUP;
 	return mask;
 }
 
 static int ppp_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	struct ppp_file *pf = (struct ppp_file *) file->private_data;
+	struct ppp_file *pf = file->private_data;
 	struct ppp *ppp;
 	int err = -EFAULT, val, val2, i;
 	struct ppp_idle idle;
@@ -479,6 +488,33 @@
 	if (pf == 0)
 		return ppp_unattached_ioctl(pf, file, cmd, arg);
 
+	if (cmd == PPPIOCDETACH) {
+		/*
+		 * We have to be careful here... if the file descriptor
+		 * has been dup'd, we could have another process in the
+		 * middle of a poll using the same file *, so we had
+		 * better not free the interface data structures -
+		 * instead we fail the ioctl.  Even in this case, we
+		 * shut down the interface if we are the owner of it.
+		 * Actually, we should get rid of PPPIOCDETACH, userland
+		 * (i.e. pppd) could achieve the same effect by closing
+		 * this fd and reopening /dev/ppp.
+		 */
+		err = -EINVAL;
+		if (pf->kind == INTERFACE) {
+			ppp = PF_TO_PPP(pf);
+			if (file == ppp->owner)
+				ppp_shutdown_interface(ppp);
+		}
+		if (atomic_read(&file->f_count) <= 2) {
+			ppp_release(inode, file);
+			err = 0;
+		} else
+			printk(KERN_DEBUG "PPPIOCDETACH file->f_count=%d\n",
+			       atomic_read(&file->f_count));
+		return err;
+	}
+
 	if (pf->kind == CHANNEL) {
 		struct channel *pch = PF_TO_CHANNEL(pf);
 		struct ppp_channel *chan;
@@ -494,20 +530,13 @@
 			err = ppp_disconnect_channel(pch);
 			break;
 
-		case PPPIOCDETACH:
-			file->private_data = 0;
-			if (atomic_dec_and_test(&pf->refcnt))
-				ppp_destroy_channel(pch);
-			err = 0;
-			break;
-
 		default:
-			spin_lock_bh(&pch->downl);
+			down_read(&pch->chan_sem);
 			chan = pch->chan;
 			err = -ENOTTY;
 			if (chan && chan->ops->ioctl)
 				err = chan->ops->ioctl(chan, cmd, arg);
-			spin_unlock_bh(&pch->downl);
+			up_read(&pch->chan_sem);
 		}
 		return err;
 	}
@@ -520,13 +549,6 @@
 
 	ppp = PF_TO_PPP(pf);
 	switch (cmd) {
-	case PPPIOCDETACH:
-		file->private_data = 0;
-		if (atomic_dec_and_test(&pf->refcnt))
-			ppp_destroy_interface(ppp);
-		err = 0;
-		break;
-
 	case PPPIOCSMRU:
 		if (get_user(val, (int *) arg))
 			break;
@@ -677,6 +699,7 @@
 	default:
 		err = -ENOTTY;
 	}
+
 	return err;
 }
 
@@ -696,6 +719,7 @@
 		if (ppp == 0)
 			break;
 		file->private_data = &ppp->file;
+		ppp->owner = file;
 		err = -EFAULT;
 		if (put_user(ppp->file.index, (int *) arg))
 			break;
@@ -706,31 +730,29 @@
 		/* Attach to an existing ppp unit */
 		if (get_user(unit, (int *) arg))
 			break;
-		spin_lock(&all_ppp_lock);
+		down(&all_ppp_sem);
+		err = -ENXIO;
 		ppp = ppp_find_unit(unit);
-		if (ppp != 0)
+		if (ppp != 0) {
 			atomic_inc(&ppp->file.refcnt);
-		spin_unlock(&all_ppp_lock);
-		err = -ENXIO;
-		if (ppp == 0)
-			break;
-		file->private_data = &ppp->file;
-		err = 0;
+			file->private_data = &ppp->file;
+			err = 0;
+		}
+		up(&all_ppp_sem);
 		break;
 
 	case PPPIOCATTCHAN:
 		if (get_user(unit, (int *) arg))
 			break;
 		spin_lock_bh(&all_channels_lock);
+		err = -ENXIO;
 		chan = ppp_find_channel(unit);
-		if (chan != 0)
+		if (chan != 0) {
 			atomic_inc(&chan->file.refcnt);
+			file->private_data = &chan->file;
+			err = 0;
+		}
 		spin_unlock_bh(&all_channels_lock);
-		err = -ENXIO;
-		if (chan == 0)
-			break;
-		file->private_data = &chan->file;
-		err = 0;
 		break;
 
 	default:
@@ -907,15 +929,16 @@
 	struct sk_buff *skb;
 
 	ppp_xmit_lock(ppp);
-	ppp_push(ppp);
-	while (ppp->xmit_pending == 0
-	       && (skb = skb_dequeue(&ppp->file.xq)) != 0)
-		ppp_send_frame(ppp, skb);
-	/* If there's no work left to do, tell the core net
-	   code that we can accept some more. */
-	if (ppp->xmit_pending == 0 && skb_peek(&ppp->file.xq) == 0
-	    && ppp->dev != 0)
-		netif_wake_queue(ppp->dev);
+	if (ppp->dev != 0) {
+		ppp_push(ppp);
+		while (ppp->xmit_pending == 0
+		       && (skb = skb_dequeue(&ppp->file.xq)) != 0)
+			ppp_send_frame(ppp, skb);
+		/* If there's no work left to do, tell the core net
+		   code that we can accept some more. */
+		if (ppp->xmit_pending == 0 && skb_peek(&ppp->file.xq) == 0)
+			netif_wake_queue(ppp->dev);
+	}
 	ppp_xmit_unlock(ppp);
 }
 
@@ -1528,6 +1551,7 @@
 			   error indication. */
 			if (len == DECOMP_FATALERROR)
 				ppp->rstate |= SC_DC_FERROR;
+			kfree_skb(ns);
 			goto err;
 		}
 
@@ -1799,7 +1823,7 @@
 {
 	struct channel *pch;
 
-	pch = kmalloc(sizeof(struct channel), GFP_ATOMIC);
+	pch = kmalloc(sizeof(struct channel), GFP_KERNEL);
 	if (pch == 0)
 		return -ENOMEM;
 	memset(pch, 0, sizeof(struct channel));
@@ -1811,11 +1835,13 @@
 #ifdef CONFIG_PPP_MULTILINK
 	pch->lastseq = -1;
 #endif /* CONFIG_PPP_MULTILINK */
+	init_rwsem(&pch->chan_sem);
 	spin_lock_init(&pch->downl);
 	pch->upl = RW_LOCK_UNLOCKED;
 	spin_lock_bh(&all_channels_lock);
 	pch->file.index = ++last_channel_index;
-	list_add(&pch->file.list, &all_channels);
+	list_add(&pch->list, &new_channels);
+	atomic_inc(&channel_count);
 	spin_unlock_bh(&all_channels_lock);
 	MOD_INC_USE_COUNT;
 	return 0;
@@ -1828,7 +1854,9 @@
 {
 	struct channel *pch = chan->ppp;
 
-	return pch->file.index;
+	if (pch != 0)
+		return pch->file.index;
+	return -1;
 }
 
 /*
@@ -1850,7 +1878,7 @@
 
 /*
  * Disconnect a channel from the generic layer.
- * This can be called from mainline or BH/softirq level.
+ * This must be called in process context.
  */
 void
 ppp_unregister_channel(struct ppp_channel *chan)
@@ -1865,14 +1893,17 @@
 	 * This ensures that we have returned from any calls into the
 	 * the channel's start_xmit or ioctl routine before we proceed.
 	 */
+	down_write(&pch->chan_sem);
 	spin_lock_bh(&pch->downl);
 	pch->chan = 0;
 	spin_unlock_bh(&pch->downl);
+	up_write(&pch->chan_sem);
 	ppp_disconnect_channel(pch);
-	wake_up_interruptible(&pch->file.rwait);
 	spin_lock_bh(&all_channels_lock);
-	list_del(&pch->file.list);
+	list_del(&pch->list);
 	spin_unlock_bh(&all_channels_lock);
+	pch->file.dead = 1;
+	wake_up_interruptible(&pch->file.rwait);
 	if (atomic_dec_and_test(&pch->file.refcnt))
 		ppp_destroy_channel(pch);
 	MOD_DEC_USE_COUNT;
@@ -1929,20 +1960,21 @@
 #endif /* CONFIG_KMOD */
 	if (cp == 0)
 		goto out;
+	/*
+	 * XXX race: the compressor module could get unloaded between
+	 * here and when we do the comp_alloc or decomp_alloc call below.
+	 */
 
 	err = -ENOBUFS;
 	if (data.transmit) {
-		ppp_xmit_lock(ppp);
-		ppp->xstate &= ~SC_COMP_RUN;
-		if (ppp->xc_state != 0) {
-			ppp->xcomp->comp_free(ppp->xc_state);
-			ppp->xc_state = 0;
-		}
-		ppp_xmit_unlock(ppp);
-
 		state = cp->comp_alloc(ccp_option, data.length);
 		if (state != 0) {
 			ppp_xmit_lock(ppp);
+			ppp->xstate &= ~SC_COMP_RUN;
+			if (ppp->xc_state != 0) {
+				ppp->xcomp->comp_free(ppp->xc_state);
+				ppp->xc_state = 0;
+			}
 			ppp->xcomp = cp;
 			ppp->xc_state = state;
 			ppp_xmit_unlock(ppp);
@@ -1950,17 +1982,14 @@
 		}
 
 	} else {
-		ppp_recv_lock(ppp);
-		ppp->rstate &= ~SC_DECOMP_RUN;
-		if (ppp->rc_state != 0) {
-			ppp->rcomp->decomp_free(ppp->rc_state);
-			ppp->rc_state = 0;
-		}
-		ppp_recv_unlock(ppp);
-
 		state = cp->decomp_alloc(ccp_option, data.length);
 		if (state != 0) {
 			ppp_recv_lock(ppp);
+			ppp->rstate &= ~SC_DECOMP_RUN;
+			if (ppp->rc_state != 0) {
+				ppp->rcomp->decomp_free(ppp->rc_state);
+				ppp->rc_state = 0;
+			}
 			ppp->rcomp = cp;
 			ppp->rc_state = state;
 			ppp_recv_unlock(ppp);
@@ -2193,39 +2222,27 @@
 ppp_create_interface(int unit, int *retp)
 {
 	struct ppp *ppp;
-	struct net_device *dev;
-	struct list_head *list;
-	int last_unit = -1;
-	int ret = -EEXIST;
+	struct net_device *dev = NULL;
+	int ret = -ENOMEM;
 	int i;
 
-	spin_lock(&all_ppp_lock);
-	list = &all_ppp_units;
-	while ((list = list->next) != &all_ppp_units) {
-		ppp = list_entry(list, struct ppp, file.list);
-		if ((unit < 0 && ppp->file.index > last_unit + 1)
-		    || (unit >= 0 && unit < ppp->file.index))
-			break;
-		if (unit == ppp->file.index)
-			goto out;	/* unit already exists */
-		last_unit = ppp->file.index;
-	}
-	if (unit < 0)
-		unit = last_unit + 1;
-
-	/* Create a new ppp structure and link it before `list'. */
-	ret = -ENOMEM;
-	ppp = kmalloc(sizeof(struct ppp), GFP_ATOMIC);
+	ppp = kmalloc(sizeof(struct ppp), GFP_KERNEL);
 	if (ppp == 0)
-		goto out;
+		goto err;
+	dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
+	if (dev == 0)
+		goto err;
 	memset(ppp, 0, sizeof(struct ppp));
-	dev = kmalloc(sizeof(struct net_device), GFP_ATOMIC);
-	if (dev == 0) {
-		kfree(ppp);
-		goto out;
-	}
 	memset(dev, 0, sizeof(struct net_device));
 
+	ret = -EEXIST;
+	down(&all_ppp_sem);
+	if (unit < 0)
+		unit = cardmap_find_first_free(all_ppp_units);
+	else if (cardmap_get(all_ppp_units, unit) != NULL)
+		goto err_unlock;	/* unit already exists */
+
+	/* Initialize the new ppp unit */
 	ppp->file.index = unit;
 	ppp->mru = PPP_MRU;
 	init_ppp_file(&ppp->file, INTERFACE);
@@ -2250,19 +2267,26 @@
 	ret = register_netdevice(dev);
 	rtnl_unlock();
 	if (ret != 0) {
-		printk(KERN_ERR "PPP: couldn't register device (%d)\n", ret);
-		kfree(dev);
-		kfree(ppp);
-		goto out;
+		printk(KERN_ERR "PPP: couldn't register device %s (%d)\n",
+		       dev->name, ret);
+		goto err_unlock;
 	}
 
-	list_add(&ppp->file.list, list->prev);
- out:
-	spin_unlock(&all_ppp_lock);
-	*retp = ret;
-	if (ret != 0)
-		ppp = 0;
+	atomic_inc(&ppp_unit_count);
+	cardmap_set(&all_ppp_units, unit, ppp);
+	up(&all_ppp_sem);
+	*retp = 0;
 	return ppp;
+
+ err_unlock:
+	up(&all_ppp_sem);
+ err:
+	*retp = ret;
+	if (ppp)
+		kfree(ppp);
+	if (dev)
+		kfree(dev);
+	return NULL;
 }
 
 /*
@@ -2279,19 +2303,48 @@
 }
 
 /*
- * Free up all the resources used by a ppp interface unit.
+ * Take down a ppp interface unit - called when the owning file
+ * (the one that created the unit) is closed or detached.
  */
-static void ppp_destroy_interface(struct ppp *ppp)
+static void ppp_shutdown_interface(struct ppp *ppp)
 {
 	struct net_device *dev;
-	int n_channels ;
-
-	spin_lock(&all_ppp_lock);
-	list_del(&ppp->file.list);
 
-	/* Last fd open to this ppp unit is being closed or detached:
-	   mark the interface down, free the ppp unit */
+	down(&all_ppp_sem);
 	ppp_lock(ppp);
+	dev = ppp->dev;
+	ppp->dev = 0;
+	ppp_unlock(ppp);
+	if (dev) {
+		rtnl_lock();
+		dev_close(dev);
+		unregister_netdevice(dev);
+		rtnl_unlock();
+	}
+	cardmap_set(&all_ppp_units, ppp->file.index, NULL);
+	ppp->file.dead = 1;
+	ppp->owner = NULL;
+	wake_up_interruptible(&ppp->file.rwait);
+	up(&all_ppp_sem);
+}
+
+/*
+ * Free the memory used by a ppp unit.  This is only called once
+ * there are no channels connected to the unit and no file structs
+ * that reference the unit.
+ */
+static void ppp_destroy_interface(struct ppp *ppp)
+{
+	atomic_dec(&ppp_unit_count);
+
+	if (!ppp->file.dead || ppp->n_channels) {
+		/* "can't happen" */
+		printk(KERN_ERR "ppp: destroying ppp struct %p but dead=%d "
+		       "n_channels=%d !\n", ppp, ppp->file.dead,
+		       ppp->n_channels);
+		return;
+	}
+
 	ppp_ccp_closed(ppp);
 	if (ppp->vj) {
 		slhc_free(ppp->vj);
@@ -2312,52 +2365,27 @@
 		ppp->active_filter.filter = 0;
 	}
 #endif /* CONFIG_PPP_FILTER */
-	dev = ppp->dev;
-	ppp->dev = 0;
-	n_channels = ppp->n_channels ;
-	ppp_unlock(ppp);
-
-	if (dev) {
-		rtnl_lock();
-		dev_close(dev);
-		unregister_netdevice(dev);
-		rtnl_unlock();
-	}
 
-	/*
-	 * We can't acquire any new channels (since we have the
-	 * all_ppp_lock) so if n_channels is 0, we can free the
-	 * ppp structure.  Otherwise we leave it around until the
-	 * last channel disconnects from it.
-	 */
-	if (n_channels == 0) 
-		kfree(ppp);
-
-	spin_unlock(&all_ppp_lock);
+	kfree(ppp);
 }
 
 /*
  * Locate an existing ppp unit.
- * The caller should have locked the all_ppp_lock.
+ * The caller should have locked the all_ppp_sem.
  */
 static struct ppp *
 ppp_find_unit(int unit)
 {
-	struct ppp *ppp;
-	struct list_head *list;
-
-	list = &all_ppp_units;
-	while ((list = list->next) != &all_ppp_units) {
-		ppp = list_entry(list, struct ppp, file.list);
-		if (ppp->file.index == unit)
-			return ppp;
-	}
-	return 0;
+	return cardmap_get(all_ppp_units, unit);
 }
 
 /*
  * Locate an existing ppp channel.
  * The caller should have locked the all_channels_lock.
+ * First we look in the new_channels list, then in the
+ * all_channels list.  If found in the new_channels list,
+ * we move it to the all_channels list.  This is for speed
+ * when we have a lot of channels in use.
  */
 static struct channel *
 ppp_find_channel(int unit)
@@ -2365,9 +2393,18 @@
 	struct channel *pch;
 	struct list_head *list;
 
+	list = &new_channels;
+	while ((list = list->next) != &new_channels) {
+		pch = list_entry(list, struct channel, list);
+		if (pch->file.index == unit) {
+			list_del(&pch->list);
+			list_add(&pch->list, &all_channels);
+			return pch;
+		}
+	}
 	list = &all_channels;
 	while ((list = list->next) != &all_channels) {
-		pch = list_entry(list, struct channel, file.list);
+		pch = list_entry(list, struct channel, list);
 		if (pch->file.index == unit)
 			return pch;
 	}
@@ -2384,19 +2421,16 @@
 	int ret = -ENXIO;
 	int hdrlen;
 
-	spin_lock(&all_ppp_lock);
+	down(&all_ppp_sem);
 	ppp = ppp_find_unit(unit);
 	if (ppp == 0)
 		goto out;
 	write_lock_bh(&pch->upl);
 	ret = -EINVAL;
 	if (pch->ppp != 0)
-		goto outwl;
-	ppp_lock(ppp);
-	spin_lock_bh(&pch->downl);
-	if (pch->chan == 0)		/* need to check this?? */
-		goto outr;
+		goto outl;
 
+	ppp_lock(ppp);
 	if (pch->file.hdrlen > ppp->file.hdrlen)
 		ppp->file.hdrlen = pch->file.hdrlen;
 	hdrlen = pch->file.hdrlen + 2;	/* for protocol bytes */
@@ -2405,15 +2439,14 @@
 	list_add_tail(&pch->clist, &ppp->channels);
 	++ppp->n_channels;
 	pch->ppp = ppp;
+	atomic_inc(&ppp->file.refcnt);
+	ppp_unlock(ppp);
 	ret = 0;
 
- outr:
-	spin_unlock_bh(&pch->downl);
-	ppp_unlock(ppp);
- outwl:
+ outl:
 	write_unlock_bh(&pch->upl);
  out:
-	spin_unlock(&all_ppp_lock);
+	up(&all_ppp_sem);
 	return ret;
 }
 
@@ -2425,25 +2458,21 @@
 {
 	struct ppp *ppp;
 	int err = -EINVAL;
-	int dead;
 
 	write_lock_bh(&pch->upl);
 	ppp = pch->ppp;
+	pch->ppp = NULL;
+	write_unlock_bh(&pch->upl);
 	if (ppp != 0) {
 		/* remove it from the ppp unit's list */
-		pch->ppp = NULL;
 		ppp_lock(ppp);
 		list_del(&pch->clist);
 		--ppp->n_channels;
-		dead = ppp->dev == 0 && ppp->n_channels == 0;
 		ppp_unlock(ppp);
-		if (dead)
-			/* Last disconnect from a ppp unit
-			   that is already dead: free it. */
-			kfree(ppp);
+		if (atomic_dec_and_test(&ppp->file.refcnt))
+			ppp_destroy_interface(ppp);
 		err = 0;
 	}
-	write_unlock_bh(&pch->upl);
 	return err;
 }
 
@@ -2452,6 +2481,14 @@
  */
 static void ppp_destroy_channel(struct channel *pch)
 {
+	atomic_dec(&channel_count);
+
+	if (!pch->file.dead) {
+		/* "can't happen" */
+		printk(KERN_ERR "ppp: destroying undead channel %p !\n",
+		       pch);
+		return;
+	}
 	skb_queue_purge(&pch->file.xq);
 	skb_queue_purge(&pch->file.rq);
 	kfree(pch);
@@ -2460,12 +2497,123 @@
 static void __exit ppp_cleanup(void)
 {
 	/* should never happen */
-	if (!list_empty(&all_ppp_units) || !list_empty(&all_channels))
+	if (atomic_read(&ppp_unit_count) || atomic_read(&channel_count))
 		printk(KERN_ERR "PPP: removing module but units remain!\n");
+	cardmap_destroy(&all_ppp_units);
 	if (devfs_unregister_chrdev(PPP_MAJOR, "ppp") != 0)
 		printk(KERN_ERR "PPP: failed to unregister PPP device\n");
 	devfs_unregister(devfs_handle);
 }
+
+/*
+ * Cardmap implementation.
+ */
+static void *cardmap_get(struct cardmap *map, unsigned int nr)
+{
+	struct cardmap *p;
+	int i;
+
+	for (p = map; p != NULL; ) {
+		if ((i = nr >> p->shift) >= CARDMAP_WIDTH)
+			return NULL;
+		if (p->shift == 0)
+			return p->ptr[i];
+		nr &= ~(CARDMAP_MASK << p->shift);
+		p = p->ptr[i];
+	}
+	return NULL;
+}
+
+static void cardmap_set(struct cardmap **pmap, unsigned int nr, void *ptr)
+{
+	struct cardmap *p;
+	int i;
+
+	p = *pmap;
+	if (p == NULL || (nr >> p->shift) >= CARDMAP_WIDTH) {
+		do {
+			/* need a new top level */
+			struct cardmap *np = kmalloc(sizeof(*np), GFP_KERNEL);
+			memset(np, 0, sizeof(*np));
+			np->ptr[0] = p;
+			if (p != NULL) {
+				np->shift = p->shift + CARDMAP_ORDER;
+				p->parent = np;
+			} else
+				np->shift = 0;
+			p = np;
+		} while ((nr >> p->shift) >= CARDMAP_WIDTH);
+		*pmap = p;
+	}
+	while (p->shift > 0) {
+		i = (nr >> p->shift) & CARDMAP_MASK;
+		if (p->ptr[i] == NULL) {
+			struct cardmap *np = kmalloc(sizeof(*np), GFP_KERNEL);
+			memset(np, 0, sizeof(*np));
+			np->shift = p->shift - CARDMAP_ORDER;
+			np->parent = p;
+			p->ptr[i] = np;
+		}
+		if (ptr == NULL)
+			clear_bit(i, &p->inuse);
+		p = p->ptr[i];
+	}
+	i = nr & CARDMAP_MASK;
+	p->ptr[i] = ptr;
+	if (ptr != NULL)
+		set_bit(i, &p->inuse);
+	else
+		clear_bit(i, &p->inuse);
+}
+
+static unsigned int cardmap_find_first_free(struct cardmap *map)
+{
+	struct cardmap *p;
+	unsigned int nr = 0;
+	int i;
+
+	if ((p = map) == NULL)
+		return 0;
+	for (;;) {
+		i = find_first_zero_bit(&p->inuse, CARDMAP_WIDTH);
+		if (i >= CARDMAP_WIDTH) {
+			if (p->parent == NULL)
+				return CARDMAP_WIDTH << p->shift;
+			p = p->parent;
+			i = (nr >> p->shift) & CARDMAP_MASK;
+			set_bit(i, &p->inuse);
+			continue;
+		}
+		nr = (nr & (~CARDMAP_MASK << p->shift)) | (i << p->shift);
+		if (p->shift == 0 || p->ptr[i] == NULL)
+			return nr;
+		p = p->ptr[i];
+	}
+}
+
+static void cardmap_destroy(struct cardmap **pmap)
+{
+	struct cardmap *p, *np;
+	int i;
+
+	for (p = *pmap; p != NULL; p = np) {
+		if (p->shift != 0) {
+			for (i = 0; i < CARDMAP_WIDTH; ++i)
+				if (p->ptr[i] != NULL)
+					break;
+			if (i < CARDMAP_WIDTH) {
+				np = p->ptr[i];
+				p->ptr[i] = NULL;
+				continue;
+			}
+		}
+		np = p->parent;
+		kfree(p);
+	}
+	*pmap = NULL;
+}
+
+/* Module/initialization stuff */
 
 module_init(ppp_init);
 module_exit(ppp_cleanup);
diff -urN linux-2.4.18-pre8/drivers/net/ppp_synctty.c linux/drivers/net/ppp_synctty.c
--- linux-2.4.18-pre8/drivers/net/ppp_synctty.c	Wed Oct 24 23:05:06 2001
+++ linux/drivers/net/ppp_synctty.c	Mon Feb  4 12:46:15 2002
@@ -25,11 +25,11 @@
  * the generic PPP layer to give it frames to send and to process
  * received frames.  It implements the PPP line discipline.
  *
- * Part of the code in this driver was inspired by the old sync-only
+ * Part of the code in this driver was inspired by the old async-only
  * PPP driver, written by Michael Callahan and Al Longyear, and
  * subsequently hacked by Paul Mackerras.
  *
- * ==FILEVERSION 20000322==
+ * ==FILEVERSION 20020125==
  */
 
 #include <linux/module.h>
@@ -41,10 +41,12 @@
 #include <linux/ppp_defs.h>
 #include <linux/if_ppp.h>
 #include <linux/ppp_channel.h>
+#include <linux/spinlock.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
+#include <asm/semaphore.h>
 
-#define PPP_VERSION	"2.4.1"
+#define PPP_VERSION	"2.4.2"
 
 /* Structure for storing local state. */
 struct syncppp {
@@ -65,6 +67,8 @@
 
 	struct sk_buff	*rpkt;
 
+	atomic_t	refcnt;
+	struct semaphore dead_sem;
 	struct ppp_channel chan;	/* interface to generic ppp layer */
 };
 
@@ -161,7 +165,36 @@
  */
 
 /*
- * Called when a tty is put into line discipline.
+ * We have a potential race on dereferencing tty->disc_data,
+ * because the tty layer provides no locking at all - thus one
+ * cpu could be running ppp_synctty_receive while another
+ * calls ppp_synctty_close, which zeroes tty->disc_data and
+ * frees the memory that ppp_synctty_receive is using.  The best
+ * way to fix this is to use a rwlock in the tty struct, but for now
+ * we use a single global rwlock for all ttys in ppp line discipline.
+ */
+static rwlock_t disc_data_lock = RW_LOCK_UNLOCKED;
+
+static struct syncppp *sp_get(struct tty_struct *tty)
+{
+	struct syncppp *ap;
+
+	read_lock(&disc_data_lock);
+	ap = tty->disc_data;
+	if (ap != NULL)
+		atomic_inc(&ap->refcnt);
+	read_unlock(&disc_data_lock);
+	return ap;
+}
+
+static void sp_put(struct syncppp *ap)
+{
+	if (atomic_dec_and_test(&ap->refcnt))
+		up(&ap->dead_sem);
+}
+
+/*
+ * Called when a tty is put into sync-PPP line discipline.
  */
 static int
 ppp_sync_open(struct tty_struct *tty)
@@ -185,6 +218,9 @@
 	ap->xaccm[3] = 0x60000000U;
 	ap->raccm = ~0U;
 
+	atomic_set(&ap->refcnt, 1);
+	init_MUTEX_LOCKED(&ap->dead_sem);
+
 	ap->chan.private = ap;
 	ap->chan.ops = &sync_ops;
 	ap->chan.mtu = PPP_MRU;
@@ -206,16 +242,34 @@
 
 /*
  * Called when the tty is put into another line discipline
- * (or it hangs up).
+ * or it hangs up.  We have to wait for any cpu currently
+ * executing in any of the other ppp_synctty_* routines to
+ * finish before we can call ppp_unregister_channel and free
+ * the syncppp struct.  This routine must be called from
+ * process context, not interrupt or softirq context.
  */
 static void
 ppp_sync_close(struct tty_struct *tty)
 {
-	struct syncppp *ap = tty->disc_data;
+	struct syncppp *ap;
 
+	write_lock(&disc_data_lock);
+	ap = tty->disc_data;
+	tty->disc_data = 0;
+	write_unlock(&disc_data_lock);
 	if (ap == 0)
 		return;
-	tty->disc_data = 0;
+
+	/*
+	 * We have now ensured that nobody can start using ap from now
+	 * on, but we have to wait for all existing users to finish.
+	 * Note that ppp_unregister_channel ensures that no calls to
+	 * our channel ops (i.e. ppp_sync_send/ioctl) are in progress
+	 * by the time it returns.
+	 */
+	if (!atomic_dec_and_test(&ap->refcnt))
+		down(&ap->dead_sem);
+
 	ppp_unregister_channel(&ap->chan);
 	if (ap->rpkt != 0)
 		kfree_skb(ap->rpkt);
@@ -251,9 +305,11 @@
 ppp_synctty_ioctl(struct tty_struct *tty, struct file *file,
 		  unsigned int cmd, unsigned long arg)
 {
-	struct syncppp *ap = tty->disc_data;
+	struct syncppp *ap = sp_get(tty);
 	int err, val;
 
+	if (ap == 0)
+		return -ENXIO;
 	err = -EFAULT;
 	switch (cmd) {
 	case PPPIOCGCHAN:
@@ -299,6 +355,7 @@
 		err = -ENOIOCTLCMD;
 	}
 
+	sp_put(ap);
 	return err;
 }
 
@@ -319,13 +376,14 @@
 ppp_sync_receive(struct tty_struct *tty, const unsigned char *buf,
 		  char *flags, int count)
 {
-	struct syncppp *ap = tty->disc_data;
+	struct syncppp *ap = sp_get(tty);
 
 	if (ap == 0)
 		return;
 	spin_lock_bh(&ap->recv_lock);
 	ppp_sync_input(ap, buf, flags, count);
 	spin_unlock_bh(&ap->recv_lock);
+	sp_put(ap);
 	if (test_and_clear_bit(TTY_THROTTLED, &tty->flags)
 	    && tty->driver.unthrottle)
 		tty->driver.unthrottle(tty);
@@ -334,13 +392,14 @@
 static void
 ppp_sync_wakeup(struct tty_struct *tty)
 {
-	struct syncppp *ap = tty->disc_data;
+	struct syncppp *ap = sp_get(tty);
 
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	if (ap == 0)
 		return;
 	if (ppp_sync_push(ap))
 		ppp_output_wakeup(&ap->chan);
+	sp_put(ap);
 }
 
 
diff -r -u linux-2.4.18-pre8/drivers/net/pppoe.c linux/drivers/net/pppoe.c
--- linux-2.4.18-pre8/drivers/net/pppoe.c	Fri Nov  9 17:02:24 2001
+++ linux/drivers/net/pppoe.c	Fri Jan 25 07:42:14 2002
@@ -5,7 +5,7 @@
  * PPPoE --- PPP over Ethernet (RFC 2516)
  *
  *
- * Version:    0.6.9
+ * Version:    0.6.10
  *
  * 030700 :     Fixed connect logic to allow for disconnect.
  * 270700 :	Fixed potential SMP problems; we must protect against
@@ -31,6 +31,9 @@
  *		a memory leak.
  * 081001 :     Misc. cleanup (licence string, non-blocking, prevent
  *              reference of device on close).
+ * 121301 :     New ppp channels interface; cannot unregister a channel
+ *              from interrupts.  Thus, we mark the socket as a ZOMBIE
+ *              and do the unregistration later.
  *
  * Author:	Michal Ostrowski <mostrows@speakeasy.net>
  * Contributors:
@@ -273,10 +276,10 @@
 
 				lock_sock(sk);
 
-				if (sk->state & (PPPOX_CONNECTED | PPPOX_BOUND)) {
+				if (sk->state & (PPPOX_CONNECTED|PPPOX_BOUND)){
 					pppox_unbind_sock(sk);
 					dev_put(dev);
-					sk->state = PPPOX_DEAD;
+					sk->state = PPPOX_ZOMBIE;
 					sk->state_change(sk);
 				}
 
@@ -439,8 +442,10 @@
 		 * one socket family type, we cannot (easily) distinguish
 		 * what kind of SKB it is during backlog rcv.
 		 */
-		if (sk->lock.users == 0)
+		if (sk->lock.users == 0) {
+			sk->state = PPPOX_ZOMBIE;
 			pppox_unbind_sock(sk);
+		}
 
 		bh_unlock_sock(sk);
 		sock_put(sk);
@@ -722,7 +727,7 @@
 		struct pppox_opt *relay_po;
 
 		err = -EBUSY;
-		if (sk->state & PPPOX_BOUND)
+		if (sk->state & (PPPOX_BOUND|PPPOX_ZOMBIE|PPPOX_DEAD))
 			break;
 
 		err = -ENOTCONN;
diff -r -u linux-2.4.18-pre8/include/linux/if_pppox.h linux/include/linux/if_pppox.
--- linux-2.4.18-pre8/include/linux/if_pppox.h	Thu Nov 22 14:47:14 2001
+++ linux/include/linux/if_pppox.h	Fri Jan 25 07:39:15 2002
@@ -126,13 +126,14 @@
 extern int pppox_channel_ioctl(struct ppp_channel *pc, unsigned int cmd,
 			       unsigned long arg);
 
-/* PPPoE socket states */
+/* PPPoX socket states */
 enum {
     PPPOX_NONE		= 0,  /* initial state */
     PPPOX_CONNECTED	= 1,  /* connection established ==TCP_ESTABLISHED */
     PPPOX_BOUND		= 2,  /* bound to ppp device */
     PPPOX_RELAY		= 4,  /* forwarding is enabled */
-    PPPOX_DEAD		= 8
+    PPPOX_ZOMBIE	= 8,  /* dead, but still bound to ppp device */
+    PPPOX_DEAD		= 16  /* dead, useless, please clean me up!*/
 };
 
 extern struct ppp_channel_ops pppoe_chan_ops;


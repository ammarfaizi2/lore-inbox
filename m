Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbRERKNq>; Fri, 18 May 2001 06:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262292AbRERKNg>; Fri, 18 May 2001 06:13:36 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:48059 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S262291AbRERKNY>; Fri, 18 May 2001 06:13:24 -0400
Message-ID: <3B04F4C2.C472C6D7@uow.edu.au>
Date: Fri, 18 May 2001 20:09:06 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: alborchers@steinerpoint.com, linux-kernel@vger.kernel.org,
        macro@ds2.pg.gda.pl, tytso@mit.edu, Peter Berger <pberger@brimson.com>
Subject: Re: [patch] 2.4.0, 2.2.18: A critical problem with tty_io.c
In-Reply-To: <E150f2E-0006oP-00@the-village.bc.nu> from "Alan Cox" at May 18, 2001 08:50:53 AM <E150fYc-0006qG-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > drivers and fix their open/close routines to work with this patch?  Peter
> > > and I can take some time to do that--if that would help.
> >
> > That would be one big help. Having done that I'd like to go over it all with
> > Ted first (if he has time) before I push it to Linus
> 
> So I stuck my justify this change to Ted hat on. And failed.
> 
> For one the cleanest way to handle all the locking is to propogate the other
> locking fix styles into both the ldisc and serial drivers. At least for 2.4
> until the 2.5 folks get their deep magic inactivity based clean up working
> 
> The advantage of doing that is that modules that do play with use counts will
> not do anything worse than they do now, and will remain fully compatible.
> 
> The ldisc race is also real and completely unfixed right now.
> 

I have a work-in-non-progress here which addresses a few of
these things.  It would be good if someone could review it
and finish it off...

- implements tty->ldisc_sem to plug race between do_tty_hangup()
  and tty_set_ldisc().  Is this the ldisc race to which you refer?

- implements the `struct module *owner' in tty_driver and
  tty_ldisc.  Manipulates this in all the right places.

- Actually *uses* ->owner in ppp_async.c, n_r3964.c and serial.c
  Other tty and ldisc drivers need to be changed to set ->owner.

There's a fight between n_hdlc.c and n_r3964.c which hasn't been fixed
yet.  If you attach r3964 to a tty and then detach it, it leaves
a non-zero value in tty->disc_data.  This then prevents you from being
able to attach n_hdlc to the tty, because it checks for null ->disc_data.
Best fix for this is to make sure all the ldisc close routines zero out
disc_data when they're finished.



--- linux-2.4.2-ac24/include/linux/tty_driver.h	Tue Jan 30 18:24:56 2001
+++ ac/include/linux/tty_driver.h	Sun Mar 25 21:09:30 2001
@@ -117,6 +117,14 @@
 
 #include <linux/fs.h>
 
+#ifdef CONFIG_MODULES
+#include <linux/module.h>
+#define SET_TTY_OWNER(driver)	\
+	do { (driver)->owner = THIS_MODULE; } while (0)
+#define SET_LDISC_OWNER(ldisc)	\
+	do { (ldisc)->owner = THIS_MODULE; } while (0)
+#endif
+
 struct tty_driver {
 	int	magic;		/* magic number for this structure */
 	const char	*driver_name;
@@ -176,6 +184,9 @@
 	 */
 	struct tty_driver *next;
 	struct tty_driver *prev;
+#ifdef CONFIG_MODULES
+	struct module *owner;
+#endif
 };
 
 /* tty driver magic number */
--- linux-2.4.2-ac24/include/linux/tty_ldisc.h	Sat Mar 24 14:28:24 2001
+++ ac/include/linux/tty_ldisc.h	Sun Mar 25 21:09:30 2001
@@ -100,6 +100,8 @@
 #include <linux/fs.h>
 #include <linux/wait.h>
 
+struct module;
+
 struct tty_ldisc {
 	int	magic;
 	char	*name;
@@ -129,6 +131,9 @@
 			       char *fp, int count);
 	int	(*receive_room)(struct tty_struct *);
 	void	(*write_wakeup)(struct tty_struct *);
+#ifdef CONFIG_MODULES
+	struct module *owner;
+#endif
 };
 
 #define TTY_LDISC_MAGIC	0x5403
--- linux-2.4.2-ac24/include/linux/tty.h	Sat Mar 24 14:28:24 2001
+++ ac/include/linux/tty.h	Sun Mar 25 21:09:30 2001
@@ -306,6 +306,7 @@
 	unsigned int canon_column;
 	struct semaphore atomic_read;
 	struct semaphore atomic_write;
+	struct semaphore ldisc_sem;	/* Lock this while we're manipulating ldisc */
 	spinlock_t read_lock;
 	/* If the tty has a pending do_SAK, queue it here - akpm */
 	struct tq_struct SAK_tq;
--- linux-2.4.2-ac24/drivers/char/tty_io.c	Sat Mar 24 14:28:05 2001
+++ ac/drivers/char/tty_io.c	Sun Mar 25 23:33:45 2001
@@ -110,10 +110,10 @@
 #endif
 extern int rio_init(void);
 
-#define CONSOLE_DEV MKDEV(TTY_MAJOR,0)
-#define TTY_DEV MKDEV(TTYAUX_MAJOR,0)
-#define SYSCONS_DEV MKDEV(TTYAUX_MAJOR,1)
-#define PTMX_DEV MKDEV(TTYAUX_MAJOR,2)
+#define CONSOLE_DEV MKDEV(TTY_MAJOR,0)		/* /dev/systty */
+#define TTY_DEV MKDEV(TTYAUX_MAJOR,0)		/* /dev/tty */
+#define SYSCONS_DEV MKDEV(TTYAUX_MAJOR,1)	/* /dev/console */
+#define PTMX_DEV MKDEV(TTYAUX_MAJOR,2)		/* /dev/ptmx */
 
 #undef TTY_DEBUG_HANGUP
 
@@ -188,6 +188,65 @@
 }
 
 /*
+ * Lock a driver's module into core and increment its low-level refcount.
+ * Return 0 on success.  If we return non-zero then the driver module isn't there
+ * any more and action needs to be taken by the caller
+ */
+static int tty_dev_hold(struct tty_driver *driver)
+{
+#ifdef CONFIG_MODULES
+	if (try_inc_mod_count(driver->owner) == 0)
+		return -ENODEV;	/* Module is deleted */
+#endif
+	(*driver->refcount)++;
+	return 0;
+}
+
+/*
+ * Release the driver and (possibly) its module
+ */
+static void tty_dev_put(struct tty_driver *driver)
+{
+#ifdef CONFIG_MODULES
+	if (driver->owner)
+		__MOD_DEC_USE_COUNT(driver->owner);
+#endif
+	(*driver->refcount)--;
+}
+
+/*
+ * Lock an ldisc's module into core.  Return non-zero if the
+ * containing module is unusable - remedial action is needed
+ * by the caller
+ */
+static int tty_ldisc_hold(struct tty_ldisc *ldisc)
+{
+#ifdef CONFIG_MODULES
+	if (try_inc_mod_count(ldisc->owner) == 0)
+		return -ENODEV;	/* Module is deleted */
+	return 0;
+#endif
+}
+
+/*
+ * Release an ldisc and (possibly) its module
+ */
+static void tty_ldisc_put(struct tty_ldisc *ldisc)
+{
+#ifdef CONFIG_MODULES
+	if (ldisc->owner) {
+		int uc;
+		__MOD_DEC_USE_COUNT(ldisc->owner);
+		uc = atomic_read(&(ldisc->owner)->uc.usecount);
+		if (uc < 0) {
+			printk("tty_ldisc_put: count=%d.  This is not good\n",
+				atomic_read(&(ldisc->owner)->uc.usecount));
+		}
+	}
+#endif
+}
+
+/*
  * This routine returns the name of tty.
  */
 static char *
@@ -276,12 +335,15 @@
 /* Set the discipline of a tty line. */
 static int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 {
-	int	retval = 0;
+	int	retval;
 	struct	tty_ldisc o_ldisc;
 	char buf[64];
 
-	if ((ldisc < N_TTY) || (ldisc >= NR_LDISCS))
-		return -EINVAL;
+	down(&tty->ldisc_sem);	/* We're changing the ldisc.  Get exclusive access */
+	if ((ldisc < N_TTY) || (ldisc >= NR_LDISCS)) {
+		retval = -EINVAL;
+		goto out;
+	}
 	/* Eduardo Blanco <ejbs@cs.cs.com.uy> */
 	/* Cyrus Durgin <cider@speakeasy.org> */
 	if (!(ldiscs[ldisc].flags & LDISC_FLAG_DEFINED)) {
@@ -289,11 +351,14 @@
 		sprintf(modname, "tty-ldisc-%d", ldisc);
 		request_module (modname);
 	}
-	if (!(ldiscs[ldisc].flags & LDISC_FLAG_DEFINED))
-		return -EINVAL;
-
-	if (tty->ldisc.num == ldisc)
-		return 0;	/* We are already in the desired discipline */
+	if (!(ldiscs[ldisc].flags & LDISC_FLAG_DEFINED)) {
+		retval = -EINVAL;
+		goto out;
+	}
+	if (tty->ldisc.num == ldisc) {
+		retval = 0;	/* We are already in the desired discipline */
+		goto out;
+	}
 	o_ldisc = tty->ldisc;
 
 	tty_wait_until_sent(tty, 0);
@@ -302,15 +367,24 @@
 	if (tty->ldisc.close)
 		(tty->ldisc.close)(tty);
 
+	/* Don't do tty_ldisc_put(&o_ldisc) - we may need it later */
+
 	/* Now set up the new line discipline. */
 	tty->ldisc = ldiscs[ldisc];
 	tty->termios->c_line = ldisc;
-	if (tty->ldisc.open)
+
+	retval = tty_ldisc_hold(&tty->ldisc);
+
+	if (retval == 0 && tty->ldisc.open)
 		retval = (tty->ldisc.open)(tty);
+
 	if (retval < 0) {
+		tty_ldisc_put(&tty->ldisc);
+		tty_ldisc_hold(&o_ldisc);
 		tty->ldisc = o_ldisc;
 		tty->termios->c_line = tty->ldisc.num;
 		if (tty->ldisc.open && (tty->ldisc.open(tty) < 0)) {
+			tty_ldisc_put(&tty->ldisc);
 			tty->ldisc = ldiscs[N_TTY];
 			tty->termios->c_line = N_TTY;
 			if (tty->ldisc.open) {
@@ -323,8 +397,11 @@
 			}
 		}
 	}
+	tty_ldisc_put(&o_ldisc);	/* Do it now */
 	if (tty->ldisc.num != o_ldisc.num && tty->driver.set_ldisc)
 		tty->driver.set_ldisc(tty);
+out:
+	up(&tty->ldisc_sem);
 	return retval;
 }
 
@@ -466,8 +543,9 @@
 		filp->f_op = &hung_up_tty_fops;
 	}
 	file_list_unlock();
-	
-	/* FIXME! What are the locking issues here? This may me overdoing things.. */
+
+	/* Pin down tty->ldisc to avoid racing with tty_set_ldisc */
+	down(&tty->ldisc_sem);
 	{
 		unsigned long flags;
 
@@ -494,6 +572,7 @@
 	if (tty->ldisc.num != ldiscs[N_TTY].num) {
 		if (tty->ldisc.close)
 			(tty->ldisc.close)(tty);
+		tty_ldisc_put(&tty->ldisc);
 		tty->ldisc = ldiscs[N_TTY];
 		tty->termios->c_line = N_TTY;
 		if (tty->ldisc.open) {
@@ -503,6 +582,7 @@
 				       -i);
 		}
 	}
+	up(&tty->ldisc_sem);
 	
 	read_lock(&tasklist_lock);
  	for_each_task(p) {
@@ -907,7 +987,8 @@
 			*o_ltp_loc = o_ltp;
 		o_tty->termios = *o_tp_loc;
 		o_tty->termios_locked = *o_ltp_loc;
-		(*driver->other->refcount)++;
+		if (tty_dev_hold(driver->other) != 0)
+			goto free_mem_out;
 		if (driver->subtype == PTY_TYPE_MASTER)
 			o_tty->count++;
 
@@ -916,6 +997,9 @@
 		o_tty->link = tty;
 	}
 
+	if (tty_dev_hold(driver) != 0)
+		goto free_mem_out;
+
 	/* 
 	 * All structures have been allocated, so now we install them.
 	 * Failures after this point use release_mem to clean up, so 
@@ -929,7 +1013,6 @@
 		*ltp_loc = ltp;
 	tty->termios = *tp_loc;
 	tty->termios_locked = *ltp_loc;
-	(*driver->refcount)++;
 	tty->count++;
 
 	/* 
@@ -1026,7 +1109,7 @@
 			kfree(tp);
 		}
 		o_tty->magic = 0;
-		(*o_tty->driver.refcount)--;
+		tty_dev_put(&o_tty->driver);
 		free_tty_struct(o_tty);
 	}
 
@@ -1037,7 +1120,7 @@
 		kfree(tp);
 	}
 	tty->magic = 0;
-	(*tty->driver.refcount)--;
+	tty_dev_put(&tty->driver);
 	free_tty_struct(tty);
 }
 
@@ -1254,11 +1337,13 @@
 	 */
 	if (tty->ldisc.close)
 		(tty->ldisc.close)(tty);
+	tty_ldisc_put(&tty->ldisc);
 	tty->ldisc = ldiscs[N_TTY];
 	tty->termios->c_line = N_TTY;
 	if (o_tty) {
 		if (o_tty->ldisc.close)
 			(o_tty->ldisc.close)(o_tty);
+		tty_ldisc_put(&o_tty->ldisc);
 		o_tty->ldisc = ldiscs[N_TTY];
 	}
 	
@@ -1299,21 +1384,21 @@
 retry_open:
 	noctty = filp->f_flags & O_NOCTTY;
 	device = inode->i_rdev;
-	if (device == TTY_DEV) {
+	if (device == TTY_DEV) {		/* /dev/tty */
 		if (!current->tty)
 			return -ENXIO;
 		device = current->tty->device;
-		filp->f_flags |= O_NONBLOCK; /* Don't let /dev/tty block */
+		filp->f_flags |= O_NONBLOCK;	/* Don't let /dev/tty block */
 		/* noctty = 1; */
 	}
 #ifdef CONFIG_VT
-	if (device == CONSOLE_DEV) {
+	if (device == CONSOLE_DEV) {		/* /dev/systty */
 		extern int fg_console;
 		device = MKDEV(TTY_MAJOR, fg_console + 1);
 		noctty = 1;
 	}
 #endif
-	if (device == SYSCONS_DEV) {
+	if (device == SYSCONS_DEV) {		/* /dev/console */
 		struct console *c = console_drivers;
 		while(c && !c->device)
 			c = c->next;
@@ -1324,7 +1409,7 @@
 		noctty = 1;
 	}
 
-	if (device == PTMX_DEV) {
+	if (device == PTMX_DEV) {		/* /dev/ptmx */
 #ifdef CONFIG_UNIX98_PTYS
 
 		/* find a free pty. */
@@ -1996,6 +2081,7 @@
 	tty->tq_hangup.data = tty;
 	sema_init(&tty->atomic_read, 1);
 	sema_init(&tty->atomic_write, 1);
+	sema_init(&tty->ldisc_sem, 1);
 	spin_lock_init(&tty->read_lock);
 	INIT_LIST_HEAD(&tty->tty_files);
 	INIT_TQUEUE(&tty->SAK_tq, 0, 0);
--- linux-2.4.2-ac24/drivers/char/serial.c	Sat Mar 24 14:28:04 2001
+++ ac/drivers/char/serial.c	Sun Mar 25 21:09:30 2001
@@ -212,6 +212,14 @@
 #include <linux/sysrq.h>
 #endif
 
+#ifdef SET_TTY_OWNER
+#define TTY_MOD_INC do {} while (0)
+#define TTY_MOD_DEC do {} while (0)
+#else
+#define TTY_MOD_INC	MOD_INC_USE_COUNT
+#define TTY_MOD_DEC	MOD_DEC_USE_COUNT
+#endif
+
 /*
  * All of the compatibilty code so we can compile serial.c against
  * older kernels is hidden in serial_compat.h
@@ -2761,7 +2769,7 @@
 	
 	if (tty_hung_up_p(filp)) {
 		DBG_CNT("before DEC-hung");
-		MOD_DEC_USE_COUNT;
+		TTY_MOD_DEC;
 		restore_flags(flags);
 		return;
 	}
@@ -2788,7 +2796,7 @@
 	}
 	if (state->count) {
 		DBG_CNT("before DEC-2");
-		MOD_DEC_USE_COUNT;
+		TTY_MOD_DEC;
 		restore_flags(flags);
 		return;
 	}
@@ -2844,7 +2852,7 @@
 	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CALLOUT_ACTIVE|
 			 ASYNC_CLOSING);
 	wake_up_interruptible(&info->close_wait);
-	MOD_DEC_USE_COUNT;
+	TTY_MOD_DEC;
 }
 
 /*
@@ -3128,21 +3136,21 @@
 	int 			retval, line;
 	unsigned long		page;
 
-	MOD_INC_USE_COUNT;
+	TTY_MOD_INC;
 	line = MINOR(tty->device) - tty->driver.minor_start;
 	if ((line < 0) || (line >= NR_PORTS)) {
-		MOD_DEC_USE_COUNT;
+		TTY_MOD_DEC;
 		return -ENODEV;
 	}
 	retval = get_async_struct(line, &info);
 	if (retval) {
-		MOD_DEC_USE_COUNT;
+		TTY_MOD_DEC;
 		return retval;
 	}
 	tty->driver_data = info;
 	info->tty = tty;
 	if (serial_paranoia_check(info, tty->device, "rs_open")) {
-		MOD_DEC_USE_COUNT;		
+		TTY_MOD_DEC;		
 		return -ENODEV;
 	}
 
@@ -3157,7 +3165,7 @@
 	if (!tmp_buf) {
 		page = get_zeroed_page(GFP_KERNEL);
 		if (!page) {
-			MOD_DEC_USE_COUNT;
+			TTY_MOD_DEC;
 			return -ENOMEM;
 		}
 		if (tmp_buf)
@@ -3173,7 +3181,7 @@
 	    (info->flags & ASYNC_CLOSING)) {
 		if (info->flags & ASYNC_CLOSING)
 			interruptible_sleep_on(&info->close_wait);
-		MOD_DEC_USE_COUNT;
+		TTY_MOD_DEC;
 #ifdef SERIAL_DO_RESTART
 		return ((info->flags & ASYNC_HUP_NOTIFY) ?
 			-EAGAIN : -ERESTARTSYS);
@@ -3187,7 +3195,7 @@
 	 */
 	retval = startup(info);
 	if (retval) {
-		MOD_DEC_USE_COUNT;
+		TTY_MOD_DEC;
 		return retval;
 	}
 
@@ -3197,7 +3205,7 @@
 		printk("rs_open returning after block_til_ready with %d\n",
 		       retval);
 #endif
-		MOD_DEC_USE_COUNT;
+		TTY_MOD_DEC;
 		return retval;
 	}
 
@@ -5180,7 +5188,9 @@
 	serial_driver.wait_until_sent = rs_wait_until_sent;
 	serial_driver.read_proc = rs_read_proc;
 #endif
-	
+#ifdef SET_TTY_OWNER
+	SET_TTY_OWNER(&serial_driver);
+#endif
 	/*
 	 * The callout device is just like normal device except for
 	 * major number and the subtype code.
@@ -5413,12 +5423,16 @@
 	del_timer_sync(&serial_timer);
 	save_flags(flags); cli();
         remove_bh(SERIAL_BH);
-	if ((e1 = tty_unregister_driver(&serial_driver)))
+	if ((e1 = tty_unregister_driver(&serial_driver))) {
 		printk("serial: failed to unregister serial driver (%d)\n",
 		       e1);
-	if ((e2 = tty_unregister_driver(&callout_driver)))
+		BUG();
+	}
+	if ((e2 = tty_unregister_driver(&callout_driver))) {
 		printk("serial: failed to unregister callout driver (%d)\n", 
 		       e2);
+		BUG();
+	}
 	restore_flags(flags);
 
 	for (i = 0; i < NR_PORTS; i++) {
--- linux-2.4.2-ac24/drivers/net/ppp_async.c	Sat Mar 24 14:28:11 2001
+++ ac/drivers/net/ppp_async.c	Sun Mar 25 21:09:30 2001
@@ -113,7 +113,6 @@
 	struct asyncppp *ap;
 	int err;
 
-	MOD_INC_USE_COUNT;
 	err = -ENOMEM;
 	ap = kmalloc(sizeof(*ap), GFP_KERNEL);
 	if (ap == 0)
@@ -146,7 +145,6 @@
  out_free:
 	kfree(ap);
  out:
-	MOD_DEC_USE_COUNT;
 	return err;
 }
 
@@ -171,7 +169,6 @@
 	if (ap->tpkt != 0)
 		kfree_skb(ap->tpkt);
 	kfree(ap);
-	MOD_DEC_USE_COUNT;
 }
 
 /*
@@ -310,6 +307,9 @@
 	receive_room: ppp_asynctty_room,
 	receive_buf: ppp_asynctty_receive,
 	write_wakeup: ppp_asynctty_wakeup,
+#ifdef CONFIG_MODULES
+	owner: THIS_MODULE,
+#endif
 };
 
 static int __init
--- linux-2.4.2-ac24/drivers/char/n_hdlc.c	Sun Feb 25 17:37:03 2001
+++ ac/drivers/char/n_hdlc.c	Sun Mar 25 23:12:03 2001
@@ -305,7 +305,6 @@
 			n_hdlc->tty = n_hdlc->backup_tty;
 		} else {
 			n_hdlc_release (n_hdlc);
-			MOD_DEC_USE_COUNT;
 		}
 	}
 	
@@ -345,8 +344,6 @@
 	tty->disc_data = n_hdlc;
 	n_hdlc->tty    = tty;
 	
-	MOD_INC_USE_COUNT;
-	
 #if defined(TTY_NO_WRITE_SPLIT)
 	/* change tty_io write() to not split large writes into 8K chunks */
 	set_bit(TTY_NO_WRITE_SPLIT,&tty->flags);
@@ -1006,6 +1003,9 @@
 	n_hdlc_ldisc.receive_room	= n_hdlc_tty_room;
 	n_hdlc_ldisc.receive_buf	= n_hdlc_tty_receive;
 	n_hdlc_ldisc.write_wakeup	= n_hdlc_tty_wakeup;
+#ifdef CONFIG_MODULES
+	n_hdlc_ldisc.owner		= THIS_MODULE;
+#endif
 
 	status = tty_register_ldisc(N_HDLC, &n_hdlc_ldisc);
 	if (!status)
--- linux-2.4.2-ac24/drivers/char/n_r3964.c	Sat Mar 24 14:28:04 2001
+++ ac/drivers/char/n_r3964.c	Sun Mar 25 23:15:51 2001
@@ -146,22 +146,20 @@
 static int  r3964_receive_room(struct tty_struct *tty);
 
 static struct tty_ldisc tty_ldisc_N_R3964 = {
-        TTY_LDISC_MAGIC,       /* magic */
-	"R3964",               /* name */
-        0,                     /* num */
-        0,                     /* flags */
-        r3964_open,            /* open */
-        r3964_close,           /* close */
-        0,                     /* flush_buffer */
-        0,                     /* chars_in_buffer */
-        r3964_read,            /* read */
-        r3964_write,           /* write */
-        r3964_ioctl,           /* ioctl */
-        r3964_set_termios,     /* set_termios */
-        r3964_poll,            /* poll */            
-        r3964_receive_buf,     /* receive_buf */
-        r3964_receive_room,    /* receive_room */
-        0                      /* write_wakeup */
+        magic:		TTY_LDISC_MAGIC,
+	name:		"R3964",
+        open:		r3964_open,
+        close:		r3964_close,
+        read:		r3964_read,
+        write:		r3964_write,
+        ioctl:		r3964_ioctl,
+        set_termios:	r3964_set_termios,
+        poll:		r3964_poll,
+        receive_buf:	r3964_receive_buf,
+        receive_room:	r3964_receive_room,
+#ifdef CONFIG_MODULES
+	owner:		THIS_MODULE,
+#endif
 };
 
 
@@ -1098,8 +1096,6 @@
 {
    struct r3964_info *pInfo;
    
-   MOD_INC_USE_COUNT;
-
    TRACE_L("open");
    TRACE_L("tty=%x, PID=%d, disc_data=%x", 
           (int)tty, current->pid, (int)tty->disc_data);
@@ -1234,8 +1230,6 @@
     TRACE_M("r3964_close - tx_buf kfree %x",(int)pInfo->tx_buf);
     kfree(pInfo);
     TRACE_M("r3964_close - info kfree %x",(int)pInfo);
-
-    MOD_DEC_USE_COUNT;
 }
 
 static int r3964_read(struct tty_struct *tty, struct file *file,

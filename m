Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130493AbRCWKyk>; Fri, 23 Mar 2001 05:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130532AbRCWKyW>; Fri, 23 Mar 2001 05:54:22 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:64392 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130493AbRCWKyL>; Fri, 23 Mar 2001 05:54:11 -0500
Message-ID: <3ABB2B4B.93515581@uow.edu.au>
Date: Fri, 23 Mar 2001 21:54:03 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Kevin Buhr <buhr@stat.wisc.edu>
CC: paulus@samba.org, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH against 2.4.2: TTY hangup on PPP channel corrupts kernel 
 memory
In-Reply-To: <vbaofv1nyza.fsf@mozart.stat.wisc.edu>
		<15027.20462.682109.679714@argo.linuxcare.com.au>
		<vbasnkblsvd.fsf@mozart.stat.wisc.edu>
		<15034.53871.560040.366149@argo.linuxcare.com.au>,
		Paul Mackerras's message of "Fri, 23 Mar 2001 15:34:55 +1100 (EST)" <vbalmpxyo7n.fsf@mozart.stat.wisc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Buhr wrote:
> 
> ...
> When changing line disciplines, "sys_ioctl" gets the big kernel lock
> for us, and the "tty_set_ldisc" function doesn't get any additional
> locks.  It just calls the line discipline "open" function.
> 
> Suppose, at this point, the modem hangs up.  From a hardware
> interrupt, "tty_hangup" is called which schedule_tasks the tq_hangup
> routine, "do_tty_hangup".
> 
> Now, suppose the line discipline "open" function doesn't do any
> special locking and has a harmless-looking "kmalloc" that isn't
> GPF_ATOMIC.  It falls asleep and gives up the big kernel lock!!
> 
> Now, the eventd kernel thread wakes up and runs "do_tty_hangup".
> "do_tty_hangup" has no trouble getting the big kernel lock and running
> the "flush_buffer", "write_wakeup", and "close" line discipline
> function on the half-initialized line discipline all with no further
> locking.  In a naive implementation, "close" would start freeing the
> same kernel structures that "open" hasn't had a chance to allocate!
> And, now, "open" is free to wake up and try allocating structures for
> a line discipline that has already been shutdown from the TTY.

Your analysis is correct.  It's a bug.

Furthermore, n_hdlc_tty_open() (for example) can sleep prior to
incrementing the module refcount, which means the module can be
unloaded while it's running.  I cut a patch ages ago which fixes
this one for both ttys and ldiscs.  I never got around to sending
it to anyone.

> Does this mean that all line discipline implementations must use a
> spinlock around critical code in "open", "close", and every other line
> discipline function?  It looks like they must, and it looks like most
> don't right now.
> 

Seems a semaphore would be adequate.  Adding locking to the
tty code can be tricky, because it likes to copy big structures
around by value, rather than by reference.  You can end up
accidentally overwriting your locks.  I'm not sure why the
code was done this way.

Here's the old tty+ldisc module safety patch.  I've added the
ldisc locking.  Does it look to you like it'll fix the race
you identify?  Note that only one ldisc (ppp_async) and one
tty driver (serial) have been edited to actually use the new
module handling. It's trivial to change the other ldiscs and
tty drivers.

I think the scenario you describe could happen with the 
tty_struct.driver handling, as well as with tty_struct.ldisc.

This patch isn't ready to roll yet, BTW.  It needs a few hours
staring, thinking and testing.  Mainly checking whether all
scenarios are covered.  Hacking the tty layer is not 
exactly a walk in the park....


--- linux-2.4.3-pre6/include/linux/tty_driver.h	Tue Jan 30 18:24:56 2001
+++ linux-akpm/include/linux/tty_driver.h	Fri Mar 23 21:20:36 2001
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
--- linux-2.4.3-pre6/include/linux/tty_ldisc.h	Tue Jan 30 18:24:56 2001
+++ linux-akpm/include/linux/tty_ldisc.h	Fri Mar 23 21:20:36 2001
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
--- linux-2.4.3-pre6/include/linux/tty.h	Tue Jan 30 18:24:56 2001
+++ linux-akpm/include/linux/tty.h	Fri Mar 23 21:29:32 2001
@@ -306,6 +306,7 @@
 	unsigned int canon_column;
 	struct semaphore atomic_read;
 	struct semaphore atomic_write;
+	struct semaphore ldisc_sem;	/* Lock this while we're manipulating ldisc */
 	spinlock_t read_lock;
 };
 
--- linux-2.4.3-pre6/drivers/char/tty_io.c	Sun Feb 25 17:37:04 2001
+++ linux-akpm/drivers/char/tty_io.c	Fri Mar 23 21:39:11 2001
@@ -182,6 +182,67 @@
 }
 
 /*
+ * Lock a driver's module into core and increment its low-level refcount.
+ * Return 0 on success.  If we return non-zero then the driver module isn't there
+ * any more and action needs to be taken by the caller
+ */
+static int tty_dev_hold(struct tty_driver *driver)
+{
+#ifdef CONFIG_MODULES
+	if (driver->owner) {
+		if (try_inc_mod_count(driver->owner) == 0)
+			return -ENODEV;	/* Module is deleted */
+	}
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
@@ -270,12 +331,15 @@
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
@@ -283,11 +347,14 @@
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
@@ -296,15 +363,24 @@
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
@@ -317,8 +393,11 @@
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
 
@@ -460,8 +539,9 @@
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
 
@@ -488,6 +568,7 @@
 	if (tty->ldisc.num != ldiscs[N_TTY].num) {
 		if (tty->ldisc.close)
 			(tty->ldisc.close)(tty);
+		tty_ldisc_put(&tty->ldisc);
 		tty->ldisc = ldiscs[N_TTY];
 		tty->termios->c_line = N_TTY;
 		if (tty->ldisc.open) {
@@ -497,6 +578,7 @@
 				       -i);
 		}
 	}
+	up(&tty->ldisc_sem);
 	
 	read_lock(&tasklist_lock);
  	for_each_task(p) {
@@ -901,7 +983,8 @@
 			*o_ltp_loc = o_ltp;
 		o_tty->termios = *o_tp_loc;
 		o_tty->termios_locked = *o_ltp_loc;
-		(*driver->other->refcount)++;
+		if (tty_dev_hold(driver->other) != 0)
+			goto free_mem_out;
 		if (driver->subtype == PTY_TYPE_MASTER)
 			o_tty->count++;
 
@@ -910,6 +993,9 @@
 		o_tty->link = tty;
 	}
 
+	if (tty_dev_hold(driver) != 0)
+		goto free_mem_out;
+
 	/* 
 	 * All structures have been allocated, so now we install them.
 	 * Failures after this point use release_mem to clean up, so 
@@ -923,7 +1009,6 @@
 		*ltp_loc = ltp;
 	tty->termios = *tp_loc;
 	tty->termios_locked = *ltp_loc;
-	(*driver->refcount)++;
 	tty->count++;
 
 	/* 
@@ -1020,7 +1105,7 @@
 			kfree(tp);
 		}
 		o_tty->magic = 0;
-		(*o_tty->driver.refcount)--;
+		tty_dev_put(&o_tty->driver);
 		free_tty_struct(o_tty);
 	}
 
@@ -1031,7 +1116,7 @@
 		kfree(tp);
 	}
 	tty->magic = 0;
-	(*tty->driver.refcount)--;
+	tty_dev_put(&tty->driver);
 	free_tty_struct(tty);
 }
 
@@ -1248,11 +1333,13 @@
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
 	
@@ -1971,6 +2058,7 @@
 	tty->tq_hangup.data = tty;
 	sema_init(&tty->atomic_read, 1);
 	sema_init(&tty->atomic_write, 1);
+	sema_init(&tty->ldisc_sem, 1);
 	spin_lock_init(&tty->read_lock);
 	INIT_LIST_HEAD(&tty->tty_files);
 }
--- linux-2.4.3-pre6/drivers/char/serial.c	Thu Mar 22 18:52:47 2001
+++ linux-akpm/drivers/char/serial.c	Fri Mar 23 21:20:36 2001
@@ -209,6 +209,14 @@
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
@@ -2760,7 +2768,7 @@
 	
 	if (tty_hung_up_p(filp)) {
 		DBG_CNT("before DEC-hung");
-		MOD_DEC_USE_COUNT;
+		TTY_MOD_DEC;
 		restore_flags(flags);
 		return;
 	}
@@ -2787,7 +2795,7 @@
 	}
 	if (state->count) {
 		DBG_CNT("before DEC-2");
-		MOD_DEC_USE_COUNT;
+		TTY_MOD_DEC;
 		restore_flags(flags);
 		return;
 	}
@@ -2843,7 +2851,7 @@
 	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CALLOUT_ACTIVE|
 			 ASYNC_CLOSING);
 	wake_up_interruptible(&info->close_wait);
-	MOD_DEC_USE_COUNT;
+	TTY_MOD_DEC;
 }
 
 /*
@@ -3126,21 +3134,21 @@
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
 
@@ -3155,7 +3163,7 @@
 	if (!tmp_buf) {
 		page = get_zeroed_page(GFP_KERNEL);
 		if (!page) {
-			MOD_DEC_USE_COUNT;
+			TTY_MOD_DEC;
 			return -ENOMEM;
 		}
 		if (tmp_buf)
@@ -3171,7 +3179,7 @@
 	    (info->flags & ASYNC_CLOSING)) {
 		if (info->flags & ASYNC_CLOSING)
 			interruptible_sleep_on(&info->close_wait);
-		MOD_DEC_USE_COUNT;
+		TTY_MOD_DEC;
 #ifdef SERIAL_DO_RESTART
 		return ((info->flags & ASYNC_HUP_NOTIFY) ?
 			-EAGAIN : -ERESTARTSYS);
@@ -3185,7 +3193,7 @@
 	 */
 	retval = startup(info);
 	if (retval) {
-		MOD_DEC_USE_COUNT;
+		TTY_MOD_DEC;
 		return retval;
 	}
 
@@ -3195,7 +3203,7 @@
 		printk("rs_open returning after block_til_ready with %d\n",
 		       retval);
 #endif
-		MOD_DEC_USE_COUNT;
+		TTY_MOD_DEC;
 		return retval;
 	}
 
@@ -5254,7 +5262,9 @@
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
@@ -5495,12 +5505,16 @@
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
--- linux-2.4.3-pre6/drivers/net/ppp_async.c	Sun Feb 25 17:37:06 2001
+++ linux-akpm/drivers/net/ppp_async.c	Fri Mar 23 21:20:36 2001
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
 
 int

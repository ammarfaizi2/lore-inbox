Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266508AbUIIUFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUIIUFd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUIIUE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:04:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48584 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264954AbUIITxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:53:18 -0400
Date: Thu, 9 Sep 2004 15:53:10 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH: tty locking fixes take 1
Message-ID: <20040909195310.GA30009@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Much to my suprise with the bug DaveM fixed and a couple of others squashed
this seems to work. It's the first step to fixing the ldisc mess. It should
give us the guarantees that

ldisc functions don't get called after ldisc->close()
ldisc functions don't get called before ->open() completes
multiple line discipline changes don't occur at once
line disciplines don't change mid I/O

This is still in part a prototype - the ldisc set can return EBUSY if you
are randomly busy receiving bytes on another processor at the moment. The
_wait ldisc deref code doesn't do proper sleeping and has debug traps. The
TIOCSTI code needs some thought to deal with issues like TTY_DONT_FLIP. The
termios locking is still totally missing.

It does however rationalise the setup/use/tear-down sequencing. I've only
fixed the serial_core driver for driver side locking but that should be a good
enough reference to fix the others.

Alan


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc1/Documentation/tty.txt linux-2.6.9rc1/Documentation/tty.txt
--- linux.vanilla-2.6.9rc1/Documentation/tty.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9rc1/Documentation/tty.txt	2004-09-09 17:19:32.000000000 +0100
@@ -0,0 +1,187 @@
+
+			The Lockronomicon
+
+Your guide to the ancient and twisted locking policies of the tty layer and
+the warped logic behind them. Beware all ye who read on.
+
+
+
+Line Discipline
+---------------
+
+Line disciplines are registered with tty_register_ldisc() passing the
+discipline number and the ldisc structure. At the point of registration the 
+discipline must be ready to use and it is possible it will get used before
+the call returns success. If the call returns an error then it won't get
+called. Do not re-use ldisc numbers as they are part of the userspace ABI
+and writing over an existing ldisc will cause demons to eat your computer.
+After the return the ldisc data has been copied so you may free your own 
+copy of the structure. You must not re-register over the top of the line
+discipline even with the same data or your computer again will be eaten by
+demons.
+
+In order to remove a line discipline call tty_register_ldisc passing NULL.
+In ancient times this always worked. In modern times the function will
+return -EBUSY if the ldisc is currently in use. Since the ldisc referencing
+code manages the module counts this should not usually be a concern.
+
+Heed this warning: the reference count field of the registered copies of the
+tty_ldisc structure in the ldisc table counts the number of lines using this
+discipline. The reference count of the tty_ldisc structure within a tty 
+counts the number of active users of the ldisc at this instant. In effect it
+counts the number of threads of execution within an ldisc method (plus those
+about to enter and exit although this detail matters not).
+
+Line Discipline Methods
+-----------------------
+
+TTY side interfaces:
+
+close()		-	This is called on a terminal when the line
+			discipline is being unplugged. At the point of
+			execution no further users will enter the
+			ldisc code for this tty. Hopefully soon will always
+			be safe to sleep.
+
+open()		-	Called when the line discipline is attached to
+			the terminal. No other call into the line
+			discipline for this tty will occur until it
+			completes successfully. Hopefully soon will always
+			be safe to sleep.
+
+write()		-	A process is writing data from user space
+			through the line discipline. Multiple write calls
+			are serialized by the tty layer for the ldisc.
+
+flush_buffer()	-	May be called at any point between open and close.
+
+chars_in_buffer() -	Report the number of bytes in the buffer. 
+
+set_termios()	-	Called on termios structure changes. Semantics 
+			deeply mysterious right now.
+
+read()		-	Move data from the line discipline to the user.
+			Multiple read calls may occur in parallel and the
+			ldisc must deal with serialization issues. May 
+			sleep.
+
+poll()		-	Check the status for the poll/select calls. Multiple
+			poll calls may occur in parallel. May sleep.
+
+ioctl()		-	Called when an ioctl is handed to the tty layer
+			that might be for the ldisc. Multiple ioctl calls
+			may occur in parallel. May sleep. 
+
+Driver Side Interfaces:
+
+receive_buf()	-	Hand buffers of bytes from the driver to the ldisc
+			for processing. Semantics currently rather
+			mysterious 8(
+
+receive_room()	-	Can be called by the driver layer at any time when
+			the ldisc is opened. The ldisc must be able to
+			handle the reported amount of data at that instant.
+			Synchronization between active receive_buf and
+			receive_room calls is down to the driver not the
+			ldisc.
+
+write_wakeup()	-	May be called at any point between open and close.
+			The TTY_DO_WRITE_WAKEUP flag indicates if a call
+			is needed but always races versus calls. Thus the
+			ldisc must be careful about setting order and to
+			handle unexpected calls.
+
+
+Locking
+
+Callers to the line discipline functions from the tty layer are required to
+take line discipline locks. The same is true of calls from the driver side
+but not yet enforced.
+
+Three calls are now provided
+
+	ldisc = tty_ldisc_ref(tty);
+
+takes a handle to the line discipline in the tty and returns it. If no ldisc
+is currently attached or the ldisc is being closed and re-opened at this
+point then NULL is returned. While this handle is held the ldisc will not
+change or go away.
+
+	tty_ldisc_deref(ldisc)
+
+Returns the ldisc reference and allows the ldisc to be closed. Returning the
+reference takes away your right to call the ldisc functions until you take
+a new reference.
+
+	ldisc = tty_ldisc_ref_wait(tty);
+
+Performs the same function as tty_ldisc_ref except that it will wait for an
+ldisc change to complete and then return a reference to the new ldisc. 
+
+While these functions are slightly slower than the old code they should have
+minimal impact as most receive logic uses the flip buffers and they only
+need to take a reference when they push bits up through the driver.
+
+
+
+Driver Interface
+----------------
+
+open()		-	Called when a device is opened. May sleep
+
+close()		-	Called when a device is closed. At the point of
+			return from this call the driver must make no 
+			further ldisc calls of any kind. May sleep
+
+write()		-	Called to write bytes to the device. May not
+			sleep. May occur in parallel in special cases. 
+			Because this includes panic paths drivers generally
+			shouldn't try and do clever locking here.
+
+put_char()	-	Stuff a single character onto the queue. The
+			driver is guaranteed following up calls to
+			flush_chars.
+
+flush_chars()	-	Ask the kernel to write put_char queue
+
+write_room()	-	Return the number of characters tht can be stuffed
+			into the port buffers without overflow (or less).
+			The ldisc is responsible for being intelligent
+			about multi-threading of write_room/write calls
+
+ioctl()		-	Called when an ioctl may be for the driver
+
+set_termios()	-	Called on termios change, may get parallel calls,
+			may block for now (may change that)
+
+set_ldisc()	-	Notifier for discipline change. At the point this 
+			is done the discipline is not yet usable. Can now
+			sleep (I think)
+
+throttle()	-	Called by the ldisc to ask the driver to do flow
+			control.  Serialization including with unthrottle
+			is the job of the ldisc layer.
+
+unthrottle()	-	Called by the ldisc to ask the driver to stop flow
+			control.
+
+stop()		-	Ldisc notifier to the driver to stop output. As with
+			throttle the serializations with start() are down
+			to the ldisc layer.
+
+start()		-	Ldisc notifier to the driver to start output.
+
+hangup()	-	Ask the tty driver to cause a hangup initiated
+			from the host side. [Can sleep ??]
+
+break_ctl()	-	Send RS232 break. Can sleep. Can get called in
+			parallel, driver must serialize (for now), and
+			with write calls.
+
+wait_until_sent() -	Wait for characters to exit the hardware queue
+			of the driver. Can sleep
+
+send_xchar()	  -	Send XON/XOFF and if possible jump the queue with
+			it in order to get fast flow control responses.
+			Cannot sleep ??
+
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc1/drivers/char/tty_io.c linux-2.6.9rc1/drivers/char/tty_io.c
--- linux.vanilla-2.6.9rc1/drivers/char/tty_io.c	2004-08-31 15:04:14.000000000 +0100
+++ linux-2.6.9rc1/drivers/char/tty_io.c	2004-09-09 18:56:50.628381144 +0100
@@ -104,7 +104,7 @@
 
 #include <linux/kmod.h>
 
-#undef TTY_DEBUG_HANGUP
+#define TTY_DEBUG_HANGUP	/* FIXME undef */
 
 #define TTY_PARANOIA_CHECK 1
 #define CHECK_TTY_COUNT 1
@@ -120,10 +120,14 @@
 
 EXPORT_SYMBOL(tty_std_termios);
 
+/* This list gets poked at by procfs and various bits of boot up code. This
+   could do with some rationalisation such as pulling the tty proc function
+   into this file */
+   
 LIST_HEAD(tty_drivers);			/* linked list of tty drivers */
-struct tty_ldisc ldiscs[NR_LDISCS];	/* line disc dispatch table	*/
 
-/* Semaphore to protect creating and releasing a tty */
+/* Semaphore to protect creating and releasing a tty. This is shared with
+   vt.c for deeply disgusting hack reasons */
 DECLARE_MUTEX(tty_sem);
 
 #ifdef CONFIG_UNIX98_PTYS
@@ -223,65 +227,272 @@
 	return 0;
 }
 
+/*
+ *	This guards the refcounted line discipline lists. The lock
+ *	must be taken with irqs off because there are hangup path
+ *	callers who will do ldisc lookups and cannot sleep.
+ */
+ 
+static spinlock_t tty_ldisc_lock = SPIN_LOCK_UNLOCKED;
+static struct tty_ldisc tty_ldiscs[NR_LDISCS];	/* line disc dispatch table	*/
+
 int tty_register_ldisc(int disc, struct tty_ldisc *new_ldisc)
 {
+	unsigned long flags;
+	int ret = 0;
+	
 	if (disc < N_TTY || disc >= NR_LDISCS)
 		return -EINVAL;
 	
+	spin_lock_irqsave(&tty_ldisc_lock, flags);
 	if (new_ldisc) {
-		ldiscs[disc] = *new_ldisc;
-		ldiscs[disc].flags |= LDISC_FLAG_DEFINED;
-		ldiscs[disc].num = disc;
-	} else
-		memset(&ldiscs[disc], 0, sizeof(struct tty_ldisc));
+		tty_ldiscs[disc] = *new_ldisc;
+		tty_ldiscs[disc].num = disc;
+		tty_ldiscs[disc].flags |= LDISC_FLAG_DEFINED;
+		tty_ldiscs[disc].refcount = 0;
+	} else {
+		if(tty_ldiscs[disc].refcount)
+			ret = -EBUSY;
+		else
+			tty_ldiscs[disc].flags &= ~LDISC_FLAG_DEFINED;
+	}
+	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 	
-	return 0;
+	return ret;
 }
 
 EXPORT_SYMBOL(tty_register_ldisc);
 
-/* Set the discipline of a tty line. */
+struct tty_ldisc *tty_ldisc_get(int disc)
+{
+	unsigned long flags;
+	struct tty_ldisc *ld;
+
+	if (disc < N_TTY || disc >= NR_LDISCS)
+		return NULL;
+	
+	spin_lock_irqsave(&tty_ldisc_lock, flags);
+
+	ld = &tty_ldiscs[disc];
+	/* Check the entry is defined */
+	if(ld->flags & LDISC_FLAG_DEFINED)
+	{
+		/* If the module is being unloaded we can't use it */
+		if (!try_module_get(ld->owner))
+		       	ld = NULL;
+		else /* lock it */
+			ld->refcount++;
+	}
+	else
+		ld = NULL;
+	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+	return ld;
+}
+
+EXPORT_SYMBOL_GPL(tty_ldisc_get);
+
+void tty_ldisc_put(int disc)
+{
+	struct tty_ldisc *ld;
+	unsigned long flags;
+	
+	if (disc < N_TTY || disc >= NR_LDISCS)
+		BUG();
+		
+	spin_lock_irqsave(&tty_ldisc_lock, flags);
+	ld = &tty_ldiscs[disc];
+	if(ld->refcount == 0)
+		BUG();
+	ld->refcount --;
+	module_put(ld->owner);
+	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+}
+	
+EXPORT_SYMBOL_GPL(tty_ldisc_put);
+
+/**
+ *	tty_ldisc_ref_wait	-	wait for the tty ldisc
+ *	@tty: tty device
+ *
+ *	Dereference the line discipline for the terminal and take a 
+ *	reference to it. If the line discipline is in flux then 
+ *	wait patiently until it changes.
+ *
+ *	Note: Must not be called from an IRQ/timer context. The caller
+ *	must also be careful not to hold other locks that will deadlock
+ *	against a discipline change, such as an existing ldisc reference
+ *	(which we check for)
+ */
+ 
+struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *tty)
+{
+	struct tty_ldisc *ld;
+	unsigned long flags;
+	int ct = 0;	/* This is just for debug */
+	do
+	{	
+		spin_lock_irqsave(&tty_ldisc_lock, flags);
+		ld = &tty->ldisc;
+		if(test_bit(TTY_LDISC, &tty->flags))
+		{
+			ld->refcount++;
+			spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+			return ld;
+		}
+		spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+		if(test_bit(TTY_CLOSING, &tty->flags))
+		{
+			printk(KERN_ERR "Closing while in ref_wait: BAD\n");
+			return NULL;
+		}
+		/* FIXME: proper wakeup queue here */
+		msleep(100);
+	}
+	while(ct++ < 100);
+	printk(KERN_EMERG "Orinoco was here.\n");
+	return NULL;
+}
+
+/**
+ *	tty_ldisc_ref		-	get the tty ldisc
+ *	@tty: tty device
+ *
+ *	Dereference the line discipline for the terminal and take a 
+ *	reference to it. If the line discipline is in flux then 
+ *	return NULL. Can be called from IRQ and timer functions.
+ */
+ 
+struct tty_ldisc *tty_ldisc_ref(struct tty_struct *tty)
+{
+	struct tty_ldisc *ld;
+	unsigned long flags;
+	
+	spin_lock_irqsave(&tty_ldisc_lock, flags);
+	ld = &tty->ldisc;
+	if(test_bit(TTY_LDISC, &tty->flags))
+		ld->refcount++;
+	else
+		ld = NULL;
+	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+	return ld;
+}
+
+/**
+ *	tty_ldisc_deref		-	free a tty ldisc reference
+ *	@ld: reference to free up
+ *
+ *	Undoes the effect of tty_ldisc_ref or tty_ldisc_ref_wait. May
+ *	be called in IRQ context.
+ */
+ 
+void tty_ldisc_deref(struct tty_ldisc *ld)
+{
+	unsigned long flags;
+
+	if(ld == NULL)
+		return;
+		
+	spin_lock_irqsave(&tty_ldisc_lock, flags);
+	ld->refcount--;
+//	if(ld->refcount == 0)
+//		wake_up(&tty_ldisc_wait);
+	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+}
+	
+/**
+ *	tty_set_ldisc		-	set line discipline
+ *	@tty: the terminal to set
+ *	@ldisc: the line discipline
+ *
+ *	Set the discipline of a tty line. Must be called from a process
+ *	context.
+ */
+ 
 static int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 {
 	int	retval = 0;
 	struct	tty_ldisc o_ldisc;
 	char buf[64];
+	int work;
+	unsigned long flags;
+	struct tty_ldisc *ld;
 
 	if ((ldisc < N_TTY) || (ldisc >= NR_LDISCS))
 		return -EINVAL;
+	if (tty->ldisc.num == ldisc)
+		return 0;	/* We are already in the desired discipline */
+	
+	printk(KERN_EMERG "tty_set_ldisc\n");
+	ld = tty_ldisc_get(ldisc);
 	/* Eduardo Blanco <ejbs@cs.cs.com.uy> */
 	/* Cyrus Durgin <cider@speakeasy.org> */
-	if (!(ldiscs[ldisc].flags & LDISC_FLAG_DEFINED)) {
+	if (ld == NULL) {
 		request_module("tty-ldisc-%d", ldisc);
+		ld = tty_ldisc_get(ldisc);
 	}
-	if (!(ldiscs[ldisc].flags & LDISC_FLAG_DEFINED))
+	if (ld == NULL)
 		return -EINVAL;
 
-	if (tty->ldisc.num == ldisc)
-		return 0;	/* We are already in the desired discipline */
-
-	if (!try_module_get(ldiscs[ldisc].owner))
-	       	return -EINVAL;
-	
 	o_ldisc = tty->ldisc;
 
 	tty_wait_until_sent(tty, 0);
+
+	/*
+	 *	Make sure we don't change while someone holds a
+	 *	reference to the line discipline. The TTY_LDISC bit
+	 *	prevents anyone taking a reference once it is clear.
+	 *	We need the lock to avoid racing reference takers.
+	 */
+	 
+	spin_lock_irqsave(&tty_ldisc_lock, flags);
+	if(tty->ldisc.refcount)
+	{
+		/* Free the new ldisc we grabbed. Must drop the lock
+		   first. */
+		spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+		tty_ldisc_put(ldisc);
+		return -EBUSY;
+	}
+	clear_bit(TTY_LDISC, &tty->flags);	
+	clear_bit(TTY_DONT_FLIP, &tty->flags);
+	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 	
+	printk(KERN_EMERG "tty_set_ldisc: wait\n");
+	/*
+	 *	From this point on we know nobody has an ldisc
+	 *	usage reference, nor can they obtain one until
+	 *	we say so later on.
+	 */
+	 
+	work = cancel_delayed_work(&tty->flip.work);
+	/*
+	 * Wait for ->hangup_work and ->flip.work handlers to terminate
+	 */
+	 
+	printk(KERN_EMERG "flush_sched\n");
+	flush_scheduled_work();
+	printk(KERN_EMERG "flush_sched - DONE\n");
 	/* Shutdown the current discipline. */
 	if (tty->ldisc.close)
 		(tty->ldisc.close)(tty);
 
+	printk(KERN_EMERG "tty_set_ldisc: close\n");
 	/* Now set up the new line discipline. */
-	tty->ldisc = ldiscs[ldisc];
+	tty->ldisc = *ld;
 	tty->termios->c_line = ldisc;
 	if (tty->ldisc.open)
 		retval = (tty->ldisc.open)(tty);
 	if (retval < 0) {
-		tty->ldisc = o_ldisc;
+		tty_ldisc_put(ldisc);
+		/* There is an outstanding reference here so this is safe */
+		tty->ldisc = *tty_ldisc_get(o_ldisc.num);
 		tty->termios->c_line = tty->ldisc.num;
 		if (tty->ldisc.open && (tty->ldisc.open(tty) < 0)) {
-			tty->ldisc = ldiscs[N_TTY];
+			tty_ldisc_put(o_ldisc.num);
+			/* This driver is always present */
+			tty->ldisc = *tty_ldisc_get(N_TTY);
 			tty->termios->c_line = N_TTY;
+			/* FIXME: module count logic seems buggy */
 			if (tty->ldisc.open) {
 				int r = tty->ldisc.open(tty);
 
@@ -291,12 +502,28 @@
 					      tty_name(tty, buf), r);
 			}
 		}
-	} else {
-		module_put(o_ldisc.owner);
 	}
+	/* At this point we hold a reference to the new ldisc and a
+	   a reference to the old ldisc. If we ended up flipping back
+	   to the existing ldisc we have two references to it */
 	
 	if (tty->ldisc.num != o_ldisc.num && tty->driver->set_ldisc)
 		tty->driver->set_ldisc(tty);
+		
+	tty_ldisc_put(o_ldisc.num);
+	
+	/*
+	 *	Allow ldisc referencing to occur as soon as the driver
+	 *	ldisc callback completes.
+	 */
+	 
+	printk(KERN_EMERG "tty_set_ldisc: back\n");
+	set_bit(TTY_LDISC, &tty->flags);
+	
+	/* Restart it in case no characters kick it off. Safe if
+	   already running */
+	if(work)
+		schedule_delayed_work(&tty->flip.work, 1);
 	return retval;
 }
 
@@ -411,6 +638,7 @@
 	struct file *filp, *f = NULL;
 	struct task_struct *p;
 	struct pid *pid;
+	struct tty_ldisc *ld;
 	int    closecount = 0, n;
 
 	if (!tty)
@@ -441,18 +669,18 @@
 	
 	/* FIXME! What are the locking issues here? This may me overdoing things..
 	* this question is especially important now that we've removed the irqlock. */
-	{
-		unsigned long flags;
 
-		local_irq_save(flags); // FIXME: is this safe?
-		if (tty->ldisc.flush_buffer)
-			tty->ldisc.flush_buffer(tty);
-		if (tty->driver->flush_buffer)
-			tty->driver->flush_buffer(tty);
+	ld = tty_ldisc_ref(tty);
+	if(ld != NULL)	/* We may have no line discipline at this point */
+	{
+		if (ld->flush_buffer)
+			ld->flush_buffer(tty);
+		if (ld->flush_buffer)
+			ld->flush_buffer(tty);
 		if ((test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags)) &&
-		    tty->ldisc.write_wakeup)
-			(tty->ldisc.write_wakeup)(tty);
-		local_irq_restore(flags); // FIXME: is this safe?
+		    ld->write_wakeup)
+			ld->write_wakeup(tty);
+		tty_ldisc_deref(ld);
 	}
 
 	wake_up_interruptible(&tty->write_wait);
@@ -464,20 +692,12 @@
 	 */
 	if (tty->driver->flags & TTY_DRIVER_RESET_TERMIOS)
 		*tty->termios = tty->driver->init_termios;
-	if (tty->ldisc.num != ldiscs[N_TTY].num) {
-		if (tty->ldisc.close)
-			(tty->ldisc.close)(tty);
-		module_put(tty->ldisc.owner);
 		
-		tty->ldisc = ldiscs[N_TTY];
-		tty->termios->c_line = N_TTY;
-		if (tty->ldisc.open) {
-			int i = (tty->ldisc.open)(tty);
-			if (i < 0)
-				printk(KERN_ERR "do_tty_hangup: N_TTY open: "
-						"error %d\n", -i);
-		}
-	}
+	/* Defer ldisc switch */
+	/* tty_deferred_ldisc_switch(N_TTY);
+	
+	  This should get done automatically when the port closes and
+	  tty_release is called */
 	
 	read_lock(&tasklist_lock);
 	if (tty->session > 0) {
@@ -617,6 +837,8 @@
 
 void start_tty(struct tty_struct *tty)
 {
+	struct tty_ldisc *ld;
+	
 	if (!tty->stopped || tty->flow_stopped)
 		return;
 	tty->stopped = 0;
@@ -627,9 +849,13 @@
 	}
 	if (tty->driver->start)
 		(tty->driver->start)(tty);
-	if ((test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags)) &&
-	    tty->ldisc.write_wakeup)
-		(tty->ldisc.write_wakeup)(tty);
+
+	/* If we have a running line discipline it may need kicking */		
+	ld = tty_ldisc_ref(tty);
+	if (ld && (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags)) &&
+	    ld->write_wakeup)
+		(ld->write_wakeup)(tty);
+	tty_ldisc_deref(ld);		
 	wake_up_interruptible(&tty->write_wait);
 }
 
@@ -641,6 +867,7 @@
 	int i;
 	struct tty_struct * tty;
 	struct inode *inode;
+	struct tty_ldisc *ld;
 
 	tty = (struct tty_struct *)file->private_data;
 	inode = file->f_dentry->d_inode;
@@ -649,11 +876,15 @@
 	if (!tty || (test_bit(TTY_IO_ERROR, &tty->flags)))
 		return -EIO;
 
+	/* We want to wait for the line discipline to sort out in this
+	   situation */
+	ld = tty_ldisc_ref_wait(tty);
 	lock_kernel();
-	if (tty->ldisc.read)
-		i = (tty->ldisc.read)(tty,file,buf,count);
+	if (ld && ld->read)
+		i = (ld->read)(tty,file,buf,count);
 	else
 		i = -EIO;
+	tty_ldisc_deref(ld);
 	unlock_kernel();
 	if (i > 0)
 		inode->i_atime = CURRENT_TIME;
@@ -715,16 +946,23 @@
 {
 	struct tty_struct * tty;
 	struct inode *inode = file->f_dentry->d_inode;
-
+	ssize_t ret;
+	struct tty_ldisc *ld;
+	
 	tty = (struct tty_struct *)file->private_data;
 	if (tty_paranoia_check(tty, inode, "tty_write"))
 		return -EIO;
 	if (!tty || !tty->driver->write || (test_bit(TTY_IO_ERROR, &tty->flags)))
 		return -EIO;
-	if (!tty->ldisc.write)
-		return -EIO;
-	return do_tty_write(tty->ldisc.write, tty, file,
+
+	ld = tty_ldisc_ref_wait(tty);		
+	if (!ld || !ld->write)
+		ret = -EIO;
+	else
+		ret = do_tty_write(ld->write, tty, file,
 			    (const unsigned char __user *)buf, count);
+	tty_ldisc_deref(ld);
+	return ret;
 }
 
 ssize_t redirected_tty_write(struct file * file, const char __user * buf, size_t count,
@@ -768,6 +1006,7 @@
 	struct termios *ltp, **ltp_loc, *o_ltp, **o_ltp_loc;
 	int retval=0;
 
+	printk(KERN_EMERG "init_dev\n");
 	/* 
 	 * Check whether we need to acquire the tty semaphore to avoid
 	 * race conditions.  For now, play it safe.
@@ -910,6 +1149,9 @@
 	 * If we fail here just call release_mem to clean up.  No need
 	 * to decrement the use counts, as release_mem doesn't care.
 	 */
+
+	printk(KERN_EMERG "init_dev: ldisc open\n");
+	
 	if (tty->ldisc.open) {
 		retval = (tty->ldisc.open)(tty);
 		if (retval)
@@ -922,7 +1164,9 @@
 				(tty->ldisc.close)(tty);
 			goto release_mem_out;
 		}
+		set_bit(TTY_LDISC, &o_tty->flags);
 	}
+	set_bit(TTY_LDISC, &tty->flags);
 	goto success;
 
 	/*
@@ -932,6 +1176,7 @@
 	 * opens on a pty master.
 	 */
 fast_track:
+	printk(KERN_EMERG "init_dev: fast track\n");
 	if (test_bit(TTY_CLOSING, &tty->flags)) {
 		retval = -EIO;
 		goto end_init;
@@ -951,7 +1196,11 @@
 	tty->count++;
 	tty->driver = driver; /* N.B. why do this every time?? */
 
+	/* FIXME */
+	if(!test_bit(TTY_LDISC, &tty->flags))
+		printk(KERN_ERR "init_dev but no ldisc\n");
 success:
+	printk(KERN_EMERG "init_dev: done\n");
 	*ret_tty = tty;
 	
 	/* All paths come through here to release the semaphore */
@@ -1059,6 +1308,7 @@
 	if (tty_paranoia_check(tty, filp->f_dentry->d_inode, "release_dev"))
 		return;
 
+	printk(KERN_EMERG "Release_dev\n");
 	check_tty_count(tty, "release_dev");
 
 	tty_fasync(-1, filp, 0);
@@ -1130,6 +1380,7 @@
 		}
 	}
 #endif
+	printk(KERN_EMERG "Release_dev: close driver\n");
 
 	if (tty->driver->close)
 		tty->driver->close(tty, filp);
@@ -1185,6 +1436,7 @@
 		schedule();
 	}	
 
+	printk(KERN_EMERG "Release_dev: loop1 done\n");
 	/*
 	 * The closing flags are now consistent with the open counts on 
 	 * both sides, and we've completed the last operation that could 
@@ -1247,41 +1499,58 @@
 		read_unlock(&tasklist_lock);
 	}
 
+	printk(KERN_EMERG "Release_dev: closing\n");
 	/* check whether both sides are closing ... */
 	if (!tty_closing || (o_tty && !o_tty_closing))
+	{
+		printk(KERN_EMERG "Release_dev: half closed - DONE\n");
 		return;
+	}
 	
 #ifdef TTY_DEBUG_HANGUP
 	printk(KERN_DEBUG "freeing tty structure...");
 #endif
 
+	printk(KERN_EMERG "Clear ldisc\n");
 	/*
 	 * Prevent flush_to_ldisc() from rescheduling the work for later.  Then
-	 * kill any delayed work.
+	 * kill any delayed work. As this is the final close it does not
+	 * race with the set_ldisc code path.
 	 */
+	clear_bit(TTY_LDISC, &tty->flags);
 	clear_bit(TTY_DONT_FLIP, &tty->flags);
 	cancel_delayed_work(&tty->flip.work);
 
 	/*
 	 * Wait for ->hangup_work and ->flip.work handlers to terminate
 	 */
+	 
+	printk(KERN_EMERG "Flush sched\n");
 	flush_scheduled_work();
+	printk(KERN_EMERG "Flush done\n");
 
 	/*
 	 * Shutdown the current line discipline, and reset it to N_TTY.
 	 * N.B. why reset ldisc when we're releasing the memory??
+	 *
+	 * FIXME: this MUST get fixed for the new reflocking
 	 */
 	if (tty->ldisc.close)
 		(tty->ldisc.close)(tty);
-	module_put(tty->ldisc.owner);
+	tty_ldisc_put(tty->ldisc.num);
 	
-	tty->ldisc = ldiscs[N_TTY];
+	/*
+	 *	Switch the line discipline back
+	 */
+	tty->ldisc = *tty_ldisc_get(N_TTY);
 	tty->termios->c_line = N_TTY;
 	if (o_tty) {
+		/* FIXME: could o_tty be in setldisc here ? */
+		clear_bit(TTY_LDISC, &o_tty->flags);
 		if (o_tty->ldisc.close)
 			(o_tty->ldisc.close)(o_tty);
-		module_put(o_tty->ldisc.owner);
-		o_tty->ldisc = ldiscs[N_TTY];
+		tty_ldisc_put(o_tty->ldisc.num);
+		o_tty->ldisc = *tty_ldisc_get(N_TTY);
 	}
 
 	/*
@@ -1323,6 +1592,8 @@
 	unsigned short saved_flags = filp->f_flags;
 
 	nonseekable_open(inode, filp);
+	
+	printk(KERN_EMERG "tty_open (%d)\n", MAJOR(device));
 retry_open:
 	noctty = filp->f_flags & O_NOCTTY;
 	index  = -1;
@@ -1479,14 +1750,18 @@
 static unsigned int tty_poll(struct file * filp, poll_table * wait)
 {
 	struct tty_struct * tty;
+	struct tty_ldisc *ld;
+	int ret = 0;
 
 	tty = (struct tty_struct *)filp->private_data;
 	if (tty_paranoia_check(tty, filp->f_dentry->d_inode, "tty_poll"))
 		return 0;
-
-	if (tty->ldisc.poll)
-		return (tty->ldisc.poll)(tty, filp, wait);
-	return 0;
+		
+	ld = tty_ldisc_ref_wait(tty);
+	if (ld && ld->poll)
+		ret = (ld->poll)(tty, filp, wait);
+	tty_ldisc_deref(ld);
+	return ret;
 }
 
 static int tty_fasync(int fd, struct file * filp, int on)
@@ -1518,12 +1793,19 @@
 static int tiocsti(struct tty_struct *tty, char __user *p)
 {
 	char ch, mbz = 0;
-
+	struct tty_ldisc *ld;
+	
 	if ((current->signal->tty != tty) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	if (get_user(ch, p))
 		return -EFAULT;
-	tty->ldisc.receive_buf(tty, &ch, &mbz, 1);
+	ld = tty_ldisc_ref_wait(tty);
+	/* FIXME: suppose this is NOFLIP ?? */
+	if(ld)
+	{
+		ld->receive_buf(tty, &ch, &mbz, 1);
+		tty_ldisc_deref(ld);
+	}
 	return 0;
 }
 
@@ -1772,6 +2054,7 @@
 	struct tty_struct *tty, *real_tty;
 	void __user *p = (void __user *)arg;
 	int retval;
+	struct tty_ldisc *ld;
 	
 	tty = (struct tty_struct *)file->private_data;
 	if (tty_paranoia_check(tty, inode, "tty_ioctl"))
@@ -1861,6 +2144,7 @@
 		case TIOCGSID:
 			return tiocgsid(tty, real_tty, p);
 		case TIOCGETD:
+			/* FIXME: check this is ok */
 			return put_user(tty->ldisc.num, (int __user *)p);
 		case TIOCSETD:
 			return tiocsetd(tty, p);
@@ -1899,16 +2183,20 @@
 			return tty_tiocmset(tty, file, cmd, p);
 	}
 	if (tty->driver->ioctl) {
-		int retval = (tty->driver->ioctl)(tty, file, cmd, arg);
+		retval = (tty->driver->ioctl)(tty, file, cmd, arg);
 		if (retval != -ENOIOCTLCMD)
 			return retval;
 	}
-	if (tty->ldisc.ioctl) {
-		int retval = (tty->ldisc.ioctl)(tty, file, cmd, arg);
-		if (retval != -ENOIOCTLCMD)
-			return retval;
+	ld = tty_ldisc_ref_wait(tty);
+	retval = -EINVAL;
+	if (ld && ld->ioctl) {
+		if(likely(test_bit(TTY_LDISC, &tty->flags)))
+			retval = (tty->ldisc.ioctl)(tty, file, cmd, arg);
+		if (retval == -ENOIOCTLCMD)
+			retval = -EINVAL;
 	}
-	return -EINVAL;
+	tty_ldisc_deref(ld);
+	return retval;
 }
 
 
@@ -1943,14 +2231,21 @@
 	int session;
 	int		i;
 	struct file	*filp;
+	struct tty_ldisc *disc;
 	
 	if (!tty)
 		return;
 	session  = tty->session;
-	if (tty->ldisc.flush_buffer)
-		tty->ldisc.flush_buffer(tty);
+	
+	/* We don't want an ldisc switch during this */
+	disc = tty_ldisc_ref(tty);
+	if (disc && disc->flush_buffer)
+		disc->flush_buffer(tty);
+	tty_ldisc_deref(disc);
+
 	if (tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
+	
 	read_lock(&tasklist_lock);
 	for_each_task_pid(session, PIDTYPE_SID, p, l, pid) {
 		if (p->signal->tty == tty || session > 0) {
@@ -2002,24 +2297,29 @@
 
 /*
  * This routine is called out of the software interrupt to flush data
- * from the flip buffer to the line discipline.
+ * from the flip buffer to the line discipline. 
  */
+ 
 static void flush_to_ldisc(void *private_)
 {
 	struct tty_struct *tty = (struct tty_struct *) private_;
 	unsigned char	*cp;
 	char		*fp;
 	int		count;
-	unsigned long flags;
+	unsigned long 	flags;
+	struct tty_ldisc *disc;
+
+	disc = tty_ldisc_ref(tty);
+	if (disc == NULL)	/*  !TTY_LDISC */
+		return;
 
 	if (test_bit(TTY_DONT_FLIP, &tty->flags)) {
 		/*
 		 * Do it after the next timer tick:
 		 */
 		schedule_delayed_work(&tty->flip.work, 1);
-		return;
+		goto out;
 	}
-
 	spin_lock_irqsave(&tty->read_lock, flags);
 	if (tty->flip.buf_num) {
 		cp = tty->flip.char_buf + TTY_FLIPBUF_SIZE;
@@ -2038,7 +2338,31 @@
 	tty->flip.count = 0;
 	spin_unlock_irqrestore(&tty->read_lock, flags);
 
-	tty->ldisc.receive_buf(tty, cp, fp, count);
+	disc->receive_buf(tty, cp, fp, count);
+out:
+	tty_ldisc_deref(disc);
+}
+
+/*
+ *	Call the ldisc flush directly from a driver. This function may
+ *	return an error and need retrying by the user.
+ */
+
+int tty_push_data(struct tty_struct *tty, unsigned char *cp, unsigned char *fp, int count)
+{
+	int ret = 0;
+	struct tty_ldisc *disc;
+	
+	disc = tty_ldisc_ref(tty);
+	if(test_bit(TTY_DONT_FLIP, &tty->flags))
+		ret = -EAGAIN;
+	else if(disc == NULL)
+		ret = -EIO;
+	else
+		disc->receive_buf(tty, cp, fp, count);
+	tty_ldisc_deref(disc);
+	return ret;
+	
 }
 
 /*
@@ -2113,7 +2437,7 @@
 {
 	memset(tty, 0, sizeof(struct tty_struct));
 	tty->magic = TTY_MAGIC;
-	tty->ldisc = ldiscs[N_TTY];
+	tty->ldisc = *tty_ldisc_get(N_TTY);
 	tty->pgrp = -1;
 	tty->flip.char_buf_ptr = tty->flip.char_buf;
 	tty->flip.flag_buf_ptr = tty->flip.flag_buf;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc1/drivers/char/tty_ioctl.c linux-2.6.9rc1/drivers/char/tty_ioctl.c
--- linux.vanilla-2.6.9rc1/drivers/char/tty_ioctl.c	2004-08-31 15:04:17.000000000 +0100
+++ linux-2.6.9rc1/drivers/char/tty_ioctl.c	2004-09-09 16:49:51.000000000 +0100
@@ -98,6 +98,7 @@
 {
 	int canon_change;
 	struct termios old_termios = *tty->termios;
+	struct tty_ldisc *ld;
 
 	local_irq_disable(); // FIXME: is this safe?
 	*tty->termios = *new_termios;
@@ -136,13 +137,16 @@
 	if (tty->driver->set_termios)
 		(*tty->driver->set_termios)(tty, &old_termios);
 
-	if (tty->ldisc.set_termios)
-		(*tty->ldisc.set_termios)(tty, &old_termios);
+	ld = tty_ldisc_ref(tty);
+	if (ld->set_termios)
+		(ld->set_termios)(tty, &old_termios);
+	tty_ldisc_deref(ld);
 }
 
 static int set_termios(struct tty_struct * tty, void __user *arg, int opt)
 {
 	struct termios tmp_termios;
+	struct tty_ldisc *ld;
 	int retval = tty_check_change(tty);
 
 	if (retval)
@@ -159,9 +163,13 @@
 			return -EFAULT;
 	}
 
-	if ((opt & TERMIOS_FLUSH) && tty->ldisc.flush_buffer)
-		tty->ldisc.flush_buffer(tty);
+	ld = tty_ldisc_ref(tty);
+	
+	if ((opt & TERMIOS_FLUSH) && ld->flush_buffer)
+		ld->flush_buffer(tty);
 
+	tty_ldisc_deref(ld);
+	
 	if (opt & TERMIOS_WAIT) {
 		tty_wait_until_sent(tty, 0);
 		if (signal_pending(current))
@@ -365,6 +373,7 @@
 	struct tty_struct * real_tty;
 	void __user *p = (void __user *)arg;
 	int retval;
+	struct tty_ldisc *ld;
 
 	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 	    tty->driver->subtype == PTY_TYPE_MASTER)
@@ -443,22 +452,26 @@
 			retval = tty_check_change(tty);
 			if (retval)
 				return retval;
+				
+			ld = tty_ldisc_ref(tty);
 			switch (arg) {
 			case TCIFLUSH:
-				if (tty->ldisc.flush_buffer)
-					tty->ldisc.flush_buffer(tty);
+				if (ld->flush_buffer)
+					ld->flush_buffer(tty);
 				break;
 			case TCIOFLUSH:
-				if (tty->ldisc.flush_buffer)
-					tty->ldisc.flush_buffer(tty);
+				if (ld->flush_buffer)
+					ld->flush_buffer(tty);
 				/* fall through */
 			case TCOFLUSH:
 				if (tty->driver->flush_buffer)
 					tty->driver->flush_buffer(tty);
 				break;
 			default:
+				tty_ldisc_deref(ld);
 				return -EINVAL;
 			}
+			tty_ldisc_deref(ld);
 			return 0;
 		case TIOCOUTQ:
 			return put_user(tty->driver->chars_in_buffer ?
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc1/fs/proc/proc_tty.c linux-2.6.9rc1/fs/proc/proc_tty.c
--- linux.vanilla-2.6.9rc1/fs/proc/proc_tty.c	2004-08-31 15:05:29.000000000 +0100
+++ linux-2.6.9rc1/fs/proc/proc_tty.c	2004-09-09 16:57:15.024238784 +0100
@@ -15,9 +15,6 @@
 #include <linux/seq_file.h>
 #include <asm/bitops.h>
 
-extern struct tty_ldisc ldiscs[];
-
-
 static int tty_ldiscs_read_proc(char *page, char **start, off_t off,
 				int count, int *eof, void *data);
 
@@ -159,12 +156,15 @@
 	int	i;
 	int	len = 0;
 	off_t	begin = 0;
-
+	struct tty_ldisc *ld;
+	
 	for (i=0; i < NR_LDISCS; i++) {
-		if (!(ldiscs[i].flags & LDISC_FLAG_DEFINED))
+		ld = tty_ldisc_get(i);
+		if (ld == NULL)
 			continue;
 		len += sprintf(page+len, "%-10s %2d\n",
-			       ldiscs[i].name ? ldiscs[i].name : "???", i);
+			       ld->name ? ld->name : "???", i);
+		tty_ldisc_put(i);
 		if (len+begin > off+count)
 			break;
 		if (len+begin < off) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc1/include/linux/tty.h linux-2.6.9rc1/include/linux/tty.h
--- linux.vanilla-2.6.9rc1/include/linux/tty.h	2004-08-31 15:03:59.000000000 +0100
+++ linux-2.6.9rc1/include/linux/tty.h	2004-09-09 16:58:00.000000000 +0100
@@ -306,19 +306,20 @@
  * tty->write.  Thus, you must use the inline functions set_bit() and
  * clear_bit() to make things atomic.
  */
-#define TTY_THROTTLED 0
-#define TTY_IO_ERROR 1
-#define TTY_OTHER_CLOSED 2
-#define TTY_EXCLUSIVE 3
-#define TTY_DEBUG 4
-#define TTY_DO_WRITE_WAKEUP 5
-#define TTY_PUSH 6
-#define TTY_CLOSING 7
-#define TTY_DONT_FLIP 8
-#define TTY_HW_COOK_OUT 14
-#define TTY_HW_COOK_IN 15
-#define TTY_PTY_LOCK 16
-#define TTY_NO_WRITE_SPLIT 17
+#define TTY_THROTTLED 		0	/* Call unthrottle() at threshold min */
+#define TTY_IO_ERROR 		1	/* Canse an I/O error (may be no ldisc too) */
+#define TTY_OTHER_CLOSED 	2	/* Other side (if any) has closed */
+#define TTY_EXCLUSIVE 		3	/* Exclusive open mode */
+#define TTY_DEBUG 		4	/* Debugging */
+#define TTY_DO_WRITE_WAKEUP 	5	/* Call write_wakeup after queuing new */
+#define TTY_PUSH 		6	/* n_tty private */
+#define TTY_CLOSING 		7	/* ->close() in progress */
+#define TTY_DONT_FLIP 		8	/* Defer buffer flip */
+#define TTY_LDISC 		9	/* Line discipline attached */
+#define TTY_HW_COOK_OUT 	14	/* Hardware can do output cooking */
+#define TTY_HW_COOK_IN 		15	/* Hardware can do input cooking */
+#define TTY_PTY_LOCK 		16	/* pty private */
+#define TTY_NO_WRITE_SPLIT 	17	/* Preserve write boundaries to driver */
 
 #define TTY_WRITE_FLUSH(tty) tty_write_flush((tty))
 
@@ -362,6 +363,13 @@
 extern int tty_get_baud_rate(struct tty_struct *tty);
 extern int tty_termios_baud_rate(struct termios *termios);
 
+extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
+extern void tty_ldisc_deref(struct tty_ldisc *);
+extern struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *);
+
+extern struct tty_ldisc *tty_ldisc_get(int);
+extern void tty_ldisc_put(int);
+
 struct semaphore;
 extern struct semaphore tty_sem;
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc1/include/linux/tty_ldisc.h linux-2.6.9rc1/include/linux/tty_ldisc.h
--- linux.vanilla-2.6.9rc1/include/linux/tty_ldisc.h	2004-08-31 15:04:00.000000000 +0100
+++ linux-2.6.9rc1/include/linux/tty_ldisc.h	2004-09-07 21:20:21.000000000 +0100
@@ -132,6 +132,8 @@
 	void	(*write_wakeup)(struct tty_struct *);
 
 	struct  module *owner;
+	
+	int refcount;
 };
 
 #define TTY_LDISC_MAGIC	0x5403

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269567AbUINRCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269567AbUINRCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269561AbUINQzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:55:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13547 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269496AbUINQew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:34:52 -0400
Date: Tue, 14 Sep 2004 12:34:26 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: PATCH: tty locking for 2.6.9rc2
Message-ID: <20040914163426.GA29253@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This updates the ldisc locking patch for the 2.6.9rc2 changes.


diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/Documentation/tty.txt linux-2.6.9rc2/Documentation/tty.txt
--- linux.vanilla-2.6.9rc2/Documentation/tty.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9rc2/Documentation/tty.txt	2004-09-14 14:43:03.118920256 +0100
@@ -0,0 +1,192 @@
+
+			The Lockronomicon
+
+Your guide to the ancient and twisted locking policies of the tty layer and
+the warped logic behind them. Beware all ye who read on.
+
+FIXME: still need to work out the full set of BKL assumptions and document
+them so they can eventually be killed off.
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
+			ldisc code for this tty. Can sleep.
+
+open()		-	Called when the line discipline is attached to
+			the terminal. No other call into the line
+			discipline for this tty will occur until it
+			completes successfully. Can sleep.
+
+write()		-	A process is writing data from user space
+			through the line discipline. Multiple write calls
+			are serialized by the tty layer for the ldisc. May
+			sleep.
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
+			ldisc. Must not sleep.
+
+write_wakeup()	-	May be called at any point between open and close.
+			The TTY_DO_WRITE_WAKEUP flag indicates if a call
+			is needed but always races versus calls. Thus the
+			ldisc must be careful about setting order and to
+			handle unexpected calls. Must not sleep.
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
+A caution: The ldisc->open(), ldisc->close() and driver->set_ldisc 
+functions are called with the ldisc unavailable. Thus tty_ldisc_ref will
+fail in this situation if used within these functions. Ldisc and driver
+code calling its own functions must be careful in this case. 
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
+ 			about multi-threading of write_room/write calls
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
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/drivers/bluetooth/hci_ldisc.c linux-2.6.9rc2/drivers/bluetooth/hci_ldisc.c
--- linux.vanilla-2.6.9rc2/drivers/bluetooth/hci_ldisc.c	2004-09-14 14:20:36.893577616 +0100
+++ linux-2.6.9rc2/drivers/bluetooth/hci_ldisc.c	2004-09-14 14:28:56.021698608 +0100
@@ -180,6 +180,7 @@ static int hci_uart_flush(struct hci_dev
 {
 	struct hci_uart *hu  = (struct hci_uart *) hdev->driver_data;
 	struct tty_struct *tty = hu->tty;
+	struct tty_ldisc *ld = tty_ldisc_ref(tty);
 
 	BT_DBG("hdev %p tty %p", hdev, tty);
 
@@ -188,8 +189,11 @@ static int hci_uart_flush(struct hci_dev
 	}
 
 	/* Flush any pending characters in the driver and discipline. */
-	if (tty->ldisc.flush_buffer)
-		tty->ldisc.flush_buffer(tty);
+	if (ld) {
+		if(ld->flush_buffer)
+			ld->flush_buffer(tty);
+		tty_ldisc_deref(ld);
+	}
 
 	if (tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
@@ -280,7 +284,9 @@ static int hci_uart_tty_open(struct tty_
 
 	spin_lock_init(&hu->rx_lock);
 
-	/* Flush any pending characters in the driver and line discipline */
+	/* Flush any pending characters in the driver and line discipline. */
+	/* FIXME: why is this needed. Note don't use ldisc_ref here as the
+	   open path is before the ldisc is referencable */
 	if (tty->ldisc.flush_buffer)
 		tty->ldisc.flush_buffer(tty);
 
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/drivers/char/pty.c linux-2.6.9rc2/drivers/char/pty.c
--- linux.vanilla-2.6.9rc2/drivers/char/pty.c	2004-09-14 14:22:53.260846640 +0100
+++ linux-2.6.9rc2/drivers/char/pty.c	2004-09-14 14:29:10.282530632 +0100
@@ -101,6 +101,10 @@ static void pty_unthrottle(struct tty_st
  *   (2) avoid redundant copying for cases where count >> receive_room
  * N.B. Calls from user space may now return an error code instead of
  * a count.
+ *
+ * FIXME: Our pty_write method is called with our ldisc lock held but
+ * not our partners. We can't just take the other one blindly without
+ * risking deadlocks.  There is also the small matter of TTY_DONT_FLIP
  */
 static int pty_write(struct tty_struct * tty, int from_user,
 		       const unsigned char *buf, int count)
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/drivers/char/rocket.c linux-2.6.9rc2/drivers/char/rocket.c
--- linux.vanilla-2.6.9rc2/drivers/char/rocket.c	2004-09-14 14:22:53.265845880 +0100
+++ linux-2.6.9rc2/drivers/char/rocket.c	2004-09-14 14:29:10.284530328 +0100
@@ -250,12 +250,16 @@ static void rp_do_receive(struct r_port 
 			  CHANNEL_t * cp, unsigned int ChanStatus)
 {
 	unsigned int CharNStat;
-	int ToRecv, wRecv, space, count;
+	int ToRecv, wRecv, space = 0, count;
 	unsigned char *cbuf;
 	char *fbuf;
+	struct tty_ldisc *ld;
+
+	ld = tty_ldisc_ref(tty);
 
 	ToRecv = sGetRxCnt(cp);
-	space = tty->ldisc.receive_room(tty);
+	if (ld)
+		space = tty->ldisc.receive_room(tty);
 	if (space > 2 * TTY_FLIPBUF_SIZE)
 		space = 2 * TTY_FLIPBUF_SIZE;
 	cbuf = tty->flip.char_buf;
@@ -354,7 +358,19 @@ static void rp_do_receive(struct r_port 
 		count += ToRecv;
 	}
 	/*  Push the data up to the tty layer */
-	tty->ldisc.receive_buf(tty, tty->flip.char_buf, tty->flip.flag_buf, count);
+	ld->receive_buf(tty, tty->flip.char_buf, tty->flip.flag_buf, count);
+	tty_ldisc_deref(ld);
+}
+
+static void rp_maybe_wakeup(struct tty_struct *tty)
+{
+	struct tty_ldisc *ld = tty_ldisc_ref(tty);
+	if (ld) {
+	
+		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && ld->write_wakeup)
+			ld->write_wakeup(tty);
+		tty_ldisc_deref(ld);
+	}
 }
 
 /*
@@ -408,8 +424,7 @@ static void rp_do_transmit(struct r_port
 		clear_bit((info->aiop * 8) + info->chan, (void *) &xmit_flags[info->board]);
 
 	if (info->xmit_cnt < WAKEUP_CHARS) {
-		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc.write_wakeup)
-			(tty->ldisc.write_wakeup) (tty);
+		rp_maybe_wakeup(tty);
 		wake_up_interruptible(&tty->write_wait);
 #ifdef ROCKETPORT_HAVE_POLL_WAIT
 		wake_up_interruptible(&tty->poll_wait);
@@ -1022,7 +1037,8 @@ static void rp_close(struct tty_struct *
 	unsigned long flags;
 	int timeout;
 	CHANNEL_t *cp;
-
+	struct tty_ldisc *ld;
+	
 	if (rocket_paranoia_check(info, "rp_close"))
 		return;
 
@@ -1101,8 +1117,13 @@ static void rp_close(struct tty_struct *
 
 	if (TTY_DRIVER_FLUSH_BUFFER_EXISTS(tty))
 		TTY_DRIVER_FLUSH_BUFFER(tty);
-	if (tty->ldisc.flush_buffer)
-		tty->ldisc.flush_buffer(tty);
+		
+	ld = tty_ldisc_ref(tty);
+	if (ld) {
+		if (ld->flush_buffer)
+			ld->flush_buffer(tty);
+		tty_ldisc_deref(ld);
+	}
 
 	clear_bit((info->aiop * 8) + info->chan, (void *) &xmit_flags[info->board]);
 
@@ -1727,8 +1748,7 @@ end_intr:
 	
 end:
  	if (info->xmit_cnt < WAKEUP_CHARS) {
-		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP))  && tty->ldisc.write_wakeup)
-			(tty->ldisc.write_wakeup) (tty);
+ 		rp_maybe_wakeup(tty);
 		wake_up_interruptible(&tty->write_wait);
 #ifdef ROCKETPORT_HAVE_POLL_WAIT
 		wake_up_interruptible(&tty->poll_wait);
@@ -1802,8 +1822,7 @@ static void rp_flush_buffer(struct tty_s
 #ifdef ROCKETPORT_HAVE_POLL_WAIT
 	wake_up_interruptible(&tty->poll_wait);
 #endif
-	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc.write_wakeup)
-		(tty->ldisc.write_wakeup) (tty);
+	rp_maybe_wakeup(tty);
 
 	cp = &info->channel;
 	sFlushTxFIFO(cp);
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/drivers/char/selection.c linux-2.6.9rc2/drivers/char/selection.c
--- linux.vanilla-2.6.9rc2/drivers/char/selection.c	2004-09-14 14:22:53.266845728 +0100
+++ linux-2.6.9rc2/drivers/char/selection.c	2004-09-14 14:29:10.285530176 +0100
@@ -277,12 +277,15 @@ int paste_selection(struct tty_struct *t
 {
 	struct vt_struct *vt = (struct vt_struct *) tty->driver_data;
 	int	pasted = 0, count;
+	struct  tty_ldisc *ld;
 	DECLARE_WAITQUEUE(wait, current);
 
 	acquire_console_sem();
 	poke_blanked_console();
 	release_console_sem();
 
+	ld = tty_ldisc_ref_wait(tty);
+	
 	add_wait_queue(&vt->paste_wait, &wait);
 	while (sel_buffer && sel_buffer_lth > pasted) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -297,6 +300,8 @@ int paste_selection(struct tty_struct *t
 	}
 	remove_wait_queue(&vt->paste_wait, &wait);
 	current->state = TASK_RUNNING;
+
+	tty_ldisc_deref(ld);
 	return 0;
 }
 
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/drivers/char/tty_io.c linux-2.6.9rc2/drivers/char/tty_io.c
--- linux.vanilla-2.6.9rc2/drivers/char/tty_io.c	2004-09-14 14:22:53.281843448 +0100
+++ linux-2.6.9rc2/drivers/char/tty_io.c	2004-09-14 14:30:18.478163320 +0100
@@ -92,6 +92,7 @@
 #include <linux/smp_lock.h>
 #include <linux/device.h>
 #include <linux/idr.h>
+#include <linux/wait.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -120,10 +121,14 @@ struct termios tty_std_termios = {	/* fo
 
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
@@ -224,64 +229,286 @@ static int check_tty_count(struct tty_st
 	return 0;
 }
 
+/*
+ *	This guards the refcounted line discipline lists. The lock
+ *	must be taken with irqs off because there are hangup path
+ *	callers who will do ldisc lookups and cannot sleep.
+ */
+ 
+static spinlock_t tty_ldisc_lock = SPIN_LOCK_UNLOCKED;
+static DECLARE_WAIT_QUEUE_HEAD(tty_ldisc_wait);
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
+ *	tty_ldisc_try		-	internal helper
+ *	@tty: the tty
+ *
+ *	Make a single attempt to grab and bump the refcount on
+ *	the tty ldisc. Return 0 on failure or 1 on success. This is
+ *	used to implement both the waiting and non waiting versions
+ *	of tty_ldisc_ref
+ */
+
+static int tty_ldisc_try(struct tty_struct *tty)
+{
+	unsigned long flags;
+	struct tty_ldisc *ld;
+	int ret = 0;
+	
+	spin_lock_irqsave(&tty_ldisc_lock, flags);
+	ld = &tty->ldisc;
+	if(test_bit(TTY_LDISC, &tty->flags))
+	{
+		ld->refcount++;
+		ret = 1;
+	}
+	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+	return ret;
+}
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
+	/* wait_event is a macro */
+	wait_event(tty_ldisc_wait, tty_ldisc_try(tty));
+	if(tty->ldisc.refcount == 0)
+		printk("Ref wait -> 0 ref\n");
+	return &tty->ldisc;
+}
+
+EXPORT_SYMBOL_GPL(tty_ldisc_ref_wait);
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
+	if(tty_ldisc_try(tty))
+		return &tty->ldisc;
+	return NULL;
+}
+
+EXPORT_SYMBOL_GPL(tty_ldisc_ref);
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
+		BUG();
+		
+	spin_lock_irqsave(&tty_ldisc_lock, flags);
+	if(ld->refcount == 0)
+		printk(KERN_EMERG "tty_ldisc_deref: no references.\n");
+	else
+		ld->refcount--;
+	if(ld->refcount == 0)
+		wake_up(&tty_ldisc_wait);
+	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+}
+
+EXPORT_SYMBOL_GPL(tty_ldisc_deref);
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
+
+restart:
+
+	if (tty->ldisc.num == ldisc)
+		return 0;	/* We are already in the desired discipline */
+	
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
+		/*
+		 * There are several reasons we may be busy, including
+		 * random momentary I/O traffic. We must therefore
+		 * retry. We could distinguish between blocking ops
+		 * and retries if we made tty_ldisc_wait() smarter. That
+		 * is up for discussion.
+		 */
+		if(wait_event_interruptible(tty_ldisc_wait, tty->ldisc.refcount == 0) < 0)
+			return -ERESTARTSYS;			
+		goto restart;
+	}
+	clear_bit(TTY_LDISC, &tty->flags);	
+	clear_bit(TTY_DONT_FLIP, &tty->flags);
+	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 	
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
+	flush_scheduled_work();
 	/* Shutdown the current discipline. */
 	if (tty->ldisc.close)
 		(tty->ldisc.close)(tty);
 
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
 			if (tty->ldisc.open) {
 				int r = tty->ldisc.open(tty);
@@ -292,12 +519,27 @@ static int tty_set_ldisc(struct tty_stru
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
+	set_bit(TTY_LDISC, &tty->flags);
+	
+	/* Restart it in case no characters kick it off. Safe if
+	   already running */
+	if(work)
+		schedule_delayed_work(&tty->flip.work, 1);
 	return retval;
 }
 
@@ -424,6 +666,7 @@ void do_tty_hangup(void *data)
 	struct file * cons_filp = NULL;
 	struct file *filp, *f = NULL;
 	struct task_struct *p;
+	struct tty_ldisc *ld;
 	int    closecount = 0, n;
 
 	if (!tty)
@@ -454,18 +697,17 @@ void do_tty_hangup(void *data)
 	
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
 	}
 
 	wake_up_interruptible(&tty->write_wait);
@@ -477,20 +719,12 @@ void do_tty_hangup(void *data)
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
@@ -523,6 +757,12 @@ void do_tty_hangup(void *data)
 				tty->driver->close(tty, cons_filp);
 	} else if (tty->driver->hangup)
 		(tty->driver->hangup)(tty);
+		
+	if(ld)
+	{
+		set_bit(TTY_LDISC, &tty->flags);
+		tty_ldisc_deref(ld);
+	}
 	unlock_kernel();
 	if (f)
 		fput(f);
@@ -628,6 +868,8 @@ EXPORT_SYMBOL(stop_tty);
 
 void start_tty(struct tty_struct *tty)
 {
+	struct tty_ldisc *ld;
+	
 	if (!tty->stopped || tty->flow_stopped)
 		return;
 	tty->stopped = 0;
@@ -638,9 +880,13 @@ void start_tty(struct tty_struct *tty)
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
 
@@ -652,6 +898,7 @@ static ssize_t tty_read(struct file * fi
 	int i;
 	struct tty_struct * tty;
 	struct inode *inode;
+	struct tty_ldisc *ld;
 
 	tty = (struct tty_struct *)file->private_data;
 	inode = file->f_dentry->d_inode;
@@ -660,11 +907,15 @@ static ssize_t tty_read(struct file * fi
 	if (!tty || (test_bit(TTY_IO_ERROR, &tty->flags)))
 		return -EIO;
 
+	/* We want to wait for the line discipline to sort out in this
+	   situation */
+	ld = tty_ldisc_ref_wait(tty);
 	lock_kernel();
-	if (tty->ldisc.read)
-		i = (tty->ldisc.read)(tty,file,buf,count);
+	if (ld->read)
+		i = (ld->read)(tty,file,buf,count);
 	else
 		i = -EIO;
+	tty_ldisc_deref(ld);
 	unlock_kernel();
 	if (i > 0)
 		inode->i_atime = CURRENT_TIME;
@@ -726,16 +977,23 @@ static ssize_t tty_write(struct file * f
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
+	if (!ld->write)
+		ret = -EIO;
+	else
+		ret = do_tty_write(ld->write, tty, file,
 			    (const unsigned char __user *)buf, count);
+	tty_ldisc_deref(ld);
+	return ret;
 }
 
 ssize_t redirected_tty_write(struct file * file, const char __user * buf, size_t count,
@@ -932,6 +1190,7 @@ static int init_dev(struct tty_driver *d
 	 * If we fail here just call release_mem to clean up.  No need
 	 * to decrement the use counts, as release_mem doesn't care.
 	 */
+
 	if (tty->ldisc.open) {
 		retval = (tty->ldisc.open)(tty);
 		if (retval)
@@ -944,7 +1203,9 @@ static int init_dev(struct tty_driver *d
 				(tty->ldisc.close)(tty);
 			goto release_mem_out;
 		}
+		set_bit(TTY_LDISC, &o_tty->flags);
 	}
+	set_bit(TTY_LDISC, &tty->flags);
 	goto success;
 
 	/*
@@ -973,6 +1234,9 @@ fast_track:
 	tty->count++;
 	tty->driver = driver; /* N.B. why do this every time?? */
 
+	/* FIXME */
+	if(!test_bit(TTY_LDISC, &tty->flags))
+		printk(KERN_ERR "init_dev but no ldisc\n");
 success:
 	*ret_tty = tty;
 	
@@ -1152,7 +1416,6 @@ static void release_dev(struct file * fi
 		}
 	}
 #endif
-
 	if (tty->driver->close)
 		tty->driver->close(tty, filp);
 
@@ -1276,34 +1539,43 @@ static void release_dev(struct file * fi
 #ifdef TTY_DEBUG_HANGUP
 	printk(KERN_DEBUG "freeing tty structure...");
 #endif
-
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
 	flush_scheduled_work();
 
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
@@ -1345,6 +1617,7 @@ static int tty_open(struct inode * inode
 	unsigned short saved_flags = filp->f_flags;
 
 	nonseekable_open(inode, filp);
+	
 retry_open:
 	noctty = filp->f_flags & O_NOCTTY;
 	index  = -1;
@@ -1508,14 +1781,18 @@ static int tty_release(struct inode * in
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
+	if (ld->poll)
+		ret = (ld->poll)(tty, filp, wait);
+	tty_ldisc_deref(ld);
+	return ret;
 }
 
 static int tty_fasync(int fd, struct file * filp, int on)
@@ -1547,12 +1824,19 @@ static int tty_fasync(int fd, struct fil
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
 
@@ -1800,6 +2084,7 @@ int tty_ioctl(struct inode * inode, stru
 	struct tty_struct *tty, *real_tty;
 	void __user *p = (void __user *)arg;
 	int retval;
+	struct tty_ldisc *ld;
 	
 	tty = (struct tty_struct *)file->private_data;
 	if (tty_paranoia_check(tty, inode, "tty_ioctl"))
@@ -1889,6 +2174,7 @@ int tty_ioctl(struct inode * inode, stru
 		case TIOCGSID:
 			return tiocgsid(tty, real_tty, p);
 		case TIOCGETD:
+			/* FIXME: check this is ok */
 			return put_user(tty->ldisc.num, (int __user *)p);
 		case TIOCSETD:
 			return tiocsetd(tty, p);
@@ -1927,16 +2213,20 @@ int tty_ioctl(struct inode * inode, stru
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
+	if (ld->ioctl) {
+		if(likely(test_bit(TTY_LDISC, &tty->flags)))
+			retval = ld->ioctl(tty, file, cmd, arg);
+		if (retval == -ENOIOCTLCMD)
+			retval = -EINVAL;
 	}
-	return -EINVAL;
+	tty_ldisc_deref(ld);
+	return retval;
 }
 
 
@@ -1969,14 +2259,21 @@ static void __do_SAK(void *arg)
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
 	do_each_task_pid(session, PIDTYPE_SID, p) {
 		if (p->signal->tty == tty || session > 0) {
@@ -2028,24 +2325,29 @@ EXPORT_SYMBOL(do_SAK);
 
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
@@ -2064,7 +2366,31 @@ static void flush_to_ldisc(void *private
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
@@ -2139,7 +2465,7 @@ static void initialize_tty_struct(struct
 {
 	memset(tty, 0, sizeof(struct tty_struct));
 	tty->magic = TTY_MAGIC;
-	tty->ldisc = ldiscs[N_TTY];
+	tty->ldisc = *tty_ldisc_get(N_TTY);
 	tty->pgrp = -1;
 	tty->flip.char_buf_ptr = tty->flip.char_buf;
 	tty->flip.flag_buf_ptr = tty->flip.flag_buf;
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/drivers/char/tty_ioctl.c linux-2.6.9rc2/drivers/char/tty_ioctl.c
--- linux.vanilla-2.6.9rc2/drivers/char/tty_ioctl.c	2004-09-14 14:20:00.696080472 +0100
+++ linux-2.6.9rc2/drivers/char/tty_ioctl.c	2004-09-14 14:29:24.297400048 +0100
@@ -98,6 +98,7 @@ static void change_termios(struct tty_st
 {
 	int canon_change;
 	struct termios old_termios = *tty->termios;
+	struct tty_ldisc *ld;
 
 	local_irq_disable(); // FIXME: is this safe?
 	*tty->termios = *new_termios;
@@ -136,13 +137,16 @@ static void change_termios(struct tty_st
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
@@ -159,9 +163,14 @@ static int set_termios(struct tty_struct
 			return -EFAULT;
 	}
 
-	if ((opt & TERMIOS_FLUSH) && tty->ldisc.flush_buffer)
-		tty->ldisc.flush_buffer(tty);
-
+	ld = tty_ldisc_ref(tty);
+	
+	if (ld != NULL) {
+		if ((opt & TERMIOS_FLUSH) && ld->flush_buffer)
+			ld->flush_buffer(tty);
+		tty_ldisc_deref(ld);
+	}
+	
 	if (opt & TERMIOS_WAIT) {
 		tty_wait_until_sent(tty, 0);
 		if (signal_pending(current))
@@ -365,6 +374,7 @@ int n_tty_ioctl(struct tty_struct * tty,
 	struct tty_struct * real_tty;
 	void __user *p = (void __user *)arg;
 	int retval;
+	struct tty_ldisc *ld;
 
 	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 	    tty->driver->subtype == PTY_TYPE_MASTER)
@@ -443,22 +453,26 @@ int n_tty_ioctl(struct tty_struct * tty,
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
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/drivers/char/viocons.c linux-2.6.9rc2/drivers/char/viocons.c
--- linux.vanilla-2.6.9rc2/drivers/char/viocons.c	2004-09-14 14:19:57.136621592 +0100
+++ linux-2.6.9rc2/drivers/char/viocons.c	2004-09-14 14:29:24.297400048 +0100
@@ -422,9 +422,13 @@ static void send_buffers(struct port_inf
 			pi->overflowMessage = 0;
 
 		if (pi->tty) {
-			if ((pi->tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-			    (pi->tty->ldisc.write_wakeup))
-				(pi->tty->ldisc.write_wakeup)(pi->tty);
+			struct tty_ldisc *ld = tty_ldisc_ref(tty);
+			if(ld) {
+				if ((pi->tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+				    (ld->write_wakeup))
+					(ld->write_wakeup)(pi->tty);
+				tty_ldisc_deref(ld);
+			}
 			wake_up_interruptible(&pi->tty->write_wait);
 		}
 	}
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/drivers/char/vt_ioctl.c linux-2.6.9rc2/drivers/char/vt_ioctl.c
--- linux.vanilla-2.6.9rc2/drivers/char/vt_ioctl.c	2004-09-14 14:19:57.789522336 +0100
+++ linux-2.6.9rc2/drivers/char/vt_ioctl.c	2004-09-14 14:29:24.298399896 +0100
@@ -373,6 +373,7 @@ int vt_ioctl(struct tty_struct *tty, str
 	unsigned char ucval;
 	void __user *up = (void __user *)arg;
 	int i, perm;
+	struct tty_ldisc *ld;
 	
 	console = vt->vc_num;
 
@@ -536,8 +537,12 @@ int vt_ioctl(struct tty_struct *tty, str
 		  default:
 			return -EINVAL;
 		}
-		if (tty->ldisc.flush_buffer)
-			tty->ldisc.flush_buffer(tty);
+		ld = tty_ldisc_ref(tty);
+		if (ld) {
+			if (ld->flush_buffer)
+				ld->flush_buffer(tty);
+			tty_ldisc_deref(ld);
+		}
 		return 0;
 
 	case KDGKBMODE:
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/drivers/isdn/capi/capi.c linux-2.6.9rc2/drivers/isdn/capi/capi.c
--- linux.vanilla-2.6.9rc2/drivers/isdn/capi/capi.c	2004-09-14 14:20:16.424689360 +0100
+++ linux-2.6.9rc2/drivers/isdn/capi/capi.c	2004-09-14 14:31:07.216753928 +0100
@@ -436,51 +436,62 @@ static int handle_recv_skb(struct capimi
 	struct sk_buff *nskb;
 	int datalen;
 	u16 errcode, datahandle;
-
+	struct tty_ldisc *ld;
+	
 	datalen = skb->len - CAPIMSG_LEN(skb->data);
-	if (mp->tty) {
-		if (mp->tty->ldisc.receive_buf == 0) {
-			printk(KERN_ERR "capi: ldisc has no receive_buf function\n");
-			return -1;
-		}
-		if (mp->ttyinstop) {
+	if (mp->tty == NULL)
+	{
+#ifdef _DEBUG_DATAFLOW
+		printk(KERN_DEBUG "capi: currently no receiver\n");
+#endif
+		return -1;
+	}
+	
+	ld = tty_ldisc_deref(mp->tty);
+	if (ld == NULL)
+		return -1;
+	if (ld->receive_buf == NULL) {
 #if defined(_DEBUG_DATAFLOW) || defined(_DEBUG_TTYFUNCS)
-			printk(KERN_DEBUG "capi: recv tty throttled\n");
+		printk(KERN_DEBUG "capi: ldisc has no receive_buf function\n");
 #endif
-			return -1;
-		}
-		if (mp->tty->ldisc.receive_room &&
-		    mp->tty->ldisc.receive_room(mp->tty) < datalen) {
+		goto bad;
+	}
+	if (mp->ttyinstop) {
 #if defined(_DEBUG_DATAFLOW) || defined(_DEBUG_TTYFUNCS)
-			printk(KERN_DEBUG "capi: no room in tty\n");
+		printk(KERN_DEBUG "capi: recv tty throttled\n");
 #endif
-			return -1;
-		}
-		if ((nskb = gen_data_b3_resp_for(mp, skb)) == 0) {
-			printk(KERN_ERR "capi: gen_data_b3_resp failed\n");
-			return -1;
-		}
-		datahandle = CAPIMSG_U16(skb->data,CAPIMSG_BASELEN+4);
-		errcode = capi20_put_message(mp->ap, nskb);
-		if (errcode != CAPI_NOERROR) {
-			printk(KERN_ERR "capi: send DATA_B3_RESP failed=%x\n",
-					errcode);
-			kfree_skb(nskb);
-			return -1;
-		}
-		(void)skb_pull(skb, CAPIMSG_LEN(skb->data));
-#ifdef _DEBUG_DATAFLOW
-		printk(KERN_DEBUG "capi: DATA_B3_RESP %u len=%d => ldisc\n",
-					datahandle, skb->len);
+		goto bad;
+	}
+	if (ld->receive_room &&
+	    ld->receive_room(mp->tty) < datalen) {
+#if defined(_DEBUG_DATAFLOW) || defined(_DEBUG_TTYFUNCS)
+		printk(KERN_DEBUG "capi: no room in tty\n");
 #endif
-		mp->tty->ldisc.receive_buf(mp->tty, skb->data, NULL, skb->len);
-		kfree_skb(skb);
-		return 0;
-
+		goto bad;
+	}
+	if ((nskb = gen_data_b3_resp_for(mp, skb)) == 0) {
+		printk(KERN_ERR "capi: gen_data_b3_resp failed\n");
+		goto bad;
+	}
+	datahandle = CAPIMSG_U16(skb->data,CAPIMSG_BASELEN+4);
+	errcode = capi20_put_message(mp->ap, nskb);
+	if (errcode != CAPI_NOERROR) {
+		printk(KERN_ERR "capi: send DATA_B3_RESP failed=%x\n",
+				errcode);
+		kfree_skb(nskb);
+		goto bad;
 	}
+	(void)skb_pull(skb, CAPIMSG_LEN(skb->data));
 #ifdef _DEBUG_DATAFLOW
-	printk(KERN_DEBUG "capi: currently no receiver\n");
+	printk(KERN_DEBUG "capi: DATA_B3_RESP %u len=%d => ldisc\n",
+				datahandle, skb->len);
 #endif
+	ld->receive_buf(mp->tty, skb->data, NULL, skb->len);
+	kfree_skb(skb);
+	tty_ldisc_deref(ld);
+	return 0;
+bad:
+	tty_ldisc_deref(ld);
 	return -1;
 }
 
@@ -614,6 +625,7 @@ static void capi_recv_message(struct cap
 
 
 	if (CAPIMSG_SUBCOMMAND(skb->data) == CAPI_IND) {
+		
 		datahandle = CAPIMSG_U16(skb->data, CAPIMSG_BASELEN+4+4+2);
 #ifdef _DEBUG_DATAFLOW
 		printk(KERN_DEBUG "capi_signal: DATA_B3_IND %u len=%d\n",
@@ -634,8 +646,12 @@ static void capi_recv_message(struct cap
 		kfree_skb(skb);
 		(void)capiminor_del_ack(mp, datahandle);
 		if (mp->tty) {
-			if (mp->tty->ldisc.write_wakeup)
-				mp->tty->ldisc.write_wakeup(mp->tty);
+			struct tty_ldisc *ld = tty_ldisc_ref(mp->tty);
+			if (ld != NULL)	{
+				if (ld->write_wakeup)
+					ld->write_wakeup(mp->tty);
+				tty_ldisc_deref(ld);
+			}
 		}
 		(void)handle_minor_send(mp);
 
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/drivers/isdn/i4l/isdn_tty.c linux-2.6.9rc2/drivers/isdn/i4l/isdn_tty.c
--- linux.vanilla-2.6.9rc2/drivers/isdn/i4l/isdn_tty.c	2004-09-14 14:20:15.382847744 +0100
+++ linux-2.6.9rc2/drivers/isdn/i4l/isdn_tty.c	2004-09-14 14:31:07.218753624 +0100
@@ -293,12 +293,16 @@ isdn_tty_tint(modem_info * info)
 	if ((slen = isdn_writebuf_skb_stub(info->isdn_driver,
 					   info->isdn_channel, 1, skb)) == len) {
 		struct tty_struct *tty = info->tty;
+		struct tty_ldisc *ld = tty_ldisc_ref(tty);
 		info->send_outstanding++;
 		info->msr &= ~UART_MSR_CTS;
 		info->lsr &= ~UART_LSR_TEMT;
-		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-		    tty->ldisc.write_wakeup)
-			(tty->ldisc.write_wakeup) (tty);
+		if (ld != NULL) {
+			if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+			     ld->write_wakeup)
+				ld->write_wakeup(tty);
+			tty_ldisc_deref(ld);
+		}
 		wake_up_interruptible(&tty->write_wait);
 		return;
 	}
@@ -1681,6 +1685,7 @@ isdn_tty_close(struct tty_struct *tty, s
 {
 	modem_info *info = (modem_info *) tty->driver_data;
 	ulong timeout;
+	struct tty_ldisc *ld;
 
 	if (!info || isdn_tty_paranoia_check(info, tty->name, "isdn_tty_close"))
 		return;
@@ -1747,10 +1752,16 @@ isdn_tty_close(struct tty_struct *tty, s
 	}
 	dev->modempoll--;
 	isdn_tty_shutdown(info);
+	
 	if (tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
-	if (tty->ldisc.flush_buffer)
-		tty->ldisc.flush_buffer(tty);
+		
+	ld = tty_ldisc_ref(tty);
+	if (ld) {
+		if(ld->flush_buffer)
+			ld->flush_buffer(tty);
+		tty_ldisc_deref(ld);
+	}
 	info->tty = NULL;
 	info->ncarrier = 0;
 	tty->closing = 0;
@@ -2678,11 +2689,16 @@ isdn_tty_modem_result(int code, modem_in
 		}
 	}
 	if (code == RESULT_NO_CARRIER) {
+		struct tty_ldisc *ld;
 		if ((info->flags & ISDN_ASYNC_CLOSING) || (!info->tty)) {
 			return;
 		}
-		if (info->tty->ldisc.flush_buffer)
-			info->tty->ldisc.flush_buffer(info->tty);
+		ld = tty_ldisc_ref(info->tty);
+		if (ld) {
+			if (ld->flush_buffer)
+				ld->flush_buffer(info->tty);
+			tty_ldisc_deref(ld);
+		}
 		if ((info->flags & ISDN_ASYNC_CHECK_CD) &&
 		    (!((info->flags & ISDN_ASYNC_CALLOUT_ACTIVE) &&
 		       (info->flags & ISDN_ASYNC_CALLOUT_NOHUP)))) {
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/drivers/net/hamradio/mkiss.c linux-2.6.9rc2/drivers/net/hamradio/mkiss.c
--- linux.vanilla-2.6.9rc2/drivers/net/hamradio/mkiss.c	2004-09-14 14:20:06.083261496 +0100
+++ linux-2.6.9rc2/drivers/net/hamradio/mkiss.c	2004-09-14 14:31:29.327392600 +0100
@@ -602,8 +602,8 @@ static int ax25_open(struct tty_struct *
 
 	if (tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
-	if (tty->ldisc.flush_buffer)
-		tty->ldisc.flush_buffer(tty);
+	/* FIXME - not needed - check if (tty->ldisc.flush_buffer)
+		tty->ldisc.flush_buffer(tty); */
 
 	/* Restore default settings */
 	ax->dev->type = ARPHRD_AX25;
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/drivers/serial/serial_core.c linux-2.6.9rc2/drivers/serial/serial_core.c
--- linux.vanilla-2.6.9rc2/drivers/serial/serial_core.c	2004-09-14 14:20:35.741752720 +0100
+++ linux-2.6.9rc2/drivers/serial/serial_core.c	2004-09-14 14:31:49.953256992 +0100
@@ -111,9 +111,13 @@ static void uart_tasklet_action(unsigned
 
 	tty = state->info->tty;
 	if (tty) {
-		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-		    tty->ldisc.write_wakeup)
-			tty->ldisc.write_wakeup(tty);
+		struct tty_ldisc *ldisc = tty_ldisc_ref(tty);
+		if(ldisc) {
+			if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+			    ldisc->write_wakeup)
+				ldisc->write_wakeup(tty);
+			tty_ldisc_deref(ldisc);
+		}
 		wake_up_interruptible(&tty->write_wait);
 	}
 }
@@ -575,6 +579,7 @@ static void uart_flush_buffer(struct tty
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port = state->port;
 	unsigned long flags;
+	struct tty_ldisc *ldisc;
 
 	DPRINTK("uart_flush_buffer(%d) called\n", tty->index);
 
@@ -582,9 +587,13 @@ static void uart_flush_buffer(struct tty
 	uart_circ_clear(&state->info->xmit);
 	spin_unlock_irqrestore(&port->lock, flags);
 	wake_up_interruptible(&tty->write_wait);
-	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-	    tty->ldisc.write_wakeup)
-		(tty->ldisc.write_wakeup)(tty);
+	ldisc = tty_ldisc_ref(tty);
+	if(ldisc) {
+		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+		    ldisc->write_wakeup)
+			(ldisc->write_wakeup)(tty);
+		tty_ldisc_deref(ldisc);
+	}
 }
 
 /*
@@ -1216,7 +1225,8 @@ static void uart_close(struct tty_struct
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port;
-
+	struct tty_ldisc *ldisc;
+	
 	BUG_ON(!kernel_locked());
 
 	if (!state || !state->port)
@@ -1280,8 +1290,15 @@ static void uart_close(struct tty_struct
 
 	uart_shutdown(state);
 	uart_flush_buffer(tty);
-	if (tty->ldisc.flush_buffer)
-		tty->ldisc.flush_buffer(tty);
+	
+	ldisc = tty_ldisc_ref(tty);
+	if (ldisc)
+	{
+		if(ldisc->flush_buffer)
+			ldisc->flush_buffer(tty);
+		tty_ldisc_deref(ldisc);
+	}
+	
 	tty->closing = 0;
 	state->info->tty = NULL;
 
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/fs/proc/proc_tty.c linux-2.6.9rc2/fs/proc/proc_tty.c
--- linux.vanilla-2.6.9rc2/fs/proc/proc_tty.c	2004-09-14 14:21:23.169542600 +0100
+++ linux-2.6.9rc2/fs/proc/proc_tty.c	2004-09-14 14:32:09.178334336 +0100
@@ -15,9 +15,6 @@
 #include <linux/seq_file.h>
 #include <asm/bitops.h>
 
-extern struct tty_ldisc ldiscs[];
-
-
 static int tty_ldiscs_read_proc(char *page, char **start, off_t off,
 				int count, int *eof, void *data);
 
@@ -159,12 +156,15 @@ static int tty_ldiscs_read_proc(char *pa
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
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/include/linux/tty.h linux-2.6.9rc2/include/linux/tty.h
--- linux.vanilla-2.6.9rc2/include/linux/tty.h	2004-09-14 14:19:40.205195560 +0100
+++ linux-2.6.9rc2/include/linux/tty.h	2004-09-14 14:32:19.706733776 +0100
@@ -306,19 +306,20 @@ struct tty_struct {
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
 
@@ -362,6 +363,13 @@ extern void tty_flip_buffer_push(struct 
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
 
diff -u -p --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/include/linux/tty_ldisc.h linux-2.6.9rc2/include/linux/tty_ldisc.h
--- linux.vanilla-2.6.9rc2/include/linux/tty_ldisc.h	2004-09-14 14:19:40.331176408 +0100
+++ linux-2.6.9rc2/include/linux/tty_ldisc.h	2004-09-14 14:32:26.328727080 +0100
@@ -132,6 +132,8 @@ struct tty_ldisc {
 	void	(*write_wakeup)(struct tty_struct *);
 
 	struct  module *owner;
+	
+	int refcount;
 };
 
 #define TTY_LDISC_MAGIC	0x5403

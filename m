Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267454AbUIWWFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267454AbUIWWFK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbUIWWDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:03:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36068 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267450AbUIWV41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:56:27 -0400
Date: Thu, 23 Sep 2004 17:56:07 -0400
From: Alan Cox <alan@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: PATCH: tty driver take 4 try 2
Message-ID: <20040923215607.GA22804@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok this should fix the bug

"We apologise for the inconvenience"


diff -u --new-file --recursive --exclude-from /usr/src/exclude tty.old/Documentation/tty.txt linux-2.6.9rc2/Documentation/tty.txt
--- tty.old/Documentation/tty.txt	2004-09-23 19:16:26.131074592 +0100
+++ linux-2.6.9rc2/Documentation/tty.txt	2004-09-21 14:05:02.000000000 +0100
@@ -58,8 +58,10 @@
 
 chars_in_buffer() -	Report the number of bytes in the buffer.
 
-set_termios()	-	Called on termios structure changes. Semantics 
-			deeply mysterious right now.
+set_termios()	-	Called on termios structure changes. The caller
+			passes the old termios data and the current data
+			is in the tty. Currently can be parallel entered
+			and ordering isn't predictable - FIXME
 
 read()		-	Move data from the line discipline to the user.
 			Multiple read calls may occur in parallel and the
diff -u --new-file --recursive --exclude-from /usr/src/exclude tty.old/drivers/char/n_tty.c linux-2.6.9rc2/drivers/char/n_tty.c
--- tty.old/drivers/char/n_tty.c	2004-09-23 18:43:04.852315208 +0100
+++ linux-2.6.9rc2/drivers/char/n_tty.c	2004-09-23 10:35:50.292643816 +0100
@@ -99,11 +99,18 @@
 	spin_unlock_irqrestore(&tty->read_lock, flags);
 }
 
-/* 
- * Check whether to call the driver.unthrottle function.
- * We test the TTY_THROTTLED bit first so that it always
- * indicates the current state.
+/**
+ *	check_unthrottle	-	allow new receive data
+ *	@tty; tty device
+ *
+ *	Check whether to call the driver.unthrottle function.
+ *	We test the TTY_THROTTLED bit first so that it always
+ *	indicates the current state. The decision about whether
+ *	it is worth allowing more input has been taken by the caller.
+ *	Can sleep, may be called under the atomic_read semaphore but
+ *	this is not guaranteed.
  */
+ 
 static void check_unthrottle(struct tty_struct * tty)
 {
 	if (tty->count &&
@@ -112,10 +119,13 @@
 		tty->driver->unthrottle(tty);
 }
 
-/*
- * Reset the read buffer counters, clear the flags, 
- * and make sure the driver is unthrottled. Called
- * from n_tty_open() and n_tty_flush_buffer().
+/**
+ *	reset_buffer_flags	-	reset buffer state
+ *	@tty: terminal to reset
+ *
+ *	Reset the read buffer counters, clear the flags, 
+ *	and make sure the driver is unthrottled. Called
+ *	from n_tty_open() and n_tty_flush_buffer().
  */
 static void reset_buffer_flags(struct tty_struct *tty)
 {
@@ -129,9 +139,19 @@
 	check_unthrottle(tty);
 }
 
-/*
- * Flush the input buffer
+/**
+ *	n_tty_flush_buffer	-	clean input queue
+ *	@tty:	terminal device
+ *
+ *	Flush the input buffer. Called when the line discipline is
+ *	being closed, when the tty layer wants the buffer flushed (eg
+ *	at hangup) or when the N_TTY line discipline internally has to
+ *	clean the pending queue (for example some signals).
+ *
+ *	FIXME: tty->ctrl_status is not spinlocked and relies on
+ *	lock_kernel() still.
  */
+ 
 void n_tty_flush_buffer(struct tty_struct * tty)
 {
 	/* clear everything and unthrottle the driver */
@@ -146,9 +166,14 @@
 	}
 }
 
-/*
- * Return number of characters buffered to be delivered to user
+/**
+ *	n_tty_chars_in_buffer	-	report available bytes
+ *	@tty: tty device
+ *
+ *	Report the number of characters buffered to be delivered to user
+ *	at this instant in time. 
  */
+ 
 ssize_t n_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	unsigned long flags;
@@ -166,20 +191,47 @@
 	return n;
 }
 
+/**
+ *	is_utf8_continuation	-	utf8 multibyte check
+ *	@c: byte to check
+ *
+ *	Returns true if the utf8 character 'c' is a multibyte continuation
+ *	character. We use this to correctly compute the on screen size
+ *	of the character when printing
+ */
+ 
 static inline int is_utf8_continuation(unsigned char c)
 {
 	return (c & 0xc0) == 0x80;
 }
 
+/**
+ *	is_continuation		-	multibyte check
+ *	@c: byte to check
+ *
+ *	Returns true if the utf8 character 'c' is a multibyte continuation
+ *	character and the terminal is in unicode mode.
+ */
+ 
 static inline int is_continuation(unsigned char c, struct tty_struct *tty)
 {
 	return I_IUTF8(tty) && is_utf8_continuation(c);
 }
 
-/*
- * Perform OPOST processing.  Returns -1 when the output device is
- * full and the character must be retried.
+/**
+ *	opost			-	output post processor
+ *	@c: character (or partial unicode symbol)
+ *	@tty: terminal device
+ *
+ *	Perform OPOST processing.  Returns -1 when the output device is
+ *	full and the character must be retried. Note that Linux currently
+ *	ignores TABDLY, CRDLY, VTDLY, FFDLY and NLDLY. They simply aren't
+ *	relevant in the world today. If you ever need them, add them here.
+ *
+ *	Called from both the receive and transmit sides and can be called
+ *	re-entrantly. Relies on lock_kernel() still.
  */
+ 
 static int opost(unsigned char c, struct tty_struct *tty)
 {
 	int	space, spaces;
@@ -239,10 +291,20 @@
 	return 0;
 }
 
-/*
- * opost_block --- to speed up block console writes, among other
- * things.
+/**
+ *	opost_block		-	block postprocess
+ *	@tty: terminal device
+ *	@inbuf: user buffer
+ *	@nr: number of bytes
+ *
+ *	This path is used to speed up block console writes, among other
+ *	things when processing blocks of output data. It handles only
+ *	the simple cases normally found and helps to generate blocks of
+ *	symbols for the console driver and thus improve performance.
+ *
+ *	Called from write_chan under the tty layer write lock.
  */
+ 
 static ssize_t opost_block(struct tty_struct * tty,
 		       const unsigned char __user * inbuf, unsigned int nr)
 {
@@ -304,13 +366,27 @@
 }
 
 
-
+/**
+ *	put_char	-	write character to driver
+ *	@c: character (or part of unicode symbol)
+ *	@tty: terminal device
+ *
+ *	Queue a byte to the driver layer for output
+ */
+ 
 static inline void put_char(unsigned char c, struct tty_struct *tty)
 {
 	tty->driver->put_char(tty, c);
 }
 
-/* Must be called only when L_ECHO(tty) is true. */
+/**
+ *	echo_char	-	echo characters
+ *	@c: unicode byte to echo
+ *	@tty: terminal device
+ *
+ *	Echo user input back onto the screen. This must be called only when 
+ *	L_ECHO(tty) is true. Called from the driver receive_buf path.
+ */
 
 static void echo_char(unsigned char c, struct tty_struct *tty)
 {
@@ -331,6 +407,16 @@
 	}
 }
 
+/**
+ *	eraser		-	handle erase function
+ *	@c: character input
+ *	@tty: terminal device
+ *
+ *	Perform erase and neccessary output when an erase character is
+ *	present in the stream from the driver layer. Handles the complexities
+ *	of UTF-8 multibyte symbols.
+ */
+ 
 static void eraser(unsigned char c, struct tty_struct *tty)
 {
 	enum { ERASE, WERASE, KILL } kill_type;
@@ -463,6 +549,18 @@
 		finish_erasing(tty);
 }
 
+/**
+ *	isig		-	handle the ISIG optio
+ *	@sig: signal
+ *	@tty: terminal
+ *	@flush: force flush
+ *
+ *	Called when a signal is being sent due to terminal input. This
+ *	may caus terminal flushing to take place according to the termios
+ *	settings and character used. Called from the driver receive_buf
+ *	path so serialized.
+ */
+ 
 static inline void isig(int sig, struct tty_struct *tty, int flush)
 {
 	if (tty->pgrp > 0)
@@ -474,6 +572,16 @@
 	}
 }
 
+/**
+ *	n_tty_receive_break	-	handle break
+ *	@tty: terminal
+ *
+ *	An RS232 break event has been hit in the incoming bitstream. This
+ *	can cause a variety of events depending upon the termios settings.
+ *
+ *	Called from the receive_buf path so single threaded.
+ */
+ 
 static inline void n_tty_receive_break(struct tty_struct *tty)
 {
 	if (I_IGNBRK(tty))
@@ -490,19 +598,40 @@
 	wake_up_interruptible(&tty->read_wait);
 }
 
+/**
+ *	n_tty_receive_overrun	-	handle overrun reporting
+ *	@tty: terminal
+ *
+ *	Data arrived faster than we could process it. While the tty
+ *	driver has flagged this the bits that were missed are gone
+ *	forever.
+ *
+ *	Called from the receive_buf path so single threaded. Does not
+ *	need locking as num_overrun and overrun_time are function
+ *	private.
+ */
+ 
 static inline void n_tty_receive_overrun(struct tty_struct *tty)
 {
 	char buf[64];
 
 	tty->num_overrun++;
 	if (time_before(tty->overrun_time, jiffies - HZ)) {
-		printk("%s: %d input overrun(s)\n", tty_name(tty, buf),
+		printk(KERN_WARNING "%s: %d input overrun(s)\n", tty_name(tty, buf),
 		       tty->num_overrun);
 		tty->overrun_time = jiffies;
 		tty->num_overrun = 0;
 	}
 }
 
+/**
+ *	n_tty_receive_parity_error	-	error notifier
+ *	@tty: terminal device
+ *	@c: character
+ *
+ *	Process a parity error and queue the right data to indicate
+ *	the error case if neccessary. Locking as per n_tty_receive_buf.
+ */
 static inline void n_tty_receive_parity_error(struct tty_struct *tty,
 					      unsigned char c)
 {
@@ -520,6 +649,16 @@
 	wake_up_interruptible(&tty->read_wait);
 }
 
+/**
+ *	n_tty_receive_char	-	perform processing
+ *	@tty: terminal device
+ *	@c: character
+ *
+ *	Process an individual character of input received from the driver.
+ *	This is serialized with respect to itself by the rules for the 
+ *	driver above.
+ */
+
 static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 {
 	unsigned long flags;
@@ -711,6 +850,16 @@
 	put_tty_queue(c, tty);
 }	
 
+/**
+ *	n_tty_receive_room	-	receive space
+ *	@tty: terminal
+ *
+ *	Called by the driver to find out how much data it is
+ *	permitted to feed to the line discipline without any being lost
+ *	and thus to manage flow control. Not serialized. Answers for the
+ *	"instant".
+ */
+ 
 static int n_tty_receive_room(struct tty_struct *tty)
 {
 	int	left = N_TTY_BUF_SIZE - tty->read_cnt - 1;
@@ -729,10 +878,13 @@
 	return 0;
 }
 
-/*
- * Required for the ptys, serial driver etc. since processes
- * that attach themselves to the master and rely on ASYNC
- * IO must be woken up
+/**
+ *	n_tty_write_wakeup	-	asynchronous I/O notifier
+ *	@tty: tty device
+ *
+ *	Required for the ptys, serial driver etc. since processes
+ *	that attach themselves to the master and rely on ASYNC
+ *	IO must be woken up
  */
 
 static void n_tty_write_wakeup(struct tty_struct *tty)
@@ -745,6 +897,19 @@
 	return;
 }
 
+/**
+ *	n_tty_receive_buf	-	data receive
+ *	@tty: terminal device
+ *	@cp: buffer
+ *	@fp: flag buffer
+ *	@count: characters
+ *
+ *	Called by the terminal driver when a block of characters has
+ *	been received. This function must be called from soft contexts
+ *	not from interrupt context. The driver is responsible for making
+ *	calls one at a time and in order (or using flush_to_ldisc)
+ */
+ 
 static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			      char *fp, int count)
 {
@@ -828,6 +993,18 @@
 	        current->sighand->action[sig-1].sa.sa_handler == SIG_IGN);
 }
 
+/**
+ *	n_tty_set_termios	-	termios data changed
+ *	@tty: terminal
+ *	@old: previous data
+ *
+ *	Called by the tty layer when the user changes termios flags so
+ *	that the line discipline can plan ahead. This function cannot sleep
+ *	and is protected from re-entry by the tty layer. The user is 
+ *	guaranteed that this function will not be re-entered or in progress
+ *	when the ldisc is closed.
+ */
+ 
 static void n_tty_set_termios(struct tty_struct *tty, struct termios * old)
 {
 	if (!tty)
@@ -843,7 +1020,6 @@
 	    I_ICRNL(tty) || I_INLCR(tty) || L_ICANON(tty) ||
 	    I_IXON(tty) || L_ISIG(tty) || L_ECHO(tty) ||
 	    I_PARMRK(tty)) {
-		local_irq_disable(); // FIXME: is this safe?
 		memset(tty->process_char_map, 0, 256/8);
 
 		if (I_IGNCR(tty) || I_ICRNL(tty))
@@ -879,7 +1055,6 @@
 			set_bit(SUSP_CHAR(tty), tty->process_char_map);
 		}
 		clear_bit(__DISABLED_CHAR, tty->process_char_map);
-		local_irq_enable(); // FIXME: is this safe?
 		tty->raw = 0;
 		tty->real_raw = 0;
 	} else {
@@ -893,6 +1068,16 @@
 	}
 }
 
+/**
+ *	n_tty_close		-	close the ldisc for this tty
+ *	@tty: device
+ *
+ *	Called from the terminal layer when this line discipline is 
+ *	being shut down, either because of a close or becsuse of a 
+ *	discipline change. The function will not be called while other
+ *	ldisc methods are in progress.
+ */
+ 
 static void n_tty_close(struct tty_struct *tty)
 {
 	n_tty_flush_buffer(tty);
@@ -902,11 +1087,22 @@
 	}
 }
 
+/**
+ *	n_tty_open		-	open an ldisc
+ *	@tty: terminal to open
+ *
+ *	Called when this line discipline is being attached to the 
+ *	terminal device. Can sleep. Called serialized so that no
+ *	other events will occur in parallel. No further open will occur
+ *	until a close.
+ */
+
 static int n_tty_open(struct tty_struct *tty)
 {
 	if (!tty)
 		return -EINVAL;
 
+	/* This one is ugly. Currently a malloc failure here can panic */
 	if (!tty->read_buf) {
 		tty->read_buf = alloc_buf();
 		if (!tty->read_buf)
@@ -932,14 +1128,23 @@
 	return 0;
 }
 
-/*
- * Helper function to speed up read_chan.  It is only called when
- * ICANON is off; it copies characters straight from the tty queue to
- * user space directly.  It can be profitably called twice; once to
- * drain the space from the tail pointer to the (physical) end of the
- * buffer, and once to drain the space from the (physical) beginning of
- * the buffer to head pointer.
+/**
+ * 	copy_from_read_buf	-	copy read data directly
+ *	@tty: terminal device
+ *	@b: user data
+ *	@nr: size of data
+ *
+ *	Helper function to speed up read_chan.  It is only called when
+ *	ICANON is off; it copies characters straight from the tty queue to
+ *	user space directly.  It can be profitably called twice; once to
+ *	drain the space from the tail pointer to the (physical) end of the
+ *	buffer, and once to drain the space from the (physical) beginning of
+ *	the buffer to head pointer.
+ *
+ *	Called under the tty->atomic_read sem and with TTY_DONT_FLIP set
+ *
  */
+ 
 static inline int copy_from_read_buf(struct tty_struct *tty,
 				      unsigned char __user **b,
 				      size_t *nr)
@@ -970,25 +1175,18 @@
 
 extern ssize_t redirected_tty_write(struct file *,const char *,size_t,loff_t *);
 
-static ssize_t read_chan(struct tty_struct *tty, struct file *file,
-			 unsigned char __user *buf, size_t nr)
+/**
+ *	job_control		-	check job control
+ *	@tty: tty
+ *	@file: file handle
+ *
+ *	Perform job control management checks on this file/tty descriptor
+ *	and if appropriate send any needed signals and return a negative 
+ *	error code if action should be taken.
+ */
+ 
+static int job_control(struct tty_struct *tty, struct file *file)
 {
-	unsigned char __user *b = buf;
-	DECLARE_WAITQUEUE(wait, current);
-	int c;
-	int minimum, time;
-	ssize_t retval = 0;
-	ssize_t size;
-	long timeout;
-	unsigned long flags;
-
-do_it_again:
-
-	if (!tty->read_buf) {
-		printk("n_tty_read_chan: called with read_buf == NULL?!?\n");
-		return -EIO;
-	}
-
 	/* Job control check -- must be done at start and after
 	   every sleep (POSIX.1 7.1.1.4). */
 	/* NOTE: not yet done after every sleep pending a thorough
@@ -1006,7 +1204,48 @@
 			return -ERESTARTSYS;
 		}
 	}
+	return 0;
+}
+ 
+
+/**
+ *	read_chan		-	read function for tty
+ *	@tty: tty device
+ *	@file: file object
+ *	@buf: userspace buffer pointer
+ *	@nr: size of I/O
+ *
+ *	Perform reads for the line discipline. We are guaranteed that the
+ *	line discipline will not be closed under us but we may get multiple
+ *	parallel readers and must handle this ourselves. We may also get
+ *	a hangup. Always called in user context, may sleep.
+ *
+ *	This code must be sure never to sleep through a hangup.
+ */
+ 
+static ssize_t read_chan(struct tty_struct *tty, struct file *file,
+			 unsigned char __user *buf, size_t nr)
+{
+	unsigned char __user *b = buf;
+	DECLARE_WAITQUEUE(wait, current);
+	int c;
+	int minimum, time;
+	ssize_t retval = 0;
+	ssize_t size;
+	long timeout;
+	unsigned long flags;
+
+do_it_again:
+
+	if (!tty->read_buf) {
+		printk("n_tty_read_chan: called with read_buf == NULL?!?\n");
+		return -EIO;
+	}
 
+	c = job_control(tty, file);
+	if(c < 0)
+		return c;
+	
 	minimum = time = 0;
 	timeout = MAX_SCHEDULE_TIMEOUT;
 	if (!tty->icanon) {
@@ -1028,6 +1267,9 @@
 		}
 	}
 
+	/*
+	 *	Internal serialization of reads.
+	 */
 	if (file->f_flags & O_NONBLOCK) {
 		if (down_trylock(&tty->atomic_read))
 			return -EAGAIN;
@@ -1177,6 +1419,21 @@
 	return retval;
 }
 
+/**
+ *	write_chan		-	write function for tty
+ *	@tty: tty device
+ *	@file: file object
+ *	@buf: userspace buffer pointer
+ *	@nr: size of I/O
+ *
+ *	Write function of the terminal device. This is serialized with
+ *	respect to other write callers but not to termios changes, reads
+ *	and other such events. We must be careful with N_TTY as the receive
+ *	code will echo characters, thus calling driver write methods.
+ *
+ *	This code must be sure never to sleep through a hangup.
+ */
+ 
 static ssize_t write_chan(struct tty_struct * tty, struct file * file,
 			  const unsigned char __user * buf, size_t nr)
 {
@@ -1246,7 +1503,25 @@
 	return (b - buf) ? b - buf : retval;
 }
 
-/* Called without the kernel lock held - fine */
+/**
+ *	normal_poll		-	poll method for N_TTY
+ *	@tty: terminal device
+ *	@file: file accessing it
+ *	@wait: poll table
+ *
+ *	Called when the line discipline is asked to poll() for data or
+ *	for special events. This code is not serialized with respect to
+ *	other events save open/close.
+ *
+ *	This code must be sure never to sleep through a hangup.
+ *	Called without the kernel lock held - fine
+ *
+ *	FIXME: if someone changes the VMIN or discipline settings for the
+ *	terminal while another process is in poll() the poll does not
+ *	recompute the new limits. Possibly set_termios should issue
+ *	a read wakeup to fix this bug.
+ */
+ 
 static unsigned int normal_poll(struct tty_struct * tty, struct file * file, poll_table *wait)
 {
 	unsigned int mask = 0;
@@ -1287,6 +1562,7 @@
 	n_tty_ioctl,		/* ioctl */
 	n_tty_set_termios,	/* set_termios */
 	normal_poll,		/* poll */
+	NULL,			/* hangup */
 	n_tty_receive_buf,	/* receive_buf */
 	n_tty_receive_room,	/* receive_room */
 	n_tty_write_wakeup	/* write_wakeup */
diff -u --new-file --recursive --exclude-from /usr/src/exclude tty.old/drivers/char/pcmcia/synclink_cs.c linux-2.6.9rc2/drivers/char/pcmcia/synclink_cs.c
--- tty.old/drivers/char/pcmcia/synclink_cs.c	2004-09-23 19:16:12.718113672 +0100
+++ linux-2.6.9rc2/drivers/char/pcmcia/synclink_cs.c	2004-09-17 18:03:37.000000000 +0100
@@ -516,6 +516,40 @@
 	return mgslpc_get_text_ptr;
 }
 
+/**
+ * line discipline callback wrappers
+ *
+ * The wrappers maintain line discipline references
+ * while calling into the line discipline.
+ *
+ * ldisc_flush_buffer - flush line discipline receive buffers
+ * ldisc_receive_buf  - pass receive data to line discipline
+ */
+
+static void ldisc_flush_buffer(struct tty_struct *tty)
+{
+	struct tty_ldisc *ld = tty_ldisc_ref(tty);
+	if (ld) {
+		if (ld->flush_buffer)
+			ld->flush_buffer(tty);
+		tty_ldisc_deref(ld);
+	}
+}
+
+static void ldisc_receive_buf(struct tty_struct *tty,
+			      const __u8 *data, char *flags, int count)
+{
+	struct tty_ldisc *ld;
+	if (!tty)
+		return;
+	ld = tty_ldisc_ref(tty);
+	if (ld) {
+		if (ld->receive_buf)
+			ld->receive_buf(tty, data, flags, count);
+		tty_ldisc_deref(ld);
+	}
+}
+
 static dev_link_t *mgslpc_attach(void)
 {
     MGSLPC_INFO *info;
@@ -969,13 +1003,7 @@
 		printk("bh_transmit() entry on %s\n", info->device_name);
 
 	if (tty) {
-		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-		    tty->ldisc.write_wakeup) {
-			if ( debug_level >= DEBUG_LEVEL_BH )
-				printk( "%s(%d):calling ldisc.write_wakeup on %s\n",
-					__FILE__,__LINE__,info->device_name);
-			(tty->ldisc.write_wakeup)(tty);
-		}
+		tty_wakeup(tty);
 		wake_up_interruptible(&tty->write_wait);
 	}
 }
@@ -1860,11 +1888,9 @@
 	info->tx_count = info->tx_put = info->tx_get = 0;
 	del_timer(&info->tx_timer);	
 	spin_unlock_irqrestore(&info->lock,flags);
-	
+
 	wake_up_interruptible(&tty->write_wait);
-	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-	    tty->ldisc.write_wakeup)
-		(tty->ldisc.write_wakeup)(tty);
+	tty_wakeup(tty);
 }
 
 /* Send a high-priority XON/XOFF character
@@ -2573,9 +2599,8 @@
 
 	if (tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
-		
-	if (tty->ldisc.flush_buffer)
-		tty->ldisc.flush_buffer(tty);
+
+	ldisc_flush_buffer(tty);
 		
 	shutdown(info);
 	
@@ -4040,11 +4065,7 @@
 				hdlcdev_rx(info, buf->data, framesize);
 			else
 #endif
-			{
-				/* Call the line discipline receive callback directly. */
-				if (tty && tty->ldisc.receive_buf)
-					tty->ldisc.receive_buf(tty, buf->data, info->flag_buf, framesize);
-			}
+				ldisc_receive_buf(tty, buf->data, info->flag_buf, framesize);
 		}
 	}
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude tty.old/drivers/char/synclink.c linux-2.6.9rc2/drivers/char/synclink.c
--- tty.old/drivers/char/synclink.c	2004-09-23 19:16:12.736110936 +0100
+++ linux-2.6.9rc2/drivers/char/synclink.c	2004-09-17 18:03:37.000000000 +0100
@@ -975,6 +975,40 @@
 	return 0;
 }
 
+/**
+ * line discipline callback wrappers
+ *
+ * The wrappers maintain line discipline references
+ * while calling into the line discipline.
+ *
+ * ldisc_flush_buffer - flush line discipline receive buffers
+ * ldisc_receive_buf  - pass receive data to line discipline
+ */
+
+static void ldisc_flush_buffer(struct tty_struct *tty)
+{
+	struct tty_ldisc *ld = tty_ldisc_ref(tty);
+	if (ld) {
+		if (ld->flush_buffer)
+			ld->flush_buffer(tty);
+		tty_ldisc_deref(ld);
+	}
+}
+
+static void ldisc_receive_buf(struct tty_struct *tty,
+			      const __u8 *data, char *flags, int count)
+{
+	struct tty_ldisc *ld;
+	if (!tty)
+		return;
+	ld = tty_ldisc_ref(tty);
+	if (ld) {
+		if (ld->receive_buf)
+			ld->receive_buf(tty, data, flags, count);
+		tty_ldisc_deref(ld);
+	}
+}
+
 /* mgsl_stop()		throttle (stop) transmitter
  * 	
  * Arguments:		tty	pointer to tty info structure
@@ -1135,13 +1169,7 @@
 			__FILE__,__LINE__,info->device_name);
 
 	if (tty) {
-		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-		    tty->ldisc.write_wakeup) {
-			if ( debug_level >= DEBUG_LEVEL_BH )
-				printk( "%s(%d):calling ldisc.write_wakeup on %s\n",
-					__FILE__,__LINE__,info->device_name);
-			(tty->ldisc.write_wakeup)(tty);
-		}
+		tty_wakeup(tty);
 		wake_up_interruptible(&tty->write_wait);
 	}
 
@@ -2397,11 +2425,8 @@
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 	
 	wake_up_interruptible(&tty->write_wait);
-	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-	    tty->ldisc.write_wakeup)
-		(tty->ldisc.write_wakeup)(tty);
-		
-}	/* end of mgsl_flush_buffer() */
+	tty_wakeup(tty);
+}
 
 /* mgsl_send_xchar()
  *
@@ -3235,9 +3260,8 @@
 
 	if (tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
-		
-	if (tty->ldisc.flush_buffer)
-		tty->ldisc.flush_buffer(tty);
+
+	ldisc_flush_buffer(tty);
 		
 	shutdown(info);
 	
@@ -6810,11 +6834,7 @@
 				hdlcdev_rx(info,info->intermediate_rxbuffer,framesize);
 			else
 #endif
-			{
-				/* Call the line discipline receive callback directly. */
-				if ( tty && tty->ldisc.receive_buf )
-				tty->ldisc.receive_buf(tty, info->intermediate_rxbuffer, info->flag_buf, framesize);
-			}
+				ldisc_receive_buf(tty, info->intermediate_rxbuffer, info->flag_buf, framesize);
 		}
 	}
 	/* Free the buffers used by this frame. */
@@ -6986,9 +7006,7 @@
 			memcpy( info->intermediate_rxbuffer, pBufEntry->virt_addr, framesize);
 			info->icount.rxok++;
 
-			/* Call the line discipline receive callback directly. */
-			if ( tty && tty->ldisc.receive_buf )
-				tty->ldisc.receive_buf(tty, info->intermediate_rxbuffer, info->flag_buf, framesize);
+			ldisc_receive_buf(tty, info->intermediate_rxbuffer, info->flag_buf, framesize);
 		}
 
 		/* Free the buffers used by this frame. */
diff -u --new-file --recursive --exclude-from /usr/src/exclude tty.old/drivers/char/synclinkmp.c linux-2.6.9rc2/drivers/char/synclinkmp.c
--- tty.old/drivers/char/synclinkmp.c	2004-09-23 19:16:12.740110328 +0100
+++ linux-2.6.9rc2/drivers/char/synclinkmp.c	2004-09-17 18:03:37.000000000 +0100
@@ -699,6 +699,40 @@
 	return 0;
 }
 
+/**
+ * line discipline callback wrappers
+ *
+ * The wrappers maintain line discipline references
+ * while calling into the line discipline.
+ *
+ * ldisc_flush_buffer - flush line discipline receive buffers
+ * ldisc_receive_buf  - pass receive data to line discipline
+ */
+
+static void ldisc_flush_buffer(struct tty_struct *tty)
+{
+	struct tty_ldisc *ld = tty_ldisc_ref(tty);
+	if (ld) {
+		if (ld->flush_buffer)
+			ld->flush_buffer(tty);
+		tty_ldisc_deref(ld);
+	}
+}
+
+static void ldisc_receive_buf(struct tty_struct *tty,
+			      const __u8 *data, char *flags, int count)
+{
+	struct tty_ldisc *ld;
+	if (!tty)
+		return;
+	ld = tty_ldisc_ref(tty);
+	if (ld) {
+		if (ld->receive_buf)
+			ld->receive_buf(tty, data, flags, count);
+		tty_ldisc_deref(ld);
+	}
+}
+
 /* tty callbacks */
 
 /* Called when a port is opened.  Init and enable port.
@@ -846,8 +880,7 @@
 	if (tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
 
-	if (tty->ldisc.flush_buffer)
-		tty->ldisc.flush_buffer(tty);
+	ldisc_flush_buffer(tty);
 
 	shutdown(info);
 
@@ -1252,9 +1285,7 @@
 	spin_unlock_irqrestore(&info->lock,flags);
 
 	wake_up_interruptible(&tty->write_wait);
-	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-	    tty->ldisc.write_wakeup)
-		(tty->ldisc.write_wakeup)(tty);
+	tty_wakeup(tty);
 }
 
 /* throttle (stop) transmitter
@@ -2123,13 +2154,7 @@
 			__FILE__,__LINE__,info->device_name);
 
 	if (tty) {
-		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-		    tty->ldisc.write_wakeup) {
-			if ( debug_level >= DEBUG_LEVEL_BH )
-				printk( "%s(%d):%s calling ldisc.write_wakeup\n",
-					__FILE__,__LINE__,info->device_name);
-			(tty->ldisc.write_wakeup)(tty);
-		}
+		tty_wakeup(tty);
 		wake_up_interruptible(&tty->write_wait);
 	}
 }
@@ -5051,15 +5076,8 @@
 				hdlcdev_rx(info,info->tmp_rx_buf,framesize);
 			else
 #endif
-			{
-				if ( tty && tty->ldisc.receive_buf ) {
-					/* Call the line discipline receive callback directly. */
-					tty->ldisc.receive_buf(tty,
-						info->tmp_rx_buf,
-						info->flag_buf,
-						framesize);
-				}
-			}
+				ldisc_receive_buf(tty,info->tmp_rx_buf,
+						  info->flag_buf, framesize);
 		}
 	}
 	/* Free the buffers used by this frame. */
diff -u --new-file --recursive --exclude-from /usr/src/exclude tty.old/drivers/char/tty_io.c linux-2.6.9rc2/drivers/char/tty_io.c
--- tty.old/drivers/char/tty_io.c	2004-09-23 19:16:26.150071704 +0100
+++ linux-2.6.9rc2/drivers/char/tty_io.c	2004-09-23 22:27:29.269412680 +0100
@@ -130,6 +130,8 @@
 /* Semaphore to protect creating and releasing a tty. This is shared with
    vt.c for deeply disgusting hack reasons */
 DECLARE_MUTEX(tty_sem);
+/* Lock for tty_termios changes - private to tty_io/tty_ioctl */
+spinlock_t tty_termios_lock = SPIN_LOCK_UNLOCKED;
 
 #ifdef CONFIG_UNIX98_PTYS
 extern struct tty_driver *ptm_driver;	/* Unix98 pty masters; for /dev/ptmx */
@@ -230,6 +232,20 @@
 }
 
 /*
+ *	This is probably overkill for real world processors but
+ *	they are not on hot paths so a little discipline won't do 
+ *	any harm.
+ */
+ 
+static void tty_set_termios_ldisc(struct tty_struct *tty, int num)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&tty_termios_lock, flags);
+	tty->termios->c_line = num;
+	spin_unlock_irqrestore(&tty_termios_lock, flags);
+}
+
+/*
  *	This guards the refcounted line discipline lists. The lock
  *	must be taken with irqs off because there are hangup path
  *	callers who will do ldisc lookups and cannot sleep.
@@ -365,7 +381,7 @@
 	/* wait_event is a macro */
 	wait_event(tty_ldisc_wait, tty_ldisc_try(tty));
 	if(tty->ldisc.refcount == 0)
-		printk("Ref wait -> 0 ref\n");
+		printk(KERN_ERR "tty_ldisc_ref_wait\n");
 	return &tty->ldisc;
 }
 
@@ -406,7 +422,7 @@
 		
 	spin_lock_irqsave(&tty_ldisc_lock, flags);
 	if(ld->refcount == 0)
-		printk(KERN_EMERG "tty_ldisc_deref: no references.\n");
+		printk(KERN_ERR "tty_ldisc_deref: no references.\n");
 	else
 		ld->refcount--;
 	if(ld->refcount == 0)
@@ -503,19 +519,19 @@
 
 	/* Now set up the new line discipline. */
 	tty_ldisc_assign(tty, ld);
-	tty->termios->c_line = ldisc;
+	tty_set_termios_ldisc(tty, ldisc);
 	if (tty->ldisc.open)
 		retval = (tty->ldisc.open)(tty);
 	if (retval < 0) {
 		tty_ldisc_put(ldisc);
 		/* There is an outstanding reference here so this is safe */
 		tty_ldisc_assign(tty, tty_ldisc_get(o_ldisc.num));
-		tty->termios->c_line = tty->ldisc.num;
+		tty_set_termios_ldisc(tty, tty->ldisc.num);
 		if (tty->ldisc.open && (tty->ldisc.open(tty) < 0)) {
 			tty_ldisc_put(o_ldisc.num);
 			/* This driver is always present */
 			tty_ldisc_assign(tty, tty_ldisc_get(N_TTY));
-			tty->termios->c_line = N_TTY;
+			tty_set_termios_ldisc(tty, N_TTY);
 			if (tty->ldisc.open) {
 				int r = tty->ldisc.open(tty);
 
@@ -711,6 +727,7 @@
 	
 	check_tty_count(tty, "do_tty_hangup");
 	file_list_lock();
+	/* This breaks for file handles being sent over AF_UNIX sockets ? */
 	list_for_each_entry(filp, &tty->tty_files, f_list) {
 		if (filp->f_op->write == redirected_tty_write)
 			cons_filp = filp;
@@ -723,7 +740,7 @@
 	file_list_unlock();
 	
 	/* FIXME! What are the locking issues here? This may me overdoing things..
-	* this question is especially important now that we've removed the irqlock. */
+	 * this question is especially important now that we've removed the irqlock. */
 
 	ld = tty_ldisc_ref(tty);
 	if(ld != NULL)	/* We may have no line discipline at this point */
@@ -735,8 +752,13 @@
 		if ((test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags)) &&
 		    ld->write_wakeup)
 			ld->write_wakeup(tty);
+		if (ld->hangup)
+			ld->hangup(tty);
 	}
 
+	/* FIXME: Once we trust the LDISC code better we can wait here for
+	   ldisc completion and fix the driver call race */
+	   
 	wake_up_interruptible(&tty->write_wait);
 	wake_up_interruptible(&tty->read_wait);
 
@@ -745,8 +767,13 @@
 	 * N_TTY.
 	 */
 	if (tty->driver->flags & TTY_DRIVER_RESET_TERMIOS)
+	{
+		unsigned long flags;
+		spin_lock_irqsave(&tty_termios_lock, flags);
 		*tty->termios = tty->driver->init_termios;
-		
+		spin_unlock_irqrestore(&tty_termios_lock, flags);
+	}
+	
 	/* Defer ldisc switch */
 	/* tty_deferred_ldisc_switch(N_TTY);
 	
@@ -785,8 +812,13 @@
 	} else if (tty->driver->hangup)
 		(tty->driver->hangup)(tty);
 		
-	if(ld)
-	{
+	/* We don't want to have driver/ldisc interactions beyond
+	   the ones we did here. The driver layer expects no
+	   calls after ->hangup() from the ldisc side. However we
+	   can't yet guarantee all that */
+
+	set_bit(TTY_HUPPED, &tty->flags);
+	if (ld) {
 		set_bit(TTY_LDISC, &tty->flags);
 		tty_ldisc_deref(ld);
 	}
@@ -895,8 +927,6 @@
 
 void start_tty(struct tty_struct *tty)
 {
-	struct tty_ldisc *ld;
-	
 	if (!tty->stopped || tty->flow_stopped)
 		return;
 	tty->stopped = 0;
@@ -908,12 +938,8 @@
 	if (tty->driver->start)
 		(tty->driver->start)(tty);
 
-	/* If we have a running line discipline it may need kicking */		
-	ld = tty_ldisc_ref(tty);
-	if (ld && (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags)) &&
-	    ld->write_wakeup)
-		(ld->write_wakeup)(tty);
-	tty_ldisc_deref(ld);		
+	/* If we have a running line discipline it may need kicking */
+	tty_wakeup(tty);
 	wake_up_interruptible(&tty->write_wait);
 }
 
@@ -1367,6 +1393,7 @@
 	int	devpts_master, devpts;
 	int	idx;
 	char	buf[64];
+	unsigned long flags;
 	
 	tty = (struct tty_struct *)filp->private_data;
 	if (tty_paranoia_check(tty, filp->f_dentry->d_inode, "release_dev"))
@@ -1580,7 +1607,20 @@
 	 */
 	 
 	flush_scheduled_work();
-
+	
+	/*
+	 * Wait for any short term users (we know they are just driver
+	 * side waiters as the file is closing so user count on the file
+	 * side is zero.
+	 */
+	spin_lock_irqsave(&tty_ldisc_lock, flags);
+	while(tty->ldisc.refcount)
+	{
+		spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+		wait_event(tty_ldisc_wait, tty->ldisc.refcount == 0);
+		spin_lock_irqsave(&tty_ldisc_lock, flags);
+	}
+	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 	/*
 	 * Shutdown the current line discipline, and reset it to N_TTY.
 	 * N.B. why reset ldisc when we're releasing the memory??
@@ -1595,7 +1635,7 @@
 	 *	Switch the line discipline back
 	 */
 	tty_ldisc_assign(tty, tty_ldisc_get(N_TTY));
-	tty->termios->c_line = N_TTY;
+	tty_set_termios_ldisc(tty,N_TTY); 
 	if (o_tty) {
 		/* FIXME: could o_tty be in setldisc here ? */
 		clear_bit(TTY_LDISC, &o_tty->flags);
@@ -1603,8 +1643,8 @@
 			(o_tty->ldisc.close)(o_tty);
 		tty_ldisc_put(o_tty->ldisc.num);
 		tty_ldisc_assign(o_tty, tty_ldisc_get(N_TTY));
+		tty_set_termios_ldisc(o_tty,N_TTY); 
 	}
-
 	/*
 	 * The release_mem function takes care of the details of clearing
 	 * the slots and preserving the termios structure.
@@ -1858,12 +1898,8 @@
 	if (get_user(ch, p))
 		return -EFAULT;
 	ld = tty_ldisc_ref_wait(tty);
-	/* FIXME: suppose this is NOFLIP ?? */
-	if(ld)
-	{
-		ld->receive_buf(tty, &ch, &mbz, 1);
-		tty_ldisc_deref(ld);
-	}
+	ld->receive_buf(tty, &ch, &mbz, 1);
+	tty_ldisc_deref(ld);
 	return 0;
 }
 
@@ -2441,7 +2477,11 @@
 
 int tty_termios_baud_rate(struct termios *termios)
 {
-	unsigned int cbaud = termios->c_cflag & CBAUD;
+	unsigned int cbaud;
+	unsigned long flags;
+	
+	spin_lock_irqsave(&tty_termios_lock, flags);
+	cbaud = termios->c_cflag & CBAUD;
 
 	if (cbaud & CBAUDEX) {
 		cbaud &= ~CBAUDEX;
@@ -2451,7 +2491,7 @@
 		else
 			cbaud += 15;
 	}
-
+	spin_unlock_irqrestore(&tty_termios_lock, flags);
 	return baud_table[cbaud];
 }
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude tty.old/drivers/char/tty_ioctl.c linux-2.6.9rc2/drivers/char/tty_ioctl.c
--- tty.old/drivers/char/tty_ioctl.c	2004-09-23 19:16:26.150071704 +0100
+++ linux-2.6.9rc2/drivers/char/tty_ioctl.c	2004-09-21 15:05:41.000000000 +0100
@@ -29,6 +29,8 @@
 
 #undef	DEBUG
 
+extern spinlock_t tty_termios_lock;
+
 /*
  * Internal flag options for termios setting behavior
  */
@@ -99,8 +101,17 @@
 	int canon_change;
 	struct termios old_termios = *tty->termios;
 	struct tty_ldisc *ld;
+	unsigned long flags;
+	
+	/*
+	 *	Perform the actual termios internal changes under lock.
+	 */
+	 
+
+	/* FIXME: we need to decide on some locking/ordering semantics
+	   for the set_termios notification eventually */
+	spin_lock_irqsave(&tty_termios_lock, flags);
 
-	local_irq_disable(); // FIXME: is this safe?
 	*tty->termios = *new_termios;
 	unset_locked_termios(tty->termios, &old_termios, tty->termios_locked);
 	canon_change = (old_termios.c_lflag ^ tty->termios->c_lflag) & ICANON;
@@ -110,12 +121,13 @@
 		tty->canon_data = 0;
 		tty->erasing = 0;
 	}
-	local_irq_enable(); // FIXME: is this safe?
+	
+	
 	if (canon_change && !L_ICANON(tty) && tty->read_cnt)
 		/* Get characters left over from canonical mode. */
 		wake_up_interruptible(&tty->read_wait);
 
-	/* see if packet mode change of state */
+	/* See if packet mode change of state. */
 
 	if (tty->link && tty->link->packet) {
 		int old_flow = ((old_termios.c_iflag & IXON) &&
@@ -133,14 +145,17 @@
 			wake_up_interruptible(&tty->link->read_wait);
 		}
 	}
-
+	   
 	if (tty->driver->set_termios)
 		(*tty->driver->set_termios)(tty, &old_termios);
 
 	ld = tty_ldisc_ref(tty);
-	if (ld->set_termios)
-		(ld->set_termios)(tty, &old_termios);
-	tty_ldisc_deref(ld);
+	if (ld != NULL) {
+		if (ld->set_termios)
+			(ld->set_termios)(tty, &old_termios);
+		tty_ldisc_deref(ld);
+	}
+	spin_unlock_irqrestore(&tty_termios_lock, flags);
 }
 
 static int set_termios(struct tty_struct * tty, void __user *arg, int opt)
@@ -234,12 +249,16 @@
 static int get_sgttyb(struct tty_struct * tty, struct sgttyb __user * sgttyb)
 {
 	struct sgttyb tmp;
+	unsigned long flags;
 
+	spin_lock_irqsave(&tty_termios_lock, flags);
 	tmp.sg_ispeed = 0;
 	tmp.sg_ospeed = 0;
 	tmp.sg_erase = tty->termios->c_cc[VERASE];
 	tmp.sg_kill = tty->termios->c_cc[VKILL];
 	tmp.sg_flags = get_sgflags(tty);
+	spin_unlock_irqrestore(&tty_termios_lock, flags);
+	
 	return copy_to_user(sgttyb, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
 
@@ -278,12 +297,16 @@
 	retval = tty_check_change(tty);
 	if (retval)
 		return retval;
-	termios =  *tty->termios;
+	
 	if (copy_from_user(&tmp, sgttyb, sizeof(tmp)))
 		return -EFAULT;
+		
+	spin_lock_irqsave(&tty_termios_lock, flags);
+	termios =  *tty->termios;
 	termios.c_cc[VERASE] = tmp.sg_erase;
 	termios.c_cc[VKILL] = tmp.sg_kill;
 	set_sgflags(&termios, tmp.sg_flags);
+	spin_unlock_irqrestore(&tty_termios_lock, flags);
 	change_termios(tty, &termios);
 	return 0;
 }
@@ -375,6 +398,7 @@
 	void __user *p = (void __user *)arg;
 	int retval;
 	struct tty_ldisc *ld;
+	unsigned long flags;
 
 	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 	    tty->driver->subtype == PTY_TYPE_MASTER)
@@ -518,9 +542,11 @@
 		case TIOCSSOFTCAR:
 			if (get_user(arg, (unsigned int __user *) arg))
 				return -EFAULT;
+			spin_lock_irqsave(&tty_termios_lock, flags);
 			tty->termios->c_cflag =
 				((tty->termios->c_cflag & ~CLOCAL) |
 				 (arg ? CLOCAL : 0));
+			spin_unlock_irqrestore(&tty_termios_lock, flags);
 			return 0;
 		default:
 			return -ENOIOCTLCMD;
diff -u --new-file --recursive --exclude-from /usr/src/exclude tty.old/drivers/usb/serial/ir-usb.c linux-2.6.9rc2/drivers/usb/serial/ir-usb.c
--- tty.old/drivers/usb/serial/ir-usb.c	2004-09-23 18:43:47.023904152 +0100
+++ linux-2.6.9rc2/drivers/usb/serial/ir-usb.c	2004-09-23 10:37:21.235818352 +0100
@@ -449,6 +449,10 @@
 			 */
 			tty = port->tty;
 
+			/*
+			 *	FIXME: must not do this in IRQ context,
+			 *	must honour TTY_DONT_FLIP
+			 */
 			tty->ldisc.receive_buf(
 				tty,
 				data+1,
diff -u --new-file --recursive --exclude-from /usr/src/exclude tty.old/include/linux/tty.h linux-2.6.9rc2/include/linux/tty.h
--- tty.old/include/linux/tty.h	2004-09-23 19:16:26.163069728 +0100
+++ linux-2.6.9rc2/include/linux/tty.h	2004-09-21 14:57:41.000000000 +0100
@@ -320,6 +320,7 @@
 #define TTY_HW_COOK_IN 		15	/* Hardware can do input cooking */
 #define TTY_PTY_LOCK 		16	/* pty private */
 #define TTY_NO_WRITE_SPLIT 	17	/* Preserve write boundaries to driver */
+#define TTY_HUPPED 		18	/* Post driver->hangup() */
 
 #define TTY_WRITE_FLUSH(tty) tty_write_flush((tty))
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude tty.old/include/linux/tty_ldisc.h linux-2.6.9rc2/include/linux/tty_ldisc.h
--- tty.old/include/linux/tty_ldisc.h	2004-09-23 19:16:26.163069728 +0100
+++ linux-2.6.9rc2/include/linux/tty_ldisc.h	2004-09-21 17:21:28.000000000 +0100
@@ -95,6 +95,13 @@
  * 	that line discpline should try to send more characters to the
  * 	low-level driver for transmission.  If the line discpline does
  * 	not have any more data to send, it can just return.
+ *
+ * int (*hangup)(struct tty_struct *)
+ *
+ *	Called on a hangup. Tells the discipline that it should
+ *	cease I/O to the tty driver. Can sleep. The driver should
+ *	seek to perform this action quickly but should wait until
+ *	any pending driver I/O is completed.
  */
 
 #include <linux/fs.h>
@@ -122,6 +129,7 @@
 	void	(*set_termios)(struct tty_struct *tty, struct termios * old);
 	unsigned int (*poll)(struct tty_struct *, struct file *,
 			     struct poll_table_struct *);
+	int	(*hangup)(struct tty_struct *tty);
 	
 	/*
 	 * The following routines are called from below.

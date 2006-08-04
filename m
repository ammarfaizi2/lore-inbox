Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbWHDMd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbWHDMd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 08:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbWHDMd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 08:33:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56301 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161121AbWHDMdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 08:33:55 -0400
Subject: PATCH: tty layer comment the locking assumptions and functions
	somewhat
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Aug 2006 13:53:17 +0100
Message-Id: <1154695997.23655.216.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't fix them but does show up some interesting areas that need
review and fixing.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc2-mm1/drivers/char/tty_io.c linux-2.6.18-rc2-mm1/drivers/char/tty_io.c
--- linux.vanilla-2.6.18-rc2-mm1/drivers/char/tty_io.c	2006-07-27 16:19:51.000000000 +0100
+++ linux-2.6.18-rc2-mm1/drivers/char/tty_io.c	2006-08-04 13:02:22.306400960 +0100
@@ -153,7 +153,16 @@
 static int tty_fasync(int fd, struct file * filp, int on);
 static void release_mem(struct tty_struct *tty, int idx);
 
-
+/**
+ *	alloc_tty_struct	-	allocate a tty object
+ *
+ *	Return a new empty tty structure. The data fields have not
+ *	been initialized in any way but has been zeroed
+ *
+ *	Locking: none
+ *	FIXME: use kzalloc
+ */
+ 
 static struct tty_struct *alloc_tty_struct(void)
 {
 	struct tty_struct *tty;
@@ -166,6 +175,15 @@
 
 static void tty_buffer_free_all(struct tty_struct *);
 
+/**
+ *	free_tty_struct		-	free a disused tty
+ *	@tty: tty struct to free
+ *
+ *	Free the write buffers, tty queue and tty memory itself.
+ *
+ *	Locking: none. Must be called after tty is definitely unused
+ */
+
 static inline void free_tty_struct(struct tty_struct *tty)
 {
 	kfree(tty->write_buf);
@@ -175,6 +193,17 @@
 
 #define TTY_NUMBER(tty) ((tty)->index + (tty)->driver->name_base)
 
+/**
+ *	tty_name	-	return tty naming
+ *	@tty: tty structure
+ *	@buf: buffer for output
+ *
+ *	Convert a tty structure into a name. The name reflects the kernel
+ *	naming policy and if udev is in use may not reflect user space
+ *
+ *	Locking: none
+ */
+ 
 char *tty_name(struct tty_struct *tty, char *buf)
 {
 	if (!tty) /* Hmm.  NULL pointer.  That's fun. */
@@ -235,6 +264,17 @@
  * Tty buffer allocation management
  */
 
+
+/**
+ *	tty_buffer_free_all		-	free buffers used by a tty
+ *	@tty: tty to free from
+ *
+ *	Remove all the buffers pending on a tty whether queued with data
+ *	or in the free ring. Must be called when the tty is no longer in use
+ *
+ *	Locking: none
+ */
+ 
 static void tty_buffer_free_all(struct tty_struct *tty)
 {
 	struct tty_buffer *thead;
@@ -347,6 +446,18 @@
 }
 EXPORT_SYMBOL_GPL(tty_buffer_request_room);
 
+/**
+ *	tty_insert_flip_string	-	Add characters to the tty buffer
+ *	@tty: tty structure
+ *	@chars: characters
+ *	@size: size
+ *
+ *	Queue a series of bytes to the tty buffering. All the characters
+ *	passed are marked as without error. Returns the number added.
+ *
+ *	Locking: Called functions may take tty->buf.lock
+ */
+ 
 int tty_insert_flip_string(struct tty_struct *tty, const unsigned char *chars,
 				size_t size)
 {
@@ -370,6 +481,20 @@
 }
 EXPORT_SYMBOL(tty_insert_flip_string);
 
+/**
+ *	tty_insert_flip_string_flags	-	Add characters to the tty buffer
+ *	@tty: tty structure
+ *	@chars: characters
+ *	@flags: flag bytes
+ *	@size: size
+ *
+ *	Queue a series of bytes to the tty buffering. For each character
+ *	the flags array indicates the status of the character. Returns the 
+ *	number added.
+ *
+ *	Locking: Called functions may take tty->buf.lock
+ */
+ 
 int tty_insert_flip_string_flags(struct tty_struct *tty,
 		const unsigned char *chars, const char *flags, size_t size)
 {
@@ -394,6 +519,17 @@
 }
 EXPORT_SYMBOL(tty_insert_flip_string_flags);
 
+/**
+ *	tty_schedule_flip	-	push characters to ldisc
+ *	@tty: tty to push from
+ *
+ *	Takes any pending buffers and transfers their ownership to the
+ *	ldisc side of the queue. It then schedules those characters for
+ *	processing by the line discipline.
+ *
+ *	Locking: Takes tty->buf.lock
+ */
+
 void tty_schedule_flip(struct tty_struct *tty)
 {
 	unsigned long flags;
@@ -405,12 +541,19 @@
 }
 EXPORT_SYMBOL(tty_schedule_flip);
 
-/*
+/**
+ *	tty_prepare_flip_string		-	make room for characters
+ *	@tty: tty
+ *	@chars: return pointer for character write area
+ *	@size: desired size
+ *
  *	Prepare a block of space in the buffer for data. Returns the length
  *	available and buffer pointer to the space which is now allocated and
  *	accounted for as ready for normal characters. This is used for drivers
  *	that need their own block copy routines into the buffer. There is no
  *	guarantee the buffer is a DMA target!
+ *
+ *	Locking: May call functions taking tty->buf.lock
  */
 
 int tty_prepare_flip_string(struct tty_struct *tty, unsigned char **chars, size_t size)
@@ -427,12 +570,20 @@
 
 EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
 
-/*
+/**
+ *	tty_prepare_flip_string_flags	-	make room for characters
+ *	@tty: tty
+ *	@chars: return pointer for character write area
+ *	@flags: return pointer for status flag write area
+ *	@size: desired size
+ *
  *	Prepare a block of space in the buffer for data. Returns the length
  *	available and buffer pointer to the space which is now allocated and
  *	accounted for as ready for characters. This is used for drivers
  *	that need their own block copy routines into the buffer. There is no
  *	guarantee the buffer is a DMA target!
+ *
+ *	Locking: May call functions taking tty->buf.lock
  */
 
 int tty_prepare_flip_string_flags(struct tty_struct *tty, unsigned char **chars, char **flags, size_t size)
@@ -451,10 +602,16 @@
 
 
 
-/*
+/**
+ *	tty_set_termios_ldisc		-	set ldisc field
+ *	@tty: tty structure
+ *	@num: line discipline number
+ *
  *	This is probably overkill for real world processors but
  *	they are not on hot paths so a little discipline won't do 
  *	any harm.
+ *
+ *	Locking: takes termios_sem
  */
  
 static void tty_set_termios_ldisc(struct tty_struct *tty, int num)
@@ -474,6 +631,19 @@
 static DECLARE_WAIT_QUEUE_HEAD(tty_ldisc_wait);
 static struct tty_ldisc tty_ldiscs[NR_LDISCS];	/* line disc dispatch table */
 
+/**
+ *	tty_register_ldisc	-	install a line discipline
+ *	@disc: ldisc number
+ *	@new_ldisc: pointer to the ldisc object
+ *
+ *	Installs a new line discipline into the kernel. The discipline
+ *	is set up as unreferenced and then made available to the kernel
+ *	from this point onwards.
+ *
+ *	Locking:
+ *		takes tty_ldisc_lock to guard against ldisc races
+ */
+ 
 int tty_register_ldisc(int disc, struct tty_ldisc *new_ldisc)
 {
 	unsigned long flags;
@@ -493,6 +663,18 @@
 }
 EXPORT_SYMBOL(tty_register_ldisc);
 
+/**
+ *	tty_unregister_ldisc	-	unload a line discipline
+ *	@disc: ldisc number
+ *	@new_ldisc: pointer to the ldisc object
+ *
+ *	Remove a line discipline from the kernel providing it is not
+ *	currently in use.
+ *
+ *	Locking:
+ *		takes tty_ldisc_lock to guard against ldisc races
+ */
+ 
 int tty_unregister_ldisc(int disc)
 {
 	unsigned long flags;
@@ -512,6 +694,19 @@
 }
 EXPORT_SYMBOL(tty_unregister_ldisc);
 
+/**
+ *	tty_ldisc_get		-	take a reference to an ldisc
+ *	@disc: ldisc number
+ *
+ *	Takes a reference to a line discipline. Deals with refcounts and
+ *	module locking counts. Returns NULL if the discipline is not available.
+ *	Returns a pointer to the discipline and bumps the ref count if it is
+ *	available
+ * 
+ *	Locking:
+ *		takes tty_ldisc_lock to guard against ldisc races
+ */
+ 
 struct tty_ldisc *tty_ldisc_get(int disc)
 {
 	unsigned long flags;
@@ -540,6 +735,17 @@
 
 EXPORT_SYMBOL_GPL(tty_ldisc_get);
 
+/**
+ *	tty_ldisc_put		-	drop ldisc reference
+ *	@disc: ldisc number
+ *
+ *	Drop a reference to a line discipline. Manage refcounts and
+ *	module usage counts
+ *
+ *	Locking:
+ *		takes tty_ldisc_lock to guard against ldisc races
+ */
+ 
 void tty_ldisc_put(int disc)
 {
 	struct tty_ldisc *ld;
@@ -557,6 +763,19 @@
 	
 EXPORT_SYMBOL_GPL(tty_ldisc_put);
 
+/**
+ *	tty_ldisc_assign	-	set ldisc on a tty
+ *	@tty: tty to assign
+ *	@ld: line discipline
+ *
+ *	Install an instance of a line discipline into a tty structure. The
+ *	ldisc must have a reference count above zero to ensure it remains/
+ *	The tty instance refcount starts at zero.
+ *
+ *	Locking:
+ *		Caller must hold references
+ */
+ 
 static void tty_ldisc_assign(struct tty_struct *tty, struct tty_ldisc *ld)
 {
 	tty->ldisc = *ld;
@@ -571,6 +790,8 @@
  *	the tty ldisc. Return 0 on failure or 1 on success. This is
  *	used to implement both the waiting and non waiting versions
  *	of tty_ldisc_ref
+ *
+ *	Locking: takes tty_ldisc_lock
  */
 
 static int tty_ldisc_try(struct tty_struct *tty)
@@ -602,6 +823,8 @@
  *	must also be careful not to hold other locks that will deadlock
  *	against a discipline change, such as an existing ldisc reference
  *	(which we check for)
+ *
+ *	Locking: call functions take tty_ldisc_lock
  */
  
 struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *tty)
@@ -622,6 +845,8 @@
  *	Dereference the line discipline for the terminal and take a 
  *	reference to it. If the line discipline is in flux then 
  *	return NULL. Can be called from IRQ and timer functions.
+ *
+ *	Locking: called functions take tty_ldisc_lock
  */
  
 struct tty_ldisc *tty_ldisc_ref(struct tty_struct *tty)
@@ -639,6 +864,8 @@
  *
  *	Undoes the effect of tty_ldisc_ref or tty_ldisc_ref_wait. May
  *	be called in IRQ context.
+ *
+ *	Locking: takes tty_ldisc_lock
  */
  
 void tty_ldisc_deref(struct tty_ldisc *ld)
@@ -683,6 +910,9 @@
  *
  *	Set the discipline of a tty line. Must be called from a process
  *	context.
+ *
+ *	Locking: takes tty_ldisc_lock.
+ *		called functions take termios_sem
  */
  
 static int tty_set_ldisc(struct tty_struct *tty, int ldisc)
@@ -846,9 +1076,17 @@
 	return retval;
 }
 
-/*
- * This routine returns a tty driver structure, given a device number
+/**
+ *	get_tty_driver		-	find device of a tty
+ *	@dev_t: device identifier
+ *	@index: returns the index of the tty
+ *
+ *	This routine returns a tty driver structure, given a device number
+ *	and also passes back the index number.
+ *
+ *	Locking: caller must hold tty_mutex
  */
+
 static struct tty_driver *get_tty_driver(dev_t device, int *index)
 {
 	struct tty_driver *p;
@@ -863,11 +1101,17 @@
 	return NULL;
 }
 
-/*
- * If we try to write to, or set the state of, a terminal and we're
- * not in the foreground, send a SIGTTOU.  If the signal is blocked or
- * ignored, go ahead and perform the operation.  (POSIX 7.2)
+/**
+ *	tty_check_change	-	check for POSIX terminal changes
+ *	@tty: tty to check
+ *
+ *	If we try to write to, or set the state of, a terminal and we're
+ *	not in the foreground, send a SIGTTOU.  If the signal is blocked or
+ *	ignored, go ahead and perform the operation.  (POSIX 7.2)
+ *
+ *	Locking: none
  */
+
 int tty_check_change(struct tty_struct * tty)
 {
 	if (current->signal->tty != tty)
@@ -1005,10 +1249,27 @@
 
 EXPORT_SYMBOL_GPL(tty_ldisc_flush);
 	
-/*
- * This can be called by the "eventd" kernel thread.  That is process synchronous,
- * but doesn't hold any locks, so we need to make sure we have the appropriate
- * locks for what we're doing..
+/**
+ *	do_tty_hangup		-	actual handler for hangup events
+ *	@data: tty device
+ *
+ *	This can be called by the "eventd" kernel thread.  That is process
+ *	synchronous but doesn't hold any locks, so we need to make sure we
+ *	have the appropriate locks for what we're doing.
+ *
+ *	The hangup event clears any pending redirections onto the hung up
+ *	device. It ensures future writes will error and it does the needed
+ *	line discipline hangup and signal delivery. The tty object itself
+ *	remains intact.
+ *
+ *	Locking:
+ *		BKL
+ *		redirect lock for undoing redirection
+ *		file list lock for manipulating list of ttys
+ *		tty_ldisc_lock from called functions
+ *		termios_sem resetting termios data
+ *		tasklist_lock to walk task list for hangup event
+ *		
  */
 static void do_tty_hangup(void *data)
 {
@@ -1133,6 +1394,14 @@
 		fput(f);
 }
 
+/**
+ *	tty_hangup		-	trigger a hangup event
+ *	@tty: tty to hangup
+ *
+ *	A carrier loss (virtual or otherwise) has occurred on this like
+ *	schedule a hangup sequence to run after this event.
+ */
+ 
 void tty_hangup(struct tty_struct * tty)
 {
 #ifdef TTY_DEBUG_HANGUP
@@ -1145,6 +1414,15 @@
 
 EXPORT_SYMBOL(tty_hangup);
 
+/**
+ *	tty_vhangup		-	process vhangup
+ *	@tty: tty to hangup
+ *
+ *	The user has asked via system call for the terminal to be hung up.
+ *	We do this synchronously so that when the syscall returns the process
+ *	is complete. That guarantee is neccessary for security reasons.
+ */
+ 
 void tty_vhangup(struct tty_struct * tty)
 {
 #ifdef TTY_DEBUG_HANGUP
@@ -1156,6 +1434,14 @@
 }
 EXPORT_SYMBOL(tty_vhangup);
 
+/**
+ *	tty_hung_up_p		-	was tty hung up
+ *	@filp: file pointer of tty
+ *
+ *	Return true if the tty has been subject to a vhangup or a carrier
+ *	loss
+ */
+
 int tty_hung_up_p(struct file * filp)
 {
 	return (filp->f_op == &hung_up_tty_fops);
@@ -1163,19 +1449,28 @@
 
 EXPORT_SYMBOL(tty_hung_up_p);
 
-/*
- * This function is typically called only by the session leader, when
- * it wants to disassociate itself from its controlling tty.
+/**
+ *	disassociate_ctty	-	disconnect controlling tty
+ *	@on_exit: true if exiting so need to "hang up" the session
+ *
+ *	This function is typically called only by the session leader, when
+ *	it wants to disassociate itself from its controlling tty.
  *
- * It performs the following functions:
+ *	It performs the following functions:
  * 	(1)  Sends a SIGHUP and SIGCONT to the foreground process group
  * 	(2)  Clears the tty from being controlling the session
  * 	(3)  Clears the controlling tty for all processes in the
  * 		session group.
  *
- * The argument on_exit is set to 1 if called when a process is
- * exiting; it is 0 if called by the ioctl TIOCNOTTY.
+ *	The argument on_exit is set to 1 if called when a process is
+ *	exiting; it is 0 if called by the ioctl TIOCNOTTY.
+ *
+ *	Locking: tty_mutex is taken to protect current->signal->tty
+ *		BKL is taken for hysterical raisins
+ *		Tasklist lock is taken (under tty_mutex) to walk process
+ *		lists for the session.
  */
+
 void disassociate_ctty(int on_exit)
 {
 	struct tty_struct *tty;
@@ -1222,6 +1517,25 @@
 	unlock_kernel();
 }
 
+
+/**
+ *	stop_tty	-	propogate flow control
+ *	@tty: tty to stop
+ *
+ *	Perform flow control to the driver. For PTY/TTY pairs we
+ *	must also propogate the TIOCKPKT status. May be called
+ *	on an already stopped device and will not re-call the driver
+ *	method.
+ *
+ *	This functionality is used by both the line disciplines for
+ *	halting incoming flow and by the driver. It may therefore be
+ *	called from any context, may be under the tty atomic_write_lock
+ *	but not always.
+ *
+ *	Locking:
+ *		Broken. Relies on BKL which is unsafe here.
+ */
+ 
 void stop_tty(struct tty_struct *tty)
 {
 	if (tty->stopped)
@@ -1238,6 +1552,19 @@
 
 EXPORT_SYMBOL(stop_tty);
 
+/**
+ *	start_tty	-	propogate flow control
+ *	@tty: tty to start
+ *
+ *	Start a tty that has been stopped if at all possible. Perform
+ *	any neccessary wakeups and propogate the TIOCPKT status. If this
+ *	is the tty was previous stopped and is being started then the
+ *	driver start method is invoked and the line discipline woken.
+ *
+ *	Locking:
+ *		Broken. Relies on BKL which is unsafe here.
+ */
+ 
 void start_tty(struct tty_struct *tty)
 {
 	if (!tty->stopped || tty->flow_stopped)
@@ -1258,6 +1585,23 @@
 
 EXPORT_SYMBOL(start_tty);
 
+/**
+ *	tty_read	-	read method for tty device files
+ *	@file: pointer to tty file
+ *	@buf: user buffer
+ *	@count: size of user buffer
+ *	@ppos: unused
+ *
+ *	Perform the read system call function on this terminal device. Checks
+ *	for hung up devices before calling the line discipline method.
+ *
+ *	Locking:
+ *		Locks the line discipline internally while needed
+ *		For historical reasons the line discipline read method is
+ *	invoked under the BKL. This will go away in time so do not rely on it
+ *	in new code. Multiple read calls may be outstanding in parallel.
+ */
+
 static ssize_t tty_read(struct file * file, char __user * buf, size_t count, 
 			loff_t *ppos)
 {
@@ -1302,6 +1646,7 @@
 	ssize_t ret = 0, written = 0;
 	unsigned int chunk;
 	
+	/* FIXME: O_NDELAY ... */
 	if (mutex_lock_interruptible(&tty->atomic_write_lock)) {
 		return -ERESTARTSYS;
 	}
@@ -1318,6 +1663,9 @@
 	 * layer has problems with bigger chunks. It will
 	 * claim to be able to handle more characters than
 	 * it actually does.
+	 *
+	 * FIXME: This can probably go away now except that 64K chunks
+	 * are too likely to fail unless switched to vmalloc...
 	 */
 	chunk = 2048;
 	if (test_bit(TTY_NO_WRITE_SPLIT, &tty->flags))
@@ -1375,6 +1723,24 @@
 }
 
 
+/**
+ *	tty_write		-	write method for tty device file
+ *	@file: tty file pointer
+ *	@buf: user data to write
+ *	@count: bytes to write
+ *	@ppos: unused
+ *
+ *	Write data to a tty device via the line discipline.
+ *
+ *	Locking:
+ *		Locks the line discipline as required
+ *		Writes to the tty driver are serialized by the atomic_write_lock
+ *	and are then processed in chunks to the device. The line discipline
+ *	write method will not be involked in parallel for each device
+ *		The line discipline write method is called under the big
+ *	kernel lock for historical reasons. New code should not rely on this.
+ */
+ 
 static ssize_t tty_write(struct file * file, const char __user * buf, size_t count,
 			 loff_t *ppos)
 {
@@ -1422,7 +1788,18 @@
 
 static char ptychar[] = "pqrstuvwxyzabcde";
 
-static inline void pty_line_name(struct tty_driver *driver, int index, char *p)
+/**
+ *	pty_line_name	-	generate name for a pty
+ *	@driver: the tty driver in use
+ *	@index: the minor number
+ *	@p: output buffer of at least 6 bytes
+ *
+ *	Generate a name from a driver reference and write it to the output
+ *	buffer.
+ *
+ *	Locking: None
+ */	
+static void pty_line_name(struct tty_driver *driver, int index, char *p)
 {
 	int i = index + driver->name_base;
 	/* ->name is initialized to "ttyp", but "tty" is expected */
@@ -1431,24 +1808,53 @@
 			ptychar[i >> 4 & 0xf], i & 0xf);
 }
 
-static inline void tty_line_name(struct tty_driver *driver, int index, char *p)
+/**
+ *	pty_line_name	-	generate name for a tty
+ *	@driver: the tty driver in use
+ *	@index: the minor number
+ *	@p: output buffer of at least 7 bytes
+ *
+ *	Generate a name from a driver reference and write it to the output
+ *	buffer.
+ *
+ *	Locking: None
+ */	
+static void tty_line_name(struct tty_driver *driver, int index, char *p)
 {
 	sprintf(p, "%s%d", driver->name, index + driver->name_base);
 }
 
-/*
+/**
+ *	init_dev		-	initialise a tty device
+ *	@driver: tty driver we are opening a device on
+ *	@idx: device index
+ *	@tty: returned tty structure
+ *
+ *	Prepare a tty device. This may not be a "new" clean device but
+ *	could also be an active device. The pty drivers require special
+ *	handling because of this.
+ *
+ *	Locking:
+ *		The function is called under the tty_mutex, which
+ *	protects us from the tty struct or driver itself going away.
+ *
+ *	On exit the tty device has the line discipline attached and
+ *	a reference count of 1. If a pair was created for pty/tty use
+ *	and the other was a pty master then it too has a reference count of 1.
+ *
  * WSH 06/09/97: Rewritten to remove races and properly clean up after a
  * failed open.  The new code protects the open with a mutex, so it's
  * really quite straightforward.  The mutex locking can probably be
  * relaxed for the (most common) case of reopening a tty.
  */
+
 static int init_dev(struct tty_driver *driver, int idx,
 	struct tty_struct **ret_tty)
 {
 	struct tty_struct *tty, *o_tty;
 	struct termios *tp, **tp_loc, *o_tp, **o_tp_loc;
 	struct termios *ltp, **ltp_loc, *o_ltp, **o_ltp_loc;
-	int retval=0;
+	int retval = 0;
 
 	/* check whether we're reopening an existing tty */
 	if (driver->flags & TTY_DRIVER_DEVPTS_MEM) {
@@ -1662,10 +2068,20 @@
 	goto end_init;
 }
 
-/*
- * Releases memory associated with a tty structure, and clears out the
- * driver table slots.
+/**
+ *	release_mem		-	release tty structure memory
+ *
+ *	Releases memory associated with a tty structure, and clears out the
+ *	driver table slots. This function is called when a device is no longer
+ *	in use. It also gets called when setup of a device fails.
+ *
+ *	Locking:
+ *		tty_mutex - sometimes only
+ *		takes the file list lock internally when working on the list
+ *	of ttys that the driver keeps.
+ *		FIXME: should we require tty_mutex is held here ??
  */
+ 
 static void release_mem(struct tty_struct *tty, int idx)
 {
 	struct tty_struct *o_tty;
@@ -2006,18 +2422,27 @@
 
 }
 
-/*
- * tty_open and tty_release keep up the tty count that contains the
- * number of opens done on a tty. We cannot use the inode-count, as
- * different inodes might point to the same tty.
- *
- * Open-counting is needed for pty masters, as well as for keeping
- * track of serial lines: DTR is dropped when the last close happens.
- * (This is not done solely through tty->count, now.  - Ted 1/27/92)
- *
- * The termios state of a pty is reset on first open so that
- * settings don't persist across reuse.
+/**
+ *	tty_open		-	open a tty device
+ *	@inode: inode of device file
+ *	@filp: file pointer to tty
+ *
+ *	tty_open and tty_release keep up the tty count that contains the
+ *	number of opens done on a tty. We cannot use the inode-count, as
+ *	different inodes might point to the same tty.
+ *
+ *	Open-counting is needed for pty masters, as well as for keeping
+ *	track of serial lines: DTR is dropped when the last close happens.
+ *	(This is not done solely through tty->count, now.  - Ted 1/27/92)
+ *
+ *	The termios state of a pty is reset on first open so that
+ *	settings don't persist across reuse.
+ *
+ *	Locking: tty_mutex protects current->signal->tty, get_tty_driver and
+ *		init_dev work. tty->count should protect the rest.
+ *		task_lock is held to update task details for sessions
  */
+
 static int tty_open(struct inode * inode, struct file * filp)
 {
 	struct tty_struct *tty;
@@ -2132,6 +2557,18 @@
 }
 
 #ifdef CONFIG_UNIX98_PTYS
+/**
+ *	ptmx_open		-	open a unix 98 pty master
+ *	@inode: inode of device file
+ *	@filp: file pointer to tty
+ *
+ *	Allocate a unix98 pty master device from the ptmx driver.
+ *
+ *	Locking: tty_mutex protects theinit_dev work. tty->count should
+ 		protect the rest.
+ *		allocated_ptys_lock handles the list of free pty numbers
+ */
+
 static int ptmx_open(struct inode * inode, struct file * filp)
 {
 	struct tty_struct *tty;
@@ -2191,6 +2628,18 @@
 }
 #endif
 
+/**
+ *	tty_release		-	vfs callback for close
+ *	@inode: inode of tty
+ *	@filp: file pointer for handle to tty
+ *
+ *	Called the last time each file handle is closed that references
+ *	this tty. There may however be several such references.
+ *
+ *	Locking:
+ *		Takes bkl. See release_dev
+ */
+
 static int tty_release(struct inode * inode, struct file * filp)
 {
 	lock_kernel();
@@ -2199,7 +2648,18 @@
 	return 0;
 }
 
-/* No kernel lock held - fine */
+/**
+ *	tty_poll	-	check tty status
+ *	@filp: file being polled
+ *	@wait: poll wait structures to update
+ *
+ *	Call the line discipline polling method to obtain the poll
+ *	status of the device.
+ *
+ *	Locking: locks called line discipline but ldisc poll method
+ *	may be re-entered freely by other callers.
+ */
+
 static unsigned int tty_poll(struct file * filp, poll_table * wait)
 {
 	struct tty_struct * tty;
@@ -2243,6 +2703,21 @@
 	return 0;
 }
 
+/**
+ *	tiocsti			-	fake input character
+ *	@tty: tty to fake input into
+ *	@p: pointer to character
+ *
+ *	Fake input to a tty device. Does the neccessary locking and
+ *	input management.
+ *
+ *	FIXME: does not honour flow control ??
+ *
+ *	Locking:
+ *		Called functions take tty_ldisc_lock
+ *		current->signal->tty check is safe without locks
+ */
+
 static int tiocsti(struct tty_struct *tty, char __user *p)
 {
 	char ch, mbz = 0;
@@ -2258,6 +2733,18 @@
 	return 0;
 }
 
+/**
+ *	tiocgwinsz		-	implement window query ioctl
+ *	@tty; tty
+ *	@arg: user buffer for result
+ *
+ *	Copies the kernel idea of the window size into the user buffer. No
+ *	locking is done.
+ *
+ *	FIXME: Returning random values racing a window size set is wrong
+ *	should lock here against that
+ */
+ 
 static int tiocgwinsz(struct tty_struct *tty, struct winsize __user * arg)
 {
 	if (copy_to_user(arg, &tty->winsize, sizeof(*arg)))
@@ -2265,6 +2752,24 @@
 	return 0;
 }
 
+/**
+ *	tiocswinsz		-	implement window size set ioctl
+ *	@tty; tty
+ *	@arg: user buffer for result
+ *
+ *	Copies the user idea of the window size to the kernel. Traditionally
+ *	this is just advisory information but for the Linux console it 
+ *	actually has driver level meaning and triggers a VC resize.
+ *
+ *	Locking:
+ *		The console_sem is used to ensure we do not try and resize
+ *	the console twice at once.
+ *	FIXME: Two racing size sets may leave the console and kernel
+ *		parameters disagreeing. Is this exploitable ?
+ *	FIXME: Random values racing a window size get is wrong
+ *	should lock here against that
+ */
+ 
 static int tiocswinsz(struct tty_struct *tty, struct tty_struct *real_tty,
 	struct winsize __user * arg)
 {
@@ -2294,6 +2799,15 @@
 	return 0;
 }
 
+/**
+ *	tioccons	-	allow admin to move logical console
+ *	@file: the file to become console
+ *
+ *	Allow the adminstrator to move the redirected console device
+ *
+ *	Locking: uses redirect_lock to guard the redirect information
+ */
+ 
 static int tioccons(struct file *file)
 {
 	if (!capable(CAP_SYS_ADMIN))
@@ -2319,6 +2833,17 @@
 	return 0;
 }
 
+/**
+ *	fionbio		-	non blocking ioctl
+ *	@file: file to set blocking value
+ *	@p: user parameter
+ *
+ *	Historical tty interfaces had a blocking control ioctl before
+ *	the generic functionality existed. This piece of history is preserved
+ *	in the expected tty API of posix OS's.
+ *
+ *	Locking: none, the open fle handle ensures it won't go away.
+ */
 
 static int fionbio(struct file *file, int __user *p)
 {
@@ -2334,6 +2859,23 @@
 	return 0;
 }
 
+/**
+ *	tiocsctty	-	set controlling tty
+ *	@tty: tty structure
+ *	@arg: user argument
+ *
+ *	This ioctl is used to manage job control. It permits a session
+ *	leader to set this tty as the controlling tty for the session.
+ *
+ *	Locking:
+ *		Takes tasklist lock internally to walk sessions
+ *		Takes task_lock() when updating signal->tty
+ *
+ *	FIXME: tty_mutex is needed to protect signal->tty references.
+ *	FIXME: why task_lock on the signal->tty reference ??
+ *	
+ */
+ 
 static int tiocsctty(struct tty_struct *tty, int arg)
 {
 	struct task_struct *p;
@@ -2374,6 +2916,18 @@
 	return 0;
 }
 
+/**
+ *	tiocgpgrp		-	get process group
+ *	@tty: tty passed by user
+ *	@real_tty: tty side of the tty pased by the user if a pty else the tty
+ *	@p: returned pid
+ *
+ *	Obtain the process group of the tty. If there is no process group
+ *	return an error.
+ *
+ *	Locking: none. Reference to ->signal->tty is safe.
+ */
+ 
 static int tiocgpgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
 {
 	/*
@@ -2385,6 +2939,20 @@
 	return put_user(real_tty->pgrp, p);
 }
 
+/**
+ *	tiocspgrp		-	attempt to set process group
+ *	@tty: tty passed by user
+ *	@real_tty: tty side device matching tty passed by user
+ *	@p: pid pointer
+ *
+ *	Set the process group of the tty to the session passed. Only
+ *	permitted where the tty session is our session.
+ *
+ *	Locking: None
+ *
+ *	FIXME: current->signal->tty referencing is unsafe.
+ */
+
 static int tiocspgrp(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
 {
 	pid_t pgrp;
@@ -2408,6 +2976,18 @@
 	return 0;
 }
 
+/**
+ *	tiocgsid		-	get session id
+ *	@tty: tty passed by user
+ *	@real_tty: tty side of the tty pased by the user if a pty else the tty
+ *	@p: pointer to returned session id
+ *
+ *	Obtain the session id of the tty. If there is no session
+ *	return an error.
+ *
+ *	Locking: none. Reference to ->signal->tty is safe.
+ */
+ 
 static int tiocgsid(struct tty_struct *tty, struct tty_struct *real_tty, pid_t __user *p)
 {
 	/*
@@ -2421,6 +3001,16 @@
 	return put_user(real_tty->session, p);
 }
 
+/**
+ *	tiocsetd	-	set line discipline
+ *	@tty: tty device
+ *	@p: pointer to user data
+ *
+ *	Set the line discipline according to user request.
+ *
+ *	Locking: see tty_set_ldisc, this function is just a helper
+ */
+
 static int tiocsetd(struct tty_struct *tty, int __user *p)
 {
 	int ldisc;
@@ -2430,6 +3020,21 @@
 	return tty_set_ldisc(tty, ldisc);
 }
 
+/**
+ *	send_break	-	performed time break
+ *	@tty: device to break on
+ *	@duration: timeout in mS
+ *
+ *	Perform a timed break on hardware that lacks its own driver level
+ *	timed break functionality.
+ *
+ *	Locking:
+ *		None
+ *
+ *	FIXME:
+ *		What if two overlap
+ */
+
 static int send_break(struct tty_struct *tty, unsigned int duration)
 {
 	tty->driver->break_ctl(tty, -1);
@@ -2442,8 +3047,19 @@
 	return 0;
 }
 
-static int
-tty_tiocmget(struct tty_struct *tty, struct file *file, int __user *p)
+/**
+ *	tiocmget		-	get modem status
+ *	@tty: tty device
+ *	@file: user file pointer
+ *	@p: pointer to result
+ *
+ *	Obtain the modem status bits from the tty driver if the feature
+ *	is supported. Return -EINVAL if it is not available.
+ *
+ *	Locking: none (up to the driver)
+ */
+ 
+static int tty_tiocmget(struct tty_struct *tty, struct file *file, int __user *p)
 {
 	int retval = -EINVAL;
 
@@ -2456,8 +3072,20 @@
 	return retval;
 }
 
-static int
-tty_tiocmset(struct tty_struct *tty, struct file *file, unsigned int cmd,
+/**
+ *	tiocmset		-	set modem status
+ *	@tty: tty device
+ *	@file: user file pointer
+ *	@cmd: command - clear bits, set bits or set all
+ *	@p: pointer to desired bits
+ *
+ *	Set the modem status bits from the tty driver if the feature
+ *	is supported. Return -EINVAL if it is not available.
+ *
+ *	Locking: none (up to the driver)
+ */
+ 
+static int tty_tiocmset(struct tty_struct *tty, struct file *file, unsigned int cmd,
 	     unsigned __user *p)
 {
 	int retval = -EINVAL;
@@ -2573,6 +3201,7 @@
 			clear_bit(TTY_EXCLUSIVE, &tty->flags);
 			return 0;
 		case TIOCNOTTY:
+			/* FIXME: taks lock or tty_mutex ? */
 			if (current->signal->tty != tty)
 				return -ENOTTY;
 			if (current->signal->leader)
@@ -2753,9 +3382,16 @@
 
 EXPORT_SYMBOL(do_SAK);
 
-/*
- * This routine is called out of the software interrupt to flush data
- * from the buffer chain to the line discipline.
+/**
+ *	flush_to_ldisc
+ *	@private_: tty structure passed from work queue.
+ *
+ *	This routine is called out of the software interrupt to flush data
+ *	from the buffer chain to the line discipline.
+ *
+ *	Locking: holds tty->buf.lock to guard buffer list. Drops the lock
+ *	while invoking the line discipline receive_buf method. The
+ *	receive_buf method is single threaded for each tty instance.
  */
  
 static void flush_to_ldisc(void *private_)
@@ -2831,6 +3467,8 @@
  *	Convert termios baud rate data into a speed. This should be called
  *	with the termios lock held if this termios is a terminal termios
  *	structure. May change the termios data.
+ *
+ *	Locking: none
  */
  
 int tty_termios_baud_rate(struct termios *termios)
@@ -2859,6 +3497,8 @@
  *	Returns the baud rate as an integer for this terminal. The
  *	termios lock must be held by the caller and the terminal bit
  *	flags may be updated.
+ *
+ *	Locking: none
  */
  
 int tty_get_baud_rate(struct tty_struct *tty)
@@ -2888,6 +3528,8 @@
  *
  *	In the event of the queue being busy for flipping the work will be
  *	held off and retried later.
+ *
+ *	Locking: tty buffer lock. Driver locks in low latency mode.
  */
 
 void tty_flip_buffer_push(struct tty_struct *tty)
@@ -2907,9 +3549,16 @@
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
 
-/*
- * This subroutine initializes a tty structure.
+/**
+ *	initialize_tty_struct
+ *	@tty: tty to initialize
+ *
+ *	This subroutine initializes a tty structure that has been newly
+ *	allocated.
+ *
+ *	Locking: none - tty in question must not be exposed at this point
  */
+
 static void initialize_tty_struct(struct tty_struct *tty)
 {
 	memset(tty, 0, sizeof(struct tty_struct));
@@ -2935,6 +3584,7 @@
 /*
  * The default put_char routine if the driver did not define one.
  */
+
 static void tty_default_put_char(struct tty_struct *tty, unsigned char ch)
 {
 	tty->driver->write(tty, &ch, 1);
@@ -2943,19 +3593,23 @@
 static struct class *tty_class;
 
 /**
- * tty_register_device - register a tty device
- * @driver: the tty driver that describes the tty device
- * @index: the index in the tty driver for this tty device
- * @device: a struct device that is associated with this tty device.
- *	This field is optional, if there is no known struct device for this
- *	tty device it can be set to NULL safely.
- *
- * Returns a pointer to the class device (or ERR_PTR(-EFOO) on error).
- *
- * This call is required to be made to register an individual tty device if
- * the tty driver's flags have the TTY_DRIVER_DYNAMIC_DEV bit set.  If that
- * bit is not set, this function should not be called by a tty driver.
+ *	tty_register_device - register a tty device
+ *	@driver: the tty driver that describes the tty device
+ *	@index: the index in the tty driver for this tty device
+ *	@device: a struct device that is associated with this tty device.
+ *		This field is optional, if there is no known struct device
+ *		for this tty device it can be set to NULL safely.
+ *
+ *	Returns a pointer to the class device (or ERR_PTR(-EFOO) on error).
+ *
+ *	This call is required to be made to register an individual tty device
+ *	if the tty driver's flags have the TTY_DRIVER_DYNAMIC_DEV bit set.  If
+ *	that bit is not set, this function should not be called by a tty
+ *	driver.
+ *
+ *	Locking: ??
  */
+ 
 struct class_device *tty_register_device(struct tty_driver *driver,
 					 unsigned index, struct device *device)
 {
@@ -2977,13 +3631,16 @@
 }
 
 /**
- * tty_unregister_device - unregister a tty device
- * @driver: the tty driver that describes the tty device
- * @index: the index in the tty driver for this tty device
+ * 	tty_unregister_device - unregister a tty device
+ * 	@driver: the tty driver that describes the tty device
+ * 	@index: the index in the tty driver for this tty device
  *
- * If a tty device is registered with a call to tty_register_device() then
- * this function must be made when the tty device is gone.
+ * 	If a tty device is registered with a call to tty_register_device() then
+ *	this function must be called when the tty device is gone.
+ *
+ *	Locking: ??
  */
+
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
 	class_device_destroy(tty_class, MKDEV(driver->major, driver->minor_start) + index);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc2-mm1/drivers/char/tty_ioctl.c linux-2.6.18-rc2-mm1/drivers/char/tty_ioctl.c
--- linux.vanilla-2.6.18-rc2-mm1/drivers/char/tty_ioctl.c	2006-07-27 16:19:02.000000000 +0100
+++ linux-2.6.18-rc2-mm1/drivers/char/tty_ioctl.c	2006-08-04 13:09:55.067570800 +0100
@@ -36,6 +36,18 @@
 #define TERMIOS_WAIT	2
 #define TERMIOS_TERMIO	4
 
+
+/**
+ *	tty_wait_until_sent	-	wait for I/O to finish
+ *	@tty: tty we are waiting for
+ *	@timeout: how long we will wait
+ *
+ *	Wait for characters pending in a tty driver to hit the wire, or
+ *	for a timeout to occur (eg due to flow control)
+ *
+ *	Locking: none
+ */
+ 
 void tty_wait_until_sent(struct tty_struct * tty, long timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
@@ -94,6 +106,18 @@
 			old->c_cc[i] : termios->c_cc[i];
 }
 
+/**
+ *	change_termios		-	update termios values
+ *	@tty: tty to update
+ *	@new_termios: desired new value
+ *
+ *	Perform updates to the termios values set on this terminal. There
+ *	is a bit of layering violation here with n_tty in terms of the 
+ *	internal knowledge of this function.
+ *
+ *	Locking: termios_sem
+ */
+ 
 static void change_termios(struct tty_struct * tty, struct termios * new_termios)
 {
 	int canon_change;
@@ -155,6 +179,19 @@
 	up(&tty->termios_sem);
 }
 
+/**
+ *	set_termios		-	set termios values for a tty
+ *	@tty: terminal device
+ *	@arg: user data
+ *	@opt: option information
+ *
+ *	Helper function to prepare termios data and run neccessary other
+ *	functions before using change_termios to do the actual changes.
+ *
+ *	Locking:
+ *		Called functions take ldisc and termios_sem locks
+ */
+
 static int set_termios(struct tty_struct * tty, void __user *arg, int opt)
 {
 	struct termios tmp_termios;
@@ -284,6 +321,17 @@
 	}
 }
 
+/**
+ *	set_sgttyb		-	set legacy terminal values
+ *	@tty: tty structure
+ *	@sgttyb: pointer to old style terminal structure
+ *
+ *	Updates a terminal from the legacy BSD style terminal information
+ *	structure.
+ *
+ *	Locking: termios_sem
+ */
+
 static int set_sgttyb(struct tty_struct * tty, struct sgttyb __user * sgttyb)
 {
 	int retval;
@@ -369,9 +417,16 @@
 }
 #endif
 
-/*
- * Send a high priority character to the tty.
+/**
+ *	send_prio_char		-	send priority character
+ *
+ *	Send a high priority character to the tty even if stopped
+ *
+ *	Locking: none
+ *
+ *	FIXME: overlapping calls with start/stop tty lose state of tty
  */
+
 static void send_prio_char(struct tty_struct *tty, char ch)
 {
 	int	was_stopped = tty->stopped;


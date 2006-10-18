Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbWJRRpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWJRRpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWJRRpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:45:23 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23491 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751515AbWJRRpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:45:19 -0400
Subject: [PATCH 1/2] tty: switch to ktermios and new framework
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 18:47:39 +0100
Message-Id: <1161193659.9363.117.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the core of the switch to the new framework. I've split it from
the driver patches which are mostly search/replace and would encourage
people to give this one a good hard stare.

The references to BOTHER and ISHIFT are the termios values that must be
defined by a platform once it wants to turn on "new style" ioctl
support. The code patches here ensure that providing

1. The termios overlays the ktermios in memory
2. The only new kernel only fields are c_ispeed/c_ospeed (or none)

the existing behaviour is retained. This is true for the patches at this
point in time.

Future patches will define BOTHER, ISHIFT and enable newer termios
structures for each architecture, and once they are all done some of the
ifdefs also vanish.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/drivers/char/tty_io.c linux-2.6.19-rc2-mm1/drivers/char/tty_io.c
--- linux.vanilla-2.6.19-rc2-mm1/drivers/char/tty_io.c	2006-10-18 13:50:12.000000000 +0100
+++ linux-2.6.19-rc2-mm1/drivers/char/tty_io.c	2006-10-18 17:45:28.000000000 +0100
@@ -109,13 +109,15 @@
 #define TTY_PARANOIA_CHECK 1
 #define CHECK_TTY_COUNT 1
 
-struct termios tty_std_termios = {	/* for the benefit of tty drivers  */
+struct ktermios tty_std_termios = {	/* for the benefit of tty drivers  */
 	.c_iflag = ICRNL | IXON,
 	.c_oflag = OPOST | ONLCR,
 	.c_cflag = B38400 | CS8 | CREAD | HUPCL,
 	.c_lflag = ISIG | ICANON | ECHO | ECHOE | ECHOK |
 		   ECHOCTL | ECHOKE | IEXTEN,
-	.c_cc = INIT_C_CC
+	.c_cc = INIT_C_CC,
+	.c_ispeed = 38400,
+	.c_ospeed = 38400
 };
 
 EXPORT_SYMBOL(tty_std_termios);
@@ -1251,6 +1253,22 @@
 }
 
 EXPORT_SYMBOL_GPL(tty_ldisc_flush);
+
+/**
+ *	tty_reset_termios	-	reset terminal state
+ *	@tty: tty to reset
+ *
+ *	Restore a terminal to the driver default state
+ */
+ 
+static void tty_reset_termios(struct tty_struct *tty)
+{
+	mutex_lock(&tty->termios_mutex);
+	*tty->termios = tty->driver->init_termios;
+	tty->termios->c_ispeed = tty_termios_input_baud_rate(tty->termios);
+	tty->termios->c_ospeed = tty_termios_baud_rate(tty->termios);
+	mutex_unlock(&tty->termios_mutex);
+}
 	
 /**
  *	do_tty_hangup		-	actual handler for hangup events
@@ -1338,11 +1356,7 @@
 	 * N_TTY.
 	 */
 	if (tty->driver->flags & TTY_DRIVER_RESET_TERMIOS)
-	{
-		mutex_lock(&tty->termios_mutex);
-		*tty->termios = tty->driver->init_termios;
-		mutex_unlock(&tty->termios_mutex);
-	}
+		tty_reset_termios(tty);
 	
 	/* Defer ldisc switch */
 	/* tty_deferred_ldisc_switch(N_TTY);
@@ -1855,8 +1869,8 @@
 	struct tty_struct **ret_tty)
 {
 	struct tty_struct *tty, *o_tty;
-	struct termios *tp, **tp_loc, *o_tp, **o_tp_loc;
-	struct termios *ltp, **ltp_loc, *o_ltp, **o_ltp_loc;
+	struct ktermios *tp, **tp_loc, *o_tp, **o_tp_loc;
+	struct ktermios *ltp, **ltp_loc, *o_ltp, **o_ltp_loc;
 	int retval = 0;
 
 	/* check whether we're reopening an existing tty */
@@ -1903,7 +1917,7 @@
 	}
 
 	if (!*tp_loc) {
-		tp = (struct termios *) kmalloc(sizeof(struct termios),
+		tp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
 						GFP_KERNEL);
 		if (!tp)
 			goto free_mem_out;
@@ -1911,11 +1925,11 @@
 	}
 
 	if (!*ltp_loc) {
-		ltp = (struct termios *) kmalloc(sizeof(struct termios),
+		ltp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
 						 GFP_KERNEL);
 		if (!ltp)
 			goto free_mem_out;
-		memset(ltp, 0, sizeof(struct termios));
+		memset(ltp, 0, sizeof(struct ktermios));
 	}
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY) {
@@ -1936,19 +1950,19 @@
 		}
 
 		if (!*o_tp_loc) {
-			o_tp = (struct termios *)
-				kmalloc(sizeof(struct termios), GFP_KERNEL);
+			o_tp = (struct ktermios *)
+				kmalloc(sizeof(struct ktermios), GFP_KERNEL);
 			if (!o_tp)
 				goto free_mem_out;
 			*o_tp = driver->other->init_termios;
 		}
 
 		if (!*o_ltp_loc) {
-			o_ltp = (struct termios *)
-				kmalloc(sizeof(struct termios), GFP_KERNEL);
+			o_ltp = (struct ktermios *)
+				kmalloc(sizeof(struct ktermios), GFP_KERNEL);
 			if (!o_ltp)
 				goto free_mem_out;
-			memset(o_ltp, 0, sizeof(struct termios));
+			memset(o_ltp, 0, sizeof(struct ktermios));
 		}
 
 		/*
@@ -1987,6 +2001,9 @@
 		*ltp_loc = ltp;
 	tty->termios = *tp_loc;
 	tty->termios_locked = *ltp_loc;
+	/* Compatibility until drivers always set this */
+	tty->termios->c_ispeed = tty_termios_input_baud_rate(tty->termios);
+	tty->termios->c_ospeed = tty_termios_baud_rate(tty->termios);
 	driver->refcount++;
 	tty->count++;
 
@@ -2089,7 +2106,7 @@
 static void release_mem(struct tty_struct *tty, int idx)
 {
 	struct tty_struct *o_tty;
-	struct termios *tp;
+	struct ktermios *tp;
 	int devpts = tty->driver->flags & TTY_DRIVER_DEVPTS_MEM;
 
 	if ((o_tty = tty->link) != NULL) {
@@ -3453,84 +3470,6 @@
 	tty_ldisc_deref(disc);
 }
 
-/*
- * Routine which returns the baud rate of the tty
- *
- * Note that the baud_table needs to be kept in sync with the
- * include/asm/termbits.h file.
- */
-static int baud_table[] = {
-	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
-	9600, 19200, 38400, 57600, 115200, 230400, 460800,
-#ifdef __sparc__
-	76800, 153600, 307200, 614400, 921600
-#else
-	500000, 576000, 921600, 1000000, 1152000, 1500000, 2000000,
-	2500000, 3000000, 3500000, 4000000
-#endif
-};
-
-static int n_baud_table = ARRAY_SIZE(baud_table);
-
-/**
- *	tty_termios_baud_rate
- *	@termios: termios structure
- *
- *	Convert termios baud rate data into a speed. This should be called
- *	with the termios lock held if this termios is a terminal termios
- *	structure. May change the termios data.
- *
- *	Locking: none
- */
- 
-int tty_termios_baud_rate(struct termios *termios)
-{
-	unsigned int cbaud;
-	
-	cbaud = termios->c_cflag & CBAUD;
-
-	if (cbaud & CBAUDEX) {
-		cbaud &= ~CBAUDEX;
-
-		if (cbaud < 1 || cbaud + 15 > n_baud_table)
-			termios->c_cflag &= ~CBAUDEX;
-		else
-			cbaud += 15;
-	}
-	return baud_table[cbaud];
-}
-
-EXPORT_SYMBOL(tty_termios_baud_rate);
-
-/**
- *	tty_get_baud_rate	-	get tty bit rates
- *	@tty: tty to query
- *
- *	Returns the baud rate as an integer for this terminal. The
- *	termios lock must be held by the caller and the terminal bit
- *	flags may be updated.
- *
- *	Locking: none
- */
- 
-int tty_get_baud_rate(struct tty_struct *tty)
-{
-	int baud = tty_termios_baud_rate(tty->termios);
-
-	if (baud == 38400 && tty->alt_speed) {
-		if (!tty->warned) {
-			printk(KERN_WARNING "Use of setserial/setrocket to "
-					    "set SPD_* flags is deprecated\n");
-			tty->warned = 1;
-		}
-		baud = tty->alt_speed;
-	}
-	
-	return baud;
-}
-
-EXPORT_SYMBOL(tty_get_baud_rate);
-
 /**
  *	tty_flip_buffer_push	-	terminal
  *	@tty: tty to push
@@ -3752,8 +3691,8 @@
 
 	if (p) {
 		driver->ttys = (struct tty_struct **)p;
-		driver->termios = (struct termios **)(p + driver->num);
-		driver->termios_locked = (struct termios **)(p + driver->num * 2);
+		driver->termios = (struct ktermios **)(p + driver->num);
+		driver->termios_locked = (struct ktermios **)(p + driver->num * 2);
 	} else {
 		driver->ttys = NULL;
 		driver->termios = NULL;
@@ -3792,7 +3731,7 @@
 int tty_unregister_driver(struct tty_driver *driver)
 {
 	int i;
-	struct termios *tp;
+	struct ktermios *tp;
 	void *p;
 
 	if (driver->refcount)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/drivers/char/tty_ioctl.c linux-2.6.19-rc2-mm1/drivers/char/tty_ioctl.c
--- linux.vanilla-2.6.19-rc2-mm1/drivers/char/tty_ioctl.c	2006-10-18 13:50:12.000000000 +0100
+++ linux-2.6.19-rc2-mm1/drivers/char/tty_ioctl.c	2006-10-18 17:42:29.000000000 +0100
@@ -36,6 +36,7 @@
 #define TERMIOS_FLUSH	1
 #define TERMIOS_WAIT	2
 #define TERMIOS_TERMIO	4
+#define TERMIOS_OLD	8
 
 
 /**
@@ -84,9 +85,9 @@
 
 EXPORT_SYMBOL(tty_wait_until_sent);
 
-static void unset_locked_termios(struct termios *termios,
-				 struct termios *old,
-				 struct termios *locked)
+static void unset_locked_termios(struct ktermios *termios,
+				 struct ktermios *old,
+				 struct ktermios *locked)
 {
 	int	i;
 	
@@ -105,8 +106,206 @@
 	for (i=0; i < NCCS; i++)
 		termios->c_cc[i] = locked->c_cc[i] ?
 			old->c_cc[i] : termios->c_cc[i];
+	/* FIXME: What should we do for i/ospeed */
 }
 
+/*
+ * Routine which returns the baud rate of the tty
+ *
+ * Note that the baud_table needs to be kept in sync with the
+ * include/asm/termbits.h file.
+ */
+static const speed_t baud_table[] = {
+	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
+	9600, 19200, 38400, 57600, 115200, 230400, 460800,
+#ifdef __sparc__
+	76800, 153600, 307200, 614400, 921600
+#else
+	500000, 576000, 921600, 1000000, 1152000, 1500000, 2000000,
+	2500000, 3000000, 3500000, 4000000
+#endif
+};
+
+#ifndef __sparc__
+static const tcflag_t baud_bits[] = {
+	B0, B50, B75, B110, B134, B150, B200, B300, B600,
+	B1200, B1800, B2400, B4800, B9600, B19200, B38400,
+	B57600, B115200, B230400, B460800, B500000, B576000,
+	B921600, B1000000, B1152000, B1500000, B2000000, B2500000,
+	B3000000, B3500000, B4000000
+};
+#else
+static const tcflag_t baud_bits[] = {
+	B0, B50, B75, B110, B134, B150, B200, B300, B600,
+	B1200, B1800, B2400, B4800, B9600, B19200, B38400,
+	B57600, B115200, B230400, B460800, B76800, B153600,
+	B307200, B614400, B921600
+};
+#endif	
+
+static int n_baud_table = ARRAY_SIZE(baud_table);
+
+/**
+ *	tty_termios_baud_rate
+ *	@termios: termios structure
+ *
+ *	Convert termios baud rate data into a speed. This should be called
+ *	with the termios lock held if this termios is a terminal termios
+ *	structure. May change the termios data. Device drivers can call this
+ *	function but should use ->c_[io]speed directly as they are updated.
+ *
+ *	Locking: none
+ */
+ 
+speed_t tty_termios_baud_rate(struct ktermios *termios)
+{
+	unsigned int cbaud;
+	
+	cbaud = termios->c_cflag & CBAUD;
+
+#ifdef BOTHER
+	/* Magic token for arbitary speed via c_ispeed/c_ospeed */
+	if (cbaud == BOTHER)
+		return termios->c_ospeed;
+#endif
+	if (cbaud & CBAUDEX) {
+		cbaud &= ~CBAUDEX;
+
+		if (cbaud < 1 || cbaud + 15 > n_baud_table)
+			termios->c_cflag &= ~CBAUDEX;
+		else
+			cbaud += 15;
+	}
+	return baud_table[cbaud];
+}
+
+EXPORT_SYMBOL(tty_termios_baud_rate);
+
+/**
+ *	tty_termios_input_baud_rate
+ *	@termios: termios structure
+ *
+ *	Convert termios baud rate data into a speed. This should be called
+ *	with the termios lock held if this termios is a terminal termios
+ *	structure. May change the termios data. Device drivers can call this
+ *	function but should use ->c_[io]speed directly as they are updated.
+ *
+ *	Locking: none
+ */
+ 
+speed_t tty_termios_input_baud_rate(struct ktermios *termios)
+{
+	unsigned int cbaud;
+	
+#ifdef IBSHIFT
+	cbaud = (termios->c_cflag >> IBSHIFT) & CBAUD;
+	
+	if (cbaud == B0)
+		return tty_termios_baud_rate(termios);
+
+	/* Magic token for arbitary speed via c_ispeed*/
+	if (cbaud == BOTHER)
+		return termios->c_ispeed;
+
+	if (cbaud & CBAUDEX) {
+		cbaud &= ~CBAUDEX;
+
+		if (cbaud < 1 || cbaud + 15 > n_baud_table)
+			termios->c_cflag &= ~(CBAUDEX << IBSHIFT);
+		else
+			cbaud += 15;
+	}
+	return baud_table[cbaud];
+#else
+	return tty_termios_baud_rate(termios);
+#endif	
+}
+
+EXPORT_SYMBOL(tty_termios_input_baud_rate);
+
+#ifdef BOTHER
+
+/**
+ *	tty_termios_encode_baud_rate
+ *	@termios: termios structure
+ *	@ispeed: input speed
+ *	@ospeed: output speed
+ *
+ *	Encode the speeds set into the passed termios structure. This is
+ *	used as a library helper for drivers os that they can report back
+ *	the actual speed selected when it differs from the speed requested
+ *
+ *	For now input and output speed must agree.
+ *
+ *	Locking: Caller should hold termios lock. This is already held
+ *	when calling this function from the driver termios handler.
+ */
+ 
+void tty_termios_encode_baud_rate(struct ktermios *termios, speed_t ibaud, speed_t obaud)
+{
+	int i = 0;
+	int ifound = 0, ofound = 0;
+		
+	termios->c_ispeed = ibaud;
+	termios->c_ospeed = obaud;
+
+	termios->c_cflag &= ~CBAUD;
+	/* Identical speed means no input encoding (ie B0 << IBSHIFT)*/
+	if (termios->c_ispeed == termios->c_ospeed)
+		ifound = 1;
+	
+	do {
+		if (obaud == baud_table[i]) {
+			termios->c_cflag |= baud_bits[i];
+			ofound = 1;
+			/* So that if ibaud == obaud we don't set it */
+			continue;
+		}
+		if (ibaud == baud_table[i]) {
+			termios->c_cflag |= (baud_bits[i] << IBSHIFT);
+			ifound = 1;
+		}
+	}
+	while(++i < n_baud_table);
+	if (!ofound)
+		termios->c_cflag |= BOTHER;
+	if (!ifound)
+		termios->c_cflag |= (BOTHER << IBSHIFT);
+}
+ 
+EXPORT_SYMBOL_GPL(tty_termios_encode_baud_rate);
+
+#endif
+
+/**
+ *	tty_get_baud_rate	-	get tty bit rates
+ *	@tty: tty to query
+ *
+ *	Returns the baud rate as an integer for this terminal. The
+ *	termios lock must be held by the caller and the terminal bit
+ *	flags may be updated.
+ *
+ *	Locking: none
+ */
+ 
+speed_t tty_get_baud_rate(struct tty_struct *tty)
+{
+	speed_t baud = tty_termios_baud_rate(tty->termios);
+
+	if (baud == 38400 && tty->alt_speed) {
+		if (!tty->warned) {
+			printk(KERN_WARNING "Use of setserial/setrocket to "
+					    "set SPD_* flags is deprecated\n");
+			tty->warned = 1;
+		}
+		baud = tty->alt_speed;
+	}
+	
+	return baud;
+}
+
+EXPORT_SYMBOL(tty_get_baud_rate);
+
 /**
  *	change_termios		-	update termios values
  *	@tty: tty to update
@@ -119,10 +318,10 @@
  *	Locking: termios_sem
  */
 
-static void change_termios(struct tty_struct * tty, struct termios * new_termios)
+static void change_termios(struct tty_struct * tty, struct ktermios * new_termios)
 {
 	int canon_change;
-	struct termios old_termios = *tty->termios;
+	struct ktermios old_termios = *tty->termios;
 	struct tty_ldisc *ld;
 	
 	/*
@@ -195,7 +394,7 @@
 
 static int set_termios(struct tty_struct * tty, void __user *arg, int opt)
 {
-	struct termios tmp_termios;
+	struct ktermios tmp_termios;
 	struct tty_ldisc *ld;
 	int retval = tty_check_change(tty);
 
@@ -203,16 +402,28 @@
 		return retval;
 
 	if (opt & TERMIOS_TERMIO) {
-		memcpy(&tmp_termios, tty->termios, sizeof(struct termios));
+		memcpy(&tmp_termios, tty->termios, sizeof(struct ktermios));
 		if (user_termio_to_kernel_termios(&tmp_termios,
 						(struct termio __user *)arg))
 			return -EFAULT;
+#ifdef TCGETS2		
+	} else if (opt & TERMIOS_OLD) {
+		memcpy(&tmp_termios, tty->termios, sizeof(struct termios));
+		if (user_termios_to_kernel_termios_1(&tmp_termios,
+						(struct termios_v1 __user *)arg))
+			return -EFAULT;
+#endif		
 	} else {
 		if (user_termios_to_kernel_termios(&tmp_termios,
 						(struct termios __user *)arg))
 			return -EFAULT;
 	}
 
+	/* If old style Bfoo values are used then load c_ispeed/c_ospeed with the real speed
+	   so its unconditionally usable */
+	tmp_termios.c_ispeed = tty_termios_input_baud_rate(&tmp_termios);
+	tmp_termios.c_ospeed = tty_termios_baud_rate(&tmp_termios);
+
 	ld = tty_ldisc_ref(tty);
 	
 	if (ld != NULL) {
@@ -286,8 +497,8 @@
 	struct sgttyb tmp;
 
 	mutex_lock(&tty->termios_mutex);
-	tmp.sg_ispeed = 0;
-	tmp.sg_ospeed = 0;
+	tmp.sg_ispeed = tty->c_ispeed;
+	tmp.sg_ospeed = tty->c_ospeed;
 	tmp.sg_erase = tty->termios->c_cc[VERASE];
 	tmp.sg_kill = tty->termios->c_cc[VKILL];
 	tmp.sg_flags = get_sgflags(tty);
@@ -296,7 +507,7 @@
 	return copy_to_user(sgttyb, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
 
-static void set_sgflags(struct termios * termios, int flags)
+static void set_sgflags(struct ktermios * termios, int flags)
 {
 	termios->c_iflag = ICRNL | IXON;
 	termios->c_oflag = 0;
@@ -337,7 +548,7 @@
 {
 	int retval;
 	struct sgttyb tmp;
-	struct termios termios;
+	struct ktermios termios;
 
 	retval = tty_check_change(tty);
 	if (retval)
@@ -351,6 +562,10 @@
 	termios.c_cc[VERASE] = tmp.sg_erase;
 	termios.c_cc[VKILL] = tmp.sg_kill;
 	set_sgflags(&termios, tmp.sg_flags);
+	/* Try and encode into Bfoo format */	
+#ifdef BOTHER	
+	tty_termios_encode_baud_rate(&termios, termios.c_ispeed, termios.c_ospeed);
+#endif	
 	mutex_unlock(&tty->termios_mutex);
 	change_termios(tty, &termios);
 	return 0;
@@ -481,16 +696,33 @@
 		case TIOCSLTC:
 			return set_ltchars(real_tty, p);
 #endif
+		case TCSETSF:
+			return set_termios(real_tty, p,  TERMIOS_FLUSH | TERMIOS_WAIT | TERMIOS_OLD);
+		case TCSETSW:
+			return set_termios(real_tty, p, TERMIOS_WAIT | TERMIOS_OLD);
+		case TCSETS:
+			return set_termios(real_tty, p, TERMIOS_OLD);
+#ifndef TCGETS2
 		case TCGETS:
 			if (kernel_termios_to_user_termios((struct termios __user *)arg, real_tty->termios))
 				return -EFAULT;
 			return 0;
-		case TCSETSF:
+#else
+		case TCGETS:
+			if (kernel_termios_to_user_termios_1((struct termios_v1 __user *)arg, real_tty->termios))
+				return -EFAULT;
+			return 0;
+		case TCGETS2:
+			if (kernel_termios_to_user_termios((struct termios __user *)arg, real_tty->termios))
+				return -EFAULT;
+			return 0;
+		case TCSETSF2:
 			return set_termios(real_tty, p,  TERMIOS_FLUSH | TERMIOS_WAIT);
-		case TCSETSW:
+		case TCSETSW2:
 			return set_termios(real_tty, p, TERMIOS_WAIT);
-		case TCSETS:
+		case TCSETS2:
 			return set_termios(real_tty, p, 0);
+#endif			
 		case TCGETA:
 			return get_termio(real_tty, p);
 		case TCSETAF:
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/linux/tty_driver.h linux-2.6.19-rc2-mm1/include/linux/tty_driver.h
--- linux.vanilla-2.6.19-rc2-mm1/include/linux/tty_driver.h	2006-10-18 13:50:34.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/linux/tty_driver.h	2006-10-18 14:13:20.000000000 +0100
@@ -53,7 +53,7 @@
  *	device-specific ioctl's.  If the ioctl number passed in cmd
  * 	is not recognized by the driver, it should return ENOIOCTLCMD.
  * 
- * void (*set_termios)(struct tty_struct *tty, struct termios * old);
+ * void (*set_termios)(struct tty_struct *tty, struct ktermios * old);
  *
  * 	This routine allows the tty driver to be notified when
  * 	device's termios settings have changed.  Note that a
@@ -132,7 +132,7 @@
 	int  (*chars_in_buffer)(struct tty_struct *tty);
 	int  (*ioctl)(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg);
-	void (*set_termios)(struct tty_struct *tty, struct termios * old);
+	void (*set_termios)(struct tty_struct *tty, struct ktermios * old);
 	void (*throttle)(struct tty_struct * tty);
 	void (*unthrottle)(struct tty_struct * tty);
 	void (*stop)(struct tty_struct *tty);
@@ -165,7 +165,7 @@
 	int	num;		/* number of devices allocated */
 	short	type;		/* type of tty driver */
 	short	subtype;	/* subtype of tty driver */
-	struct termios init_termios; /* Initial termios */
+	struct ktermios init_termios; /* Initial termios */
 	int	flags;		/* tty driver flags */
 	int	refcount;	/* for loadable tty drivers */
 	struct proc_dir_entry *proc_entry; /* /proc fs entry */
@@ -175,8 +175,8 @@
 	 * Pointer to the tty data structures
 	 */
 	struct tty_struct **ttys;
-	struct termios **termios;
-	struct termios **termios_locked;
+	struct ktermios **termios;
+	struct ktermios **termios_locked;
 	void *driver_state;	/* only used for the PTY driver */
 	
 	/*
@@ -193,7 +193,7 @@
 	int  (*chars_in_buffer)(struct tty_struct *tty);
 	int  (*ioctl)(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg);
-	void (*set_termios)(struct tty_struct *tty, struct termios * old);
+	void (*set_termios)(struct tty_struct *tty, struct ktermios * old);
 	void (*throttle)(struct tty_struct * tty);
 	void (*unthrottle)(struct tty_struct * tty);
 	void (*stop)(struct tty_struct *tty);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/linux/tty.h linux-2.6.19-rc2-mm1/include/linux/tty.h
--- linux.vanilla-2.6.19-rc2-mm1/include/linux/tty.h	2006-10-18 13:50:34.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/linux/tty.h	2006-10-18 17:43:53.546805424 +0100
@@ -175,7 +175,7 @@
 	int index;
 	struct tty_ldisc ldisc;
 	struct mutex termios_mutex;
-	struct termios *termios, *termios_locked;
+	struct ktermios *termios, *termios_locked;
 	char name[64];
 	int pgrp;
 	int session;
@@ -258,7 +258,7 @@
 
 extern void tty_write_flush(struct tty_struct *);
 
-extern struct termios tty_std_termios;
+extern struct ktermios tty_std_termios;
 
 extern int kmsg_redirect;
 
@@ -294,8 +294,9 @@
 extern void do_SAK(struct tty_struct *tty);
 extern void disassociate_ctty(int priv);
 extern void tty_flip_buffer_push(struct tty_struct *tty);
-extern int tty_get_baud_rate(struct tty_struct *tty);
-extern int tty_termios_baud_rate(struct termios *termios);
+extern speed_t tty_get_baud_rate(struct tty_struct *tty);
+extern speed_t tty_termios_baud_rate(struct ktermios *termios);
+extern speed_t tty_termios_input_baud_rate(struct ktermios *termios);
 
 extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
 extern void tty_ldisc_deref(struct tty_ldisc *);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc2-mm1/include/linux/tty_ldisc.h linux-2.6.19-rc2-mm1/include/linux/tty_ldisc.h
--- linux.vanilla-2.6.19-rc2-mm1/include/linux/tty_ldisc.h	2006-10-13 15:07:12.000000000 +0100
+++ linux-2.6.19-rc2-mm1/include/linux/tty_ldisc.h	2006-10-18 14:13:38.000000000 +0100
@@ -59,7 +59,7 @@
  * 	low-level driver can "grab" an ioctl request before the line
  * 	discpline has a chance to see it.
  * 
- * void	(*set_termios)(struct tty_struct *tty, struct termios * old);
+ * void	(*set_termios)(struct tty_struct *tty, struct ktermios * old);
  *
  * 	This function notifies the line discpline that a change has
  * 	been made to the termios structure.
@@ -118,7 +118,7 @@
 			 const unsigned char * buf, size_t nr);	
 	int	(*ioctl)(struct tty_struct * tty, struct file * file,
 			 unsigned int cmd, unsigned long arg);
-	void	(*set_termios)(struct tty_struct *tty, struct termios * old);
+	void	(*set_termios)(struct tty_struct *tty, struct ktermios * old);
 	unsigned int (*poll)(struct tty_struct *, struct file *,
 			     struct poll_table_struct *);
 	int	(*hangup)(struct tty_struct *tty);



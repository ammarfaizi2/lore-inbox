Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbUL2IxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbUL2IxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 03:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbUL2IxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 03:53:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28619 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261172AbUL2IwY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 03:52:24 -0500
Date: Wed, 29 Dec 2004 08:52:22 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Patch: 2.6.10 - CMSPAR in mxser.c undeclared
Message-ID: <20041229085222.GM26051@parcelfarce.linux.theplanet.co.uk>
References: <20041229081957.GA31981@rollcage.inittab.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041229081957.GA31981@rollcage.inittab.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 09:19:58AM +0100, Norbert Tretkowski wrote:
> --- drivers/char/mxser.c~       2004-12-24 22:35:14.000000000 +0100
> +++ drivers/char/mxser.c        2004-12-29 09:08:59.000000000 +0100
> @@ -1561,6 +1561,10 @@
> 
>                                 mon_data_ext.stopbits[i] = cflag & CSTOPB;
> 
> +#ifndef CMSPAR
> +#define        CMSPAR 010000000000
> +#endif

a) there's another declaration lower in the file (too low) and it gets
redundant.
b) there are other problems with mxser; patch below had been sent to Linus a
couple of days ago.


diff -urN RC10-delta13/drivers/char/mxser.c RC10-delta14/drivers/char/mxser.c
--- RC10-delta13/drivers/char/mxser.c	Fri Dec 24 20:11:42 2004
+++ RC10-delta14/drivers/char/mxser.c	Mon Dec 27 06:04:22 2004
@@ -401,7 +401,7 @@
 static void mxser_flush_chars(struct tty_struct *);
 static void mxser_put_char(struct tty_struct *, unsigned char);
 static int mxser_ioctl(struct tty_struct *, struct file *, uint, ulong);
-static int mxser_ioctl_special(unsigned int, unsigned long);
+static int mxser_ioctl_special(unsigned int, void __user *);
 static void mxser_throttle(struct tty_struct *);
 static void mxser_unthrottle(struct tty_struct *);
 static void mxser_set_termios(struct tty_struct *, struct termios *);
@@ -417,9 +417,9 @@
 static int mxser_startup(struct mxser_struct *);
 static void mxser_shutdown(struct mxser_struct *);
 static int mxser_change_speed(struct mxser_struct *, struct termios *old_termios);
-static int mxser_get_serial_info(struct mxser_struct *, struct serial_struct *);
-static int mxser_set_serial_info(struct mxser_struct *, struct serial_struct *);
-static int mxser_get_lsr_info(struct mxser_struct *, unsigned int *);
+static int mxser_get_serial_info(struct mxser_struct *, struct serial_struct __user *);
+static int mxser_set_serial_info(struct mxser_struct *, struct serial_struct __user *);
+static int mxser_get_lsr_info(struct mxser_struct *, unsigned int __user *);
 static void mxser_send_break(struct mxser_struct *, int);
 static int mxser_tiocmget(struct tty_struct *, struct file *);
 static int mxser_tiocmset(struct tty_struct *, struct file *, unsigned int, unsigned int);
@@ -834,6 +834,7 @@
 	}
 
 	/* start finding PCI board here */
+#ifdef CONFIG_PCI
 	n = (sizeof(mxser_pcibrds) / sizeof(mxser_pcibrds[0])) - 1;
 	index = 0;
 	b = 0;
@@ -875,6 +876,7 @@
 			m++;
 		}
 	}
+#endif
 
 	ret1 = 0;
 	if (!(ret1 = tty_register_driver(mxvar_sdriver))) {
@@ -968,7 +970,7 @@
 			*tty->termios = info->normal_termios;
 		else
 			*tty->termios = info->callout_termios;
-		mxser_change_speed(info, 0);
+		mxser_change_speed(info, NULL);
 	}
 
 	info->session = current->signal->session;
@@ -1084,7 +1086,7 @@
 		
 	tty->closing = 0;
 	info->event = 0;
-	info->tty = 0;
+	info->tty = NULL;
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -1223,12 +1225,13 @@
 	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
 	int retval;
 	struct async_icount cprev, cnow;	/* kernel counter temps */
-	struct serial_icounter_struct *p_cuser;	/* user space */
+	struct serial_icounter_struct __user *p_cuser;
 	unsigned long templ;
 	unsigned long flags;
+	void __user *argp = (void __user *)arg;
 
 	if (tty->index == MXSER_PORTS)
-		return (mxser_ioctl_special(cmd, arg));
+		return (mxser_ioctl_special(cmd, argp));
 
 	// following add by Victor Yu. 01-05-2004
 	if (cmd == MOXA_SET_OP_MODE || cmd == MOXA_GET_OP_MODE) {
@@ -1239,7 +1242,7 @@
 
 		p = info->port % 4;
 		if (cmd == MOXA_SET_OP_MODE) {
-			if (get_user(opmode, (int *) arg))
+			if (get_user(opmode, (int __user *) argp))
 				return -EFAULT;
 			if (opmode != RS232_MODE && opmode != RS485_2WIRE_MODE && opmode != RS422_MODE && opmode != RS485_4WIRE_MODE)
 				return -EFAULT;
@@ -1253,7 +1256,7 @@
 			shiftbit = p * 2;
 			opmode = inb(info->opmode_ioaddr) >> shiftbit;
 			opmode &= OP_MODE_MASK;
-			if (copy_to_user((int *) arg, &opmode, sizeof(int)))
+			if (copy_to_user(argp, &opmode, sizeof(int)))
 				return -EFAULT;
 		}
 		return 0;
@@ -1281,19 +1284,19 @@
 		mxser_send_break(info, arg ? arg * (HZ / 10) : HZ / 4);
 		return (0);
 	case TIOCGSOFTCAR:
-		return put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long *) arg);
+		return put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long __user *) argp);
 	case TIOCSSOFTCAR:
-		if (get_user(templ, (unsigned long *) arg))
+		if (get_user(templ, (unsigned long __user *) argp))
 			return -EFAULT;
 		arg = templ;
 		tty->termios->c_cflag = ((tty->termios->c_cflag & ~CLOCAL) | (arg ? CLOCAL : 0));
 		return (0);
 	case TIOCGSERIAL:
-		return (mxser_get_serial_info(info, (struct serial_struct *) arg));
+		return mxser_get_serial_info(info, argp);
 	case TIOCSSERIAL:
-		return (mxser_set_serial_info(info, (struct serial_struct *) arg));
+		return mxser_set_serial_info(info, argp);
 	case TIOCSERGETLSR:	/* Get line status register */
-		return (mxser_get_lsr_info(info, (unsigned int *) arg));
+		return mxser_get_lsr_info(info, argp);
 		/*
 		 * Wait for any of the 4 modem inputs (DCD,RI,DSR,CTS) to change
 		 * - mask passed in arg for lines of interest
@@ -1340,7 +1343,7 @@
 		spin_lock_irqsave(&info->slock, flags);
 		cnow = info->icount;
 		spin_unlock_irqrestore(&info->slock, flags);
-		p_cuser = (struct serial_icounter_struct *) arg;
+		p_cuser = argp;
 		/* modified by casper 1/11/2000 */
 		if (put_user(cnow.frame, &p_cuser->frame))
 			return -EFAULT;
@@ -1364,7 +1367,7 @@
 /* */
 		return 0;
 	case MOXA_HighSpeedOn:
-		return put_user(info->baud_base != 115200 ? 1 : 0, (int *) arg);
+		return put_user(info->baud_base != 115200 ? 1 : 0, (int __user *) argp);
 
 	case MOXA_SDS_RSTICOUNTER:{
 			info->mon_data.rxcnt = 0;
@@ -1374,13 +1377,13 @@
 // (above) added by James.
 	case MOXA_ASPP_SETBAUD:{
 			long baud;
-			if (get_user(baud, (long *) arg))
+			if (get_user(baud, (long __user *) argp))
 				return -EFAULT;
 			mxser_set_baud(info, baud);
 			return 0;
 		}
 	case MOXA_ASPP_GETBAUD:
-		if (copy_to_user((long *) arg, &info->realbaud, sizeof(long)))
+		if (copy_to_user(argp, &info->realbaud, sizeof(long)))
 			return -EFAULT;
 
 		return 0;
@@ -1394,7 +1397,7 @@
 
 			len += (lsr ? 0 : 1);
 
-			if (copy_to_user((int *) arg, &len, sizeof(int)))
+			if (copy_to_user(argp, &len, sizeof(int)))
 				return -EFAULT;
 
 			return 0;
@@ -1423,7 +1426,7 @@
 				info->mon_data.hold_reason &= ~NPPI_NOTIFY_CTSHOLD;
 
 
-			if (copy_to_user((struct mxser_mon *) arg, &(info->mon_data), sizeof(struct mxser_mon)))
+			if (copy_to_user(argp, &info->mon_data, sizeof(struct mxser_mon)))
 				return -EFAULT;
 
 			return 0;
@@ -1431,7 +1434,7 @@
 		}
 
 	case MOXA_ASPP_LSTATUS:{
-			if (copy_to_user((struct mxser_mon *) arg, &(info->err_shadow), sizeof(unsigned char)))
+			if (copy_to_user(argp, &info->err_shadow, sizeof(unsigned char)))
 				return -EFAULT;
 
 			info->err_shadow = 0;
@@ -1440,10 +1443,10 @@
 		}
 	case MOXA_SET_BAUD_METHOD:{
 			int method;
-			if (get_user(method, (int *) arg))
+			if (get_user(method, (int __user *) argp))
 				return -EFAULT;
 			mxser_set_baud_method[info->port] = method;
-			if (copy_to_user((int *) arg, &method, sizeof(int)))
+			if (copy_to_user(argp, &method, sizeof(int)))
 				return -EFAULT;
 
 			return 0;
@@ -1454,22 +1457,26 @@
 	return 0;
 }
 
-static int mxser_ioctl_special(unsigned int cmd, unsigned long arg)
+#ifndef CMSPAR
+#define	CMSPAR 010000000000
+#endif
+
+static int mxser_ioctl_special(unsigned int cmd, void __user *argp)
 {
 	int i, result, status;
 
 	switch (cmd) {
 	case MOXA_GET_CONF:
-		if (copy_to_user((struct mxser_hwconf *) arg, mxsercfg, sizeof(struct mxser_hwconf) * 4))
+		if (copy_to_user(argp, mxsercfg, sizeof(struct mxser_hwconf) * 4))
 			return -EFAULT;
 		return 0;
 	case MOXA_GET_MAJOR:
-		if (copy_to_user((int *) arg, &ttymajor, sizeof(int)))
+		if (copy_to_user(argp, &ttymajor, sizeof(int)))
 			return -EFAULT;
 		return 0;
 
 	case MOXA_GET_CUMAJOR:
-		if (copy_to_user((int *) arg, &calloutmajor, sizeof(int)))
+		if (copy_to_user(argp, &calloutmajor, sizeof(int)))
 			return -EFAULT;
 		return 0;
 
@@ -1479,9 +1486,9 @@
 			if (mxvar_table[i].base)
 				result |= (1 << i);
 		}
-		return put_user(result, (unsigned long *) arg);
+		return put_user(result, (unsigned long __user *) argp);
 	case MOXA_GETDATACOUNT:
-		if (copy_to_user((struct mxser_log *) arg, &mxvar_log, sizeof(mxvar_log)))
+		if (copy_to_user(argp, &mxvar_log, sizeof(mxvar_log)))
 			return -EFAULT;
 		return (0);
 	case MOXA_GETMSTATUS:
@@ -1516,7 +1523,7 @@
 			else
 				GMStatus[i].cts = 0;
 		}
-		if (copy_to_user((struct mxser_mstatus *) arg, GMStatus, sizeof(struct mxser_mstatus) * MXSER_PORTS))
+		if (copy_to_user(argp, GMStatus, sizeof(struct mxser_mstatus) * MXSER_PORTS))
 			return -EFAULT;
 		return 0;
 	case MOXA_ASPP_MON_EXT:{
@@ -1584,7 +1591,7 @@
 				mon_data_ext.iftype[i] = opmode;
 
 			}
-			if (copy_to_user((struct mxser_mon_ext *) arg, &mon_data_ext, sizeof(struct mxser_mon_ext)))
+			if (copy_to_user(argp, &mon_data_ext, sizeof(struct mxser_mon_ext)))
 				return -EFAULT;
 
 			return 0;
@@ -1829,7 +1836,7 @@
 	info->event = 0;
 	info->count = 0;
 	info->flags &= ~ASYNC_NORMAL_ACTIVE;
-	info->tty = 0;
+	info->tty = NULL;
 	wake_up_interruptible(&info->open_wait);
 }
 
@@ -1866,7 +1873,7 @@
 	int pass_counter = 0;
 	int handled = IRQ_NONE;
 
-	port = 0;
+	port = NULL;
 	//spin_lock(&gm_lock);
 
 	for (i = 0; i < MXSER_BOARDS; i++) {
@@ -2412,7 +2419,7 @@
 	 * and set the speed of the serial port
 	 */
 	spin_unlock_irqrestore(&info->slock, flags);
-	mxser_change_speed(info, 0);
+	mxser_change_speed(info, NULL);
 
 	info->flags |= ASYNC_INITIALIZED;
 	return (0);
@@ -2442,7 +2449,7 @@
 	 */
 	if (info->xmit_buf) {
 		free_page((unsigned long) info->xmit_buf);
-		info->xmit_buf = 0;
+		info->xmit_buf = NULL;
 	}
 
 	info->IER = 0;
@@ -2591,9 +2598,6 @@
 		cval |= 0x04;
 	if (cflag & PARENB)
 		cval |= UART_LCR_PARITY;
-#ifndef CMSPAR
-#define	CMSPAR 010000000000
-#endif
 	if (!(cflag & PARODD)) {
 		cval |= UART_LCR_EPAR;
 	}
@@ -2807,7 +2811,7 @@
  * friends of mxser_ioctl()
  * ------------------------------------------------------------
  */
-static int mxser_get_serial_info(struct mxser_struct *info, struct serial_struct *retinfo)
+static int mxser_get_serial_info(struct mxser_struct *info, struct serial_struct __user *retinfo)
 {
 	struct serial_struct tmp;
 
@@ -2829,7 +2833,7 @@
 	return (0);
 }
 
-static int mxser_set_serial_info(struct mxser_struct *info, struct serial_struct *new_info)
+static int mxser_set_serial_info(struct mxser_struct *info, struct serial_struct __user *new_info)
 {
 	struct serial_struct new_serial;
 	unsigned int flags;
@@ -2869,7 +2873,7 @@
 	/* */
 	if (info->flags & ASYNC_INITIALIZED) {
 		if (flags != (info->flags & ASYNC_SPD_MASK)) {
-			mxser_change_speed(info, 0);
+			mxser_change_speed(info, NULL);
 		}
 	} else {
 		retval = mxser_startup(info);
@@ -2887,7 +2891,7 @@
  *	    transmit holding register is empty.  This functionality
  *	    allows an RS485 driver to be written in user space.
  */
-static int mxser_get_lsr_info(struct mxser_struct *info, unsigned int *value)
+static int mxser_get_lsr_info(struct mxser_struct *info, unsigned int __user *value)
 {
 	unsigned char status;
 	unsigned int result;

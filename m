Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUAMRoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbUAMRoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:44:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33299 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264502AbUAMRmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:42:52 -0500
Date: Tue, 13 Jan 2004 17:42:19 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, digiLinux@dgii.com, acme@conectiva.com.br,
       arobinso@nyx.net, support@moxa.com.tw, christoph@lameter.com,
       pgmdsg@ibi.com, richard@sleepie.demon.co.uk, R.E.Wolff@BitWizard.nl,
       fritz@isdn4linux.de, reginak@cyclades.com, oli@bv.ro, jeff@uclinux.org,
       mleslie@lineo.ca, macro@ds2.pg.gda.pl
Subject: [3/3] 2.6 broken serial drivers
Message-ID: <20040113174219.E7256@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org, digiLinux@dgii.com,
	acme@conectiva.com.br, arobinso@nyx.net, support@moxa.com.tw,
	christoph@lameter.com, pgmdsg@ibi.com, richard@sleepie.demon.co.uk,
	R.E.Wolff@BitWizard.nl, fritz@isdn4linux.de, reginak@cyclades.com,
	oli@bv.ro, jeff@uclinux.org, mleslie@lineo.ca, macro@ds2.pg.gda.pl
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth> <20040113113650.A2975@flint.arm.linux.org.uk> <20040113114948.B2975@flint.arm.linux.org.uk> <20040113171544.B7256@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040113171544.B7256@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Tue, Jan 13, 2004 at 05:15:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch which updates various serial drivers in the kernel to
make them less broken than they were before.  Nevertheless, they are
still broken.

The improvement is to make these drivers use the tiocmget/tiocmset
methods, which are present in the 2.6 kernel.

Many of these have been incorrectly converted from the old global IRQ
locking without regard for SMP issues, or still use the old global IRQ
locking methods which are no longer present in 2.6 kernels.

The full message thread can be found at:

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&threadm=1dvnl-5Pr-1%40gated-at.bofh.it&rnum=1&prev=/groups%3Fhl%3Den%26lr%3D%26ie%3DISO-8859-1%26q%3DOutstanding%2Bfixups%26btnG%3DGoogle%2BSearch%26meta%3Dgroup%253Dlinux.kernel

===== drivers/char/amiserial.c 1.28 vs edited =====
--- 1.28/drivers/char/amiserial.c	Tue Sep 30 01:23:52 2003
+++ edited/drivers/char/amiserial.c	Tue Jan 13 15:30:32 2004
@@ -1248,57 +1248,48 @@
 }
 
 
-static int get_modem_info(struct async_struct * info, unsigned int *value)
+static int rs_tiocmget(struct tty_struct *tty, struct file *file)
 {
+	struct async_struct * info = (struct async_struct *)tty->driver_data;
 	unsigned char control, status;
-	unsigned int result;
 	unsigned long flags;
 
+	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
+		return -ENODEV;
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
+
 	control = info->MCR;
 	local_irq_save(flags);
 	status = ciab.pra;
 	local_irq_restore(flags);
-	result =  ((control & SER_RTS) ? TIOCM_RTS : 0)
+	return    ((control & SER_RTS) ? TIOCM_RTS : 0)
 		| ((control & SER_DTR) ? TIOCM_DTR : 0)
 		| (!(status  & SER_DCD) ? TIOCM_CAR : 0)
 		| (!(status  & SER_DSR) ? TIOCM_DSR : 0)
 		| (!(status  & SER_CTS) ? TIOCM_CTS : 0);
-	if (copy_to_user(value, &result, sizeof(int)))
-		return -EFAULT;
-	return 0;
 }
 
-static int set_modem_info(struct async_struct * info, unsigned int cmd,
-			  unsigned int *value)
+static int rs_tiocmset(struct tty_struct *tty, struct file *file,
+		       unsigned int set, unsigned int clear)
 {
-	unsigned int arg;
+	struct async_struct * info = (struct async_struct *)tty->driver_data;
 	unsigned long flags;
 
-	if (copy_from_user(&arg, value, sizeof(int)))
-		return -EFAULT;
+	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
+		return -ENODEV;
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
 
-	switch (cmd) {
-	case TIOCMBIS: 
-	        if (arg & TIOCM_RTS)
-			info->MCR |= SER_RTS;
-		if (arg & TIOCM_DTR)
-			info->MCR |= SER_DTR;
-		break;
-	case TIOCMBIC:
-	        if (arg & TIOCM_RTS)
-			info->MCR &= ~SER_RTS;
-		if (arg & TIOCM_DTR)
-			info->MCR &= ~SER_DTR;
-		break;
-	case TIOCMSET:
-		info->MCR = ((info->MCR & ~(SER_RTS | SER_DTR))
-			     | ((arg & TIOCM_RTS) ? SER_RTS : 0)
-			     | ((arg & TIOCM_DTR) ? SER_DTR : 0));
-		break;
-	default:
-		return -EINVAL;
-	}
 	local_irq_save(flags);
+	if (set & TIOCM_RTS)
+		info->MCR |= SER_RTS;
+	if (set & TIOCM_DTR)
+		info->MCR |= SER_DTR;
+	if (clear & TIOCM_RTS)
+		info->MCR &= ~SER_RTS;
+	if (clear & TIOCM_DTR)
+		info->MCR &= ~SER_DTR;
 	rtsdtr_ctrl(info->MCR);
 	local_irq_restore(flags);
 	return 0;
@@ -1344,12 +1335,6 @@
 	}
 
 	switch (cmd) {
-		case TIOCMGET:
-			return get_modem_info(info, (unsigned int *) arg);
-		case TIOCMBIS:
-		case TIOCMBIC:
-		case TIOCMSET:
-			return set_modem_info(info, cmd, (unsigned int *) arg);
 		case TIOCGSERIAL:
 			return get_serial_info(info,
 					       (struct serial_struct *) arg);
@@ -2045,6 +2030,8 @@
 	.send_xchar = rs_send_xchar,
 	.wait_until_sent = rs_wait_until_sent,
 	.read_proc = rs_read_proc,
+	.tiocmget = rs_tiocmget,
+	.tiocmset = rs_tiocmset,
 };
 
 /*
===== drivers/char/epca.c 1.32 vs edited =====
--- 1.32/drivers/char/epca.c	Thu Sep 11 23:46:11 2003
+++ edited/drivers/char/epca.c	Tue Jan 13 15:51:58 2004
@@ -2931,6 +2931,96 @@
 }
 /* --------------------- Begin pc_ioctl  ----------------------- */
 
+static int pc_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	struct channel *ch = (struct channel *) tty->driver_data;
+	volatile struct board_chan *bc;
+	unsigned int mstat, mflag = 0;
+	unsigned long flags;
+
+	if (ch)
+		bc = ch->brdchan;
+	else 
+	{
+		printk(KERN_ERR "<Error> - ch is NULL in pc_tiocmget!\n");
+		return(-EINVAL);
+	}
+
+	save_flags(flags);
+	cli();
+	globalwinon(ch);
+	mstat = bc->mstat;
+	memoff(ch);
+	restore_flags(flags);
+
+	if (mstat & ch->m_dtr)
+		mflag |= TIOCM_DTR;
+
+	if (mstat & ch->m_rts)
+		mflag |= TIOCM_RTS;
+
+	if (mstat & ch->m_cts)
+		mflag |= TIOCM_CTS;
+
+	if (mstat & ch->dsr)
+		mflag |= TIOCM_DSR;
+
+	if (mstat & ch->m_ri)
+		mflag |= TIOCM_RI;
+
+	if (mstat & ch->dcd)
+		mflag |= TIOCM_CD;
+
+	return mflag;
+}
+
+static int pc_tiocmset(struct tty_struct *tty, struct file *file,
+		       unsigned int set, unsigned int clear)
+{
+	struct channel *ch = (struct channel *) tty->driver_data;
+	unsigned long flags;
+
+	if (!ch) {
+		printk(KERN_ERR "<Error> - ch is NULL in pc_tiocmset!\n");
+		return(-EINVAL);
+	}
+
+	save_flags(flags);
+	cli();
+	/*
+	 * I think this modemfake stuff is broken.  It doesn't
+	 * correctly reflect the behaviour desired by the TIOCM*
+	 * ioctls.  Therefore this is probably broken.
+	 */
+	if (set & TIOCM_RTS) {
+		ch->modemfake |= ch->m_rts;
+		ch->modem |= ch->m_rts;
+	}
+	if (set & TIOCM_DTR) {
+		ch->modemfake |= ch->m_dtr;
+		ch->modem |= ch->m_dtr;
+	}
+	if (clear & TIOCM_RTS) {
+		ch->modemfake |= ch->m_rts;
+		ch->modem &= ~ch->m_rts;
+	}
+	if (clear & TIOCM_DTR) {
+		ch->modemfake |= ch->m_dtr;
+		ch->modem &= ~ch->m_dtr;
+	}
+
+	globalwinon(ch);
+
+	/*  --------------------------------------------------------------
+		The below routine generally sets up parity, baud, flow control 
+		issues, etc.... It effect both control flags and input flags.
+	------------------------------------------------------------------ */
+
+	epcaparam(tty,ch);
+	memoff(ch);
+	restore_flags(flags);
+}
+
 static int pc_ioctl(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg)
 { /* Begin pc_ioctl */
@@ -3021,90 +3111,15 @@
 		}
 
 		case TIOCMODG:
-		case TIOCMGET:
-
-			mflag = 0;
-
-			cli();
-			globalwinon(ch);
-			mstat = bc->mstat;
-			memoff(ch);
-			restore_flags(flags);
-
-			if (mstat & ch->m_dtr)
-				mflag |= TIOCM_DTR;
-
-			if (mstat & ch->m_rts)
-				mflag |= TIOCM_RTS;
-
-			if (mstat & ch->m_cts)
-				mflag |= TIOCM_CTS;
-
-			if (mstat & ch->dsr)
-				mflag |= TIOCM_DSR;
-
-			if (mstat & ch->m_ri)
-				mflag |= TIOCM_RI;
-
-			if (mstat & ch->dcd)
-				mflag |= TIOCM_CD;
-
-			error = verify_area(VERIFY_WRITE, (void *) arg,sizeof(long));
-
-			if (error)
-				return error;
-
-			putUser(mflag, (unsigned int *) arg);
-
+			mflag = pc_tiocmget(tty, file);
+			if (putUser(mflag, (unsigned int *) arg))
+				return -EFAULT;
 			break;
 
-		case TIOCMBIS:
-		case TIOCMBIC:
 		case TIOCMODS:
-		case TIOCMSET:
-
-			getUser(mstat, (unsigned int *)arg);
-
-			mflag = 0;
-			if (mstat & TIOCM_DTR)
-				mflag |= ch->m_dtr;
-
-			if (mstat & TIOCM_RTS)
-				mflag |= ch->m_rts;
-
-			switch (cmd) 
-			{ /* Begin switch cmd */
-
-				case TIOCMODS:
-				case TIOCMSET:
-					ch->modemfake = ch->m_dtr|ch->m_rts;
-					ch->modem = mflag;
-					break;
-
-				case TIOCMBIS:
-					ch->modemfake |= mflag;
-					ch->modem |= mflag;
-					break;
-
-				case TIOCMBIC:
-					ch->modemfake |= mflag;
-					ch->modem &= ~mflag;
-					break;
-
-			} /* End switch cmd */
-
-			cli();
-			globalwinon(ch);
-
-			/*  --------------------------------------------------------------
-				The below routine generally sets up parity, baud, flow control 
-				issues, etc.... It effect both control flags and input flags.
-			------------------------------------------------------------------ */
-
-			epcaparam(tty,ch);
-			memoff(ch);
-			restore_flags(flags);
-			break;
+			if (getUser(mstat, (unsigned int *)arg))
+				return -EFAULT;
+			return pc_tiocmset(tty, file, mstat, ~mstat);
 
 		case TIOCSDTR:
 			ch->omodem |= ch->m_dtr;
===== drivers/char/esp.c 1.26 vs edited =====
--- 1.26/drivers/char/esp.c	Sun Oct  5 07:51:01 2003
+++ edited/drivers/char/esp.c	Tue Jan 13 15:56:56 2004
@@ -1753,55 +1753,52 @@
 }
 
 
-static int get_modem_info(struct esp_struct * info, unsigned int *value)
+static int esp_tiocmget(struct tty_struct *tty, struct file *file)
 {
+	struct esp_struct * info = (struct esp_struct *)tty->driver_data;
 	unsigned char control, status;
-	unsigned int result;
+
+	if (serial_paranoia_check(info, tty->name, __FUNCTION__))
+		return -ENODEV;
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
 
 	control = info->MCR;
 	cli();
 	serial_out(info, UART_ESI_CMD1, ESI_GET_UART_STAT);
 	status = serial_in(info, UART_ESI_STAT2);
 	sti();
-	result =  ((control & UART_MCR_RTS) ? TIOCM_RTS : 0)
+	return    ((control & UART_MCR_RTS) ? TIOCM_RTS : 0)
 		| ((control & UART_MCR_DTR) ? TIOCM_DTR : 0)
 		| ((status  & UART_MSR_DCD) ? TIOCM_CAR : 0)
 		| ((status  & UART_MSR_RI) ? TIOCM_RNG : 0)
 		| ((status  & UART_MSR_DSR) ? TIOCM_DSR : 0)
 		| ((status  & UART_MSR_CTS) ? TIOCM_CTS : 0);
-	return put_user(result,value);
 }
 
-static int set_modem_info(struct esp_struct * info, unsigned int cmd,
-			  unsigned int *value)
+static int esp_tiocmset(struct tty_struct *tty, struct file *file,
+			unsigned int set, unsigned int clear)
 {
+	struct esp_struct * info = (struct esp_struct *)tty->driver_data;
 	unsigned int arg;
 
-	if (get_user(arg, value))
-		return -EFAULT;
+	if (serial_paranoia_check(info, tty->name, __FUNCTION__))
+		return -ENODEV;
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
 
-	switch (cmd) {
-	case TIOCMBIS: 
-		if (arg & TIOCM_RTS)
-			info->MCR |= UART_MCR_RTS;
-		if (arg & TIOCM_DTR)
-			info->MCR |= UART_MCR_DTR;
-		break;
-	case TIOCMBIC:
-		if (arg & TIOCM_RTS)
-			info->MCR &= ~UART_MCR_RTS;
-		if (arg & TIOCM_DTR)
-			info->MCR &= ~UART_MCR_DTR;
-		break;
-	case TIOCMSET:
-		info->MCR = ((info->MCR & ~(UART_MCR_RTS | UART_MCR_DTR))
-			     | ((arg & TIOCM_RTS) ? UART_MCR_RTS : 0)
-			     | ((arg & TIOCM_DTR) ? UART_MCR_DTR : 0));
-		break;
-	default:
-		return -EINVAL;
-	}
 	cli();
+
+	if (set & TIOCM_RTS)
+		info->MCR |= UART_MCR_RTS;
+	if (set & TIOCM_DTR)
+		info->MCR |= UART_MCR_DTR;
+
+	if (clear & TIOCM_RTS)
+		info->MCR &= ~UART_MCR_RTS;
+	if (clear & TIOCM_DTR)
+		info->MCR &= ~UART_MCR_DTR;
+
 	serial_out(info, UART_ESI_CMD1, ESI_WRITE_UART);
 	serial_out(info, UART_ESI_CMD2, UART_MCR);
 	serial_out(info, UART_ESI_CMD2, info->MCR);
@@ -1853,12 +1850,6 @@
 	}
 	
 	switch (cmd) {
-		case TIOCMGET:
-			return get_modem_info(info, (unsigned int *) arg);
-		case TIOCMBIS:
-		case TIOCMBIC:
-		case TIOCMSET:
-			return set_modem_info(info, cmd, (unsigned int *) arg);
 		case TIOCGSERIAL:
 			return get_serial_info(info,
 					       (struct serial_struct *) arg);
@@ -2444,6 +2435,8 @@
 	.hangup = esp_hangup,
 	.break_ctl = esp_break,
 	.wait_until_sent = rs_wait_until_sent,
+	.tiocmget = esp_tiocmget,
+	.tiocmset = esp_tiocmset,
 };
 
 /*
===== drivers/char/isicom.c 1.27 vs edited =====
--- 1.27/drivers/char/isicom.c	Sun Oct  5 07:51:01 2003
+++ edited/drivers/char/isicom.c	Tue Jan 13 13:48:05 2004
@@ -1291,63 +1291,44 @@
 out:	restore_flags(flags);
 }
 
-static int isicom_get_modem_info(struct isi_port * port, unsigned int * value)
+static int isicom_tiocmget(struct tty_struct *tty, struct file *file)
 {
+	struct isi_port * port = (struct isi_port *) tty->driver_data;
 	/* just send the port status */
-	unsigned int info;
 	unsigned short status = port->status;
+
+	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
+		return -ENODEV;
 	
-	info =  ((status & ISI_RTS) ? TIOCM_RTS : 0) |
+	return  ((status & ISI_RTS) ? TIOCM_RTS : 0) |
 		((status & ISI_DTR) ? TIOCM_DTR : 0) |
 		((status & ISI_DCD) ? TIOCM_CAR : 0) |
 		((status & ISI_DSR) ? TIOCM_DSR : 0) |
 		((status & ISI_CTS) ? TIOCM_CTS : 0) |
 		((status & ISI_RI ) ? TIOCM_RI  : 0);
-	return put_user(info, (unsigned int *) value);
 }
 
-static int isicom_set_modem_info(struct isi_port * port, unsigned int cmd,
-					unsigned int * value)
+static int isicom_tiocmset(struct tty_struct *tty, struct file *file,
+			   unsigned int set, unsigned int clear)
 {
+	struct isi_port * port = (struct isi_port *) tty->driver_data;
 	unsigned int arg;
 	unsigned long flags;
 	
-	if(get_user(arg, value))
-		return -EFAULT;
+	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
+		return -ENODEV;
 	
 	save_flags(flags); cli();
-	
-	switch(cmd) {
-		case TIOCMBIS:
-			if (arg & TIOCM_RTS) 
-				raise_rts(port);
-			if (arg & TIOCM_DTR) 
-				raise_dtr(port);
-			break;
-		
-		case TIOCMBIC:
-			if (arg & TIOCM_RTS)
-				drop_rts(port);
-			if (arg & TIOCM_DTR)
-				drop_dtr(port);	
-			break;
-			
-		case TIOCMSET:
-			if (arg & TIOCM_RTS)
-				raise_rts(port);
-			else
-				drop_rts(port);
-			
-			if (arg & TIOCM_DTR)
-				raise_dtr(port);
-			else
-				drop_dtr(port);
-			break;
-		
-		default:
-			restore_flags(flags);
-			return -EINVAL;		 	
-	}
+	if (set & TIOCM_RTS) 
+		raise_rts(port);
+	if (set & TIOCM_DTR) 
+		raise_dtr(port);
+
+	if (clear & TIOCM_RTS)
+		drop_rts(port);
+	if (clear & TIOCM_DTR)
+		drop_dtr(port);	
+
 	restore_flags(flags);
 	return 0;
 }			
@@ -1445,15 +1426,6 @@
 				(arg ? CLOCAL : 0));
 			return 0;	
 			
-		case TIOCMGET:
-			return isicom_get_modem_info(port, (unsigned int*) arg);
-			
-		case TIOCMBIS:
-		case TIOCMBIC:
-		case TIOCMSET: 	
-			return isicom_set_modem_info(port, cmd, 
-					(unsigned int *) arg);
-		
 		case TIOCGSERIAL:
 			return isicom_get_serial_info(port, 
 					(struct serial_struct *) arg);
@@ -1640,6 +1612,8 @@
 	.start	= isicom_start,
 	.hangup	= isicom_hangup,
 	.flush_buffer	= isicom_flush_buffer,
+	.tiocmget	= isicom_tiocmget,
+	.tiocmset	= isicom_tiocmset,
 };
 
 static int register_drivers(void)
===== drivers/char/moxa.c 1.27 vs edited =====
--- 1.27/drivers/char/moxa.c	Tue Sep 30 01:23:52 2003
+++ edited/drivers/char/moxa.c	Tue Jan 13 16:18:08 2004
@@ -231,6 +231,9 @@
 static void moxa_stop(struct tty_struct *);
 static void moxa_start(struct tty_struct *);
 static void moxa_hangup(struct tty_struct *);
+static int moxa_tiocmget(struct tty_struct *tty, struct file *file);
+static int moxa_tiocmset(struct tty_struct *tty, struct file *file,
+			 unsigned int set, unsigned int clear);
 static void moxa_poll(unsigned long);
 static void set_tty_param(struct tty_struct *);
 static int block_till_ready(struct tty_struct *, struct file *,
@@ -288,6 +291,8 @@
 	.stop = moxa_stop,
 	.start = moxa_start,
 	.hangup = moxa_hangup,
+	.tiocmget = moxa_tiocmget,
+	.tiocmset = moxa_tiocmset,
 };
 
 static int __init moxa_init(void)
@@ -741,6 +746,53 @@
 	ch->statusflags |= LOWWAIT;
 }
 
+static int moxa_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	struct moxa_str *ch = (struct moxa_str *) tty->driver_data;
+	int flag = 0, dtr, rts;
+
+	port = PORTNO(tty);
+	if ((port != MAX_PORTS) && (!ch))
+		return (-EINVAL);
+
+	MoxaPortGetLineOut(ch->port, &dtr, &rts);
+	if (dtr)
+		flag |= TIOCM_DTR;
+	if (rts)
+		flag |= TIOCM_RTS;
+	dtr = MoxaPortLineStatus(ch->port);
+	if (dtr & 1)
+		flag |= TIOCM_CTS;
+	if (dtr & 2)
+		flag |= TIOCM_DSR;
+	if (dtr & 4)
+		flag |= TIOCM_CD;
+	return flag;
+}
+
+static int moxa_tiocmset(struct tty_struct *tty, struct file *file,
+			 unsigned int set, unsigned int clear)
+{
+	struct moxa_str *ch = (struct moxa_str *) tty->driver_data;
+	int flag = 0, dtr, rts;
+
+	port = PORTNO(tty);
+	if ((port != MAX_PORTS) && (!ch))
+		return (-EINVAL);
+
+	MoxaPortGetLineOut(ch->port, &dtr, &rts);
+	if (set & TIOCM_RTS)
+		rts = 1;
+	if (set & TIOCM_DTR)
+		dtr = 1;
+	if (clear & TIOCM_RTS)
+		rts = 0;
+	if (clear & TIOCM_DTR)
+		dtr = 0;
+	MoxaPortLineCtrl(ch->port, dtr, rts);
+	return 0;
+}
+
 static int moxa_ioctl(struct tty_struct *tty, struct file *file,
 		      unsigned int cmd, unsigned long arg)
 {
@@ -783,51 +835,6 @@
 			ch->asyncflags &= ~ASYNC_CHECK_CD;
 		else
 			ch->asyncflags |= ASYNC_CHECK_CD;
-		return (0);
-	case TIOCMGET:
-		flag = 0;
-		MoxaPortGetLineOut(ch->port, &dtr, &rts);
-		if (dtr)
-			flag |= TIOCM_DTR;
-		if (rts)
-			flag |= TIOCM_RTS;
-		dtr = MoxaPortLineStatus(ch->port);
-		if (dtr & 1)
-			flag |= TIOCM_CTS;
-		if (dtr & 2)
-			flag |= TIOCM_DSR;
-		if (dtr & 4)
-			flag |= TIOCM_CD;
-		return put_user(flag, (unsigned int *) arg);
-	case TIOCMBIS:
-		if(get_user(retval, (unsigned int *) arg))
-			return -EFAULT;
-		MoxaPortGetLineOut(ch->port, &dtr, &rts);
-		if (retval & TIOCM_RTS)
-			rts = 1;
-		if (retval & TIOCM_DTR)
-			dtr = 1;
-		MoxaPortLineCtrl(ch->port, dtr, rts);
-		return (0);
-	case TIOCMBIC:
-		if(get_user(retval, (unsigned int *) arg))
-			return -EFAULT;
-		MoxaPortGetLineOut(ch->port, &dtr, &rts);
-		if (retval & TIOCM_RTS)
-			rts = 0;
-		if (retval & TIOCM_DTR)
-			dtr = 0;
-		MoxaPortLineCtrl(ch->port, dtr, rts);
-		return (0);
-	case TIOCMSET:
-		if(get_user(retval, (unsigned long *) arg))
-			return -EFAULT;
-		dtr = rts = 0;
-		if (retval & TIOCM_RTS)
-			rts = 1;
-		if (retval & TIOCM_DTR)
-			dtr = 1;
-		MoxaPortLineCtrl(ch->port, dtr, rts);
 		return (0);
 	case TIOCGSERIAL:
 		return (moxa_get_serial_info(ch, (struct serial_struct *) arg));
===== drivers/char/mxser.c 1.29 vs edited =====
--- 1.29/drivers/char/mxser.c	Tue Sep 30 01:23:52 2003
+++ edited/drivers/char/mxser.c	Tue Jan 13 16:23:48 2004
@@ -349,8 +349,8 @@
 static int mxser_set_serial_info(struct mxser_struct *, struct serial_struct *);
 static int mxser_get_lsr_info(struct mxser_struct *, unsigned int *);
 static void mxser_send_break(struct mxser_struct *, int);
-static int mxser_get_modem_info(struct mxser_struct *, unsigned int *);
-static int mxser_set_modem_info(struct mxser_struct *, unsigned int, unsigned int *);
+static int mxser_tiocmget(struct tty_struct *, struct file *);
+static int mxser_tiocmset(struct tty_struct *, struct file *, unsigned int, unsigned int);
 
 /*
  * The MOXA C168/C104 serial driver boot-time initialization code!
@@ -491,6 +491,8 @@
 	.stop = mxser_stop,
 	.start = mxser_start,
 	.hangup = mxser_hangup,
+	.tiocmget = mxser_tiocmget,
+	.tiocmset = mxser_tiocmset,
 };
 
 static int __init mxser_module_init(void)
@@ -1009,12 +1011,6 @@
 		tty->termios->c_cflag = ((tty->termios->c_cflag & ~CLOCAL) |
 					 (arg ? CLOCAL : 0));
 		return (0);
-	case TIOCMGET:
-		return (mxser_get_modem_info(info, (unsigned int *) arg));
-	case TIOCMBIS:
-	case TIOCMBIC:
-	case TIOCMSET:
-		return (mxser_set_modem_info(info, cmd, (unsigned int *) arg));
 	case TIOCGSERIAL:
 		return (mxser_get_serial_info(info, (struct serial_struct *) arg));
 	case TIOCSSERIAL:
@@ -2150,13 +2146,18 @@
 	restore_flags(flags);
 }
 
-static int mxser_get_modem_info(struct mxser_struct *info,
-				unsigned int *value)
+static int mxser_tiocmget(struct tty_struct *tty, struct file *file)
 {
+	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
 	unsigned char control, status;
 	unsigned int result;
 	unsigned long flags;
 
+	if (PORTNO(tty) == MXSER_PORTS)
+		return (-ENOIOCTLCMD);
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return (-EIO);
+
 	control = info->MCR;
 	save_flags(flags);
 	cli();
@@ -2164,46 +2165,38 @@
 	if (status & UART_MSR_ANY_DELTA)
 		mxser_check_modem_status(info, status);
 	restore_flags(flags);
-	result = ((control & UART_MCR_RTS) ? TIOCM_RTS : 0) |
+	return ((control & UART_MCR_RTS) ? TIOCM_RTS : 0) |
 	    ((control & UART_MCR_DTR) ? TIOCM_DTR : 0) |
 	    ((status & UART_MSR_DCD) ? TIOCM_CAR : 0) |
 	    ((status & UART_MSR_RI) ? TIOCM_RNG : 0) |
 	    ((status & UART_MSR_DSR) ? TIOCM_DSR : 0) |
 	    ((status & UART_MSR_CTS) ? TIOCM_CTS : 0);
-	return put_user(result, value);
 }
 
-static int mxser_set_modem_info(struct mxser_struct *info, unsigned int cmd,
-				unsigned int *value)
+static int mxser_tiocmset(struct tty_struct *tty, struct file *file,
+			  unsigned int set, unsigned int clear)
 {
+	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
 	unsigned int arg;
 	unsigned long flags;
 
-	if(get_user(arg, value))
-		return -EFAULT;
-	switch (cmd) {
-	case TIOCMBIS:
-		if (arg & TIOCM_RTS)
-			info->MCR |= UART_MCR_RTS;
-		if (arg & TIOCM_DTR)
-			info->MCR |= UART_MCR_DTR;
-		break;
-	case TIOCMBIC:
-		if (arg & TIOCM_RTS)
-			info->MCR &= ~UART_MCR_RTS;
-		if (arg & TIOCM_DTR)
-			info->MCR &= ~UART_MCR_DTR;
-		break;
-	case TIOCMSET:
-		info->MCR = ((info->MCR & ~(UART_MCR_RTS | UART_MCR_DTR)) |
-			     ((arg & TIOCM_RTS) ? UART_MCR_RTS : 0) |
-			     ((arg & TIOCM_DTR) ? UART_MCR_DTR : 0));
-		break;
-	default:
-		return (-EINVAL);
-	}
+	if (PORTNO(tty) == MXSER_PORTS)
+		return (-ENOIOCTLCMD);
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return (-EIO);
+
 	save_flags(flags);
 	cli();
+	if (set & TIOCM_RTS)
+		info->MCR |= UART_MCR_RTS;
+	if (set & TIOCM_DTR)
+		info->MCR |= UART_MCR_DTR;
+
+	if (clear & TIOCM_RTS)
+		info->MCR &= ~UART_MCR_RTS;
+	if (clear & TIOCM_DTR)
+		info->MCR &= ~UART_MCR_DTR;
+
 	outb(info->MCR, info->base + UART_MCR);
 	restore_flags(flags);
 	return (0);
===== drivers/char/pcxx.c 1.22 vs edited =====
--- 1.22/drivers/char/pcxx.c	Tue Sep 30 01:23:52 2003
+++ edited/drivers/char/pcxx.c	Tue Jan 13 16:35:47 2004
@@ -173,6 +173,9 @@
 static inline void memoff(struct channel *ch);
 static inline void assertgwinon(struct channel *ch);
 static inline void assertmemoff(struct channel *ch);
+static int pcxe_tiocmget(struct tty_struct *tty, struct file *file);
+static int pcxe_tiocmset(struct tty_struct *tty, struct file *file,
+			 unsigned int set, unsigned int clear);
 
 #define TZ_BUFSZ 4096
 
@@ -1029,6 +1032,8 @@
 	.stop = pcxe_stop,
 	.start = pcxe_start,
 	.hangup = pcxe_hangup,
+	.tiocmget = pcxe_tiocmget,
+	.tiocmset = pcxe_tiocmset,
 };
 
 /*
@@ -1983,6 +1988,89 @@
 }
 
 
+static int pcxe_tiocmget(struct tty_struct *tty, struct file *file)
+{
+	struct channel *ch = (struct channel *) tty->driver_data;
+	volatile struct board_chan *bc;
+	unsigned long flags;
+	int mflag = 0;
+
+	if(ch)
+		bc = ch->brdchan;
+	else {
+		printk("ch is NULL in %s!\n", __FUNCTION__);
+		return(-EINVAL);
+	}
+
+	save_flags(flags);
+	cli();
+	globalwinon(ch);
+	mstat = bc->mstat;
+	memoff(ch);
+	restore_flags(flags);
+
+	if(mstat & DTR)
+		mflag |= TIOCM_DTR;
+	if(mstat & RTS)
+		mflag |= TIOCM_RTS;
+	if(mstat & CTS)
+		mflag |= TIOCM_CTS;
+	if(mstat & ch->dsr)
+		mflag |= TIOCM_DSR;
+	if(mstat & RI)
+		mflag |= TIOCM_RI;
+	if(mstat & ch->dcd)
+		mflag |= TIOCM_CD;
+
+	return mflag;
+}
+
+
+static int pcxe_tiocmset(struct tty_struct *tty, struct file *file,
+			 unsigned int set, unsigned int clear)
+{
+	struct channel *ch = (struct channel *) tty->driver_data;
+	volatile struct board_chan *bc;
+	unsigned long flags;
+
+	if(ch)
+		bc = ch->brdchan;
+	else {
+		printk("ch is NULL in %s!\n", __FUNCTION__);
+		return(-EINVAL);
+	}
+
+	save_flags(flags);
+	cli();
+	/*
+	 * I think this modemfake stuff is broken.  It doesn't
+	 * correctly reflect the behaviour desired by the TIOCM*
+	 * ioctls.  Therefore this is probably broken.
+	 */
+	if (set & TIOCM_DTR) {
+		ch->modemfake |= DTR;
+		ch->modem |= DTR;
+	}
+	if (set & TIOCM_RTS) {
+		ch->modemfake |= RTS;
+		ch->modem |= RTS;
+	}
+
+	if (clear & TIOCM_DTR) {
+		ch->modemfake |= DTR;
+		ch->modem &= ~DTR;
+	}
+	if (clear & TIOCM_RTS) {
+		ch->modemfake |= RTS;
+		ch->modem &= ~RTS;
+	}
+	globalwinon(ch);
+	pcxxparam(tty,ch);
+	memoff(ch);
+	restore_flags(flags);
+}
+
+
 static int pcxe_ioctl(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg)
 {
@@ -2036,69 +2124,15 @@
 			return 0;
 
 		case TIOCMODG:
-		case TIOCMGET:
-			mflag = 0;
-
-			cli();
-			globalwinon(ch);
-			mstat = bc->mstat;
-			memoff(ch);
-			restore_flags(flags);
-
-			if(mstat & DTR)
-				mflag |= TIOCM_DTR;
-			if(mstat & RTS)
-				mflag |= TIOCM_RTS;
-			if(mstat & CTS)
-				mflag |= TIOCM_CTS;
-			if(mstat & ch->dsr)
-				mflag |= TIOCM_DSR;
-			if(mstat & RI)
-				mflag |= TIOCM_RI;
-			if(mstat & ch->dcd)
-				mflag |= TIOCM_CD;
-
+			mflag = pcxe_tiocmget(tty, file);
 			if (put_user(mflag, (unsigned int *) arg))
 				return -EFAULT;
 			break;
 
-		case TIOCMBIS:
-		case TIOCMBIC:
 		case TIOCMODS:
-		case TIOCMSET:
 			if (get_user(mstat, (unsigned int *) arg))
 				return -EFAULT;
-
-			mflag = 0;
-			if(mstat & TIOCM_DTR)
-				mflag |= DTR;
-			if(mstat & TIOCM_RTS)
-				mflag |= RTS;
-
-			switch(cmd) {
-				case TIOCMODS:
-				case TIOCMSET:
-					ch->modemfake = DTR|RTS;
-					ch->modem = mflag;
-					break;
-
-				case TIOCMBIS:
-					ch->modemfake |= mflag;
-					ch->modem |= mflag;
-					break;
-
-				case TIOCMBIC:
-					ch->modemfake &= ~mflag;
-					ch->modem &= ~mflag;
-					break;
-			}
-
-			cli();
-			globalwinon(ch);
-			pcxxparam(tty,ch);
-			memoff(ch);
-			restore_flags(flags);
-			break;
+			return pcxe_tiocmset(tty, file, mstat, ~mstat);
 
 		case TIOCSDTR:
 			cli();
===== drivers/char/riscom8.c 1.23 vs edited =====
--- 1.23/drivers/char/riscom8.c	Thu Sep  4 07:39:56 2003
+++ edited/drivers/char/riscom8.c	Tue Jan 13 16:27:00 2004
@@ -1306,59 +1306,53 @@
 		(tty->ldisc.write_wakeup)(tty);
 }
 
-static int rc_get_modem_info(struct riscom_port * port, unsigned int *value)
+static int rc_tiocmget(struct tty_struct *tty, struct file *file)
 {
+	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
 	struct riscom_board * bp;
 	unsigned char status;
-	unsigned int result;
 	unsigned long flags;
 
+	if (rc_paranoia_check(port, tty->name, __FUNCTION__))
+		return -ENODEV;
+
 	bp = port_Board(port);
 	save_flags(flags); cli();
 	rc_out(bp, CD180_CAR, port_No(port));
 	status = rc_in(bp, CD180_MSVR);
 	result = rc_in(bp, RC_RI) & (1u << port_No(port)) ? 0 : TIOCM_RNG;
 	restore_flags(flags);
-	result |= ((status & MSVR_RTS) ? TIOCM_RTS : 0)
+	return    ((status & MSVR_RTS) ? TIOCM_RTS : 0)
 		| ((status & MSVR_DTR) ? TIOCM_DTR : 0)
 		| ((status & MSVR_CD)  ? TIOCM_CAR : 0)
 		| ((status & MSVR_DSR) ? TIOCM_DSR : 0)
 		| ((status & MSVR_CTS) ? TIOCM_CTS : 0);
-	return put_user(result, value);
 }
 
-static int rc_set_modem_info(struct riscom_port * port, unsigned int cmd,
-			     unsigned int *value)
+static int rc_tiocmset(struct tty_struct *tty, struct file *file,
+		       unsigned int set, unsigned int clear)
 {
+	struct riscom_port *port = (struct riscom_port *)tty->driver_data;
 	unsigned int arg;
 	unsigned long flags;
-	struct riscom_board *bp = port_Board(port);
+	struct riscom_board *bp;
+
+	if (rc_paranoia_check(port, tty->name, __FUNCTION__))
+		return -ENODEV;
+
+	bp = port_Board(port);
 
-	if (get_user(arg, value))
-		return -EFAULT;
-	switch (cmd) {
-	 case TIOCMBIS: 
-		if (arg & TIOCM_RTS) 
-			port->MSVR |= MSVR_RTS;
-		if (arg & TIOCM_DTR)
-			bp->DTR &= ~(1u << port_No(port));
-		break;
-	case TIOCMBIC:
-		if (arg & TIOCM_RTS)
-			port->MSVR &= ~MSVR_RTS;
-		if (arg & TIOCM_DTR)
-			bp->DTR |= (1u << port_No(port));
-		break;
-	case TIOCMSET:
-		port->MSVR = (arg & TIOCM_RTS) ? (port->MSVR | MSVR_RTS) : 
-					         (port->MSVR & ~MSVR_RTS);
-		bp->DTR = arg & TIOCM_DTR ? (bp->DTR &= ~(1u << port_No(port))) :
-					    (bp->DTR |=  (1u << port_No(port)));
-		break;
-	 default:
-		return -EINVAL;
-	}
 	save_flags(flags); cli();
+	if (set & TIOCM_RTS) 
+		port->MSVR |= MSVR_RTS;
+	if (set & TIOCM_DTR)
+		bp->DTR &= ~(1u << port_No(port));
+
+	if (clear & TIOCM_RTS)
+		port->MSVR &= ~MSVR_RTS;
+	if (clear & TIOCM_DTR)
+		bp->DTR |= (1u << port_No(port));
+
 	rc_out(bp, CD180_CAR, port_No(port));
 	rc_out(bp, CD180_MSVR, port->MSVR);
 	rc_out(bp, RC_DTR, bp->DTR);
@@ -1485,12 +1479,6 @@
 			((tty->termios->c_cflag & ~CLOCAL) |
 			(arg ? CLOCAL : 0));
 		break;
-	 case TIOCMGET:
-		return rc_get_modem_info(port, (unsigned int *) arg);
-	 case TIOCMBIS:
-	 case TIOCMBIC:
-	 case TIOCMSET:
-		return rc_set_modem_info(port, cmd, (unsigned int *) arg);
 	 case TIOCGSERIAL:	
 		return rc_get_serial_info(port, (struct serial_struct *) arg);
 	 case TIOCSSERIAL:	
@@ -1677,6 +1665,8 @@
 	.stop = rc_stop,
 	.start = rc_start,
 	.hangup = rc_hangup,
+	.tiocmget = rc_tiocmget,
+	.tiocmset = rx_tiocmset,
 };
 
 static inline int rc_init_drivers(void)
===== drivers/char/serial167.c 1.31 vs edited =====
--- 1.31/drivers/char/serial167.c	Tue Sep 30 01:23:52 2003
+++ edited/drivers/char/serial167.c	Tue Jan 13 15:22:11 2004
@@ -1492,8 +1492,9 @@
 } /* set_serial_info */
 
 static int
-get_modem_info(struct cyclades_port * info, unsigned int *value)
+cy_tiocmget(struct tty_struct *tty, struct file *file)
 {
+  struct cyclades_port * info = (struct cyclades_port *)tty->driver_data;
   int channel;
   volatile unsigned char *base_addr = (u_char *)BASE_ADDR;
   unsigned long flags;
@@ -1507,36 +1508,32 @@
         status = base_addr[CyMSVR1] | base_addr[CyMSVR2];
     local_irq_restore(flags);
 
-    result =  ((status  & CyRTS) ? TIOCM_RTS : 0)
+    return    ((status  & CyRTS) ? TIOCM_RTS : 0)
             | ((status  & CyDTR) ? TIOCM_DTR : 0)
             | ((status  & CyDCD) ? TIOCM_CAR : 0)
             | ((status  & CyDSR) ? TIOCM_DSR : 0)
             | ((status  & CyCTS) ? TIOCM_CTS : 0);
-    return put_user(result,(unsigned int *) value);
-} /* get_modem_info */
+} /* cy_tiocmget */
 
 static int
-set_modem_info(struct cyclades_port * info, unsigned int cmd,
-                          unsigned int *value)
+cy_tiocmset(struct tty_struct *tty, struct file *file,
+	    unsigned int set, unsigned int clear)
 {
+  struct cyclades_port * info = (struct cyclades_port *)tty->driver_data;
   int channel;
   volatile unsigned char *base_addr = (u_char *)BASE_ADDR;
   unsigned long flags;
   unsigned int arg;
 	  
-    if (get_user(arg, (unsigned long *) value))
-	return -EFAULT;
     channel = info->line;
 
-    switch (cmd) {
-    case TIOCMBIS:
-	if (arg & TIOCM_RTS){
+	if (set & TIOCM_RTS){
 	    local_irq_save(flags);
 		base_addr[CyCAR] = (u_char)channel;
 		base_addr[CyMSVR1] = CyRTS;
 	    local_irq_restore(flags);
 	}
-	if (arg & TIOCM_DTR){
+	if (set & TIOCM_DTR){
 	    local_irq_save(flags);
 	    base_addr[CyCAR] = (u_char)channel;
 /* CP('S');CP('2'); */
@@ -1547,15 +1544,14 @@
 #endif
 	    local_irq_restore(flags);
 	}
-	break;
-    case TIOCMBIC:
-	if (arg & TIOCM_RTS){
+
+	if (clear & TIOCM_RTS){
 	    local_irq_save(flags);
 		base_addr[CyCAR] = (u_char)channel;
 		base_addr[CyMSVR1] = 0;
 	    local_irq_restore(flags);
 	}
-	if (arg & TIOCM_DTR){
+	if (clear & TIOCM_DTR){
 	    local_irq_save(flags);
 	    base_addr[CyCAR] = (u_char)channel;
 /* CP('C');CP('2'); */
@@ -1566,44 +1562,7 @@
 #endif
 	    local_irq_restore(flags);
 	}
-	break;
-    case TIOCMSET:
-	if (arg & TIOCM_RTS){
-	    local_irq_save(flags);
-		base_addr[CyCAR] = (u_char)channel;
-		base_addr[CyMSVR1] = CyRTS;
-	    local_irq_restore(flags);
-	}else{
-	    local_irq_save(flags);
-		base_addr[CyCAR] = (u_char)channel;
-		base_addr[CyMSVR1] = 0;
-	    local_irq_restore(flags);
-	}
-	if (arg & TIOCM_DTR){
-	    local_irq_save(flags);
-	    base_addr[CyCAR] = (u_char)channel;
-/* CP('S');CP('3'); */
-	    base_addr[CyMSVR2] = CyDTR;
-#ifdef SERIAL_DEBUG_DTR
-            printk("cyc: %d: raising DTR\n", __LINE__);
-            printk("     status: 0x%x, 0x%x\n", base_addr[CyMSVR1], base_addr[CyMSVR2]);
-#endif
-	    local_irq_restore(flags);
-	}else{
-	    local_irq_save(flags);
-	    base_addr[CyCAR] = (u_char)channel;
-/* CP('C');CP('3'); */
-	    base_addr[CyMSVR2] = 0;
-#ifdef SERIAL_DEBUG_DTR
-            printk("cyc: %d: dropping DTR\n", __LINE__);
-            printk("     status: 0x%x, 0x%x\n", base_addr[CyMSVR1], base_addr[CyMSVR2]);
-#endif
-	    local_irq_restore(flags);
-	}
-	break;
-    default:
-		return -EINVAL;
-        }
+
     return 0;
 } /* set_modem_info */
 
@@ -1777,11 +1736,6 @@
             tty_wait_until_sent(tty,0);
             send_break(info, arg ? arg*(HZ/10) : HZ/4);
             break;
-        case TIOCMBIS:
-        case TIOCMBIC:
-        case TIOCMSET:
-            ret_val = set_modem_info(info, cmd, (unsigned int *) arg);
-            break;
 
 /* The following commands are incompletely implemented!!! */
         case TIOCGSOFTCAR:
@@ -1794,9 +1748,6 @@
             tty->termios->c_cflag =
                     ((tty->termios->c_cflag & ~CLOCAL) | (val ? CLOCAL : 0));
             break;
-        case TIOCMGET:
-            ret_val = get_modem_info(info, (unsigned int *) arg);
-            break;
         case TIOCGSERIAL:
             ret_val = get_serial_info(info, (struct serial_struct *) arg);
             break;
@@ -2299,6 +2250,8 @@
 	.stop = cy_stop,
 	.start = cy_start,
 	.hangup = cy_hangup,
+	.tiocmget = cy_tiocmget,
+	.tiocmset = cy_tiocmset,
 };
 /* The serial driver boot-time initialization code!
     Hardware I/O ports are mapped to character special devices on a
===== drivers/char/specialix.c 1.26 vs edited =====
--- 1.26/drivers/char/specialix.c	Wed Sep 24 07:15:15 2003
+++ edited/drivers/char/specialix.c	Tue Jan 13 15:14:59 2004
@@ -1652,13 +1652,17 @@
 }
 
 
-static int sx_get_modem_info(struct specialix_port * port, unsigned int *value)
+static int sx_tiocmget(struct tty_struct *tty, struct file *file)
 {
+	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 	struct specialix_board * bp;
 	unsigned char status;
 	unsigned int result;
 	unsigned long flags;
 
+	if (sx_paranoia_check(port, tty->name, __FUNCTION__))
+		return -ENODEV;
+
 	bp = port_Board(port);
 	save_flags(flags); cli();
 	sx_out(bp, CD186x_CAR, port_No(port));
@@ -1682,71 +1686,51 @@
 		          |/* ((status & MSVR_DSR) ? */ TIOCM_DSR /* : 0) */
 		          |   ((status & MSVR_CTS) ? TIOCM_CTS : 0);
 	}
-	put_user(result,(unsigned int *) value);
-	return 0;
+
+	return result;
 }
 
 
-static int sx_set_modem_info(struct specialix_port * port, unsigned int cmd,
-                             unsigned int *value)
+static int sx_tiocmset(struct tty_struct *tty, struct file *file,
+		       unsigned int set, unsigned int clear)
 {
+	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 	int error;
 	unsigned int arg;
 	unsigned long flags;
-	struct specialix_board *bp = port_Board(port);
+	struct specialix_board *bp;
 
-	error = verify_area(VERIFY_READ, value, sizeof(int));
-	if (error) 
-		return error;
+	if (sx_paranoia_check(port, tty->name, __FUNCTION__))
+		return -ENODEV;
+
+	bp = port_Board(port);
 
-	get_user(arg, (unsigned long *) value);
-	switch (cmd) {
-	case TIOCMBIS: 
-	   /*	if (arg & TIOCM_RTS) 
-			port->MSVR |= MSVR_RTS; */
-	   /*   if (arg & TIOCM_DTR)
-			port->MSVR |= MSVR_DTR; */
-
-		if (SX_CRTSCTS(port->tty)) {
-			if (arg & TIOCM_RTS)
-				port->MSVR |= MSVR_DTR; 
-		} else {
-			if (arg & TIOCM_DTR)
-				port->MSVR |= MSVR_DTR; 
-		}	     
-		break;
-	case TIOCMBIC:
-	  /*	if (arg & TIOCM_RTS)
-			port->MSVR &= ~MSVR_RTS; */
-	  /*    if (arg & TIOCM_DTR)
-			port->MSVR &= ~MSVR_DTR; */
-		if (SX_CRTSCTS(port->tty)) {
-			if (arg & TIOCM_RTS)
-				port->MSVR &= ~MSVR_DTR;
-		} else {
-			if (arg & TIOCM_DTR)
-				port->MSVR &= ~MSVR_DTR;
-		}
-		break;
-	case TIOCMSET:
-	  /* port->MSVR = (arg & TIOCM_RTS) ? (port->MSVR | MSVR_RTS) : 
-						 (port->MSVR & ~MSVR_RTS); */
-	  /* port->MSVR = (arg & TIOCM_DTR) ? (port->MSVR | MSVR_DTR) : 
-						 (port->MSVR & ~MSVR_DTR); */
-		if (SX_CRTSCTS(port->tty)) {
-	  		port->MSVR = (arg & TIOCM_RTS) ? 
-			                         (port->MSVR |  MSVR_DTR) : 
-			                         (port->MSVR & ~MSVR_DTR);
-		} else {
-			port->MSVR = (arg & TIOCM_DTR) ?
-			                         (port->MSVR |  MSVR_DTR):
-			                         (port->MSVR & ~MSVR_DTR);
-		}
-		break;
-	default:
-		return -EINVAL;
-	}
 	save_flags(flags); cli();
+   /*	if (set & TIOCM_RTS) 
+		port->MSVR |= MSVR_RTS; */
+   /*   if (set & TIOCM_DTR)
+		port->MSVR |= MSVR_DTR; */
+
+	if (SX_CRTSCTS(port->tty)) {
+		if (set & TIOCM_RTS)
+			port->MSVR |= MSVR_DTR; 
+	} else {
+		if (set & TIOCM_DTR)
+			port->MSVR |= MSVR_DTR; 
+	}	     
+
+  /*	if (clear & TIOCM_RTS)
+		port->MSVR &= ~MSVR_RTS; */
+  /*    if (clear & TIOCM_DTR)
+		port->MSVR &= ~MSVR_DTR; */
+	if (SX_CRTSCTS(port->tty)) {
+		if (clear & TIOCM_RTS)
+			port->MSVR &= ~MSVR_DTR;
+	} else {
+		if (clear & TIOCM_DTR)
+			port->MSVR &= ~MSVR_DTR;
+	}
+
 	sx_out(bp, CD186x_CAR, port_No(port));
 	sx_out(bp, CD186x_MSVR, port->MSVR);
 	restore_flags(flags);
@@ -1896,16 +1880,6 @@
 			((tty->termios->c_cflag & ~CLOCAL) |
 			(arg ? CLOCAL : 0));
 		return 0;
-	 case TIOCMGET:
-		error = verify_area(VERIFY_WRITE, (void *) arg,
-		                    sizeof(unsigned int));
-		if (error)
-			return error;
-		return sx_get_modem_info(port, (unsigned int *) arg);
-	 case TIOCMBIS:
-	 case TIOCMBIC:
-	 case TIOCMSET:
-		return sx_set_modem_info(port, cmd, (unsigned int *) arg);
 	 case TIOCGSERIAL:	
 		return sx_get_serial_info(port, (struct serial_struct *) arg);
 	 case TIOCSSERIAL:	
@@ -2115,6 +2089,8 @@
 	.stop = sx_stop,
 	.start = sx_start,
 	.hangup = sx_hangup,
+	.tiocmget = sx_tiocmget,
+	.tiocmset = sx_tiocmset,
 };
 
 static int sx_init_drivers(void)
===== drivers/isdn/i4l/isdn_tty.c 1.55 vs edited =====
--- 1.55/drivers/isdn/i4l/isdn_tty.c	Sun Sep 21 22:49:52 2003
+++ edited/drivers/isdn/i4l/isdn_tty.c	Tue Jan 13 13:07:41 2004
@@ -1436,93 +1436,73 @@
 
 
 static int
-isdn_tty_get_modem_info(modem_info * info, uint * value)
+isdn_tty_tiocmget(struct tty_struct *tty, struct file *file)
 {
+	modem_info *info = (modem_info *) tty->driver_data;
 	u_char control,
 	 status;
 	uint result;
 	ulong flags;
 
+	if (isdn_tty_paranoia_check(info, tty->name, __FUNCTION__))
+		return -ENODEV;
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
+
+#ifdef ISDN_DEBUG_MODEM_IOCTL
+	printk(KERN_DEBUG "ttyI%d ioctl TIOCMGET\n", info->line);
+#endif
+
 	control = info->mcr;
 	save_flags(flags);
 	cli();
 	status = info->msr;
 	restore_flags(flags);
-	result = ((control & UART_MCR_RTS) ? TIOCM_RTS : 0)
+	return ((control & UART_MCR_RTS) ? TIOCM_RTS : 0)
 	    | ((control & UART_MCR_DTR) ? TIOCM_DTR : 0)
 	    | ((status & UART_MSR_DCD) ? TIOCM_CAR : 0)
 	    | ((status & UART_MSR_RI) ? TIOCM_RNG : 0)
 	    | ((status & UART_MSR_DSR) ? TIOCM_DSR : 0)
 	    | ((status & UART_MSR_CTS) ? TIOCM_CTS : 0);
-	return put_user(result, (uint *) value);
 }
 
 static int
-isdn_tty_set_modem_info(modem_info * info, uint cmd, uint * value)
+isdn_tty_tiocmset(struct tty_struct *tty, struct file *file,
+		  unsigned int set, unsigned int clear)
 {
+	modem_info *info = (modem_info *) tty->driver_data;
 	uint arg;
 	int pre_dtr;
 
-	if (get_user(arg, (uint *) value))
-		return -EFAULT;
-	switch (cmd) {
-		case TIOCMBIS:
-#ifdef ISDN_DEBUG_MODEM_IOCTL
-			printk(KERN_DEBUG "ttyI%d ioctl TIOCMBIS\n", info->line);
-#endif
-			if (arg & TIOCM_RTS) {
-				info->mcr |= UART_MCR_RTS;
-			}
-			if (arg & TIOCM_DTR) {
-				info->mcr |= UART_MCR_DTR;
-				isdn_tty_modem_ncarrier(info);
-			}
-			break;
-		case TIOCMBIC:
-#ifdef ISDN_DEBUG_MODEM_IOCTL
-			printk(KERN_DEBUG "ttyI%d ioctl TIOCMBIC\n", info->line);
-#endif
-			if (arg & TIOCM_RTS) {
-				info->mcr &= ~UART_MCR_RTS;
-			}
-			if (arg & TIOCM_DTR) {
-				info->mcr &= ~UART_MCR_DTR;
-				if (info->emu.mdmreg[REG_DTRHUP] & BIT_DTRHUP) {
-					isdn_tty_modem_reset_regs(info, 0);
-#ifdef ISDN_DEBUG_MODEM_HUP
-					printk(KERN_DEBUG "Mhup in TIOCMBIC\n");
-#endif
-					if (info->online)
-						info->ncarrier = 1;
-					isdn_tty_modem_hup(info, 1);
-				}
-			}
-			break;
-		case TIOCMSET:
+	if (isdn_tty_paranoia_check(info, tty->name, __FUNCTION__))
+		return -ENODEV;
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
+
 #ifdef ISDN_DEBUG_MODEM_IOCTL
-			printk(KERN_DEBUG "ttyI%d ioctl TIOCMSET\n", info->line);
+	printk(KERN_DEBUG "ttyI%d ioctl TIOCMxxx: %x %x\n", info->line, set, clear);
 #endif
-			pre_dtr = (info->mcr & UART_MCR_DTR);
-			info->mcr = ((info->mcr & ~(UART_MCR_RTS | UART_MCR_DTR))
-				 | ((arg & TIOCM_RTS) ? UART_MCR_RTS : 0)
-			       | ((arg & TIOCM_DTR) ? UART_MCR_DTR : 0));
-			if (pre_dtr |= (info->mcr & UART_MCR_DTR)) {
-				if (!(info->mcr & UART_MCR_DTR)) {
-					if (info->emu.mdmreg[REG_DTRHUP] & BIT_DTRHUP) {
-						isdn_tty_modem_reset_regs(info, 0);
+
+	if (set & TIOCM_RTS)
+		info->mcr |= UART_MCR_RTS;
+	if (set & TIOCM_DTR) {
+		info->mcr |= UART_MCR_DTR;
+		isdn_tty_modem_ncarrier(info);
+	}
+
+	if (clear & TIOCM_RTS)
+		info->mcr &= ~UART_MCR_RTS;
+	if (clear & TIOCM_DTR) {
+		info->mcr &= ~UART_MCR_DTR;
+		if (info->emu.mdmreg[REG_DTRHUP] & BIT_DTRHUP) {
+			isdn_tty_modem_reset_regs(info, 0);
 #ifdef ISDN_DEBUG_MODEM_HUP
-						printk(KERN_DEBUG "Mhup in TIOCMSET\n");
+			printk(KERN_DEBUG "Mhup in TIOCMBIC\n");
 #endif
-						if (info->online)
-							info->ncarrier = 1;
-						isdn_tty_modem_hup(info, 1);
-					}
-				} else
-					isdn_tty_modem_ncarrier(info);
-			}
-			break;
-		default:
-			return -EINVAL;
+			if (info->online)
+				info->ncarrier = 1;
+			isdn_tty_modem_hup(info, 1);
+		}
 	}
 	return 0;
 }
@@ -1572,15 +1552,6 @@
 			    ((tty->termios->c_cflag & ~CLOCAL) |
 			     (arg ? CLOCAL : 0));
 			return 0;
-		case TIOCMGET:
-#ifdef ISDN_DEBUG_MODEM_IOCTL
-			printk(KERN_DEBUG "ttyI%d ioctl TIOCMGET\n", info->line);
-#endif
-			return isdn_tty_get_modem_info(info, (uint *) arg);
-		case TIOCMBIS:
-		case TIOCMBIC:
-		case TIOCMSET:
-			return isdn_tty_set_modem_info(info, cmd, (uint *) arg);
 		case TIOCSERGETLSR:	/* Get line status register */
 #ifdef ISDN_DEBUG_MODEM_IOCTL
 			printk(KERN_DEBUG "ttyI%d ioctl TIOCSERGETLSR\n", info->line);
@@ -2006,6 +1977,8 @@
 	.unthrottle = isdn_tty_unthrottle,
 	.set_termios = isdn_tty_set_termios,
 	.hangup = isdn_tty_hangup,
+	.tiocmget = isdn_tty_tiocmget,
+	.tiocmset = isdn_tty_tiocmset,
 };
 
 int
===== drivers/net/wan/pc300_tty.c 1.14 vs edited =====
--- 1.14/drivers/net/wan/pc300_tty.c	Thu Sep 11 18:40:53 2003
+++ edited/drivers/net/wan/pc300_tty.c	Tue Jan 13 14:42:34 2004
@@ -583,6 +583,14 @@
 	CPC_TTY_DBG("%s: IOCTL cmd %x\n",cpc_tty->name,cmd);
 	
 	switch (cmd) { 
+#error This is broken.  See comments.
+/*
+ * TIOCMBIS/TIOCMBIC do not control only the DTR signal, but also
+ * the RTS, OUT1 and OUT2 signals, or even maybe nothing at all.
+ * Plus, these IOCTLs are no longer passed down to the driver.
+ * Instead, drivers should implement tiocmget and tiocmset driver
+ * methods.
+ */
 		case TIOCMBIS :    /* set DTR */
 			cpc_tty_dtr_on(cpc_tty->pc300dev);
 			break; 
===== drivers/sbus/char/aurora.c 1.30 vs edited =====
--- 1.30/drivers/sbus/char/aurora.c	Wed Jun 11 20:32:35 2003
+++ edited/drivers/sbus/char/aurora.c	Tue Jan 13 14:47:09 2004
@@ -1752,8 +1752,9 @@
 #endif
 }
 
-static int aurora_get_modem_info(struct Aurora_port * port, unsigned int *value)
+static int aurora_tiocmget(struct tty_struct *tty, struct file *file)
 {
+	struct Aurora_port *port = (struct Aurora_port *) tty->driver_data;
 	struct Aurora_board * bp;
 	unsigned char status,chip;
 	unsigned int result;
@@ -1762,6 +1763,9 @@
 #ifdef AURORA_DEBUG
 	printk("aurora_get_modem_info: start\n");
 #endif
+	if ((aurora_paranoia_check(port, tty->name, __FUNCTION__))
+		return -ENODEV;
+
 	chip = AURORA_CD180(port_No(port));
 
 	bp = port_Board(port);
@@ -1782,16 +1786,16 @@
 		| ((status & MSVR_DSR) ? TIOCM_DSR : 0)
 		| ((status & MSVR_CTS) ? TIOCM_CTS : 0);
 
-	put_user(result,(unsigned long *) value);
 #ifdef AURORA_DEBUG
 	printk("aurora_get_modem_info: end\n");
 #endif
-	return 0;
+	return result;
 }
 
-static int aurora_set_modem_info(struct Aurora_port * port, unsigned int cmd,
-				 unsigned int *value)
+static int aurora_tiocmset(struct tty_struct *tty, struct file *file,
+			   unsigned int set, unsigned int clear)
 {
+	struct Aurora_port *port = (struct Aurora_port *) tty->driver_data;
 	unsigned int arg;
 	unsigned long flags;
 	struct Aurora_board *bp = port_Board(port);
@@ -1800,33 +1804,20 @@
 #ifdef AURORA_DEBUG
 	printk("aurora_set_modem_info: start\n");
 #endif
-	if (get_user(arg, value))
-		return -EFAULT;
+	if ((aurora_paranoia_check(port, tty->name, __FUNCTION__))
+		return -ENODEV;
+
 	chip = AURORA_CD180(port_No(port));
-	switch (cmd) {
-	 case TIOCMBIS: 
-		if (arg & TIOCM_RTS) 
-			port->MSVR |= bp->RTS;
-		if (arg & TIOCM_DTR)
-			port->MSVR |= bp->DTR;
-		break;
-	case TIOCMBIC:
-		if (arg & TIOCM_RTS)
-			port->MSVR &= ~bp->RTS;
-		if (arg & TIOCM_DTR)
-			port->MSVR &= ~bp->DTR;
-		break;
-	case TIOCMSET:
-		port->MSVR = (arg & TIOCM_RTS) ? (port->MSVR | bp->RTS) : 
-					         (port->MSVR & ~bp->RTS);
-		port->MSVR = (arg & TIOCM_DTR) ? (port->MSVR | bp->RTS) :
-						 (port->MSVR & ~bp->RTS);
-		break;
-	 default:
-		return -EINVAL;
-	};
 
 	save_flags(flags); cli();
+	if (set & TIOCM_RTS)
+		port->MSVR |= bp->RTS;
+	if (set & TIOCM_DTR)
+		port->MSVR |= bp->DTR;
+	if (clear & TIOCM_RTS)
+		port->MSVR &= ~bp->RTS;
+	if (clear & TIOCM_DTR)
+		port->MSVR &= ~bp->DTR;
 
 	sbus_writeb(port_No(port) & 7, &bp->r[chip]->r[CD180_CAR]);
 	udelay(1);
@@ -1993,16 +1984,6 @@
 			((tty->termios->c_cflag & ~CLOCAL) |
 			 (arg ? CLOCAL : 0));
 		return 0;
-	case TIOCMGET:
-		retval = verify_area(VERIFY_WRITE, (void *) arg,
-				    sizeof(unsigned int));
-		if (retval)
-			return retval;
-		return aurora_get_modem_info(port, (unsigned int *) arg);
-	case TIOCMBIS:
-	case TIOCMBIC:
-	case TIOCMSET:
-		return aurora_set_modem_info(port, cmd, (unsigned int *) arg);
 	case TIOCGSERIAL:	
 		return aurora_get_serial_info(port, (struct serial_struct *) arg);
 	case TIOCSSERIAL:	
@@ -2268,6 +2249,8 @@
 	.stop = aurora_stop,
 	.start = aurora_start,
 	.hangup = aurora_hangup,
+	.tiocmget = aurora_tiocmget,
+	.tiocmset = aurora_tiocmset,
 };
 
 static int aurora_init_drivers(void)
===== drivers/serial/68360serial.c 1.17 vs edited =====
--- 1.17/drivers/serial/68360serial.c	Wed Jun 11 20:32:34 2003
+++ edited/drivers/serial/68360serial.c	Tue Jan 13 13:06:44 2004
@@ -1282,12 +1282,19 @@
 }
 #endif
 
-static int get_modem_info(ser_info_t *info, unsigned int *value)
+static int rs_360_tiocmget(struct tty_struct *tty, struct file *file)
 {
+	ser_info_t *info = (ser_info_t *)tty->driver_data;
 	unsigned int result = 0;
 #ifdef modem_control
 	unsigned char control, status;
 
+	if (serial_paranoia_check(info, tty->name, __FUNCTION__))
+		return -ENODEV;
+
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
+
 	control = info->MCR;
 	local_irq_disable();
 	status = serial_in(info, UART_MSR);
@@ -1303,63 +1310,42 @@
 		| ((status  & UART_MSR_DSR) ? TIOCM_DSR : 0)
 		| ((status  & UART_MSR_CTS) ? TIOCM_CTS : 0);
 #endif
-	/* return put_user(result,value); */
-	put_user(result,value);
-	return (0);
+	return result;
 }
 
-static int set_modem_info(ser_info_t *info, unsigned int cmd,
-			  unsigned int *value)
+static int rs_360_tiocmset(struct tty_struct *tty, struct file *file,
+			   unsigned int set, unsigned int clear)
 {
-	int error;
- 	unsigned int arg; 
-
-	error = get_user(arg,value);
-	if (error)
-		return error;
 #ifdef modem_control
-	switch (cmd) {
-	case TIOCMBIS: 
-		if (arg & TIOCM_RTS)
-			info->MCR |= UART_MCR_RTS;
-		if (arg & TIOCM_DTR)
-			info->MCR |= UART_MCR_DTR;
-#ifdef TIOCM_OUT1
-		if (arg & TIOCM_OUT1)
-			info->MCR |= UART_MCR_OUT1;
-		if (arg & TIOCM_OUT2)
-			info->MCR |= UART_MCR_OUT2;
-#endif
-		break;
-	case TIOCMBIC:
-		if (arg & TIOCM_RTS)
-			info->MCR &= ~UART_MCR_RTS;
-		if (arg & TIOCM_DTR)
-			info->MCR &= ~UART_MCR_DTR;
-#ifdef TIOCM_OUT1
-		if (arg & TIOCM_OUT1)
-			info->MCR &= ~UART_MCR_OUT1;
-		if (arg & TIOCM_OUT2)
-			info->MCR &= ~UART_MCR_OUT2;
-#endif
-		break;
-	case TIOCMSET:
-		info->MCR = ((info->MCR & ~(UART_MCR_RTS |
-#ifdef TIOCM_OUT1
-					    UART_MCR_OUT1 |
-					    UART_MCR_OUT2 |
-#endif
-					    UART_MCR_DTR))
-			     | ((arg & TIOCM_RTS) ? UART_MCR_RTS : 0)
+	ser_info_t *info = (ser_info_t *)tty->driver_data;
+ 	unsigned int arg;
+
+	if (serial_paranoia_check(info, tty->name, __FUNCTION__))
+		return -ENODEV;
+
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
+
+ 	if (set & TIOCM_RTS)
+ 		info->mcr |= UART_MCR_RTS;
+ 	if (set & TIOCM_DTR)
+ 		info->mcr |= UART_MCR_DTR;
+	if (clear & TIOCM_RTS)
+		info->MCR &= ~UART_MCR_RTS;
+	if (clear & TIOCM_DTR)
+		info->MCR &= ~UART_MCR_DTR;
+
 #ifdef TIOCM_OUT1
-			     | ((arg & TIOCM_OUT1) ? UART_MCR_OUT1 : 0)
-			     | ((arg & TIOCM_OUT2) ? UART_MCR_OUT2 : 0)
+	if (set & TIOCM_OUT1)
+		info->MCR |= UART_MCR_OUT1;
+	if (set & TIOCM_OUT2)
+		info->MCR |= UART_MCR_OUT2;
+	if (clear & TIOCM_OUT1)
+		info->MCR &= ~UART_MCR_OUT1;
+	if (clear & TIOCM_OUT2)
+		info->MCR &= ~UART_MCR_OUT2;
 #endif
-			     | ((arg & TIOCM_DTR) ? UART_MCR_DTR : 0));
-		break;
-	default:
-		return -EINVAL;
-	}
+
 	local_irq_disable();
 	serial_out(info, UART_MCR, info->MCR);
 	local_irq_enable();
@@ -1506,12 +1492,6 @@
 				((tty->termios->c_cflag & ~CLOCAL) |
 				 (arg ? CLOCAL : 0));
 			return 0;
-		case TIOCMGET:
-			return get_modem_info(info, (unsigned int *) arg);
-		case TIOCMBIS:
-		case TIOCMBIC:
-		case TIOCMSET:
-			return set_modem_info(info, cmd, (unsigned int *) arg);
 #ifdef maybe
 		case TIOCSERGETLSR: /* Get line status register */
 			return get_lsr_info(info, (unsigned int *) arg);
@@ -2513,6 +2493,8 @@
 	.hangup = rs_360_hangup,
 	/* .wait_until_sent = rs_360_wait_until_sent, */
 	/* .read_proc = rs_360_read_proc, */
+	.tiocmget = rs_360_tiocmget,
+	.tiocmset = rs_360_tiocmset,
 };
 
 /* int __init rs_360_init(void) */
===== drivers/tc/zs.c 1.24 vs edited =====
--- 1.24/drivers/tc/zs.c	Fri Sep 26 00:38:44 2003
+++ edited/drivers/tc/zs.c	Tue Jan 13 14:25:30 2004
@@ -1176,11 +1176,21 @@
 	return 0;
 }
 
-static int get_modem_info(struct dec_serial *info, unsigned int *value)
+static int rs_tiocmget(struct tty_struct *tty, struct file *file)
 {
+	struct dec_serial * info = (struct dec_serial *)tty->driver_data;
 	unsigned char control, status_a, status_b;
 	unsigned int result;
 
+	if (info->hook)
+		return -ENODEV;
+
+	if (serial_paranoia_check(info, tty->name, __FUNCTION__))
+		return -ENODEV;
+
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
+
 	if (info->zs_channel == info->zs_chan_a)
 		result = 0;
 	else {
@@ -1196,41 +1206,37 @@
 			| ((status_a & SYNC_HUNT) ? TIOCM_DSR: 0)
 			| ((status_b & CTS) ? TIOCM_CTS: 0);
 	}
-	put_user(result, value);
-	return 0;
+	return result;
 }
 
-static int set_modem_info(struct dec_serial *info, unsigned int cmd,
-			  unsigned int *value)
+static int rs_tiocmset(struct tty_struct *tty, struct file *file,
+		       unsigned int set, unsigned int clear)
 {
+	struct dec_serial * info = (struct dec_serial *)tty->driver_data;
 	int error;
 	unsigned int arg, bits;
 
-	error = verify_area(VERIFY_READ, value, sizeof(int));
-	if (error)
-		return error;
+	if (info->hook)
+		return -ENODEV;
+
+	if (serial_paranoia_check(info, tty->name, __FUNCTION__))
+		return -ENODEV;
+
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
 
 	if (info->zs_channel == info->zs_chan_a)
 		return 0;
 
-	get_user(arg, value);
-	bits = (arg & TIOCM_RTS? RTS: 0) + (arg & TIOCM_DTR? DTR: 0);
 	cli();
-	switch (cmd) {
-	case TIOCMBIS:
-		info->zs_chan_a->curregs[5] |= bits;
-		break;
-	case TIOCMBIC:
-		info->zs_chan_a->curregs[5] &= ~bits;
-		break;
-	case TIOCMSET:
-		info->zs_chan_a->curregs[5] = 
-			(info->zs_chan_a->curregs[5] & ~(DTR | RTS)) | bits;
-		break;
-	default:
-		sti();
-		return -EINVAL;
-	}
+	if (set & TIOCM_RTS)
+		info->zs_chan_a->curregs[5] |= RTS;
+	if (set & TIOCM_DTR)
+		info->zs_chan_a->curregs[5] |= DTR;
+	if (clear & TIOCM_RTS)
+		info->zs_chan_a->curregs[5] &= ~RTS;
+	if (clear & TIOCM_DTR)
+		info->zs_chan_a->curregs[5] &= ~DTR;
 	write_zsreg(info->zs_chan_a, 5, info->zs_chan_a->curregs[5]);
 	sti();
 	return 0;
@@ -1278,16 +1284,6 @@
 	}
 	
 	switch (cmd) {
-		case TIOCMGET:
-			error = verify_area(VERIFY_WRITE, (void *) arg,
-				sizeof(unsigned int));
-			if (error)
-				return error;
-			return get_modem_info(info, (unsigned int *) arg);
-		case TIOCMBIS:
-		case TIOCMBIC:
-		case TIOCMSET:
-			return set_modem_info(info, cmd, (unsigned int *) arg);
 		case TIOCGSERIAL:
 			error = verify_area(VERIFY_WRITE, (void *) arg,
 						sizeof(struct serial_struct));
@@ -1816,6 +1812,8 @@
 	.hangup = rs_hangup,
 	.break_ctl = rs_break,
 	.wait_until_sent = rs_wait_until_sent,
+	.tiocmget = rs_tiocmget,
+	.tiocmset = rs_tiocmset,
 };
 
 /* zs_init inits the driver */


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

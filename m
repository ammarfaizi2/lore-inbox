Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261756AbTCLRJZ>; Wed, 12 Mar 2003 12:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261792AbTCLRJZ>; Wed, 12 Mar 2003 12:09:25 -0500
Received: from users.linvision.com ([62.58.92.114]:10430 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S261756AbTCLRJV>; Wed, 12 Mar 2003 12:09:21 -0500
Date: Wed, 12 Mar 2003 18:19:49 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Userspace serial drivers: PTY changes.
Message-ID: <20030312181949.A18204@bitwizard.nl>
References: <20030312142822.A12206@bitwizard.nl> <b4nmsq$3fr$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <b4nmsq$3fr$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2003 at 08:22:50AM -0800, H. Peter Anvin wrote:
> Followup to:  <20030312142822.A12206@bitwizard.nl>
> By author:    Rogier Wolff <R.E.Wolff@BitWizard.nl>
> In newsgroup: linux.dev.kernel
> > 
> > So we implemented all this. Patch attached. What do you think?
> > 
> 
> -ENOPATCH?

--EAGREE


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.4.20.trueport-12-mrt"

diff -ur linux-2.4.20.clean/drivers/char/pty.c linux-2.4.20.trueport2/drivers/char/pty.c
--- linux-2.4.20.clean/drivers/char/pty.c	Sat Aug  3 02:39:43 2002
+++ linux-2.4.20.trueport2/drivers/char/pty.c	Wed Mar 12 10:56:08 2003
@@ -262,16 +262,109 @@
 	return 0;
 }
 
+static int pty_slave_ioctl(struct tty_struct *tty, struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+
+	struct tty_struct * real_tty;
+
+	if (!tty) {
+		printk(KERN_ERR "%scalled with NULL tty!\n", __FUNCTION__);
+		return -EIO;
+	}
+
+	if (tty->driver.type == TTY_DRIVER_TYPE_PTY &&
+	    tty->driver.subtype == PTY_TYPE_MASTER)
+		real_tty = tty->link;
+	else
+		real_tty = tty;
+	
+	switch(cmd) {
+	case TIOCSBRK:
+	case TCSBRK:
+	case TCSBRKP:
+		if (tty->link && tty->link->packet) {
+			tty->ctrl_status |= TIOCPKT_BREAK;
+			wake_up_interruptible(&tty->link->read_wait);
+		}
+		return 0;
+	case TIOCMBIC:
+	case TIOCMBIS:
+	case TIOCMSET: {
+		unsigned int new_val;
+
+		get_user(arg, (unsigned int *) arg);
+
+		new_val = real_tty->modem_status;
+		switch (cmd) {
+			case TIOCMBIC:
+				new_val &= ~arg;
+				break;
+			case TIOCMBIS:
+				new_val |=  arg;
+				break;
+			case TIOCMSET: 
+				new_val = arg;
+				break;
+		}
+
+		if (new_val != real_tty->modem_status) {
+			printk ("New status: 0x%x 0x%x\n", new_val ,  real_tty->modem_status);
+			real_tty->modem_status = new_val;
+			real_tty->link->modem_status = new_val;
+		
+			if (real_tty->link && real_tty->link->packet) {
+				real_tty->ctrl_status |= TIOCPKT_SIGNALS;
+				wake_up_interruptible(&real_tty->link->read_wait);
+			}
+		}
+
+		return 0;
+	}
+	case TIOCMGET:
+		printk ("Getting modem status: 0x%x\n", real_tty->modem_status);
+		if (put_user (real_tty->modem_status, (unsigned int*)arg))
+			return -EFAULT;
+		return 0;
+	}
+		
+		
+
+	return -ENOIOCTLCMD;
+}
+
+int set_termios(struct tty_struct * tty, unsigned long arg, int opt);
+
+
 static int pty_bsd_ioctl(struct tty_struct *tty, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
+	struct tty_struct * real_tty;
+
 	if (!tty) {
 		printk("pty_ioctl called with NULL tty!\n");
 		return -EIO;
 	}
+
+	if (tty->driver.type == TTY_DRIVER_TYPE_PTY &&
+	    tty->driver.subtype == PTY_TYPE_MASTER)
+		real_tty = tty->link;
+	else
+		real_tty = tty;
+	
+
 	switch(cmd) {
 	case TIOCSPTLCK: /* Set PT Lock (disallow slave open) */
 		return pty_set_lock(tty, (int *) arg);
+	case TCGETS:
+		if (kernel_termios_to_user_termios((struct termios *)arg, real_tty->termios))
+			return -EFAULT;
+		return 0;
+	case TIOCMSET: 
+		get_user(arg, (unsigned int *) arg);
+		tty->modem_status = arg;
+		tty->link->modem_status = arg;
+		return 0;
 	}
 	return -ENOIOCTLCMD;
 }
@@ -352,6 +445,11 @@
 {
         tty->termios->c_cflag &= ~(CSIZE | PARENB);
         tty->termios->c_cflag |= (CS8 | CREAD);
+
+	if (tty->link && tty->link->packet) {
+		tty->ctrl_status |= TIOCPKT_TERMIOS;
+		wake_up_interruptible(&tty->link->read_wait);
+	}
 }
 
 int __init pty_init(void)
@@ -420,6 +518,7 @@
 	pty_slave_driver.termios_locked = ttyp_termios_locked;
 	pty_slave_driver.driver_state = pty_state;
 	pty_slave_driver.other = &pty_driver;
+	pty_slave_driver.ioctl = pty_slave_ioctl;
 
 	if (tty_register_driver(&pty_driver))
 		panic("Couldn't register pty driver");
diff -ur linux-2.4.20.clean/drivers/char/tty_ioctl.c linux-2.4.20.trueport2/drivers/char/tty_ioctl.c
--- linux-2.4.20.clean/drivers/char/tty_ioctl.c	Wed Dec 18 12:09:13 2002
+++ linux-2.4.20.trueport2/drivers/char/tty_ioctl.c	Wed Mar 12 10:56:08 2003
@@ -138,7 +138,7 @@
 		(*tty->ldisc.set_termios)(tty, &old_termios);
 }
 
-static int set_termios(struct tty_struct * tty, unsigned long arg, int opt)
+int set_termios(struct tty_struct * tty, unsigned long arg, int opt)
 {
 	struct termios tmp_termios;
 	int retval = tty_check_change(tty);
@@ -505,6 +505,44 @@
 				((tty->termios->c_cflag & ~CLOCAL) |
 				 (arg ? CLOCAL : 0));
 			return 0;
+		case TIOCMGET:
+			if (put_user (tty->link->modem_status, (unsigned int*)arg))
+				return -EFAULT;
+			return 0;
+		case TIOCMSET: {
+			unsigned int new_val;
+			get_user(new_val, (unsigned int *) arg);
+			real_tty->modem_status = new_val;
+			real_tty->link->modem_status = new_val;
+			return 0;
+		}	
+		case TIOCMBIC:
+			if (get_user (arg, (unsigned int *) arg))
+				return -EFAULT;
+			
+			if (arg & TIOCM_DTR)
+				tty->link->modem_status &= ~TIOCM_DTR;
+
+			if (arg & TIOCM_RTS)
+				tty->link->modem_status &= ~ TIOCM_RTS;
+
+			wake_up_interruptible(&tty->link->read_wait);
+			return 0;
+
+
+		case TIOCMBIS:
+			if (get_user (arg, (unsigned int *) arg))
+				return -EFAULT;
+			
+			if (arg & TIOCM_DTR)
+				tty->link->modem_status |= TIOCM_DTR;
+
+			if (arg & TIOCM_RTS)
+				tty->link->modem_status |= TIOCM_RTS;
+
+			wake_up_interruptible(&tty->link->read_wait);
+			return 0;
+
 		default:
 			return -ENOIOCTLCMD;
 		}
diff -ur linux-2.4.20.clean/include/asm-i386/ioctls.h linux-2.4.20.trueport2/include/asm-i386/ioctls.h
--- linux-2.4.20.clean/include/asm-i386/ioctls.h	Sat Aug  3 02:39:45 2002
+++ linux-2.4.20.trueport2/include/asm-i386/ioctls.h	Wed Mar 12 11:00:37 2003
@@ -77,6 +77,16 @@
 #define TIOCPKT_NOSTOP		16
 #define TIOCPKT_DOSTOP		32
 
+/* Ugly hack. We use one bit for two purposes to prevent having to expand
+   the byte (API!). The deal is that you pretend that they are separate bits 
+   when setting or reading these bits. However when you check if a bit is 
+   set (indicating something changed), you have to be prepared that it 
+   in fact didn't change at all..... (As you also have to be prepared to 
+   handle the case where it changed back before you noticed it.) -- REW */
+#define TIOCPKT_SIGNALS         64
+#define TIOCPKT_TERMIOS         64
+#define TIOCPKT_BREAK          128
+
 #define TIOCSER_TEMT    0x01	/* Transmitter physically empty */
 
 #endif
diff -ur linux-2.4.20.clean/include/linux/tty.h linux-2.4.20.trueport2/include/linux/tty.h
--- linux-2.4.20.clean/include/linux/tty.h	Thu Feb 27 15:13:27 2003
+++ linux-2.4.20.trueport2/include/linux/tty.h	Wed Mar 12 10:56:24 2003
@@ -270,6 +270,7 @@
 	unsigned char stopped:1, hw_stopped:1, flow_stopped:1, packet:1;
 	unsigned char low_latency:1, warned:1;
 	unsigned char ctrl_status;
+	unsigned int  modem_status;
 
 	struct tty_struct *link;
 	struct fasync_struct *fasync;

--lrZ03NoBR/3+SXJZ--

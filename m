Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937114AbWLDQh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937114AbWLDQh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937116AbWLDQh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:37:28 -0500
Received: from [81.2.110.250] ([81.2.110.250]:53159 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-??-OK-FAIL) by vger.kernel.org with ESMTP
	id S937114AbWLDQh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:37:27 -0500
Date: Mon, 4 Dec 2006 16:43:01 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: [PATCH] usb serial: Eliminate bogus ioctl code
Message-ID: <20061204164301.02f870a9@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers have bogus ioctl code that tries unneccessarily to
override the standard processing. In the three cases here the actual code
is not only wrong but also not required as they implement the proper
set_termios method as well.

Remove the junk.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc6-mm1/drivers/usb/serial/cypress_m8.c linux-2.6.19-rc6-mm1/drivers/usb/serial/cypress_m8.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/usb/serial/cypress_m8.c	2006-11-24 13:58:30.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/usb/serial/cypress_m8.c	2006-11-24 14:27:36.000000000 +0000
@@ -962,21 +962,6 @@
 			cypress_set_termios(port, &priv->tmp_termios);
 			return (0);
 			break;
-		/* these are called when setting baud rate from gpsd */
-		case TCGETS:
-			if (copy_to_user((void __user *)arg, port->tty->termios, sizeof(struct ktermios))) {
-				return -EFAULT;
-			}
-			return (0);
-			break;
-		case TCSETS:
-			if (copy_from_user(port->tty->termios, (void __user *)arg, sizeof(struct ktermios))) {
-				return -EFAULT;
-			}
-			/* here we need to call cypress_set_termios to invoke the new settings */
-			cypress_set_termios(port, &priv->tmp_termios);
-			return (0);
-			break;
 		/* This code comes from drivers/char/serial.c and ftdi_sio.c */
 		case TIOCMIWAIT:
 			while (priv != NULL) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc6-mm1/drivers/usb/serial/kl5kusb105.c linux-2.6.19-rc6-mm1/drivers/usb/serial/kl5kusb105.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/usb/serial/kl5kusb105.c	2006-11-24 13:58:30.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/usb/serial/kl5kusb105.c	2006-11-24 14:27:48.000000000 +0000
@@ -903,67 +903,7 @@
 static int klsi_105_ioctl (struct usb_serial_port *port, struct file * file,
 			   unsigned int cmd, unsigned long arg)
 {
-	struct klsi_105_private *priv = usb_get_serial_port_data(port);
-	void __user *user_arg = (void __user *)arg;
-	
-	dbg("%scmd=0x%x", __FUNCTION__, cmd);
-
-	/* Based on code from acm.c and others */
-	switch (cmd) {
-	case TIOCMIWAIT:
-		/* wait for any of the 4 modem inputs (DCD,RI,DSR,CTS)*/
-		/* TODO */
-		dbg("%s - TIOCMIWAIT not handled", __FUNCTION__);
-		return -ENOIOCTLCMD;
-	case TIOCGICOUNT:
-		/* return count of modemline transitions */
-		/* TODO */
-		dbg("%s - TIOCGICOUNT not handled", __FUNCTION__);
-		return -ENOIOCTLCMD;
-
-	/* FIXME: The following 3 will break soon, fix the driver to use
-	   the proper interfaces please */
-	case TCGETS:
-		/* return current info to caller */
-		dbg("%s - TCGETS data faked/incomplete", __FUNCTION__);
-
-		if (!access_ok(VERIFY_WRITE, user_arg, sizeof(struct ktermios)))
-			return -EFAULT;
-
-		if (kernel_termios_to_user_termios((struct ktermios __user *)arg,
-						   &priv->termios))
-			return -EFAULT;
-		return 0;
-	case TCSETS:
-		/* set port termios to the one given by the user */
-		dbg("%s - TCSETS not handled", __FUNCTION__);
-
-		if (!access_ok(VERIFY_READ, user_arg, sizeof(struct ktermios)))
-			return -EFAULT;
-
-		if (user_termios_to_kernel_termios(&priv->termios,
-						   (struct ktermios __user *)arg))
-			return -EFAULT;
-		klsi_105_set_termios(port, &priv->termios);
-		return 0;
-	case TCSETSW: {
-		/* set port termios and try to wait for completion of last
-		 * write operation */
-		/* We guess here. If there are not too many write urbs
-		 * outstanding, we lie. */
-		/* what is the right way to wait here? schedule() ? */
-	        /*
-		while (klsi_105_chars_in_buffer(port) > (NUM_URBS / 4 ) * URB_TRANSFER_BUFFER_SIZE)
-			    schedule();
-		 */
-		return -ENOIOCTLCMD;
-		      }
-	default:
-		dbg("%s: arg not supported - 0x%04x", __FUNCTION__,cmd);
-		return(-ENOIOCTLCMD);
-		break;
-	}
-	return 0;
+	return -ENOIOCTLCMD;
 } /* klsi_105_ioctl */
 
 static void klsi_105_throttle (struct usb_serial_port *port)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc6-mm1/drivers/usb/serial/mos7840.c linux-2.6.19-rc6-mm1/drivers/usb/serial/mos7840.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/usb/serial/mos7840.c	2006-11-24 13:58:30.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/usb/serial/mos7840.c	2006-11-24 14:27:48.000000000 +0000
@@ -2460,13 +2460,6 @@
 		tty_ldisc_deref(ld);
 		return 0;
 
-	/* FIXME: Drivers are not allowed to override TCGETS like this */
-	case TCGETS:
-		if (kernel_termios_to_user_termios
-		    ((struct termios __user *)argp, tty->termios))
-			return -EFAULT;
-		return 0;
-
 	case TIOCSERGETLSR:
 		dbg("%s (%d) TIOCSERGETLSR", __FUNCTION__, port->number);
 		return mos7840_get_lsr_info(mos7840_port, argp);

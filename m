Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933008AbWJIT3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933008AbWJIT3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933010AbWJIT3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:29:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41151 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S933007AbWJIT3G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:29:06 -0400
Date: Mon, 9 Oct 2006 20:29:03 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] mos7840 annotations
Message-ID: <20061009192903.GW29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__user annotations, NULL noise removal, %p use for pointers

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/serial/mos7840.c |   46 +++++++++++++++---------------------------
 1 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 2306d49..021be39 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1087,7 +1087,7 @@ static int mos7840_open(struct usb_seria
 	mos7840_port->icount.tx = 0;
 	mos7840_port->icount.rx = 0;
 
-	dbg("\n\nusb_serial serial:%x       mos7840_port:%x\n      usb_serial_port port:%x\n\n", (unsigned int)serial, (unsigned int)mos7840_port, (unsigned int)port);
+	dbg("\n\nusb_serial serial:%p       mos7840_port:%p\n      usb_serial_port port:%p\n\n", serial, mos7840_port, port);
 
 	return 0;
 
@@ -1420,7 +1420,6 @@ static int mos7840_write(struct usb_seri
 	int i;
 	int bytes_sent = 0;
 	int transfer_size;
-	int from_user = 0;
 
 	struct moschip_port *mos7840_port;
 	struct usb_serial *serial;
@@ -1511,15 +1510,7 @@ #endif
 	}
 	transfer_size = min(count, URB_TRANSFER_BUFFER_SIZE);
 
-	if (from_user) {
-		if (copy_from_user
-		    (urb->transfer_buffer, current_position, transfer_size)) {
-			bytes_sent = -EFAULT;
-			goto exit;
-		}
-	} else {
-		memcpy(urb->transfer_buffer, current_position, transfer_size);
-	}
+	memcpy(urb->transfer_buffer, current_position, transfer_size);
 
 	/* fill urb with data and submit  */
 	usb_fill_bulk_urb(urb,
@@ -2225,7 +2216,7 @@ static void mos7840_set_termios(struct u
  *****************************************************************************/
 
 static int mos7840_get_lsr_info(struct moschip_port *mos7840_port,
-				unsigned int *value)
+				unsigned int __user *value)
 {
 	int count;
 	unsigned int result = 0;
@@ -2248,7 +2239,7 @@ static int mos7840_get_lsr_info(struct m
  *****************************************************************************/
 
 static int mos7840_get_bytes_avail(struct moschip_port *mos7840_port,
-				   unsigned int *value)
+				   unsigned int __user *value)
 {
 	unsigned int result = 0;
 	struct tty_struct *tty = mos7840_port->port->tty;
@@ -2271,7 +2262,7 @@ static int mos7840_get_bytes_avail(struc
  *****************************************************************************/
 
 static int mos7840_set_modem_info(struct moschip_port *mos7840_port,
-				  unsigned int cmd, unsigned int *value)
+				  unsigned int cmd, unsigned int __user *value)
 {
 	unsigned int mcr;
 	unsigned int arg;
@@ -2341,7 +2332,7 @@ static int mos7840_set_modem_info(struct
  *****************************************************************************/
 
 static int mos7840_get_modem_info(struct moschip_port *mos7840_port,
-				  unsigned int *value)
+				  unsigned int __user *value)
 {
 	unsigned int result = 0;
 	__u16 msr;
@@ -2370,7 +2361,7 @@ static int mos7840_get_modem_info(struct
  *****************************************************************************/
 
 static int mos7840_get_serial_info(struct moschip_port *mos7840_port,
-				   struct serial_struct *retinfo)
+				   struct serial_struct __user *retinfo)
 {
 	struct serial_struct tmp;
 
@@ -2405,6 +2396,7 @@ static int mos7840_get_serial_info(struc
 static int mos7840_ioctl(struct usb_serial_port *port, struct file *file,
 			 unsigned int cmd, unsigned long arg)
 {
+	void __user *argp = (void __user *)arg;
 	struct moschip_port *mos7840_port;
 	struct tty_struct *tty;
 
@@ -2433,16 +2425,13 @@ static int mos7840_ioctl(struct usb_seri
 
 	case TIOCINQ:
 		dbg("%s (%d) TIOCINQ", __FUNCTION__, port->number);
-		return mos7840_get_bytes_avail(mos7840_port,
-					       (unsigned int *)arg);
-		break;
+		return mos7840_get_bytes_avail(mos7840_port, argp);
 
 	case TIOCOUTQ:
 		dbg("%s (%d) TIOCOUTQ", __FUNCTION__, port->number);
 		return put_user(tty->driver->chars_in_buffer ?
 				tty->driver->chars_in_buffer(tty) : 0,
 				(int __user *)arg);
-		break;
 
 	case TCFLSH:
 		retval = tty_check_change(tty);
@@ -2472,13 +2461,13 @@ static int mos7840_ioctl(struct usb_seri
 
 	case TCGETS:
 		if (kernel_termios_to_user_termios
-		    ((struct termios __user *)arg, tty->termios))
+		    ((struct termios __user *)argp, tty->termios))
 			return -EFAULT;
 		return 0;
 
 	case TIOCSERGETLSR:
 		dbg("%s (%d) TIOCSERGETLSR", __FUNCTION__, port->number);
-		return mos7840_get_lsr_info(mos7840_port, (unsigned int *)arg);
+		return mos7840_get_lsr_info(mos7840_port, argp);
 		return 0;
 
 	case TIOCMBIS:
@@ -2487,19 +2476,16 @@ static int mos7840_ioctl(struct usb_seri
 		dbg("%s (%d) TIOCMSET/TIOCMBIC/TIOCMSET", __FUNCTION__,
 		    port->number);
 		mosret =
-		    mos7840_set_modem_info(mos7840_port, cmd,
-					   (unsigned int *)arg);
+		    mos7840_set_modem_info(mos7840_port, cmd, argp);
 		return mosret;
 
 	case TIOCMGET:
 		dbg("%s (%d) TIOCMGET", __FUNCTION__, port->number);
-		return mos7840_get_modem_info(mos7840_port,
-					      (unsigned int *)arg);
+		return mos7840_get_modem_info(mos7840_port, argp);
 
 	case TIOCGSERIAL:
 		dbg("%s (%d) TIOCGSERIAL", __FUNCTION__, port->number);
-		return mos7840_get_serial_info(mos7840_port,
-					       (struct serial_struct *)arg);
+		return mos7840_get_serial_info(mos7840_port, argp);
 
 	case TIOCSSERIAL:
 		dbg("%s (%d) TIOCSSERIAL", __FUNCTION__, port->number);
@@ -2549,7 +2535,7 @@ static int mos7840_ioctl(struct usb_seri
 
 		dbg("%s (%d) TIOCGICOUNT RX=%d, TX=%d", __FUNCTION__,
 		    port->number, icount.rx, icount.tx);
-		if (copy_to_user((void *)arg, &icount, sizeof(icount)))
+		if (copy_to_user(argp, &icount, sizeof(icount)))
 			return -EFAULT;
 		return 0;
 
@@ -2817,7 +2803,7 @@ static int mos7840_startup(struct usb_se
 
 	/* setting configuration feature to one */
 	usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-			(__u8) 0x03, 0x00, 0x01, 0x00, 0x00, 0x00, 5 * HZ);
+			(__u8) 0x03, 0x00, 0x01, 0x00, NULL, 0x00, 5 * HZ);
 	return 0;
 }
 
-- 
1.4.2.GIT


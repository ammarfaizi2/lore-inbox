Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264491AbTDXXf4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTDXXfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:35:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:25065 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264491AbTDXXeG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280533216@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <1051228052666@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:33 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.11, 2003/04/23 17:37:29-07:00, greg@kroah.com

[PATCH] USB: digi_acceleport: add support for new tty tiocmget and tiocmset functions.


 drivers/usb/serial/digi_acceleport.c |   62 +++++++++++++++++++++--------------
 1 files changed, 38 insertions(+), 24 deletions(-)


diff -Nru a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
--- a/drivers/usb/serial/digi_acceleport.c	Thu Apr 24 16:23:25 2003
+++ b/drivers/usb/serial/digi_acceleport.c	Thu Apr 24 16:23:25 2003
@@ -460,6 +460,9 @@
 static void digi_break_ctl( struct usb_serial_port *port, int break_state );
 static int digi_ioctl( struct usb_serial_port *port, struct file *file,
 	unsigned int cmd, unsigned long arg );
+static int digi_tiocmget( struct usb_serial_port *port, struct file *file );
+static int digi_tiocmset( struct usb_serial_port *port, struct file *file,
+	unsigned int set, unsigned int clear );
 static int digi_write( struct usb_serial_port *port, int from_user,
 	const unsigned char *buf, int count );
 static void digi_write_bulk_callback( struct urb *urb, struct pt_regs *regs );
@@ -526,6 +529,8 @@
 	.ioctl =			digi_ioctl,
 	.set_termios =			digi_set_termios,
 	.break_ctl =			digi_break_ctl,
+	.tiocmget =			digi_tiocmget,
+	.tiocmset =			digi_tiocmset,
 	.attach =			digi_startup,
 	.shutdown =			digi_shutdown,
 };
@@ -551,6 +556,8 @@
 	.ioctl =			digi_ioctl,
 	.set_termios =			digi_set_termios,
 	.break_ctl =			digi_break_ctl,
+	.tiocmget =			digi_tiocmget,
+	.tiocmset =			digi_tiocmset,
 	.attach =			digi_startup,
 	.shutdown =			digi_shutdown,
 };
@@ -1211,39 +1218,46 @@
 }
 
 
-static int digi_ioctl( struct usb_serial_port *port, struct file *file,
-	unsigned int cmd, unsigned long arg )
+static int digi_tiocmget( struct usb_serial_port *port, struct file *file )
 {
+	struct digi_port *priv = usb_get_serial_port_data(port);
+	unsigned int val;
+	unsigned long flags;
+
+	dbg("%s: TOP: port=%d", __FUNCTION__, priv->dp_port_num);
+
+	spin_lock_irqsave( &priv->dp_port_lock, flags );
+	val = priv->dp_modem_signals;
+	spin_unlock_irqrestore( &priv->dp_port_lock, flags );
+	return val;
+}
+
 
+static int digi_tiocmset( struct usb_serial_port *port, struct file *file,
+	unsigned int set, unsigned int clear )
+{
 	struct digi_port *priv = usb_get_serial_port_data(port);
 	unsigned int val;
-	unsigned long flags = 0;
+	unsigned long flags;
 
+	dbg("%s: TOP: port=%d", __FUNCTION__, priv->dp_port_num);
+
+	spin_lock_irqsave( &priv->dp_port_lock, flags );
+	val = (priv->dp_modem_signals & ~clear) | set;
+	spin_unlock_irqrestore( &priv->dp_port_lock, flags );
+	return digi_set_modem_signals( port, val, 1 );
+}
+
+
+static int digi_ioctl( struct usb_serial_port *port, struct file *file,
+	unsigned int cmd, unsigned long arg )
+{
+
+	struct digi_port *priv = usb_get_serial_port_data(port);
 
 dbg( "digi_ioctl: TOP: port=%d, cmd=0x%x", priv->dp_port_num, cmd );
 
 	switch (cmd) {
-
-	case TIOCMGET:
-		spin_lock_irqsave( &priv->dp_port_lock, flags );
-		val = priv->dp_modem_signals;
-		spin_unlock_irqrestore( &priv->dp_port_lock, flags );
-		if( copy_to_user((unsigned int *)arg, &val, sizeof(int)) )
-			return( -EFAULT );
-		return( 0 );
-
-	case TIOCMSET:
-	case TIOCMBIS:
-	case TIOCMBIC:
-		if( copy_from_user(&val, (unsigned int *)arg, sizeof(int)) )
-			return( -EFAULT );
-		spin_lock_irqsave( &priv->dp_port_lock, flags );
-		if( cmd == TIOCMBIS )
-			val = priv->dp_modem_signals | val;
-		else if( cmd == TIOCMBIC )
-			val = priv->dp_modem_signals & ~val;
-		spin_unlock_irqrestore( &priv->dp_port_lock, flags );
-		return( digi_set_modem_signals( port, val, 1 ) );
 
 	case TIOCMIWAIT:
 		/* wait for any of the 4 modem inputs (DCD,RI,DSR,CTS)*/


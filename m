Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313265AbSC1Vvm>; Thu, 28 Mar 2002 16:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313266AbSC1Vve>; Thu, 28 Mar 2002 16:51:34 -0500
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:34312 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313265AbSC1Vv1>;
	Thu, 28 Mar 2002 16:51:27 -0500
Date: Thu, 28 Mar 2002 13:51:16 -0800
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] USB serial fix for visor oops on 2.4.18
Message-ID: <20020328215116.GA10049@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 28 Feb 2002 18:39:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a fix for the oops that happens for a lot of people when their
Visor or Palm OS device is done syncing.  It is against 2.4.18 but will
apply cleanly to 2.4.19-pre4.

I've held off applying this to my tree, as the real fix for this problem
is already in the 2.5 kernel.  But it doesn't look like I'm going to be
backporting the 2.5 usb-serial changes to the 2.4 tree until after
2.4.19 is out.

So this patch is for those people who are bugged by this problem (it
doesn't happen to everyone), or for the distros who have to ship a
stable 2.4.x kernel.

It's also available at:
  http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/usb-serial_visor_fix-2.4.18.patch
for those people reading from the mailing list archives.

thanks,

greg k-h


diff -Nru a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
--- a/drivers/usb/serial/belkin_sa.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/belkin_sa.c	Thu Mar 28 13:43:49 2002
@@ -361,8 +361,6 @@
 
 	dbg(__FUNCTION__" port %d", port->number);
 
-	down (&port->sem);
-
 	--port->open_count;
 
 	if (port->open_count <= 0) {
@@ -375,7 +373,6 @@
 		port->active = 0;
 	}
 	
-	up (&port->sem);
 	MOD_DEC_USE_COUNT;
 } /* belkin_sa_close */
 
diff -Nru a/drivers/usb/serial/cyberjack.c b/drivers/usb/serial/cyberjack.c
--- a/drivers/usb/serial/cyberjack.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/cyberjack.c	Thu Mar 28 13:43:49 2002
@@ -193,8 +193,6 @@
 {
 	dbg(__FUNCTION__ " - port %d", port->number);
 
-	down (&port->sem);
-
 	--port->open_count;
 
 	if (port->open_count <= 0) {
@@ -209,7 +207,6 @@
 		port->open_count = 0;
 	}
 
-	up (&port->sem);
 	MOD_DEC_USE_COUNT;
 }
 
diff -Nru a/drivers/usb/serial/empeg.c b/drivers/usb/serial/empeg.c
--- a/drivers/usb/serial/empeg.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/empeg.c	Thu Mar 28 13:43:49 2002
@@ -212,8 +212,6 @@
 	if (!serial)
 		return;
 
-	down (&port->sem);
-
 	--port->open_count;
 
 	if (port->open_count <= 0) {
@@ -224,8 +222,6 @@
 		port->active = 0;
 		port->open_count = 0;
 	}
-
-	up (&port->sem);
 
 	/* Uncomment the following line if you want to see some statistics in your syslog */
 	/* info ("Bytes In = %d  Bytes Out = %d", bytes_in, bytes_out); */
diff -Nru a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
--- a/drivers/usb/serial/ftdi_sio.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/ftdi_sio.c	Thu Mar 28 13:43:49 2002
@@ -380,7 +380,6 @@
 
 	dbg( __FUNCTION__);
 
-	down (&port->sem);
 	--port->open_count;
 
 	if (port->open_count <= 0) {
@@ -419,7 +418,6 @@
 		}
 	}
 
-	up (&port->sem);
 	MOD_DEC_USE_COUNT;
 
 } /* ftdi_sio_close */
diff -Nru a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
--- a/drivers/usb/serial/ipaq.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/ipaq.c	Thu Mar 28 13:43:49 2002
@@ -224,8 +224,6 @@
 	if (!serial)
 		return;
 	
-	down (&port->sem);
-
 	--port->open_count;
 
 	if (port->open_count <= 0) {
@@ -243,7 +241,6 @@
 		port->open_count = 0;
 
 	}
-	up (&port->sem);
 
 	/* Uncomment the following line if you want to see some statistics in your syslog */
 	/* info ("Bytes In = %d  Bytes Out = %d", bytes_in, bytes_out); */
diff -Nru a/drivers/usb/serial/ir-usb.c b/drivers/usb/serial/ir-usb.c
--- a/drivers/usb/serial/ir-usb.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/ir-usb.c	Thu Mar 28 13:43:49 2002
@@ -317,8 +317,6 @@
 	if (!serial)
 		return;
 	
-	down (&port->sem);
-
 	--port->open_count;
 
 	if (port->open_count <= 0) {
@@ -330,7 +328,6 @@
 		port->open_count = 0;
 
 	}
-	up (&port->sem);
 	MOD_DEC_USE_COUNT;
 }
 
diff -Nru a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
--- a/drivers/usb/serial/keyspan.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/keyspan.c	Thu Mar 28 13:43:49 2002
@@ -945,8 +945,6 @@
 	p_priv->out_flip = 0;
 	p_priv->in_flip = 0;
 
-	down (&port->sem);
-
 	if (--port->open_count <= 0) {
 		if (port->active) {
 			if (serial->dev) {
@@ -963,7 +961,6 @@
 		port->open_count = 0;
 		port->tty = 0;
 	}
-	up (&port->sem);
 
 	MOD_DEC_USE_COUNT;
 }
diff -Nru a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
--- a/drivers/usb/serial/keyspan_pda.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/keyspan_pda.c	Thu Mar 28 13:43:49 2002
@@ -738,8 +738,6 @@
 {
 	struct usb_serial *serial = port->serial;
 
-	down (&port->sem);
-
 	--port->open_count;
 
 	if (port->open_count <= 0) {
@@ -756,7 +754,6 @@
 		port->open_count = 0;
 	}
 
-	up (&port->sem);
 	MOD_DEC_USE_COUNT;
 }
 
diff -Nru a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
--- a/drivers/usb/serial/kl5kusb105.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/kl5kusb105.c	Thu Mar 28 13:43:49 2002
@@ -499,8 +499,6 @@
 	if(!serial)
 		return;
 
-	down (&port->sem);
-
 	--port->open_count;
 
 	if (port->open_count <= 0) {
@@ -527,7 +525,6 @@
 		info("kl5kusb105 port stats: %ld bytes in, %ld bytes out", priv->bytes_in, priv->bytes_out);
 	}
 	
-	up (&port->sem);
 	MOD_DEC_USE_COUNT;
 } /* klsi_105_close */
 
diff -Nru a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
--- a/drivers/usb/serial/mct_u232.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/mct_u232.c	Thu Mar 28 13:43:49 2002
@@ -479,8 +479,6 @@
 {
 	dbg(__FUNCTION__" port %d", port->number);
 
-	down (&port->sem);
-
 	--port->open_count;
 
 	if (port->open_count <= 0) {
@@ -493,7 +491,6 @@
 		port->active = 0;
 	}
 	
-	up (&port->sem);
 	MOD_DEC_USE_COUNT;
 } /* mct_u232_close */
 
diff -Nru a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
--- a/drivers/usb/serial/omninet.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/omninet.c	Thu Mar 28 13:43:49 2002
@@ -211,8 +211,6 @@
 	if (!serial)
 		return;
 
-	down (&port->sem);
-
 	--port->open_count;
 
 	if (port->open_count <= 0) {
@@ -229,7 +227,6 @@
 			kfree(od);
 	}
 
-	up (&port->sem);
 	MOD_DEC_USE_COUNT;
 }
 
diff -Nru a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
--- a/drivers/usb/serial/pl2303.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/pl2303.c	Thu Mar 28 13:43:49 2002
@@ -447,8 +447,6 @@
 	
 	dbg (__FUNCTION__ " - port %d", port->number);
 
-	down (&port->sem);
-
 	--port->open_count;
 	if (port->open_count <= 0) {
 		if (serial->dev) {
@@ -486,7 +484,6 @@
 		port->open_count = 0;
 	}
 
-	up (&port->sem);
 	MOD_DEC_USE_COUNT;
 }
 
diff -Nru a/drivers/usb/serial/usbserial.c b/drivers/usb/serial/usbserial.c
--- a/drivers/usb/serial/usbserial.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/usbserial.c	Thu Mar 28 13:43:49 2002
@@ -553,12 +553,21 @@
 		return;
 	}
 
+	down (&port->sem);
+
+	if (tty->driver_data == NULL) {
+		/* disconnect beat us to the punch here, so handle it gracefully */
+		goto exit;
+	}
+	
 	/* pass on to the driver specific version of this function if it is available */
 	if (serial->type->close) {
 		serial->type->close(port, filp);
 	} else {
 		generic_close(port, filp);
 	}
+exit:
+	up (&port->sem);
 }	
 
 
@@ -1350,8 +1359,10 @@
 	if (serial) {
 		/* fail all future close/read/write/ioctl/etc calls */
 		for (i = 0; i < serial->num_ports; ++i) {
+			down (&serial->port[i].sem);
 			if (serial->port[i].tty != NULL)
 				serial->port[i].tty->driver_data = NULL;
+			up (&serial->port[i].sem);
 		}
 
 		serial->dev = NULL;
diff -Nru a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
--- a/drivers/usb/serial/visor.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/visor.c	Thu Mar 28 13:43:49 2002
@@ -363,8 +363,6 @@
 	if (!serial)
 		return;
 	
-	down (&port->sem);
-
 	--port->open_count;
 
 	if (port->open_count <= 0) {
@@ -389,7 +387,6 @@
 		port->active = 0;
 		port->open_count = 0;
 	}
-	up (&port->sem);
 
 	/* Uncomment the following line if you want to see some statistics in your syslog */
 	/* info ("Bytes In = %d  Bytes Out = %d", bytes_in, bytes_out); */
diff -Nru a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
--- a/drivers/usb/serial/whiteheat.c	Thu Mar 28 13:43:49 2002
+++ b/drivers/usb/serial/whiteheat.c	Thu Mar 28 13:43:49 2002
@@ -380,7 +380,6 @@
 	
 	dbg(__FUNCTION__ " - port %d", port->number);
 	
-	down (&port->sem);
 	--port->open_count;
 
 	if (port->open_count <= 0) {
@@ -398,7 +397,6 @@
 		port->active = 0;
 	}
 	MOD_DEC_USE_COUNT;
-	up (&port->sem);
 }
 
 

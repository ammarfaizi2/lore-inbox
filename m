Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272262AbRIKDCB>; Mon, 10 Sep 2001 23:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272264AbRIKDBw>; Mon, 10 Sep 2001 23:01:52 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:57862 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S272262AbRIKDBr>;
	Mon, 10 Sep 2001 23:01:47 -0400
Date: Mon, 10 Sep 2001 20:00:36 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] usb driver min max cleanup
Message-ID: <20010910200036.A7981@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0109101745440.1145-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109101745440.1145-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against 2.4.10-pre8 that converts most of the usb drivers
from min_t() and max_t() to min() and max().

Thanks,

greg k-h
(temporary usb maintainer)


diff -Nru a/drivers/usb/bluetooth.c b/drivers/usb/bluetooth.c
--- a/drivers/usb/bluetooth.c	Mon Sep 10 19:47:07 2001
+++ b/drivers/usb/bluetooth.c	Mon Sep 10 19:47:07 2001
@@ -518,7 +518,7 @@
 				}
 				
 
-				buffer_size = min_t (int, count, bluetooth->bulk_out_buffer_size);
+				buffer_size = min (count, bluetooth->bulk_out_buffer_size);
 				memcpy (urb->transfer_buffer, current_position, buffer_size);
 
 				/* build up our urb */
diff -Nru a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
--- a/drivers/usb/serial/digi_acceleport.c	Mon Sep 10 19:47:07 2001
+++ b/drivers/usb/serial/digi_acceleport.c	Mon Sep 10 19:47:07 2001
@@ -670,7 +670,7 @@
 		}
 
 		/* len must be a multiple of 4, so commands are not split */
-		len = min_t(int, count, oob_port->bulk_out_size );
+		len = min(count, oob_port->bulk_out_size );
 		if( len > 4 )
 			len &= ~3;
 
@@ -747,7 +747,7 @@
 		/* len must be a multiple of 4 and small enough to */
 		/* guarantee the write will send buffered data first, */
 		/* so commands are in order with data and not split */
-		len = min_t(int, count, port->bulk_out_size-2-priv->dp_out_buf_len );
+		len = min(count, port->bulk_out_size-2-priv->dp_out_buf_len );
 		if( len > 4 )
 			len &= ~3;
 
@@ -951,7 +951,7 @@
 	spin_lock_irqsave( &priv->dp_port_lock, flags );
 
 	/* send any buffered chars from throttle time on to tty subsystem */
-	len = min_t(int, priv->dp_in_buf_len, TTY_FLIPBUF_SIZE - tty->flip.count );
+	len = min(priv->dp_in_buf_len, TTY_FLIPBUF_SIZE - tty->flip.count );
 	if( len > 0 ) {
 		memcpy( tty->flip.char_buf_ptr, priv->dp_in_buf, len );
 		memcpy( tty->flip.flag_buf_ptr, priv->dp_in_flag_buf, len );
@@ -1272,7 +1272,8 @@
 priv->dp_port_num, count, from_user, in_interrupt() );
 
 	/* copy user data (which can sleep) before getting spin lock */
-	count = min_t(int, 64, min_t(int, count, port->bulk_out_size-2 ) );
+	count = min( count, port->bulk_out_size-2 );
+	count = min( 64, count);
 	if( from_user && copy_from_user( user_buf, buf, count ) ) {
 		return( -EFAULT );
 	}
@@ -1303,7 +1304,7 @@
 
 	/* allow space for any buffered data and for new data, up to */
 	/* transfer buffer size - 2 (for command and length bytes) */
-	new_len = min_t(int, count, port->bulk_out_size-2-priv->dp_out_buf_len );
+	new_len = min(count, port->bulk_out_size-2-priv->dp_out_buf_len);
 	data_len = new_len + priv->dp_out_buf_len;
 
 	if( data_len == 0 ) {
@@ -1929,7 +1930,7 @@
 
 		if( throttled ) {
 
-			len = min_t( int, len,
+			len = min( len,
 				DIGI_IN_BUF_SIZE - priv->dp_in_buf_len );
 
 			if( len > 0 ) {
@@ -1942,7 +1943,7 @@
 
 		} else {
 
-			len = min_t( int, len, TTY_FLIPBUF_SIZE - tty->flip.count );
+			len = min( len, TTY_FLIPBUF_SIZE - tty->flip.count );
 
 			if( len > 0 ) {
 				memcpy( tty->flip.char_buf_ptr, data, len );
diff -Nru a/drivers/usb/serial/empeg.c b/drivers/usb/serial/empeg.c
--- a/drivers/usb/serial/empeg.c	Mon Sep 10 19:47:07 2001
+++ b/drivers/usb/serial/empeg.c	Mon Sep 10 19:47:07 2001
@@ -276,7 +276,7 @@
 			}
 		}
 
-		transfer_size = min_t (int, count, URB_TRANSFER_BUFFER_SIZE);
+		transfer_size = min (count, URB_TRANSFER_BUFFER_SIZE);
 
 		if (from_user) {
 			if (copy_from_user (urb->transfer_buffer, current_position, transfer_size)) {
diff -Nru a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
--- a/drivers/usb/serial/io_edgeport.c	Mon Sep 10 19:47:07 2001
+++ b/drivers/usb/serial/io_edgeport.c	Mon Sep 10 19:47:07 2001
@@ -1311,7 +1311,7 @@
 	fifo = &edge_port->txfifo;
 
 	// calculate number of bytes to put in fifo
-	copySize = min_t (int, count, (edge_port->txCredits - fifo->count));
+	copySize = min ((unsigned int)count, (edge_port->txCredits - fifo->count));
 
 	dbg(__FUNCTION__"(%d) of %d byte(s) Fifo room  %d -- will copy %d bytes", 
 	    port->number, count, edge_port->txCredits - fifo->count, copySize);
@@ -1329,7 +1329,7 @@
 	// then copy the reset from the start of the buffer 
 
 	bytesleft = fifo->size - fifo->head;
-	firsthalf = min_t (int, bytesleft, copySize);
+	firsthalf = min (bytesleft, copySize);
 	dbg (__FUNCTION__" - copy %d bytes of %d into fifo ", firsthalf, bytesleft);
 
 	/* now copy our data */
@@ -1454,7 +1454,7 @@
 
 	/* now copy our data */
 	bytesleft =  fifo->size - fifo->tail;
-	firsthalf = min_t (int, bytesleft, count);
+	firsthalf = min (bytesleft, count);
 	memcpy(&buffer[2], &fifo->fifo[fifo->tail], firsthalf);
 	fifo->tail  += firsthalf;
 	fifo->count -= firsthalf;
diff -Nru a/drivers/usb/serial/io_usbvend.h b/drivers/usb/serial/io_usbvend.h
--- a/drivers/usb/serial/io_usbvend.h	Mon Sep 10 19:47:07 2001
+++ b/drivers/usb/serial/io_usbvend.h	Mon Sep 10 19:47:07 2001
@@ -115,7 +115,7 @@
 
 // TxCredits value below which driver won't bother sending (to prevent too many small writes).
 // Send only if above 25%
-#define EDGE_FW_GET_TX_CREDITS_SEND_THRESHOLD(InitialCredit)	(max_t(int, ((InitialCredit) / 4), EDGE_FW_BULK_MAX_PACKET_SIZE))
+#define EDGE_FW_GET_TX_CREDITS_SEND_THRESHOLD(InitialCredit)	(max(((InitialCredit) / 4), EDGE_FW_BULK_MAX_PACKET_SIZE))
 
 #define	EDGE_FW_BULK_MAX_PACKET_SIZE		64	// Max Packet Size for Bulk In Endpoint (EP1)
 #define EDGE_FW_BULK_READ_BUFFER_SIZE		1024	// Size to use for Bulk reads
diff -Nru a/drivers/usb/serial/usbserial.c b/drivers/usb/serial/usbserial.c
--- a/drivers/usb/serial/usbserial.c	Mon Sep 10 19:47:07 2001
+++ b/drivers/usb/serial/usbserial.c	Mon Sep 10 19:47:07 2001
@@ -1259,9 +1259,9 @@
 
 	/* initialize some parts of the port structures */
 	/* we don't use num_ports here cauz some devices have more endpoint pairs than ports */
-	max_endpoints = max_t(int, num_bulk_in, num_bulk_out);
-	max_endpoints = max_t(int, max_endpoints, num_interrupt_in);
-	max_endpoints = max_t(int, max_endpoints, serial->num_ports);
+	max_endpoints = max(num_bulk_in, num_bulk_out);
+	max_endpoints = max(max_endpoints, num_interrupt_in);
+	max_endpoints = max(max_endpoints, (int)serial->num_ports);
 	dbg (__FUNCTION__ " - setting up %d port structures for this device", max_endpoints);
 	for (i = 0; i < max_endpoints; ++i) {
 		port = &serial->port[i];
diff -Nru a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
--- a/drivers/usb/serial/visor.c	Mon Sep 10 19:47:07 2001
+++ b/drivers/usb/serial/visor.c	Mon Sep 10 19:47:07 2001
@@ -441,7 +441,7 @@
 			}
 		}
 		
-		transfer_size = min_t (int, count, URB_TRANSFER_BUFFER_SIZE);
+		transfer_size = min (count, URB_TRANSFER_BUFFER_SIZE);
 		if (from_user) {
 			if (copy_from_user (urb->transfer_buffer, current_position, transfer_size)) {
 				bytes_sent = -EFAULT;

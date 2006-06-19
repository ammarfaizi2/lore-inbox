Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWFSQfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWFSQfg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 12:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWFSQfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 12:35:36 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:39883 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964786AbWFSQff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 12:35:35 -0400
Date: Mon, 19 Jun 2006 13:35:31 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RESEND] [PATCH 1/2] ipaq.c bugfixes
Message-ID: <20060619133531.78f8ab39@doriath.conectiva>
In-Reply-To: <20060619084446.GA17103@fks.be>
References: <20060619084446.GA17103@fks.be>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.9.3; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 10:44:47 +0200
Frank Gevaerts <frank.gevaerts@fks.be> wrote:

| This patch fixes several problems in the ipaq.c driver with connecting
| and disconnecting pocketpc devices:
| * The read urb stayed active if the connect failed, causing nullpointer
|   dereferences later on.
| * If a write failed, the driver continued as if nothing happened. Now it
|   handles that case the same way as other usb serial devices (fix by
|   Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>)
| 
| Signed-off-by: Frank Gevaerts <frank.gevaerts@fks.be>
| 
| diff -urp linux-2.6.17-rc6/drivers/usb/serial/ipaq.c linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c
| --- linux-2.6.17-rc6/drivers/usb/serial/ipaq.c	2006-03-20 06:53:29.000000000 +0100
| +++ linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c	2006-06-14 16:02:03.000000000 +0200
| @@ -652,11 +652,6 @@ static int ipaq_open(struct usb_serial_p
|  		      usb_rcvbulkpipe(serial->dev, port->bulk_in_endpointAddress),
|  		      port->read_urb->transfer_buffer, port->read_urb->transfer_buffer_length,
|  		      ipaq_read_bulk_callback, port);
| -	result = usb_submit_urb(port->read_urb, GFP_KERNEL);
| -	if (result) {
| -		err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
| -		goto error;
| -	}
|  
|  	/*
|  	 * Send out control message observed in win98 sniffs. Not sure what
| @@ -671,6 +666,11 @@ static int ipaq_open(struct usb_serial_p
|  				usb_sndctrlpipe(serial->dev, 0), 0x22, 0x21,
|  				0x1, 0, NULL, 0, 100);
|  		if (result == 0) {
| +			result = usb_submit_urb(port->read_urb, GFP_KERNEL);
| +			if (result) {
| +				err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
| +				goto error;
| +			}
|  			return 0;
|  		}
|  	}

 What do you think about this (not compiled and may be wrong):

diff --git a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
index 9a5c979..96a6550 100644
--- a/drivers/usb/serial/ipaq.c
+++ b/drivers/usb/serial/ipaq.c
@@ -646,17 +646,6 @@ static int ipaq_open(struct usb_serial_p
 	port->write_urb->transfer_buffer = port->bulk_out_buffer;
 	port->read_urb->transfer_buffer_length = URBDATA_SIZE;
 	port->bulk_out_size = port->write_urb->transfer_buffer_length = URBDATA_SIZE;
-	
-	/* Start reading from the device */
-	usb_fill_bulk_urb(port->read_urb, serial->dev, 
-		      usb_rcvbulkpipe(serial->dev, port->bulk_in_endpointAddress),
-		      port->read_urb->transfer_buffer, port->read_urb->transfer_buffer_length,
-		      ipaq_read_bulk_callback, port);
-	result = usb_submit_urb(port->read_urb, GFP_KERNEL);
-	if (result) {
-		err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
-		goto error;
-	}
 
 	/*
 	 * Send out control message observed in win98 sniffs. Not sure what
@@ -670,12 +659,27 @@ static int ipaq_open(struct usb_serial_p
 		result = usb_control_msg(serial->dev,
 				usb_sndctrlpipe(serial->dev, 0), 0x22, 0x21,
 				0x1, 0, NULL, 0, 100);
-		if (result == 0) {
-			return 0;
-		}
+		if (!result)
+			break;
 	}
-	err("%s - failed doing control urb, error %d", __FUNCTION__, result);
-	goto error;
+	if (result) {
+		err("%s - failed doing control urb, error %d", __FUNCTION__,
+		    result);
+		goto error;
+	}
+
+	/* Start reading from the device */
+	usb_fill_bulk_urb(port->read_urb, serial->dev, 
+		      usb_rcvbulkpipe(serial->dev, port->bulk_in_endpointAddress),
+		      port->read_urb->transfer_buffer, port->read_urb->transfer_buffer_length,
+		      ipaq_read_bulk_callback, port);
+	result = usb_submit_urb(port->read_urb, GFP_KERNEL);
+	if (result) {
+		err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
+		goto error;
+	}
+
+	return 0;
 
 enomem:
 	result = -ENOMEM;

 This makes the code more readable than your version, IMHO.

 Greg, what do you think about this patch? I think it makes sense
because besides Frank's tests there's a comment stating that the
device only starts the chat sequence after one of these control
messages gets through.

-- 
Luiz Fernando N. Capitulino

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWE3Oiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWE3Oiv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWE3Oiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:38:51 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:23712 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751510AbWE3Oit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:38:49 -0400
Date: Tue, 30 May 2006 11:38:01 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060530113801.22c71afe@doriath.conectiva>
In-Reply-To: <20060530082141.GA26517@fks.be>
References: <20060526182217.GA12687@fks.be>
	<20060526133410.9cfff805.zaitcev@redhat.com>
	<20060529120102.1bc28bf2@doriath.conectiva>
	<20060529132553.08b225ba@doriath.conectiva>
	<20060529141110.6d149e21@doriath.conectiva>
	<20060529194334.GA32440@fks.be>
	<20060529172410.63dffa72@doriath.conectiva>
	<20060529204724.GA22250@fks.be>
	<20060529193330.3c51f3ba@home.brethil>
	<20060530082141.GA26517@fks.be>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 10:21:41 +0200
Frank Gevaerts <frank.gevaerts@fks.be> wrote:

| On Mon, May 29, 2006 at 07:33:30PM -0300, Luiz Fernando N. Capitulino wrote:
| > On Mon, 29 May 2006 22:47:24 +0200
| > Frank Gevaerts <frank.gevaerts@fks.be> wrote:
| > | 
| > | The panic was caused by the read urb being submitten in ipaq_open,
| > | regardless of success, and never killed in case of failure. What my
| > | patch basically does is to submit the urb only after succesfully sending
| > | the control message, and adding a sleep between tries. As long as this
| > | patch is not applied, we hardly get any other error because the kernel
| > | panics as soon as an ipaq reboots.
| > 
| >  I see.
| > 
| >  Did you try to just kill the read urb in the ipaq_open's error path?
| 
| Yes, that's what I did at first. It works, but with the long waits (we see
| waits up to 80-90 seconds right now) I was afraid that the urb might timeout
| before the control message succeeds.

 Hmmm, I see.

 My only (obvious) question is that if it's really safe to send the read
urb after the control message..

 Greg, are you following this thread? WDT?

 Anyways, if it's safe to do it, I do prefer the following (not tested)
version. Which is cleaner, IMO.

------------

diff --git a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
index 9a5c979..9333169 100644
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
@@ -665,17 +654,31 @@ static int ipaq_open(struct usb_serial_p
 	 * through. Since this has a reasonably high failure rate, we retry
 	 * several times.
 	 */
-
 	while (retries--) {
 		result = usb_control_msg(serial->dev,
 				usb_sndctrlpipe(serial->dev, 0), 0x22, 0x21,
 				0x1, 0, NULL, 0, 100);
-		if (result == 0) {
-			return 0;
-		}
+		if (!result)
+			break;
+	}
+	if (result) {
+		err("%s - failed doing control urb, error %d", __FUNCTION__,
+				result);
+		goto error;
 	}
-	err("%s - failed doing control urb, error %d", __FUNCTION__, result);
-	goto error;
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


-- 
Luiz Fernando N. Capitulino

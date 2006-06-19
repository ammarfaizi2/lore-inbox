Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWFSIpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWFSIpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWFSIpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:45:14 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:60377 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1751235AbWFSIpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:45:12 -0400
Date: Mon, 19 Jun 2006 10:44:47 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [RESEND] [PATCH 1/2] ipaq.c bugfixes
Message-ID: <20060619084446.GA17103@fks.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-104.708,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL -0.99,
	BAYES_05 -0.41, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes several problems in the ipaq.c driver with connecting
and disconnecting pocketpc devices:
* The read urb stayed active if the connect failed, causing nullpointer
  dereferences later on.
* If a write failed, the driver continued as if nothing happened. Now it
  handles that case the same way as other usb serial devices (fix by
  Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>)

Signed-off-by: Frank Gevaerts <frank.gevaerts@fks.be>

diff -urp linux-2.6.17-rc6/drivers/usb/serial/ipaq.c linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c
--- linux-2.6.17-rc6/drivers/usb/serial/ipaq.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c	2006-06-14 16:02:03.000000000 +0200
@@ -652,11 +652,6 @@ static int ipaq_open(struct usb_serial_p
 		      usb_rcvbulkpipe(serial->dev, port->bulk_in_endpointAddress),
 		      port->read_urb->transfer_buffer, port->read_urb->transfer_buffer_length,
 		      ipaq_read_bulk_callback, port);
-	result = usb_submit_urb(port->read_urb, GFP_KERNEL);
-	if (result) {
-		err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
-		goto error;
-	}
 
 	/*
 	 * Send out control message observed in win98 sniffs. Not sure what
@@ -671,6 +666,11 @@ static int ipaq_open(struct usb_serial_p
 				usb_sndctrlpipe(serial->dev, 0), 0x22, 0x21,
 				0x1, 0, NULL, 0, 100);
 		if (result == 0) {
+			result = usb_submit_urb(port->read_urb, GFP_KERNEL);
+			if (result) {
+				err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
+				goto error;
+			}
 			return 0;
 		}
 	}
@@ -855,6 +855,7 @@ static void ipaq_write_bulk_callback(str
 	
 	if (urb->status) {
 		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__, urb->status);
+		return;
 	}
 
 	spin_lock_irqsave(&write_list_lock, flags);

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19

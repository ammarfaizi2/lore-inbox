Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWFNL6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWFNL6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 07:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWFNL6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 07:58:55 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:22409 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1751264AbWFNL6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 07:58:55 -0400
Date: Wed, 14 Jun 2006 13:58:22 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: Greg KH <gregkh@suse.de>, Pete Zaitcev <zaitcev@redhat.com>,
       lcapitulino@mandriva.com.br, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] ipaq.c bugfixes
Message-ID: <20060614115822.GB20751@fks.be>
References: <20060530082141.GA26517@fks.be> <20060530113801.22c71afe@doriath.conectiva> <20060530115329.30184aa0@doriath.conectiva> <20060530174821.GA15969@fks.be> <20060530113327.297aceb7.zaitcev@redhat.com> <20060531213828.GA17711@fks.be> <20060531215523.GA13745@suse.de> <20060531224245.GB17711@fks.be> <20060531224624.GA17667@suse.de> <20060601191840.GB1757@fks.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601191840.GB1757@fks.be>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-103.516,
	vereist 5, ALL_TRUSTED -3.30, AWL -2.22, BAYES_50 2.00,
	USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 09:18:40PM +0200, Frank Gevaerts wrote:
> On Wed, May 31, 2006 at 03:46:24PM -0700, Greg KH wrote:
> > This is not how you pre-initialize a module parameter...
> 
> Thanks. That should teach me not to try to fix kernel code without
> reading documentation. I fixed it here, but I won't resubmit yet because
> there are some 100% reproducible bugs left. 

Everything now runs for more than a week without problems, so I guess I
now have all bugs. I have split out the extra parameters to a separate
patch, because they might not be needed for the standard kernel.
The fixes to usb-serial.c (in a separate mail/thread) are also needed
for bug-free operation.


This patch fixes several problems in the ipaq.c driver with connecting
and disconnecting pocketpc devices:
* The read urb stayed active if the connect failed, causing nullpointer
  dereferences later on.
* If a write failed, the driver continued as if nothing happened. Now it
  handles that case the same way as other usb serial devices (fix by
  "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>)

Signed-off-by: Frank Gevaerts <frank.gevaerts@fks.be>

diff -urp linux-2.6.17-rc6/drivers/usb/serial/ipaq.c linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c
--- linux-2.6.17-rc6/drivers/usb/serial/ipaq.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c	2006-06-14 13:22:57.000000000 +0200
@@ -652,7 +652,6 @@ static int ipaq_open(struct usb_serial_p
 		      usb_rcvbulkpipe(serial->dev, port->bulk_in_endpointAddress),
 		      port->read_urb->transfer_buffer, port->read_urb->transfer_buffer_length,
 		      ipaq_read_bulk_callback, port);
-	result = usb_submit_urb(port->read_urb, GFP_KERNEL);
 	if (result) {
 		err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
 		goto error;
@@ -671,6 +670,7 @@ static int ipaq_open(struct usb_serial_p
 				usb_sndctrlpipe(serial->dev, 0), 0x22, 0x21,
 				0x1, 0, NULL, 0, 100);
 		if (result == 0) {
+			result = usb_submit_urb(port->read_urb, GFP_KERNEL);
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

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWFNN6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWFNN6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWFNN6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:58:54 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:38118 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964943AbWFNN6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:58:53 -0400
Date: Wed, 14 Jun 2006 10:58:49 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: Greg KH <gregkh@suse.de>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] ipaq.c bugfixes
Message-ID: <20060614105849.14b4026a@doriath.conectiva>
In-Reply-To: <20060614115822.GB20751@fks.be>
References: <20060530082141.GA26517@fks.be>
	<20060530113801.22c71afe@doriath.conectiva>
	<20060530115329.30184aa0@doriath.conectiva>
	<20060530174821.GA15969@fks.be>
	<20060530113327.297aceb7.zaitcev@redhat.com>
	<20060531213828.GA17711@fks.be>
	<20060531215523.GA13745@suse.de>
	<20060531224245.GB17711@fks.be>
	<20060531224624.GA17667@suse.de>
	<20060601191840.GB1757@fks.be>
	<20060614115822.GB20751@fks.be>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.3 (GTK+ 2.9.2; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2006 13:58:22 +0200
Frank Gevaerts <frank.gevaerts@fks.be> wrote:

| On Thu, Jun 01, 2006 at 09:18:40PM +0200, Frank Gevaerts wrote:
| > On Wed, May 31, 2006 at 03:46:24PM -0700, Greg KH wrote:
| > > This is not how you pre-initialize a module parameter...
| > 
| > Thanks. That should teach me not to try to fix kernel code without
| > reading documentation. I fixed it here, but I won't resubmit yet because
| > there are some 100% reproducible bugs left. 
| 
| Everything now runs for more than a week without problems, so I guess I
| now have all bugs. I have split out the extra parameters to a separate
| patch, because they might not be needed for the standard kernel.
| The fixes to usb-serial.c (in a separate mail/thread) are also needed
| for bug-free operation.
| 
| 
| This patch fixes several problems in the ipaq.c driver with connecting
| and disconnecting pocketpc devices:
| * The read urb stayed active if the connect failed, causing nullpointer
|   dereferences later on.
| * If a write failed, the driver continued as if nothing happened. Now it
|   handles that case the same way as other usb serial devices (fix by
|   "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>)
| 
| Signed-off-by: Frank Gevaerts <frank.gevaerts@fks.be>
| 
| diff -urp linux-2.6.17-rc6/drivers/usb/serial/ipaq.c linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c
| --- linux-2.6.17-rc6/drivers/usb/serial/ipaq.c	2006-03-20 06:53:29.000000000 +0100
| +++ linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c	2006-06-14 13:22:57.000000000 +0200
| @@ -652,7 +652,6 @@ static int ipaq_open(struct usb_serial_p
|  		      usb_rcvbulkpipe(serial->dev, port->bulk_in_endpointAddress),
|  		      port->read_urb->transfer_buffer, port->read_urb->transfer_buffer_length,
|  		      ipaq_read_bulk_callback, port);
| -	result = usb_submit_urb(port->read_urb, GFP_KERNEL);
|  	if (result) {
|  		err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
|  		goto error;
| @@ -671,6 +670,7 @@ static int ipaq_open(struct usb_serial_p
|  				usb_sndctrlpipe(serial->dev, 0), 0x22, 0x21,
|  				0x1, 0, NULL, 0, 100);
|  		if (result == 0) {
| +			result = usb_submit_urb(port->read_urb, GFP_KERNEL);
|  			return 0;
|  		}
|  	}

 I think you forgot to move the 'result' checking after the urb is
submitted.

-- 
Luiz Fernando N. Capitulino

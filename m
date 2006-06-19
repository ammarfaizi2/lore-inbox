Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWFSR0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWFSR0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWFSR0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:26:03 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:48802 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S932186AbWFSR0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:26:01 -0400
Date: Mon, 19 Jun 2006 19:25:36 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RESEND] [PATCH 1/2] ipaq.c bugfixes
Message-ID: <20060619172536.GB32484@fks.be>
References: <20060619084446.GA17103@fks.be> <20060619133531.78f8ab39@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619133531.78f8ab39@doriath.conectiva>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.797,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.10,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 01:35:31PM -0300, Luiz Fernando N. Capitulino wrote:
> On Mon, 19 Jun 2006 10:44:47 +0200
> Frank Gevaerts <frank.gevaerts@fks.be> wrote:
> 
> | This patch fixes several problems in the ipaq.c driver with connecting
> | and disconnecting pocketpc devices:
> | * The read urb stayed active if the connect failed, causing nullpointer
> |   dereferences later on.
> | * If a write failed, the driver continued as if nothing happened. Now it
> |   handles that case the same way as other usb serial devices (fix by
> |   Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>)
> | 
> | Signed-off-by: Frank Gevaerts <frank.gevaerts@fks.be>
> | 
> | diff -urp linux-2.6.17-rc6/drivers/usb/serial/ipaq.c linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c
> | --- linux-2.6.17-rc6/drivers/usb/serial/ipaq.c	2006-03-20 06:53:29.000000000 +0100
> | +++ linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c	2006-06-14 16:02:03.000000000 +0200
> | @@ -652,11 +652,6 @@ static int ipaq_open(struct usb_serial_p
> |  		      usb_rcvbulkpipe(serial->dev, port->bulk_in_endpointAddress),
> |  		      port->read_urb->transfer_buffer, port->read_urb->transfer_buffer_length,
> |  		      ipaq_read_bulk_callback, port);
> | -	result = usb_submit_urb(port->read_urb, GFP_KERNEL);
> | -	if (result) {
> | -		err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
> | -		goto error;
> | -	}
> |  
> |  	/*
> |  	 * Send out control message observed in win98 sniffs. Not sure what
> | @@ -671,6 +666,11 @@ static int ipaq_open(struct usb_serial_p
> |  				usb_sndctrlpipe(serial->dev, 0), 0x22, 0x21,
> |  				0x1, 0, NULL, 0, 100);
> |  		if (result == 0) {
> | +			result = usb_submit_urb(port->read_urb, GFP_KERNEL);
> | +			if (result) {
> | +				err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
> | +				goto error;
> | +			}
> |  			return 0;
> |  		}
> |  	}
> 
>  What do you think about this (not compiled and may be wrong):
> 
> diff --git a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
> index 9a5c979..96a6550 100644
> --- a/drivers/usb/serial/ipaq.c
> +++ b/drivers/usb/serial/ipaq.c
> @@ -646,17 +646,6 @@ static int ipaq_open(struct usb_serial_p
>  	port->write_urb->transfer_buffer = port->bulk_out_buffer;
>  	port->read_urb->transfer_buffer_length = URBDATA_SIZE;
>  	port->bulk_out_size = port->write_urb->transfer_buffer_length = URBDATA_SIZE;
> -	
> -	/* Start reading from the device */
> -	usb_fill_bulk_urb(port->read_urb, serial->dev, 
> -		      usb_rcvbulkpipe(serial->dev, port->bulk_in_endpointAddress),
> -		      port->read_urb->transfer_buffer, port->read_urb->transfer_buffer_length,
> -		      ipaq_read_bulk_callback, port);
> -	result = usb_submit_urb(port->read_urb, GFP_KERNEL);
> -	if (result) {
> -		err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
> -		goto error;
> -	}
>  
>  	/*
>  	 * Send out control message observed in win98 sniffs. Not sure what
> @@ -670,12 +659,27 @@ static int ipaq_open(struct usb_serial_p
>  		result = usb_control_msg(serial->dev,
>  				usb_sndctrlpipe(serial->dev, 0), 0x22, 0x21,
>  				0x1, 0, NULL, 0, 100);
> -		if (result == 0) {
> -			return 0;
> -		}
> +		if (!result)
> +			break;
>  	}
> -	err("%s - failed doing control urb, error %d", __FUNCTION__, result);
> -	goto error;
> +	if (result) {
> +		err("%s - failed doing control urb, error %d", __FUNCTION__,
> +		    result);
> +		goto error;
> +	}
> +
> +	/* Start reading from the device */
> +	usb_fill_bulk_urb(port->read_urb, serial->dev, 
> +		      usb_rcvbulkpipe(serial->dev, port->bulk_in_endpointAddress),
> +		      port->read_urb->transfer_buffer, port->read_urb->transfer_buffer_length,
> +		      ipaq_read_bulk_callback, port);
> +	result = usb_submit_urb(port->read_urb, GFP_KERNEL);
> +	if (result) {
> +		err("%s - failed submitting read urb, error %d", __FUNCTION__, result);
> +		goto error;
> +	}
> +
> +	return 0;
>  
>  enomem:
>  	result = -ENOMEM;
> 
>  This makes the code more readable than your version, IMHO.

It is more readable. It compiles, and it looks equivalent to me.
Unfortunately, I don't have easy access to the test setup anymore
(everything is now at the customer site), so I'm not sure if I can test
this anytime soon.

Frank

>  Greg, what do you think about this patch? I think it makes sense
> because besides Frank's tests there's a comment stating that the
> device only starts the chat sequence after one of these control
> messages gets through.
> 
> -- 
> Luiz Fernando N. Capitulino

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19

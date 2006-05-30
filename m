Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWE3PGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWE3PGy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 11:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWE3PGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 11:06:54 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:56195 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S932293AbWE3PGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 11:06:53 -0400
Date: Tue, 30 May 2006 17:06:27 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060530150627.GB27700@fks.be>
References: <20060526133410.9cfff805.zaitcev@redhat.com> <20060529120102.1bc28bf2@doriath.conectiva> <20060529132553.08b225ba@doriath.conectiva> <20060529141110.6d149e21@doriath.conectiva> <20060529194334.GA32440@fks.be> <20060529172410.63dffa72@doriath.conectiva> <20060529204724.GA22250@fks.be> <20060529193330.3c51f3ba@home.brethil> <20060530082141.GA26517@fks.be> <20060530113801.22c71afe@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530113801.22c71afe@doriath.conectiva>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.814,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.09,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 11:38:01AM -0300, Luiz Fernando N. Capitulino wrote:
> On Tue, 30 May 2006 10:21:41 +0200
> Frank Gevaerts <frank.gevaerts@fks.be> wrote:
> 
> | On Mon, May 29, 2006 at 07:33:30PM -0300, Luiz Fernando N. Capitulino wrote:
> | > On Mon, 29 May 2006 22:47:24 +0200
> | >  I see.
> | > 
> | >  Did you try to just kill the read urb in the ipaq_open's error path?
> | 
> | Yes, that's what I did at first. It works, but with the long waits (we see
> | waits up to 80-90 seconds right now) I was afraid that the urb might timeout
> | before the control message succeeds.
> 
>  Hmmm, I see.
> 
>  My only (obvious) question is that if it's really safe to send the read
> urb after the control message..

Since it is bulk, it is not guaranteed to start before the control
message anyway, so it should be safe.

The patch looks correct to me, but I would still like to increase
KP_RETRIES a bit. If I read the code correctly, the current setup allows
for 10 seconds between usb connect and acknowledging the control
message. This is enough if the device is only connected when booted
(which is the normal use case). However, in our case, we do
software-initiated reboots of the ipaq while it is attached to the usb
bus, which can take much longer, so for us KP_RETRIES should be at least
1000, maybe 2000. Of course, we can always run a patched kernel for this.

I'll test the patch later today.

Anyway, we have not seen the usb_serial_disconnect bug since applying
your patch, so that bug is also probably gone (we have had nearly 1000
successfull connects/disconnects since then)

Frank

>  Greg, are you following this thread? WDT?
> 
>  Anyways, if it's safe to do it, I do prefer the following (not tested)
> version. Which is cleaner, IMO.
> 
> ------------
> 
> diff --git a/drivers/usb/serial/ipaq.c b/drivers/usb/serial/ipaq.c
> index 9a5c979..9333169 100644
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
> @@ -665,17 +654,31 @@ static int ipaq_open(struct usb_serial_p
>  	 * through. Since this has a reasonably high failure rate, we retry
>  	 * several times.
>  	 */
> -
>  	while (retries--) {
>  		result = usb_control_msg(serial->dev,
>  				usb_sndctrlpipe(serial->dev, 0), 0x22, 0x21,
>  				0x1, 0, NULL, 0, 100);
> -		if (result == 0) {
> -			return 0;
> -		}
> +		if (!result)
> +			break;
> +	}
> +	if (result) {
> +		err("%s - failed doing control urb, error %d", __FUNCTION__,
> +				result);
> +		goto error;
>  	}
> -	err("%s - failed doing control urb, error %d", __FUNCTION__, result);
> -	goto error;
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
> 
> -- 
> Luiz Fernando N. Capitulino

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19

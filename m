Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUFGOUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUFGOUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbUFGOUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:20:18 -0400
Received: from [141.156.69.115] ([141.156.69.115]:39562 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S264693AbUFGOTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:19:35 -0400
Message-ID: <40C47972.8090703@infosciences.com>
Date: Mon, 07 Jun 2004 10:19:30 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Memory leak in visor.c and ftdi_sio.c
References: <40C08E6D.8080606@infosciences.com> <c9q8a6$hga$1@sea.gmane.org> <20040605001832.GA28502@kroah.com>
In-Reply-To: <20040605001832.GA28502@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Jun 04, 2004 at 05:34:41PM +0100, Ian Abbott wrote:
> 
>>On 04/06/2004 15:59, nardelli wrote:
>>
>>A related problem with the current implementation is that is easy to 
>>run out of memory by running something similar to this:
>>
>> # cat /dev/zero > /dev/ttyUSB0
>>
>>That affects both the ftdi_sio and visor drivers.
> 
> 
> Care to try out the following (build test only) patch to the visor
> driver to see if it prevents this from happening?  I don't have a
> working visor right now to test it out myself :(
> 
> Oops, ignore the fact that we never free the structure on disconnect, I
> see that now...
> 
> thanks,
> 
> greg k-h
> 
> 
> ===== drivers/usb/serial/visor.c 1.114 vs edited =====
> --- 1.114/drivers/usb/serial/visor.c	Fri Jun  4 07:13:10 2004
> +++ edited/drivers/usb/serial/visor.c	Fri Jun  4 17:12:53 2004

...

Just curious - is there something special about 42?  Grepping wasn't
very useful, as numbers like this are scattered all over the place.

> +/* number of outstanding urbs to prevent userspace DoS from happening */
> +#define URB_UPPER_LIMIT	42

...

>  
>  static int visor_write (struct usb_serial_port *port, int from_user, const unsigned char *buf, int count)
>  {
> +	struct visor_private *priv = usb_get_serial_port_data(port);
>  	struct usb_serial *serial = port->serial;
>  	struct urb *urb;
>  	unsigned char *buffer;
> +	unsigned long flags;
>  	int status;
>  
>  	dbg("%s - port %d", __FUNCTION__, port->number);
>  
> +	spin_lock_irqsave(&priv->lock, flags);
> +	if (priv->outstanding_urbs > URB_UPPER_LIMIT) {
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +		dev_dbg(&port->dev, "write limit hit\n");
> +		return 0;
> +	}
> +	++priv->outstanding_urbs;
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
>  	buffer = kmalloc (count, GFP_ATOMIC);
>  	if (!buffer) {
>  		dev_err(&port->dev, "out of memory\n");
> @@ -520,7 +545,10 @@
>  		count = status;
>  		kfree (buffer);
>  	} else {
> -		bytes_out += count;
> +		spin_lock_irqsave(&priv->lock, flags);
> +		++priv->outstanding_urbs;
> +		priv->bytes_out += count;
> +		spin_unlock_irqrestore(&priv->lock, flags);
>  	}
>  
>  	/* we are done with this urb, so let the host driver


Removing the first of two priv->outstanding_urbs increments in
visor_write (I assume that was your intention) produced very nice
results ;-)

1) When being flooded, after the initial bunch of URBs were sent,
only 1 per second was sent, and it appeared that all of them were
being freed.
2) Even after the flood, the driver survived, and backups were
possible after the device was reconnected.


I'm fairly ignorant of most of the lower level usb infrastructure
(hcd, hub, ehci, etc), so I'm not sure what the root cause (ignoring
the patch above) of the completion handler not being called might be.
I would suspect overflow of some callback list, but that's just a
guess.  Do you have any ideas on what this might be, and could this
be a problem in other devices?


-- 
Joe Nardelli
jnardelli@infosciences.com

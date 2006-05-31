Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965222AbWEaWsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbWEaWsv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbWEaWsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:48:51 -0400
Received: from mx1.suse.de ([195.135.220.2]:14767 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965222AbWEaWsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:48:51 -0400
Date: Wed, 31 May 2006 15:46:24 -0700
From: Greg KH <gregkh@suse.de>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: Pete Zaitcev <zaitcev@redhat.com>, lcapitulino@mandriva.com.br,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] ipaq.c bugfixes
Message-ID: <20060531224624.GA17667@suse.de>
References: <20060529204724.GA22250@fks.be> <20060529193330.3c51f3ba@home.brethil> <20060530082141.GA26517@fks.be> <20060530113801.22c71afe@doriath.conectiva> <20060530115329.30184aa0@doriath.conectiva> <20060530174821.GA15969@fks.be> <20060530113327.297aceb7.zaitcev@redhat.com> <20060531213828.GA17711@fks.be> <20060531215523.GA13745@suse.de> <20060531224245.GB17711@fks.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531224245.GB17711@fks.be>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 12:42:45AM +0200, Frank Gevaerts wrote:
> This patch fixes several problems in the ipaq.c driver with connecting
> and disconnecting pocketpc devices: 
> * The read urb stayed active if the connect failed, causing nullpointer
>   dereferences later on. 
> * If a write failed, the driver continued as if nothing happened. Now it
>   handles that case the same way as other usb serial devices (fix by 
>   "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>)
> 
> The connect_retries parameter is added because if a pocketpc device is
> connected while it is rebooting, it can take a long time after the USB
> connect (sometimes several minutes) before it starts accepting the
> control packet that starts the serial connection. Since this is not the
> normal usecase, it is probably better to leave the default number of
> retries as-is.
> 
> Signed-off-by: Frank Gevaerts <frank.gevaerts@fks.be>
> 
> diff -pur linux-2.6.17-rc4/drivers/usb/serial/ipaq.c linux-2.6.17-rc4.test/drivers/usb/serial/ipaq.c
> --- linux-2.6.17-rc4/drivers/usb/serial/ipaq.c	2006-03-20 06:53:29.000000000 +0100
> +++ linux-2.6.17-rc4.test/drivers/usb/serial/ipaq.c	2006-05-30 20:46:23.000000000 +0200
> @@ -71,6 +71,7 @@
>  
>  static __u16 product, vendor;
>  static int debug;
> +static int connect_retries;
>  
>  /* Function prototypes for an ipaq */
>  static int  ipaq_open (struct usb_serial_port *port, struct file *filp);
> @@ -583,7 +584,7 @@ static int ipaq_open(struct usb_serial_p
>  	struct ipaq_private	*priv;
>  	struct ipaq_packet	*pkt;
>  	int			i, result = 0;
> -	int			retries = KP_RETRIES;
> +	int			retries = connect_retries;
>  
>  	dbg("%s - port %d", __FUNCTION__, port->number);
>  
> @@ -681,6 +682,7 @@ enomem:
>  	result = -ENOMEM;
>  	err("%s - Out of memory", __FUNCTION__);
>  error:
> +	usb_kill_urb(port->read_urb);
>  	ipaq_destroy_lists(port);
>  	kfree(priv);
>  	return result;
> @@ -855,6 +857,7 @@ static void ipaq_write_bulk_callback(str
>  	
>  	if (urb->status) {
>  		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__, urb->status);
> +		return;
>  	}
>  
>  	spin_lock_irqsave(&write_list_lock, flags);
> @@ -967,3 +970,6 @@ MODULE_PARM_DESC(vendor, "User specified
>  
>  module_param(product, ushort, 0);
>  MODULE_PARM_DESC(product, "User specified USB idProduct");
> +
> +module_param(connect_retries, int, KP_RETRIES);

I really do not think that you want KP_RETRIES as a mode value in sysfs
:)

This is not how you pre-initialize a module parameter...

thanks,

greg k-h

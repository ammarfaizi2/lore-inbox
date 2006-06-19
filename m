Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWFSRev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWFSRev (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWFSRev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:34:51 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:3750 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1750712AbWFSReu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:34:50 -0400
Date: Mon, 19 Jun 2006 19:34:28 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RESEND] [PATCH 2/2] ipaq.c timing parameters
Message-ID: <20060619173428.GD32484@fks.be>
References: <20060619084446.GA17103@fks.be> <20060619084619.GB17103@fks.be> <20060619134240.68785a33@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619134240.68785a33@doriath.conectiva>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-103.497,
	vereist 5, ALL_TRUSTED -3.30, AWL -2.20, BAYES_50 2.00,
	USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 01:42:40PM -0300, Luiz Fernando N. Capitulino wrote:
> On Mon, 19 Jun 2006 10:46:19 +0200
> Frank Gevaerts <frank.gevaerts@fks.be> wrote:
> 
> | Adds configurable waiting periods to the ipaq connection code. These are
> | not needed when the pocketpc device is running normally when plugged in,
> | but they need extra delays if they are physically connected while
> | rebooting.
> | There are two parameters :
> | * initial_wait : this is the delay before the driver attemts to start the
> |   connection. This is needed because the pocktpc device takes much
> |   longer to boot if the driver starts sending control packets too soon.
> | * connect_retries : this is the number of times the control urb is
> |   retried before finally giving up. The patch also adds a 1 second delay
> |   between retries.
> | I'm not sure if the cases where this patch is useful are general enough
> | to include this in the kernel.
> | 
> | Signed-off-by: Frank Gevaerts <frank.gevaerts@fks.be>
> | 
> | diff -urp linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c linux-2.6.17-rc6.b/drivers/usb/serial/ipaq.c
> | --- linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c	2006-06-14 16:02:03.000000000 +0200
> | +++ linux-2.6.17-rc6.b/drivers/usb/serial/ipaq.c	2006-06-14 16:06:44.000000000 +0200
> | @@ -71,6 +71,8 @@
> |  
> |  static __u16 product, vendor;
> |  static int debug;
> | +static int connect_retries = KP_RETRIES;
> | +static int initial_wait;
> |  
> |  /* Function prototypes for an ipaq */
> |  static int  ipaq_open (struct usb_serial_port *port, struct file *filp);
> | @@ -583,7 +585,7 @@ static int ipaq_open(struct usb_serial_p
> |  	struct ipaq_private	*priv;
> |  	struct ipaq_packet	*pkt;
> |  	int			i, result = 0;
> | -	int			retries = KP_RETRIES;
> | +	int			retries = connect_retries;
> |  
> |  	dbg("%s - port %d", __FUNCTION__, port->number);
> |  
> | @@ -647,6 +649,7 @@ static int ipaq_open(struct usb_serial_p
> |  	port->read_urb->transfer_buffer_length = URBDATA_SIZE;
> |  	port->bulk_out_size = port->write_urb->transfer_buffer_length = URBDATA_SIZE;
> |  	
> | +	msleep(1000*initial_wait);
> 
>  I was going to say you should use ssleep() here, but I can't find a
> ssleep_interruptible(). Then either: use msleep_interruptible() or
> creates a new ssleep_interruptible().

I wasn't sure if that was safe here, so I used the non-interruptible
version. I'll change it when I redo the patch.
Is it worth it creating ssleep_interruptible() just for this one call?

> |  	/* Start reading from the device */
> |  	usb_fill_bulk_urb(port->read_urb, serial->dev, 
> |  		      usb_rcvbulkpipe(serial->dev, port->bulk_in_endpointAddress),
> | @@ -673,6 +676,7 @@ static int ipaq_open(struct usb_serial_p
> |  			}
> |  			return 0;
> |  		}
> | +		msleep(1000);
> |  	}
> 
>  Don't you want msleep(100); here?

The currently running version has 1000. 100 is probably better.

I'll submit a new patch once it's clear which version of the first patch
goes in.

> 
> -- 
> Luiz Fernando N. Capitulino

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19

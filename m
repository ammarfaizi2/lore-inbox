Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWFSQmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWFSQmr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 12:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWFSQmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 12:42:47 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:53441 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964793AbWFSQmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 12:42:46 -0400
Date: Mon, 19 Jun 2006 13:42:40 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RESEND] [PATCH 2/2] ipaq.c timing parameters
Message-ID: <20060619134240.68785a33@doriath.conectiva>
In-Reply-To: <20060619084619.GB17103@fks.be>
References: <20060619084446.GA17103@fks.be>
	<20060619084619.GB17103@fks.be>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.9.3; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 10:46:19 +0200
Frank Gevaerts <frank.gevaerts@fks.be> wrote:

| Adds configurable waiting periods to the ipaq connection code. These are
| not needed when the pocketpc device is running normally when plugged in,
| but they need extra delays if they are physically connected while
| rebooting.
| There are two parameters :
| * initial_wait : this is the delay before the driver attemts to start the
|   connection. This is needed because the pocktpc device takes much
|   longer to boot if the driver starts sending control packets too soon.
| * connect_retries : this is the number of times the control urb is
|   retried before finally giving up. The patch also adds a 1 second delay
|   between retries.
| I'm not sure if the cases where this patch is useful are general enough
| to include this in the kernel.
| 
| Signed-off-by: Frank Gevaerts <frank.gevaerts@fks.be>
| 
| diff -urp linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c linux-2.6.17-rc6.b/drivers/usb/serial/ipaq.c
| --- linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c	2006-06-14 16:02:03.000000000 +0200
| +++ linux-2.6.17-rc6.b/drivers/usb/serial/ipaq.c	2006-06-14 16:06:44.000000000 +0200
| @@ -71,6 +71,8 @@
|  
|  static __u16 product, vendor;
|  static int debug;
| +static int connect_retries = KP_RETRIES;
| +static int initial_wait;
|  
|  /* Function prototypes for an ipaq */
|  static int  ipaq_open (struct usb_serial_port *port, struct file *filp);
| @@ -583,7 +585,7 @@ static int ipaq_open(struct usb_serial_p
|  	struct ipaq_private	*priv;
|  	struct ipaq_packet	*pkt;
|  	int			i, result = 0;
| -	int			retries = KP_RETRIES;
| +	int			retries = connect_retries;
|  
|  	dbg("%s - port %d", __FUNCTION__, port->number);
|  
| @@ -647,6 +649,7 @@ static int ipaq_open(struct usb_serial_p
|  	port->read_urb->transfer_buffer_length = URBDATA_SIZE;
|  	port->bulk_out_size = port->write_urb->transfer_buffer_length = URBDATA_SIZE;
|  	
| +	msleep(1000*initial_wait);

 I was going to say you should use ssleep() here, but I can't find a
ssleep_interruptible(). Then either: use msleep_interruptible() or
creates a new ssleep_interruptible().

|  	/* Start reading from the device */
|  	usb_fill_bulk_urb(port->read_urb, serial->dev, 
|  		      usb_rcvbulkpipe(serial->dev, port->bulk_in_endpointAddress),
| @@ -673,6 +676,7 @@ static int ipaq_open(struct usb_serial_p
|  			}
|  			return 0;
|  		}
| +		msleep(1000);
|  	}

 Don't you want msleep(100); here?

-- 
Luiz Fernando N. Capitulino

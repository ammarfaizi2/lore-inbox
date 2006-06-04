Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932201AbWFDUm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWFDUm3 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 16:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWFDUm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 16:42:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:229 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932201AbWFDUm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 16:42:28 -0400
Date: Sun, 4 Jun 2006 13:42:10 -0700
From: Greg KH <greg@kroah.com>
To: Vitja Makarov <vitja.makarov@gmail.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftdi_sio patch
Message-ID: <20060604204210.GC23895@kroah.com>
References: <1925ef8a0606041248i56b99f5s5fb93c6d92a6a9fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1925ef8a0606041248i56b99f5s5fb93c6d92a6a9fc@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 11:48:54PM +0400, Vitja Makarov wrote:
> Hi!
> 
> I've found that ftdi_sio driver have problems it could ran out of memory,
> or lead kernel panic. The problem is in ftdi_write function, it
> allocates new urb structure each time write() is called.
> 
> The following patch fixes this problems. Code is mostly based on pl2303 
> code.
> I moved buffer code into separate file serial-buf.h as it could be
> userful for other drivers.
> 
> Signed-off-by: Vitja Makarov <vitja.makarov@gmail.com>
> 
> vitja.
> 
> diff -uprN orig/drivers/usb/serial/ftdi_sio.c 
> new/drivers/usb/serial/ftdi_sio.c
> --- orig/drivers/usb/serial/ftdi_sio.c	2006-03-28 01:05:57.000000000 +0400
> +++ new/drivers/usb/serial/ftdi_sio.c	2006-05-28 23:58:50.000000000 +0400
> @@ -260,6 +260,7 @@
> #include <linux/serial.h>
> #include "usb-serial.h"
> #include "ftdi_sio.h"
> +#include "serial-buf.h"
> 
> /*
>  * Version Information
> @@ -268,6 +269,8 @@
> #define DRIVER_AUTHOR "Greg Kroah-Hartman <greg@kroah.com>, Bill
> Ryder <bryder@sgi.com>, Kuba Ober <kuba@mareimbrium.org>"
> #define DRIVER_DESC "USB FTDI Serial Converters Driver"
> 
> +#define MIN(a,b) ((a)>(b)?(b):(a))

Please us the built in kernel min() function.  This one is wrong...

> static int debug;
> static __u16 vendor = FTDI_VID;
> static __u16 product;
> @@ -545,6 +548,11 @@ struct ftdi_private {
> 
> 	int force_baud;		/* if non-zero, force the baud rate to this 
> 	value */
> 	int force_rtscts;	/* if non-zero, force RTS-CTS to always be 
> 	enabled */
> +
> +	spinlock_t lock;		   /* private lock */
> +	
> +	struct serial_buf *buf; /* write buffer */
> +	int write_urb_in_use;   /* write urb in use indicator */
> };
> 
> /* Used for TIOCMIWAIT */
> @@ -562,6 +570,7 @@ static void ftdi_shutdown		(struct usb_s
> static int  ftdi_open			(struct usb_serial_port *port, 
> struct file *filp);
> static void ftdi_close			(struct usb_serial_port *port, 
> struct file *filp);
> static int  ftdi_write			(struct usb_serial_port *port, const
> unsigned char *buf, int count);
> +static void ftdi_send                   (struct usb_serial_port *port);
> static int  ftdi_write_room		(struct usb_serial_port *port);
> static int  ftdi_chars_in_buffer	(struct usb_serial_port *port);
> static void ftdi_write_bulk_callback	(struct urb *urb, struct pt_regs 
> *regs);
> @@ -1066,6 +1075,8 @@ static ssize_t store_event_char(struct d
> 			     v, priv->interface,
> 			     buf, 0, WDR_TIMEOUT);
> 	
> +	
> +	

Why add lines of whitespace?  Especially ones with trailing spaces :(

> 	if (rv < 0) {
> 		dbg("Unable to write event character: %i", rv);
> 		return -EIO;
> @@ -1138,6 +1149,7 @@ static int ftdi_sio_attach (struct usb_s
> 	struct usb_serial_port *port = serial->port[0];
> 	struct ftdi_private *priv;
> 	struct ftdi_sio_quirk *quirk;
> +	unsigned char *transfer_buffer;
> 	
> 	dbg("%s",__FUNCTION__);
> 
> @@ -1147,6 +1159,7 @@ static int ftdi_sio_attach (struct usb_s
> 		return -ENOMEM;
> 	}
> 	memset(priv, 0, sizeof(*priv));
> +	spin_lock_init(&priv->lock);
> 
> 	spin_lock_init(&priv->rx_lock);
>         init_waitqueue_head(&priv->delta_msr_wait);
> @@ -1167,14 +1180,22 @@ static int ftdi_sio_attach (struct usb_s
> 	}
> 
> 	INIT_WORK(&priv->rx_work, ftdi_process_read, port);
> +
> +	/* Try to increase the size of write buffer */
> +	transfer_buffer = (unsigned char *) kmalloc(SERIAL_BUF_SIZE, 
> GFP_KERNEL);

cast is not needed.

> +
> +	if (transfer_buffer) {
> +                port->write_urb->transfer_buffer = transfer_buffer;
> +                port->write_urb->transfer_buffer_length = SERIAL_BUF_SIZE;
> +	}
> 
> 	/* Free port's existing write urb and transfer buffer. */
> -	if (port->write_urb) {
> -		usb_free_urb (port->write_urb);
> -		port->write_urb = NULL;
> +	priv->buf = serial_buf_alloc(SERIAL_BUF_SIZE);
> +	if (priv->buf == NULL) {
> +		kfree(port->bulk_in_buffer);
> +		kfree(priv);
> +		return -ENOMEM;
> 	}
> -	kfree(port->bulk_out_buffer);
> -	port->bulk_out_buffer = NULL;
> 
> 	usb_set_serial_port_data(serial->port[0], priv);
> 
> @@ -1246,6 +1267,7 @@ static void ftdi_shutdown (struct usb_se
> 	 */
> 
> 	if (priv) {
> +		serial_buf_free(priv->buf);
> 		usb_set_serial_port_data(port, NULL);
> 		kfree(priv);
> 	}
> @@ -1345,128 +1367,137 @@ static void ftdi_close (struct usb_seria
> 	/* shutdown our bulk read */
> 	if (port->read_urb)
> 		usb_kill_urb(port->read_urb);
> +
> +	/* shutdown our bulk write */
> +	if (port->write_urb)	
> +	    usb_kill_urb(port->write_urb);

Trailing white space and improper indentation :(

> +
> } /* ftdi_close */
> 
> +static int ftdi_write(struct usb_serial_port *port, const unsigned
> char *buf, int count)

Patch is linewrapped :(

> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	unsigned long flags;
> +	

Trailing whitespace added :(

> +struct serial_buf {
> +	unsigned int	buf_size;
> +	char		*buf_buf;
> +	char		*buf_get;
> +	char		*buf_put;
> +};


We already have a circular buffer structure in the kernel.  Please use
that one instead of creating your own again.

thanks,

greg k-h

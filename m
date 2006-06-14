Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWFNOWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWFNOWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWFNOWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:22:12 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:38048 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S964973AbWFNOWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:22:11 -0400
Date: Wed, 14 Jun 2006 16:21:48 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <gregkh@suse.de>, Pete Zaitcev <zaitcev@redhat.com>,
       lcapitulino@mandriva.com.br, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] ipaq.c connection open timing parameters
Message-ID: <20060614142148.GC5814@fks.be>
References: <20060530115329.30184aa0@doriath.conectiva> <20060530174821.GA15969@fks.be> <20060530113327.297aceb7.zaitcev@redhat.com> <20060531213828.GA17711@fks.be> <20060531215523.GA13745@suse.de> <20060531224245.GB17711@fks.be> <20060531224624.GA17667@suse.de> <20060601191840.GB1757@fks.be> <20060614115822.GB20751@fks.be> <20060614120551.GC20751@fks.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060614120551.GC20751@fks.be>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-103.507,
	vereist 5, ALL_TRUSTED -3.30, AWL -2.21, BAYES_50 2.00,
	USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 02:05:52PM +0200, Frank Gevaerts wrote:
> Adds configurable waiting periods to the ipaq connection code. These are
> not needed when the pocketpc device is running normally when plugged in,
> but they need extra delays if they are physically connected while
> rebooting.

This won't apply cleanly because of the mistake I made in the
correctness patch. Here's the new version:

Adds configurable waiting periods to the ipaq connection code. These are
not needed when the pocketpc device is running normally when plugged in,
but they need extra delays if they are physically connected while
rebooting.
There are two parameters :
* initial_wait : this is the delay before the driver attemts to start the
  connection. This is needed because the pocktpc device takes much
  longer to boot if the driver starts sending control packets too soon.
* connect_retries : this is the number of times the control urb is
  retried before finally giving up. The patch also adds a 1 second delay
  between retries.
I'm not sure if the cases where this patch is useful are general enough
to include this in the kernel.

Signed-off-by: Frank Gevaerts <frank.gevaerts@fks.be>

diff -urp linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c linux-2.6.17-rc6.b/drivers/usb/serial/ipaq.c
--- linux-2.6.17-rc6.a/drivers/usb/serial/ipaq.c	2006-06-14 16:02:03.000000000 +0200
+++ linux-2.6.17-rc6.b/drivers/usb/serial/ipaq.c	2006-06-14 16:06:44.000000000 +0200
@@ -71,6 +71,8 @@
 
 static __u16 product, vendor;
 static int debug;
+static int connect_retries = KP_RETRIES;
+static int initial_wait;
 
 /* Function prototypes for an ipaq */
 static int  ipaq_open (struct usb_serial_port *port, struct file *filp);
@@ -583,7 +585,7 @@ static int ipaq_open(struct usb_serial_p
 	struct ipaq_private	*priv;
 	struct ipaq_packet	*pkt;
 	int			i, result = 0;
-	int			retries = KP_RETRIES;
+	int			retries = connect_retries;
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
@@ -647,6 +649,7 @@ static int ipaq_open(struct usb_serial_p
 	port->read_urb->transfer_buffer_length = URBDATA_SIZE;
 	port->bulk_out_size = port->write_urb->transfer_buffer_length = URBDATA_SIZE;
 	
+	msleep(1000*initial_wait);
 	/* Start reading from the device */
 	usb_fill_bulk_urb(port->read_urb, serial->dev, 
 		      usb_rcvbulkpipe(serial->dev, port->bulk_in_endpointAddress),
@@ -673,6 +676,7 @@ static int ipaq_open(struct usb_serial_p
 			}
 			return 0;
 		}
+		msleep(1000);
 	}
 	err("%s - failed doing control urb, error %d", __FUNCTION__, result);
 	goto error;
@@ -968,3 +972,9 @@ MODULE_PARM_DESC(vendor, "User specified
 
 module_param(product, ushort, 0);
 MODULE_PARM_DESC(product, "User specified USB idProduct");
+
+module_param(connect_retries, int, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(connect_retries, "Maximum number of connect retries (100ms each)");
+
+module_param(initial_wait, int, S_IRUGO|S_IWUSR);
+MODULE_PARM_DESC(initial_wait, "Time to wait before attempting a connection (in seconds)");


-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19

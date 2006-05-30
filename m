Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWE3Rs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWE3Rs7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWE3Rs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:48:59 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:60620 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S932291AbWE3Rs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:48:58 -0400
Date: Tue, 30 May 2006 19:48:21 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060530174821.GA15969@fks.be>
References: <20060529120102.1bc28bf2@doriath.conectiva> <20060529132553.08b225ba@doriath.conectiva> <20060529141110.6d149e21@doriath.conectiva> <20060529194334.GA32440@fks.be> <20060529172410.63dffa72@doriath.conectiva> <20060529204724.GA22250@fks.be> <20060529193330.3c51f3ba@home.brethil> <20060530082141.GA26517@fks.be> <20060530113801.22c71afe@doriath.conectiva> <20060530115329.30184aa0@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530115329.30184aa0@doriath.conectiva>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.815,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.08,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 11:53:29AM -0300, Luiz Fernando N. Capitulino wrote:
> On Tue, 30 May 2006 11:38:01 -0300
> "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
> 
>  If it ran _before_ the timeout expires with no timeout error it does not
> depend. Then we can do the simpler solution: just kill the read urb in the
> ipaq_open's error path.

That seems to work.
I also found that both the return in ipaq_write_bulk_callback and the
flush_scheduled_work() in destroy_serial() are needed to get rid of the
usb_serial_disconnect() bug.

It's now running with the following patch:

Signed-off-by: Frank Gevaerts <frank.gevaerts@fks.be>

diff -pur linux-2.6.17-rc4/drivers/usb/serial/ipaq.c linux-2.6.17-rc4.test/drivers/usb/serial/ipaq.c
--- linux-2.6.17-rc4/drivers/usb/serial/ipaq.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc4.test/drivers/usb/serial/ipaq.c	2006-05-30 19:41:19.000000000 +0200
@@ -71,6 +71,7 @@
 
 static __u16 product, vendor;
 static int debug;
+static int connect_retries;
 
 /* Function prototypes for an ipaq */
 static int  ipaq_open (struct usb_serial_port *port, struct file *filp);
@@ -583,7 +584,7 @@ static int ipaq_open(struct usb_serial_p
 	struct ipaq_private	*priv;
 	struct ipaq_packet	*pkt;
 	int			i, result = 0;
-	int			retries = KP_RETRIES;
+	int			retries = connect_retries;
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
@@ -681,6 +682,7 @@ enomem:
 	result = -ENOMEM;
 	err("%s - Out of memory", __FUNCTION__);
 error:
+	usb_kill_urb(port->read_urb);
 	ipaq_destroy_lists(port);
 	kfree(priv);
 	return result;
@@ -692,6 +694,7 @@ static void ipaq_close(struct usb_serial
 	struct ipaq_private	*priv = usb_get_serial_port_data(port);
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
+
 			 
 	/*
 	 * shut down bulk read and write
@@ -855,6 +858,7 @@ static void ipaq_write_bulk_callback(str
 	
 	if (urb->status) {
 		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__, urb->status);
+		return;
 	}
 
 	spin_lock_irqsave(&write_list_lock, flags);
@@ -967,3 +971,6 @@ MODULE_PARM_DESC(vendor, "User specified
 
 module_param(product, ushort, 0);
 MODULE_PARM_DESC(product, "User specified USB idProduct");
+
+module_param(connect_retries, int, KP_RETRIES);
+MODULE_PARM_DESC(product, "Maximum number of connect retries (100ms each)");
diff -pur linux-2.6.17-rc4/drivers/usb/serial/usb-serial.c linux-2.6.17-rc4.test/drivers/usb/serial/usb-serial.c
--- linux-2.6.17-rc4/drivers/usb/serial/usb-serial.c	2006-05-30 19:01:16.000000000 +0200
+++ linux-2.6.17-rc4.test/drivers/usb/serial/usb-serial.c	2006-05-30 19:01:24.000000000 +0200
@@ -162,6 +162,8 @@ static void destroy_serial(struct kref *
 		}
 	}
 
+	flush_scheduled_work();		/* port->work */
+
 	usb_put_dev(serial->dev);
 
 	/* free up any memory that we allocated */

Frank

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19

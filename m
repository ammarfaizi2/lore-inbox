Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbUJWXAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbUJWXAj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 19:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbUJWXAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 19:00:38 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:29544 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261327AbUJWXA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 19:00:26 -0400
Subject: Re: pl2303/usb-serial driver problem in 2.4.27-pre6
From: Paul Fulghum <paulkf@microgate.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Greg KH <greg@kroah.com>, Oleksiy <Oleksiy@kharkiv.com.ua>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041023180625.GA12113@logos.cnet>
References: <416A6CF8.5050106@kharkiv.com.ua>
	 <20041012171004.GB11750@kroah.com>  <20041023180625.GA12113@logos.cnet>
Content-Type: text/plain
Message-Id: <1098572412.5996.6.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 23 Oct 2004 18:00:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 13:06, Marcelo Tosatti wrote:
> On Tue, Oct 12, 2004 at 10:10:04AM -0700, Greg KH wrote:
> > On Mon, Oct 11, 2004 at 02:22:32PM +0300, Oleksiy wrote:
> > > Hi all,
> > > 
> > > I have a problem using GPRS inet vi my Siemens S55 attached with USB 
> > > cable since kernel version 2.4.27-pre5, the link is established well, 
> > > but then no packets get received, looking with tcpdump shows outgoing 
> > > ping packets and just few per several minutes received back. I'm unable 
> > > to ping, do nslookup, etc.
> > > The problem started when i switched from kernel 2.4.26 (linux slackware 
> > > 10.0) to 2.4.28-pre3. None of ppp otions haven't changed and all the 
> > > same options were set during kerenel config. So i decided to test all 
> > > kernels between 2.4.26 and 2.4.28-pre4 (also not working). Link works 
> > > well in 2.4.27-pre5 and stop working in 2.4.27-pre6. No "strange" 
> > > messages or errors in the logs. firewall is disabled (ACCEPT for all).
> > 
> > Can you enable CONFIG_DEBUG?
> > 
> > There were no pl2303 driver changes between 2.4.27-pre5 and pre6, so I
> > don't think it's that driver...

--- linux-2.4.27-pre5/drivers/usb/serial/pl2303.c	2004-04-14 08:05:35.000000000 -0500
+++ linux-2.4.27-pre6/drivers/usb/serial/pl2303.c	2004-10-23 17:47:34.000000000 -0500
@@ -107,6 +107,7 @@ MODULE_DEVICE_TABLE (usb, id_table);
 #define VENDOR_READ_REQUEST		0x01
 
 #define UART_STATE			0x08
+#define UART_STATE_TRANSIENT_MASK	0x74
 #define UART_DCD			0x01
 #define UART_DSR			0x02
 #define UART_BREAK_ERROR		0x04
@@ -198,6 +199,9 @@ static int pl2303_write (struct usb_seri
 
 	dbg("%s - port %d, %d bytes", __FUNCTION__, port->number, count);
 
+	if (!count)
+		return count;
+
 	if (port->write_urb->status == -EINPROGRESS) {
 		dbg("%s - already writing", __FUNCTION__);
 		return 0;
@@ -678,6 +682,7 @@ static void pl2303_read_int_callback (st
 	struct pl2303_private *priv = usb_get_serial_port_data(port);
 	unsigned char *data = urb->transfer_buffer;
 	unsigned long flags;
+	u8 uart_state;
 
 	dbg("%s (%d)", __FUNCTION__, port->number);
 
@@ -708,8 +713,10 @@ static void pl2303_read_int_callback (st
 		return;
 
 	/* Save off the uart status for others to look at */
+	uart_state = data[UART_STATE];
 	spin_lock_irqsave(&priv->lock, flags);
-	priv->line_status = data[UART_STATE];
+	uart_state |= (priv->line_status & UART_STATE_TRANSIENT_MASK);
+	priv->line_status = uart_state;
 	spin_unlock_irqrestore(&priv->lock, flags);
 	wake_up_interruptible (&priv->delta_msr_wait);
 
@@ -767,7 +774,9 @@ static void pl2303_read_bulk_callback (s
 
 	spin_lock_irqsave(&priv->lock, flags);
 	status = priv->line_status;
+	priv->line_status &= ~UART_STATE_TRANSIENT_MASK;
 	spin_unlock_irqrestore(&priv->lock, flags);
+	wake_up_interruptible (&priv->delta_msr_wait); //AF from 2.6
 
 	/* break takes precedence over parity, */
 	/* which takes precedence over framing errors */

-- 
Paul Fulghum
paulkf@microgate.com



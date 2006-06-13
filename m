Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWFMLqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWFMLqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 07:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWFMLqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 07:46:55 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:205 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1751090AbWFMLqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 07:46:54 -0400
Date: Tue, 13 Jun 2006 13:46:06 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: Mark Lord <lkml@rtr.ca>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb, error -28
Message-ID: <20060613114604.GB10834@fks.be>
References: <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD50F.3060002@rtr.ca> <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD968.2010000@rtr.ca> <20060612212812.GA17458@suse.de> <448DE28D.3040708@rtr.ca> <448DF6F6.2050803@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448DF6F6.2050803@rtr.ca>
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-103.52,
	vereist 5, ALL_TRUSTED -3.30, AWL -2.22, BAYES_50 2.00,
	USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 07:21:26PM -0400, Mark Lord wrote:
> Mark Lord wrote:
> >Greg KH wrote:
> >>So we should have finally covered both of them now.
> >
> >Yes, agreed.
> >
> >So if modify pl2303_open() to have it simulate -ENOMEM from 
> >usb_submit_urb(),
> >then this should not crash the entire USB subsystem.  Right?
> >
> >Ditto if it happens due to low-memory, rather than me hacking the code 
> >to test it?
> 
> Mmmm.. looks like it's still buggy, but we manage to avoid the bug
> under *most* circumstances.   Which is good!
> 
> But the bug will still need to be fixed.  A failure from usb_submit_urb()
> should not require a reboot to recover.
> Here's the results of a simulated -ENOMEM test:
> 
> kernel BUG at kernel/workqueue.c:110!

We had the exact same error here with ipaq.ko. Our problems only went
away once we applied the following (the first part might already be
applied).
Apart from that, we also needed a lot of fixes in ipaq.c. I still have
to clean up and submit the complete patch.

Frank

Signed-of-byA Frank Gevaerts <frank.gevaerts@fks.be>

--- linux-2.6.17-rc4/drivers/usb/serial/usb-serial.c	2006-05-30 19:01:16.000000000 +0200
+++ linux-2.6.17-rc4.test/drivers/usb/serial/usb-serial.c	2006-06-02 21:50:07.000000000 +0200
@@ -162,6 +162,8 @@ static void destroy_serial(struct kref *
 		}
 	}
 
+	flush_scheduled_work();		/* port->work */
+
 	usb_put_dev(serial->dev);
 
 	/* free up any memory that we allocated */
@@ -223,6 +225,8 @@ static int serial_open (struct tty_struc
 	return 0;
 
 bailout_module_put:
+	tty->driver_data = NULL;
+	port->tty = NULL;
 	module_put(serial->type->driver.owner);
 bailout_kref_put:
 	kref_put(&serial->kref, destroy_serial);

Frank

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19

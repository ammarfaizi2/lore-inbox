Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbTJJST3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbTJJST3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:19:29 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:49156 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262018AbTJJST1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:19:27 -0400
Date: Fri, 10 Oct 2003 22:19:19 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, mru@users.sourceforge.net
Subject: Re: USB and DMA on Alpha with 2.6.0-test7
Message-ID: <20031010221919.A650@den.park.msu.ru>
References: <3F86E9D7.9020104@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F86E9D7.9020104@pacbell.net>; from david-b@pacbell.net on Fri, Oct 10, 2003 at 10:18:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 10:18:15AM -0700, David Brownell wrote:
> We might need arch-specific implementations of that
> method, and maybe Alpha is even one of them.  But if
> there's going to be a default implementation for that
> method, the current scheme has portability problems.

Sigh. The generic dma_* stuff wasn't a well thought-out idea,
and it's too late to change it in 2.6. :-(
Right now calling dma_* functions for non-busmaster devices
just *doesn't work*.

> Nope -- there's EHCI, which can handle 64-bit DMA when the
> silicon allows ... which is why that test exists.

That test is not a test at all - it's precise equivalent
of "if (1)" on i386. On other platforms it's just a BUG().
I'd suggest following (untested) patch.

Ivan.

--- t7/drivers/usb/net/usbnet.c	Wed Oct  8 23:24:07 2003
+++ linux/drivers/usb/net/usbnet.c	Fri Oct 10 22:10:24 2003
@@ -2970,7 +2970,7 @@ usbnet_probe (struct usb_interface *udev
 	memcpy (net->dev_addr, node_id, sizeof node_id);
 
 	// possible with some EHCI controllers
-	if (dma_supported (&udev->dev, 0xffffffffffffffffULL))
+	if (*udev->dev->dma_mask == 0xffffffffffffffffULL))
 		net->features |= NETIF_F_HIGHDMA;
 
 	net->change_mtu = usbnet_change_mtu;
--- t7/drivers/usb/net/kaweth.c	Wed Oct  8 23:24:26 2003
+++ linux/drivers/usb/net/kaweth.c	Fri Oct 10 22:11:21 2003
@@ -1120,7 +1120,7 @@ static int kaweth_probe(
 
 	usb_set_intfdata(intf, kaweth);
 
-	if (dma_supported (&intf->dev, 0xffffffffffffffffULL))
+	if (*intf->dev->dma_mask == 0xffffffffffffffffULL))
 		kaweth->net->features |= NETIF_F_HIGHDMA;
 
 	SET_NETDEV_DEV(netdev, &intf->dev);

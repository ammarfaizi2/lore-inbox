Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264983AbUELNNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264983AbUELNNm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 09:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUELNNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 09:13:42 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:26247 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S264983AbUELNNj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 09:13:39 -0400
Subject: Re: [PATCH] hci-usb bugfix
From: Marcel Holtmann <marcel@holtmann.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Sebastian Schmidt <yath@yath.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0405110947150.911-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0405110947150.911-100000@ida.rowland.org>
Content-Type: text/plain
Message-Id: <1084367596.25099.9.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 15:13:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> Oliver was right about not using interfaces after they have been released.
> I think the best approach will be for the hci_usb_disconnect() routine to 
> release both interfaces when it is called.  Something like this:
> 
>     In hci_usb.h, add to struct hci_usb:
> 	struct usb_interface		*acl_iface;
> 
>     In hci_usb_probe, add near the end:
> 	husb->acl_iface = intf;
> 
>     In hci_usb_disconnect, add:
> 
> 	/* Always release both interfaces whenever we must release either */
> 	if (intf == husb->isoc_iface)
> 		usb_driver_release_interface(&hci_usb_driver,
> 				husb->acl_iface);
> 	else if (husb->isoc_iface)
> 		usb_driver_release_interface(&hci_usb_driver, 
> 				husb->isoc_iface);
> 
> It's not necessary to set the interface private pointers back to NULL, 
> since the USB core will do that for you when the interface is released.

actually I was thinking about setting a flag that no more ISOC URB's are
submitted, because the device will still work if the second interface is
disconnected. The ISOC interface is only needed if an SCO link is opened
which would never happen when the Bluetooth chip is configured to route
the SCO traffic over an external PCM interface. Let me think a little
bit about the best way.

Regards

Marcel



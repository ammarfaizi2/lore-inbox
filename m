Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264776AbUEKO7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264776AbUEKO7p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 10:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbUEKO7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 10:59:45 -0400
Received: from ida.rowland.org ([192.131.102.52]:8196 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264776AbUEKO7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 10:59:39 -0400
Date: Tue, 11 May 2004 10:59:38 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Marcel Holtmann <marcel@holtmann.org>
cc: Oliver Neukum <oliver@neukum.org>, Sebastian Schmidt <yath@yath.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hci-usb bugfix
In-Reply-To: <1084212423.9639.47.camel@pegasus>
Message-ID: <Pine.LNX.4.44L0.0405110947150.911-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver was right about not using interfaces after they have been released.
I think the best approach will be for the hci_usb_disconnect() routine to 
release both interfaces when it is called.  Something like this:

    In hci_usb.h, add to struct hci_usb:
	struct usb_interface		*acl_iface;

    In hci_usb_probe, add near the end:
	husb->acl_iface = intf;

    In hci_usb_disconnect, add:

	/* Always release both interfaces whenever we must release either */
	if (intf == husb->isoc_iface)
		usb_driver_release_interface(&hci_usb_driver,
				husb->acl_iface);
	else if (husb->isoc_iface)
		usb_driver_release_interface(&hci_usb_driver, 
				husb->isoc_iface);

It's not necessary to set the interface private pointers back to NULL, 
since the USB core will do that for you when the interface is released.

Alan Stern



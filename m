Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264847AbUEJQOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264847AbUEJQOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264854AbUEJQOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:14:37 -0400
Received: from ida.rowland.org ([192.131.102.52]:1796 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264851AbUEJQNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:13:18 -0400
Date: Mon, 10 May 2004 12:13:17 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Marcel Holtmann <marcel@holtmann.org>
cc: Sebastian Schmidt <yath@yath.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hci-usb bugfix
In-Reply-To: <1084135167.9269.118.camel@pegasus>
Message-ID: <Pine.LNX.4.44L0.0405101211350.669-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 May 2004, Marcel Holtmann wrote:

> Hi Sebastian,
> 
> > this is a little patch against 2.6.6-rc3 which fixes the Oops when
> > unplugging an USB Bluetooth device.
> > 
> > hci_usb_disconnect() got called recursively which caused
> > sysfs_hash_and_remove() finally to dereference a NULL pointer.

> thanks for finding the reason for this problem, because the only thing
> that I knew, was that enabled SCO support caused this problem. I prefer
> to let the USB guys fix it, because this bug should be present for all
> drivers that claimed more than one interface.
> 
> Regards
> 
> Marcel

It looks like the problem is that hci_usb_disconnect() is trying to do too 
much.  When called for the SCO interface it should simply return.

Does this patch improve the situation?

Alan Stern



===== drivers/bluetooth/hci_usb.c 1.44 vs edited =====
--- 1.44/drivers/bluetooth/hci_usb.c	Thu Apr 29 13:33:56 2004
+++ edited/drivers/bluetooth/hci_usb.c	Mon May 10 12:10:31 2004
@@ -918,7 +918,7 @@
 			BT_ERR("Can't set isoc interface settings");
 			isoc_iface = NULL;
 		}
-		usb_driver_claim_interface(&hci_usb_driver, isoc_iface, husb);
+		usb_driver_claim_interface(&hci_usb_driver, isoc_iface, NULL);
 		husb->isoc_iface  = isoc_iface;
 		husb->isoc_in_ep  = isoc_in_ep[isoc_ifnum];
 		husb->isoc_out_ep = isoc_out_ep[isoc_ifnum];


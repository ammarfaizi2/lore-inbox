Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264384AbUEIUjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbUEIUjt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 16:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbUEIUjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 16:39:49 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:1215 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S264384AbUEIUjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 16:39:47 -0400
Subject: Re: [PATCH] hci-usb bugfix
From: Marcel Holtmann <marcel@holtmann.org>
To: Sebastian Schmidt <yath@yath.eu.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <20040509194715.GA2163@eniac.lan.yath.eu.org>
References: <20040509194715.GA2163@eniac.lan.yath.eu.org>
Content-Type: text/plain
Message-Id: <1084135167.9269.118.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 09 May 2004 22:39:27 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

> this is a little patch against 2.6.6-rc3 which fixes the Oops when
> unplugging an USB Bluetooth device.
> 
> hci_usb_disconnect() got called recursively which caused
> sysfs_hash_and_remove() finally to dereference a NULL pointer.
> 
> --- SNIP ---
> diff -uNr linux-2.6.6-rc3.old/drivers/bluetooth/hci_usb.c linux-2.6.6-rc3/drivers/bluetooth/hci_usb.c
> --- linux-2.6.6-rc3.old/drivers/bluetooth/hci_usb.c     2004-05-09 20:25:00.000000000 +0200
> +++ linux-2.6.6-rc3/drivers/bluetooth/hci_usb.c 2004-05-09 20:28:30.000000000 +0200
> @@ -986,8 +986,21 @@
> 
>         hci_usb_close(hdev);
> 
> -       if (husb->isoc_iface)
> +       if (husb->isoc_iface) {
> +#if 0
>                 usb_driver_release_interface(&hci_usb_driver, husb->isoc_iface);
> +#else
> +               /* do the same as usb_driver_release_interface would do,
> +                * except calling diconnect().
> +                * usb_driver_release_interface() _does_ check if
> +                *  are in disconnect() or add, but I really dunno 
> +                *  where dev->driver_list or dev->bus_list gets set.
> +                *      -- yath
> +                */
> +               husb->isoc_iface->dev.driver = NULL;
> +               usb_set_intfdata(husb->isoc_iface, NULL);
> +#endif
> +       }
> 
>         if (hci_unregister_dev(hdev) < 0)
>                 BT_ERR("Can't unregister HCI device %s", hdev->name);
> --- SNAP ---
> 
> Please apply it,

thanks for finding the reason for this problem, because the only thing
that I knew, was that enabled SCO support caused this problem. I prefer
to let the USB guys fix it, because this bug should be present for all
drivers that claimed more than one interface.

Regards

Marcel



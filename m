Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264404AbUEIWiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264404AbUEIWiL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 18:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbUEIWiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 18:38:11 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:25748 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S264404AbUEIWiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 18:38:05 -0400
To: linux-kernel@vger.kernel.org
Date: Mon, 10 May 2004 00:37:59 +0200
From: Soeren Sonnenburg <kernel@nn7.de>
Message-ID: <pan.2004.05.09.22.37.55.951344@nn7.de>
Organization: Local Intranet News
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
References: <20040509194715.GA2163@eniac.lan.yath.eu.org>
Subject: Re: [PATCH] hci-usb bugfix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 May 2004 19:47:15 +0000, Sebastian Schmidt wrote:

> Hi,
> 
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
>

indeed it fixes this oops ... however I still get 

usb 2-1: USB disconnect, address 4
usb 2-1: new full speed USB device using address 5
devfs_mk_dev: could not append to parent for bluetooth/rfcomm/0
devfs_remove: bluetooth/rfcomm/0 not found, cannot remove
Call trace:
 [c00099c4] dump_stack+0x18/0x28
 [c010af1c] devfs_remove+0xcc/0xd0
 [c01e4a5c] tty_unregister_device+0x30/0x5c
 [f2080b64] rfcomm_dev_destruct+0x50/0xd4 [rfcomm]
 [f2081310] rfcomm_release_dev+0xf8/0x148 [rfcomm]
 [f20807a8] rfcomm_sock_ioctl+0x34/0x58 [rfcomm]
 [c02a8668] sock_ioctl+0xc0/0x2c0
 [c00726e0] sys_ioctl+0x100/0x318
 [c0005d60] ret_from_syscall+0x0/0x44
usb 2-1: USB disconnect, address 5

occasionally...

Soeren

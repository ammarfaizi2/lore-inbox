Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUCXUOQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbUCXUOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:14:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:211 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261160AbUCXUOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:14:09 -0500
Date: Wed, 24 Mar 2004 12:16:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexander Hoogerhuis <alexh@boxed.no>
Cc: linux-kernel@vger.kernel.org, marcel@holtmann.org
Subject: Re: 2.6.5-rc2-mm2
Message-Id: <20040324121614.10d22568.akpm@osdl.org>
In-Reply-To: <87smfynvhn.fsf@dorker.boxed.no>
References: <20040323232511.1346842a.akpm@osdl.org>
	<87smfynvhn.fsf@dorker.boxed.no>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@boxed.no> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> >
> > [SNIP]
> >
>  
> I'm getting this oops when booting my shiny new HP nc6000 laptop
> (PM-1.6 with integrated bluetooth and stuff) with bluetooth enabled:
> 
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: HCI USB driver ver 2.5
> drivers/usb/core/usb.c: registered new driver hci_usb
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>  printing eip:
> e08c56be
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<e08c56be>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.5-rc2-mm2)
> EIP is at usb_disable_interface+0x11/0x3f [usbcore]
> eax: dea7f000   ebx: 00000000   ecx: c03a1310   edx: deb39080
> esi: 00000001   edi: 00000000   ebp: deb65d50   esp: deb65d40
> ds: 007b   es: 007b   ss: 0068
> Process khubd (pid: 5147, threadinfo=deb65000 task=deb423b0)
> Stack: dea7f000 dea7f000 00000001 00000002 deb65d88 e08c5904 00000001 00000002
>        00000001 00000000 00000000 00001388 00000000 ddab4db0 deb39080 00000000
>        ddab4b80 ddab4c38 deb65e34 e09419da 00000246 deb65dd8 00000018 00000003
> Call Trace:
>  [<e08c5904>] usb_set_interface+0x92/0x143 [usbcore]
>  [<e09419da>] hci_usb_probe+0x226/0x46e [hci_usb]
>  [<c01a675e>] inode_doinit_with_dentry+0x3e/0x59a
>  [<e08c0064>] usb_probe_interface+0x56/0x63 [usbcore]
>  [<c01fb727>] bus_match+0x35/0x5e
>  [<c01fb78f>] device_attach+0x3f/0x8f
>  [<c0166129>] dput+0x1c/0x252
>  [<c01fb945>] bus_add_device+0x67/0x9f
>  [<c01fa9d8>] device_add+0x94/0x128
>  [<e08c5c6d>] usb_set_configuration+0x1c9/0x251 [usbcore]
>  [<e08c0f87>] usb_new_device+0x23f/0x3ae [usbcore]
>  [<c011c8a7>] printk+0x121/0x172
>  [<e08c26c3>] hub_port_connect_change+0x172/0x265 [usbcore]
>  [<e08c2a3e>] hub_events+0x288/0x2fa [usbcore]
>  [<e08c2ae0>] hub_thread+0x30/0xdd [usbcore]
>  [<c0118aa1>] default_wake_function+0x0/0xc
>  [<e08c2ab0>] hub_thread+0x0/0xdd [usbcore]
>  [<c0105269>] kernel_thread_helper+0x5/0xb

As far as I can tell, this is impossible.  usb_set_interface() has just
checked that local variable `iface' is non-null, but the crash in
usb_disable_interface() says that incoming arg `intf' is indeed NULL.  So
colour me confused.



I do note a bug in drivers/bluetooth/hci_usb.c:hci_usb_probe(), but it
doesn't explain your oops:

#ifdef CONFIG_BT_HCIUSB_SCO
	if (isoc_iface) {
		BT_DBG("isoc ifnum %d alts %d", isoc_ifnum, isoc_alts);
		if (usb_set_interface(udev, isoc_ifnum, isoc_alts)) {
			BT_ERR("Can't set isoc interface settings");
			isoc_iface = NULL;
		}
		usb_driver_claim_interface(&hci_usb_driver, isoc_iface, husb);

If usb_set_interface() failed we pass a NULL isoc_iface into
usb_driver_claim_interface(), which will promptly return -EINVAL, which is
then cheerfully ignored.  The error handling here seems flakey.




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932715AbWF1EHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbWF1EHg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 00:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbWF1EHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 00:07:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46266 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932715AbWF1EHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 00:07:35 -0400
Date: Tue, 27 Jun 2006 21:07:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] Input update for 2.6.17
In-Reply-To: <1151437593.25011.38.camel@localhost>
Message-ID: <Pine.LNX.4.64.0606272057160.3927@g5.osdl.org>
References: <200606260235.03718.dtor_core@ameritech.net> 
 <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org>  <20060627063734.GA28135@kroah.com>
  <Pine.LNX.4.64.0606271131590.3927@g5.osdl.org>  <Pine.LNX.4.64.0606271211110.3927@g5.osdl.org>
  <Pine.LNX.4.64.0606271231440.3927@g5.osdl.org> <1151437593.25011.38.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ok, Dmitry's patch fixed one problem, but that one just allows me to get 
further enough that I can now suspend and resume the machine again, but 
there's still something wrong with HCI/USB/Input layer. 

I do believe it's related to the previous problem, because it does end up 
being very _close_, and it's again that usb 5-1 disconnect that seems to 
trigger it (except now it's not at bootup, now it's at resume-time):

	__tx_submit: hci0 tx submit failed urb da8a9cac type 1 err -19
	.. snip snip boring stuff ..
	PM: Adding info for No Bus:usbdev4.5_ep81
	PM: Adding info for No Bus:usbdev4.5
	drivers/usb/core/inode.c: creating file '005'
	hub 5-0:1.0: state 7 ports 2 chg 0006 evt 0006
	uhci_hcd 0000:00:1d.3: port 1 portsc 009b,00
	hub 5-0:1.0: port 1, status 0101, change 0003, 12 Mb/s
	usb 5-1: USB disconnect, address 4
	usb 5-1: usb_disable_device nuking all URBs
	usb 5-1: unregistering interface 5-1:1.0
	PM: Removing info for No Bus:usbdev5.4_ep81
	 usbdev5.4_ep81: ep_device_release called for usbdev5.4_ep81
	PM: Removing info for No Bus:usbdev5.4_ep02
	 usbdev5.4_ep02: ep_device_release called for usbdev5.4_ep02
	PM: Removing info for No Bus:usbdev5.4_ep82
	 usbdev5.4_ep82: ep_device_release called for usbdev5.4_ep82
	slab error in verify_redzone_free(): cache `size-512': memory outside object was overwritten
	 <c0103d31> show_trace+0xd/0x10  <c0104317> dump_stack+0x19/0x1b
	 <c015c5a8> __slab_error+0x17/0x1c  <c015c657> cache_free_debugcheck+0xaa/0x181
	 <c015cc61> kfree+0x75/0xaa  <df0d5146> hci_usb_close+0xbf/0x11d [hci_usb]
	 <df0d51cb> hci_usb_disconnect+0x27/0x67 [hci_usb]  <c02ab0c7> usb_unbind_interface+0x37/0x6e
	 <c024276f> __device_release_driver+0x63/0x79  <c02429c1> device_release_driver+0x2e/0x3e
	 <c02420b8> bus_remove_device+0x7e/0x8e  <c024104a> device_del+0x115/0x149
	 <c02a96f0> usb_disable_device+0xca/0x12d  <c02a5617> usb_disconnect+0x9d/0x117
	 <c02a676e> hub_thread+0x5d4/0xd8a  <c0132ec1> kthread+0xc5/0xf1
	 <c0101005> kernel_thread_helper+0x5/0xb
	dd977458: redzone 1:0x5a5a5a5a, redzone 2:0x170fc2a5.
	------------[ cut here ]------------
	kernel BUG at mm/slab.c:2688!
	...

(the actual OOPS message from the BUG_ON() is due to this one:

	BUG_ON(objp != index_to_obj(cachep, slabp, objnr));

but I think that's just due to the slab corruption that the redzone_free 
check already complained about, so I don't think the OOPS is very 
interesting).

Anyway, maybe it really is a hci_usb bug now, not an input layer thing, 
and it just happens close-by because device disconnect just in general is 
hard and nasty. The traceback certainly seems to point at hci_usb.

I'll see if this is repeatable (and whether it goes away without that 
hci_usb module).

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423008AbWF1Egt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423008AbWF1Egt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 00:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423009AbWF1Egt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 00:36:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60352 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423008AbWF1Egs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 00:36:48 -0400
Date: Tue, 27 Jun 2006 21:36:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] Input update for 2.6.17
In-Reply-To: <Pine.LNX.4.64.0606272057160.3927@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0606272114330.3927@g5.osdl.org>
References: <200606260235.03718.dtor_core@ameritech.net> 
 <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org>  <20060627063734.GA28135@kroah.com>
  <Pine.LNX.4.64.0606271131590.3927@g5.osdl.org>  <Pine.LNX.4.64.0606271211110.3927@g5.osdl.org>
  <Pine.LNX.4.64.0606271231440.3927@g5.osdl.org> <1151437593.25011.38.camel@localhost>
 <Pine.LNX.4.64.0606272057160.3927@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jun 2006, Linus Torvalds wrote:
>
>	slab error in verify_redzone_free(): cache `size-512': memory outside object was overwritten
	...
> 	 dd977458: redzone 1:0x5a5a5a5a, redzone 2:0x170fc2a5.

Ok, it's definitely repeatable, although with small variations.

Now, in verify_redzone_free(), the redzone values _should_ have been 
RED_ACTIVE (which is 0x170FC2A5), so here the end-of-zone marker is ok, 
but the beginning has been overwritten with the normal kmalloc poison 
bytes (5a).

In the second version, I got:


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
	d570528c: redzone 1:0x5a5a5a5a, redzone 2:0x5a2cf071.

ie now "redzone 2" (which again should be RED_ACTIVE: 0x170FC2A5) is 
actually RED_INACTIVE (0x5A2CF071), which means that the thing basically 
got free'd twice (and corrupted in between).

So I think "hci_usb_close()" is freeing a pointer that it (or somebody 
else) already freed once, and depending on what has happened in the 
meantime to it, it's either allocated by somebody else, or got freed 
again. 

It seems to be inside hci_usb_unlink_urbs() (which has been inlined).

I _think_ it's the

                        kfree(urb->transfer_buffer);

in the "released completed requests" loop. That's if I read the assembly 
right.. (and I'm pretty sure I do - it's just before releasing the urb 
itself which ends up being just another kfree()).

Anyway, "urb->transfer_buffer" was initialized with

	urb->transfer_buffer = skb->data;

and I'm pretty damn sure you're supposed to just kfree() it.

So Marcel, I think this is a hci_usb.c bug. But I'm not able to fix it, 
unless the fix is to just remove that kfree entirely.

			Linus

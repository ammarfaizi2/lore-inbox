Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751801AbWF1X7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWF1X7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWF1X7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:59:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1744 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751799AbWF1X7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:59:13 -0400
Date: Wed, 28 Jun 2006 16:55:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Marcel Holtmann <marcel@holtmann.org>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] Input update for 2.6.17
In-Reply-To: <44A31381.8090101@garzik.org>
Message-ID: <Pine.LNX.4.64.0606281651240.12404@g5.osdl.org>
References: <200606260235.03718.dtor_core@ameritech.net> 
 <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org>  <20060627063734.GA28135@kroah.com>
  <Pine.LNX.4.64.0606271131590.3927@g5.osdl.org>  <Pine.LNX.4.64.0606271211110.3927@g5.osdl.org>
  <Pine.LNX.4.64.0606271231440.3927@g5.osdl.org> <1151437593.25011.38.camel@localhost>
 <Pine.LNX.4.64.0606272057160.3927@g5.osdl.org> <Pine.LNX.4.64.0606272114330.3927@g5.osdl.org>
 <44A229C0.5060702@garzik.org> <Pine.LNX.4.64.0606281502280.12404@g5.osdl.org>
 <44A31381.8090101@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jun 2006, Jeff Garzik wrote:
> 
> You do:
> 
> >         urb->transfer_buffer = skb->data;
> >         urb->transfer_buffer_length = skb->len;
> > 
> >         __fill_isoc_desc(urb, skb->len,
> > le16_to_cpu(husb->isoc_out_ep->desc.wMaxPacketSize));
> > 
> >         _urb->priv = skb;
> 
> so it looks like you can grab it out of the 'priv' field.
> 
> And a damned good thing too...

Yeah, you'd have to do something like

	struct _urb *_urb = container_of(urb, struct _urb, urb);

first. However, it also turns out that some other code-paths are _also_ 
filling "urb->transfer_buffer", and those are indeed using a kmalloc'ed 
buffer (hci_usb_isoc_rx_submit()).

So the proper thing to do is probably along the lines of

	static void free_transfer_buffer(struct urb *urb)
	{
		struct _urb *_urb = container_of(urb, struct _urb, urb);

		if (_urb->priv) {
			kfree_skb((struct sk_buff *) _urb->priv);
			_urb->priv = NULL;
			urb->transfer_buffer = NULL;
			return;
		}
		kfree(urb->transfer_buffer);
		urb->transfer_buffer = NULL;
	}

or whatever. I dunno. I ended up just uncommenting the "kfree()" in my 
code, to see that it doesn't oops any more (and it doesn't).

		Linus

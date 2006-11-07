Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753964AbWKGCt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbWKGCt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 21:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbWKGCt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 21:49:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2785 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753967AbWKGCt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 21:49:56 -0500
Date: Mon, 6 Nov 2006 18:49:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH 2.6.19-rc4] usb urb unlink/free clenup
Message-Id: <20061106184949.87b2f23a.akpm@osdl.org>
In-Reply-To: <200611062228.38937.m.kozlowski@tuxland.pl>
References: <200611062228.38937.m.kozlowski@tuxland.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2006 22:28:37 +0100
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello,
> 
> 
> 	In many places usb_(unlink,kill,free)_urb() are called this way:
> 
> if (urb)
> 	usb_something_urb(...);
> 
> which is not needed because functions like usb_unlink_urb() and usb_free_urb() are defined this way:
> 
> void usb_free_urb(struct urb *urb)
> {
>         if (urb)
>                 kref_put(&urb->kref, urb_destroy);
> }
> 
> int usb_unlink_urb(struct urb *urb)
> {
>         if (!urb)
>                 return -EINVAL;
> 	...
> }
> 
> We do not need to check for urb != NULL before we call them.

Seems reasonable.

Your patch had all its tabs replaced with spaces by your email client.  I
fixed that all up, but it was rather dull work and I'd prefer not to have
to do it again.

 It is also possible to do similar cleanup
> for usb_kill_urb(). The thing is it does urb check at the begining but right before is 
> might_sleep():
> 
> void usb_kill_urb(struct urb *urb)
> {
>         might_sleep();
>         if (!(urb && urb->dev && urb->dev->bus))
>                 return;
> 	...
> 
> which confuses me. I would like to know what to do about it. Can this be rewritten this way?:
> 
> void usb_kill_urb(struct urb *urb)
> {
> 	if (!urb)
> 		return;
>         might_sleep();
>         if (!urb->dev || !urb->dev->bus))
>                 return;
> 	...
> 
> Or maybe there is no need for this?
> 

I think it's OK as-is.  Presumably it's rare for a caller to pass in a NULL
urb.

It's possible that your proposed change will cause new (and incorrect)
warnings to be emitted, but we can handle those if/when they come out.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbULVUsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbULVUsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 15:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbULVUsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 15:48:08 -0500
Received: from mail1.kontent.de ([81.88.34.36]:12963 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262037AbULVUsD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 15:48:03 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: My vision of usbmon
Date: Wed, 22 Dec 2004 21:46:33 +0100
User-Agent: KMail/1.6.2
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       <laforge@gnumonks.org>, greg@kroah.com
References: <20041219230454.5b7f83e3@lembas.zaitcev.lan> <200412201525.52149.oliver@neukum.org> <20041221182514.5ed935e2@lembas.zaitcev.lan>
In-Reply-To: <20041221182514.5ed935e2@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200412222146.33279.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 22. Dezember 2004 03:25 schrieb Pete Zaitcev:
> On Mon, 20 Dec 2004 15:25:52 +0100, Oliver Neukum <oliver@neukum.org> wrote:
> 
> > Am Montag, 20. Dezember 2004 08:04 schrieb Pete Zaitcev:
> > > +               memcpy(&mbus->shim_ops, ubus->op, sizeof(struct usb_operations));
> > > +               mbus->shim_ops.submit_urb = mon_submit;
> > > +               mbus->saved_op = ubus->op;
> > > +               ubus->op = &mbus->shim_ops;
> > > +               ubus->monitored = 1;
> > 
> > I think you need smp_wmb() here to make sure that an irq taken
> > on another CPU sees the manipulations in the correct order.
> 
> Hmm, it seems you are right. I forgot about reordering issues. I relied on
> op being atomic, but if it points at an uninitialized shim, this will end
> badly. How about this?
> 
>                 memcpy(&mbus->shim_ops, ubus->op, sizeof(struct usb_operations));
>                 mbus->shim_ops.submit_urb = mon_submit;
>                 mbus->saved_op = ubus->op;
>                 smp_mb();       /* ubus->op is not protected by spinlocks */
smp_wmb() would do.

>                 ubus->op = &mbus->shim_ops;
>                 ubus->monitored = 1;
> 
> Generally, the type of coding which requires a use of memory barriers in drivers
> is a bug or a latent bug, so I am sorry for the above. It was a sacrifice to
> make usbmon invisible if it's not actively monitoring. Sorry about that.

That is the best way. It's just a little tricky.

	Regards
		Oliver
 

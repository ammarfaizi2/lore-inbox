Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTEUHlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTEUHlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:41:08 -0400
Received: from zeus.kernel.org ([204.152.189.113]:38870 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261506AbTEUHlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:41:03 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [linux-usb-devel] [PATCH 06/14] USB speedtouch: spin_lock_irqsave -> spin_lock_irq in tasklets
Date: Wed, 21 May 2003 09:25:36 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
References: <200305210058.07416.baldrick@wanadoo.fr> <20030520193646.C32683@devserv.devel.redhat.com>
In-Reply-To: <20030520193646.C32683@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305210925.36830.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 May 2003 01:36, Pete Zaitcev wrote:
> > From: Duncan Sands <baldrick@wanadoo.fr>
> > Date: Wed, 21 May 2003 00:58:07 +0200
> >
> > Replace spin_lock_irqsave/spin_unlock_irqrestore with
> > spin_lock_irq/spin_unlock_irq in tasklet actions, since
> > these are always called with local irqs enabled.
> >
> > -	spin_lock_irqsave (&instance->completed_receivers_lock, flags);
> > +	spin_lock_irq (&instance->completed_receivers_lock);
>
> This is a premature optimization and I oppose it strongly.
> There is no evedince that Duncan's cable modem starts working
> any faster with this, or even that his oggs skip less.
> So, there is NO measurable benefit whatsoever.
>
> However, this will trip subtle breakage as the code changes,
> I guarantee it.
>
> Things like this may be done in common paths in TCP stack
> or block I/O, but doing such tricks in drivers is an utter folly.
> I personally had to fix bugs caused by exactly the same
> trickery, as if I have nothing better to do.

Hi Pete, thanks for your comments.  I think your concerns about
maintainability would have been better directed against patch 05,
where the same thing was done for routines called in process
context.  In this patch (06), only tasklet actions are changed.
It is very unlikely that, in the future, changes to the driver will
cause them to be called from anywhere else than the tasklet.
That is why I am not worried about future changes causing them
to be called with local irqs disabled.  So why not make this change
and save a few cycles?  Or maybe I misunderstood your concerns?

As for patch 05, this changed the following routines:
udsl_fire_receivers,
udsl_cancel_send,
udsl_usb_disconnect.

Patch 14 removed udsl_fire_receivers, so we can forget about it.
udsl_usb_disconnect is the USB disconnect routine, which I am
confident will be called in process context for all future time.  So
this change, while somewhat pointless, seems harmless enough
to me.  That leaves udsl_cancel_send.  Needless to say this routine
is called in process context (it is called from udsl_atm_close), but
you can't tell that from local inspection of udsl_cancel_send.  (Well,
you can tell now because the spin_lock_irq's document it! :) ).  So
this is probably the most dangerous change from the point of view
of maintainability.

I have some sympathy for your viewpoint in this case, especially since
in typical use this routine is called just once!

So I am willing to revert the change to udsl_cancel_send, if you like.

All the best,

Duncan.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVBAIcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVBAIcb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 03:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVBAIcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 03:32:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19170 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261525AbVBAIcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 03:32:21 -0500
Date: Tue, 1 Feb 2005 00:32:18 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Patch to add usbmon
Message-ID: <20050201003218.478f031e@localhost.localdomain>
In-Reply-To: <20050201071000.GF20783@kroah.com>
References: <20050131212903.6e3a35e5@localhost.localdomain>
	<20050201071000.GF20783@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 23:10:01 -0800, Greg KH <greg@kroah.com> wrote:

> First off, why make usbmon a module?  You aren't allowing it to happen,
> so just take out the parts of the patch that allow it.

No, I do allow it. This way I can load and unload it when debugging it.
Perhaps in the future we may simply link it with usbcore, but for now
it is a separate module. Also, I do not think it's possible not to build
it as a module when usbcore is a module.

I do not think it's a good idea for most users to build it as a module,
but it's not prohibited.

> > +#if defined(CONFIG_USB_MON) || defined(CONFIG_USB_MON_MODULE)
> > +struct usb_mon_operations *mon_ops;
> > +#endif /* CONFIG_USB_MON */
> 
> Not needed at all, as you create it down below.  Ah, the .h files, no
> wait, you refer to it there too, so removing it here should be fine.

Right.

> > @@ -1103,8 +1110,6 @@ static int hcd_submit_urb (struct urb *u
> >  		 * valid and usb_buffer_{sync,unmap}() not be needed, since
> >  		 * they could clobber root hub response data.
> >  		 */
> > -		urb->transfer_flags |= (URB_NO_TRANSFER_DMA_MAP
> > -					| URB_NO_SETUP_DMA_MAP);
> >  		status = rh_urb_enqueue (hcd, urb);
> >  		goto done;
> >  	}
> 
> Why remove that statment?  What does that have to do with usbmon?

The text format reader peeks at URB data. This is done for expediency
(because USBMon viewer wants it and because I'm still wrestling with
the design for the binary format reader stream). Anyhow, someone has to
make a decision if data is mapped into kernel at present (and if not,
perhaps kmap() in the future). This is done line this:

+	if (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)
+		return 'D';	// Cannot trust transfer_buffer
+	if ((data = urb->transfer_buffer) == NULL)
+		return 'Z';	// In case...
+	memcpy(ep->data, urb->transfer_buffer, len);

When root hub sets these bogus flags, it makes usbmon to skip perfectly
mapped data.

Even without usbmon it was such an annoying way to do things. It created
an illegal URB: the one which claimed that it has DMA mapped, but in fact
didn't. It only worked because the root hub implementation ignored flags.
This makes it much nicer, IMHO:

> >  void usb_hcd_giveback_urb (struct usb_hcd *hcd, struct urb *urb, struct pt_regs *regs)
> >  {
> > -	urb_unlink (urb);
> > +	int at_root_hub;
> >  
> > -	// NOTE:  a generic device/urb monitoring hook would go here.
> > -	// hcd_monitor_hook(MONITOR_URB_FINISH, urb, dev)
> > -	// It would catch exit/unlink paths for all urbs.
> > +	at_root_hub = (urb->dev == hcd->self.root_hub);
> > +	urb_unlink (urb);
> >  
> >  	/* lower level hcd code should use *_dma exclusively */
> > -	if (hcd->self.controller->dma_mask) {
> > +	if (hcd->self.controller->dma_mask && !at_root_hub) {
> >  		if (usb_pipecontrol (urb->pipe)
> >  			&& !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
> >  			dma_unmap_single (hcd->self.controller, urb->setup_dma,
> 
> You change the logic here a bit too.  Why?

I do not think I change the logic. The check I add is exactly the same
which is used to set bogus flags. So, the code works exactly as before,
at least in my limited testing. Am I missing something?

> > +#define usbmon_urb_submit(bus, urb)				\
> 
> Can you make these inlines?  That makes the code nicer as we get
> typechecking and everything :)

OK.

> > +#define usbmon_urb_submit(bus, urb)		/* */

> static inlines for these too if you can.

OK

-- Pete

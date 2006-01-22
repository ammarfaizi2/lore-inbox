Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWAVAO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWAVAO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 19:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWAVAO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 19:14:57 -0500
Received: from mail.gmx.net ([213.165.64.21]:48280 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751240AbWAVAO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 19:14:57 -0500
X-Authenticated: #20450766
Date: Sun, 22 Jan 2006 01:15:23 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Guennadi Liakhovetski <gl@dsa-ac.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 2.4.32] usb-uhci.c failing "-"
In-Reply-To: <20060120151030.433abdf6.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.60.0601212230210.9393@poirot.grange>
References: <Pine.LNX.4.63.0601200928480.1049@pcgl.dsa-ac.de>
 <20060120151030.433abdf6.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006, Pete Zaitcev wrote:

> On Fri, 20 Jan 2006 09:33:26 +0100 (CET), Guennadi Liakhovetski <gl@dsa-ac.de> wrote:
> 
> > Looks like a bug?
> 
> > --- a/drivers/usb/host/usb-uhci.c	Fri Jan 20 09:27:50 2006
> > +++ b/drivers/usb/host/usb-uhci.c	Fri Jan 20 09:28:05 2006
> > @@ -2505,7 +2505,7 @@
> >   			((urb_priv_t*)urb->hcpriv)->flags=0;
> >   		}
> > 
> > -		if ((urb->status != -ECONNABORTED) && (urb->status != ECONNRESET) &&
> > +		if ((urb->status != -ECONNABORTED) && (urb->status != -ECONNRESET) &&
> >   			    (urb->status != -ENOENT)) {
> 
> This is not what the author intended, obviously. But I am not quite sure
> what happens because of it. Seems like we unlink some things which are

This is my concirn too. The current behaviour is in fact just

> > -		if ((urb->status != -ECONNABORTED) && (urb->status != ECONNRESET) &&
> > +           if ((urb->status != -ECONNABORTED) &&
> >                         (urb->status != -ENOENT)) {

and nobody complains...:-) So, maybe this would be the right fix? At least 
safe in that it cannot break anything:-) But I don't understand that code 
very well. E.g., I don't understand why about 15 lines above the code in 
question

		if (urb->complete) {
			//dbg("process_interrupt: calling completion, status %i",status);
			urb->status = status;

i.e., if (!urb->completion) urb->status is not set, so, depending on 
whether the urb has ->completion either the old or the new status will be 
tested. Is this really correct? And a couple lines above that "goto 
recycle;" is superfluous...

Thanks
Guennadi

> about to return anyway... and then return -104 instead of -84. This
> may be relatively harmless. At worst, the driver resubmits and gets
> its -84 that way.
> 
> I vote to apply this and see what happens. We are early in 2.4.33 cycle,
> so it should be safe.
> 
> -- Pete
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

---
Guennadi Liakhovetski

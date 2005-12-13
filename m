Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVLMDcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVLMDcj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 22:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVLMDcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 22:32:39 -0500
Received: from mx1.rowland.org ([192.131.102.7]:43780 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S932437AbVLMDcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 22:32:39 -0500
Date: Mon, 12 Dec 2005 22:32:37 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Jeff Garzik <jgarzik@pobox.com>
cc: Greg Kroah-Hartman <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [patch 4/4] UHCI: add missing memory barriers
In-Reply-To: <439E1581.40808@pobox.com>
Message-ID: <Pine.LNX.4.44L0.0512122220350.17181-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2005, Jeff Garzik wrote:

> Greg Kroah-Hartman wrote:
> > From: Alan Stern <stern@rowland.harvard.edu>
> > 
> > This patch (as617) adds a couple of memory barriers that Ben H. forgot in
> > his recent suspend/resume fix.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > ---
> >  drivers/usb/host/uhci-hcd.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > --- greg-2.6.orig/drivers/usb/host/uhci-hcd.c
> > +++ greg-2.6/drivers/usb/host/uhci-hcd.c
> > @@ -717,6 +717,7 @@ static int uhci_suspend(struct usb_hcd *
> >  	 * at the source, so we must turn off PIRQ.
> >  	 */
> >  	pci_write_config_word(to_pci_dev(uhci_dev(uhci)), USBLEGSUP, 0);
> > +	mb();
> >  	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
> >  	uhci->hc_inaccessible = 1;
> >  	hcd->poll_rh = 0;
> > @@ -738,6 +739,7 @@ static int uhci_resume(struct usb_hcd *h
> >  	 * really don't want to keep a stale HCD_FLAG_HW_ACCESSIBLE=0
> >  	 */
> >  	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
> > +	mb();
> 
> Are these just guesses, or what?

There's no need for sarcasm.  No, they are not guesses.  Ask Ben 
Herrenschmidt if you don't believe me.

> Why not smp_mb__before_clear_bit() or smp_mb__after_clear_bit() ?

Because the code needs to synchronize not with another CPU, but with a USB 
host controller.  Those barriers are necessary even on a UP system.


By the way, what's the idea with this proliferation of little
not-all-that-helpful routines, like smp_mb__before_clear_bit()?  Are there
architectures on which

	smp_mb__before_clear_bit(...);

is significantly superior to

	smp_mb();
	clear_bit(...);

?  (It's certainly not easier to type.)  Is this difference worth noting,
considering how infrequently clear_bit() gets used?

Alan Stern


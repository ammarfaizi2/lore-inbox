Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVCaAwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVCaAwI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 19:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVCaAwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 19:52:08 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:56259 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262674AbVCaAuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 19:50:23 -0500
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] USB: usbnet uses netif_msg_*() ethtool filtering
Date: Wed, 30 Mar 2005 16:50:17 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dbrownell@users.sourceforge.net, Greg KH <greg@kroah.com>
References: <200503302319.j2UNJEBP019719@hera.kernel.org> <424B44C3.4040804@pobox.com>
In-Reply-To: <424B44C3.4040804@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503301650.17486.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 March 2005 4:30 pm, Jeff Garzik wrote:
> Linux Kernel Mailing List wrote:
> > ChangeSet 1.2181.4.72, 2005/03/24 15:31:29-08:00, david-b@pacbell.net
> > 
> > 	[PATCH] USB: usbnet uses netif_msg_*() ethtool filtering
> > 	
> > 	This converts most of the usbnet code to actually use the ethtool
> > 	message flags.  The ASIX code is left untouched, since there are
> > 	a bunch of patches pending there ... that's where the remaining
> > 	handful of "sparse -Wbitwise" warnings come from.
> > 	
> > 	Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > 	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> It would be nice if people at least CC'd me on net driver patches.

Sorry.  When drivers fit multiple classifications (e.g. USB _and_ NET,
or USB _and_ PCI _and_ PM, etc) it's unfortunately routine that not all
interested parties see them until something hits LKML.  Even when the
changes have significant cross-subsystem impact (these don't).


> netfi_msg_ifdown() is only for __interface__ up/down events; as such, 
> there should be only one message of this type in dev->open(), and one 
> message of this type in dev->stop().

I was going by the only writeup I've ever seen, which doesn't mention
such a rule at all.  The messages you highlighted are compatible with
these rules:  the interface is actually going down at that point.

  http://www.tux.org/hypermail/linux-vortex/2001-Nov/0021.html

If there are other rules, they belong in Documentation/netif-msg.txt
don't they?  That way folk won't be forced to guess.  Or risk
accidentally following the "wrong" set of rules...


> > @@ -3044,7 +3047,7 @@
> >  
> >  	memset(urb->transfer_buffer, 0, urb->transfer_buffer_length);
> >  	status = usb_submit_urb (urb, GFP_ATOMIC);
> > -	if (status != 0)
> > +	if (status != 0 && netif_msg_timer (dev))
> >  		deverr(dev, "intr resubmit --> %d", status);
> >  }
> >  
> 
> this looks more like a debugging message?

It's an error of the "what do I do now??" variety, triggered by
what's effectively a timer callback.  USB interrupt transfers
are polled by the host controller according to a schedule that's
maintained by the HCD.

- Dave


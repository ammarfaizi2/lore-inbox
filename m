Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVCaCLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVCaCLB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 21:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVCaCLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 21:11:01 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:12715 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262477AbVCaCKt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 21:10:49 -0500
From: David Brownell <david-b@pacbell.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] USB: usbnet uses netif_msg_*() ethtool filtering
Date: Wed, 30 Mar 2005 18:10:44 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dbrownell@users.sourceforge.net, Greg KH <greg@kroah.com>
References: <200503302319.j2UNJEBP019719@hera.kernel.org> <200503301650.17486.david-b@pacbell.net> <424B4DCB.2040805@pobox.com>
In-Reply-To: <424B4DCB.2040805@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503301810.45077.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 March 2005 5:09 pm, Jeff Garzik wrote:
> David Brownell wrote:
> >   http://www.tux.org/hypermail/linux-vortex/2001-Nov/0021.html
> > 
> > If there are other rules, they belong in Documentation/netif-msg.txt
> > don't they?  That way folk won't be forced to guess.  Or risk
> > accidentally following the "wrong" set of rules...
> 
> I don't see from the code that the struct net_device interface is going 
> down (via dev->stop) at that point.  Am I mistaken?

It's going down, either by netdev->stop() or by hot-unplug, in every
place I used the netif_msg_ifdown() filter.


> Moreover, if you look at any other user of netif_msg_if{up,down}, you 
> will see that it does not produce multiple lines of status register 
> information opaque to anyone but the programmer.  Its not a debugging 
> message, but something a user should feel comfortable enabling (if not 
> enabled by default).

Again, if that's going to become an official guideline it ought to be
documented in Documentation/netif-msg.txt ... along with information
about how to handle categorization of debug messages.

I suspect a general "how to use debug messages" document would help too.
With guidance like "fault paths should have diagnostics that let you
distinguish each fault", and "never provide success messages at default
message logging levels".  (Log spamming ... we hates it forever!)


If it's wrong to use netif_msg_if{up,down} for debug messages (which go
away when DEBUG isn't defined, and yes are intended for debugging aids)
which are related to interfaces going up and down ... then what's the
"correct" category to filter those out?


> >>>@@ -3044,7 +3047,7 @@
> >>> 
> >>> 	memset(urb->transfer_buffer, 0, urb->transfer_buffer_length);
> >>> 	status = usb_submit_urb (urb, GFP_ATOMIC);
> >>>-	if (status != 0)
> >>>+	if (status != 0 && netif_msg_timer (dev))
> >>> 		deverr(dev, "intr resubmit --> %d", status);
> >>> }
> >>> 
> >>
> >>this looks more like a debugging message?
> > 
> > 
> > It's an error of the "what do I do now??" variety, triggered by
> > what's effectively a timer callback.  USB interrupt transfers
> > are polled by the host controller according to a schedule that's
> > maintained by the HCD.
> 
> The above example seems more like netif_msg_tx_err() or even just KERN_ERR ?

It's not coupled to a packet TX or RX, so the guidelines I've seen
suggest netif_msg_{tx,rx}_err() would be wrong.  Maybe KERN_ERR with
no filter would be right ... but I'm used to having one goal of all
message filtering as being able to _completely shut up_ the component.
That's why there's a filter ... deverr() does wrap KERN_ERR.

- Dave


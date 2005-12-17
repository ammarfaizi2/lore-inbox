Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVLQDYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVLQDYv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 22:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVLQDYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 22:24:51 -0500
Received: from mx1.rowland.org ([192.131.102.7]:7685 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S964913AbVLQDYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 22:24:51 -0500
Date: Fri, 16 Dec 2005 22:24:49 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Linus Torvalds <torvalds@g5.osdl.org>
Subject: Re: [PATCH] UHCI: add missing memory barriers
In-Reply-To: <1134777482.6102.9.camel@gaston>
Message-ID: <Pine.LNX.4.44L0.0512162216580.15902-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Dec 2005, Benjamin Herrenschmidt wrote:

> > This patch (as617) adds a couple of memory barriers that Ben H. forgot in
> > his recent suspend/resume fix.
> 
> I didn't think they were necessary but they certainly won't hurt and
> it's not a hot code path...

True.

> >  	pci_write_config_word(to_pci_dev(uhci_dev(uhci)), USBLEGSUP, 0);
> > +	mb();
> 
> Isn't pci config space access always fully synchronous ?

If it is, it's not documented.

Looking at the PCI code, I see that the accesses are protected by a 
spinlock.  Does that guarantee in-order execution of writes to 
configuration space with respect to writes to regular memory?  On all 
platforms?  If yes, then this barrier is not needed.

> > @@ -738,6 +739,7 @@ static int uhci_resume(struct usb_hcd *h
> >  	 * really don't want to keep a stale HCD_FLAG_HW_ACCESSIBLE=0
> >  	 */
> >  	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
> > +	mb();
> 
> I don't think that one matters much but it won't hurt for sure.

Actually this one only needs to be smp_mb(), although the reasoning is a
bit subtle.  Anyway, as you said, leaving the barriers in certainly won't
hurt anything.

Alan Stern


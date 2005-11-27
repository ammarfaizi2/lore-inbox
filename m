Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVK0WGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVK0WGH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 17:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVK0WGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 17:06:07 -0500
Received: from mx1.rowland.org ([192.131.102.7]:58641 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751133AbVK0WGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 17:06:06 -0500
Date: Sun, 27 Nov 2005 17:06:04 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Michael Buesch <mbuesch@freenet.de>, David Brownell <david-b@pacbell.net>,
       Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Latest GIT: USB ehci_hcd broken (spinlock corruption)
In-Reply-To: <1133126726.7768.127.camel@gaston>
Message-ID: <Pine.LNX.4.44L0.0511271654280.16475-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2005, Benjamin Herrenschmidt wrote:

> On Sun, 2005-11-27 at 12:34 +0100, Michael Buesch wrote:
> > Hi,
> > 
> > Latest GIT code oopses in the USB driver with a spinlock corruption:
> 
> (backtrace below)
> 
> Looks bad. I went through the code, and I discovered that indeed,
> usb_add_hcd() calls driver->reset() before anything else, that is,
> before giving the low level driver a chance to initialize it's local
> data structure, including the spinlock. On EHCI, at least, reset will
> dive deep into the guts of the driver tying among others to acquire the
> lock.
> 
> That is very bad. It's yet another example of broken "mid-layer" design.
> I can't say enough how bad this whole mid-layer hcd stuff is but you
> guys don't beleive it.

Stop complaining.  We've known about this bug for over a month.  
It's even mentioned in the OSDL bugzilla:
<http://bugzilla.kernel.org/show_bug.cgi?id=5433>, comment #2.  The only
question is why Dave hasn't fixed it yet...

> So what you should do to fix the immediate problem is to have a separate
> "init" callback to the low level driver to initialize it's private data
> structure before anything else is called. A kind of "constructor". Call
> that from usb_add_hcd() before you call reset().

I suggested back in October that the "reset" method should be renamed 
"init".  It only gets called once, during device initialization, so the 
"reset" name is a misnomer.  It should do an initialize _and_ a reset.

> In the long run, the whole hcd layer junk should probably be flipped
> upside down though. It's the low level driver that should be in control,
> and the hcd layer should act as a "library" used by the hcd driver,
> instead of the opposite.
> 
> That is, the HCD driver gets probed, gets control first, calls something
> to allocate the hcd data structure, gets a chance to initialize it, then
> calls usb_add_hcd() etc... 
> 
> The whole thing is done backward currently.

Nonsense.  It's done just as you described.  You just have to think of the 
reset method as an initialization method.

For now, you can workaround the bug by adding:

	spin_lock_init(&ehci_lock);

as the first line of drivers/usb/host/ehci-pci.c:ehci_pci_reset().

Alan Stern


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTELQKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 12:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTELQKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 12:10:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56201 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262033AbTELQKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 12:10:43 -0400
Date: Mon, 12 May 2003 09:24:54 -0700
From: Greg KH <greg@kroah.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Andrew Morton <akpm@digeo.com>, stern@rowland.harvard.edu,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com
Subject: Re: 2.5.69 Interrupt Latency
Message-ID: <20030512162454.GA27939@kroah.com>
References: <1052323940.2360.7.camel@diemos> <1052336482.2020.8.camel@diemos> <20030507152856.2a71601d.akpm@digeo.com> <1052402187.1995.13.camel@diemos> <20030508122205.7b4b8a02.akpm@digeo.com> <1052503920.2093.5.camel@diemos> <1052512235.2997.8.camel@diemos> <20030509142828.59552d0a.akpm@digeo.com> <1052747862.1996.9.camel@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052747862.1996.9.camel@diemos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 08:57:42AM -0500, Paul Fulghum wrote:
> On Fri, 2003-05-09 at 16:28, Andrew Morton wrote:
> 
> > This code was added to wakeup_hc().  It is called from uhci_irq():
> > 
> > +	/* Global resume for 20ms */
> > +	outw(USBCMD_FGR | USBCMD_EGSM, io_addr + USBCMD);
> > +	wait_ms(20);
> > 
> > The changelog just says "Minor patch for uhci-hcd.c"
> > 
> > Can you delete the wait_ms() and see if that is our culprit?
> 
> This is the culprit.
> 
> Removing this line corrects the latency problems on
> the server. A 20ms delay seems pretty excessive for an
> interrupt handler. I'm not sure what it is supposed to
> accomplish, but this seems like something that should
> be scheduled to run outside of the ISR.

This should only happen when your hardware receives a "RESUME" signal
from a USB device AND the host controller is in a global suspend state
at that time.

Now I think the wait_ms() call is valid for when this is really
happening, but it sounds like you are having this happen all the time
during normal operation.  Are you using any USB devices with this
server?  Is USB enabled in the BIOS or not?

Also, Johannes / Alan, should we be verifying the global suspend state
when we read this value so that we don't accidentally call wakeup_hc()
for hardware that sets this bit in an illegal way?  I think that might
be the proper fix for this problem.

thanks,

greg k-h

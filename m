Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTEMVXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTEMVXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:23:40 -0400
Received: from ida.rowland.org ([192.131.102.52]:4868 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263487AbTEMVXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:23:01 -0400
Date: Tue, 13 May 2003 17:35:47 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Paul Fulghum <paulkf@microgate.com>, Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, <johannes@erdfelt.com>
Subject: Re: 2.5.69 Interrupt Latency
In-Reply-To: <20030513181120.GA10790@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0305131719260.673-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003, Greg KH wrote:

> On Tue, May 13, 2003 at 11:09:13AM -0700, Greg KH wrote:
> > On Tue, May 13, 2003 at 08:01:01AM -0500, Paul Fulghum wrote:
> > > 
> > > I applied the patch plus a couple of printk statements,
> > > and the wakeup_hc() is being continuously called
> > > as well as actually executing the delay.
> > 
> > Is the suspend_hc() function ever getting called by anyone in that
> > driver? 
> 
> Ok, nevermind, I see where it would be getting called under normal
> operation...
> 
> Hm, I don't really know.  Johannes, any thoughts?

My take is that wakeup_hc() is getting called whenever some stray signal
causes the device to generate an interrupt, and then a little while later
the stall timer routine calls suspend_hc() since nothing is active.  The
interrupts are probably indistinguishable from what you would get if a new
device really had just been attached to the bus.

Assuming this analysis is correct, only malfunctioning hardware would ever
cause the problem to arise.  Still, it's something that needs to be
handled.  (That's a tricky point -- to what extent should the kernel try 
to compensate for broken hardware?)

Unfortunately, there isn't any obvious way to tell that under these
circumstances the wakeup_hc() routine doesn't need to run.  Using a timer
routine to implement that 20 ms delay would at least remove the large
interrupt latency.  However, this presents some problems as well.  In
particular, is there anything that would prevent suspend_hc() from being
called before the timer had expired?  We don't want to find ourselves
simultaneously trying to turn the USB controller on and off.  Getting that
done properly will require some thought.

Maybe a kind of grace period would help: each time the controller changes
state, don't allow another change until at least 1 second later.  That
would also help the "bouncing" effect I see when I turn on or off my USB
CD-RW drive.

Alan Stern


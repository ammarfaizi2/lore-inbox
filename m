Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbTEPRfl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 13:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263332AbTEPRfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 13:35:41 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:7995 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263219AbTEPRfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 13:35:39 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0305161307390.1171-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0305161307390.1171-100000@ida.rowland.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053107295.2606.21.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 16 May 2003 12:48:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-16 at 12:16, Alan Stern wrote:
> On 16 May 2003, Paul Fulghum wrote:
> > According to the 82371AB datasheet the controller
> > itself sets the USBCMD_FGR bit when a global RD is
> > detected. So qualifying the wakeup in software won't
> > prevent the controller itself from starting the
> > wakeup process on a false RD from an OC port. :-(
> > 
> > Hmmmm.... crap
> > Is there a way around this or are we back to
> > preventing the suspend?
> 
> It might not be that bad.  What will happen is that the controller will 
> assert FGR and interrupt the host.  The driver will see the global RD, but 
> will also see that it's present only on OC ports, so the driver will never 
> leave the SUSPENDED state and will never write a 0 to FGR and EGSM.  Hence 
> the controller will never become active -- the wakeup won't finish.
>
> Of course, it's necessary to worry about what happens if one port is OC, 
> so the controller is in this permanently-waking-up state, when a device is 
> plugged into the other port.  I think this will re-assert global RD and 
> generate another interrupt.  This time the driver will see that the RD is 
> for real, so it will complete the wakeup sequence.

Agreed, when the controller sets the FGR bit, it
starts sending the resume signal to all ports,
waking attached devices, which will send back
valid resume signals to the host controller, which
will complete the wakeup. Which takes us back
to the thrashing problem.

For the case where ports are not hardwired to OC,
we should account for the possibility that the
OC condition may clear (bad cable replaced, etc).

So if we allow suspend, and then ignore resumes
on an OC (temporary condition) port, then that port will not
be able to cause a valid resume when the OC
condition is cleared. (per port RD is already set)

So always allowing suspend, and selectively doing the
wakeup will cause:
1. thrashing for case of one port OC,
other port OK with attached device.
2. prevent port with OC from doing resume
after clearing OC condition.

For the case of all ports hardwired OC, this
will work because you suspend the whole controller
and never get a valid resume.


-- 
Paul Fulghum
paulkf@microgate.com


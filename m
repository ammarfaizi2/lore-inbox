Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751666AbWISUuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbWISUuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbWISUuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:50:37 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:2201 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751666AbWISUug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:50:36 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.18-rc6-mm2 (-mm1): ohci_hcd sometimes does not initialize properly on x86_64
Date: Tue, 19 Sep 2006 22:53:54 +0200
User-Agent: KMail/1.9.1
Cc: Jan De Luyck <ml_linuxkernel_20060528@kcore.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <200609160013.16014.rjw@sisk.pl> <200609181704.42063.david-b@pacbell.net>
In-Reply-To: <200609181704.42063.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609192253.55170.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 19 September 2006 02:04, David Brownell wrote:
> On Friday 15 September 2006 3:13 pm, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > It looks like the ohci_hcd driver sometimes has problems with the
> > initialization (eg. USB mouse doesn't work after a fresh boot and reloading
> > of the driver helps).
> > 
> > I have observed this on two different x86_64 boxes (HPC 6325, Asus L5D),
> > but it is not readily reproducible.  Anyway I've got a dmesg output from a
> > failing case which is attached.
> 
> Where I've seen such issues in the past has been with one specific
> device:  a UPS that seems unhappy if it doesn't get a VBUS power cycle,
> so that OHCI implementations that don't implement power switching are
> bad choices for connecting that particular UPS.
> 
> I believe that's not the issue in your case.  I compared the boot
> sequence you sent with one for the NF3-150 I use a lot (also x86_64)
> which does not exhibit this failure, and the differences I noticed
> were:
> 
>  - NOCP set in roothub.a ... your BIOS reports no overcurrent protection
>  - different 2.6.18 prepatches ... you used rc6-mm2, not rc7
>  - different irqs (you used PIC not IOAPIC)
>  - driver registration sequence different ... I registered EHCI first
>  - yours came _up_ with RHSC irq pending on one root (device present)
> 
> And re those last two, it didn't finish mouse enumeration with OHCI before
> starting to  do it with EHCI.  I could easily see how that would lead to
> timing-dependent/intermittent failures.
> 
> Now, registering EHCI first is not "supposed" to matter, but I'm thinking
> it started to matter a while back, since a few folk have reported as much.
> 
> One suspicion being that some of the hub driver changes have had some bad
> consequences.  (My suspicions there were highlighted by noticing some of
> the misbehavior associated with an embedded USB controller I was testing,
> which provoked failures in those same code paths...)  The root hub handoff
> relies on the usb/core/hub.c code to do the right things, notably treating
> disconnect-during-reset (handoff to companion) as routine, but I think I
> noticed that fault handling logic has changed.
> 
> At any rate, that suggests a few experiments to me.
> 
>  -  First, does this still show up with the stock RC7 code?  There are
>     a bunch of IMO rather experimental USB patches in the MM tree...
>     including several affecting usbcore hub support.
> 
>  -  Second does it appear without EHCI loaded?  If not, that would
>     tend to confirm an issue usbcore hub driver handoff logic.
> 
>  -  Third, does it appear if EHCI is loaded _first_ (as the distro
>     should already have been doing just to avoid thrashing during
>     system startup)?  Similar comment re previous experiment, though
>     it'd provide a potential workaround.
> 
> I'd kind of suspect that the generic RC7 code, with EHCI loaded first
> as it should be, would "just work".

Yes, I think the problem resulted from the experimental patches in -mm.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

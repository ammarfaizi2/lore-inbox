Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbUKFEqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbUKFEqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 23:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbUKFEqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 23:46:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25729 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261314AbUKFEqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 23:46:23 -0500
Subject: Re: Kernel 2.6.x hangs with Symbios Logic 53c1010 Ultra3 SCSI Ada
	pter
From: Doug Ledford <dledford@redhat.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Richard Waltham <richard@fars-robotics.net>,
       SUPPORT <support@4bridgeworks.com>, Thomas Babut <thomas@babut.net>,
       linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>, groudier@free.fr
In-Reply-To: <20041106035951.GC24690@parcelfarce.linux.theplanet.co.uk>
References: <D5169CBBC6369D4CBFFABD7905CC9D695D31@tehran.Fars-Robotics.local>
	 <20041106035951.GC24690@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Fri, 05 Nov 2004 23:46:14 -0500
Message-Id: <1099716374.10944.48.camel@compaq-rhel4.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-06 at 03:59 +0000, Matthew Wilcox wrote:

> I think those devices need blacklisting.  Either that, or we need to do
> DV in non-approved ways.  Perhaps start with SDTR+WDTR.  If we get up
> to Fast-40, then try PPR.  I suspect James has Opinions on this though ;-)

Bleah.  I have opinions on this whether James does or not.  If you are
going to control device negotiation at the mid layer level, then you
need these things:

     1. Current bus state, as pointed out there are devices that reject
        PPR unless on an LVD bus, and whether or not you can get at the
        current bus mode and how is hardware dependent and changes from
        driver to driver, so now you have to add a new entry into the
        low level driver for all SPI class drivers hostt->bus_is_lvd()
        in order to be able to do proper checks at the mid layer level.
        This needs to be a call in function, not a static element.  Bus
        mode can change, especially from something as simple as hot
        plugging a new drive into an existing LVD JBOD, but the drive
        accidentally has the FORCE_SE jumper enabled.  This will force
        the whole bus to switch to SE instantly, and all drives will
        have to renegotiate.  So, given hotplug issues, the bus state
        needs to be checked at each negotiation, not based upon some
        previous state.
     2. Drivers *should*, when possible, honor user settings stored in
        NVRAM on the cards.  So, add another entry point so that the low
        level drivers with NVRAM can pass up the user specified max
        speed, width, cache settings, etc.  Oh, and if it isn't obvious,
        there are devices out there that reject attempted PPR messages
        if the speed/width/mode that you are requesting can be
        represented by a SDTR/WDTR pairs instead.  In other words, if
        you aren't requesting a DT + possible options settings, then
        don't use PPR.
     3. Recovery operations in the LLDD interrupt handler need to change
        the way commands are handled.  Given an attempt to send PPR
        messages, both BUSFREE and subsequent MSG_REJECT situations need
        to cancel the attempted and all future PPR messages, so now you
        need a hook in the scsi layer for the driver to tell the mid
        layer "Quit telling me to do PPR, it doesn't work you moron"
     4. In the event that a device doesn't advertise in any given way
        that it is capable of PPR, but does in fact send an unsolicited
        PPR message to the driver, we now need a hook in the mid layer
        so the driver can say "Well, would you look at that...it's a PPR
        device hiding in the corner"

That's the level of API you'll need to properly do this from the mid
level.

Of course, you could genericize this a bit.  You could have a callin for
current bus state in the LLDD.  Something like hostt->get_bus_type() and
have it return an or'ed bitmask of state bits, BUS_WIDE | BUS_SYNC |
BUS_{LVD,SE,HVD}, something like that, then it could possibly do more
than just PPR/LVD negotiation, but personally this is one of those
things that I think is card specific enough that it ought to just stay
in the LLDD.  My $.02.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606



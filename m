Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264770AbUHABhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbUHABhc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 21:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUHABhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 21:37:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:35468 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264770AbUHABh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 21:37:29 -0400
Subject: Re: Solving suspend-level confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <200407311741.12406.david-b@pacbell.net>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200407310723.12137.david-b@pacbell.net>
	 <200407311901.17390.oliver@neukum.org>
	 <200407311741.12406.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1091324075.7389.41.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 01 Aug 2004 11:34:36 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-01 at 10:41, David Brownell wrote:
> On Saturday 31 July 2004 10:01, Oliver Neukum wrote:
> > 
> > Maybe a better approach would be to describe the required features to
> > the drivers rather than encoding them in a single integer. Rather
> > like passing a request that states "lowest power level with device state
> > retained, must not do DMA, enable remote wake up"
> 
> A pointer to some sort of struct could be generic and typesafe;
> better than an integer or enum.

Well... if it gets that complicated, drivers will get it wrong...

I'm pretty sure that in real life, drivers only care about 2 states
at this point, which is the ones needed for suspend to disk and suspend
to RAM, the later doing a D3. An assitional "standby" state could be
added later if we want.

If we really want to separate the system "target" state from the device
state, then we could indeed define a structure, but I doubt this is necessary,
I think we can get everything working with the current scheme by just slightly
adjusting the constants to properly differenciate the 2 above defined system
states.

The only thing we need to make sure of at this point is that drivers ignore
states they don't understand so we keep some flexibility to extending the list
of states.

Part of the confusion at this point is that we are playing with 2 different
concepts, which are the driver operating state and the device power state.

System suspend wants all drivers to suspend (freeze activity so that a
consistent state of the driver is kept in memory). It may or may not
be followed by a device power down.

Dynamic per-device power management would alter the device power state,
but without putting the driver into a suspended state (actually, the driver
itself would be responsible to turning the device back on as soon as some kind
of request comes in).

I think we don't need at this point to provide hooks or abstractions to
represent these. Doing so would break everything, we don't need to do it
at this point, we can at least get something reasonably working with our
current scheme. The device power state policy can remain under driver
control imho and don't need to be abstracted. At least not now. Let's get
things working with what we have, for system suspend, and drivers who want
to do dynamic PM can implement it locally.

Ben.



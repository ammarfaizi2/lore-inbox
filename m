Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270353AbRHHG3O>; Wed, 8 Aug 2001 02:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270354AbRHHG3F>; Wed, 8 Aug 2001 02:29:05 -0400
Received: from imladris.infradead.org ([194.205.184.45]:46086 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S270353AbRHHG2z>;
	Wed, 8 Aug 2001 02:28:55 -0400
Date: Wed, 8 Aug 2001 07:28:55 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Josh Wyatt <jdwyatt@Bellsouth.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <3B708202.105D696B@Bellsouth.net>
Message-ID: <Pine.LNX.4.33.0108080705450.12565-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh.

 > Why not have a provision like the following:

 > 1. For a given driver, assign ethX in [ascending|descending]
 >    (pick one) order based on MAC addr. At least this is a
 >    predictable order; it should never change for a given driver.

Alan Cox will correct me if I'm wrong, but memory says that he pointed
out a while back some problem with this idea. I've cc'd this to him
for comments.

 > 2. If it's modular, you could make it even more flexible with options:

 > alias eth0 eepro100
 > alias eth1 ne2k-pci
 > alias eth2 eepro100
 > options eepro100 "bind_mac_order=eth0,eth2 \
 > bind_mac_list=00D0B760C299,00D0B760C3DC"

I would suspect that all that would be needed here would be for each
driver to only detect one interface each time it's called, so you
would get something like the following instead:

	alias eth0 eepro100
	options eth0 mac=00:D0:B7:60:C2:99
	alias eth1 ne2k-pci
	alias eth2 eepro100
	options eth2 mac=00:D0:B7:60:C3:DC

Incidentally, this follows the current modules.conf syntax rules, and
(in this particular case) would be likely to be much simpler than your
proposed change. Specifying the options on the interface rather than
the driver is the ONLY way to specify different parameters for
different interfaces in a flexible manner.

 > 3. If it's modular and insmod'ed with no options, default to a
 >    combo of the current behavior and #1, above.

 > Of course, you'd have to rely on the module maintainers to
 > follow the convention.

With the revised scenario, they already follow the convention because
that is the current convention.

 > Also, I can see a potential dependency manifested in a scenario
 > like this:

Your scenario has already been considered.

 > 1. add eth0, eth1, eth2 as above
 > 2. un-hot-plug eth0.

Two points here:

 1. The fact that you can un-hot-plug eth0 states that you can
    also un-hot-plug eth1 and eth2. Any interfaces that can't be
    hot-plugged are currently required to be set up before any of
    the hot-pluggable ones.

 2. The hotplug interface signals to the driver that this has
    happenned, so the driver de-registers eth0 by doing the
    equivalent of `ifconfig eth0 down ; rmmod eth0` internally.

We continue...

 > 3. now hotplug another interface, not used by the previous driver
 > 4. eepro100 driver is still bound to eth0

No it isn't - see comments above.

 > 5. should the new device get eth3?  or eth0?

As eth0 was auto-deregistered at point (2), it's actually irrelevant
which it gets.

 > 6. Is this a textbook problem outside of PCMCIA?

It's one that has already been dealt with as part of the PCMCIA
specification, and is thus already supported by the Linux PCMCIA
interface.

I understand we can blame/credit Microsoft with the fact that this
scenario was considered as part of the PCMCIA specification.

 > Dumb? Klutzy? thoughts?

Neither dumb nor a problem.

Best wishes from Riley.


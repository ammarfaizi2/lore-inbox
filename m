Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270132AbRHWNXv>; Thu, 23 Aug 2001 09:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270134AbRHWNXl>; Thu, 23 Aug 2001 09:23:41 -0400
Received: from duba04h04-0.dplanet.ch ([212.35.36.38]:61449 "EHLO
	duba04h04-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S270132AbRHWNXh>; Thu, 23 Aug 2001 09:23:37 -0400
Date: Thu, 23 Aug 2001 15:22:00 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Subject: [PATCH (URL), RFC] Stackable dmi_blacklist rules
Message-ID: <20010823152200.A853@tm.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
X-Operating-System: Linux 2.4.8-ac7 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please Cc: me on replies as I'm not subscribed to lkml. I am interested
in feedback on whether this is a track worth following. The actual
patch will probably fail against anything but 2.4.8-ac9 anyway.

The dmi_blacklist has become pretty popular in a short time (two dozen
entries as of 2.4.8-ac9). When I was about to write an entry for yet
another Sony BIOS, I wondered if there was a way to make the system
more flexible.

Currently, we walk the list and throw out bad apples based on full
or partial strings we match against what we get from the BIOS.
Once a rule matches, the value is immutable.

This prevents us from directly coding something like (fake examples):

- use fix for apm quirk on all Sony BIOS except BIOS R03
- disable IDE DMA for VIA but allow it for revisions which are
  known to be good

A possible solution would be to allow rules to override previous rules.

While stackable blacklist rules allow for shorter encoding of the
same information, there is a potential for an improved development
process that I consider equally important.

For instance, in order to reduce the exceedingly long list of Sony
BIOSes we might as well blacklist them all and declare good whatever
we find to work later.

Because the rules are walked in order, we could stack any number
of them as long as we sorted them properly: the most specific rules
would have to go to the end of the list.

What the patch does
-------------------
The simple patch I wrote adds an integer field to struct dmi_blacklist
which defines whether the rule will turn the specified flag on or off
(all currently defined rules turn the flag on, obviously).

The callback functions were changed to reflect the new
behavior. Basically, instead of saying "This is broken" they will say
"Workaround: on" (or off, respectively).

For IDE DMA, I made sure that the blacklist never overrides the boot
parameter (ide=nodma). The same could be done for other parameters
as well, but this patch is a proof of concept at this stage.

The patch is against 2.4.8-ac9, the dmi_blacklist hunk is likely
to fail with every other kernel (it's trivial to merge the rejected
lines, though).

It is quite long (the dmi_blacklist table alone is over 150 lines)
and I guess few people are interested in applying it right now anyway,
so here's where to get it:

http://hellgate.ch/work/dmi_blacklist.diff

Roger Luethi

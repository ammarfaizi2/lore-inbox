Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTESTEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 15:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTESTEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 15:04:55 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:46787 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262813AbTESTEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 15:04:49 -0400
Date: Mon, 19 May 2003 15:18:14 -0400 (EDT)
From: Ralph Doncaster <ralph@istop.com>
Reply-To: ralph+d@istop.com
To: Jamal Hadi <hadi@shell.cyberus.ca>
Cc: "David S. Miller" <davem@redhat.com>,
       "fw@deneb.enyo.de" <fw@deneb.enyo.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
       "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
       "linux-net@vger.kernel.org" <linux-net@vger.kernel.org>
Subject: Re: Route cache performance under stress
In-Reply-To: <20030519132819.S38814@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.51.0305191408490.1795@ns.istop.com>
References: <87d6iit4g7.fsf@deneb.enyo.de> <20030517.150933.74723581.davem@redhat.com>
 <87iss87gqd.fsf@deneb.enyo.de> <20030518.023151.77034834.davem@redhat.com>
 <20030519132819.S38814@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I looked at the route-cache code, efficient wasn't the word the came
to mind.  Whether the problem is in the route-cache or not, getting
>100kpps out of a linux router with <= 1Ghz of CPU is not at all an easy
task.  I've tried 2.2 and 2.4 (up to 2.4.20) with 3c905CX cards, with and
without NAPI, on a 750Mhz AMD.  I've never reached 100kpps without
userland (zebra) getting starved.  I've even tried the e1000 with 2.4.20,
and it still doesn't cut it (about 50% better performance than the 3Com).
This is always with a full routing table (~110K routes).

If I actually had the time to do the code, I'd try dumping the route-cache
altogether and keep the forwarding table as an r-tree (probably 2 levels
of 2048 entries since average prefix size is /22).  Frequently-used routes
would lookup faster due to CPU cache hits.  I'd have all the crap for
source-based routing ifdef'd out when firewalling is not compiled in.

My next try will be with FreeBSD, using device polling and the e1000 cards
(since it seems there are no polling patches for the 3c905CX under
FreeBSD).  From the description of how polling under FreeBSD works
http://info.iet.unipi.it/~luigi/polling/
vs NAPI under linux, polling sounds better due to the ability to configure
the polling cycle and CPU load triggers.  From the testing and reading
I've done so far, NAPI doesn't seem to kick in until after 75-80% CPU
load.  With less than 25kpps coming into the box zebra seems to take
almost 10x longer to bring up a session with full routes than it does with
no packet load.  Since CPU load before zebra becomes active is 70-75%, it
would seem a lot of cycles is being wasted on context switching when zebra
gets busy.

If there is a way to get the routing performance I'm looking for in Linux,
I'd really like to know.  I've been searching an asking for over a year
now.  When I initially talked to Jamal about it, he told me NAPI was the
answer.  It does help, but from my experience it's not the answer.  I get
the impression nobody involved in the code has has tested under real-world
conditions.  If that is, in fact, the problem then I can provide an ebgp
multihop full feed and a synflood utility for stress testing.  If the
linux routing and ethernet driver code is improved so I can handle 50kpps
of inbound regular traffic, a 50kpps random-source DOS, and still have 50%
CPU left for Zebra then Cisco might have something to worry about...

Ralph Doncaster, president
6042147 Canada Inc. o/a IStop.com

On Mon, 19 May 2003, Jamal Hadi wrote:

>
> Florian,
> I actually asked you to run some tests last time you showed up
> on netdev but never heard back. Maybe we can get some results now
> that the complaining is still continuing. Note, we cant just invent
> things because "CISCO is doing it like that". That doesnt cut it.
> What we need is data to substantiate things and then we move from there.
>
> And oh, i am pretty sure we can beat any of the BSDs forwarding rate.
> Anyone wants a duel, lets meet at the water fountain by the town
> hall at sunrise.
>
> cheers,
> jamal
>
>
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261875AbSIYBdY>; Tue, 24 Sep 2002 21:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261876AbSIYBdY>; Tue, 24 Sep 2002 21:33:24 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:15038
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S261875AbSIYBdX>; Tue, 24 Sep 2002 21:33:23 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200209250138.g8P1cMq24971@www.hockin.org>
Subject: Re: alternate event logging proposal
To: bhards@bigpond.net.au (Brad Hards)
Date: Tue, 24 Sep 2002 18:38:22 -0700 (PDT)
Cc: thockin@hockin.org (Tim Hockin), greearb@candelatech.com (Ben Greear),
       linux-kernel@vger.kernel.org (linux-kernel mailing list),
       cgl_discussion@osdl.org (cgl_discussion mailing list),
       evlog-developers@lists.sourceforge.net (evlog mailing list)
In-Reply-To: <200209251114.53657.bhards@bigpond.net.au> from "Brad Hards" at Sep 25, 2002 11:14:53 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To what level would you see this going?

Not sure - someone talked about receiving all sorts of device events.
Certainly do-able, but it may be desirable to really limit the domain.

> I'm currently doing some documentation work on the input subsystem, and it 
> produces events (/dev/input/eventX) for every mouse movement, every key press 
> (and release), etc. Now most of the application interested in those events 

So I'd say this level of heavy traffic probably deserves it's own event
mechanism that is more lightweight than eventd.  The more generic it is, the
more each event costs (currently O(n) - 1 regex comparison for each
client/config).  Putting high volume mouse/kb events would likely suck.

> > True, and if a dev_event file were created, I'd consider doing it that way.
> > But in that case it's easier for apps to talk to eventd (nee acpid) and get
> > only the messages they want.

> I think that the eventd advantage is that it is easy to do integration with 
> non-event aware apps. Example: eventd re-writes the config file and SIGHUPs 
> the application.

This eventd I'm speaking of is what currently exists as acpid.  It reads
ACPI events and does just that - runs some user-defined handlers and alerts
processes on a UNIX socket.

It does make it possible to do things like not modify DHCP client at all,
and just thump it with a HUP.  It also means everyone needs to be running
eventd.  And then you still have the 'need-an-edge' problem.  If DHCP starts
and hangs because it can't find the network (assume an unplugged NIC),
nothing is going to come along and tell it there is no link because there
was no edge.

By making something like (just for argument) /netdevfs/eth0/link, dhcp could
read that, find a "0" and go to sleep on a poll() of that same fd.  But you
need to modify DHCP.

Advantages and disadvantages to all models.  Which is why I brought it up
for debate.  IFF it is even attainable for 2.5.x.  It certainly is for just
netif style events.  On a broader scope?  Maybe not.  Another drawback of
the generic event file is that you now have a lot more people to please with
a generic enough protocol.

Tim

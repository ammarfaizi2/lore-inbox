Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTIBKV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 06:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263641AbTIBKV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 06:21:58 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:19100 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263631AbTIBKVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 06:21:55 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <20030901233023.F22682@flint.arm.linux.org.uk>
References: <20030831232812.GA129@elf.ucw.cz>
	 <Pine.LNX.4.44.0309010925230.7908-100000@home.osdl.org>
	 <20030901211220.GD342@elf.ucw.cz>
	 <20030901225243.D22682@flint.arm.linux.org.uk>
	 <20030901221920.GE342@elf.ucw.cz>
	 <20030901233023.F22682@flint.arm.linux.org.uk>
Message-Id: <1062498096.757.45.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 02 Sep 2003 12:21:37 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: Fix up power managment in 2.6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> However, I'll let the PPC people justify the real reason for the driver
> model change, since it was /their/ requirement that caused it, and I'm
> not going to fight their battles for them.  (although I seem to be doing
> exactly that while wasting my time here.)
> It's about time that the people in the PPC community, who were the main
> guys pushing for the driver model change, spoke up and justified this.

Ok, actually it was me, and it was not about PPC specifics but rather
about having sane semantics that actually mean something ;)

The whole point was to get rid of the old 2 step save_state, then
suspend model which didn't make sense. A saved state is only meaningful
as long as that state doesn't get modified afterward, so saving state
and suspending are an atomic operation.

That also means that I plan in the long run to also kill the PCI
save_state. We didn't do that yet to not harm drivers more than we
already did though ;)

Now, about that late "without interrupts" thing. Well, this is not
entirely my design idea, so I'll let Patrick speak up, as I wrote
previously, I'm not too fond of the "I return -EAGAIN" thing, on
the other hand, I wanted to kill the suspend vs. powerdown
distinction we had for a very simple reason:

Once you have suspended the whole PM tree, you can't expect a random
driver to be able to talk to it's device anymore since the "parent"
have been suspended. For example, a USB or 1394 device cannot be
"powered down" at this stage as the previous "suspend" run will have
stopped all activity on the host controller. Since I wanted the overall
PM semantics to be consistent, I asked Patrick to consider removing that
"power down" step. The fact of powering down the device is part of the
same "atomic" suspend operation, deciding wether to power down or not
the device depends solely on the target state (you typically don't do it
for S4 as you expect a complete machine shutdown afterward).

Now, we still had that need, for a few drivers (and in most cases, this
is really about system devices, so it doesn't fit in the same model
anyway, but still, we have a few broken thingies on PCI too), where a
driver need to be suspended "late" (actually powered down late) when
system interrupts have been disabled because that bit of HW is
terminally broken and will assert it's interrupt line in a non
controlled way.

That's the only reason why the powerdown call to the driver model still
exist and why Patrick kept around that mecanism of returning -EAGAIN.

So such a driver is expected to do the following:

 - first suspend will actually suspend the IOs as expected (block queues
for
a block driver, stop net queue for a network driver, etc....) and
basically do everything but the actual power down of the device. Then,
it returns -EAGAIN instead of 0 to request beeing called late for
power down.

 - second suspend will do the last step.

(I do agree that having the same callback called twice without an
indication of "when" in those 2 steps it is called isn't the best API we
could come up with, but I prefered that to adding a paremeter to
suspend() just for this special case).

This is only to be used on such "broken" devices and only on busses
where you know that your "host" bus is still available after the round
of "suspend" calls (and even PCI may not in some cases), so this is not
something I'd like to see people use too much.

Finally, to reply about UHCI/USB "brokenness", I've been working with
David Brownell and other USB folks lately to get that working properly,
it was not just a matter of adapting to the new callbacks, but also to
do the right thing on the host controller, hopefully, David now has some
patches that will be merged soon that implement proper PM on USB as well
(at least for the host side, I suppose a bunch of device drivers will
have to be fixed, with the new stuff, they'll just get -ESHUTDOWN when
trying to submit URBs after the host is suspended).

Pavel, please keep in mind that proper PM is a difficult task, what we
had before was full of holes, we spent a significant amount of time over
the past year debating the right way to do all of this and Patrick spent
even more time actually implementing it, so rather than just crying
loud, I'd epxect you rather help us fixing what still need to be.

Ben.



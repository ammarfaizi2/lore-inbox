Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbRFPTYO>; Sat, 16 Jun 2001 15:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264647AbRFPTYE>; Sat, 16 Jun 2001 15:24:04 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:23054 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264624AbRFPTXw>; Sat, 16 Jun 2001 15:23:52 -0400
Date: Sat, 16 Jun 2001 12:22:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Eric Smith <eric@brouhaha.com>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com, mj@ucw.cz
Subject: Re: 2.4.2 yenta_socket problems on ThinkPad 240
In-Reply-To: <E15BKjk-0008Pu-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0106161153440.9942-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Jun 2001, Alan Cox wrote:
>
> > Cardbus shouldn't be touching the bus stuff at all, BUT there may be
> > strange hardware that doesn't like the following:
> > 
> >         config_writeb(socket, PCI_SEC_LATENCY_TIMER, 176); 
> > 	config_writeb(socket, PCI_PRIMARY_BUS, dev->bus->number);
> >         config_writeb(socket, PCI_SECONDARY_BUS, dev->subordinate->number);
> >         config_writeb(socket, PCI_SUBORDINATE_BUS, dev->subordinate->number);
> > 
> > I have heard rumors of PCI devices that want all these set with a single
> > double-word write.
> 
> That would be consistent with the behaviour in the bugzilla report - it went
> from 0,0,0,1 to  176,0,0,0...

Hmm. It might be equally possible that we just get a bus number wrong
somewhere. In fact, looking at it more I think the yenta code is just
wrong - it uses the wrong bus numbers as far as I can see.

(And also, the generic PCI code _will_ write some of the bus information
with byte writes, so the "use a dword write" thing is not necessarily a
major requirement. See how the pci.c code writes the fixed-up subordinate
bus, for example).

As far as I can tell, the yenta code should _really_ do something like

	PCI_PROMARY_BUS:	dev->subordinate->primary
	PCI_SECONDARY_BUS:	dev->subordinate->secondary
	PCI_SUBORDINATE_BUS:	dev->subordinate->subordinate
	PCI_SEC_LATENCY_TIMER:	preferably settable, not just hardcoded to 176

instead of playing with "dev->bus->number" (which _should_ be the same as
it is now), and "subordinate->number" (which is _not_ the same as
"subordinate->subordinate".

So I think the bugzilla report just reflects the fact that we got
"PCI_SUBORDINATE_BUS" wrong.

Now, that is pretty much meaningless, as far as I can tell, because the
original 0,0,0,1 is _also_ bogus. No way should "secondary" be 0, as far
as I can tell - that would cause two buses to have bus # 0.

I suspect that the "fix" for this may be simpler than it initially
appears:

 - fix yenta.c to write the right values (ie get "subordinate" right -
   this will really only matter if/once we get PCI:PCI bridges on a
   cardbus card, and this is probably why nobody really reacted
   before). See above for the proper values.

 - Fix the "do I need to assign this bus" test in drivers/pci/pci.c. Right
   now it is:

	if ((buses & 0xffff00) && !pcibios_assign_all_busses()) {

   and from what I can tell it should really be more along the lines of

	primary = buses & 0xff;
	secondary = (buses >> 8) & 0xff;
	subordinate = (buses >> 16) & 0xff;

	assign = pcibios_assign_all_busses();

	/* Bus 0 should be the host bus */
	if (!secondary || !subordinate)
		assign = 1;

	/* Primary should be the same as the bus the bridge is on */
	if (primary != dev->bus->number)
		assing = 1;

	/* Subordinate should be larger or equal to secondary */
	if (secondary > subordinate)
		assign = 1;

#if 0
	/*
	 * We don't actually have full parent range - most of the time we
	 * don't understand host bridge ranges. Eventually we can do:
	 */

	/* The range [secondary:subordinate] must not contain the parent bus */
	if (secondary <= dev->bus->number && subordinate >= dev->bus->number)
		assign = 1;

	/* The range [secondary:subordinate] should be in the parent range */
	if (secondary < dev->bus->secondary)
		assign = 1;
	if (subordinate > dev->bus->subordinate)
		assign = 1;
#else
	/*
	 * In the meantime, we'll just _assume_ that all PCI bus numbers
	 * should be assigned in increasing order from the parent
	 */
	if (secondary <= dev->bus->number)
		assign = 1;
#endif

But the above is just my quick off-the-cuff "these are better
sanity-tests" thing, somebody else with PCI bus understanding should check
it out even more.

Jeff? Comments?

		Linus


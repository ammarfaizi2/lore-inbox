Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277135AbRJDGbF>; Thu, 4 Oct 2001 02:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277136AbRJDGap>; Thu, 4 Oct 2001 02:30:45 -0400
Received: from chiara.elte.hu ([157.181.150.200]:19465 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S277135AbRJDGaf>;
	Thu, 4 Oct 2001 02:30:35 -0400
Date: Thu, 4 Oct 2001 08:28:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110031848220.7244-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33.0110040752330.1727-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Oct 2001, jamal wrote:

> > which in turn stops that device as well sooner or later. Optionally,
> > in the future, this can be made more finegrained for chipsets that
> > support device-independent IRQ mitigation features, like the USB 2.0
> > EHCI feature mentioned by David Brownell.

> I think each subsytem should be in charge of its own fate. USB applies
> in whatever subsystem it belongs to. Cooperating subsystems doing what
> os best for the system.

this is a claim that is nearly perverse and shows a fundamental
misunderstanding of how Linux handles error situations. Perhaps we should
never check NULL pointer dereference in the networking code? Should the
NMI oopser not debug networking related lockups? Should we never print a
warning message on a double enable_irq() in a bad networking driver?

*of course* if a chipset supports IRQ mitigation then the generic IRQ code
can be enabled to use it. We can have networking devices over USB as well.
USB is a bus protocol that provides access to devices, not just a
'subsystem'. And *of course*, the IRQ code is completely right to do
various sanity checks - as it does today.

Linux has various safety nets in various places - always had. It's always
the history of problems in a certain area, the seriousness and impact of
the problem, and the intrusiveness of the safety approach that decides
whether some safety net is added or not, whether it's put under
CONFIG_KERNEL_DEBUG or not. While everybody is free to disagree about the
importance of this particular safety net, just saying 'do not mess with
*our* interrupts' sounds rather childish. Especially considering that
tools are available to trigger lockups via broadband access. Especially
considering that just a few mails earlier you claimed that such lockups do
not even exist. To quote that paragraph of yours:

# Date: Wed, 3 Oct 2001 08:49:51 -0400 (EDT)
# From: jamal <hadi@cyberus.ca>

[...]
# You dont need the patch for 2.4 to work against any lockups. And
# infact i am suprised that you observe _any_ lockups on a PIII which
# are not observed on my PII. Linux as is, without any tuneups can
# handle upto about 40000 packets/sec input before you start observing
# user space startvations. This is about 30Mbps at 64 byte packets; its
# about 60Mbps at 128 byte packets and comfortable at 100Mbps with byte
# size of 256. We really dont have a problem at 100Mbps.

so you should never see any lockups.

> Your patch with Linus' idea of "flag mask" would be more acceptable as
> a last resort. All subsytems should be cooperative and we resort to
> this to send misbehaving kids to their room.

i have nothing against it in 2.5, of course. Until then => my patch adds
an irq.c daddy that sends the bad kids to their room.

> > Your NAPI patch, or any driver/subsystem that does flowcontrol accurately
> > should never be affected by it in any way. No overhead, no performance
> > hit.
>
> so far your appraoch is that of a shotgun [...]

i'm not sure what this has to do with your NAPI patch. You should never
see the code trigger. It's an unused sledgehammer (or shotgun) put into
the garage, as far as NAPI is concerned. And besides, there are lots of
people on your continent that believe in spare shotguns ;)

i'd rather compare this approach to an airbag, or perhaps shackles.
Interrupt auto-limiting, despite your absurd and misleading analogy, does
not 'destroy' or 'kill' anything. It merely limits an IRQ source for up to
10 msecs (if HZ is 1000 then it's only 1 msec), if that IRQ source has
been detected to be critically misbehaving.

	Ingo


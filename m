Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSLYVox>; Wed, 25 Dec 2002 16:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbSLYVox>; Wed, 25 Dec 2002 16:44:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35338 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261370AbSLYVov>; Wed, 25 Dec 2002 16:44:51 -0500
Date: Wed, 25 Dec 2002 13:54:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Bjorn Helgaas <bjorn_helgaas@hp.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] Fix CPU bitmask truncation
In-Reply-To: <1040852588.1770.35.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0212251349010.9988-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 Dec 2002, Alan Cox wrote:

> On Fri, 2002-12-20 at 17:00, Bjorn Helgaas wrote:
> > This was an issue with gcc 2.96 on a 64-way IA64 box.  I don't have
> > access to one at the moment, but as I remember, without the 2.4 changes:
> >
> > -       ((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))
> > +       ((p)->cpus_runnable & (p)->cpus_allowed & (1UL << cpu))
> >
> > nothing would get scheduled on CPUs 32-63.  I guess those changes
> > aren't controversial, though.
>
> Is this a C quirk or a compiler bug ?

It's normal C behaviour. I wouldn't even call it a quirk.

	1 << cpu

is clearly an int, and as such will have undefined behaviour for cpu >
bits-of-int.

The promotion to unsigned long happens _after_ the shift has already
happened as an int, since nothing in the sub-expression needs promotion
per se.

As undefined behaviour, the C compiler is _allowed_ to do what we meant,
but quite frankly, a C compiler that would take the undefined behaviour
case and turn it into the "unsigned long" behaviour we were looking for
would be quite interesting and almost certainly just random luck.

So if you want to test a bit in an "unsigned long", you should do either

	(x >> bit) & 1

(where the shift will be on a "long", and the binary and will also be
automatically promoted to a unsigned long) or you should do

	x & (1UL << bit)

which is what the patch did (it's applied in 2.5.53 already, btw).

		Linus


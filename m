Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276647AbRKHROx>; Thu, 8 Nov 2001 12:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRKHROp>; Thu, 8 Nov 2001 12:14:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16909 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276708AbRKHROc>; Thu, 8 Nov 2001 12:14:32 -0500
Date: Thu, 8 Nov 2001 09:10:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Krishna Kumar <kumarkr@us.ibm.com>
cc: Andreas Dilger <adilger@turbolabs.com>, <ak@muc.de>, <andrewm@uow.edu.au>,
        "David S. Miller" <davem@redhat.com>, <jgarzik@mandrakesoft.com>,
        <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>, <owner-netdev@oss.sgi.com>,
        <tim@physik3.uni-rostock.de>
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
In-Reply-To: <OFE014018A.D6D3430D-ON88256AFE.005C057D@boulder.ibm.com>
Message-ID: <Pine.LNX.4.33.0111080901400.1511-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Nov 2001, Krishna Kumar wrote:
> > >
> > > In short: It is wrong to do
> > >
> > >          if (jiffies <= start+HZ)
> > >
> > > and it is _right_ to do
> > >
> > >          if (jiffies - start <= HZ)
>
> I am sorry, but I still don't see the difference. I wrote a small
> program with different cases, but the values still come same
> irrespective of the input arguments to the checks. Could you tell
> under what conditions the checks wuold fail ? The 2's complement works
> the same for addition and subtraction. I have included the test
> program below.

Ok.

Let's give an example. HZ is 100, and we started just before jiffies
wrapped, and we want to check that we're within one second.

So "start" equals 0xfffffff0, and "jiffies" equals 0xfffffff5.

The first if-statement will say

	if (0xfffffff5 <= 0xfffffff0+100)

which is the same as

	if (0xfffffff5 <= 0x54)

which is

	if (0)

in short, the first statement will say that jiffies is _not_ within 100
ticks of "start", which is obviously wrong. Jiffies _is_ within 100 ticks,
it is in fact just 5 ticks after "start".

The second statement will say

	if (0xfffffff5 - 0xfffffff0 <= 100)

which is

	if (5 <= 100)

which is

	if (1)

which is _correct_. We _are_ within 100 ticks.

See?

Ok, that was wrap-around one way: the "+HZ" wrapped. Let's see the other
case, which is that "jiffies" has wrapped: start is still 0xfffffff0, but
jiffies has wrapped around and is 0x00000001.

The first if-statement will say

	if (0x00000001 <= 0xfffffff0+100)

which is

	if (0x00000001 <= 0x54)

which is

	if (1)

which is correct. The second one will say

	if (0x00000001 - 0xfffffff0 <= 100)

which is

	if (11 <= 100)

which is

	if (1)

which is correct.

In short, the _correct_ one ALWAYS gets the right answer. Even when the
subtraction overflows.

While the first (and incorrect one) gets the wrong answer when the
addition overflows.

Do you see the difference now?

		Linus


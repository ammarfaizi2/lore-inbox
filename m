Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277012AbRKHRvp>; Thu, 8 Nov 2001 12:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276988AbRKHRvf>; Thu, 8 Nov 2001 12:51:35 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:61673 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277012AbRKHRvb>; Thu, 8 Nov 2001 12:51:31 -0500
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, ak@muc.de, andrewm@uow.edu.au,
        "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
        owner-netdev@oss.sgi.com, tim@physik3.uni-rostock.de
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFD59796BB.88D69925-ON88256AFE.006169C1@boulder.ibm.com>
From: "Krishna Kumar" <kumarkr@us.ibm.com>
Date: Thu, 8 Nov 2001 09:47:17 -0800
X-MIMETrack: Serialize by Router on D03NM066/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 11/08/2001 10:51:16 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Thanks for your clarification, it does make sense. I did only
the jiffies overflowing case, and missed the case where it
does not overflow.

Thanks,

- KK
-----------------------------------------------------------------------------

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


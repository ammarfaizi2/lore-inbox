Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276309AbRJCOQN>; Wed, 3 Oct 2001 10:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276317AbRJCOQE>; Wed, 3 Oct 2001 10:16:04 -0400
Received: from colorfullife.com ([216.156.138.34]:19460 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S276309AbRJCOP4>;
	Wed, 3 Oct 2001 10:15:56 -0400
Message-ID: <002c01c14c15$f270d6b0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "jamal" <hadi@cyberus.ca>
Cc: <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@elte.hu>,
        "Andreas Dilger" <adilger@turbolabs.com>, <linux-netdev@oss.sgi.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Date: Wed, 3 Oct 2001 16:15:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 3 Oct 2001, jamal wrote:
> > On Wed, 3 Oct 2001, Ingo Molnar wrote:
> > >
> > > but the objectives, judging from the description you gave, are i
> > > think largely orthogonal,  with some overlapping in the polling
> > > part.
> >
> > yes. Weve done a lot of thoroughly thought work in that area and i
> > think it will be a sin to throw it out.
> >
>
> I hit the send button to fast..
> The dynamic irq limiting (it must not be set by a system admin to
> conserve the principle of work) could be used as a last resort.
> The point is, if you are not generating a lot of interupts to begin
> with (as is the case with NAPI), i dont see the irq rate limiting
> kicking in at all.

A few notes as seen for low-end nics:

Forcing an irq limit without asking the driver is bad - it must be the
opposite way around.
e.g. the winbond nic contains a bug that forces it to 1 interrupt/packet
tx, but I can switch to rx polling/mitigation.
I'm sure the ne2k-pci users would also complain if a fixed irq limit is
added - I bet the majority of the drivers perform worse with a fixed
limit, only some perform better, and most perform best if they are given
a notice that they should reduce their irq rate. (e.g. disable
rx_packet, tx_packet. Leave the error interrupts on, and do the
rx_packet, tx_packet work in the poll handler)

But a hint for the driver ("now switch mitigation on/off") seems to be a
good idea. And that hint should not be the return value of netif_rx -
what if the driver is only sending packets?
What if it's not even a network driver?

NAPI seems to be very promising to fix the total system overload case
(so many packets arrive that despite irq mitigation the system is still
overloaded).

But the implementation of irq mitigation is driver specific, and a 10
millisecond stop is far too long.

--
    Manfred




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbTBGORX>; Fri, 7 Feb 2003 09:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbTBGORX>; Fri, 7 Feb 2003 09:17:23 -0500
Received: from betty.seh.de ([195.145.22.40]:46596 "EHLO seh.de")
	by vger.kernel.org with ESMTP id <S265409AbTBGORV> convert rfc822-to-8bit;
	Fri, 7 Feb 2003 09:17:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Martin Zielinski <mz@seh.de>
Organization: SEH Computertechnik GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: TCP Connection times out
Date: Fri, 7 Feb 2003 15:31:53 +0100
X-Mailer: KMail [version 1.4]
References: <Pine.LNX.3.95.1030207083742.28526B-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1030207083742.28526B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302071531.53214.mz@seh.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the prompt reply.
The situation is a bit different. Sorry for not providing all infos:

Actually the printer network interface ACKs all incoming packets
with window size zero

Everything is fine until the standard TCP/IP implementation shifts
a "22" (tp->rto) 31 (tp->backoff) times to the left and sends 16 ACKS in 
0.5ms, because it does no timeouts between them.

A "60 minute paper empty"-situation should not cause problems.

I could provide a tcpdump trace of this, if wanted.

Thanks,
martin

On Friday 07 February 2003 14:49, Richard B. Johnson wrote:
> On Fri, 7 Feb 2003, Martin Zielinski wrote:
> > Hello,
> > I'm not on the list, so I'm not really informed what's going on. But...
> >
> > our problem is a network printer the has paper empty.
> > The socket connection to the printer broke down after ~45 minutes with
> > errno 110 (Connection timed out).
> >
> > Linux base version is 2.4.18 on a strongarm machine.
> >
> > Tracking this down brought us to the tcp_send_probe0 function in
> > net/ipv4/tcp_output.c.
> > The tp->backoff value becomes allways increased.
> > on this machine from 31 on  (tp->rto << tp->backoff) is 0.
> >
> > The xmit timer is set to this timeout value - resulting in an ACK burst.
> > If the TCP sender gets the (default) 16 ACKS out, before the receiver can
> > answer them, the connection dies.
> > This happened every night, when the printer received a huge job from a
> > foreign  office.
> >
> > If this isn't a bug, it should be made configurable. Or do we miss
> > something?
> >
> > Thanks.
>
> Get new firmware for your printer. It's broken. The connection
> timed out because the connection timed out, i.e., when the printer
> is out of paper, it refuses to ACK incoming packets. You do not
> modify a standard TCP/IP implementation to fix a broken printer.
>
> The printer is expecting to hold-off incoming network data, by
> refusing to ACK it, until someone adds more paper. This is
> unconsionable behavior that violates any standards of Engineering
> practice. There is no time-out you could increase because the
> printer may be out-of-paper forever, i.e., somebody needs to go
> buy some. Network-connected devices just can't do things this
> way. The name of the vendor should be published and the vendor
> "educated" in such a way that no such printers remain connected
> to a network until they are fixed.
>
> And, if Linux didn't follow the standard, and let dead "connected"
> devices remain in a connected state, servers that use connections
> would would become impossible.
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
> Why is the government concerned about the lunatic fringe? Think about it.

-- 
Martin Zielinski       mz@seh.de


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265143AbUAKNxe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 08:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbUAKNxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 08:53:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58380 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265143AbUAKNxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 08:53:15 -0500
Date: Sun, 11 Jan 2004 13:53:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040111135309.F1931@flint.arm.linux.org.uk>
Mail-Followup-To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	linux-kernel@vger.kernel.org
References: <1073771855.3958.15.camel@nidelv.trondhjem.org> <Pine.LNX.4.44.0401102338270.7120-100000@poirot.grange> <20040111131857.GA11246@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040111131857.GA11246@hh.idb.hist.no>; from helgehaf@aitel.hist.no on Sun, Jan 11, 2004 at 02:18:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 02:18:57PM +0100, Helge Hafting wrote:
> On Sat, Jan 10, 2004 at 11:42:45PM +0100, Guennadi Liakhovetski wrote:
> > The only my doubt was - yes, you upgrade the __server__, so, you look in
> > Changes, upgrade all necessary stuff, or just upgrade blindly (as does
> > happen sometimes, I believe) a distribution - and the server works, fine.
> > What I find non-obvious, is that on updating the server you have to
> > re-configure __clients__, see? Just think about a network somewhere in a
> 
> If you upgrade the server and read "Changes", then a note in changes might
> say that "you need to configure carefully or some clients could get in trouble."
> (If the current "Changes" don't have that - post a documentation patch.)

[This is more to Guennadi than Helge]

I don't see why such a patch to "Changes" should be necessary.  The
problem is most definitely with the client hardware, and not the
server software.

The crux of this problem comes down to the SMC91C111 having only a
small on-board packet buffer, which is capable of storing only about
4 packets (both TX and RX).  This means that if you receive 8 packets
with high enough interrupt latency, you _will_ drop some of those
packets.

Note that this is independent of whether you're using DMA mode with
the SMC91C111 - DMA mode only allows you to off load the packets from
the chip faster once you've discovered you have a packet to off load
via an interrupt.

It won't be just NFS that's affected - eg, if you have 4kB NFS packets
and several machines broadcast an ARP at the same time, you'll again
run out of packet space on the SMC91C111.  Does that mean you should
somehow change the way ARP works?

Sure, reducing the NFS packet size relieves the problem, but that's
just a work around for the symptom and nothing more.  It's exactly
the same type of work around as switching the SMC91C111 to operate at
10mbps only - both work by reducing the rate at which packets are
received by the target, thereby offsetting the interrupt latency
and packet unload times.

Basically, the SMC91C111 is great for use on small, *well controlled*
embedded networks, but anything else is asking for trouble.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

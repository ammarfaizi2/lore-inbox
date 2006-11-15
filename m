Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966836AbWKONET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966836AbWKONET (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 08:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966835AbWKONET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 08:04:19 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:33037 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S966833AbWKONES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 08:04:18 -0500
Date: Wed, 15 Nov 2006 08:03:52 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: eli@dev.mellanox.co.il
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: UDP packets loss
Message-ID: <20061115130352.GB721@hmsreliant.homelinux.net>
References: <60157.89.139.64.58.1163542547.squirrel@dev.mellanox.co.il> <20061114143531.2ee7eae0@freekitty> <38090.194.90.237.34.1163545721.squirrel@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38090.194.90.237.34.1163545721.squirrel@dev.mellanox.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 01:08:41AM +0200, eli@dev.mellanox.co.il wrote:
> Thanks for the commets.
> I actually use UDP because I am seeking for ways to improve the
> performance of IPOIB and I wanted to avoid TCP's flow control. I am really
> up to making anaysis. Can you tell me more about irqbalnced? Where can I
> find more info how to control it? I would like my interrupts serviced by
> all CPUs in a somehow equal manner. I mentioned MSIX - the driver already
> make use of MSIX and I thought this is relevant to interrupts affinity.
> 

If you want complete control over which CPU's service which interrupts, just
turn irqbalance off (usually service irqbalance stop).  Then use
/proc/irq/<irq_number>/smp_affinity to tune the cpu affinity for each interrupt.

That being said however, As Auke and others have mentioned, servicing interrupts
on multiple cpu's leads to lower performance, not higher performance.  cache
line bouncing is going to create greater latency for each interrupt you service
and slow you down overall.  I assume these are gigabit interfaces?  You're best
focus to improve throughput is to (if the driver supports it), tune your
interrupt coalescing factors such that you minimize the number of interrupts you
actually receive from the card.

Regards
Neil

> > On Wed, 15 Nov 2006 00:15:47 +0200 (IST)
> > eli@dev.mellanox.co.il wrote:
> >
> >> Hi,
> >> I am running a client/server test app over IPOIB in which the client
> >> sends
> >> a certain amount of data to the server. When the transmittion ends, the
> >> server prints the bandwidth and how much data it received. I can see
> >> that
> >> the server reports it received about 60% that the client sent. However,
> >> when I look at the server's interface counters before and after the
> >> transmittion, I see that it actually received all the data that the
> >> client
> >> sent. This leads me to suspect that the networking layer somehow dropped
> >> some of the data. One thing to not - the CPU is 100% busy at the
> >> receiver.
> >> Could this be the reason (the machine I am using is 2 dual cores - 4
> >> CPUs).
> >
> > If receiver application can't keep up UDP drops packets. The counter
> > receive buffer errors (UDP_MIB_RCVBUFERRORS) is incremented.
> >
> > Don't expect flow control or reliable delivery; it's a datagram service!
> >
> >> The secod question is how do I make the interrupts be srviced by all
> >> CPUs?
> >> I tried through the procfs as described by IRQ-affinity.txt but I can
> >> set
> >> the mask to 0F bu then I read back and see it is indeed 0f but after a
> >> few
> >> seconds I see it back to 02 (which means only CPU1).
> >
> > Most likely, the user level irq balance daemon (irqbalanced) is adjusting
> > it?
> >
> >>
> >> One more thing - the device I am using is capable of generating MSIX
> >> interrupts.
> >>
> >
> > Look at device capabilities with:
> >
> > 	lspci -vv
> >
> >
> > --
> > Stephen Hemminger <shemminger@osdl.org>
> >
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/

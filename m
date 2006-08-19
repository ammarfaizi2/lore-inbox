Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWHSEcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWHSEcN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 00:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWHSEcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 00:32:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:47589 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932335AbWHSEcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 00:32:12 -0400
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: linas@austin.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Jens.Osterkamp@de.ibm.com, jklewis@us.ibm.com,
       arnd@arndb.de
In-Reply-To: <20060818.155116.112621100.davem@davemloft.net>
References: <20060818192356.GD26889@austin.ibm.com>
	 <20060818.142513.29571851.davem@davemloft.net>
	 <20060818224618.GN26889@austin.ibm.com>
	 <20060818.155116.112621100.davem@davemloft.net>
Content-Type: text/plain
Date: Sat, 19 Aug 2006 14:31:20 +1000
Message-Id: <1155961881.5803.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 15:51 -0700, David Miller wrote:
> From: linas@austin.ibm.com (Linas Vepstas)
> Date: Fri, 18 Aug 2006 17:46:18 -0500
> 
> > > We're not saying to use the RX interrupt as the trigger for
> > > RX and TX work.  Rather, either of RX or TX interrupt will
> > > schedule the NAPI poll.
> > 
> > And, for a lark, this is exactly what I did. Just to see.
> > Because there are so few ack packets, there are very few 
> > RX interrupts -- not enough to get NAPI to actually keep
> > the device busy.
> 
> You're misreading me.  TX interrupts are intended to be "enabled" and
> trigger NAPI polls.  TX IRQ enabled, enabled :-)

Maybe be because you actually typed "disabled" in your previous
message ? :)

>> The idea is to use NAPI polling with TX interrupts disabled.

> If you want to eliminate them if the kernel keeps hopping into
> the ->hard_start_xmit() via hw interrupt mitigation or whatever,
> that's fine.  But if you do need to do TX interrupt processing,
> do it in NAPI ->poll().

Well, we do need to harvest descriptors of course, though I suppose that
can be done in hard_xmit as well. I'm not sure if there is any real
benefit in batching those.

> > I'm somewhat disoriened from this conversation. Its presumably
> > clear that low-watermark mechanisms are superior to NAPI. 
> > >From what I gather, NAPI was invented to deal with cheap 
> > or low-function hardware; it adds nothing to this particular
> > situation. Why are we talking about this?
> 
> NAPI is meant to give fairness to all devices receiving packets
> in the system, particularly in times of high load or overload.
> 
> And equally importantly, it allows you to run the majority of your
> interrupt handler in software IRQ context.

That is the most important point imho for the specific case of spidernet
on cell.

> This allows not only your
> locking to be simpler, but it also allows things like oprofile to
> monitor almost your entire IRQ processing path even with just timer
> interrupt based oprofile profiling.
> 
> I see you moving TX reclaim into tasklets and stuff.  I've vehemently
> against that because you wouldn't need it in order to move TX
> processing into software interrupts if you did it all in NAPI
> ->poll().

Ben.


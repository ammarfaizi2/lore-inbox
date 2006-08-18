Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWHRWvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWHRWvQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWHRWvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:51:15 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16877
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751494AbWHRWvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:51:14 -0400
Date: Fri, 18 Aug 2006 15:51:16 -0700 (PDT)
Message-Id: <20060818.155116.112621100.davem@davemloft.net>
To: linas@austin.ibm.com
Cc: benh@kernel.crashing.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Jens.Osterkamp@de.ibm.com, jklewis@us.ibm.com, arnd@arndb.de
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060818224618.GN26889@austin.ibm.com>
References: <20060818192356.GD26889@austin.ibm.com>
	<20060818.142513.29571851.davem@davemloft.net>
	<20060818224618.GN26889@austin.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linas@austin.ibm.com (Linas Vepstas)
Date: Fri, 18 Aug 2006 17:46:18 -0500

> > We're not saying to use the RX interrupt as the trigger for
> > RX and TX work.  Rather, either of RX or TX interrupt will
> > schedule the NAPI poll.
> 
> And, for a lark, this is exactly what I did. Just to see.
> Because there are so few ack packets, there are very few 
> RX interrupts -- not enough to get NAPI to actually keep
> the device busy.

You're misreading me.  TX interrupts are intended to be "enabled" and
trigger NAPI polls.  TX IRQ enabled, enabled :-)

If you want to eliminate them if the kernel keeps hopping into
the ->hard_start_xmit() via hw interrupt mitigation or whatever,
that's fine.  But if you do need to do TX interrupt processing,
do it in NAPI ->poll().

> I'm somewhat disoriened from this conversation. Its presumably
> clear that low-watermark mechanisms are superior to NAPI. 
> >From what I gather, NAPI was invented to deal with cheap 
> or low-function hardware; it adds nothing to this particular
> situation. Why are we talking about this?

NAPI is meant to give fairness to all devices receiving packets
in the system, particularly in times of high load or overload.

And equally importantly, it allows you to run the majority of your
interrupt handler in software IRQ context.  This allows not only your
locking to be simpler, but it also allows things like oprofile to
monitor almost your entire IRQ processing path even with just timer
interrupt based oprofile profiling.

I see you moving TX reclaim into tasklets and stuff.  I've vehemently
against that because you wouldn't need it in order to move TX
processing into software interrupts if you did it all in NAPI
->poll().

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWIIJzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWIIJzb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 05:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWIIJzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 05:55:31 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:42462 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751032AbWIIJza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 05:55:30 -0400
Message-ID: <45028F87.7040603@garzik.org>
Date: Sat, 09 Sep 2006 05:55:19 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: paulus@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, akpm@osdl.org, segher@kernel.crashing.org
Subject: Re: Opinion on ordering of writel vs. stores to RAM
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>	<Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>	<17666.11971.416250.857749@cargo.ozlabs.ibm.com> <20060909.023405.71099525.davem@davemloft.net>
In-Reply-To: <20060909.023405.71099525.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.4 (---)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-3.4 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Paul Mackerras <paulus@samba.org>
> Date: Sat, 9 Sep 2006 13:02:27 +1000
> 
>> I suspect the best thing at this point is to move the sync in writeX()
>> before the store, as you suggest, and add an "eieio" before the load
>> in readX().  That does mean that we are then relying on driver writers
>> putting in the mmiowb() between a writeX() and a spin_unlock, but at
>> least that is documented.
> 
> I think not matching what PC systems do is, at least from one
> perspective, a very bad engineering decision for 2 reasons.
> 
> 1) You will be chasing down these kinds of problems forever,
>    you will fix tg3 today, but tomorrow it will be another driver
>    for which you will invest weeks of delicate debugging that
>    could have been spent on much more useful coding
> 
> 2) Driver authors will not get these memory barriers right,
>    you can say they will because it will be "documented" but
>    that does not change reality which is that driver folks
>    will get simple interfaces right but these memory barriers
>    are relatively advanced concepts, which they thus will get
>    wrong half the time
> 
> Sure it's more expensive, but at least on sparc64 I'd much rather
> spend my time working on more interesting things than "today's
> missing memory barrier" :-)
> 
> I also don't want to see all of these memory barriers crapping up our
> drivers.  I do a MMIO, then I access a descriptor, or vice versa, then
> those should be ordered because they are both technically accesses to
> "physical device state".  Having to say this explicitly seems really
> the wrong thing to do, at least to me.

Agreed.

As (I think) BenH mentioned in another email, the normal way Linux 
handles these interfaces is for the primary API (readX, writeX) to be 
strongly ordered, strongly coherent, etc.  And then there is a relaxed 
version without barriers and syncs, for the smart guys who know what 
they're doing.  We used do this for fbdev drivers, I dunno what happened 
to that interface.

We want to make it tough for driver writers to screw up, unless they are 
really trying...

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWIIJde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWIIJde (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 05:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWIIJde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 05:33:34 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30104
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750798AbWIIJdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 05:33:32 -0400
Date: Sat, 09 Sep 2006 02:34:05 -0700 (PDT)
Message-Id: <20060909.023405.71099525.davem@davemloft.net>
To: paulus@samba.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       akpm@osdl.org, segher@kernel.crashing.org
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: David Miller <davem@davemloft.net>
In-Reply-To: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>
	<17666.11971.416250.857749@cargo.ozlabs.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mackerras <paulus@samba.org>
Date: Sat, 9 Sep 2006 13:02:27 +1000

> I suspect the best thing at this point is to move the sync in writeX()
> before the store, as you suggest, and add an "eieio" before the load
> in readX().  That does mean that we are then relying on driver writers
> putting in the mmiowb() between a writeX() and a spin_unlock, but at
> least that is documented.

I think not matching what PC systems do is, at least from one
perspective, a very bad engineering decision for 2 reasons.

1) You will be chasing down these kinds of problems forever,
   you will fix tg3 today, but tomorrow it will be another driver
   for which you will invest weeks of delicate debugging that
   could have been spent on much more useful coding

2) Driver authors will not get these memory barriers right,
   you can say they will because it will be "documented" but
   that does not change reality which is that driver folks
   will get simple interfaces right but these memory barriers
   are relatively advanced concepts, which they thus will get
   wrong half the time

Sure it's more expensive, but at least on sparc64 I'd much rather
spend my time working on more interesting things than "today's
missing memory barrier" :-)

I also don't want to see all of these memory barriers crapping up our
drivers.  I do a MMIO, then I access a descriptor, or vice versa, then
those should be ordered because they are both technically accesses to
"physical device state".  Having to say this explicitly seems really
the wrong thing to do, at least to me.

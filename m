Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVC2KsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVC2KsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVC2KsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:48:11 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:17934 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262332AbVC2KrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:47:08 -0500
Date: Tue, 29 Mar 2005 20:45:24 +1000
To: Pavel Machek <pavel@ucw.cz>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jeff Garzik <jgarzik@pobox.com>,
       David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050329104524.GC19468@gondor.apana.org.au>
References: <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda> <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda> <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda> <20050325061311.GA22959@gondor.apana.org.au> <20050329102104.GB6496@elf.ucw.cz> <20050329103049.GB19541@gondor.apana.org.au> <20050329103801.GE3897@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050329103801.GE3897@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 12:38:01PM +0200, Pavel Machek wrote:
> 
> It seems to me that people wanting this level of assurance should do
> their own FIPS (or whatever) tests.

That's exactly what the current scheme of driver + rngd allows you
to do.  For those that require high assurance, they can let rngd
do the checks.  Otherwise they can disable the checks and just let
rngd feed data from /dev/hw_random into /dev/random.

It's not just about the quality checks.  It's also about deciding the
rate at which data should be fed into /dev/random.

Feeding too much means that you might be wasting system resources
(CPU/PCI bus/etc.).  Feeding too little means that /dev/random users
may block unnecessarily.

Doing the feeding in a process means that you can feed exactly the
right amount.  You feed only when the /dev/random's pool is depleted
and you feed exactly the amount of data that is needed to replenish
the pool.

> Interrupts are not totally unpredictable, either, yet noone runs FIPS

I haven't looked at this but if that's the case we might want to
look at lowering the entropy count for that.

> > Someone else raised the example of Casinos using hardware RNGs.  Some
> > of them are doing this to comply with government regulation.  In that
> > case, using data from the software RNG when the hardware has failed
> > would be violating the law.
> 
> Well, you are still using hardware RNG, but failed one. I do not see
> how you can break law with that... given that hardware RNG had proper
> certification in the first place.

Actually in the scheme proposed in this thread the hardware RNG could
be feeding a stream of zeros into /dev/random which means that the
/dev/random user will be using a software RNG.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

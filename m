Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754927AbWKLDEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927AbWKLDEm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 22:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754928AbWKLDEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 22:04:42 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:61858 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1754926AbWKLDEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 22:04:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=TPyIUconBBaFazyzTlFn65iIbcFv13mGCH4ZIEIkCk345oEtikMe84DuXdJuk0PyeYk/7f0zfHeCoVKFL+OQaB9Ox6xYFnp3/QH+TdjmEgHqmW3xc2MXxZsrlTohMEs9IJS6KnQmQ7hYv/S2HXFh0mTSbDtLH/uC2Z75IZnFtN4=  ;
X-YMail-OSG: ClMXnXEVM1kjmfXbiy3FOpYd2e8sFBN_cnXqB4bFKQkpBnEyW7.HMnnR8PULHAjXzQoTkXtlH9zMgE8OkR6kEWPTa0gmZek1Yq3PISFLpo3K5nJyBT2xzjT2mBZWu1sSPAm8ZAWzFjD0yq82MMjQy.1mT7UASumUQIM-
From: David Brownell <david-b@pacbell.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Sat, 11 Nov 2006 19:04:34 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <45567868.8020405@zytor.com>
In-Reply-To: <45567868.8020405@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611111904.36817.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 November 2006 5:27 pm, H. Peter Anvin wrote:
> 
> If this is done, I think it's essential that a "high-level" API (one 
> that supports message-based GPIO) is provided at the same time. 

It's not a "high level" vs "low level" issue, though.  There are
dozens to hundreds of drivers that know they're using "real GPIOs",
and which *need* to do that.  For example, because the signals must
be accessed while holding a spinlock, or in_irq().

I'd like to see some "message based GPIO" API soonish, but can't buy
the notion that lack of one should be a blocking issue.  In fact,
if you go reread that LKML thread I referenced originally, you'll
notice that a key "why this can't fly" issue was that it didn't have
support for irq/spinlock safe GPIOs ... which make up by far the
majority of current GPIO users in Linux.


Lack of arch-neutral "real GPIO" calls is more or less a blocking
issue, given the merge of the AVR32 architecture ... unless you'd
like to argue it's a good thing to make drivers for integrated
controllers be (otherwise needlessly) be arch-specific?  One current
example is the "atmel_spi" driver, sharable between AVR32 and AT91;
Atmel reused a lot of the controllers from its AT91 ARM series when
they designed the AVR32 SOCs, and it doesn't make sense to have both
AT91 and AVR32 versions of the same drivers.


>		 The  
> "high-level" API should be able to address the GPIOs addressed by the 
> low-level API.  What we do *not* want is a bunch of stuff using the 
> low-level API when the high-level API would work.

If there were many (any?) drivers that didn't need to care, I might be
tempted to agree.  But there aren't ...

Another way to look at it is to notice how many spinlock-safe GPIO
APIs are in use **right now** on ARM ... that's on the order of a
dozen, which is a kind of existence proof that switching to the API in
the patch I sent would be a useful cleanup.   (And switching would be
mostly just syntax tweaks ... the primitives are all the same, except
for error checking; their names are just spelled differently.)

Even if there were only four platform specific drivers per architecture
which use GPIOs, that'd still be around 50 drivers that could stop using
arch-specific calls.  But some have many more than four, and I know there
are some drivers that never leave arch trees because they have no way to
get rid of platform-specific GPIO usage ...


And on the other side ... how many "message" based ones are there?
Darn few.  The pcf8574 driver is unusable by other kernel code, so
every board with a few of those chips has to roll its own solution;
inelegant, but not a burning issue.  And the tps65010 driver has a
solution that works OK now too.   A max7301 (spi) driver will need
to get a solutition for this too.

I suspect that userspace GPIO accessors should only be written once
though, and they're going to be in the "don't care" category.  So
lack of such a "message compatible" GPIO call set might reasonably
hold up merging that sort of (configfs?) interface.

- Dave


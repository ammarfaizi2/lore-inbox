Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVJCFBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVJCFBs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 01:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVJCFBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 01:01:48 -0400
Received: from pimout7-ext.prodigy.net ([207.115.63.58]:1271 "EHLO
	pimout7-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S1750767AbVJCFBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 01:01:48 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:message-id;
	b=DrKZuynMz9stDwAw/Wez3lDDwZpruST20x6BI1EJ8rpq7PiaMXyxE2qH2Q+Vq+gBo
	XsHtJpR9TlOAk9tQUbCCg==
Date: Sun, 02 Oct 2005 22:01:30 -0700
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH] SPI
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051003050130.EE003EA55B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >	<linux/spi/spi.h>	... main header
> >	<linux/spi/CHIP.h>	... platform_data, for CHIP.c driver
> >
> >Not all chips would need them, but it might be nice to have some place
> >other than <linux/CHIP.h> for such things.  The platform_data would have
> >various important data that can't be ... chip variants, initialization
> >data, and similar stuff that differs between boards is knowable only by
> >board-specific init code, yet is needed by board-agnostic driver code.
> >  
>
> What about SPI busses that are common for different boards?

I don't understand your question.  It's simple enough to clone
the board-specific.c files for related designs; that's the only
sense I can imagine in which two boards might have the "same"
bus.  (Using the same controller is a different topic.)


> >You're imposing the same implementation strategy Mark Underwood was.
> >I believe I persuaded him not to want that, pointing out three other
> >implementation strategies that can be just as reasonable:
> >
> >   http://marc.theaimsgroup.com/?l=linux-kernel&m=112684135722116&w=2
> >
> >It'd be fine if for example your PNX controller driver worked that way
> >internally.  But other drivers shouldn't be forced to allocate kernel
> >threads when they don't need them.
>
>
> Hm, so does that imply that the whole -rt patches from 
> Ingo/Sven/Daniel/etc. are implementing wrong strategy (interrupts in 
> threads)?

In an RT context, it may make sense to impose a policy like that.

But I recall those folk have said they're making things so that sanely
behaved kernel code will work with no changes.  And also that not all
kernels should be enabling RT support ...


> How will your strategy work with that BTW?

If they meet their goals, it'll work just fine.  Sanely behaved
implementations will continue to work, and not even notice.



> >>+  [ picture deleted ]
> >
> >That seems wierd even if I assume "platform_bus" is just an example.
> >For example there are two rather different "spi bus" notions there,
> >and it looks like neither one is the physical parent of any SPI device ...
>
>
> Not sure if I understand you :(

Why couldn't for example SPI sit on a PCI bus?

And call the two boxes different things, if they're really different.
The framework I've posted has "spi_master" as a class implmented
by certain controller drivers.  (Others might use "spi_slave", and
both would be types of "SPI bus".)  That would at least clarify
the confusion on the left half of that picture.



> >>+3.2 How do the SPI devices gets discovered and probed ?
> >>    
> >
> >Better IMO to have tables that get consulted when the SPI master controller
> >drivers register the parent ... tables that are initialized by the board
> >specific __init section code, early on.  (Or maybe by __setup commandline
> >parameters.)
> >
> >Doing it the way you are prevents you from declaring all the SPI devices in
> >a single out-of-the-way location like the arch/.../board-specific.c file,
> >which is normally responsible for declaring devices that are hard-wired on
> >a given board and can't be probed.
> >  
> >
> By what means does it prevent that?

Well "prevent" may be a bit strong, if you like hopping levels in
the software stack.  I don't; without such hopping (or without a
separate out-of-band mechanism like device tables), I don't see
a way to solve that problem.


> >>+#define SPI_MAJOR	153
> >>+
> >>+...
> >>+
> >>+#define SPI_DEV_CHAR "spi-char"
> >>    
> >>
> I thought 153 was the official SPI device number.

So it is (at least for minors 0..15, so long as they use some
API I can't find a spec for), but that wasn't the point.  The
point is to keep that sort of driver-specific information from
cluttering headers which are addressed to _every_ driver.

- Dave


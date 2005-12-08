Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751661AbVLHCAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbVLHCAB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 21:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbVLHCAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 21:00:01 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:3463 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751183AbVLHCAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 21:00:00 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH 2.6-git] SPI core refresh
Date: Wed, 7 Dec 2005 17:59:55 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
References: <20051201191109.40f2d04b.vwool@ru.mvista.com> <20051205210110.44a3ba4c.vwool@ru.mvista.com>
In-Reply-To: <20051205210110.44a3ba4c.vwool@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071759.56782.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 10:01 am, Vitaly Wool wrote:
> 
> Again, some advantages of our core compared to David's I'd like to mention
> 
> - it can be compiled as a module (as opposed to basic David's core w/o Mark Underwood's patch)
> - it is less priority inversion-exposed

These are actually minor issues, with almost trivial fixes.  (Pending.)

And I'd argue about the priority inversion thing ... the inversions in
your stuff come from the API, not the implementation.  Which makes the
problems inherent, rather than fixable:  "more" exposed, not "less".


> - it can gain more performance with multiple controllers

If this isn't a repeat of that priority-inversion case (fix available),
then I don't see what you're implying.  I have a hard time seeing any
potential for an issue there, since the I/O request path just shortcuts
to the controller driver.  It can't exactly get in the way!


> - it's more adapted for use in real-time environments

I think you still haven't explained what you mean by this, other than
maybe reminding that PREEMPT_RT interacts with some implementations.


> Well, what else? 
> 1. Now thw footprint of the pure (i. e. w/o device interface and thread-based
> handling) .text section is _less_ than 2k for ARM.

Hey, I started from that size *including* device interface etc.  If it's
exceeded now, it's because of the extra overhead from wrapping device_driver
with some spi_driver code.  ;)


> 2. We still think that thread-based async messages processing will be the most
> commonly used option so we didn't remove it from core but made it a compication
> option whether to include it or not. In any case it can be overridden by a
> specific bus driver, so even when compiled in, thread-based handling won't
> necessarily _start_ the threads, so the overhead is minimal even in that case.    

Whereas I've just said such threading policies don't belong in a "core" at
all.  You may have noticed the bitbanging adapter I posted ... oddly, that
implementation allocates a thread.  Hmm ...

That is:  you're not talking about capabilities that aren't already in
the SPI patches already circulating in 2.6.15-rc5-mm1 (from Sunday).
They're just layered differently ... the core is _minimal_ and those
implementation policies can be chosen without adding to the core.
(Or impacting drivers that want different implementation policies.)


> 3. We still don't feel comportable with complicated structure of SPI message in
> David's core being exposed to all over the world. On the other hand, chaining
> SPI messages can really be helpful,

The point has been made that such chaining is actually "essential", since
device interaction protocols have constraints like "chipselect must be
asserted during all these transfers" or contrariwise "between these transfers,
chipselect must be dropped for N microseconds".  If the async messages didn't
cover such linked message, then two activities could interfere with each other
quite badly ... they'd break hardware protocol requirements.


> so we added this option to our core (yeeeep, 
> convergence is gong on :)) but

My preferred level of convergence would be changes to make your code look
more like mine, especially where you're providing a mechanism that's been
in mine all along ... hmm, like spi_driver is the same now.  I made one
such change; maybe it's your turn now.  ;)

- Dave


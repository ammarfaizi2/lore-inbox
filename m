Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVDGXBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVDGXBM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 19:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVDGXBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 19:01:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:60126 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262567AbVDGXBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 19:01:05 -0400
Subject: Re: [PATCH] radeonfb: (#2) Implement proper workarounds for PLL
	accesses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Andreas Schwab <schwab@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e9970504071422349426eb@mail.gmail.com>
References: <1110519743.5810.13.camel@gaston>
	 <1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	 <1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>
	 <1112827655.9518.194.camel@gaston> <jehdii8hjk.fsf@sykes.suse.de>
	 <21d7e9970504071422349426eb@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 08:59:55 +1000
Message-Id: <1112914795.9568.320.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 07:22 +1000, Dave Airlie wrote:
> > There are 1694 calls to radeon_pll_errata_after_data during a switch from
> > X to the console and 393 calls the other way.
> 
> Wow... Ben that seems a bit extreme... there's not even close to 393 plls :-)

Yes, that's very extreme, I suspect somebody is banging on set_par or
something like that. Let me count a normal set_par operation:

 - blank. That can do INPLL, OUTPLLP and OUTPLL on MT_LCD, that is 4
calls to the errata (OUTPLLP has two). 

 - write_pll_regs which does
    * on mobility chips: 2x INPLL to test the PLL value, and if it
matches, just writes the PLL selector with a call to the errata, that
is only 3 calls to the errata. Can you check we actually get in that
case ? Normally, on the internal LCD, we should never change the PLL
registers, or only one (they should stay the same all the time after
that) and thus we should get into this case. If not (CRT), indeed, we
end up doing more accesses:

    * OUTPLLP (2), OUTPLLP (2), manual errata (1), OUTPLLP (2),
OUTPLLP (2), OUTPLLP (2), an INPLL loop (hrm...), OUTPLLP (2), another
INPLL loop, OUTPLL (1), OUTPLLP (2), OUTPLLP (2). That is 18 calls to
the errata plus the 2 INPLL loops. It would be useful to instrument
those loops and see what happens there, but I don't see why they would
have any impact unless something wrong is going on there with the PLL
locking...

   * One last call to OUTPLLP (2).

 - reset the engine, that is 3 calls to the errata

So that means that one call to raeonfb_set_par() should be in the normal
internal flat panel case about 12 calls to the errata, and in the case
where we actually write the PLL registers, about 29, plus the ones
called by the INPLL loops waiting for the PLL to lock.

As you can see, we are far below the measured counts. So I would need
more instrumentation of the driver to figure out what's going on there.

Ben.




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbUCJQZt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbUCJQZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:25:49 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:6820 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262676AbUCJQZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:25:30 -0500
Message-ID: <404F40C2.3080003@pacbell.net>
Date: Wed, 10 Mar 2004 08:22:26 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Grant Grundler <iod00d@hp.com>, Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
References: <20031028013013.GA3991@kroah.com>	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>	<3FA12A2E.4090308@pacbell.net>	<16289.29015.81760.774530@napali.hpl.hp.com>	<16289.55171.278494.17172@napali.hpl.hp.com>	<3FA28C9A.5010608@pacbell.net>	<16457.12968.365287.561596@napali.hpl.hp.com>	<404959A5.6040809@pacbell.net>	<16457.26208.980359.82768@napali.hpl.hp.com>	<4049FE57.2060809@pacbell.net>	<20040308061802.GA25960@cup.hp.com>	<16460.49761.482020.911821@napali.hpl.hp.com>	<404CEA36.2000903@pacbell.net>	<16461.35657.188807.501072@napali.hpl.hp.com>	<404E00B5.5060603@pacbell.net>	<16462.1463.686711.622754@napali.hpl.hp.com>	<404E2B98.6080901@pacbell.net> <16462.48341.393442.583311@napali.hpl.hp.com>
In-Reply-To: <16462.48341.393442.583311@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll send out a revised patch later, thanks!  It's also good
this code got a more careful read.  It seems like some things
are not as obvious as I might like...

That patch will merge those list corruption fixes I sent, the
"else" you verified was needed (ugh!!!), and some of what you
include here.   It won't add new BUG_ON calls (WARN at worst)
or a duplicate ED state (see next).


>   >>   ...  add a new state
>   >> ED_DESCHEDULED, which is treated exactly like ED_IDLE, except
>   >> that in this state, the HC may still be referring to the ED in
>   >> question.  Thus, if
> 
>   David.B> Sounds exactly like ED_UNLINK -- except maybe that it's not
>   David.B> been put onto ed_rm_list (with ED_DEQUEUE set).  Why add
>   David.B> another state?
>   ...
> 
> The current OHCI relies on the internals of the dma_pool()
> implementation.  If the implementation changed to, say, modify the
> memory that is free or, heaven forbid, return the memory to the
> kernel, you'd get _extremely_ difficult to track down race conditions.

The current implementation _does_ poison memory on free, if
slab poisoning is enabled.  (That's why I asked if you were
using it.)

And that's been quite handy for reporting list corruption bugs,
from races or otherwise. But those list corruption bugs hit a
blind spot in that code:  it doesn't check for modify-after-free.
Which is why those bugs were able to hide for so long!


It'd be good if you said _how_ you think it relies on such
internals.  Some of your debug diagnostics wrongly claimed
allocation of "new" EDs when they were just being re-used.
That'd make intentional/safe re-use look like a bug or race.


> Even so, the code isn't race-free, like I explained yesterday:
> 
>  - ed_alloc() clears the ED to 0 via memset()
>  - the order in which memset() clears memory is undefined (various
>    from platform to platform etc)

There's a wmb() before any ED is handed off to the OHCI silicon;
that forces a defined order.  Top of ed_schedule().  First use,
or Nth re-use; no matter.

>  - thus you might get a case where hwTailP is 0 but hwHeadP
>    is non-zero, which would cause the HC to happily start
>    dereferencing the descriptor

If you assume a bug where the ED is freed but still in use,
that's hardly the only thing that'd go wrong!!  You can't
use such a potential bug to prove something else is broken.

- Dave




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVALWYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVALWYz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVALWW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:22:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42258 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261526AbVALWSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:18:05 -0500
Date: Wed, 12 Jan 2005 22:17:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ian Molton <spyro@f2s.com>
Subject: Re: MMC Driver RFC
Message-ID: <20050112221753.F17131@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ian Molton <spyro@f2s.com>
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max> <20050112214345.D17131@flint.arm.linux.org.uk> <023c01c4f8f3$1d497030$0f01a8c0@max>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <023c01c4f8f3$1d497030$0f01a8c0@max>; from rpurdie@rpsys.net on Wed, Jan 12, 2005 at 10:07:26PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 10:07:26PM -0000, Richard Purdie wrote:
> Russell King:
> >> The PXA code calls mmc_detect_change() whenever an interrupt is detected.
> >> The MMC core then does a schedule_work(&host->detect). The problem is 
> >> that
> >> when the interrupt is generated, the card may not be 100% inserted or 
> >> 100%
> >> removed. Given the mechanical nature of insertions and removals, 
> >> electrical
> >> contact is possible for a while after removal has been started (and a 
> >> while
> >> before insertion is complete).
> >
> > If your socket works like that, you need to handle that by using a timer
> > yourself.  It normally only affects removal rather than insertion.
> 
> It has only shown up on removal events *so far*. I know that the interrupt 
> triggers before the card is fully seated in the slot upon insertion on this 
> device as well and I'd imagine it does so on other devices given the 
> physical design of the cards. Initalisation whilst the electrical contacts 
> are still moving can't be a wise idea even if it hasn't bitten anyone yet.

The same is true of PCMCIA cards as well.

> I'm therefore asking if there is a general case for waiting a short while 
> after any card insertion/removal event?

I believe the MMC "specification" with its power on times and minimum
number of clocks are supposed to take care of the insertion.  However,
see below.

> If not, I will just have to delay the interrupt on my hardware as you 
> suggest. (A user isn't going to notice 0.25s delay in the grand scheme of 
> things...). I suspect I'll not be the last person to have problems with
> this though.

That depends whether the hardware already provides 0.5s of debounce
already.  Some people do, some people don't.  This is why it needs to
be left to the implementation and not a core issue.

> >> 2. Card Initialisation Problems
> >
> > Different cards behave differently.  I suspect you have yet another
> > quirky card.
> 
> What is the policy on handling this? Pin the error down, then see what can 
> be done about it? I'll just have to move delays about until I find the one 
> that helps guess.
> 
> I was wondering if there was some kind of timing specification somewhere as 
> all these cards seem to work fine under other operating systems...

That's probably the official MMC specification from the MMC forum.  Us
mere open source developers don't have access to such costly specs, so
we have to make do with the specs released by card manufacturers which
do go into the protocol sufficiently deeply.

Unfortunately, such specs only cover MMC cards and not SD cards.

> >> I suspect this is related to the 1ms wait that was added to mmc_setup() 
> >> as
> >> per comments. Is there any documentation which tells us exactly what 
> >> timings
> >> we should be aiming for here? Has anyone else has problems like this?
> >
> > There isn't any 1ms wait in mmc_setup().
> 
> I was referrng to the 1ms delay in mmc_idle_cards() which is called twice by 
> mmc_setup(). There is a comment about it in mmc_setup(): "We wait 1ms to 
> give cards time to respond.". Was this just derived from experimentation?

This was added because someone was seeing a problem.  There is no
specified delay required by "specifications" I've seen to date.

> Looking at the code from hh.org, it could be (and probably has been) derived 
> from the documentation available so I can't see a patent/IP problem although 
> I understand the concern. I agree that lack of info about the formatting of 
> CID and CSD registers is an issue although the hh.org code does seem to 
> work. Is guessing what the values mean an IP/patent infringement?...

I have no idea - and that's the big problem.  We just don't know
what the situation is with SD.

Maybe now that it's more wildly known that there's SD support available
from handhelds.org, maybe (if the SD forum are reading lkml) we'll see
some reaction.  Let's just hope it's positive.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

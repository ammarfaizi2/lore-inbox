Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVJWV10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVJWV10 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 17:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVJWV10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 17:27:26 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:28282 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1750779AbVJWV10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 17:27:26 -0400
X-IronPort-AV: i="3.97,242,1125896400"; 
   d="scan'208"; a="312091753:sNHT28433768"
Date: Sun, 23 Oct 2005 16:27:18 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, minyard@acm.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] ipmi: add timer thread
Message-ID: <20051023212718.GA23212@lists.us.dell.com>
References: <20051021145835.GI19532@i2.minyard.local> <20051023134934.1b81d9c6.akpm@osdl.org> <29495f1d0510231412n41ab2d27y41f13a9c9e62b0c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d0510231412n41ab2d27y41f13a9c9e62b0c2@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2005 at 02:12:51PM -0700, Nish Aravamudan wrote:
> On 10/23/05, Andrew Morton <akpm@osdl.org> wrote:
> > The first call to schedule_timeout() here will not actually sleep at all,
> > due to it being in state TASK_RUNNING.  Is that deliberate?

Wasn't intentional, but doesn't really matter.

> > Also, this thread can exit in state TASK_INTERUPTIBLE.  That's not a bug
> > per-se, but apparently it'll spit a warning in some of the patches which
> > Ingo is working on.  I don't know why, but I'm sure there's a good reason
> > ;)
> 
> You beat me to this one, Andrew! :) Both issue can be avoided by using
> schedule_timeout_interruptible().

OK.
 
> Additionally, I think the last variable is simply being used to switch
> between a 0 and 1 jiffy sleep (took me a while to figure that out in
> GMail sadly -- any chance the variable could be renamed?). In the
> current implementaion of schedule_timeout(), these will result in the
> same behavior, expiring the timer at the next timer interrupt (the
> next jiffy increment is the first time we'll notice we had a timer in
> the past to expire). Not sure if that's the intent and perhaps just a
> means to indicate what is desired (a sleep will still occur, even
> though a udelay() has already in the loop, for instance), but wanted
> to make sure.

I think I need to move the schedule_timeout_interruptable() into the
else clause, not at the top of the loop, as that's really the only
case where I want it to sleep.  In a former version of the patch, the
SI_SM_CALL_WITH_DELAY was supposed to be a 1-jiffy delay, while the
else clause was a several-jiffy delay.  However, that lead to most
commands still taking too long to complete, hence the CALL_WITH_DELAY
case became a udelay(1).

I'll code up and test a patch that does this, and will send that ASAP.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

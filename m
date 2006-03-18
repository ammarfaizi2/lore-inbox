Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWCRT5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWCRT5c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 14:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWCRT5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 14:57:32 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:20702
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750835AbWCRT5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 14:57:32 -0500
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20060318191006.GA3939@elte.hu>
References: <20060318142827.419018000@localhost.localdomain>
	 <20060318142830.607556000@localhost.localdomain>
	 <20060318191006.GA3939@elte.hu>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 20:57:43 +0100
Message-Id: <1142711863.17279.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 20:10 +0100, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > According to the specification the timeval must be validated and an 
> > errorcode -EINVAL returned in case the timeval is not in canonical 
> > form. Before the hrtimer merge this was silently ignored by the 
> > timeval to jiffies conversion. The validation is done inside 
> > do_setitimer so all callers are catched.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ok - bad (invalid) timevals were thus randomly interpreted? I agree that 
> even though this is new behavior, it is much better to return -EINVAL 
> than to behave randomly. OTOH, since 2.6.15 and earlier did this too, is 
> there any urgency to apply this to 2.6.16?

Sorry, I explained it badly.

The negative timer values were converted to MAX_JIFFIES_PER_LONG
timeouts and intervals.

The hrtimer code expects canonical values for the start time and the
interval. The random non canonical values should not do any damage, but
the normalizing routines might loop for a while. The negative start time
will be treated as expired and negative intervals are adjusted to
resolution (jiffie) in the hrtimer_forward code.

So the behaviour is different anyway, but I prefer the clear -EINVAL to
randomness.

	tglx



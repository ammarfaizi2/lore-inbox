Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbUCGIPb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 03:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbUCGIPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 03:15:31 -0500
Received: from mx1.elte.hu ([157.181.1.137]:38092 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261780AbUCGIP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 03:15:29 -0500
Date: Sun, 7 Mar 2004 09:16:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@suse.de>, Peter Zaitsev <peter@mysql.com>,
       Andrew Morton <akpm@osdl.org>, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040307081633.GA17629@elte.hu>
References: <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143425.GA11604@elte.hu> <20040305145947.GA4922@dualathlon.random> <20040305150225.GA13237@elte.hu> <p73ad2v47ik.fsf@brahms.suse.de> <20040305162319.GA16835@elte.hu> <20040305163933.GG4922@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305163933.GG4922@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> > what do you mean by delayed?
> 
> if the timer softirq doesn't run and wall_jiffies doesn't increase, we
> won't be able to account for it, so time() will return a time in the
> past, it will potentially go backwards precisely 1/HZ seconds every
> tick that isn't executing the timer softirq. [...]

we agree that this all is not an issue, but the reasons are different 
from what you describe.

wall_jiffies (and, more importantly, xtime.tv_sec - which is the clock
source used by sys_time()) is updated from hardirq context - so softirq
delay cannot impact it.

gettimeofday() and time() are unsynchronized clocks, and time() will
almost always return a time less than the current time - due to rounding
down.

in the moments where there's a timer IRQ pending (or the timer IRQ's
time update effect is delayed eg. due to contention on xtime_lock)
gettimeofday() can estimate the current time past the timer tick, at
which moment the inaccuracy of time() can be briefly higher than 1
second. (in most cases it should be 1 second + delta)

> [...] I tend to agree for a 1sec resultion that's not a big deal
> though if you run:
> 
> 	gettimeofday()
> 	time()
> 
> gettimeofday may say the time of the day is 17:39:10 and time may tell
> 17:39:09

nobody should rely on gettimeofday() and time() being synchronized on
the second level. Typically the delta will be [0 ... 0.999999 ] seconds,
occasionally it can get larger.

and this has nothing to do with using vsyscalls and it can already
happen. xtime.tv_sec is used without any synchronization so even if
xtime were synchronized with gettimeofday() [eg. by do_gettimeofday()
noticing that xtime.tv_sec needs an update] - the access is not
serialized on SMP.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262498AbSJKPZK>; Fri, 11 Oct 2002 11:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbSJKPZK>; Fri, 11 Oct 2002 11:25:10 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:18610 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262498AbSJKPZJ> convert rfc822-to-8bit; Fri, 11 Oct 2002 11:25:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [PATCH] pooling NUMA scheduler with initial load balancing
Date: Fri, 11 Oct 2002 17:29:44 +0200
User-Agent: KMail/1.4.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200210111027.59589.efocht@ess.nec.de> <1711018324.1034322449@[10.10.2.3]>
In-Reply-To: <1711018324.1034322449@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210111729.45129.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 October 2002 16:47, Martin J. Bligh wrote:
> > Sorry, I thought the smp_tune_scheduling() call went lost during the
> > transition to the new cpu boot scheme. But it's there. And the problem
> > is indeed "notsc". So you'll have to fix it, I can't.
>
> Errrm ... not sure what you mean by this. notsc is a perfectly
> valid thing to do, so if your patch panics with that option, I
> suggest you make something conditional on notsc inside your patch?
> Works just fine without your patch, or with Michael's patch ....

Martin,

arch/i386/kernel/smpboot.c:smp_tune_scheduling() says:

       if (!cpu_khz) {
                /*
                 * this basically disables processor-affinity
                 * scheduling on SMP without a TSC.
                 */
                cacheflush_time = 0;
                return;

If you boot with notsc, you won't have cache affinity on your machine.
Which means that the load_balancer eventually selects cache hot tasks
for stealing. The O(1) scheduler doesn't do that under normal conditions!

Of course I'll add something to my patch such that it doesn't crash
if cache_decay_ticks is unset. But you might be measuring wrong things
right now if you leave cache_decay_ticks=0 as then the cache-affinity
on NUMAQ is switched off with the vanilla O(1) and with Michael's patch.
I want to say: you cannot evaluate the impact of Michael's patches if
you don't fix that. This issue is independent of my patches.

Regards,
Erich


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272289AbTG3WRP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272290AbTG3WRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:17:15 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31942
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272289AbTG3WRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:17:14 -0400
Date: Thu, 31 Jul 2003 00:17:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linas@austin.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030730221717.GB23835@dualathlon.random>
References: <20030730111639.GI23835@dualathlon.random> <Pine.LNX.4.44.0307301342260.17411-100000@localhost.localdomain> <20030730123458.GM23835@dualathlon.random> <20030730161810.B28284@forte.austin.ibm.com> <20030730220604.GA23835@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730220604.GA23835@dualathlon.random>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 12:06:04AM +0200, Andrea Arcangeli wrote:
> practice, but still we must be missing something about this code.

ah, finally I see how can the timer->lock can have made the kernel
stable again!

run_all_timers can still definitely run on x86 too if the local cpu
timer runs on top of an irq handler:

	if (in_interrupt())
		goto out_mark;
out_mark:
	mark_bh(TIMER_BH);

	init_bh(TIMER_BH, run_all_timers);

(still on ppc will be an order of magnitude less stable than on x86,
since ppc only calls run_all_timers, so you don't need two races to
trigger at the same time to crash)

ok, so my current code is the right one and it's not needed in 2.6 since
2.6 always runs inside a softirq and it never fallbacks to a
run_all_timers.

So the best fix would be to nuke the run_all_timers thing from 2.4 too.

For now I'm only going to take the risk adding the BUG_ON in mod_timer
and to keep the timer->lock everywhere to make run_all_timers safe.

Now you should only make sure that your 2.4.21 gets stable too with the
fix I applied today (and please add the BUG_ON(old_base != timer->base)
in mod_timer too so I won't be the only tester of that code ;)

In short the stack traces I described today were all right but only for
2.4, and not for 2.6.

Andrea

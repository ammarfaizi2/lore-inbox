Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272005AbTG3LTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 07:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272382AbTG3LTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 07:19:39 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14062
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272005AbTG3LTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 07:19:37 -0400
Date: Wed, 30 Jul 2003 13:22:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linas@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030730112206.GJ23835@dualathlon.random>
References: <20030730083726.GE23835@dualathlon.random> <Pine.LNX.4.44.0307301232220.13891-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307301232220.13891-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 12:34:39PM +0200, Ingo Molnar wrote:
> 
> On Wed, 30 Jul 2003, Andrea Arcangeli wrote:
> 
> > I never did any 2.6 patch, so it maybe a different thing what you've
> > seen, not what I applied to 2.4. Infact even the 2.4 patch isn't from
> > me.
> 
> the 2.4 timer-scalability patches do have a problem: due to TIMER_BH the
> actual timer expiry can happen on a different CPU, which opens up a
> del_timer()/add_timer() race in the itimer code. Your patch closes that
> hole.
> 
> But on 2.6 the timer will run precisely on the CPU it was added, so i
> think the race is not possible.

sure, the timer will run in the CPU it was added, and the setitimer will
run in a random cpu depending where the process is been rescheduled too
between the last setitimer, and the current setitimer.  (it's not the
timer moving, it's the process!)

The only way I can imagine this race not triggering in 2.6 and my old
2.4-aa, is by using cpu bindings, of course if you bind the app that
triggers the crash to a single cpu, there's no risk of triggering this.

Also note, the 2.4 code I included is different from what you mention,
I'm definitely enforcing to run the timer always and exactly in the same
cpu it was added. that's why it needs the hooks in the local timer
interrupts of x86, x86-64 and I added it a few weeks ago to ia64 too,
near the per-process accounting, and it can't run the timers from the
global timer irq anymore. Currently only IA64, AMD64 and x86 provides
the feature, other archs still fallbacks in the global timer irq and
they behave as you described, and for them the scalability is lower of
course. But on the archs where this bug triggered it was behaving 100%
like 2.6 since it was x86.

Andrea

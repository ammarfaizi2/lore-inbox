Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTEVRuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 13:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTEVRuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 13:50:01 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:21122 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262942AbTEVRtp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 13:49:45 -0400
Message-Id: <200305221802.h4MI2UZ16813@owlet.beaverton.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] signal-latency-2.5.69-A1 
In-reply-to: Your message of "Thu, 22 May 2003 10:49:23 +0200."
             <Pine.LNX.4.44.0305221042220.4330-100000@localhost.localdomain> 
Date: Thu, 22 May 2003 11:02:30 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > This has shown some good results on our testing [...]

    (do you have any numeric results?)

Sure.  We were running a web server benchmark with which we've had
latency problems with in the past.  With your patch applied, it showed
about an 8% improvement, but reliably produced the hang upon shutdown
of the benchmark.

    It's perfectly safe to _generate_ an IPI from under the runqueue
    lock. We do it in a number of cases, and did it for years. What
    precise hardware did you run this on?

This was x86 -- since we have a variety of configurations I'll have to
check back with the person who reported the problem and tested the patch
for me to get more precise info.

True, generation isn't a problem. What *could* be a problem is if we're
waiting for any kind of response or status change from a processor as a
result of that IPI (or perhaps, in this case, as a prerequisite to sending
it.)  If the message is at all bidirectional, we may have problems.

    firstly, the IPI is not sent to all processors, it's sent to a single
    target CPU. Secondly, where and why would the hang happen?

You're right, I misspoke about it going to all processors, confusing it with
the flush tlb code above it.  But it doesn't really change my premise.
I initially believed that one processor was unable to respond to the IPI
because it had blocked interrupts.  So my thought was that one process was
blocked on the runqueue lock (with interrupts disabled), while another
was blocked sending the IPI to that processor.  You've introduced some
legitimate questions about that being the problem, despite the patch
making the hang disappear.

    we do loop in one place in the x86 APIC code, apic_wait_icr_idle(). I
    believe this should never loop indefinitely, unless the hw is broken.

This is probably the premiere gray area for me now.  I don't know enough
about APICs to tell under what conditions APIC_ICR_BUSY will be true.
Is it enough that you've disabled interrupts -- will the APIC show
busy then?

    but i'd like to understand the precise reason for the hang first.

I'm all for that.

We've been unsuccessful getting much information from the hangs
themselves.  nmi_watchdog has given us a couple of stack traces but it's
always hard to tell the culprits from the victims.  We had this nasty
interaction with runqueue locks and IPIs before with the tlb flush code,
and although the evidence wasn't nearly so clear I thought it might be
worth trying the patch.  So far it has worked, but it wouldn't be the
first time new code just shifted windows around rather than closing
them completely.

Rick

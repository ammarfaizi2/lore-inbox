Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbTLOXxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 18:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTLOXxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 18:53:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:21665 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264299AbTLOXxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 18:53:51 -0500
Date: Mon, 15 Dec 2003 15:54:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: wli@holomorphy.com, kernel@kolivas.org, chris@cvine.freeserve.co.uk,
       riel@redhat.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-Id: <20031215155427.6faff1d8.akpm@osdl.org>
In-Reply-To: <20031215233746.GO6730@dualathlon.random>
References: <200311031148.40242.kernel@kolivas.org>
	<200311032113.14462.chris@cvine.freeserve.co.uk>
	<200311041355.08731.kernel@kolivas.org>
	<20031208135225.GT19856@holomorphy.com>
	<20031208194930.GA8667@k3.hellgate.ch>
	<20031208204817.GA19856@holomorphy.com>
	<20031210215235.GC11193@dualathlon.random>
	<20031210220525.GA28912@k3.hellgate.ch>
	<20031210224445.GE11193@dualathlon.random>
	<20031215153122.1d915475.akpm@osdl.org>
	<20031215233746.GO6730@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> The reason 2.4 runs faster could be a more aggressive "young" pagetable
> heuristic via the swap_out clock algorithm. as soon as one program grows
> a bit its rss, it will run for longer, and the longer it runs the more
> pages it marks "young" during a clock scan, and the more pages it marks
> young the bigger it will grow. This keeps going until it's the by far
> biggest task and takes almost all available cpu. This is optimal for
> performance, but not optimal for fariness.

Sounds right.

One thing to be cautious of here is an interaction with the "human factor".
 One tends to adjust the test case so that it takes a reasonable amount of
time.  So the process is:

Run 1: took five seconds.

       "hmm, it didn't swap at all.  I'll use some more threads"

Run 2: takes 4 hours.

       "man, that sucked.  I'll use a few less threads"

Run 3: takes ten minutes.

       "ah, that's nice.  I'll use that many threads from now on".

Problem is, you have now carefully placed your test point right on the
point of a sharp knee in a big curve.  So small changes in input conditions
cause large changes in runtime.   At least, that's what I do ;)

> So 2.6 may be better or worse
> depending if fariness payoffs or not, obviously in qsbench it doesn't
> since it's not even measured.

It would be nice, but I've yet to find a workload in which 2.6 pageout
decisively wins.

It could well be that something is simply misbehaving in there and that we
can pull back significant benefits with some inspired tweaking rather than
with radical changes.  Certainly some of Roger's measurements indicate that
this is the case, although I worry that he may have tuned himself onto the
knee of the curve.


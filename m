Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWC3L4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWC3L4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWC3L4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:56:25 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:23309 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932122AbWC3L4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:56:21 -0500
Date: Thu, 30 Mar 2006 13:55:40 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Mike Galbraith <efault@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [rfc][patch] improved interactive starvation patch against 2.6.16
Message-ID: <20060330115540.GA4914@w.ods.org>
References: <1143713997.9381.28.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143713997.9381.28.camel@homer>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 12:19:57PM +0200, Mike Galbraith wrote:
> Greetings,
> 
> The patch below alone makes virgin 2.6.16 usable in the busy apache
> server scenario, and should help quite a bit with other situations as
> well.
> 
> The original version helps a lot, but not enough, and the latency of
> being awakened in the expired array can be needlessly painful.  Ergo,
> speed up the array switch, and instead of unconditionally plunking all
> awakening tasks (including rt tasks, oops) into the expired array, check
> to see if the task has run since the last array switch first.  This
> leaves a theoretical hole for a stream of one-time waking tasks to
> starve the expired array indefinitely, but it deals with the real
> problem pretty nicely I think. 
> 
> For the one or two folks on the planet testing my anti-starvation
> patches, I've attached an incremental to my 2.6.16 test release.

Hmmm does not apply here :

willy@wtap:linux-2.6.16-sched25$ cat /data/src/tmp/sched_*|patch -Nsp1
willy@wtap:linux-2.6.16-sched25$ patch -p1 < /data/src/tmp/patch-2.6.16-sched-2.txt 
patching file kernel/sched.c
Hunk #1 succeeded at 71 with fuzz 2 (offset -6 lines).
Hunk #2 succeeded at 391 (offset 157 lines).
Hunk #3 FAILED at 833.
Hunk #4 FAILED at 2681.
Hunk #5 succeeded at 2770 (offset 149 lines).
Hunk #6 FAILED at 2806.
Hunk #7 succeeded at 2866 (offset 162 lines).
3 out of 7 hunks FAILED -- saving rejects to file kernel/sched.c.rej

However, it applies to plain 2.6.16 with sched_[1-6] applied (but with fuzz).
Parts of the patches are already applied by your previous patches (eg: chunk1).
I suspect that you accidentely rediffed sched.c against an intermediate
working tree instead.

For instance, this part is already provided by patch 4 :
@@ -77,6 +77,21 @@
 #define NS_TO_JIFFIES(TIME)    ((TIME) / (1000000000 / HZ))
 #define JIFFIES_TO_NS(TIME)    ((TIME) * (1000000000 / HZ))
 
+#if (BITS_PER_LONG < 64)
+#define JIFFIES_TO_NS64(TIME) \
 .../...

And this part overlaps with a previous chunk in patch 7 :

-                       rq->expired_timestamp = jiffies;
-               if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+                       rq->expired_timestamp = now;
+               if (!TASK_INTERACTIVE(p) || expired_starving(rq)) {

Regards,
Willy


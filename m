Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263278AbTCUGGP>; Fri, 21 Mar 2003 01:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263274AbTCUGGP>; Fri, 21 Mar 2003 01:06:15 -0500
Received: from mx1.elte.hu ([157.181.1.137]:12779 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S263278AbTCUGGO>;
	Fri, 21 Mar 2003 01:06:14 -0500
Date: Fri, 21 Mar 2003 07:16:53 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Steven Cole <elenstev@mesatop.com>, Ed Tomlinson <tomlins@cam.org>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: 2.5.65-mm2
In-Reply-To: <5.2.0.9.2.20030320194530.01985440@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0303210710490.2533-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Mar 2003, Mike Galbraith wrote:

> [...] Virgin .65 is also subject to the positive feedback loop (irman's
> process load is worst case methinks, and rounding down only ~hides it).

there's no positive feedback loop. What might happen is that in 2.5.65 we
now distribute the bonus timeslices more widely (the backboost thing), so
certain workloads might be rated more interactive. But we never give away
timeslices that were not earned the hard way (ie. via actual sleeping).

i've attached a patch that temporarily turns off the back-boost - does
that have any measurable impact? [please apply this to -mm1, i do think
the timeslice-granularity change in -mm1 (-D3) is something we really
want.]

	Ingo

--- kernel/sched.c.orig	2003-03-21 07:14:02.000000000 +0100
+++ kernel/sched.c	2003-03-21 07:15:08.000000000 +0100
@@ -365,7 +365,7 @@
 		 * tasks.
 		 */
 		if (sleep_avg > MAX_SLEEP_AVG) {
-			if (!in_interrupt()) {
+			if (0 && !in_interrupt()) {
 				sleep_avg += current->sleep_avg - MAX_SLEEP_AVG;
 				if (sleep_avg > MAX_SLEEP_AVG)
 					sleep_avg = MAX_SLEEP_AVG;


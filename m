Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUBTXuZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 18:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUBTXuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 18:50:24 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:5602 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261426AbUBTXuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 18:50:15 -0500
Message-Id: <200402202346.i1KNkfd04123@owlet.beaverton.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Andrew Morton <akpm@osdl.org>, LSE <lse-tech@lists.sourceforge.net>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Anton Blanchard <anton@samba.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.3-rc3-mm1: sched-group-power 
In-reply-to: Your message of "Fri, 20 Feb 2004 12:37:30 +1100."
             <403564DA.8040303@cyberone.com.au> 
Date: Fri, 20 Feb 2004 15:46:41 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So let me try a diagram. Each of these groups of numbers represent a
cpu_group, and the labels to the left are individual sched_domains.

SD1		     01234567
SD2-SD3		 0123        4567
SD4-SD7	       01    23    45    67
SD8-SD15      0  1  2  3  4  5  6  7

Currently, we assume each cpu has a power of 1, so each cpu group in
domains SD8-SD15 would have a power of 1, each cpu group in SD4-SD7
would have a power of 2, each of SD2 and SD3 would have a power of 4,
and collectively, all CPUs as represented in SD1 would have a power of 8.
Of course, we don't really make use of this assumption but this just
enumerates our assumption that all nodes, all cpus are created equal.

Your new power code would assign each cpu group a static power other
than this, making SMT pairs, for instance, 1.2 instead of 2.  In the
case of four siblings, 1.4 instead of 4.  Correct?  In the example above,
SD2 and SD3 would have a power rating of 2.4, and SD1 would have a power
rating of 4*1.2 or 4.8, right?

With your current code, we only consult the power ratings if we've already
decided that we are currently "balanced enough".  I'd go one step further
and say that manipulating for power only makes sense if you have an idle
processor somewhere.  If all processors are busy, then short of some
quality-of-process assessment, how can you improve power?  (You could
improve fairness, I suppose, but that would require lots more stats and
history than we have here.) If one set of procs is slower than another,
won't that make itself apparent by a longer queue developing there? (or
shorter queues forming somewhere else?) and it being load-balanced
by the existing algorithm?  Seems to me we only need to make power
decisions when we want to consider an idle processor stealing a task (a
possibly *running* task) from another processor because this processor
is faster/stronger/better.

Rick

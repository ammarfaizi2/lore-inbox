Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbUBUBjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 20:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUBUBjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 20:39:24 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:29122 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261473AbUBUBjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 20:39:11 -0500
Message-ID: <4036B6BA.60401@cyberone.com.au>
Date: Sat, 21 Feb 2004 12:39:06 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, LSE <lse-tech@lists.sourceforge.net>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Anton Blanchard <anton@samba.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.3-rc3-mm1: sched-group-power
References: <200402202346.i1KNkfd04123@owlet.beaverton.ibm.com>
In-Reply-To: <200402202346.i1KNkfd04123@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rick Lindsley wrote:

>So let me try a diagram. Each of these groups of numbers represent a
>cpu_group, and the labels to the left are individual sched_domains.
>
>SD1		     01234567
>SD2-SD3		 0123        4567
>SD4-SD7	       01    23    45    67
>SD8-SD15      0  1  2  3  4  5  6  7
>
>Currently, we assume each cpu has a power of 1, so each cpu group in
>domains SD8-SD15 would have a power of 1, each cpu group in SD4-SD7
>would have a power of 2, each of SD2 and SD3 would have a power of 4,
>and collectively, all CPUs as represented in SD1 would have a power of 8.
>Of course, we don't really make use of this assumption but this just
>enumerates our assumption that all nodes, all cpus are created equal.
>
>

Well we used to sum up the number of CPUs in each group, so it
wasn't quite that bad. We assumed all CPUs are created equal.

>Your new power code would assign each cpu group a static power other
>than this, making SMT pairs, for instance, 1.2 instead of 2.  In the
>case of four siblings, 1.4 instead of 4.  Correct?  In the example above,
>SD2 and SD3 would have a power rating of 2.4, and SD1 would have a power
>rating of 4*1.2 or 4.8, right?
>
>

Right.

>With your current code, we only consult the power ratings if we've already
>decided that we are currently "balanced enough".
>

Well we do work out the per group loads by dividing with the power
rating instead of cpus-in-the-group too.

>  I'd go one step further
>and say that manipulating for power only makes sense if you have an idle
>processor somewhere.  If all processors are busy, then short of some
>quality-of-process assessment, how can you improve power?  (You could
>improve fairness, I suppose, but that would require lots more stats and
>history than we have here.) If one set of procs is slower than another,
>won't that make itself apparent by a longer queue developing there? (or
>shorter queues forming somewhere else?) and it being load-balanced
>by the existing algorithm?  Seems to me we only need to make power
>decisions when we want to consider an idle processor stealing a task (a
>possibly *running* task) from another processor because this processor
>is faster/stronger/better.
>
>

Yeah, probably we could change that test to:
if (*imbalance <= SCHED_LOAD_SCALE / 2
            && this_load < SCHED_LOAD_SCALE)

Either way, if the calculation should be done in such a way that
if your CPUs are not idle, then it wouldn't predict a performance
increase.

No doubt there is room for improvement, but hopefully it is now
at a "good enough" stage...


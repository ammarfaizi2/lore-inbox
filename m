Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267314AbUIEWhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUIEWhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUIEWhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:37:15 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:13707 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267314AbUIEWgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:36:04 -0400
Subject: Re: [sched] fix sched_domains hotplug bootstrap ordering vs.
	cpu_online_map issue
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040905114645.GA11422@elte.hu>
References: <1094246465.1712.12.camel@mulgrave>
	<20040903145925.1e7aedd3.akpm@osdl.org>
	<20040903222212.GV3106@holomorphy.com>
	<20040903153434.15719192.akpm@osdl.org>
	<20040903224507.GX3106@holomorphy.com>  <20040905114645.GA11422@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 05 Sep 2004 18:35:16 -0400
Message-Id: <1094423718.10976.27.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-05 at 07:46, Ingo Molnar wrote:
> > cpu_online_map is not set up at the time of sched domain
> > initialization when hotplug cpu paths are used for SMP booting. At
> > this phase of bootstrapping, cpu_possible_map can be used by the
> > various architectures using cpu hotplugging for SMP bootstrap, but the
> > manipulations of cpu_online_map done on behalf of NUMA architectures,
> > done indirectly via node_to_cpumask(), can't, because cpu_online_map
> > starts depopulated and hasn't yet been populated. On true NUMA
> > architectures this is a distinct cpumask_t from cpu_online_map and so
> > the unpatched code works on NUMA; on non-NUMA architectures the
> > definition of node_to_cpumask() this way breaks and would require an
> > invasive sweeping of users of node_to_cpumask() to change it to e.g.
> > cpu_possible_map, as cpu_possible_map is not suitable for use at
> > runtime as a substitute for cpu_online_map.
> > 
> > Signed-off-by: William Irwin <wli@holomorphy.com>
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Well this patch got in, which is what I want, since it allows the
non-NUMA machines to work with hotplug CPUs again.  However, is anyone
actually looking to fix this for real?

The fundamental problem is that NUMA or the scheduler (or both) are
broken with regard to hotplug.

The origin of the breakage is the differences between cpu_possible_map
and cpu_online_map.  In hotplug CPU, there are two ways to do
initialisations: you can initialise from cpu_online_map, but then you
*must* have a cpu hotplug notify listener to add data structures for the
extra CPUs as they come on-line, or you can initialise from
cpu_possible_map and not bother with a notifier.  The disadvantage of
the latter is that cpu_possible_map may be vastly larger than
cpu_online_map ever gets to, thus wasting valuable kernel memory.

The scheduler code is schizophrenic in this regard in that it does both:
it initialises static data structures from cpu_possible_map, but it also
has a hotplug cpu listener for starting things like the migration
threads.

I suspect the NUMA people would like us all to go to the former method
(initialise only from cpu_online_map and have a proper hotplug listener)
since their possible maps are pretty huge.  However, which is it to be:
fix NUMA (to have two cpu_to_node() maps for the possible and online
cpus per node) or fix the scheduler to do initialisation correctly?

Perhaps this should be phased: change NUMA first temporarily for phase
one and then fix the scheduler (and everyone else initialising from
cpu_possible_map) in the second.

James



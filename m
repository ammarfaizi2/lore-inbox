Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbUKTIBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUKTIBN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 03:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUKTIBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 03:01:13 -0500
Received: from holomorphy.com ([207.189.100.168]:58499 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261223AbUKTIA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 03:00:58 -0500
Date: Sat, 20 Nov 2004 00:00:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, clameter@sgi.com,
       benh@kernel.crashing.org, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-ID: <20041120080049.GP2714@holomorphy.com>
References: <20041120035510.GH2714@holomorphy.com> <419EC205.5030604@yahoo.com.au> <20041120042340.GJ2714@holomorphy.com> <419EC829.4040704@yahoo.com.au> <20041120053802.GL2714@holomorphy.com> <419EDB21.3070707@yahoo.com.au> <20041120062341.GM2714@holomorphy.com> <419EE911.20205@yahoo.com.au> <20041119225701.0279f846.akpm@osdl.org> <419EEE7F.3070509@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419EEE7F.3070509@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>> Given that we have contention problems updating a single mm-wide rss and
>> given that the way to fix that up is to spread things out a bit, it seems
>> wildly arbitrary to me that the way in which we choose to spread the
>> counter out is to stick a bit of it into each task_struct.
>> I'd expect that just shoving a pointer into mm_struct which points at a
>> dynamically allocated array[NR_CPUS] of longs would suffice.  We probably
>> don't even need to spread them out on cachelines - having four or eight
>> cpus sharing the same cacheline probably isn't going to hurt much.
>> At least, that'd be my first attempt.  If it's still not good enough, try
>> something else.

On Sat, Nov 20, 2004 at 06:13:03PM +1100, Nick Piggin wrote:
> That is what Bill thought too. I guess per-cpu and per-thread rss are
> the leading candidates.
> Per thread rss has the benefits of cacheline exclusivity, and not
> causing task bloat in the common case.
> Per CPU array has better worst case /proc properties, but shares
> cachelines (or not, if using percpu_counter as you suggested).
> I think I'd better leave it to others to finish off the arguments ;)

(1) The "task bloat" is more than tolerable on the systems capable
	of having enough cpus to see significant per-process
	memory footprint, where "significant" is smaller than a
	pagetable page even for systems twice as large as now shipped.
(2) The cacheline exclusivity is not entirely gone in dense per-cpu
	arrays, it's merely "approximated" by sharing amongst small
	groups of adjacent cpus. This is fine for e.g. NUMA because
	those small groups of adjacent cpus will typically be on nearby
	nodes.
(3) The price paid to get "perfect exclusivity" instead of "approximate
	exclusivity" is unbounded tasklist_lock hold time, which takes
	boxen down outright in every known instance.

The properties are not for /proc/, they are for tasklist_lock. Every
read stops all other writes. When you hold tasklist_lock for an
extended period of time for read or write, (e.g. exhaustive tasklist
search) you stop all fork()'s and exit()'s and execve()'s on a running
system. The "worst case" analysis has nothing to do with speed. It has
everything to do with taking a box down outright, much like unplugging
power cables or dereferencing NULL. Unbounded tasklist_lock hold time
kills running boxen dead.

Read sides of rwlocks are not licenses to spin for aeons with locks held.

And the "question" of sufficiency has in fact already been answered.
SGI's own testing during the 2.4 out-of-tree patching cycle determined
that an mm-global atomic counter was already sufficient so long as the
cacheline was not shared with ->mmap_sem and the like. The "simplest"
optimization of moving the field out of the way of ->mmap_sem already
worked. The grander ones, if and *ONLY* if they don't have showstoppers
like unbounded tasklist_lock hold time or castrating workload monitoring
to unusability, will merely be more robust for future systems.
Reiterating, this is all just fine so long as they don't cause any
showstopping problems, like castrating the ability to monitor
processes, or introducing more tasklist_lock starvation.


-- wli

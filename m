Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUDBXpT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 18:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUDBXpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 18:45:19 -0500
Received: from holomorphy.com ([207.189.100.168]:29621 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261369AbUDBXpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 18:45:05 -0500
Date: Fri, 2 Apr 2004 15:44:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Antony Suter <suterant@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-as1 patchset, cks5.2, cfq, aa1, and some wli
Message-ID: <20040402234453.GU791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Antony Suter <suterant@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <1080894085.22675.0.camel@hikaru.lan> <20040402101407.GR791@holomorphy.com> <1080924208.9281.55.camel@hikaru.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080924208.9281.55.camel@hikaru.lan>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 02:43:28AM +1000, Antony Suter wrote:
> Could you add some outlines of your patches #02, #03, #18 and #28
> please?

#2 rewrote the page allocator to do deferred coalescing, which had the
additional advantage of making transfers of groups of pages to and from
the lists protected by zone->lock into expected O(1) operations. It also
exported the new functionality of O(1) batched page freeing to callers,
which was utilized by #3.

#3 implemented caching of preconstructed leaf pagetable nodes in a manner
compatible with highpte. This was supposed to conserve cache, and may
improve performance on load that repetitively fork() and exit().

#18 just micro-optimized some page allocator logic and enlarged the
batches so as to take advantage of the operations newly made O(1) by #2
which would otherwise have been expensive with large batches. It's not
actually useful without #2 in place.

#28 put all scheduling primitives into their own ELF sections,
delimited by new marker symbols, and uses those to improve
/proc/$PID/wchan reporting so that various scheduling primitives are
skipped over that aren't now, and scheduling functions don't need to
be contiguous in the text segment of the kernel. I've resubmitted this
a few more times, and it seems to be destined for mainline.


At some point in the past, I wrote:
>> altered so the parts stressing /proc/ are removed. I also had in the
>> back of my mind the notion that /proc/ performance improvements would
>> be appreciated by end users with limited cpu power to devote to the
>> monitoring of their workloads and machines' performance, which is part
>> of what motivated me to do it "the hard way" instead of modifying the
>> benchmark or replacing the userspace procps utilities with /dev/kmem
>> -diving utilities.

On Sat, Apr 03, 2004 at 02:43:28AM +1000, Antony Suter wrote:
> How important would improvements to /proc be now we have /sys ?

These were largely performance-oriented, not functionality. A rather
unfortunate aspect of that benchmark was that it effectively benchmarked
dozens or hundreds of processes doing ps(1) in parallel. End users may
find that the overhead of running top(1) is reduced by the patches meant
to speed up /proc/ for the benchmark, as many of them were single-
threaded speedups, and not just locking improvements.

The most important of the /proc/ performance patches was actually #5,
the forward port of bcrl's O(1) proc_pid_statm(). #4, the rbtree-based
get_tgid_list()/get_tid_list(), may also prove useful, and could use
some benchmarking on it as a standalone patch done.


At some point in the past, I wrote:
>> And finally, even with all this longwinded harangue, congratulations on
>> your tree. There are very definite feelings of importance and
>> satisfaction of having done service from producing releases others rely
>> upon. And these are real, as real users do benefit from what you've
>> assembled. I'm more than happy to help if you have bugreports in any
>> code I maintained or other need to call on me. And whatever precedent I
>> may have provided, you do own this, and this is your own original work.

On Sat, Apr 03, 2004 at 02:43:28AM +1000, Antony Suter wrote:
> Thanks for your kind words, and detailed notes! Again, any pointers to
> similar sorts of work would be greatly appreciated. Can you recommend
> any good tools for patch set management?

I've discovered quilt (based on akpm's patch scripts) is excellent and
am replacing my old scripts, which confused everyone but me, with it.


-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbUB0U3C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUB0U3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:29:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:36784 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263090AbUB0U25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:28:57 -0500
Date: Fri, 27 Feb 2004 12:29:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
Message-Id: <20040227122936.4c1be1fd.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com>
References: <20040227173250.GC8834@dualathlon.random>
	<Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> First, let me start with one simple request.  Whatever you do,
> please send changes upstream in small, manageable chunks so we
> can merge your improvements without destabilising the kernel.
> 
> We should avoid the kind of disaster we had around 2.4.10...

We need to understand that right now, 2.6.x is 2.7-pre.  Once 2.7 forks off
we are more at liberty to merge nasty highmem hacks which will die when 2.6
is end-of-lined.

I plan to merge the 4g split immediately after 2.7 forks.  I wouldn't be
averse to objrmap for file-backed mappings either - I agree that the search
problems which were demonstrated are unlikely to bite in real life.

But first someone would need to demonstrate that pte_chains+4g/4g are
for some reason unacceptable for some real-world setup.

Apart from the search problem, my main gripe with objrmap is that it
creates different handling for file-backed and anonymous memory.  And the
code which extends it to anonymous memory is complex and large.  One ends
up needing to seriously ask oneself what is being gained from it all.

> 
> We've heard the "no real app runs into it" argument before,
> about various other subjects.  I remember using it myself,
> too, and every single time I used the "no real apps run into
> it" argument I turned out to be wrong in the end.
> 

heh.

> I'm not particularly attached to rmap.c and won't be opposed
> to a replacement, provided that the replacement is also more
> or less modular with the VM so plugging in an even more
> improved version in the future wil be easy ;)

Sure, let's see what it looks like.  Even if it is nearly two years late.

Oh, and can we please have testcases?  It's all very well to assert "it
sucks doing X and I fixed it" but it's a lot more useful if one can
distrubute testcases as well so others can evaluate the fix and can explore
alternative solutions.

Andrea, this shmem problem is a case in point, please.

> > in small machines the current 2.4 stock algo works just fine too, it's
> > only when the lru has the million pages queued that without my new vm
> > algo you'll do million swapouts before freeing the memleak^Wcache.
> 
> Same for Arjan's O(1) VM.  For machines in the single and low
> double digit number of gigabytes of memory either would work
> similarly well ...

Case in point.  We went round the O(1) page reclaim loop a year ago and I
was never able to obtain a testcase which demonstrated the problem on 2.4,
let alone on 2.6.

I had previously found some workloads in which the 2.4 VM collapsed for
similar reasons and those were fixed with the rotate_reclaimable_page()
logic.  Without testcases we will not be able to verify that anything else
needs doing.

> ... however, if you have a hundred gigabyte of memory, or
> even more, then you cannot afford to search the inactive
> list for clean pages on swapout. It will end up using too
> much CPU time.
> 
> The FreeBSD people found this out the hard way, even on
> smaller systems...

Did they have a testcase?

> On my 128 MB desktop system everything was smooth, until
> the point where the cache was gone and the system suddenly
> faced an inactive list entirely filled with dirty pages.
> 
> Because of this, we should do some (limited) pre-cleaning
> of inactive pages. The key word here is "limited" ;)

Current 2.6 will write out nr_inactive>>DEF_PRIORITY pages, will then
throttle behind I/O and then will start reclaiming clean pages from the
tail of the LRU which were moved there at interrupt time.

> An anchor in the lru list is definately needed.

Maybe not.  Testcase, please ;)

> Lets try combining your ideas and Arjan's ideas into
> something that fixes all these problems.

Did I mention testcases?


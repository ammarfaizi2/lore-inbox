Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTDVQEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTDVQEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:04:48 -0400
Received: from franka.aracnet.com ([216.99.193.44]:65179 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263258AbTDVQEp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:04:45 -0400
Date: Tue, 22 Apr 2003 09:16:37 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@redhat.com>
cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <182180000.1051028196@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0304221127380.10400-100000@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0304221127380.10400-100000@devserv.devel.redhat.c
 om>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > to solve this problem i believe the pte chains should be made
>> > double-linked lists, and should be organized in a completely different
>> 
>> It seems ironic that the solution to space consumption is do double the
>> amount of space taken ;-) I see what you're trying to do (shove things
>> up into highmem), but it seems like a much better plan to me to just
>> kill the bloat altogether.
> 
> at the expense of introducing a quadratic component?
> 
> then at least we should have a cutoff point at which point some smarter
> algorithm kicks in.

That's a very interesting point ... a cutover like we do for AVL stuff in
other places might well work. We can make it non-quadratic for the
real-world cases fairly easily I think though (see other emails).

> am i willing to trade in 1.2% of RAM overhead vs. 0.4% of RAM overhead in
> exchange of a predictable VM? Sure. I do believe that 0.8% of RAM will

If that was the only tradeoff, I'd be happy to make it too. But it's not
0.4% / 1.2% under any kind of heavy sharing (eg shared libs), it can be
something like 25% vs 75% ... the difference between the system living or
dying. If we had shared pagetables, and shlibs aligned on 2Mb boundaries so
they could be used, I'd be much less stressed about it, I guess.

The worse part of the tradeoff is not the space, it's the overhead. And
you're pushing many workloads that didn't have to use highpte before into
having to use it (or at least highchains) - that's a significant
performance hit.

> make almost zero noticeable difference on a 768 MB system - i have a 768
> MB system. Whether 1MB of extra RAM to a 128 MB system will make more of a
> difference than a predictable VM - i dont know, it probably depends on the
> app, but i'd go for more RAM. But it will make a _hell_ of a difference on
> a 1 TB RAM 64-bit system where the sharing factor explodes. And that's
> where Linux usage we will be by the time 2.6 based systems go production.

You obviously have a somewhat different timeline in mind for 2.6 than the
rest of us ;-) However, if you're looking at the heavy sharing factor, the
current rmap stuff explodes in terms of performance. Your rmap pages sounds
like it would reduce the list walking for delete by giving us a free index
into the list (hopping across from the pagetables), but without an
implementation that can be measured, it's really impossible to tell if
you'll hit other problems.
 
> this is why i think we should have both options in the VM - even if this
> is quite an amount of complexity. And we cannot get rid of pte chains
> anyway, they are a must for anonymous mappings. The quadratic property of
> objrmap should show up very nicely for anonymous mappings: they are in
> theory just nonlinear mappings of one very large inode [swap space],
> mapped in by zillions of tasks. Has anyone ever attempted to extend the
> objrmap concept to anonymous mappings?

Yes, Hugh did that code. But my original plan was not do that that -
because there isn't enough sharing for the payback - it was no faster on my
tests at least (it made fork/exec a little faster, but there was payback in
other places). I think the partial usage is less controversial.

>> [...] The overhead for pte-highmem is horrible as it is (something like
>> 10% systime for kernel compile IIRC). [...]
> 
> i've got some very simple speedups for atomic kmaps that should mitigate
> much of the mappings overhead. And i take issue with the 10% system-time
> increase - are you sure about that? How much of total [wall-clock]
> overhead was that? I never knew this was a problem - it's easy to solve.

Dunno. I published the results a while back ... I can try to dig them out
again. I tend to look at the system time for kernel compiles (except for
scheduler stuff) ... when running real mixed workloads, the rest of the CPU
time will be more heavily used. 

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
              2.5.59-mjb5       45.63      110.69      564.75     1480.00
      2.5.59-mjb5-highpte       46.37      118.34      565.33     1473.75

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
              2.5.59-mjb5       46.69      133.99      568.99     1505.50
      2.5.59-mjb5-highpte       47.56      142.35      569.46     1496.00

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
              2.5.59-mjb5       100.0%         0.1%
      2.5.59-mjb5-highpte        97.8%         0.2%

OK, so it's more like 8% on system time, and a couple of % off wall time.
I'd love to test the atomic kmap speedups if you have them .... it's
heavily used now for all sorts of things - we ought to speed up that
mechanism as much as possible.

> well, highmem pte chains are a pain arguably, but doable.
> 
> also consider that currently rmap has the habit of not shortening the pte
> chains upon unmap time - with a double linked list that becomes possible.
>  Has anyone ever profiled the length of pte chains during a kernel
> compile?

Yes, I had some crude thing to draw a histogram (was actually the
page->count). Pretty much all the anon pages were singletons. There was
lots of sharing of shlib pages on a "number of tasks" basis ... I can't
find the figures or the patch right now, but will try to dig that out.

M.

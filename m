Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbTDVPhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbTDVPhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:37:15 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:25825 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263204AbTDVPhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 11:37:11 -0400
Date: Tue, 22 Apr 2003 11:49:05 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       <mingo@elte.hu>, <hugh@veritas.com>, <dmccr@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: objrmap and vmtruncate
In-Reply-To: <170570000.1051021741@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0304221127380.10400-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, Martin J. Bligh wrote:

> > to solve this problem i believe the pte chains should be made
> > double-linked lists, and should be organized in a completely different
> 
> It seems ironic that the solution to space consumption is do double the
> amount of space taken ;-) I see what you're trying to do (shove things
> up into highmem), but it seems like a much better plan to me to just
> kill the bloat altogether.

at the expense of introducing a quadratic component?

then at least we should have a cutoff point at which point some smarter
algorithm kicks in.

am i willing to trade in 1.2% of RAM overhead vs. 0.4% of RAM overhead in
exchange of a predictable VM? Sure. I do believe that 0.8% of RAM will
make almost zero noticeable difference on a 768 MB system - i have a 768
MB system. Whether 1MB of extra RAM to a 128 MB system will make more of a
difference than a predictable VM - i dont know, it probably depends on the
app, but i'd go for more RAM. But it will make a _hell_ of a difference on
a 1 TB RAM 64-bit system where the sharing factor explodes. And that's
where Linux usage we will be by the time 2.6 based systems go production.

this is why i think we should have both options in the VM - even if this
is quite an amount of complexity. And we cannot get rid of pte chains
anyway, they are a must for anonymous mappings. The quadratic property of
objrmap should show up very nicely for anonymous mappings: they are in
theory just nonlinear mappings of one very large inode [swap space],
mapped in by zillions of tasks. Has anyone ever attempted to extend the
objrmap concept to anonymous mappings?

> [...] The overhead for pte-highmem is horrible as it is (something like
> 10% systime for kernel compile IIRC). [...]

i've got some very simple speedups for atomic kmaps that should mitigate
much of the mappings overhead. And i take issue with the 10% system-time
increase - are you sure about that? How much of total [wall-clock]
overhead was that? I never knew this was a problem - it's easy to solve.

> [...] And this is worse - you have to manipulate the prev and next
> elements in the list. I know how to fix pte_highmem kmap overhead
> already (via UKVA), but not rmap pages. Not only is it kmap, but you
> have double the number of cachelines touched.

well, highmem pte chains are a pain arguably, but doable.

also consider that currently rmap has the habit of not shortening the pte
chains upon unmap time - with a double linked list that becomes possible.  
Has anyone ever profiled the length of pte chains during a kernel compile?

	Ingo


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289692AbSAWFg7>; Wed, 23 Jan 2002 00:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289694AbSAWFgv>; Wed, 23 Jan 2002 00:36:51 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:22096 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S289692AbSAWFgh>; Wed, 23 Jan 2002 00:36:37 -0500
Date: Wed, 23 Jan 2002 05:38:47 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
In-Reply-To: <20020123003449.F1547@athlon.random>
Message-ID: <Pine.LNX.4.21.0201230451540.1368-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Andrea Arcangeli wrote:
> 
> page->virtual will remain for all the DEFAULT serie, to avoid breaking
> the regular kmap pagecache users. But to keep a page->virtual for each
> serie we'd need a page->virtual[KM_NR_SERIES] array, which is very
> costly in terms of ram, ....

Agreed, not an option we'd want to use.

> correct. I'm convinced the mixture problem invalidates completly the
> deadlock avoidance using the series, so the only way to fix the
> deadlocks is to avoid the mixture between the series.

First half agreed, second half not sure.  Maybe no series at all.
Could it be worked with just the one serie, and count in task_struct
of kmaps "raised" by task, only task with count >=1 allowed to take
the last N kmaps?  I suspect something like that would work if not
scheduling otherwise, but no good held across allocating another
resource e.g. memory in fault.  Probably rubbish, not thought out
fully, just mentioned in case it gives you an idea.  Another such
half-baked idea I've played with a little is using one or two ptes
of the user address space (e.g. at top of stack) as per-task kmaps.

> The ordering thing is really simple I think. There are very few places
> where we kmap and kmap_pagetable at the same time. And I don't see how
> can could ever kmap before kmap_pagetable. so that part looks fine to me.

Nice if that's so, but I think you're sadly deluded ;-)
Imagine sys_read going to file_read_actor (kmap, __copy_to_user, kunmap),
imagine the __copy_to_user faulting (needs to kmap the pagetable),
imagine the place faulted is hole in ???fs file (kmap in clear_highpage),
imagine low on memory schedules all over.

There's more I want to consider in your mail, these were
just a few points I felt I could say something on quickly.

Hugh


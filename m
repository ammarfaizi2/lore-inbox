Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbSJ3EGo>; Tue, 29 Oct 2002 23:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263966AbSJ3EGo>; Tue, 29 Oct 2002 23:06:44 -0500
Received: from bozo.vmware.com ([65.113.40.131]:18191 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S263960AbSJ3EGM>; Tue, 29 Oct 2002 23:06:12 -0500
Date: Tue, 29 Oct 2002 20:13:53 -0800
From: chrisl@vmware.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       chrisl@gnuchina.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021030041353.GA1798@vmware.com>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random> <20021028195831.GC1564@vmware.com> <20021028213225.GL13972@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028213225.GL13972@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 10:32:25PM +0100, Andrea Arcangeli wrote:

> the reason it isn't easily feasible is that you can learn that the
> writepage fails way after the process isn't mapping the page anymore and

Hmm, nice to know that. When I do bigmm test, I see it kswapd call to
writepage. You are telling me at that point, bigmm is dead already?
I did not know enough about the vm system. If program did not map
this memory any more. It is ok to drop then. VMware do not care about
what is left on the ram file at all.

Thanks for you long explain.

Chris

> we can't keep unowned unwriteable dirty pages  around for long, we've to
> drop them. if the vm tried to writepage it means no one single task had
> such page mapped, so at that time of the failure we've no clue of who to
> notify for such page, all tasks just thought to have written the data
> successfully when the pte dirty bit is been trasmitted to the page dirty
> bit, by the time the page dirty bit is lost because writepage fails it's
> too late to let know the task about it, the task may be exited long ago.
> We lose track of the task when we trasmit the dirty information
> from pagetable to pte, and only after that happens we will attempt a
> writepage. So as far as I can tell the only way to fix it and to for
> example reliably send a signal to a task to notify a write is been lost,
> is to run the fs get_block(create = 1) while trasmitting the dirty bit
> from pte_t to page_t, which isn't a trivial change, certainly not
> something that would be confortable to do in 2.4 and it would affect
> performance, it is much cleaner and efficient to deal with the fs only
> at the page_t phyical pagecache layer rather than at the pte layer.
> Lefting unowned, unfreeable pages around by marking the page dirty when
> block_write_full_page fails, doesn't look a viable option, the kernel
> could do nothing but loop forever trying to write in such case.
> 
> Andrea



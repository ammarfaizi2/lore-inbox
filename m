Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261499AbSJ1V0R>; Mon, 28 Oct 2002 16:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbSJ1V0R>; Mon, 28 Oct 2002 16:26:17 -0500
Received: from [195.223.140.107] ([195.223.140.107]:39040 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261499AbSJ1V0Q>;
	Mon, 28 Oct 2002 16:26:16 -0500
Date: Mon, 28 Oct 2002 22:32:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: chrisl@vmware.com
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       chrisl@gnuchina.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021028213225.GL13972@dualathlon.random>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random> <20021028195831.GC1564@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028195831.GC1564@vmware.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 11:58:31AM -0800, chrisl@vmware.com wrote:
> Hi Andrea,
> 
> On Thu, Oct 24, 2002 at 08:33:27PM +0200, Andrea Arcangeli wrote:
> > > 
> > > That is exactly the case for vmware ram file. VMware only use it to share
> > > memory. Those are the virtual machine's memory. We don't want to write
> > > it back to disk and we don't care what is left on the file system because
> > > when vmware exit, we will throw the guest ram data away just like a real
> > > machine power off ram will lost. We are not talking about machine using
> > > flash ram :-). 
> > > 
> > > It is kswapd try to flush the data and it should take response to handle
> > > the error. If it fail, one thing it should do is keep the page dirty
> > > if write back fail. At least not corrupt memory like that.
> > > 
> > > If we can deliver the error to user program that would be a plus.
> > > But this need to be fix frist.
> > 
> > as said this cannot be fixed easily in kernel, or it would be trivial to
> > lockup a machine by filling the fs changing the i_size of a file and by
> > marking all ram in the machine dirty in the hole, the vm must be allowed
> > to discard those pages and invaliding those posted writes. At least
> > until a true solution will be available you should change vmware to
> > preallocate the file, then it will work fine because you will catch the
> > ENOSPC error during the preallocation. If you work on shmfs that will be
> > very quick indeed.
> 
> I still think throwing process's page away if write fail is bad.
> If kernel drop the data, that process is not able to run correctly
> anyway. Why not keep the page here and let oom killer to pick up the
> process to kill. In this way, we at least have some process able to run
> correctly instead of every process which hit the out of disk space has
> some bad data.

the reason it isn't easily feasible is that you can learn that the
writepage fails way after the process isn't mapping the page anymore and
we can't keep unowned unwriteable dirty pages  around for long, we've to
drop them. if the vm tried to writepage it means no one single task had
such page mapped, so at that time of the failure we've no clue of who to
notify for such page, all tasks just thought to have written the data
successfully when the pte dirty bit is been trasmitted to the page dirty
bit, by the time the page dirty bit is lost because writepage fails it's
too late to let know the task about it, the task may be exited long ago.
We lose track of the task when we trasmit the dirty information
from pagetable to pte, and only after that happens we will attempt a
writepage. So as far as I can tell the only way to fix it and to for
example reliably send a signal to a task to notify a write is been lost,
is to run the fs get_block(create = 1) while trasmitting the dirty bit
from pte_t to page_t, which isn't a trivial change, certainly not
something that would be confortable to do in 2.4 and it would affect
performance, it is much cleaner and efficient to deal with the fs only
at the page_t phyical pagecache layer rather than at the pte layer.
Lefting unowned, unfreeable pages around by marking the page dirty when
block_write_full_page fails, doesn't look a viable option, the kernel
could do nothing but loop forever trying to write in such case.

Andrea

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbTCEL7N>; Wed, 5 Mar 2003 06:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbTCEL7N>; Wed, 5 Mar 2003 06:59:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:17325 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265523AbTCEL7L>; Wed, 5 Mar 2003 06:59:11 -0500
Date: Wed, 5 Mar 2003 17:44:52 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: bcrl@redhat.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/2] Retry based aio read - filesystem read changes
Message-ID: <20030305174452.A1882@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030305144754.A1600@in.ibm.com> <20030305150026.B1627@in.ibm.com> <20030305024254.7f154afc.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030305024254.7f154afc.akpm@digeo.com>; from akpm@digeo.com on Wed, Mar 05, 2003 at 02:42:54AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 02:42:54AM -0800, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> > +extern int FASTCALL(aio_wait_on_page_bit(struct page *page, int bit_nr));
> > +static inline int aio_wait_on_page_locked(struct page *page)
> 
> Oh boy.
> 
> There are soooo many more places where we can block:

Oh yes, there are lots (I'm simply shutting my eyes 
to them till we've conquered at least a few :))

What I'm trying to do, is to look at them one at a time, 
from the ones that have the greatest potential of benefits/
improvement based on impact and complexity.

Otherwise it'd be just too hard to get anywhere !

Actually that was one reason why I decided to post
this early. Want to catch the most important ones
and make sure we can deal with them at least.

Read is the easier case, which is why I started with
it. Will come back to write case sometime later after
I've played with a bit.

Even with read there is one more case besides your
list. The copy_to_user or fault_in_writable_pages can 
block too ;)  (that's what I'm running into) ..

However, the general idea is that any point of blocking 
where it is possible for things to just work if we return 
instead of waiting, and issue a retry that would
continue from the point where it left off, can be
handled within the basic framework. What we need to do
is to look at these on a case by case basis and see
if that is doable. My hunch is that for congestion and
throttling points it should be possible. And we already
have a lot of pipelining and restartability built
into the VFS now.  

Mostly we just need to be able to make sure the 
-EIOCBQUEUED returns can be propagated all the way up,
without breaking anything.

Its really the meta-data related waits that are a
black box for me, and wasn't planning on tackling yet ... 
More so as I guess it could mean getting into very 
filesystem specific territory so doing it consistently
may not be that easy.


> 
> - write() -> down(&inode->i_sem)
> 
> - read()/write() -> read indirect block -> wait_on_buffer()
> 
> - read()/write() -> read bitmap block -> wait_on_buffer()
> 
> - write() -> allocate block -> mark_buffer_dirty() ->
> 	balance_dirty_pages() -> writer throttling
> 
> - write() -> allocate block -> journal_get_write_access()
> 
> - read()/write() -> update_a/b/ctime() -> journal_get_write_access()
> 
> - ditto for other journalling filesystems
> 
> - read()/write() -> anything -> get_request_wait()
>   (This one can be avoided by polling the backing_dev_info congestion
>    flags)

I was thinking of a get_request_async_wait() that unplugs
the queue, and returns -EIOCBQUEUED after queueing the 
async waiter to just retry the operation. 

Of course this would work if the caller is able to push 
back -EIOCBQUEUED without breaking anything in a 
non-startable way.

> 
> - read()/write() -> page allocator -> blk_congestion_wait()
> 
> - write() -> balance_dirty_pages() -> writer throttling
> 
> - probably others.
>  
> Now, I assume that what you're looking for here is an 80% solution, but it
> seems that a lot more changes will be needed to get even that far.

If we don't bother about meta-data and indirect blocks 
just yet, wouldn't the gains we get otherwise not be
worth it ?

> 
> And given that a single kernel thread per spindle can easily keep that
> spindle saturated all the time, one does wonder "why try to do it this way at
> all"?

Need some more explanation on how/where you really break up
a generic_file_aio_read operation (with the page_cache_read, 
readpage, copy_to_user) on a per-spindle basis. Aren't we at
a higher level of abstraction compared to disk at this stage ?
I can visualize delegating all readpage calls to a worker
thread per-backing device or something like that (forgetting
LVM/RAID for a while), but what about the rest of the parts ?

Are you suggesting restructuring the generic_file_aio_read
code to separate out these stages, so it can identify where
it is and handoff itself accordingly to the right worker ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India


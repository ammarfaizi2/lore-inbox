Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVBUWXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVBUWXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 17:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVBUWXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 17:23:51 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:62089 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262093AbVBUWXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 17:23:46 -0500
Message-ID: <421A607B.4050606@sgi.com>
Date: Mon, 21 Feb 2005 16:28:11 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Martin Hicks <mort@wildopensource.com>, pj@sgi.com,
       linux-kernel@vger.kernel.org, Martin Hilgeman <hilgeman@sgi.com>
Subject: Re: [PATCH/RFC] A method for clearing out page cache
References: <20050214154431.GS26705@localhost>	<20050214193704.00d47c9f.pj@sgi.com>	<20050221192721.GB26705@localhost> <20050221134220.2f5911c9.akpm@osdl.org>
In-Reply-To: <20050221134220.2f5911c9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Martin Hicks <mort@wildopensource.com> wrote:
> 
>>This patch introduces a new sysctl for NUMA systems that tries to drop
>> as much of the page cache as possible from a set of nodes.  The
>> motivation for this patch is for setting up High Performance Computing
>> jobs, where initial memory placement is very important to overall
>> performance.
> 
> 
> - Using a write to /proc for this seems a bit hacky.  Why not simply add
>   a new system call for it?
> 

We did it this way because it was easier to get it into SLES9 that way.
But there is no particular reason that we couldn't use a system call.
It's just that we figured adding system calls is hard.

> - Starting a kernel thread for each node might be overkill.  Yes, it
>   would take longer if one process was to do all the work, but does this
>   operation need to be very fast?
>

It is possible that this call might need to be executed at the start of
each batch job in the system.  The reason for using a kernel thread was
that there was no good way to start concurrency due to a write to /proc.

>   If it does, then userspace could arrange for that concurrency by
>   starting a number of processes to perform the toss, each with a different
>   nodemask.
> 

That works fine as well if we can get a system call number assigned and
avoids the hackiness of both /proc and the kernel threads.

> - Dropping "as much pagecache as possible" might be a bit crude.  I
>   wonder if we should pass in some additional parameter which specifies how
>   much of the node's pagecache should be removed.
> 
>   Or, better, specify how much free memory we will actually require on
>   this node.  The syscall terminates when it determines that enough
>   pagecache has been removed.

Our thoughts exactly.  This is clearly a "big hammer" and we want to
make a lighter hammer to free up a certain number of pages.  Indeed,
we would like to have these calls occur automatically from __alloc_pages()
when we try to allocate local storage and find that there isn't any.
For our workloads, we want to free up unmapped, clean pagecache, if that
is what is keeping us from allocating a local page.  Not all workloads
want that, however, so we would probably use a sysctl() to enable/disable
this.

However, the first step is to do this manually from user space.

> 
> - To make the syscall more general, we should be able to reclaim mapped
>   pagecache and anonymous memory as well.
> 
> 
> So what it comes down to is
> 
> sys_free_node_memory(long node_id, long pages_to_make_free, long what_to_free)
> 
> where `what_to_free' consists of a bunch of bitflags (unmapped pagecache,
> mapped pagecache, anonymous memory, slab, ...).

Do we have to implement all of those or just allow for the possibility of that
being implemented in the future?  E. g. in our case we'd just implement the
bit that says "unmapped pagecache".

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

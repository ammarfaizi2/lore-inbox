Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266883AbUIEQd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266883AbUIEQd5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 12:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUIEQd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 12:33:57 -0400
Received: from holomorphy.com ([207.189.100.168]:42386 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266883AbUIEQdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 12:33:53 -0400
Date: Sun, 5 Sep 2004 09:33:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrey Savochkin <saw@saw.sw.com.sg>, linux-kernel@vger.kernel.org
Subject: Re: Q about pagecache data never written to disk
Message-ID: <20040905163344.GC3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Andrey Savochkin <saw@saw.sw.com.sg>,
	linux-kernel@vger.kernel.org
References: <20040905120147.A9202@castle.nmd.msu.ru> <20040905035233.6a6b5823.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040905035233.6a6b5823.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin <saw@saw.sw.com.sg> wrote:
>> Let's suppose an mmap'ed (SHARED, RW) file has a hole.
>> AFAICS, we allow to dirty the file pages without allocating the
>> space for the hole - filemap_nopage just "reads" the page filling it
>> with zeroes, and nothing is done about the on-disk data until
>> writepage. So, if the page can't be written to disk (no space), the
>> dirty data just stays in the pagecache.  The data can be read or
>> seen via mmap, but it isn't and never be on disk.  The pagecache
>> stays unsynchronized with the on-disk content forever.

On Sun, Sep 05, 2004 at 03:52:33AM -0700, Andrew Morton wrote:
> The kernel will make one attampt to write the data to disk.  If that write
> hits ENOSPC, the page is not redirtied (ie: the data can be lost).
> When that write hits ENOSPC an error flag is set in the address_space and
> that will be returned from a subsequent msync().  The application will then
> need to do something about it.
> If your application doesn't msync() the memory then it doesn't care about
> its data anyway.  If your application _does_ msync the pages then we
> reliably report errors.

msync(p, sz, MS_ASYNC) only does set_page_dirty() at the moment and
returns 0 unconditionally AFAICT, so things are stuck blocking and
waiting for disk to reap the status of the IO at all. Maybe if that
worked the fault handling wouldn't be as important. Maybe we should be
reaping AS_EIO and/or AS_ENOSPC in the MS_ASYNC case, or wherever it is
we stash the fact those IO errors ever happened. I'm also not sure what
people think would be the right way to kick off IO in the background
there, as trying to kmalloc() a workqueue element, then doing
schedule_work() on it has resource management issues, but forcing
userspace to block on the IO to ensure it's been initiated at all
defeats the point of it.


Andrey Savochkin <saw@saw.sw.com.sg> wrote:
>> Is it the intended behavior?
>> Shouldn't we call the filesystem to fill the hole at the moment of
>> the first write access?

On Sun, Sep 05, 2004 at 03:52:33AM -0700, Andrew Morton wrote:
> That would be a retrograde step - it would be nice to move in the other
> direction: perform disk allocation at writeback time rather than at write()
> time, even for regular write() data.  To do that we (probably) need space
> reservation APIs.  And yes, we perhaps could reserve space in the
> filesystem when that page is first written to.
> But then what would we do if there's no space?  SIGBUS?  SIGSEGV? 
> Inappropriate.  SIGENOSPC?

I believe SIGBUS is conventional, though you seem to be leaning toward
solutions outside the fault path. I presume the "You're screwed without
msync(2)" bit is standards-conformant.


-- wli

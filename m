Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWBJIAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWBJIAQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 03:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWBJIAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 03:00:15 -0500
Received: from science.horizon.com ([192.35.100.1]:26441 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751178AbWBJIAO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 03:00:14 -0500
Date: 10 Feb 2006 03:00:13 -0500
Message-ID: <20060210080013.6572.qmail@science.horizon.com>
From: linux@horizon.com
To: akpm@osdl.org, nickpiggin@yahoo.com.au
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Cc: linux-kernel@vger.kernel.org, linux@horizon.com, sct@redhat.com,
       torvalds@osdl.org
In-Reply-To: <20060209224656.7533ce2b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> But the main function of msync(MS_ASYNC) AFAIK is to *start* IO.
>> Why do we care so much if some application goes stupid with it?
>
> Because delaying the writeback to permit combining is a good optimisation.

In *some* cases.  The application may very well know that there won't
be any following writes to combine with.

> The alternative of not starting new writeout of a dirty page if that page
> happens to be under writeout at the time is neither one nor the other. 

It's a sub-optimal kludge, but it's something.  As everyone is perfectly
aware, msync(MS_ASYNC) is *only* a performanc optimization; you cannot
rely on it for correctness because the time to do the write is not
bounded.  So if the OS screws up occasionally, not a disaster.

So Linux has a limitation that it can't start a second write on a
particular page that's already being written.  (It seems like a simple
flag, tested on completion of the first writeback, would solve that
problem.)

But msync() means nothing unless people are writing to a file, and
concurrent writers have to cooperate anyway, so I don't see this as
being a big problem in practice.  MS_ASYNC is a performace optimization,
so it only has to work most of the time.

Thus, this is a perfectly acceptable solution.

For example, my application only calls msync(MS_ASYNC) on a particular
page once, ever, as soon as it knows there will be no more writes to
that page.  Thus, the problem would never occur.  It might be nice to
extend Linux to cope gracefully with the case where I start the write
when I'm 99% sure there will be no more data (but just might be wrong),
but I don't think that's done too commonly.

>> Why not introduce a linux specific MS_flag to propogate pte dirty
>> bits?

> That's what MS_ASYNC already does.

Yes, in violation of the SuS spec.  That's what msync(0) already does,
too, so the linux-specific extension already exists.

The standard description of MS_INVALIDATE is very confusing and poorly
worded, but I think it's designed for a model where mmap() copies rather
than playing page table tricks, and the OS has to copy the dirty pages
back and forth between the buffer cache "by hand".  Looked at that way,
the MS_INVALIDATE wording seems to be intended as something of a "commit
memory writes back to the file system level" operation.

Which could also be expected to cause the traditional 30-second sync
timeout to start applying to the written data.  In the current Linux
code, the only effect of MS_INVALIDATE over msync(0) is an extra 
validity check that I'm not clear on the purpose of.

> Another point here is that msync(MS_SYNC) starts writeout of _all_ dirty
> pages in the file (as MS_ASYNC used to do) and it waits upon writeback of
> the whole file.  That's quite inefficient for an app which has lots of
> threads writing to and msync()ing the same MAP_SHARED file.

Ick.

> We could easily enough convert msync() to only operate on the affected
> region of the (non-linearly-mapped) file.  But I don't think we can do that
> now, because people might be relying upon the side-effects.

Um, they shouldn't be.  It certainly hasn't been documented.  If someone
wants that, they can use fdatasync().  Do you have any reason to believe
that there exist applications that rely on such non-portable behaviour
for correctness?  I'd think someone writing such careful code would
carefully follow the guarantees.

> The fadvise() extensions allow us to fix this.  And we've needed them for
> some time for regular write()s anyway.  

I'm not objecting to them, just to the fact that they're non-portable
extensions needed to make the portable system calls behave in the
standard-defined way.

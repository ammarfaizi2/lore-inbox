Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262081AbRFFIFt>; Wed, 6 Jun 2001 04:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263488AbRFFIFi>; Wed, 6 Jun 2001 04:05:38 -0400
Received: from bart.one-2-one.net ([195.94.80.12]:55045 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S262081AbRFFIF0>; Wed, 6 Jun 2001 04:05:26 -0400
Date: Wed, 6 Jun 2001 10:07:03 +0200 (CEST)
From: Martin Diehl <home@mdiehl.de>
To: Pete Wyckoff <pw@osc.edu>
cc: Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org
Subject: Re: forcibly unmap pages in driver?
In-Reply-To: <20010605182120.F23799@osc.edu>
Message-ID: <Pine.LNX.4.21.0106060103280.29584-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001, Pete Wyckoff wrote:

> dmaas@dcine.com said:
> > user-space program is still running. I need to remove the user-space
> > mapping -- otherwise the user process would still have access to the
> > now-freed pages. I need an inverse of remap_page_range().
> 
> That seems a bit perverse.  How will the poor userspace program know
> not to access the pages you have yanked away from it?  If you plan
> to kill it, better to do that directly.  If you plan to signal it
> that the mapping is gone, it can just call munmap() itself.

I can very well imagine situations where you want to unmap a buffer 
beneath the userspace program to make it dying when not following the
rules - see below.

> However, do_munmap() will call zap_page_range() for you and take care of
> cache and TLB flushing if you're going to do this in the kernel.
> 
> Your driver mmap function is called by do_mmap_pgoff() which takes
> care of those issues, and there is no (*munmap) in file_operations---
> perhaps you are the first driver writer to want to unmap in the kernel.

Well, I don't know whether he is the first one, but if so, I'm probably
the other one thinking about (temporarily) unmapping mmap(2)ed memory
directly on behalf of the kernel. The idea is as follows:

Let's assume the mmap'ed buffer should be either accessible by userland
or (mutually exclusive) dedicated to I/O or DMA. So you need some
synchronisation like userland calling ioctl(2) to release the buffer and
blocks on select(2) or read(2) to get buffer access re-granted after DMA
has finished. Let's further assume you want to make absolutely sure the
userland app would really _never_, under no circumstance, access the
buffer at the wrong moment where it would read corrupted data, i.e. after
the ioctl() but before the file gets ready for nonblocking read again.

Well, you could validate all the paths in the app that might access the
mmap'ed buffer at some point and make sure this is either impossible or
will be detected somehow. Furthermore, for any future change you have to
do some re-validation... --- or, you simply make the mapping inaccessible
inside the critical window so the application would immediately die if it
would violate the rule. Note that it is not sufficient to require the app
to do the unmap itself after calling ioctl() because this would not solve
the problem - so you pay two syscalls for nothing.

I believe this is a good reason to do the unmap in the drivers'
ioctl() and remap again after DMA has finished. Basically, one could also
temporarily switch to PROT_NONE to get the same behaviour, but I
personally prefer unmapping due to more flexibility.

Although not tested so far, I think it should be possible by simply
calling do_munmap(), which is exported by mm/mmap.c. AFAICS the only thing
to take care of is the correct handling of mm->mmap_sem. Question remains
however, whether there is any reason not to do so, wrt. future changes
for example.

Regards
Martin


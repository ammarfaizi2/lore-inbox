Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSHJIzc>; Sat, 10 Aug 2002 04:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSHJIzc>; Sat, 10 Aug 2002 04:55:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15112 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316683AbSHJIzb>;
	Sat, 10 Aug 2002 04:55:31 -0400
Message-ID: <3D54D82B.87A4E1A9@zip.com.au>
Date: Sat, 10 Aug 2002 02:08:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <3D54AED6.708F247F@zip.com.au> <Pine.LNX.4.44.0208100005070.1474-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 9 Aug 2002, Andrew Morton wrote:
> >
> > What would be nice is a way of formalising the prefault, to pin
> > the mm's pages across the copy_*_user() in some manner, perhaps?
> 
> Too easy to create a DoS-type attack with any trivial implementation.

hmm, yes.  The pin has to be held across ->prepare_write.  That
tears it.

> However, I don't think pinning is worthwhile, since even if the page goes
> away, the prefaulting was just a performance optimization. The code should
> work fine without it. In fact, it would probably be good to _not_ prefault
> for a development kernel, and verify that the code works without it. That
> way we can sleep safe in the knowledge that there isn't some race through
> code that requires the prefaulting..

OK.  That covers reads.  But we need to do something short-term to get
these large performance benefits, and I don't know how to properly fix
the write deadlock.  The choices here are:

- live with the current __get_user thing

- make filemap_nopage aware of the problem, via a new `struct page *'
  in task_struct (this would be very messy on the reader side).

- or?

(Of course, the write deadlock is a different and longstanding
problem, and I don't _have_ to fix it here, weasel, weasel)

> I agree that if you could guarantee pinning the out-of-line code would be
> a bit simpler, but since we have to handle the EFAULT case anyway, I doubt
> that it is _that_ much simpler.
> 
> Also, there are actually advantages to doing it the "hard" way. If we ever
> want to, we can actually play clever tricks that avoid doing the copy at
> all with the slow path.
> 
> Example tricks: we can, if we want to, do a read() with no copy for a
> common case by adding a COW-bit to the page cache, and if you do aligned
> reads into a page that will fault on write, you can just map in the page
> cache page directly, mark it COW in the page cache (assuming the page
> count tells us we're the only user, of course), and mark it COW in the
> mapping.

glibc malloc currently returns well-aligned-address + 8.  If
it were taught to return well-aligned-address+0 then presumably a
lot of applications would automatically benefit from these
zero-copy reads.

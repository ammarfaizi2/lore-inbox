Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318734AbSHBHR3>; Fri, 2 Aug 2002 03:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318741AbSHBHR3>; Fri, 2 Aug 2002 03:17:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64785 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318734AbSHBHR2>;
	Fri, 2 Aug 2002 03:17:28 -0400
Message-ID: <3D4A3500.F65887D@zip.com.au>
Date: Fri, 02 Aug 2002 00:30:08 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: large page patch
References: <20020801.211357.93822733.davem@redhat.com> <Pine.LNX.4.33.0208012128110.1857-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 1 Aug 2002, David S. Miller wrote:
> >
> >    Of course, if you can actually measure it, that would be
> >    interesting.  Naive math gives you a guess for the order of
> >    magnitude effect, but nothing beats real numbers ;)
> >
> > The SYSV folks actually did have a buddy allocator a long time ago and
> > they did implement lazy coalescing because is supposedly improved
> > performance.
> 
> I bet that is mainly because of CPU scalability, and being able to avoid
> touching the buddy lists from multiple CPU's - the same reason _we_ have
> the per-CPU front-ends on various allocators.
> 
> I doubt it is because buddy matters past the 4MB mark. I just can't see
> how you can avoid the naive math which says that it should be 1/512th as
> common to coalesce to 4MB as it is to coalesce to 8kB.

Buddy costs tend to be down in the noise compared with the cost
of the zone->lock.

I did a per-cpu pages patch a while back which, when it takes that
lock, grabs 16 pages or frees 16 pages.  Anton tested it on the
12-way:  http://samba.org/~anton/linux/2.5.9/  blue -> purple

The cost of rmqueue() and __free_pages_ok went from 13% of system
time down to 2%.  So that 2% speedup is all that's available by fiddling
with the buddy algorithm (I think).  And I bet most of that is still taking
the lock.

Didn't submit the patch because I think a per-cpu page buffer is a bit of
a dopey cop-out.  I have patches here which make most of the page-intensive
fastpaths in the kernel stop using single pages and start using 16-page batches.

That will make a 16-page allocation request just a natural thing
to do.  But we will need a per-cpu buffer to wring the last drops
out of anonymous pagefaults and generic_file_write(), which do not
lend themselves to gang allocation.

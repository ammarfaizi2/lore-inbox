Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSFNXCZ>; Fri, 14 Jun 2002 19:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSFNXCZ>; Fri, 14 Jun 2002 19:02:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15881 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312254AbSFNXCX>;
	Fri, 14 Jun 2002 19:02:23 -0400
Message-ID: <3D0A75A4.AB34AC59@zip.com.au>
Date: Fri, 14 Jun 2002 16:00:52 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO 
 simplification
In-Reply-To: <200206141652.JAA26744@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
>         That would be pretty nice too, but that lacks three potential
> advantages of my bio_chain appoach, in order of importance:
> 
>                 1. bio_chain is avoids memory allocation failures,
>                 2. bio_chain can start the first IO slightly sooner,
>                 3. bio_chain makes bio submitters slightly simpler.
> 
>         The disadvantage of my single I/O vector bio_chain apprach is
> that it results in another procedure call per vector.  We also already
> have code that builds multiple IO vectors in ll_rw_kio and the mpage.c
> routines.
> 
> ...

I have not yet seen a BIO allocation failure in testing.  This
would indicate that either the BIO pool is too large, or I'm 
running the wrong tests.  Either way, I don't think we have
demonstrated any otherwise-unsolvable problems with BIO allocation.

What bugs me about your approach is this:  I have been gradually
nudging the kernel's IO paths away from enormously-long per-page
call paths and per-page locking into the direction of a sequence
of short little loops, each of which does the same stuff against
a bunch of pages.

This is by no means finished.  Ultimately, I want to go into the
page allocator and snip off 16 pages in a single acquisition of
the zone lock.  Put these into the pagecache in a single acquisition
of the mapping lock.  Add them to the LRU with a single acquisition
of the pagemap_lru_lock.  Slot them all into a single BIO and send
them all off with a single submit_bio().  So the common-case unit of I/O
in the kernel will not be a page - it will be a great chunk of pages.

Everything is pretty much in place to do this now.  The main piece
which is missing is the gang page allocator (Hi, Bill).

It'll be damn fast, and nicely scalable.  It's all about reducing the
L1 cache footprint.  Making best use of data when it is in cache.
Making best use of locks once they have been acquired.  If it is
done right, it'll be almost as fast as 64k PAGE_CACHE_SIZE, with
none of its disadvantages.

In this context, bio_chain() is regression, because we're back
into doing stuff once-per-page, and longer per-page call graphs.
I'd rather not have to do it if it can be avoided.

-

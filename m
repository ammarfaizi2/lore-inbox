Return-Path: <linux-kernel-owner+w=401wt.eu-S932766AbWLZT1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbWLZT1l (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 14:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbWLZT1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 14:27:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52633 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932766AbWLZT1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 14:27:40 -0500
Date: Tue, 26 Dec 2006 11:26:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrei Popa <andrei.popa@i-neo.ro>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Martin Michlmayr <tbm@cyrius.com>, Hugh Dickins <hugh@veritas.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <4590F9E5.4060300@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0612261007100.3671@woody.osdl.org>
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> 
 <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com> 
 <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org> 
 <20061222100004.GC10273@deprecation.cyrius.com>  <20061222021714.6a83fcac.akpm@osdl.org>
 <1166790275.6983.4.camel@localhost>  <20061222123249.GG13727@deprecation.cyrius.com>
  <20061222125920.GA16763@deprecation.cyrius.com>  <1166793952.32117.29.camel@twins>
  <20061222192027.GJ4229@deprecation.cyrius.com> 
 <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com> 
 <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>  <20061224005752.937493c8.akpm@osdl.org>
 <1166962478.7442.0.camel@localhost>  <20061224043102.d152e5b4.akpm@osdl.org>
 <1166978752.7022.1.camel@localhost> <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
 <Pine.LNX.4.64.0612241029460.3671@woody.osdl.org>
 <Pine.LNX.4.64.0612241115130.3671@woody.osdl.org> <4590F9E5.4060300@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Dec 2006, Nick Piggin wrote:

> Linus Torvalds wrote:
> > 
> > Ok, so how about this diff.
> > 
> > I'm actually feeling good about this one. It really looks like
> > "do_no_page()" was simply buggy, and that this explains everything.
> 
> Still trying to catch up here, so I'm not going to reply to any old
> stuff and just start at the tip of the thread... Other than to say
> that I really like cancel_page_dirty ;)

Yeah, I think that part is a bit clearer about what's going on now.

> I think your patch is quite right so that's a good catch.

Actually, since people told me it didn't matter, I went back and looked at 
_why_ - the thing is, "vma->vm_page_prot" should always be read-only 
anyway, except for mappings that don't do dirty accounting at all, so I 
think my patch only found cases that are unimportant (ie pages that get 
faulted on on filesystems like ramfs that doesn't do any dirty page 
accounting because they're all dirty anyway).

> But I'm not too surprised that it does not help the problem, because I 
> don't think we have started shedding any old pte_dirty tests at 
> unmap/reclaim-time, have we? So the dirty bit isn't going to get lost, 
> as such.

True. We should no longer _need_ those dirty bit reclaims at 
unmap/reclaim, but we still do them, so you're right, even if we were 
buggy in this area, it should only really matter for the dirty page 
counting, not for any lost data.

> I was hoping that you've almost narrowed it down to the filesystem
> writeback code, with the last few mails?

I think so, yes.

However, I've checked, and "rtorrent" really does seem to be fairly 
well-behaved wrt any filesystem activity. It does

 - no threading. It's 100% single-threaded, and doesn't even appear to use 
   signals.

 - exactly _one_ "ftruncate()", and it does it at the beginning, for the 
   full final size.

   IOW, it's not anything subtle with truncate and dirty page cancel.

 - It never uses mprotect on the shared mappings, but it _does_ do:
	"mincore()" - but the return values don't much matter (it's used 
	              as a heuristic on which parts to hash, apparently)

		      I double- and triple-checked this one, because I
		      did make changes to "mincore()", but those didn't go 
		      into the affected kernels anyway (ie they are not in 
		      plain 2.6.19, nor in 2.6.18.3 either)

	"madvise(MADV_WILLNEED)"
	"msync(MS_ASYNC)" (or MS_SYNC if you use a command line flag)
	"munmap()" of course

 - it never seems to mix mmap() and write() - it does _only_ mmap.

 - it seems to mmap/munmap the shared files in nice 64-page chunks, all 
   64-page aligned in the file (ie it does NOT create one big mapping, it 
   has some kind of LRU of thse 64-page chunks). The only exception being 
   the last chunk, which it maps byte-accurate to the size.

 - I haven't checked whether it only ever has the same chunk mapped once 
   at a time.

Anyway, the _one_ half-way interesting thing is the fact that it doesn't 
allocate any backing store at all for the file, and as such the page 
writeback needs to create all the underlying buffers on the filesystem. I 
really don't see why that would be a problem either, but I could imagine 
that if we have some writeback bug where we can end up writing back the 
_same_ page concurrently, we'd actually end up racing in the kernel, and 
allocating two different backing stores, and then maybe the other one 
would effectively "get lost" (and the earlier writeback would win the 
race, explaining why we'd end up with zeroes at the end of a block).

Or something.

However, all the codepaths _seem_ to test for PG_writeback, and not even 
try to start another writeback while the first one is still active.

What would also actually be interesting is whether somebody can reproduce 
this on Reiserfs, for example. I _think_ all the reports I've seen are on 
ext2 or ext3, and if this is somehow writeback-related, it could be some 
bug that is just shared between the two by virtue of them still having a 
lot of stuff in common. 

			Linus

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281116AbRLDQ6z>; Tue, 4 Dec 2001 11:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278932AbRLDQ5b>; Tue, 4 Dec 2001 11:57:31 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14360 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281153AbRLDQ5H>; Tue, 4 Dec 2001 11:57:07 -0500
Date: Tue, 4 Dec 2001 17:48:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Zaitsev <pz@spylog.ru>
Cc: Andrew Morton <akpm@zip.com.au>, theowl@freemail.c3.hu, theowl@freemail.hu,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: your mail on mmap() to the kernel list
Message-ID: <20011204174824.D3447@athlon.random>
In-Reply-To: <3C082244.8587.80EF082@localhost>, <3C082244.8587.80EF082@localhost> <61437219298.20011201113130@spylog.ru> <3C08A4BD.1F737E36@zip.com.au> <20011204151549.U3447@athlon.random> <16498470022.20011204183624@spylog.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <16498470022.20011204183624@spylog.ru>; from pz@spylog.ru on Tue, Dec 04, 2001 at 06:36:24PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 06:36:24PM +0300, Peter Zaitsev wrote:
> Hello Andrea,
> 
> Tuesday, December 04, 2001, 5:15:49 PM, you wrote:
> 
> 
> AA> the vma lookup overhead is nothing compared to the walking of the linked
> AA> list (not of the tree) to find the first available slot above
> AA> TASK_UNMAPPED_BASE. In the vma lookup engine rewrite I only cared about
> AA> find_vma, not about optimizing the search of a free vma over
> AA> TASK_UNMAPPED_BASE.  Such list-loop is really evil.
> Sure.
> 
> >> What appears to be happening is that the VMA tree has degenerated
> >> into a monstrous singly linked list.  All those little 4k mappings
> 
> AA> actually it's not that the tree degenerated into a list. It's that we
> AA> need to walk all the vma to check if there is a large enough hole to
> AA> place the new dynamic mapping and so walk we use the list, not the tree,
> AA> because it needs less mem resources and it's simpler and faster.
> 
> AA> You can fix the problem in userspace by using a meaningful 'addr' as
> AA> hint to mmap(2), or by using MAP_FIXED from userspace, then the kernel
> AA> won't waste time searching the first available mapping over
> AA> TASK_UNMAPPED_BASE.
> Well. Really you can't do this, because you can not really track all of

I can do this sometime, I did it in the patch I posted for example. If
you want transparency and genericity you can still do it in userspace
with an LD_LIBRARY_PATH that loads a libc that builds the hole-lookup
data structure (tree?) internally, and then passes the hint to the
kernel if the program suggests 0.

OTOH I prefer those kind of algorithms (if needed) to be in the kernel
so they're faster/cleaner and also a lib would need some magic knowledge
about kernel internals virtual addresses to do it right.

> >> The reason you don't see it with an anonymous map is, I think, that
> >> the kernel will merge contiguous anon mappings into a single one,
> 
> AA> Yes. But actually merging also file backed vmas would be a goodness
> AA> indipendently of the arch_get_unmapped_area loop. It's not possible
> AA> right now because the anonymous memory case it's much simpler: no
> AA> i_shared_locks etc... but I'd like if in the long run also the file
> AA> backed vma will be mergeable. The side effect of the goodness is that
> AA> also the loop would run faster of course.
> Do you think it's the big chance the two close mappings will belong to the
> different parts of one file. I think this should be true only for some
> specific workloads.
> AA>  But technically to really kill
> AA> the evil complexity of the loop (for example if every vma belongs to a
> AA> different file so it cannot be merged anyways) we'd need a tree of
> AA> "holes" indexed in function of the size of the hole. but it seems a very
> AA> dubious optimization...
> Are there much problems with this approach ? Much memory usage or cpu
> overhead somethere ?
> AA>  Complexity wise it makes sense, but in practice
> AA> the common case should matter more I guess, and of course userspace can
> AA> just fix this without any kernel modification by passing an helpful
> AA> "addr", to the mmap syscall with very very little effort.  Untested
> AA> patch follows:
> 
> Could you please explain a bit how this the hint works ? Does it tries

man 2 mmap, then search for 'start'

> only specified address or also tries to look up the free space from
> this point ?

in short it checks if there's 'len' free space at address 'start', and
if there is, it maps it there, without having to search for the first
large enough hole in the heap.

Andrea

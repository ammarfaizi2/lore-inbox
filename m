Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283415AbRLDOob>; Tue, 4 Dec 2001 09:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283652AbRLDOnJ>; Tue, 4 Dec 2001 09:43:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:42072 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S284338AbRLDOP7>; Tue, 4 Dec 2001 09:15:59 -0500
Date: Tue, 4 Dec 2001 15:15:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Peter Zaitsev <pz@spylog.ru>, theowl@freemail.c3.hu, theowl@freemail.hu,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: your mail on mmap() to the kernel list
Message-ID: <20011204151549.U3447@athlon.random>
In-Reply-To: <3C082244.8587.80EF082@localhost>, <3C082244.8587.80EF082@localhost> <61437219298.20011201113130@spylog.ru> <3C08A4BD.1F737E36@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C08A4BD.1F737E36@zip.com.au>; from akpm@zip.com.au on Sat, Dec 01, 2001 at 01:37:01AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 01:37:01AM -0800, Andrew Morton wrote:
> Peter Zaitsev wrote:
> > 
> > Hello theowl,
> > 
> > Saturday, December 01, 2001, 2:20:20 AM, you wrote:
> > 
> > Well. Thank you. I've allready found this - in recent kernels it's
> > even regulated via proc fs.
> > 
> > The only question is why map anonymous is rather fast (i get
> > 1000req/sec even then mapped 300.000 of blocks), therefore with
> > mapping a fd the perfomance drops to 20req/second at this number.
> > 
> 
> well a kernel profile is pretty unambiguous:
> 
> c0116af4 mm_init                                       1   0.0050
> c0117394 do_fork                                       1   0.0005
> c0124ccc clear_page_tables                             1   0.0064
> c0125af0 do_wp_page                                    1   0.0026
> c01260a0 do_no_page                                    1   0.0033
> c01265dc find_vma_prepare                              1   0.0081
> c0129138 file_read_actor                               1   0.0093
> c012d95c kmem_cache_alloc                              1   0.0035
> c0147890 d_lookup                                      1   0.0036
> c01573dc write_profile                                 1   0.0061
> c0169d44 journal_add_journal_head                      1   0.0035
> c0106e88 system_call                                   2   0.0357
> c01264bc unlock_vma_mappings                           2   0.0500
> c0135bb4 fget                                          2   0.0227
> c028982c __generic_copy_from_user                      2   0.0192
> c01267ec do_mmap_pgoff                                 4   0.0035
> c0126d6c find_vma                                      7   0.0761
> c0105000 _stext                                       16   0.1667
> c0126c70 get_unmapped_area                          4991  19.8056
> c0105278 poll_idle                                  4997 124.9250
> 00000000 total                                     10034   0.0062

the vma lookup overhead is nothing compared to the walking of the linked
list (not of the tree) to find the first available slot above
TASK_UNMAPPED_BASE. In the vma lookup engine rewrite I only cared about
find_vma, not about optimizing the search of a free vma over
TASK_UNMAPPED_BASE.  Such list-loop is really evil.

> What appears to be happening is that the VMA tree has degenerated
> into a monstrous singly linked list.  All those little 4k mappings

actually it's not that the tree degenerated into a list. It's that we
need to walk all the vma to check if there is a large enough hole to
place the new dynamic mapping and so walk we use the list, not the tree,
because it needs less mem resources and it's simpler and faster.

You can fix the problem in userspace by using a meaningful 'addr' as
hint to mmap(2), or by using MAP_FIXED from userspace, then the kernel
won't waste time searching the first available mapping over
TASK_UNMAPPED_BASE.

> The reason you don't see it with an anonymous map is, I think, that
> the kernel will merge contiguous anon mappings into a single one,

Yes. But actually merging also file backed vmas would be a goodness
indipendently of the arch_get_unmapped_area loop. It's not possible
right now because the anonymous memory case it's much simpler: no
i_shared_locks etc... but I'd like if in the long run also the file
backed vma will be mergeable. The side effect of the goodness is that
also the loop would run faster of course. But technically to really kill
the evil complexity of the loop (for example if every vma belongs to a
different file so it cannot be merged anyways) we'd need a tree of
"holes" indexed in function of the size of the hole. but it seems a very
dubious optimization... Complexity wise it makes sense, but in practice
the common case should matter more I guess, and of course userspace can
just fix this without any kernel modification by passing an helpful
"addr", to the mmap syscall with very very little effort.  Untested
patch follows:

@@ -68,7 +9,7 @@
 int main()
 {
 	int i = 0;
-	void *p;
+	void *p = NULL;
 	int t;
 	int fd;
 	
@@ -79,7 +20,7 @@
 	}
 	t = time(NULL);
 	while (1) {
-		p = mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+		p = mmap(p, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 		if ((int) p == -1) {
 			perror("mmap");
 			return;


Andrea

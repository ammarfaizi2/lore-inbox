Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284029AbRLAJhm>; Sat, 1 Dec 2001 04:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284028AbRLAJhW>; Sat, 1 Dec 2001 04:37:22 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:37901 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284027AbRLAJhU>; Sat, 1 Dec 2001 04:37:20 -0500
Message-ID: <3C08A4BD.1F737E36@zip.com.au>
Date: Sat, 01 Dec 2001 01:37:01 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Zaitsev <pz@spylog.ru>
CC: theowl@freemail.c3.hu, theowl@freemail.hu, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: your mail on mmap() to the kernel list
In-Reply-To: <3C082244.8587.80EF082@localhost>,
		<3C082244.8587.80EF082@localhost> <61437219298.20011201113130@spylog.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev wrote:
> 
> Hello theowl,
> 
> Saturday, December 01, 2001, 2:20:20 AM, you wrote:
> 
> Well. Thank you. I've allready found this - in recent kernels it's
> even regulated via proc fs.
> 
> The only question is why map anonymous is rather fast (i get
> 1000req/sec even then mapped 300.000 of blocks), therefore with
> mapping a fd the perfomance drops to 20req/second at this number.
> 

well a kernel profile is pretty unambiguous:

c0116af4 mm_init                                       1   0.0050
c0117394 do_fork                                       1   0.0005
c0124ccc clear_page_tables                             1   0.0064
c0125af0 do_wp_page                                    1   0.0026
c01260a0 do_no_page                                    1   0.0033
c01265dc find_vma_prepare                              1   0.0081
c0129138 file_read_actor                               1   0.0093
c012d95c kmem_cache_alloc                              1   0.0035
c0147890 d_lookup                                      1   0.0036
c01573dc write_profile                                 1   0.0061
c0169d44 journal_add_journal_head                      1   0.0035
c0106e88 system_call                                   2   0.0357
c01264bc unlock_vma_mappings                           2   0.0500
c0135bb4 fget                                          2   0.0227
c028982c __generic_copy_from_user                      2   0.0192
c01267ec do_mmap_pgoff                                 4   0.0035
c0126d6c find_vma                                      7   0.0761
c0105000 _stext                                       16   0.1667
c0126c70 get_unmapped_area                          4991  19.8056
c0105278 poll_idle                                  4997 124.9250
00000000 total                                     10034   0.0062

The `poll_idle' count is from the other CPU.

What appears to be happening is that the VMA tree has degenerated
into a monstrous singly linked list.  All those little 4k mappings
are individual data structures, chained one after the other.

The reason you don't see it with an anonymous map is, I think, that
the kernel will merge contiguous anon mappings into a single one,
so there's basically nothing to be searched each time you request some
more memory.

Running the same test on the -ac kernel is 4-5% slower, so Andrea's
new rbtree implementation makes a better linked list than the old
AVL-tree's one :)

It strikes me that this is not a completely stupid usage pattern, and
that perhaps it's worth thinking about some tweaks to cope with it.
I really don't know, but I've Cc'ed some people who do.

Here's the test app:

#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

int main()
{
	int i = 0;
	void *p;
	int t;
	int fd;
	
	fd = open("test.dat", O_RDWR);
	if (fd < 0) {
		puts("Unable to open file !");
		return;
	}
	t = time(NULL);
	while (1) {
		p = mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
		if ((int) p == -1) {
			perror("mmap");
			return;
		}
		i++;
		if (i % 10000 == 0) {
			printf(" %d  Time: %d\n", i, time(NULL) - t);
			t = time(NULL);
		}
	}
}

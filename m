Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293467AbSBRBbk>; Sun, 17 Feb 2002 20:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293468AbSBRBba>; Sun, 17 Feb 2002 20:31:30 -0500
Received: from dsl-213-023-043-245.arcor-ip.net ([213.23.43.245]:648 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293467AbSBRBbV>;
	Sun, 17 Feb 2002 20:31:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC] Page table sharing
Date: Mon, 18 Feb 2002 02:35:32 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, dmccr@us.ibm.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Robert Love <rml@tech9.net>, Rik van Riel <riel@conectiva.com.br>,
        mingo@redhat.co, Andrew Morton <akpm@zip.com.au>,
        manfred@colorfullife.com, wli@holomorphy.com
In-Reply-To: <Pine.LNX.4.21.0202172133520.10152-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.21.0202172133520.10152-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16cciK-0000HW-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 17, 2002 11:16 pm, Hugh Dickins wrote:
> On Sun, 17 Feb 2002, Daniel Phillips wrote:
> > 
> > Note that we have to hold the page_table_share_lock until we're finished
> > copying in the ptes, otherwise the source could go away.  This can turn
> > into a lock on the page table itself eventually, so whatever contention
> > there might be will be eliminated.
> > 
> > Fixing up copy_page_range to bring the pmd populate inside the 
> > mm->page_table_lock is trivial, I won't go into it here.  With that plus
> > changes as above, I think it's tight.  Though I would not bet my life on
> > it ;-)
> 
> Sorry, I didn't really try to follow your preceding discussion of
> zap_page_range.  (I suspect you need to step back and think again if it
> gets that messy; but that may be unfair, I haven't thought it through).

Oh believe me, it could get a lot messier than what I described.  This
problem is hard because it's hard.

> You need your "page_table_share_lock" (better, per-page-table spinlock)
> much more than you seem to realize.  If mm1 and mm2 share a page table,
> mm1->page_table_lock and mm2->page_table_lock give no protection against
> each other.

Unless we decrement and find that the count was originally 1, that means
we are the exclusive owner and are protected by the mm->page_table_lock
we hold.  Only if that is not the case do we need the extra spinlock.

Please ping me right away if this analysis is wrong.

> Consider copy_page_range from mm1 or __pte_alloc in mm1
> while try_to_swap_out is acting on shared page table in mm2.  In fact,
> I think even the read faults are vulnerable to races (mm1 and mm2
> bringing page in at the same time so double-counting it), since your
> __pte_alloc doesn't regard a read fault as reason to break the share.

This is exactly what I've been considering, intensively, for days.
(Sleeping has been optional ;-)  Please re-evaluate this in light of the
exclusive owner observation above.

> I'm also surprised that your copy_page_range appears to be setting
> write protect on each pte, including expensive pte_page, VALID_PAGE
> stuff on each.

What do you mean?  Look at my copy_page_range inner loop:

	do {
		pte_t pte = *src_ptb;
		if (!pte_none(pte) && pte_present(pte)) {
			struct page *page = pte_page(pte);
			if (VALID_PAGE(page) && !PageReserved(page) && cow)
				ptep_set_wrprotect(src_ptb);
		}
		if ((address += PAGE_SIZE) >= end)
			goto out_unlock;
		src_ptb++;
	} while ((unsigned) src_ptb & PTE_TABLE_MASK);

The && cow line takes care of it.  One thing I'm not doing is taking the
obvious optimization for inherited shared memory, you'll see it's commented
out.  For no particular reason, it's a carryover from the early debugging.

> You avoid actually copying pte and incrementing counts,
> but I'd expect you to want to avoid the whole scan: invalidating entry
> for the page table itself, to force fault if needed.

Yes, I'm concentrating on correctness right now, but the results are far
from shabby anyway.  I'm forking 2-5 times as fast from large-memory
parents:

time ./test 100 10000
100 forks from parent with 10000 pages of mapped memory...
Old total fork time: 0.488664 seconds in 100 iterations (4886 usec/fork)
New total fork time: 0.218832 seconds in 100 iterations (2188 usec/fork)
0.03user 0.82system 0:01.30elapsed 65%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (889major+20471minor)pagefaults 0swaps

time ./test 10 100000
10 forks from parent with 100000 pages of mapped memory...
Old total fork time: 1.045828 seconds in 10 iterations (104582 usec/fork)
New total fork time: 0.225679 seconds in 10 iterations (22567 usec/fork)
0.05user 64.89system 1:06.56elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1189major+200386minor)pagefaults 0swaps

I guess the real fork speed up is 5X and the rest is overhead.  By the way,
notice how long it takes to set up the memory table for the large memory
parent, it looks like there's a basic vm problem (2.4.17).

Using unmapped page tables or Linus's suggestion - setting the page table
RO - is a short step from here.  This will bring these timings from impressive
to downright silly.  However, unless somebody wants to do this hack right now
I'll put it aside for a couple of weeks while the current code stabilizes.
Oh, and I guess I'd better apologize to Linus for calling his suggestion a
'decoration'.

Here's my test script:

echo $1 forks from parent with $2 pages of mapped memory...
echo -n "Old "; sudo -u old ./forktime -n $1 -m $2
echo -n "New "; sudo -u new ./forktime -n $1 -m $2

And the c program 'forktime':

/*
 *  Time fork() system call.
 *
 * Original by Dave McCracken
 * Reformat by Daniel Phillips
 */

#include <stdio.h>
#include <sys/time.h>
#include <sys/mman.h>

int main(int argc, char *argv[])
{
	int n=1, m=1, i, pagesize = getpagesize();
	struct timeval stime, etime, rtime;
	extern char *optarg;
	char *mem;

args:	switch (getopt(argc, argv, "n:m:")) {
	case 'n':
		n = atoi(optarg);
		goto args;
	case 'm':
		m = atoi(optarg);
		goto args;
	case -1:
		break;
	default:
		fprintf(stderr, "Usage: %s [-n iterations] [-m mappedpages]\n", argv[0]);
		exit(1);
	}

	mem = mmap(NULL, m * pagesize, PROT_READ|PROT_WRITE, MAP_PRIVATE | MAP_ANON, 0, 0);

	for (i = 0; i < m; i++)
		mem[i * pagesize] = 0;

	gettimeofday (&stime, NULL);

	for (i = 0; i < n; i++)
		switch (fork()) {
			case 0: exit(0);
			case -1: exit(2);
		}

	wait();
	gettimeofday(&etime, NULL);
	timersub(&etime, &stime, &rtime);
	printf("total fork time: %d.%06d seconds in %d iterations ", rtime.tv_sec, rtime.tv_usec, i);
	printf("(%d usec/fork)\n", ((rtime.tv_sec * 1000000) + rtime.tv_usec) / i);
	exit(0);
}

-- 
Daniel

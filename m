Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVAWAV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVAWAV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 19:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVAWAV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 19:21:28 -0500
Received: from waste.org ([216.27.176.166]:33769 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261164AbVAWAVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 19:21:04 -0500
Date: Sat, 22 Jan 2005 16:21:00 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050123002100.GQ12076@waste.org>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <20050122232814.GG3867@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122232814.GG3867@waste.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 03:28:14PM -0800, Matt Mackall wrote:
> On Sat, Jan 22, 2005 at 09:34:01PM +0100, Andreas Gruenbacher wrote:
> > Add a quicksort from glibc as a kernel library function, and switch
> > xfs over to using it. The implementations are equivalent. The nfsacl
> > protocol also requires a sort function, so it makes more sense in
> > the common code.
> 
> Please update this to kernel formatting standards and try to modernize
> it a bit.

I started working on this with an eye to doing some performance
testing of the insertion sort threshold in userspace, but I'm about to
head out for the day. Here's what I've got so far, compiles but
untested. Note the insertion sort at the end really ought to be using
memmove as well.

/* Copyright (C) 1991, 1992, 1996, 1997, 1999 Free Software Foundation, Inc.
   Written by Douglas C. Schmidt (schmidt@ics.uci.edu).

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307 USA.  */

/* If you consider tuning this algorithm, you should consult first:
   Engineering a sort function; Jon Bentley and M. Douglas McIlroy;
   Software - Practice and Experience; Vol. 23 (11), 1249-1265, 1993.  */

#include <unistd.h>
#include <stdlib.h>

#define min(x,y) ({ \
	typeof(x) _x = (x);	\
	typeof(y) _y = (y);	\
	(void) (&_x == &_y);		\
	_x < _y ? _x : _y; })

/* Byte-wise swap two items of size SIZE. */
#define SWAP(a, b, size)						      \
  do									      \
    {									      \
      size_t __size = (size);					      \
      char *__a = (a), *__b = (b);				      \
      do								      \
	{								      \
	  char __tmp = *__a;						      \
	  *__a++ = *__b;						      \
	  *__b++ = __tmp;						      \
	} while (--__size > 0);						      \
    } while (0)

/* Discontinue quicksort algorithm when partition gets below this size.
   This particular magic number was chosen to work best on a Sun 4/260. */
#define MAX_THRESH 4

/* Stack node declarations used to store unfulfilled partition obligations. */
typedef struct {
	void *lo;
	void *hi;
} stack_node;

/* Order size using quicksort.  This implementation incorporates
   four optimizations discussed in Sedgewick:

   1. Non-recursive, using an explicit stack of pointer that store the
      next array partition to sort.  To save time, this maximum amount
      of space required to store an array of SIZE_MAX is allocated on the
      stack.  Assuming a 32-bit (64 bit) integer for size_t, this needs
      only 32 * sizeof(stack_node) == 256 bytes (for 64 bit: 1024 bytes).
      Pretty cheap, actually.

   2. Chose the pivot element using a median-of-three decision tree.
      This reduces the probability of selecting a bad pivot value and
      eliminates certain extraneous comparisons.

   3. Only quicksorts TOTAL_ELEMS / MAX_THRESH partitions, leaving
      insertion sort to order the MAX_THRESH items within each partition.
      This is a big win, since insertion sort is faster for small, mostly
      sorted array segments.

   4. The larger of the two sub-partitions is always pushed onto the
      stack first, with the algorithm then concentrating on the
      smaller partition.  This *guarantees* no more than log (total_elems)
      stack size is needed (actually O(1) in this case)!  */

void qsort(void *base, size_t num, size_t size,
	   int (*cmp) (const void *, const void *))
{
	const size_t max_thresh = MAX_THRESH * size;
	void *hi, *lo, *mid, *left, *right;
	void *end = base + (size * (num - 1));
	void *tmp = base;
	void *thresh = min(end, base + max_thresh);
	void *run, *trav;
	stack_node *stack, *top;

	if (num == 0)
		return;

	lo = base;
	hi = lo + size * (num - 1);
	if (num > MAX_THRESH) {
		stack = malloc(8 * sizeof(size_t) * sizeof(stack_node));
		top = stack + 1;

		while (stack < top) {
			/* Select median value from among LO, MID, and
			   HI. Rearrange LO and HI so the three values
			   are sorted. This lowers the probability of
			   picking a pathological pivot value and
			   skips a comparison for both the LEFT
			   and RIGHT in the while loops. */

			mid = lo + size * ((hi - lo) / size >> 1);

			if (cmp(mid, lo) < 0)
				SWAP(mid, lo, size);
			if (cmp(hi, mid) < 0) {
				SWAP(mid, hi, size);
				if (cmp(mid, lo) < 0)
					SWAP(mid, lo, size);
			}

			left = lo + size;
			right = hi - size;

			/* Here's the famous ``collapse the walls''
			   section of quicksort. Gotta like those
			   tight inner loops! They are the main reason
			   that this algorithm runs much faster than
			   others. */

			do {
				while (cmp(left, mid) < 0)
					left += size;
				while (cmp(mid, right) < 0)
					right -= size;

				if (left < right) {
					SWAP(left, right, size);
					if (mid == left)
						mid = right;
					else if (mid == right)
						mid = left;
					left += size;
					right -= size;
				} else if (left == right) {
					left += size;
					right -= size;
					break;
				}
			}
			while (left <= right);

			/* Set up pointers for next iteration. First
			   determine whether left and right partitions
			   are below the threshold size. If so, ignore
			   one or both. Otherwise, push the larger
			   partition's bounds on the stack and
			   continue sorting the smaller one. */

			if ((right - lo) <= max_thresh) {
				if ((hi - left) <= max_thresh) {
					/* Ignore both small partitions. */
					--top;
					lo = top->lo;
					hi = top->hi;
				} else
					/* Ignore small left partition. */
					lo = left;
			} else if ((hi - left) <= max_thresh)
				/* Ignore small right partition. */
				hi = right;
			else if ((right - lo) > (hi - left)) {
				/* Push larger left partition indices. */
				top->lo = lo;
				top->hi = right;
				top++;
				lo = left;
			} else {
				/* Push larger right partition indices. */
				top->lo = left;
				top->hi = hi;
				top++;
				hi = right;
			}
		}

		free(stack);
	}

	/* Once the BASE array is partially sorted by quicksort
	   the rest is completely sorted using insertion sort, since
	   this is efficient for partitions below MAX_THRESH size.
	   BASE points to the beginning of the array to sort, and
	   END points at the very last element in the array (*not*
	   one beyond it!). */

	/* Find smallest element in first threshold and place it at
	   the array's beginning. This is the smallest array element,
	   and the operation speeds up insertion sort's inner loop. */

	for (run = tmp + size; run <= thresh; run += size) {
		if (cmp(run, tmp) < 0)
			tmp = run;

		if (tmp != base)
			SWAP(tmp, base, size);

		/* Insertion sort, running from left-hand-side up to
		 * right-hand-side.  */

		run = base + size;
		while ((run += size) <= end) {
			tmp = run - size;
			while (cmp(run, tmp) < 0)
				tmp -= size;

			tmp += size;
			if (tmp != run) {
				trav = run + size;
				while (--trav >= run) {
					char c = *(char *)trav;
					for (hi = lo = trav;
					     (lo -= size) >= tmp; hi = lo)
						*(char *)hi = *(char *)lo;
					*(char *)hi = c;
				}
			}
		}
	}
}



-- 
Mathematics is the supreme nostalgia of our time.

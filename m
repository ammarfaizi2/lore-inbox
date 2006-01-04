Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbWADBBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWADBBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWADBBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:01:09 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:3501 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751520AbWADBBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:01:08 -0500
Subject: Re: [patch 4/9] slab: cache_estimate cleanup
From: Steven Rostedt <rostedt@goodmis.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       colpatch@us.ibm.com, clameter@sgi.com
In-Reply-To: <1136319948.8629.19.camel@localhost>
References: <1136319948.8629.19.camel@localhost>
Content-Type: multipart/mixed; boundary="=-9ibuVHjRl4GVxNg1QDLC"
Date: Tue, 03 Jan 2006 20:00:16 -0500
Message-Id: <1136336416.12468.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9ibuVHjRl4GVxNg1QDLC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-01-03 at 22:25 +0200, Pekka Enberg wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> This patch cleans up cache_estimate in mm/slab.c and improves the algorithm
> by taking an initial guess before executing the while loop. The optimization
> was originally made by Balbir Singh with further improvements from Steven
> Rostedt. Manfred Spraul provider further modifications: no loop at all for
> the off-slab case and explain the background.

The no loop at all probably needs a comment, since I don't see one.
[ see below ]

> 
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> ---
> 
>  mm/slab.c |   89 ++++++++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 64 insertions(+), 25 deletions(-)
> 
> Index: 2.6/mm/slab.c
> ===================================================================
> --- 2.6.orig/mm/slab.c
> +++ 2.6/mm/slab.c

[snip]

> +/* Calculate the number of objects and left-over bytes for a given
> +   object size. */
> +static void cache_estimate(unsigned long gfporder, size_t obj_size,
> +			   size_t align, int flags, size_t *left_over,
> +			   unsigned int *num)
> +{
> +	int nr_objs;
> +	size_t mgmt_size;
> +	size_t slab_size = PAGE_SIZE << gfporder;
> +
> +	/*
> +	 * The slab management structure can be either off the slab or
> +	 * on it. For the latter case, the memory allocated for a
> +	 * slab is used for:
> +	 *
> +	 * - The struct slab
> +	 * - One kmem_bufctl_t for each object
> +	 * - Padding, to achieve alignment of @align
> +	 * - @obj_size bytes for each object
> +	 */

Probably want a comment here that says something to the following:

If the slab management structure is off the slab, then the alignment
will already be calculated into the size. Because the slabs are all
pages aligned, the objects will be at the correct alignment when
allocated.

[more below]

> +	if (flags & CFLGS_OFF_SLAB) {
> +		mgmt_size = 0;
> +		nr_objs = slab_size / obj_size;
> +
> +		if (nr_objs > SLAB_LIMIT)
> +			nr_objs = SLAB_LIMIT;
> +	} else {
> +		/* Ignore padding for the initial guess.  The padding
> +		 * is at most @align-1 bytes, and @size is at least

should @size be @obj_size

> +		 * @align. In the worst case, this result will be one
> +		 * greater than the number of objects that fit into
> +		 * the memory allocation when taking the padding into
> +		 * account.
> +		 */
> +		nr_objs = (slab_size - sizeof(struct slab)) /
> +			  (obj_size + sizeof(kmem_bufctl_t));
> +
> +		/*
> +		 * Now take the padding into account and increase the
> +		 * number of objects/slab until it doesn't fit
> +		 * anymore.
> +		 */
> +		while (slab_mgmt_size(nr_objs, align) + nr_objs*obj_size
> +		       <= slab_size)
> +			nr_objs++;

I've also been looking at this and I've realized that we can even remove
the "while" and make it into an "if".  It works just as well. I created
the attached test program to see if there would be any difference
testing all sizes from 8 to PAGE_SIZE >> 1 (where PAGE_SIZE = 1<<12),
and all alignments of 4 to size, and I tried this with two orders of
pages.  The "if" should make the assembly a little better.

-- Steve

> +
> +		/*
> +		 * Reduce it by one which the maximum number of objects that
> +		 * fit in the slab.
> +		 */
> +		if (nr_objs > 0)
> +			nr_objs--;
> +
> +		if (nr_objs > SLAB_LIMIT)
> +			nr_objs = SLAB_LIMIT;
> +
> +		mgmt_size = slab_mgmt_size(nr_objs, align);
> +	}
> +	*num = nr_objs;
> +	*left_over = slab_size - nr_objs*obj_size - mgmt_size;
>  }
>  
>  #define slab_error(cachep, msg) __slab_error(__FUNCTION__, cachep, msg)
> 
> --
> 


--=-9ibuVHjRl4GVxNg1QDLC
Content-Disposition: attachment; filename=align.c
Content-Type: text/x-csrc; name=align.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define PAGE_SIZE (1<<12)
struct slab {
	int x[7];
};

typedef long kmem_bufctl_t;

#define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))

static size_t slab_mgmt_size(size_t nr_objs, size_t align)
{
	return ALIGN(sizeof(struct slab)+nr_objs*sizeof(kmem_bufctl_t), align);
}

int estimate (int size, int align, int *leftover, int *hold1, int * hold2, int *num, int order)
{ 
	int nr_objs;
	int slab_size = PAGE_SIZE << order;
	int nr1;
	int nr2;
	int mgmt_size;
	int nr_while;
	int nr_if;
	int ret = 0;

	nr_objs = (slab_size - sizeof(struct slab)) /
		(size + sizeof(kmem_bufctl_t));

	nr1 = nr_objs;
	/*
	 * Now take the padding into account and increase the
	 * number of objects/slab until it doesn't fit
	 * anymore.
	 */
	nr_if = nr_objs;

	if (slab_mgmt_size(nr_objs, align) + nr_objs*size
	       <= slab_size)
		nr_if++;

	if (slab_mgmt_size(nr_objs, align) + nr_objs*size
	       <= slab_size)
		nr_objs++;

	if (nr_if != nr_objs)
		ret = 1;

	nr2 = nr_objs;

	/*
	 * Reduce it by one which the maximum number of objects that
	 * fit in the slab.
	 */
	if (nr_objs > 0)
		nr_objs--;

        mgmt_size = slab_mgmt_size(nr_objs, align);

	*num = nr_objs;
	*leftover = slab_size - nr_objs*size - mgmt_size;

	*hold1 = nr1;
	*hold2 = nr2;

	return ret;
}

int main (int argc, char **argv)
{
	int i;
	int x;
	int leftover;
	int hold1;
	int hold2;
	int num;
	int order;

	for (order=0; order <= 1; order++) {
		for (i=8; i < (PAGE_SIZE >> 1); i++) {
			for (x=4; x < i; x++) {
				if (estimate(i, x, &leftover, &hold1, &hold2, &num, order))
					printf("%8d%8d%8d%8d%8d%8d%8d%8d\n", i, x, leftover,
					       hold1, hold2, num, hold1-num, hold2-num);
			}
		}
	}
	return 0;
}

--=-9ibuVHjRl4GVxNg1QDLC--


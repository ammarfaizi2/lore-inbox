Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVAVX2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVAVX2y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 18:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVAVX2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 18:28:53 -0500
Received: from waste.org ([216.27.176.166]:64992 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261157AbVAVX2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 18:28:44 -0500
Date: Sat, 22 Jan 2005 15:28:14 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050122232814.GG3867@waste.org>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122203618.962749000@blunzn.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 09:34:01PM +0100, Andreas Gruenbacher wrote:
> Add a quicksort from glibc as a kernel library function, and switch
> xfs over to using it. The implementations are equivalent. The nfsacl
> protocol also requires a sort function, so it makes more sense in
> the common code.

Please update this to kernel formatting standards and try to modernize
it a bit.

> +/* Byte-wise swap two items of size SIZE. */
> +#define SWAP(a, b, size)						      \
> +  do									      \
> +    {									      \
> +      register size_t __size = (size);					      \
> +      register char *__a = (a), *__b = (b);				      \
> +      do								      \
> +	{								      \
> +	  char __tmp = *__a;						      \
> +	  *__a++ = *__b;						      \
> +	  *__b++ = __tmp;						      \
> +	} while (--__size > 0);						      \
> +    } while (0)

Inline, please? Register keyword?!

> +typedef struct
> +  {
> +    char *lo;
> +    char *hi;
> +  } stack_node;

void *, please

> +
> +/* The next 5 #defines implement a very fast in-line stack abstraction. */
> +/* The stack needs log (total_elements) entries (we could even subtract
> +   log(MAX_THRESH)).  Since total_elements has type size_t, we get as
> +   upper bound for log (total_elements):
> +   bits per byte (CHAR_BIT) * sizeof(size_t).  */
> +#define CHAR_BIT 8
> +#define STACK_SIZE	(CHAR_BIT * sizeof(size_t))

So the stack is going to be either 256 or 1024 bytes. Seems like we
ought to kmalloc it.

> +#define PUSH(low, high)	((void) ((top->lo = (low)), (top->hi = (high)), ++top))
> +#define	POP(low, high)	((void) (--top, (low = top->lo), (high = top->hi)))
> +#define	STACK_NOT_EMPTY	(stack < top)

There's only one usage of POP, one of STACK_NOT_EMPTY and two of PUSH
that can trivially be made one. Please kill these macros.

> +   3. Only quicksorts TOTAL_ELEMS / MAX_THRESH partitions, leaving
> +      insertion sort to order the MAX_THRESH items within each partition.
> +      This is a big win, since insertion sort is faster for small, mostly
> +      sorted array segments.

This observation may be dated, instruction cache issues may dominate now.

> +	  char *mid = lo + size * ((hi - lo) / size >> 1);

Get rid of all this char* stuff, please. It makes for lots of ugly and
unnecessary casting.

> +	  if ((*cmp) ((void *) mid, (void *) lo) < 0)
> +	    SWAP (mid, lo, size);

cmp(mid, lo)

> +	  if ((*cmp) ((void *) hi, (void *) mid) < 0)
> +	    SWAP (mid, hi, size);
> +	  else
> +	    goto jump_over;
> +	  if ((*cmp) ((void *) mid, (void *) lo) < 0)
> +	    SWAP (mid, lo, size);
> +	jump_over:;

?!

> +  /* Once the BASE_PTR array is partially sorted by quicksort the rest
> +     is completely sorted using insertion sort, since this is efficient
> +     for partitions below MAX_THRESH size. BASE_PTR points to the beginning
> +     of the array to sort, and END_PTR points at the very last element in
> +     the array (*not* one beyond it!). */
> +
> +  {
> +    char *end_ptr = &base_ptr[size * (total_elems - 1)];
> +    char *tmp_ptr = base_ptr;
> +    char *thresh = min(end_ptr, base_ptr + max_thresh);
> +    register char *run_ptr;

Move these vars to the top or better yet, split this into two functions.

-- 
Mathematics is the supreme nostalgia of our time.

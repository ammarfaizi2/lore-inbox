Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbUC3Abk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUC3AbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:31:25 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:9446 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261631AbUC3AbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:31:11 -0500
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20040329041253.5cd281a5.pj@sgi.com>
References: <20040329041253.5cd281a5.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1080606618.6742.89.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Mar 2004 16:30:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 04:12, Paul Jackson wrote:
> Patch_2_of_22 - New mask ADT
> 	Adds new include/linux/mask.h header file
> 
> 	==> See this mask.h header for more extensive mask documentation <==
> 

<snip>

> + *           Various Implementation Details
> + *           ==============================
> + *
> + * The parameter 'T' above must be a variable of the appropriate
> + *   mask type (cpumask_t or nodemask_t, for instance).  This
> + *   variable is only used for its typeof() information.
> + *
> + * For details of mask_scnprintf() and mask_parse(), see
> + *   bitmap_scnprintf() and bitmap_parse() in lib/bitmap.c
> + *
> + * A new *mask type should be defined, such as cpumask_t or
> + *   nodemask_t, for each possibly different sized (number of
> + *   bits) bitmask based on this mask ADT.  The definition
> + *   for example of cpumask_t is:
> + *           typedef __mask(NR_CPUS) cpumask_t;

Is this necessary, or just convenient?  I can see how it would be
necessary for the mask_of_bit() function...


> + * These macros presume that all masks passed in a given call
> + *   are the same nbits long, and that only bits in positions
> + *   b where 0 <= b < nbits might be set in input masks.
> + *   They ensure that no additional bits outside this range
> + *   become set (however don't protect against improperly set
> + *   bits that are outside this range but still inside the array
> + *   of unsigned longs representing the mask.)  In other words,
> + *   any implementation of these ops may assume as a precondition
> + *   that any unused bits (bits in the array of unsigned
> + *   longs, outside the range 0 to nbits-1) are zero.  And any
> + *   implementation of these ops must ensure as a postcondition
> + *   on all output masks that this same precondition (unused
> + *   bits are zero) holds.  If you manage to create, by some
> + *   other means, a mask with some unused bits non-zero, and
> + *   then pass that mask to one of these mask operations, that
> + *   operation may malfunction.
> + *
> + * The abstract bit model supported by these masks is that of
> + *   an infinite set of bits, in positions numbered 0 and up,
> + *   where all but the first 'nbits' bits are always zero.
> + *   Calls that implicitly attempt to set any bit outside of
> + *   the first 'nbits' bits successfully and quietly leave such
> + *   bits as zero.  Calls that query or modify specifically
> + *   numbered bit positions require as a precondition that the
> + *   specified bit position 'n' is the range 0 <= n < nbits, and
> + *   may malfunction if handed a bit position outside this range.

Ok...  This implies that my comments on the last patch were valid.  I
like this model.  Assume the unused bits aren't set, and take care not
to set them.  I'm happy to see this spelled out explicitly.


> + * The underlying bitmap.c operations such as bitmap_and() and
> + *   bitmap_or() don't follow this model.  They don't assume
> + *   the precondition that unused bits are zero, and they do
> + *   mask off any unused portion of input masks in most cases.
> + *   However the underlying bitop.h operations, such as set_bit()
> + *   and clear_bit(), do no sanitizing of their inputs, depending
> + *   heavily on preconditions.

bitmap_and() & bitmap_or() *do not* mask off the unused input bits. 
Unless you add that code in a subsequent patch...  This paragraph seems
a bit unclear.  You're saying that bitmap_and() & bitmap_or() *don't*
follow the precondition, but *do* mask off unused bits, which I'm not
seeing.  Then the 'however' is confusing, because you continue with the
same point about *not* following preconditions.  Maybe something like:

"The underlying bitmap.c operations such as bitmap_and() and bitmap_or()
don't follow this model of 'unused bits'.  Users must follow the
precondition that unused bits are zero to guarantee no unused bits are
set by the operations.  Further, the underlying bitop.h operations, such
as set_bit() and clear_bit(), do no sanitizing of their inputs, also
depending on users not to set/clear unused bits (ie: ensure 0 <= b <
nbits)."


> + * The file include/mask.h applies to all architectures.
> + *   Architectures requiring custom details should provide
> + *   them in their include/asm-<arch>/bitops.h file, and
> + *   if necessary modify the common include/linux/mask.h
> + *   file to conditionally generate the necessary code,
> + *   depending on compile time settings.  No need to write
> + *   ugly #ifdef's to do this - gcc provides a rich set
> + *   of compile time extensions.  See further for example:
> + *   http://gcc.gnu.org/onlinedocs/gcc-3.3.3/gcc/C-Extensions.html

I think that it wouldn't be terribly ugly to split out the 1 unsigned
long special cases (bitmap_and, bitmap_or, etc) with #ifdefs.  I think
that in some ways it makes it a little more readable because it gets rid
of "if (sizeof(foo) == sizeof(unsigned long))..." all over the place.  I
don't feel strongly enough about it to make a stink, though...


> +#define mask_test_and_set(bit, mask)					\
> +	test_and_set_bit(bit, (mask)._m)

test_and_set_bit((bit), (mask)._m) ?

-Matt


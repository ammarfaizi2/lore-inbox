Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbVJaRWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVJaRWn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 12:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbVJaRWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 12:22:43 -0500
Received: from fmr19.intel.com ([134.134.136.18]:37026 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932491AbVJaRWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 12:22:43 -0500
Message-ID: <4366533C.1010809@linux.intel.com>
Date: Mon, 31 Oct 2005 09:24:12 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexandre Oliva <aoliva@redhat.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: amd64 bitops fix for -Os
References: <orvezggf7x.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
In-Reply-To: <orvezggf7x.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Oliva wrote:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=171672
> 
> This patches fixes a bug that comes up when compiling the kernel for
> x86_64 optimizing for size.  It affects 2.6.14 for sure, but I'm
> pretty sure many earlier kernels are affected as well.
> 
> The symptom is that, as soon as some change is made to the root
> filesystem (e.g. dmesg > /var/log/dmesg), the kernel mostly hangs.  It
> was not the first time I'd run into this symptom, but this time I
> could track the problem down to enabling size optimizations in the
> kernel build.  It took some time to narrow down the culprit source
> with a binary search, compiling part of the kernel sources with -Os
> and part with -O2, but eventually it was clear that bitops itself was
> to blame, which should have been clear from the soft lockup oops I
> got.
> 
> The problem is that find_first_zero_bit() fails when called with an
> underflown size, because its inline asm assumes at least one iteration
> of scasq will run.  When this does not hold, the conditional branch
> that follows it uses flags from instructions prior to the asm
> statement.


[snip]


> Anyhow, with this patch I could run 2.6.14, as in the Fedora
> development tree, except for the change to optimize for size.

Yes, works for me too.

> 	Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>

Possibly Andrew or Andi have already merged this into their trees.
However, I have a few comments on the patch re Linux style.
They are meant to help inform you and others -- that's all.

> --- arch/x86_64/lib/bitops.c~	2005-10-27 22:02:08.000000000 -0200
> +++ arch/x86_64/lib/bitops.c	2005-10-29 18:24:27.000000000 -0200

Diffs should start with a top-level names (even if it's entirely
phony), so that they can be applied with many scripts that are around
and expect that.

> @@ -1,5 +1,11 @@
>  #include <linux/bitops.h>
>  
> +#define BITOPS_CHECK_UNDERFLOW_RANGE 0
> +
> +#if BITOPS_CHECK_UNDERFLOW_RANGE
> +# include <linux/kernel.h>
> +#endif

We don't usually indent inside if/endif.

> @@ -13,11 +19,21 @@
>   * Returns the bit-number of the first zero bit, not the number of the byte
>   * containing a bit.
>   */
> -inline long find_first_zero_bit(const unsigned long * addr, unsigned long size)
> +static inline long
> +__find_first_zero_bit(const unsigned long * addr, unsigned long size)

The only good reason for splitting a function header is if it would
otherwise be > 80 columns, not just to put the function name at the
beginning of the line.

>  {
>  	long d0, d1, d2;
>  	long res;
>  
> +	/* We must test the size in words, not in bits, because
> +	   otherwise incoming sizes in the range -63..-1 will not run
> +	   any scasq instructions, and then the flags used by the je
> +	   instruction will have whatever random value was in place
> +	   before.  Nobody should call us like that, but
> +	   find_next_zero_bit() does when offset and size are at the
> +	   same word and it fails to find a zero itself.  */

Linux long-comment style is:
	/*
	 * line1 words ....
	 * line2
	 * line3
	 */

> @@ -30,11 +46,22 @@
>  		"  shlq $3,%%rdi\n"
>  		"  addq %%rdi,%%rdx"
>  		:"=d" (res), "=&c" (d0), "=&D" (d1), "=&a" (d2)
> -		:"0" (0ULL), "1" ((size + 63) >> 6), "2" (addr), "3" (-1ULL),
> -		 [addr] "r" (addr) : "memory");
> +		:"0" (0ULL), "1" (size), "2" (addr), "3" (-1ULL),
> +		 /* Any register here would do, but GCC tends to
> +		    prefer rbx over rsi, even though rsi is readily
> +		    available and doesn't have to be saved.  */
> +		 [addr] "S" (addr) : "memory");

Comment in the middle of the difficult-to-read asm instruction in
undesirable (IMO).

>  	return res;
>  }
>  

> @@ -74,6 +101,17 @@
>  	long d0, d1;
>  	long res;
>  
> +	/* We must test the size in words, not in bits, because
> +	   otherwise incoming sizes in the range -63..-1 will not run
> +	   any scasq instructions, and then the flags used by the jz
> +	   instruction will have whatever random value was in place
> +	   before.  Nobody should call us like that, but
> +	   find_next_bit() does when offset and size are at the same
> +	   word and it fails to find a one itself.  */

Comment style again.

But I'm happy that my kernel now boots.  I didn't realize that it was
a -Os issue until your email.  Thanks.

-- 
~Randy

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUC2XHR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbUC2XHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:07:17 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:23965 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261179AbUC2XHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:07:06 -0500
Subject: Re: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20040329041249.65d365a1.pj@sgi.com>
References: <20040329041249.65d365a1.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1080601576.6742.43.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Mar 2004 15:06:16 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 04:12, Paul Jackson wrote:
> Patch_1_of_22 - Underlying bitmap/bitop details, added ops
> 	Add a couple of 'const' qualifiers
> 	Add intersects, subset, xor and andnot operators.
> 	Fix some unused bits in bitmap_complement
> 	Change bitmap_complement to take two operands.

<snip>

> diff -Nru a/lib/bitmap.c b/lib/bitmap.c
> --- a/lib/bitmap.c	Mon Mar 29 01:03:26 2004
> +++ b/lib/bitmap.c	Mon Mar 29 01:03:26 2004
> @@ -45,7 +45,7 @@
>  EXPORT_SYMBOL(bitmap_full);
>  
>  int bitmap_equal(const unsigned long *bitmap1,
> -		unsigned long *bitmap2, int bits)
> +		const unsigned long *bitmap2, int bits)
>  {
>  	int k, lim = bits/BITS_PER_LONG;;
>  	for (k = 0; k < lim; ++k)

Double `;`?  You didn't put it there, but it seems that...

> @@ -61,13 +61,14 @@
>  }
>  EXPORT_SYMBOL(bitmap_equal);
>  
> -void bitmap_complement(unsigned long *bitmap, int bits)
> +void bitmap_complement(unsigned long *dst, const unsigned long *src, int bits)
>  {
> -	int k;
> -	int nr = BITS_TO_LONGS(bits);
> +	int k, lim = bits/BITS_PER_LONG;;
> +	for (k = 0; k < lim; ++k)
> +		dst[k] = ~src[k];

...you propagated the error...

 
> +int bitmap_intersects(const unsigned long *bitmap1,
> +				const unsigned long *bitmap2, int bits)
> +{
> +	int k, lim = bits/BITS_PER_LONG;;

...a couple times...

> +	for (k = 0; k < lim; ++k)
> +		if (bitmap1[k] & bitmap2[k])
> +			return 1;
> +
> +	if (bits % BITS_PER_LONG)
> +		if ((bitmap1[k] & bitmap2[k]) &
> +				((1UL << (bits % BITS_PER_LONG)) - 1))
> +			return 1;
> +	return 0;
> +}
> +EXPORT_SYMBOL(bitmap_intersects);

Do we need to check the last word specially?  If we're assuming that the
unused bits are 0's, then they can't affect the check, right?  If we're
not assuming the unused bits are 0's, then we need to do this last word
special casing in bitmap_xor & bitmap_andnot, because they could set the
unused bits.  Or am I confused?

> +int bitmap_subset(const unsigned long *bitmap1,
> +				const unsigned long *bitmap2, int bits)
> +{
> +	int k, lim = bits/BITS_PER_LONG;;
> +	for (k = 0; k < lim; ++k)
> +		if (bitmap1[k] & ~bitmap2[k])
> +			return 0;
> +
> +	if (bits % BITS_PER_LONG)
> +		if ((bitmap1[k] & ~bitmap2[k]) &
> +				((1UL << (bits % BITS_PER_LONG)) - 1))
> +			return 0;
> +	return 1;
> +}
> +EXPORT_SYMBOL(bitmap_subset);

Same comments here, both the double ';' and the last word special
casing...

Looking ahead, patch 2/22 specifically states that we assume all our
input masks have the high/unused bits cleared and we promise not to set
them.  So we shouldn't need the last word special casing in
bitmap_intersect & bitmap_subset...  I think. ;)

-Matt


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265722AbUFYHGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265722AbUFYHGf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 03:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266294AbUFYHGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 03:06:33 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:41886 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265722AbUFYHGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 03:06:31 -0400
Message-ID: <40DBCEF3.3040605@yahoo.com.au>
Date: Fri, 25 Jun 2004 17:06:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v850]  Add find_next_bit for v850
References: <20040625062900.897C93A2@mctpc71>
In-Reply-To: <20040625062900.897C93A2@mctpc71>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:
> [Since many archs use the same implementation of find_next_bit, it might
> be nice to have `generic_find_next_bit' or something.]
> 
> Signed-off-by: Miles Bader <miles@gnu.org>
> 
>  include/asm-v850/bitops.h |   76 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 76 insertions(+)
> 
> diff -ruN -X../cludes linux-2.6.7-uc0/include/asm-v850/bitops.h linux-2.6.7-uc0-v850-20040625/include/asm-v850/bitops.h
> --- linux-2.6.7-uc0/include/asm-v850/bitops.h	2004-05-11 13:20:53.000000000 +0900
> +++ linux-2.6.7-uc0-v850-20040625/include/asm-v850/bitops.h	2004-06-25 14:24:08.000000000 +0900
> @@ -193,10 +193,86 @@
>  	return result + ffz (tmp);
>  }
>  
> +
> +/* This is the same as generic_ffs, but we can't use that because it's
> +   inline and the #include order mucks things up.  */
> +static inline int generic_ffs_for_find_next_bit(int x)
> +{
> +	int r = 1;
> +
> +	if (!x)
> +		return 0;
> +	if (!(x & 0xffff)) {
> +		x >>= 16;
> +		r += 16;
> +	}
> +	if (!(x & 0xff)) {
> +		x >>= 8;
> +		r += 8;
> +	}
> +	if (!(x & 0xf)) {
> +		x >>= 4;
> +		r += 4;
> +	}
> +	if (!(x & 3)) {
> +		x >>= 2;
> +		r += 2;
> +	}
> +	if (!(x & 1)) {
> +		x >>= 1;
> +		r += 1;
> +	}
> +	return r;
> +}
> +
> +/*
> + * Find next one bit in a bitmap reasonably efficiently.
> + */
> +static __inline__ unsigned long find_next_bit(const unsigned long *addr,

This probably shouldn't be inline.

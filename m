Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318173AbSGWRER>; Tue, 23 Jul 2002 13:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318174AbSGWREQ>; Tue, 23 Jul 2002 13:04:16 -0400
Received: from [195.223.140.120] ([195.223.140.120]:33300 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318173AbSGWREP>; Tue, 23 Jul 2002 13:04:15 -0400
Date: Tue, 23 Jul 2002 19:08:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel McNeil <daniel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2aa1 i_size atomic access
Message-ID: <20020723170807.GW1116@dualathlon.random>
References: <1026949132.20314.0.camel@joe2.pdx.osdl.net> <1026951041.2412.38.camel@IBM-C> <20020718103511.GG994@dualathlon.random> <1027037361.2424.73.camel@IBM-C> <20020719112305.A15517@oldwotan.suse.de> <1027119396.2629.16.camel@IBM-C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027119396.2629.16.camel@IBM-C>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 03:56:36PM -0700, Daniel McNeil wrote:
> +	short v1;
> +	short v2;
> +	loff_t i_size;
> +
> +	/*
> +	 * retry if i_size was possibly modified while sampling.
> +	 */
> +	do {
> +		v1 = inode->i_attr_version1;
> +		v2 = inode->i_attr_version2;
> +		rmb();
> +		i_size = inode->i_size;
> +		rmb();
> +	} while (v1 != v2 ||
> +		 v1 != inode->i_attr_version1 ||
> +		 v1 != inode->i_attr_version2);
> +	return i_size;
[..]
>  #elif BITS_PER_LONG==64
>  	return inode->i_size;
>  #endif
> @@ -548,8 +566,12 @@
>  static inline void i_size_write(struct inode * inode, loff_t i_size)
>  {
>  #if BITS_PER_LONG==32
> -	set_64bit((unsigned long long *) &inode->i_size,
> -		  (unsigned long long) i_size);
> +	inode->i_attr_version1++;       /* changing i_size */
> +	wmb();
> +	inode->i_size = i_size;
> +	wmb();
> +	inode->i_attr_version2++;       /* done with change */
> +	wmb();
>  #elif BITS_PER_LONG==64
>  	inode->i_size = i_size;
>  #endif

btw, looking at the implementation the read side was buggy. First it's
pointless to read both version1 and version2 before reading the isize,
secondly if you increase version1 first (in the writer), the reader has
to read version2 before i_size and version1 after i_size. While you're
doing the opposite, you compare v1 (version1) read before i_size with
version2 after i_size.

So while merging it I rewrote it this way (I also change the type of the
sequence number to int, 2^16 can overflow quite fast in a multighz cpu,
mostly for paranoid of course, and to go safe with the atomic granularty
provided by archs, int certainly has to be atomic-granular).

	loff_t i_size;
	int v1, v2;

	/* Retry if i_size was possibly modified while sampling. */
	do {
		v1 = inode->i_size_version1;
		rmb();
		i_size = inode->i_size;
		rmb();
		v2 = inode->i_size_version2;
	} while (v1 != v2);

	return i_size;


and the new writer side:

	inode->i_size_version2++;
	wmb();
	inode->i_size = i_size;
	wmb();
	inode->i_size_version1++;
	wmb(); /* make it visible ASAP */

Andrea

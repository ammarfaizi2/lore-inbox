Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267485AbTBNWxP>; Fri, 14 Feb 2003 17:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbTBNWxO>; Fri, 14 Feb 2003 17:53:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:6784 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267485AbTBNWxM>;
	Fri, 14 Feb 2003 17:53:12 -0500
Date: Fri, 14 Feb 2003 15:01:28 -0800
From: Andrew Morton <akpm@digeo.com>
To: Szabolcs Berecz <szabi@mplayerhq.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] radix-tree.c
Message-Id: <20030214150128.5a28e7d5.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.33.0302142233370.16839-100000@mail.mplayerhq.hu>
References: <Pine.LNX.4.33.0302142233370.16839-100000@mail.mplayerhq.hu>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2003 23:02:58.0819 (UTC) FILETIME=[37933530:01C2D47D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szabolcs Berecz <szabi@mplayerhq.hu> wrote:
>
> 
> With the following patch maxindex is taken from an array instead of
> recalculating it all the time.

Looks good to me.

> +static unsigned long height_to_maxindex[RADIX_TREE_MAX_PATH];
> +
>  /*
>   * Radix tree node cache.
>   */
> @@ -126,12 +128,9 @@
>   */
>  static inline unsigned long radix_tree_maxindex(unsigned int height)
>  {
> -	unsigned int tmp = height * RADIX_TREE_MAP_SHIFT;
> -	unsigned long index = (~0UL >> (RADIX_TREE_INDEX_BITS - tmp - 1)) >> 1;
> -
> -	if (tmp >= RADIX_TREE_INDEX_BITS)
> -		index = ~0UL;
> -	return index;
> +	if (unlikely(height >= RADIX_TREE_MAX_PATH))
> +		return ~0UL;
> +	return height_to_maxindex[height];

If you make height_to_maxindex[] a bit bigger, and fill it up with ~0UL's,
this comparison can be removed too.

I rather hope that height cannot be larger than RADIX_TREE_MAX_PATH anyway...


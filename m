Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWDHPmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWDHPmZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 11:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWDHPmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 11:42:25 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:57350 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S964989AbWDHPmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 11:42:24 -0400
Message-ID: <4437D9BB.30207@shadowen.org>
Date: Sat, 08 Apr 2006 16:41:47 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com, jes@trained-monkey.org,
       nickpiggin@yahoo.com.au, tony.luck@intel.com,
       mm-commits@vger.kernel.org
Subject: Re: + pg_uncached-is-ia64-only.patch added to -mm tree
References: <200604070421.k374LXFs011197@shell0.pdx.osdl.net>	<20060407134827.91a47e69.kamezawa.hiroyu@jp.fujitsu.com> <20060406215242.245340de.akpm@osdl.org>
In-Reply-To: <20060406215242.245340de.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> 
>>Hi, Andrew
>>
>>On Thu, 06 Apr 2006 21:20:26 -0700
>>akpm@osdl.org wrote:
>>
>>
>>>The patch titled
>>>
>>>     PG_uncached is ia64 only
>>>
>>>has been added to the -mm tree.  Its filename is
>>>
>>>     pg_uncached-is-ia64-only.patch
>>>
>>>See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
>>>out what to do about this
>>>
>>
>>in include/linux/mmzone.h
>>==
>>#elif BITS_PER_LONG == 64
>>/*
>> * with 64 bit flags field, there's plenty of room.
>> */
>>#define FLAGS_RESERVED          32
>>
>>#else
> 
> 
> OK.
> 
> 
>>it looks this is used here.
>>
>>#if SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
>>#error SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
>>#endif
>>
>>I'm not sure but please compile check FLAGS_RESRVED with SPARSEMEM or
>>
> 
> 
> Yes, that test won't trigger.
> 
> 
>>#if (BITS_PER_LONG > 32)               /* 64-bit only flags. we can use full 
>>                                          low 32bits */
>>#define PG_uncached	31
>>#endif
>>
>>Hm..Is this  ugly ? :(
> 
> 
> It's easier to change FLAGS_RESERVED ;)
> 
> diff -puN include/linux/page-flags.h~pg_uncached-is-ia64-only include/linux/page-flags.h
> --- devel/include/linux/page-flags.h~pg_uncached-is-ia64-only	2006-04-06 21:50:51.000000000 -0700
> +++ devel-akpm/include/linux/page-flags.h	2006-04-06 21:50:51.000000000 -0700
> @@ -7,6 +7,8 @@
>  
>  #include <linux/percpu.h>
>  #include <linux/cache.h>
> +#include <linux/types.h>
> +
>  #include <asm/pgtable.h>
>  
>  /*
> @@ -86,7 +88,10 @@
>  #define PG_mappedtodisk		16	/* Has blocks allocated on-disk */
>  #define PG_reclaim		17	/* To be reclaimed asap */
>  #define PG_nosave_free		18	/* Free, should not be written */
> -#define PG_uncached		19	/* Page has been mapped as uncached */
> +
> +#if (BITS_PER_LONG > 32)
> +#define PG_uncached		32	/* Page has been mapped as uncached */
> +#endif

As Hiroyuki-san points out we can need up to 30 bits to encode large 64
bit machines right now.  Reducing the space available for FIELDS but
reducing FLAGS_RESERVED for 64 bit machines will negativly impact them
when SPARSEMEM is enabled.  I think it makes much more sense here to use
the bits which have been released by the movement of the FIELDS upwards
in the 64 bit case.

32 bit  -------------------------------| FIELDS |       FLAGS         |
64 bit  |           FIELDS             | ??????         FLAGS         |
        63                            32                              0

Logically we should in the general case have FLAGS_RESERVED in 64 bit be
the value for 32 bit + 32; currently 9 + 32.  If we desire to have 64
bit only flags then it seems keeping FLAGS_RESERVED at 32 for 64 bit
would leave '32 bit FIELDS' segment free for those flags.

In short with the current values of FLAGS_RESERVED I would think
starting at 31 working downwards towards the 'common'/32 bit flags would
be the most logical.

Cheers.

-apw

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWACVZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWACVZc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWACVZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:25:14 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:60575 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750908AbWACVYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:24:54 -0500
Message-ID: <43BAEB98.8060906@austin.ibm.com>
Date: Tue, 03 Jan 2006 15:24:40 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yasunori Goto <y-goto@jp.fujitsu.com>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [Patch] New zone ZONE_EASY_RECLAIM take 4. (change build_zonelists)[3/8]
References: <20051220172910.1B0C.Y-GOTO@jp.fujitsu.com>
In-Reply-To: <20051220172910.1B0C.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -	BUG_ON(zone_type > ZONE_HIGHMEM);
> +	BUG_ON(zone_type > ZONE_EASY_RECLAIM);

It might be nice to check ifndef CONFIG_HIGHMEM that the zone isn't 
particularly ZONE_HIGHMEM.

>  	int res = ZONE_NORMAL;
> -	if (zone_bits & (__force int)__GFP_HIGHMEM)
> -		res = ZONE_HIGHMEM;
> -	if (zone_bits & (__force int)__GFP_DMA32)
> -		res = ZONE_DMA32;
> -	if (zone_bits & (__force int)__GFP_DMA)
> +
> +	if (zone_bits == fls((__force int)__GFP_DMA))
>  		res = ZONE_DMA;
> +	if (zone_bits == fls((__force int)__GFP_DMA32) &&
> +	    (__force int)__GFP_DMA32 == 0x02)
> +		res = ZONE_DMA32;
> +	if (zone_bits == fls((__force int)__GFP_HIGHMEM))
> +		res = ZONE_HIGHMEM;
> +	if (zone_bits == fls((__force int)__GFP_EASY_RECLAIM))
> +		res = ZONE_EASY_RECLAIM;
> +
>  	return res;
>  }

It is incredibly silly to check a constant for a value.  When it is zero 
instead of 2 the first part of the statement will be false anyway.

Which reminds me.  Why are we using fls again?  I don't see why we 
aren't just (zone_bits & value) the types.  It seems much easier to 
understand that way.

>  
> Index: zone_reclaim/include/linux/gfp.h
> ===================================================================
> --- zone_reclaim.orig/include/linux/gfp.h	2005-12-19 20:19:37.000000000 +0900
> +++ zone_reclaim/include/linux/gfp.h	2005-12-19 20:19:56.000000000 +0900
> @@ -81,7 +81,7 @@ struct vm_area_struct;
>  
>  static inline int gfp_zone(gfp_t gfp)
>  {
> -	int zone = GFP_ZONEMASK & (__force int) gfp;
> +	int zone = fls(GFP_ZONEMASK & (__force int) gfp);
>  	BUG_ON(zone >= GFP_ZONETYPES);
>  	return zone;
>  }
> 



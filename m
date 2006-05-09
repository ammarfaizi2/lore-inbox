Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWEIRw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWEIRw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 13:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWEIRw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 13:52:57 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:6253 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750790AbWEIRw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 13:52:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4gy44oCPZGTSaGCMbNytWaIZAxqxzz9Ezu/gtkk9ijz8SXQawzFfyGFpUCM9kps2U/7/wy0+oK6PxSGMP0k9hXFlBsmLwA0dlQpNHdIv792RsaDjNg42vu3gF81yoLyGztulIQFuKL9g2RbMknMNADFeqN9QQKjr0rM4Tfwj2Vs=  ;
Message-ID: <44607CF1.5080109@yahoo.com.au>
Date: Tue, 09 May 2006 21:28:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Dave Hansen <haveblue@us.ibm.com>, Bob Picco <bob.picco@hp.com>,
       Ingo Molnar <mingo@elte.hu>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 1/3] zone init check and report unaligned zone boundries
References: <exportbomb.1147172704@pinky> <20060509110520.GA9634@shadowen.org>
In-Reply-To: <20060509110520.GA9634@shadowen.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patchset looks nice, Andy. Page allocator stuff looks fine, just
a couple of questions about the setup and alignment stuff:

Andy Whitcroft wrote:
> zone init check and report unaligned zone boundries
> 
> We have a number of strict constraints on the layout of struct
> page's for use with the buddy allocator.  One of which is that zone
> boundries must occur at MAX_ORDER page boundries.  Add a check for
> this during init.
> 
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>
> ---
>  include/linux/mmzone.h |    5 +++++
>  mm/page_alloc.c        |    4 ++++
>  2 files changed, 9 insertions(+)
> diff -upN reference/include/linux/mmzone.h current/include/linux/mmzone.h
> --- reference/include/linux/mmzone.h
> +++ current/include/linux/mmzone.h
> @@ -388,6 +388,11 @@ static inline int is_dma(struct zone *zo
>  	return zone == zone->zone_pgdat->node_zones + ZONE_DMA;
>  }
>  
> +static inline unsigned long zone_boundry_align_pfn(unsigned long pfn)
> +{
> +	return pfn & ~((1 << MAX_ORDER) - 1);
> +}
> +
>  /* These two functions are used to setup the per zone pages min values */
>  struct ctl_table;
>  struct file;
> diff -upN reference/mm/page_alloc.c current/mm/page_alloc.c
> --- reference/mm/page_alloc.c
> +++ current/mm/page_alloc.c
> @@ -2078,6 +2078,10 @@ static void __init free_area_init_core(s
>  		struct zone *zone = pgdat->node_zones + j;
>  		unsigned long size, realsize;
>  
> +		if (zone_boundry_align_pfn(zone_start_pfn) != zone_start_pfn)
> +			printk(KERN_CRIT "node %d zone %s missaligned "
> +					"start pfn\n", nid, zone_names[j]);
> +


We also need to align the end of the zone I think? I think we should
try to force alignment by reducing the size here, or if that is not
possible, then panic?

If we don't either fix it or panic, then we're allowing users' machines
to run in an unstable state.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

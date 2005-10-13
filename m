Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVJMTHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVJMTHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVJMTHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:07:10 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:22433 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932158AbVJMTHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:07:08 -0400
Message-ID: <434EB058.8090809@austin.ibm.com>
Date: Thu, 13 Oct 2005 14:07:04 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: akpm@osdl.org, kravetz@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 6/8] Fragmentation Avoidance V17: 006_largealloc_tryharder
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie> <20051011151251.16178.24064.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051011151251.16178.24064.sendpatchset@skynet.csn.ul.ie>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 17, plus several versions I did while Mel was preoccupied with 
his day job, makes well over 20 times this has been posted to the mailing lists 
that are lkml, linux-mm, and memory hotplug.

All objections/feedback/suggestions that have been brought up on the lists are 
fixed in the following version.  It's starting to become almost silent when a 
new version gets posted, possibly because everybody accepts the code as perfect, 
possibly because they have grown bored with it.  Probably a combination of both.

I'm guessing the reason this code hasn't been merged yet is because nobody has 
really enumerated the benefits in awhile.  Here's my try at it

Benefits of merging:
1. Reduced Fragmentation
2. Better able to fulfill large allocations (see 1)
3. Less out of memory conditions (see 1)
3. Prereq for memory hotplug remove
4. Would be helpful for future development of active defragmentation
5. Also helpful for future development of demand fault allocating large pages

Downsides of merging:
It's been well tested on multiple architectures in multiple configurations, but 
non-trivial changes to core subsystems should not be done lightly.

> @@ -1203,8 +1204,19 @@ rebalance:
>  				goto got_pg;
>  		}
>  
> -		out_of_memory(gfp_mask, order);
> +		if (order < MAX_ORDER / 2)
> +			out_of_memory(gfp_mask, order);
> +		
> +		/*
> +		 * Due to low fragmentation efforts, we try a little
> +		 * harder to satisfy high order allocations and only
> +		 * go OOM for low-order allocations
> +		 */
> +		if (order >= MAX_ORDER/2 && --highorder_retry > 0)
> +				goto rebalance;
> +
>  		goto restart;
> +
>  	}

If order >= MAX_ORDER/2 it doesn't call out_of_memory().  The logic behind it is 
that we shouldn't go OOM for large-order allocations, because we aren't really 
OOM.  And if we can't satisfy these large allocations then killing processes 
should have little chance of helping.  Mel and I had discussed this privately, 
agreed, and it is reflected in the comment.

But it's a bit of a behavior change and I didn't want it to go unnoticed.  I 
guess the question is, should existing behavior of going OOM even for large 
order allocations be maintained?  Or is this change a better way, especially in 
light of the lower fragmentation and increased attempts, like we think it is?

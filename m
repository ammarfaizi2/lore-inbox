Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbVJ3AQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbVJ3AQq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVJ3AQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:16:46 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26555 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750818AbVJ3AQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:16:46 -0400
Date: Sat, 29 Oct 2005 17:16:30 -0700
From: Paul Jackson <pj@sgi.com>
To: "Rohit, Seth" <rohit.seth@intel.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
Message-Id: <20051029171630.04a69660.pj@sgi.com>
In-Reply-To: <20051028183326.A28611@unix-os.sc.intel.com>
References: <20051028183326.A28611@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth wroteL
> @@ -851,19 +853,11 @@
>  	 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
>  	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
>  	 */
> -	for (i = 0; (z = zones[i]) != NULL; i++) {
> -		if (!zone_watermark_ok(z, order, z->pages_min,
> -				       classzone_idx, can_try_harder,
> -				       gfp_mask & __GFP_HIGH))
> -			continue;
> -
> -		if (wait && !cpuset_zone_allowed(z, gfp_mask))
> -			continue;
> -
> -		page = buffered_rmqueue(z, order, gfp_mask);
> -		if (page)
> -			goto got_pg;
> -	}
> +	if (!wait)
> +		page = get_page_from_freelist(gfp_mask, order, zones, 
> +						can_try_harder);

Thanks for the clean-up work.  Good stuff.

I think you've changed the affect that the cpuset check has on the
above pass.

As you know, the above is the last chance we have for GFP_ATOMIC (can't
wait) allocations before getting into the oom_kill code.  The code had
been written to ignore cpuset constraints for GFP_ATOMIC (that is,
"!wait") allocations.  The intent is to allow taking GFP_ATOMIC memory
from any damn node we can find it on, rather than start killing.

Your change will call into get_page_from_freelist() in such cases,
where the cpuset check is still done.

I would be tempted instead to:
 1) pass 'can_try_harder' value of -1, instead of the the local value
    of 1 (which it certainly is, since we are in !wait code).
 2) condition the cpuset check in get_page_from_freelist() on
    can_try_harder being not equal to -1.

The item (2) -does- change the existing cpuset conditions as well,
allowing cpuset boundaries to be violated for the cases that would
"allow future memory freeing" (such as GFP_MEMALLOC or TIF_MEMDIE),
whereas until now, we did not allow violating cpuset conditions
for this.  But that is arguably a good change.

The following patch, on top of yours, shows what I have in mind here:

--- 2.6.14-rc5-mm1.orig/mm/page_alloc.c	2005-10-29 14:45:07.000000000 -0700
+++ 2.6.14-rc5-mm1/mm/page_alloc.c	2005-10-29 16:35:55.000000000 -0700
@@ -777,7 +777,7 @@ get_page_from_freelist(unsigned int __no
 	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
 	 */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
-		if (!cpuset_zone_allowed(z, gfp_mask))
+		if (can_try_harder != -1 && !cpuset_zone_allowed(z, gfp_mask))
 			continue;
 
 		if ((can_try_harder >= 0) && 
@@ -940,8 +940,7 @@ restart:
 	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
 	 */
 	if (!wait)
-		page = get_page_from_freelist(gfp_mask, order, zones, 
-						can_try_harder);
+		page = get_page_from_freelist(gfp_mask, order, zones, -1);
 	if (page)
 		goto got_pg;
 

However ...
 1) The above also would change __GFP_HIGH and rt allocations to also
    ignore mins entirely, instead of just going deeper into reserves,
    on this pass.  That is likely not good.
 2) I can't get my head wrapped around Nick's reply to this patch.

So my above patch is no doubt flawed in one or more ways.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

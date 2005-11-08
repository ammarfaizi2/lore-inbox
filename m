Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbVKHByL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVKHByL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVKHByL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:54:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964834AbVKHByK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:54:10 -0500
Date: Mon, 7 Nov 2005 17:53:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rohit, Seth" <rohit.seth@intel.com>
Cc: torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Cleanup of __alloc_pages
Message-Id: <20051107175358.62c484a3.akpm@osdl.org>
In-Reply-To: <20051107174349.A8018@unix-os.sc.intel.com>
References: <20051107174349.A8018@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rohit, Seth" <rohit.seth@intel.com> wrote:
>
> [PATCH]: Clean up of __alloc_pages. Couple of difference from original behavior:
> 	1- remove the initial reclaim logic
> 	2- GFP_HIGH pages are allowed to go little below watermark sooner.
> 	3- Search for free pages unconditionally after direct reclaim.

Would it be possible to break these into three separate patches?  The
cleanup part should be #1.

> +/* get_page_from_freeliest loops through all the possible zones
> + * to find out if it can allocate a page.  can_try_harder can have following
> + * values:
> + * -1 => No need to check for the watermarks.
> + *  0 => Don't go too low down in deeps below the low watermark (GFP_HIGH)
> + *  1 => Go far below the low watermark.  See zone_watermark_ok (RT TASK)
> + *
> + * cpuset check is not performed when the skip_cpuset_chk flag is set.
> + */
> +
> +static struct page *
> +get_page_from_freelist(gfp_t gfp_mask, unsigned int order, struct zone **zones, 
> +			int can_try_harder, int skip_cpuset_chk)
> +{
> +	struct zone *z;
> +	struct page *page = NULL;
> +	int classzone_idx = zone_idx(zones[0]);
> +	int i;
> +
> +	/*
> +	 * Go through the zonelist once, looking for a zone with enough free.
> +	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
> +	 */
> +	for (i = 0; (z = zones[i]) != NULL; i++) {
> +		if (!skip_cpuset_chk && (!cpuset_zone_allowed(z, gfp_mask)))

It'd be nice to not have the `skip_cpuset_chk' flag there.  a) it gives
Linus conniptions and b) it's a little extra overhead for !CONFIG_CPUSETS
kernels.

> -	zone_statistics(zonelist, z);
> +	zone_statistics(zonelist, page_zone(page));

Evaluating page_zone() is not completely trivial.  Can we avoid the above?

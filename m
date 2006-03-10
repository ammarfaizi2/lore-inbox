Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWCJWjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWCJWjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbWCJWjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:39:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13995 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750976AbWCJWjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:39:52 -0500
Date: Fri, 10 Mar 2006 14:35:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
Message-Id: <20060310143545.74a9a92a.akpm@osdl.org>
In-Reply-To: <200603102054.20077.kernel@kolivas.org>
References: <200603102054.20077.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> +	/*
> +	 * get_page_state is super expensive so we only perform it every
> +	 * SWAP_CLUSTER_MAX prefetched_pages.

nr_running() is similarly expensive btw.

> 	 * We also test if we're the only
> +	 * task running anywhere. We want to have as little impact on all
> +	 * resources (cpu, disk, bus etc). As this iterates over every cpu
> +	 * we measure this infrequently.
> +	 */
> +	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) {
> +		unsigned long cpuload = nr_running();
> +
> +		if (cpuload > 1)
> +			goto out;

Sorry, this is just wrong.  If swap prefetch is useful then it's also
useful if some task happens to be sitting over in the corner calculating
pi.

What's the actual problem here?  Someone's 3d game went blippy?  Why?  How
much?  Are we missing a cond_resched()?

> +		cpuload += nr_uninterruptible();
> +		if (cpuload > 1)
> +			goto out;

Not sure about this either.  


> +		if (ns->last_free) {
> +			if (ns->current_free + SWAP_CLUSTER_MAX <
> +				ns->last_free) {
> +					ns->last_free = ns->current_free;
>  					node_clear(node,
>  						sp_stat.prefetch_nodes);
>  					continue;
>  			}
>  		} else

That has an extra tabstop.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbTF1PyZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 11:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbTF1PyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 11:54:25 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:37380 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265265AbTF1PyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 11:54:24 -0400
Date: Sat, 28 Jun 2003 17:08:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm2
Message-ID: <20030628170837.A10514@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030627202130.066c183b.akpm@digeo.com> <20030628155436.GY20413@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030628155436.GY20413@holomorphy.com>; from wli@holomorphy.com on Sat, Jun 28, 2003 at 08:54:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 08:54:36AM -0700, William Lee Irwin III wrote:
> +config HIGHPMD
> +	bool "Allocate 2nd-level pagetables from highmem"
> +	depends on HIGHMEM64G
> +	help
> +	  The VM uses one pmd entry for each pagetable page of physical
> +	  memory allocated. For systems with extreme amounts of highmem,
> +	  this cannot be tolerated. Setting this option will put
> +	  userspace 2nd-level pagetables in highmem.

Does this make sense for !HIGHPTE?  In fact does it make sense to
carry along HIGHPTE as an option still? ..

> +#ifndef CONFIG_HIGHPMD /* Oh boy. Error reporting is going to blow major goats. */

Any chance you can rearragne the code to avoid the ifndef in favour
of an ifdef?

>  		set_pte(dst_pte, entry);
> +		pmd_unmap(dst_pte);
> +		pmd_unmap_nested(src_pte);

<Lots more pmd_unmap* calls snipped>

Looks like you changed some API so that pmds are now returned mapped?
It might make sense to change their names into foo_map then so the
breakage is at the API level if someone misses updates for the changes.

> +#ifdef CONFIG_HIGHPMD
> +#define	GFP_PMD		(__GFP_REPEAT|__GFP_HIGHMEM|GFP_KERNEL)
> +#else
> +#define GFP_PMD		(__GFP_REPEAT|GFP_KERNEL)
> +#endif

So what?  Do you want to use a space or tab after the #define? :)

Also Given that GFP_PMD is used just once it's argueable whether it makes
sense to get rid of the defintion and use the expanded values directly.


Otherwise the patch looks fine to me and should allow to get some more
free lowmem on those insanely big 32bit machines.. :)

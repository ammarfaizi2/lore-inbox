Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWD1Xbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWD1Xbv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 19:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWD1Xbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 19:31:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751122AbWD1Xbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 19:31:50 -0400
Date: Fri, 28 Apr 2006 16:34:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] catch valid mem range at onlining memory
Message-Id: <20060428163409.389e895e.akpm@osdl.org>
In-Reply-To: <20060428114732.e889ad2d.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060428114732.e889ad2d.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> This patch allows hot-add memory which is not aligned to section.
> Based on linux-2.6.17-rc2-mm1 + memory hotadd ioresource register patch.
> 
> iomem resource patch is here.
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0604.3/1188.html
> 
> Now, hot-added memory has to be aligned to section size.
> Considering big section sized archs, this is not useful.
> 
> When hot-added memory is registerd as iomem resoruce by iomem resource patch,
> we can make use of that information to detect valid memory range.
> 
> Note: With this, not-aligned memory can be registerd. To allow hot-add
>       memory with holes, we have to do more work around add_memory().
>       (It doesn't allows add memory to already existing mem section.)
>       
> 

Looks sane, thanks.

> +#ifdef CONFIG_MEMORY_HOTPLUG
> +/*
> + * Finds the lowest memory reosurce exists within [res->start.res->end)
> + * the caller must specify res->start, res->end, res->flags.
> + * If found, returns 0, res is overwritten, if not found, returns -1.
> + */
> +int find_next_system_ram(struct resource *res)
> +{
> +	u64 start, end;
> +	struct resource *p;
> +
> +	BUG_ON(!res);
> +
> +	start = res->start;
> +	end = res->end;
> +
> +	read_lock(&resource_lock);
> +	for( p = iomem_resource.child; p ; p = p->sibling) {
> +		/* system ram is just marked as IORESOURCE_MEM */
> +		if (p->flags != res->flags)
> +			continue;
> +		if (p->start > end) {
> +			p = NULL;
> +			break;
> +		}
> +		if (p->start >= start)
> +			break;
> +	}
> +	read_unlock(&resource_lock);
> +	if (!p)
> +		return -1;
> +	/* copy data */
> +	res->start = p->start;
> +	res->end = p->end;
> +	return 0;
> +}
> +
> +#endif

This all looks fairly (but trivially) dependent upon the 64-bit-resource
patches in Greg's tree.  Greg, were you planning on merging them in the
post-2.6.17 flood?

> ===================================================================
> --- linux-2.6.17-rc2-mm1.orig/include/linux/ioport.h	2006-04-27 18:00:16.000000000 +0900
> +++ linux-2.6.17-rc2-mm1/include/linux/ioport.h	2006-04-27 21:47:25.000000000 +0900
> @@ -105,6 +105,10 @@
>  			     void *alignf_data);
>  int adjust_resource(struct resource *res, u64 start,
>  		    u64 size);
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +/* get registered SYSTEM_RAM resources in specified area */
> +extern int find_next_system_ram(struct resource *res);
> +#endif

I'll remove the ifdefs - the only thing they give us if someone makes a
mistake is an additional compile-time warning, and I don't think that's
beneficial enough to warrant the addition of an ifdef.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWD1Xpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWD1Xpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 19:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWD1Xpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 19:45:42 -0400
Received: from cantor2.suse.de ([195.135.220.15]:58773 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964997AbWD1Xpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 19:45:42 -0400
Date: Fri, 28 Apr 2006 16:44:10 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] catch valid mem range at onlining memory
Message-ID: <20060428234410.GA7598@kroah.com>
References: <20060428114732.e889ad2d.kamezawa.hiroyu@jp.fujitsu.com> <20060428163409.389e895e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060428163409.389e895e.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 04:34:09PM -0700, Andrew Morton wrote:
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> >
> > This patch allows hot-add memory which is not aligned to section.
> > Based on linux-2.6.17-rc2-mm1 + memory hotadd ioresource register patch.
> > 
> > iomem resource patch is here.
> > http://www.uwsg.indiana.edu/hypermail/linux/kernel/0604.3/1188.html
> > 
> > Now, hot-added memory has to be aligned to section size.
> > Considering big section sized archs, this is not useful.
> > 
> > When hot-added memory is registerd as iomem resoruce by iomem resource patch,
> > we can make use of that information to detect valid memory range.
> > 
> > Note: With this, not-aligned memory can be registerd. To allow hot-add
> >       memory with holes, we have to do more work around add_memory().
> >       (It doesn't allows add memory to already existing mem section.)
> >       
> > 
> 
> Looks sane, thanks.
> 
> > +#ifdef CONFIG_MEMORY_HOTPLUG
> > +/*
> > + * Finds the lowest memory reosurce exists within [res->start.res->end)
> > + * the caller must specify res->start, res->end, res->flags.
> > + * If found, returns 0, res is overwritten, if not found, returns -1.
> > + */
> > +int find_next_system_ram(struct resource *res)
> > +{
> > +	u64 start, end;
> > +	struct resource *p;
> > +
> > +	BUG_ON(!res);
> > +
> > +	start = res->start;
> > +	end = res->end;
> > +
> > +	read_lock(&resource_lock);
> > +	for( p = iomem_resource.child; p ; p = p->sibling) {
> > +		/* system ram is just marked as IORESOURCE_MEM */
> > +		if (p->flags != res->flags)
> > +			continue;
> > +		if (p->start > end) {
> > +			p = NULL;
> > +			break;
> > +		}
> > +		if (p->start >= start)
> > +			break;
> > +	}
> > +	read_unlock(&resource_lock);
> > +	if (!p)
> > +		return -1;
> > +	/* copy data */
> > +	res->start = p->start;
> > +	res->end = p->end;
> > +	return 0;
> > +}
> > +
> > +#endif
> 
> This all looks fairly (but trivially) dependent upon the 64-bit-resource
> patches in Greg's tree.  Greg, were you planning on merging them in the
> post-2.6.17 flood?

Yes, I was, unless there are any objections to me doing this?

thanks,

greg k-h

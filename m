Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263752AbUFXD0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUFXD0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 23:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUFXD0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 23:26:25 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:18609 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263752AbUFXD0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 23:26:22 -0400
Subject: Re: [Lhns-devel] Merging Nonlinear and Numa style memory hotplug
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <ygoto@us.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Linux-Node-Hotplug <lhns-devel@lists.sourceforge.net>,
       linux-mm <linux-mm@kvack.org>,
       "BRADLEY CHRISTIANSEN [imap]" <bradc1@us.ibm.com>
In-Reply-To: <20040623184303.25D9.YGOTO@us.fujitsu.com>
References: <20040622114733.30A6.YGOTO@us.fujitsu.com>
	 <1088029973.28102.269.camel@nighthawk>
	 <20040623184303.25D9.YGOTO@us.fujitsu.com>
Content-Type: text/plain
Message-Id: <1088047565.3918.183.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 23 Jun 2004 20:26:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-23 at 20:04, Yasunori Goto wrote:

> > Can they be allocated elsewhere, instead
> > of directly inside the translation tables, or otherwise derived?  Also,
> > why does the booked/free_count have to be kept here?  Can't that be
> > determined by simply looping through and looking at all the pages'
> > flags?
> 
> It might be OK. But there might be some other influence by it 
> (for example, new lock will be necessary in alloc_pages()...).
> I think measurement is necessary to find which implementation
> is the fastest. If I will have a time, I would like to try it.

I'm pretty sure your current implementation is the faster of the two
approaches.  However, I think we should take a performance hit during
the hotplug operations in order to decrease the storage overhead.  It's
not like we'll be publishing benchmarks during remove operations...

> > Also, can you provide a patch which is just your modifications to Dave's
> > original nonlinear patch?
> 
> No, I don't have it (at least now).
> Base of my patches is Iwamoto-san's patch which is for 2.6.5.
> But Dave-san's patch is for linux-2.6.5-mm. So, I had to change
> Dave-san's patch for it.
> 
> And, other difference thing is about mem_map.
> Dave-san's patch divides virtual address of mem_map per mem_section.
> But it is cause of increasing steps at 'buddy allocator' like this.
>   
>   - buddy1 = base + (page_idx ^ -mask);
>   - buddy2 = base + page_idx;
>   + buddy1 = pfn_to_page(base + (page_idx ^ -mask);
>   + buddy2 = pfn_to_page(base + page_idx);
> 
> So, I would like to try contiguous virtual mem_map yet,
> if it is possible.

I'd love to see an implementation, but I'm not horribly sure how
feasible it is.  I think they use that approach on ia64 right now, and I
don't think it's very popular.

But, it could be interesting.  I'll be curious to see how it turns out.

> > Instead of remove_from_freelist(unsigned int section), I'd hope that we
> > could support a much more generic interface in the page allocator:
> > allocate by physical address.  remove_from_freelist() has some intimate
> > knowledge of the buddy allocator that I think is a bit complex.  
> 
> I don't think I understand your idea at this point.
> If booked pages remain in free_list, page allocator has to
> search many pages which include booked pages.
> remove_from_reelist() is to avoid this.

Oh, I like *that* part.  The first step in a "removal" is to allocate
the pages.  I'd just like to see that allocation be more based on pfns
or physical addresses than sections.  That's a much more generic
interface, and would be applicable to things outside of
CONFIG_NONLINEAR.  I'll post an example of this in a day or two.

-- Dave


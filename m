Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVCHGUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVCHGUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVCHGUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:20:16 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:11404 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261598AbVCHGS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:18:59 -0500
Date: Tue, 8 Mar 2005 11:58:27 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC] ext3/jbd race: releasing in-use journal_heads
Message-ID: <20050308062827.GA3756@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk> <20050304160451.4c33919c.akpm@osdl.org> <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk> <20050307123118.3a946bc8.akpm@osdl.org> <1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk> <20050307131113.0fd7477e.akpm@osdl.org> <1110230527.15117.625.camel@sisko.sctweedie.blueyonder.co.uk> <1110237205.15117.702.camel@sisko.sctweedie.blueyonder.co.uk> <20050307155001.099352b5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307155001.099352b5.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yup, looks like the same issue we hit in wait_on_page_writeback_range 
during AIO work  - probably want to break out of the outer loop as well
when this happens.

>From the old changelog:
>>
>> wait_on_page_writeback_range shouldn't wait for pages beyond the
>> specified range. Ideally, the radix-tree-lookup could accept an
>> end_index parameter so that it doesn't return the extra pages
>> in the first place, but for now we just add a few extra checks
>> to skip such pages.
>>

How hard would it be to add an end_index parameter to the radix tree
lookup, since we seem to be hitting this in multiple places ?

Regards
Suparna


On Mon, Mar 07, 2005 at 03:50:01PM -0800, Andrew Morton wrote:
> "Stephen C. Tweedie" <sct@redhat.com> wrote:
> >
> > In invalidate_inode_pages2_range(), what happens if we lookup a pagevec,
> > get a bunch of pages back, but all the pages in the vec are beyond the
> > end of the range we want?
> 
> hmm, yes.  Another one :(
> 
> > @@ -271,12 +271,13 @@ int invalidate_inode_pages2_range(struct
> >  			int was_dirty;
> >  
> >  			lock_page(page);
> > +			if (page->mapping == mapping)
> > +				next = page->index + 1;
> >  			if (page->mapping != mapping || page->index > end) {
> >  				unlock_page(page);
> >  				continue;
> >  			}
> >  			wait_on_page_writeback(page);
> > -			next = page->index + 1;
> >  			if (next == 0)
> >  				wrapped = 1;
> >  			while (page_mapped(page)) {
> 
> truncate_inode_pages_range() seems to dtrt here.  Can we do it in the same
> manner in invalidate_inode_pages2_range()?
> 
> 
> Something like:
> 
> 
> diff -puN mm/truncate.c~invalidate_inode_pages2_range-livelock-fix mm/truncate.c
> --- 25/mm/truncate.c~invalidate_inode_pages2_range-livelock-fix	Mon Mar  7 15:47:25 2005
> +++ 25-akpm/mm/truncate.c	Mon Mar  7 15:49:09 2005
> @@ -305,15 +305,22 @@ int invalidate_inode_pages2_range(struct
>  			min(end - next, (pgoff_t)PAGEVEC_SIZE - 1) + 1)) {
>  		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
>  			struct page *page = pvec.pages[i];
> +			pgoff_t page_index;
>  			int was_dirty;
>  
>  			lock_page(page);
> -			if (page->mapping != mapping || page->index > end) {
> +			page_index = page->index;
> +			if (page_index > end) {
> +				next = page_index;
> +				unlock_page(page);
> +				break;
> +			}
> +			if (page->mapping != mapping) {
>  				unlock_page(page);
>  				continue;
>  			}
>  			wait_on_page_writeback(page);
> -			next = page->index + 1;
> +			next = page_index + 1;
>  			if (next == 0)
>  				wrapped = 1;
>  			while (page_mapped(page)) {
> @@ -323,7 +330,7 @@ int invalidate_inode_pages2_range(struct
>  					 */
>  					unmap_mapping_range(mapping,
>  					    page->index << PAGE_CACHE_SHIFT,
> -					    (end - page->index + 1)
> +					    (end - page_index + 1)
>  							<< PAGE_CACHE_SHIFT,
>  					    0);
>  					did_range_unmap = 1;
> @@ -332,7 +339,7 @@ int invalidate_inode_pages2_range(struct
>  					 * Just zap this page
>  					 */
>  					unmap_mapping_range(mapping,
> -					  page->index << PAGE_CACHE_SHIFT,
> +					  page_index << PAGE_CACHE_SHIFT,
>  					  PAGE_CACHE_SIZE, 0);
>  				}
>  			}
> _
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


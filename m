Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVCHGaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVCHGaC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVCHGaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:30:02 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:2452 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261387AbVCHG3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:29:32 -0500
Date: Tue, 8 Mar 2005 12:09:09 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC] ext3/jbd race: releasing in-use journal_heads
Message-ID: <20050308063909.GA3878@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1109966084.5309.3.camel@sisko.sctweedie.blueyonder.co.uk> <20050304160451.4c33919c.akpm@osdl.org> <1110213656.15117.193.camel@sisko.sctweedie.blueyonder.co.uk> <20050307123118.3a946bc8.akpm@osdl.org> <1110229687.15117.612.camel@sisko.sctweedie.blueyonder.co.uk> <20050307131113.0fd7477e.akpm@osdl.org> <1110230527.15117.625.camel@sisko.sctweedie.blueyonder.co.uk> <1110237205.15117.702.camel@sisko.sctweedie.blueyonder.co.uk> <20050307155001.099352b5.akpm@osdl.org> <20050308062827.GA3756@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308062827.GA3756@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Just as an idea of what I meant (dug up an old WIP patch):

--- radix-tree.c	2004-04-01 10:32:15.384556136 +0530
+++ radix-tree.c.end	2004-04-01 11:11:07.176069944 +0530
@@ -562,7 +562,8 @@ EXPORT_SYMBOL(radix_tree_gang_lookup);
  */
 static unsigned int
 __lookup_tag(struct radix_tree_root *root, void **results, unsigned long index,
-	unsigned int max_items, unsigned long *next_index, int tag)
+	unsigned long max_index, unsigned int max_items,
+	unsigned long *next_index, int tag)
 {
 	unsigned int nr_found = 0;
 	unsigned int shift;
@@ -596,7 +597,8 @@ __lookup_tag(struct radix_tree_root *roo
 				if (tag_get(slot, tag, j)) {
 					BUG_ON(slot->slots[j] == NULL);
 					results[nr_found++] = slot->slots[j];
-					if (nr_found == max_items)
+					if ((nr_found == max_items) || 
+						(index > max_index))
 						goto out;
 				}
 			}
@@ -624,12 +626,15 @@ out:
  */
 unsigned int
 radix_tree_gang_lookup_tag(struct radix_tree_root *root, void **results,
-		unsigned long first_index, unsigned int max_items, int tag)
+		unsigned long first_index, unsigned long end_index,
+		unsigned int max_items, int tag)
 {
 	const unsigned long max_index = radix_tree_maxindex(root->height);
 	unsigned long cur_index = first_index;
 	unsigned int ret = 0;
 
+	if (max_index > end_index)
+		max_index = end_index;
 	while (ret < max_items) {
 		unsigned int nr_found;
 		unsigned long next_index;	/* Index of next search */
@@ -637,7 +642,8 @@ radix_tree_gang_lookup_tag(struct radix_
 		if (cur_index > max_index)
 			break;
 		nr_found = __lookup_tag(root, results + ret, cur_index,
-					max_items - ret, &next_index, tag);
+					max_index, max_items - ret, 
+					&next_index, tag);
 		ret += nr_found;
 		if (next_index == 0)
 			break;


On Tue, Mar 08, 2005 at 11:58:27AM +0530, Suparna Bhattacharya wrote:
> 
> yup, looks like the same issue we hit in wait_on_page_writeback_range 
> during AIO work  - probably want to break out of the outer loop as well
> when this happens.
> 
> From the old changelog:
> >>
> >> wait_on_page_writeback_range shouldn't wait for pages beyond the
> >> specified range. Ideally, the radix-tree-lookup could accept an
> >> end_index parameter so that it doesn't return the extra pages
> >> in the first place, but for now we just add a few extra checks
> >> to skip such pages.
> >>
> 
> How hard would it be to add an end_index parameter to the radix tree
> lookup, since we seem to be hitting this in multiple places ?
> 
> Regards
> Suparna
> 
> 
> On Mon, Mar 07, 2005 at 03:50:01PM -0800, Andrew Morton wrote:
> > "Stephen C. Tweedie" <sct@redhat.com> wrote:
> > >
> > > In invalidate_inode_pages2_range(), what happens if we lookup a pagevec,
> > > get a bunch of pages back, but all the pages in the vec are beyond the
> > > end of the range we want?
> > 
> > hmm, yes.  Another one :(
> > 
> > > @@ -271,12 +271,13 @@ int invalidate_inode_pages2_range(struct
> > >  			int was_dirty;
> > >  
> > >  			lock_page(page);
> > > +			if (page->mapping == mapping)
> > > +				next = page->index + 1;
> > >  			if (page->mapping != mapping || page->index > end) {
> > >  				unlock_page(page);
> > >  				continue;
> > >  			}
> > >  			wait_on_page_writeback(page);
> > > -			next = page->index + 1;
> > >  			if (next == 0)
> > >  				wrapped = 1;
> > >  			while (page_mapped(page)) {
> > 
> > truncate_inode_pages_range() seems to dtrt here.  Can we do it in the same
> > manner in invalidate_inode_pages2_range()?
> > 
> > 
> > Something like:
> > 
> > 
> > diff -puN mm/truncate.c~invalidate_inode_pages2_range-livelock-fix mm/truncate.c
> > --- 25/mm/truncate.c~invalidate_inode_pages2_range-livelock-fix	Mon Mar  7 15:47:25 2005
> > +++ 25-akpm/mm/truncate.c	Mon Mar  7 15:49:09 2005
> > @@ -305,15 +305,22 @@ int invalidate_inode_pages2_range(struct
> >  			min(end - next, (pgoff_t)PAGEVEC_SIZE - 1) + 1)) {
> >  		for (i = 0; !ret && i < pagevec_count(&pvec); i++) {
> >  			struct page *page = pvec.pages[i];
> > +			pgoff_t page_index;
> >  			int was_dirty;
> >  
> >  			lock_page(page);
> > -			if (page->mapping != mapping || page->index > end) {
> > +			page_index = page->index;
> > +			if (page_index > end) {
> > +				next = page_index;
> > +				unlock_page(page);
> > +				break;
> > +			}
> > +			if (page->mapping != mapping) {
> >  				unlock_page(page);
> >  				continue;
> >  			}
> >  			wait_on_page_writeback(page);
> > -			next = page->index + 1;
> > +			next = page_index + 1;
> >  			if (next == 0)
> >  				wrapped = 1;
> >  			while (page_mapped(page)) {
> > @@ -323,7 +330,7 @@ int invalidate_inode_pages2_range(struct
> >  					 */
> >  					unmap_mapping_range(mapping,
> >  					    page->index << PAGE_CACHE_SHIFT,
> > -					    (end - page->index + 1)
> > +					    (end - page_index + 1)
> >  							<< PAGE_CACHE_SHIFT,
> >  					    0);
> >  					did_range_unmap = 1;
> > @@ -332,7 +339,7 @@ int invalidate_inode_pages2_range(struct
> >  					 * Just zap this page
> >  					 */
> >  					unmap_mapping_range(mapping,
> > -					  page->index << PAGE_CACHE_SHIFT,
> > +					  page_index << PAGE_CACHE_SHIFT,
> >  					  PAGE_CACHE_SIZE, 0);
> >  				}
> >  			}
> > _
> > 
> > 
> > 
> > -------------------------------------------------------
> > SF email is sponsored by - The IT Product Guide
> > Read honest & candid reviews on hundreds of IT Products from real users.
> > Discover which products truly live up to the hype. Start reading now.
> > http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> > _______________________________________________
> > Ext2-devel mailing list
> > Ext2-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ext2-devel
> 
> -- 
> Suparna Bhattacharya (suparna@in.ibm.com)
> Linux Technology Center
> IBM Software Lab, India
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


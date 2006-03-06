Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752366AbWCFKDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbWCFKDb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 05:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbWCFKDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 05:03:31 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:25547 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750935AbWCFKDa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 05:03:30 -0500
Date: Mon, 6 Mar 2006 15:33:21 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: christoph <hch@lst.de>, mcao@us.ibm.com, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, vs@namesys.com,
       zam@namesys.com
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and mpage_readpages()
Message-ID: <20060306100321.GA27319@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com> <20060222151216.GA22946@lst.de> <1140801549.22756.195.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140801549.22756.195.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 09:19:08AM -0800, Badari Pulavarty wrote:
> On Wed, 2006-02-22 at 16:12 +0100, christoph wrote:
> ..
> > Thanks Badari, with that interface changes the mpage_readpage changes
> > look a lot nicer than my original version.  I'd like to second
> > the request to put it into -mm. 
> > 
> > And if the namesys folks could try out whether this works for their
> > reiser4 requirements it'd be nice.  If you have an even faster
> > ->readpages I'd be interested in that secrete souce receipe for
> > further improvement to mpage_readpages.
> 
> I don't have any secret receipes, but I was thinking of re-organizing
> the code a little. Complexity is due to "confused" case and 
> "blocksize < pagesize" cases + going in-and-out of the worker routine
> with stored state.
> 
> I am thinking of having a "fast path" which doesn't deal with any
> of those and "slow" path to deal with all that non-sense.
> Something like ..
> 
> mpage_readpages()
> {
> 	if (block-size < page-size)
> 		slow_path;
> 
> 	while (nr-pages) {
> 		if (get_block(bh)) 
> 			slow_path;
> 		if (uptodate(bh))
> 			slow_path;
> 		while (bh.b_size) {
> 			if (not contig)
> 				submit bio();
> 			add all the pages we can to bio();
> 			bh.b_size -= size-of-pages-added;
> 			nr_pages -= count-of-pages-added;
> 		}
> 
> 	}
> }
> 
> slow_path is going to be slow & ugly. How important is to handle
> 1k, 2k filesystems efficiently ? Should I try ?

With 64K page size that could include 4K, 8K, 16K, 32K block size filesystems
as well, not sure how likely that would be ?

Regards
Suparna

> 	
> Thanks,
> Badari
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


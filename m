Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWBXRRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWBXRRw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 12:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWBXRRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 12:17:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:32148 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932154AbWBXRRv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 12:17:51 -0500
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and
	mpage_readpages()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: christoph <hch@lst.de>
Cc: mcao@us.ibm.com, akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, vs@namesys.com,
       zam@namesys.com
In-Reply-To: <20060222151216.GA22946@lst.de>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060222151216.GA22946@lst.de>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 09:19:08 -0800
Message-Id: <1140801549.22756.195.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 16:12 +0100, christoph wrote:
..
> Thanks Badari, with that interface changes the mpage_readpage changes
> look a lot nicer than my original version.  I'd like to second
> the request to put it into -mm. 
> 
> And if the namesys folks could try out whether this works for their
> reiser4 requirements it'd be nice.  If you have an even faster
> ->readpages I'd be interested in that secrete souce receipe for
> further improvement to mpage_readpages.

I don't have any secret receipes, but I was thinking of re-organizing
the code a little. Complexity is due to "confused" case and 
"blocksize < pagesize" cases + going in-and-out of the worker routine
with stored state.

I am thinking of having a "fast path" which doesn't deal with any
of those and "slow" path to deal with all that non-sense.
Something like ..

mpage_readpages()
{
	if (block-size < page-size)
		slow_path;

	while (nr-pages) {
		if (get_block(bh)) 
			slow_path;
		if (uptodate(bh))
			slow_path;
		while (bh.b_size) {
			if (not contig)
				submit bio();
			add all the pages we can to bio();
			bh.b_size -= size-of-pages-added;
			nr_pages -= count-of-pages-added;
		}

	}
}

slow_path is going to be slow & ugly. How important is to handle
1k, 2k filesystems efficiently ? Should I try ?
	
Thanks,
Badari


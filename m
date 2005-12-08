Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVLHSSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVLHSSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 13:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVLHSSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 13:18:37 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:2533 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S932101AbVLHSSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 13:18:36 -0500
Message-ID: <439878E4.6060505@cs.wisc.edu>
Date: Thu, 08 Dec 2005 12:18:12 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       open-iscsi@googlegroups.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: allowed pages in the block later, was Re: [Ext2-devel] [PATCH]
 ext3: avoid sending down non-refcounted pages
References: <20051208180900T.fujita.tomonori@lab.ntt.co.jp> <20051208101833.GM14509@schatzie.adilger.int> <20051208134239.GA13376@infradead.org>
In-Reply-To: <20051208134239.GA13376@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Dec 08, 2005 at 03:18:33AM -0700, Andreas Dilger wrote:
> 
>>What happens on 1kB or 2kB block filesystems (i.e. b_size != PAGE_SIZE)?
>>This will allocate a whole page for each block (which may be considerable
>>overhead on e.g. a 64kB PAGE_SIZE ia64 or PPC system).
> 
> 
> Yes.  How often do we trigger this codepath?
> 
> The problem we're trying to solve here is how do implement network block
> devices (nbd, iscsi) efficiently.  The zero copy codepath in the networking
> layer does need to grab additional references to pages.  So to use sendpage
> we need a refcountable page.  pages used by the slab allocator are not
> normally refcounted so try to do get_page/pub_page on them will break.
> 
> One way to work around that would be to detect kmalloced pages and use
> a slowpath for that.  The major issues with that is that we don't have a
> reliable way to detect if a given struct page comes from the slab allocator
> or not.  The minor problem is that even with such an indicator it means
> having a separate and lightly tested slowpath for this rare case.
> 
> All in all I think we should document that the block layer only accepts
> properly refcounted pages, which is everything but kmalloced pages (even
> vmalloc is totally fine)

Is it anytime kmalloc is used? For scsi when it uses scsi_execute* for 
something like scanning (report luns result is kmallocd) would this be a 
problem?

If PageSlab() does work, then could we have a request queue flag that 
bounces those pages for all block layer drivers. Pretty slow and yucky 
but if we have to convert SCSI and maybe other parts of the block layer 
maybe it will be easiest for now.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263394AbRFEWVz>; Tue, 5 Jun 2001 18:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263392AbRFEWVp>; Tue, 5 Jun 2001 18:21:45 -0400
Received: from quasar.osc.edu ([192.148.249.15]:5780 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S263394AbRFEWV2>;
	Tue, 5 Jun 2001 18:21:28 -0400
Date: Tue, 5 Jun 2001 18:21:20 -0400
From: Pete Wyckoff <pw@osc.edu>
To: Dan Maas <dmaas@dcine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forcibly unmap pages in driver?
Message-ID: <20010605182120.F23799@osc.edu>
In-Reply-To: <04ea01c0ed67$ad3f38f0$0701a8c0@morph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ea01c0ed67$ad3f38f0$0701a8c0@morph>; from dmaas@dcine.com on Mon, Jun 04, 2001 at 10:31:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmaas@dcine.com said:
> I am writing a device driver that, like many others, exposes a shared memory
> region to user-space via mmap(). The region is allocated with vmalloc(), the
> pages are marked reserved, and the user-space mapping is implemented with
> remap_page_range().
> 
> In my driver, I may have to free the underlying vmalloc() region while the
> user-space program is still running. I need to remove the user-space
> mapping -- otherwise the user process would still have access to the
> now-freed pages. I need an inverse of remap_page_range().
> 
> Is zap_page_range() the function I am looking for? Unfortunately it's not
> exported to modules =(. As a quick fix, I was thinking I could just remap
> all of the user pages to point to a zeroed page or something...
> 
> Another question- in the mm.c sources, I see that many of the memory-mapping
> functions are surrounded by calls to flush_cache_range() and
> flush_tlb_range(). But I don't see these calls in many drivers. Is it
> necessary to make them when my driver maps or unmaps the shared memory
> region?

That seems a bit perverse.  How will the poor userspace program know
not to access the pages you have yanked away from it?  If you plan
to kill it, better to do that directly.  If you plan to signal it
that the mapping is gone, it can just call munmap() itself.

However, do_munmap() will call zap_page_range() for you and take care of
cache and TLB flushing if you're going to do this in the kernel.

Your driver mmap function is called by do_mmap_pgoff() which takes
care of those issues, and there is no (*munmap) in file_operations---
perhaps you are the first driver writer to want to unmap in the kernel.

		-- Pete

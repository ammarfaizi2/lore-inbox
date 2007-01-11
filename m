Return-Path: <linux-kernel-owner+w=401wt.eu-S1751521AbXAKVkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbXAKVkq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 16:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbXAKVkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 16:40:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:35306 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751518AbXAKVkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 16:40:45 -0500
Date: Fri, 12 Jan 2007 08:39:16 +1100
From: David Chinner <dgc@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sami Farin <7atbggg02@sneakemail.com>, David Chinner <dgc@sgi.com>,
       xfs-masters@oss.sgi.com
Subject: Re: 2.6.20-rc4: known regressions with patches (v3)
Message-ID: <20070111213916.GE33919298@melbourne.sgi.com>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <20070111051329.GB21724@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111051329.GB21724@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 06:13:29AM +0100, Adrian Bunk wrote:
> This email lists some known regressions in 2.6.20-rc4 compared to 2.6.19
> with patches available.
> 
> Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (XFS)
> References : http://lkml.org/lkml/2007/1/5/308
> Submitter  : Sami Farin <7atbggg02@sneakemail.com>
> Handled-By : David Chinner <dgc@sgi.com>
> Patch      : http://lkml.org/lkml/2007/1/7/201
> Status     : patch available

Patch is broken, do not merge. The original had an off-by-one bug in
it, and the fixed one I have has just shown a worse problem than
before - partial page truncation (i.e.  filesystem block size less
than page size) is busted because invalidate_complete_page2_range() can
only handle complete pages.

Andrew - looking at unmap_mapping_pages, it says it cannot handle
partial pages and must get rid of them whereas vmtrucate() handles
partial pages but changes file size so can't be used. I see that
vmtruncate handles this by not unmapping the first partial page.

I can use the vmtruncate mechanism (unmap_mapping_pages, then
truncate_inode_pages) but that seems racy to me because we are not
actually truncating the file so a mmap could remap a page between
the unmap and the truncate and hence we still get the warning.

So the question is - is there any generic function that handles
this case (i.e. don't unmap first partial page, unmap the rest,
partial truncate of first page, complete truncate of the rest)
without racing? Or do I need to write a variation of
invalidate_inode_pages2_range() to do this?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group

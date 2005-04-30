Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVD3PwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVD3PwF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 11:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVD3Pv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 11:51:59 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:51102 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261261AbVD3Pvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 11:51:38 -0400
Date: Sat, 30 Apr 2005 21:30:53 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC] Adding multiple block allocation
Message-ID: <20050430160053.GA3941@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk> <1113288087.4319.49.camel@localhost.localdomain> <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk> <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com> <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk> <1114207837.7339.50.camel@localhost.localdomain> <1114659912.16933.5.camel@mindpipe> <1114715665.18996.29.camel@localhost.localdomain> <20050429135211.GA4539@in.ibm.com> <1114794608.10473.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114794608.10473.18.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 10:10:08AM -0700, Mingming Cao wrote:
> On Fri, 2005-04-29 at 19:22 +0530, Suparna Bhattacharya wrote:
> > On Thu, Apr 28, 2005 at 12:14:24PM -0700, Mingming Cao wrote:
> > > Currently ext3_get_block()/ext3_new_block() only allocate one block at a
> > > time.  To allocate multiple blocks, the caller, for example, ext3 direct
> > > IO routine, has to invoke ext3_get_block() many times.  This is quite
> > > inefficient for sequential IO workload. 
> > > 
> > > The benefit of a real get_blocks() include
> > > 1) increase the possibility to get contiguous blocks, reduce possibility
> > > of  fragmentation due to interleaved allocations from other threads.
> > > (should good for non reservation case)
> > > 2) Reduces CPU cycles spent in repeated get_block() calls
> > > 3) Batch meta data update and journaling in one short
> > > 4) Could possibly speed up future get_blocks() look up by cache the last
> > > mapped blocks in inode.
> > > 
> > 
> > And here is the patch to make mpage_writepages use get_blocks() for
> > multiple block lookup/allocation. It performs a radix-tree contiguous 
> > pages lookup, and issues a get_blocks for the range together. It maintains
> > an mpageio structure to track intermediate mapping state, somewhat
> > like the DIO code.
> > 
> > It does need some more testing, especially block_size < PAGE_SIZE.
> > The JFS workaround can be dropped if the JFS get_blocks fix from
> > Dave Kleikamp is integrated.
> > 
> > Review feedback would be welcome.
> > 
> > Mingming,
> > Let me know if you have a chance to try this out with your patch.
> 
> 
> Sure, Suparna, I will try your patch soon!
> 
> In my patch,  I have modified ext3 directo io code to make use of
> ext3_get_blocks(). Tested with a simple file write with O_DIRECT, seems
> work fine! Allocating blocks for a 120k file only invokes
> ext3_get_blocks() for 4 times(perfect is 1, but before is 30 times call
> to ext3_get_block). Among the 4 calls to ext3_get_blocks, 2 because of
> reach the meta data block boundary(direct ->indirect), another 2 because
> of reach the end of the reservation window. For the later 2, we could
> avoid that by extend the reservation window before calling
> ext3_new_blocks() if the window size is less than the number of blocks
> to allocate.
> 
> But if it try to allocating blocks in the hole (with direct IO), blocks
> are allocated one by one. I am looking at it right now.

That is expected, because DIO falls back to using buffered IO for
overwriting holes. This is to avoid some tricky races between DIO
and buffered IO that could otherwise have led to exposure of
stale data.

Regards
Suparna

> 
> Thanks,
> Mingming
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


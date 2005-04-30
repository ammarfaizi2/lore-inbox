Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVD3Qn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVD3Qn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 12:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVD3QnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 12:43:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:44726 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261283AbVD3QnA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 12:43:00 -0400
Date: Sat, 30 Apr 2005 22:22:16 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Mingming Cao <cmm@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC] Adding multiple block allocation
Message-ID: <20050430165216.GD3941@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk> <1113288087.4319.49.camel@localhost.localdomain> <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk> <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com> <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk> <1114207837.7339.50.camel@localhost.localdomain> <1114659912.16933.5.camel@mindpipe> <1114715665.18996.29.camel@localhost.localdomain> <20050429135211.GA4539@in.ibm.com> <427280C1.8090404@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427280C1.8090404@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 11:45:21AM -0700, Badari Pulavarty wrote:
> Suparna Bhattacharya wrote:
> >On Thu, Apr 28, 2005 at 12:14:24PM -0700, Mingming Cao wrote:
> >
> >>Currently ext3_get_block()/ext3_new_block() only allocate one block at a
> >>time.  To allocate multiple blocks, the caller, for example, ext3 direct
> >>IO routine, has to invoke ext3_get_block() many times.  This is quite
> >>inefficient for sequential IO workload. 
> >>
> >>The benefit of a real get_blocks() include
> >>1) increase the possibility to get contiguous blocks, reduce possibility
> >>of  fragmentation due to interleaved allocations from other threads.
> >>(should good for non reservation case)
> >>2) Reduces CPU cycles spent in repeated get_block() calls
> >>3) Batch meta data update and journaling in one short
> >>4) Could possibly speed up future get_blocks() look up by cache the last
> >>mapped blocks in inode.
> >>
> >
> >
> >And here is the patch to make mpage_writepages use get_blocks() for
> >multiple block lookup/allocation. It performs a radix-tree contiguous 
> >pages lookup, and issues a get_blocks for the range together. It maintains
> >an mpageio structure to track intermediate mapping state, somewhat
> >like the DIO code.
> >
> >It does need some more testing, especially block_size < PAGE_SIZE.
> >The JFS workaround can be dropped if the JFS get_blocks fix from
> >Dave Kleikamp is integrated.
> >
> >Review feedback would be welcome.
> >
> >Mingming,
> >Let me know if you have a chance to try this out with your patch.
> >
> >Regards
> >Suparna
> >
> 
> Suparna,
> 
> I touch tested your patch earlier and seems to work fine. Lets integrate
> Mingming's getblocks() patches with this and see if we get any benifit
> from the whole effort.
> 
> BTW,  is it the plan to remove repeated calls to getblocks() and work
> with whatever getblocks() returned ? Or do you find the its better to
> repeatedly do getblocks() in a loop till you satisfy all the pages
> in the list (as long as blocks are contiguous) ?

The patch only loops through repeated get_blocks upto PAGE_SIZE, just
like the earlier mpage_writepage code - in this case if blocks aren't
contiguous at least upto PAGE_SIZE, it would fall back to confused case
(since it means multiple ios for the same page) just as before. 
What is new now is just the numblocks specified to get_blocks, so in
case it gets more contiguous blocks it can remember that mapping and 
avoid get_blocks calls for subsequent pages.

Does that clarify ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India


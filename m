Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262881AbVD2Spk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbVD2Spk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 14:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVD2Spk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 14:45:40 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:23271 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262881AbVD2Sp0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 14:45:26 -0400
Message-ID: <427280C1.8090404@us.ibm.com>
Date: Fri, 29 Apr 2005 11:45:21 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: Mingming Cao <cmm@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC] Adding multiple block allocation
References: <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk> <1113244710.4413.38.camel@localhost.localdomain> <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk> <1113288087.4319.49.camel@localhost.localdomain> <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk> <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com> <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk> <1114207837.7339.50.camel@localhost.localdomain> <1114659912.16933.5.camel@mindpipe> <1114715665.18996.29.camel@localhost.localdomain> <20050429135211.GA4539@in.ibm.com>
In-Reply-To: <20050429135211.GA4539@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:
> On Thu, Apr 28, 2005 at 12:14:24PM -0700, Mingming Cao wrote:
> 
>>Currently ext3_get_block()/ext3_new_block() only allocate one block at a
>>time.  To allocate multiple blocks, the caller, for example, ext3 direct
>>IO routine, has to invoke ext3_get_block() many times.  This is quite
>>inefficient for sequential IO workload. 
>>
>>The benefit of a real get_blocks() include
>>1) increase the possibility to get contiguous blocks, reduce possibility
>>of  fragmentation due to interleaved allocations from other threads.
>>(should good for non reservation case)
>>2) Reduces CPU cycles spent in repeated get_block() calls
>>3) Batch meta data update and journaling in one short
>>4) Could possibly speed up future get_blocks() look up by cache the last
>>mapped blocks in inode.
>>
> 
> 
> And here is the patch to make mpage_writepages use get_blocks() for
> multiple block lookup/allocation. It performs a radix-tree contiguous 
> pages lookup, and issues a get_blocks for the range together. It maintains
> an mpageio structure to track intermediate mapping state, somewhat
> like the DIO code.
> 
> It does need some more testing, especially block_size < PAGE_SIZE.
> The JFS workaround can be dropped if the JFS get_blocks fix from
> Dave Kleikamp is integrated.
> 
> Review feedback would be welcome.
> 
> Mingming,
> Let me know if you have a chance to try this out with your patch.
> 
> Regards
> Suparna
> 

Suparna,

I touch tested your patch earlier and seems to work fine. Lets integrate
Mingming's getblocks() patches with this and see if we get any benifit
from the whole effort.

BTW,  is it the plan to remove repeated calls to getblocks() and work
with whatever getblocks() returned ? Or do you find the its better to
repeatedly do getblocks() in a loop till you satisfy all the pages
in the list (as long as blocks are contiguous) ?

Thanks,
Badari


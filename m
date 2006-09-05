Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWIEVw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWIEVw0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 17:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWIEVw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 17:52:26 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:29152 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751508AbWIEVwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 17:52:25 -0400
Message-ID: <44FDF16D.8040505@us.ibm.com>
Date: Tue, 05 Sep 2006 14:51:41 -0700
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: Badari Pulavarty <pbadari@us.ibm.com>,
       Badari Pulavarty <pbadari@gmail.com>,
       Will Simoneau <simoneau@ele.uri.edu>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
References: <20060905171049.GB27433@ele.uri.edu>	 <1157479756.23501.18.camel@dyn9047017100.beaverton.ibm.com>	 <1157482632.19432.6.camel@kleikamp.austin.ibm.com>	 <44FDDA89.7080207@us.ibm.com> <1157491179.19432.11.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1157491179.19432.11.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp wrote:
> On Tue, 2006-09-05 at 13:14 -0700, Badari Pulavarty wrote:
> 
>>Dave Kleikamp wrote:
> 
> 
>>>I'm having a hard time figuring out exactly what ext3_get_blocks_handle
>>>is trying to return, but it looks to me like if it is allocating one
>>>data block, and needs to allocate an indirect block as well, then it
>>>will return 2 rather than 1.  Is this expected, or am I just confused?
>>>
>>>  
>>
>>It would return "1" in that case.. (data block)
>>
>> > 0 means get_block() suceeded and indicates the number of blocks mapped
>>= 0 lookup failed
>>< 0 mean error case
> 
> 
> Okay, I got confused looking through the code.  I still don't see how
> ext3_get_blocks_handle() should be returning a number greater than
> maxblocks.
> 

yes ext3_get_blocks_handle() will return the number of data blocks 
allocated(not including the indirect/double indirecto blocks), and that 
number should not than maxblocks. In this case, it should return 1 instead.

The ext3_get_blocks_handle() behavior was changed when multiple blocks 
map/allocation was added to ext3 via this function. Previously, the 
behavior of ext3_get_blokc_handle() returns 0 for success case, and 
returns non-zero(nagive) for error case. While with new behavior, the 
success case is the thre returned value should > 0.

How many blocks is being mapped in this case? > 1? or 0? If it failed to 
map the block (ext3_get_blocks_handle() returns 0), ext3_getblk() will 
also WARN_ON().

> 
>>>>I did search for callers of ext3_get_blocks_handle() and found that
>>>>ext3_readdir() seems to do wrong thing all the time with error check :(
>>>>Need to take a closer look..
>>>>
>>>>	err = ext3_get_blocks_handle(NULL, inode, blk, 1,
>>>>                                                &map_bh, 0, 0);
>>>>        if (err > 0) {  <<<< BAD
>>>>                  page_cache_readahead(sb->s_bdev->bd_inode->i_mapping,
>>>>                                &filp->f_ra,
>>>>                                filp,
>>>>                                map_bh.b_blocknr >>
>>>>                                (PAGE_CACHE_SHIFT - inode->i_blkbits),
>>>>                                1);
>>>>                        bh = ext3_bread(NULL, inode, blk, 0, &err);
>>>>       }
>>>>    
>>>
>>>Bad to do what it's doing, or bad to call name the variable "err"?
>>>I think if it looked like this:
>>>
>>>	count = ext3_get_blocks_handle(NULL, inode, blk, 1,
>>>                                                &map_bh, 0, 0);
>>>        if (count > 0) { 
>>>
>>>it would be a lot less confusing.
>>>  
>>
>>I am sorry !! it is doing the right thing :(
> 
> 
> Not your fault.  The variable is very badly named.


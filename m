Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161944AbWKPG4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161944AbWKPG4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 01:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161942AbWKPG4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 01:56:06 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:62955 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161901AbWKPG4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 01:56:02 -0500
Message-ID: <455C0B6F.7000201@us.ibm.com>
Date: Wed, 15 Nov 2006 22:55:43 -0800
From: Mingming Cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Boot failure with ext2 and initrds
References: <20061114014125.dd315fff.akpm@osdl.org>	<20061114184919.GA16020@skynet.ie>	<Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>	<20061114113120.d4c22b02.akpm@osdl.org>	<Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>	<Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com> <20061115214534.72e6f2e8.akpm@osdl.org>
In-Reply-To: <20061115214534.72e6f2e8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 15 Nov 2006 14:17:01 +0000 (GMT)
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> 
>>On Tue, 14 Nov 2006, Hugh Dickins wrote:
>>
>>>On Tue, 14 Nov 2006, Andrew Morton wrote:
>>>
>>>>The below might help.
>>>
>>>Indeed it does (with Martin's E2FSBLK warning fix),
>>>seems to be running well on all machines now.
>>
>>i386 and ppc64 still doing builds, but after an hour on x86_64,
>>an ld got stuck in a loop under ext2_try_to_allocate_with_rsv,
>>alternating between ext2_rsv_window_add and rsv_window_remove.
>>Send me a patch and I'll try it...
>>
>>ext2_try_to_allocate_with_rsv+0x288
>>ext2_new_blocks+0x21e
>>ext2_get_blocks+0x398
>>ext2_get_block+0x46
>>__block_prepare_write+0x171
>>block_prepare_write+0x39
>>ext2_prepare_write+0x2c
>>generic_file_buffered_write+0x2b0
>>__generic_file_aio_write_nolock+0x4bc
>>generic_file_aio_write+0x6d
>>do_sync_write+0xf9
>>vfs_write+0xc8
>>sys_write+0x51
> 
> 
> OK, I have a theory.
> 
> This must have been the seventeenth damn time I've stared at
> find_next_zero_bit() wondering what the damn return value is and wondering
> how any even slightly non-sadistic person could write a damn function like
> that and not damn well document it.
> 
> int find_next_zero_bit(const unsigned long *addr, int size, int offset)
> 
> It returns the offset of the first zero bit relative to addr.  
> 
> ext3's bitmap_search_next_usable_block() assumed that find_next_zero_bit()
> returns the offset of the first zero bit relative to (addr+offset).
> 
> The while loop in ext3's bitmap_search_next_usable_block() serendipitously
> covered that bug up.
> 
> ext2's bitmap_search_next_usable_block() doesn't need that while loop, so
> ext3's benign bug became ext2's fatal bug.
> 
> So...
> 
> --- a/fs/ext2/balloc.c~a
> +++ a/fs/ext2/balloc.c
> @@ -524,7 +524,7 @@ bitmap_search_next_usable_block(ext2_grp
>  	ext2_grpblk_t next;
> 
>  	next = ext2_find_next_zero_bit(bh->b_data, maxblocks, start);
> -	if (next >= maxblocks)
> +	if (next >= start + maxblocks)
>  		return -1;
>  	return next;
>  }
> _
> 
> Anyway, I think that's the bug.  Or a bug, at least.  If so, the cause of
> this bug is inadequate code commenting, pure and simple.  And ext3 and ext4
> need fixing.
> 
Hmm, maxblocks, in bitmap_search_next_usable_block(),  is the end block 
number of the range  to search, not the lengh of the range. maxblocks 
get passed to ext2_find_next_zero_bit(), where it expecting to take the 
_size_ of the range to search instead...

Something like this: (this is not a patch)
  @@ -524,7 +524,7 @@ bitmap_search_next_usable_block(ext2_grp
   	ext2_grpblk_t next;

   -  	next = ext2_find_next_zero_bit(bh->b_data, maxblocks, start);
   +  	next = ext2_find_next_zero_bit(bh->b_data, maxblocks-start + 1, 
start);
	if (next >= maxblocks)
   		return -1;
   	return next;
   }


Mingming



Yes, it's quite confusing and probably we should replace it a better 
name......

Mingming


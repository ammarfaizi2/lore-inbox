Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVCERjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVCERjr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 12:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVCERjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 12:39:47 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:46985 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261687AbVCERjk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 12:39:40 -0500
Message-ID: <4229EEDA.2030307@us.ibm.com>
Date: Sat, 05 Mar 2005 09:39:38 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.11-mm1 "nobh" support for ext3 writeback mode
References: <1109980952.7236.39.camel@dyn318077bld.beaverton.ibm.com>	<20050304162331.4a7dfdb8.akpm@osdl.org>	<1109982557.7236.65.camel@dyn318077bld.beaverton.ibm.com>	<20050304164553.29811e8f.akpm@osdl.org>	<1109984528.7236.72.camel@dyn318077bld.beaverton.ibm.com> <20050304171651.013ff333.akpm@osdl.org>
In-Reply-To: <20050304171651.013ff333.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
>> 	iblock = index << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits);
> 
> 
> It would still be nice to add a comment in here...
> 
> 
>>+	if (test_opt(inode->i_sb, NOBH) && !page_has_buffers(page)) {
>>+		if (!PageUptodate(page)) {
>>+			struct buffer_head map_bh;
>>+			bh = &map_bh;
>>+			bh->b_state = 0;
>>+			clear_buffer_mapped(bh);
>>+			ext3_get_block(inode, iblock, bh, 0);
>>+			if (!buffer_mapped(bh)) 
>>+				goto unlock;
>>+			err = -EIO;
>>+			set_bh_page(bh, page, 0);
>>+			bh->b_this_page = 0;
>>+			bh->b_size = 1 << inode->i_blkbits;
>>+			ll_rw_block(READ, 1, &bh);
>>+			wait_on_buffer(bh);
>>+			if (!buffer_uptodate(bh))
>>+				goto unlock;
>>+			SetPageMappedToDisk(page);
>>+		}
>>+		kaddr = kmap_atomic(page, KM_USER0);
>>+		memset(kaddr + offset, 0, length);
>>+		flush_dcache_page(page);
>>+		kunmap_atomic(kaddr, KM_USER0);
>>+		set_page_dirty(page);
>>+		err = 0;
>>+		goto unlock;
>>+	}
>>+	
>> 	if (!page_has_buffers(page))
>> 		create_empty_buffers(page, blocksize, 0);
> 
> 
> Given that we're about to go add buffers to the page, why not do that
> first, and use the page's own buffer_head rather than cooking up a local
> one?  Then we can simply use sb_bread().
> 
> 

Only reason for cooking up the local one is not to attach the buffer to
the page forever. That will end up forcing other routines (like 
writepage/writepages) go thro "confused" code. I was hoping not to
attach buffers if they are not really needed.

But again, doing it the way you suggested will make the code more
readable.

Thanks,
Badari

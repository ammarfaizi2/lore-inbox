Return-Path: <linux-kernel-owner+w=401wt.eu-S932160AbXACW3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbXACW3R (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbXACW3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:29:16 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:33201 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932157AbXACW3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:29:15 -0500
Message-ID: <459C2E6D.2040406@yahoo.fr>
Date: Wed, 03 Jan 2007 23:30:05 +0100
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Handle error in sync_sb_inodes()
References: <45958E4F.5080105@yahoo.fr> <20070102132645.264d2b89.akpm@osdl.org>
In-Reply-To: <20070102132645.264d2b89.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
>> @@ -365,7 +366,8 @@ sync_sb_inodes(struct super_block *sb, s
>>  		BUG_ON(inode->i_state & I_FREEING);
>>  		__iget(inode);
>>  		pages_skipped = wbc->pages_skipped;
>> -		__writeback_single_inode(inode, wbc);
>> +		ret = __writeback_single_inode(inode, wbc);
>> +		mapping_set_error(mapping, ret);
>>  		if (wbc->sync_mode == WB_SYNC_HOLD) {
>>  			inode->dirtied_when = jiffies;
>>  			list_move(&inode->i_list, &sb->s_dirty);
>>     
> --- a/fs/buffer.c~a
> +++ a/fs/buffer.c
> @@ -1739,6 +1739,7 @@ recover:
>  		}
>  	} while ((bh = bh->b_this_page) != head);
>  	SetPageError(page);
> +	mapping_set_error(page->mapping, err);
>  	BUG_ON(PageWriteback(page));
>  	set_page_writeback(page);
>  	unlock_page(page);
>   


Unfortunately, with your patch and not mine, the problem is still 
present: msync()
does not return the error. Both pieces of code (yours and mine) are 
called for the
same mapping though, albeit yours more frequently.

My interpretation (based more on imagination than experience) is that
__writeback_single_inode() ends up calling __block_write_full_page() which
sets the page flags (your patch), then calls wait_on_page_writeback_range()
which clears the flags but returns the error as its return value. And this
error code is dropped by sync_sb_inodes() (my patch not applied).

With my patch, wait_on_page_writeback_range() would get the error code
by some other mean, and sync_sb_inodes() would re-put it in the flags for
msync() later.

Sorry, for the speculation, but I would need some hint to debug this ;-)

Thanks.

-- 
Guillaume


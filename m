Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbUANS2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 13:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbUANS2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 13:28:12 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.116]:58777 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S263345AbUANS2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 13:28:07 -0500
Message-ID: <400589A9.4080706@stanford.edu>
Date: Wed, 14 Jan 2004 10:25:45 -0800
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla Thunderbird 0.5a (20031223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Slusky <sluskyb@paranoiacs.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: loopback over reiserfs broken in 2.6.1-mm1
References: <4002F317.2070102@myrealbox.com> <200401122245.i0CMjYbn015552@car.linuxhacker.ru> <40042A0F.7080401@myrealbox.com> <40044B9A.4070300@myrealbox.com> <20040114034922.GA4793@fukurou.paranoiacs.org> <4004E50F.8090306@myrealbox.com> <20040114125503.GB4793@fukurou.paranoiacs.org>
In-Reply-To: <20040114125503.GB4793@fukurou.paranoiacs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Slusky wrote:
> On Tue, 13 Jan 2004 22:43:27 -0800, Andy Lutomirski wrote:
> 
>>Didn't help.
>>
>>I put in a few printk's -- it looks like the failure is in 
>>set_blocksize, probably due to a bogus blocksize of 131072, coming from 
>>'lo_blocksize = inode->i_blksize;'.
> 
> 
> Right... and this patch would have fixed it if ReiserFS' i_blksize were
> merely huge (on the order of 8192) instead of frickin' ludicrous (on the
> order of 131072).
> 
> Under the circumstances I think this is the best fix then, it ought
> to revert loop_set_fd's behavior to what it's always been:
> 
> --- drivers/block/loop.c.old	2004-01-11 13:05:05.000000000 -0500
> +++ drivers/block/loop.c	2004-01-14 07:49:24.795161024 -0500
> @@ -853,9 +853,7 @@
>  		blk_queue_merge_bvec(lo->lo_queue, q->merge_bvec_fn);
>  	}
>  
> -	error = set_blocksize(bdev, lo_blocksize);
> -	if (error)
> -		goto out_putf;
> +	set_blocksize(bdev, lo_blocksize);
>  
>  	kernel_thread(loop_thread, lo, CLONE_KERNEL);
>  	down(&lo->lo_sem);
> 

Fixed.  Thanks.

--Andy

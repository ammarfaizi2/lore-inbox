Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161963AbWKPHWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161963AbWKPHWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 02:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161962AbWKPHWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 02:22:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161960AbWKPHWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 02:22:47 -0500
Date: Wed, 15 Nov 2006 23:22:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Hugh Dickins <hugh@veritas.com>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Boot failure with ext2 and initrds
Message-Id: <20061115232228.afaf42f2.akpm@osdl.org>
In-Reply-To: <455C0B6F.7000201@us.ibm.com>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061114184919.GA16020@skynet.ie>
	<Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	<20061114113120.d4c22b02.akpm@osdl.org>
	<Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	<Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
	<20061115214534.72e6f2e8.akpm@osdl.org>
	<455C0B6F.7000201@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 22:55:43 -0800
Mingming Cao <cmm@us.ibm.com> wrote:

> Hmm, maxblocks, in bitmap_search_next_usable_block(),  is the end block 
> number of the range  to search, not the lengh of the range. maxblocks 
> get passed to ext2_find_next_zero_bit(), where it expecting to take the 
> _size_ of the range to search instead...
> 
> Something like this: (this is not a patch)
>   @@ -524,7 +524,7 @@ bitmap_search_next_usable_block(ext2_grp
>    	ext2_grpblk_t next;
> 
>    -  	next = ext2_find_next_zero_bit(bh->b_data, maxblocks, start);
>    +  	next = ext2_find_next_zero_bit(bh->b_data, maxblocks-start + 1, start);
> 	if (next >= maxblocks)
>    		return -1;
>    	return next;
>    }

yes, the `size' arg to find_next_zero_bit() represents the number of bits
to scan at `offset'.

So I think your change is correctish.  But we don't want the "+ 1", do we?

If we're right then this bug could cause the code to scan off the end of the
bitmap.  But it won't explain Hugh's bug, because of the if (next >= maxblocks).

btw, how come try_to_extend_reservation() uses spin_trylock?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbUD0ER7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUD0ER7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 00:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbUD0ER7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 00:17:59 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:30555 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262022AbUD0ER6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 00:17:58 -0400
Message-ID: <408DDEF1.8030608@yahoo.com.au>
Date: Tue, 27 Apr 2004 14:17:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: ext3 inode cache eats system, news at 11
References: <20040426171856.22514.qmail@lwn.net>	<20040426181235.2b5b62c8.akpm@osdl.org>	<408DD2D5.1040306@yahoo.com.au> <20040426210237.788045cf.akpm@osdl.org>
In-Reply-To: <20040426210237.788045cf.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>> Andrew Morton wrote:
>>
>> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc2/2.6.6-rc2-mm2/broken-out/slab-order-0-for-vfs-caches.patch
>> > 
>> > is not a completely happy solution, but it should fix things up.
>>
>> Another thing you could be doing is not zeroing swapper->nr
>> if the shrinker function doesn't do anything, in order to try
>> to maintain pressure on the dcache. This would be similar to
>> your deferred list idea.
> 
> 
> Am now doing this.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc2/2.6.6-rc2-mm2/broken-out/shrink_slab-handle-GFP_NOFS.patch
> 

Ahh good. You may want to subtract the pending ->nr from
"(*shrinker->shrinker)(0, gfp_mask)" though, when calculating
the size of the next delta to scan.

Well possibly not. The math in your patch presently assumes
no entries will be freed due to the built up deferred scanning,
and if you changed it to the above idea, it would assume all
entries will be freed. I just think it would be good to dampen
the increase to ->nr a bit. It would inherently limit ->nr from
wrapping too.

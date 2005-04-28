Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVD1B3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVD1B3f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 21:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVD1B3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 21:29:35 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:27512 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261571AbVD1B3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 21:29:32 -0400
Message-ID: <42703C6C.5090102@yahoo.com.au>
Date: Thu, 28 Apr 2005 11:29:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: andrea@suse.de, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: [patch] fix the 2nd buffer race properly
References: <426F908C.2060804@yahoo.com.au>	<20050427105655.5edc13ce.akpm@osdl.org>	<4270296D.9010109@yahoo.com.au> <20050427180012.26b75e0f.akpm@osdl.org>
In-Reply-To: <20050427180012.26b75e0f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>> > That's all a bit too complex.   How's about this instead?
>> > 
>>
>> Well you really don't need to hold the page locked for that long.
> 
> 
> Is a rare case, so there's no perfomance issue here.
> 

Well it is for buffered writes, right? And in general it will be OK,
but if you run into queue/memory congestion when submitting the IO,
it will be locked for a lot longer than required.

> I do prefer the idea of simply keeping other threads of control out of the
> page until this thread has finished playing with its buffers.
> 

That's exactly what my patch does too!

> (The buffer-ring walk we have in there is racy against page reclaim, too. 
> If only the first buffer is dirty, we inspect the other buffers after
> PageWriteback has potentially cleared.)
> 

Well we do have a reference on the buffers, so in this particular case
perhaps not. But we have no mutual exclusion on the page or buffers
so I agree it could be racy against a lot of things.

> 
>> block_read_full_page, nobh_prepare_write both use the same sort of
>> array of buffer heads logic - I think it makes sense not to touch
>> any buffers after submitting them all for IO...?
> 
> 
> Well.  Most code in there uses the ->b_this_page walk.
> 

block_read_full_page does the walk in order to gather up the buffers.
They then get submitted for IO via the buffer head array walk.

I prefer my patch. I don't think it is particularly complex.

-- 
SUSE Labs, Novell Inc.


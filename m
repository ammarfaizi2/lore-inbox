Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUEZLEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUEZLEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbUEZLEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:04:15 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:2456 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265477AbUEZLEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:04:08 -0400
Message-ID: <40B479A3.9070605@yahoo.com.au>
Date: Wed, 26 May 2004 21:04:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Buddy Lumpkin <b.lumpkin@comcast.net>
CC: "'William Lee Irwin III'" <wli@holomorphy.com>, orders@nodivisions.com,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buddy Lumpkin wrote:
>>Hi Buddy,
>>Even for systems that don't *need* the extra memory space, swap can
>>actually provide performance improvements by allowing unused memory
>>to be replaced with often-used memory.
> 
> 
>>For example, I have 57MB swapped right now. It allows me to instantly
>>grep the kernel tree. If I turned swap off, each grep would probably
>>take 30 seconds.
> 
> 
> Your analogy is flawed. There are many reasons why this doesn't work in the
> real world.
> 

It is not an analogy.

[snip]

I understand the basics of how Linux's memory management works.

> Your grep analogy incorrectly assumes that you have a bunch of vacant memory
> just waiting to store those filesystem pages, but that simply isn't the
> case. Rather 57MB of anonymous memory was evicted to make room for 57MB of
> anonymous or file system backed pages. Unless you have freed anonymous
> memory on the system by closing applications. Your physical memory pages are
> still mostly occupied. 
> 

Yes the 57MB of anonymous memory *was* evicted to make room for 57MB
of file system backed pages that grep pulled in presumably.

I tend to use grep rather often. I'm very glad that crud from mozilla,
XFree86, nautilus, gnome-settin, x-session-ma, etc has been paged out.
It allows me to grep the kernel source instantly.

> This means your grep is only going to run faster if you already read those
> files recently and they are already in the pagecache. You still have the
> burdon of pushing pages that have not been used recently out of ram before
> you can read in the new ones. And as long as you are performing a sufficient
> amount of file system I/O, this is guaranteed to happen.
> 

What would you have it do? Push out pages that have been recently used?

> One thing that can be done to minimize the problem where heavy filesystem
> I/O flushes important pages from memory like pages from shared libraries and
> executables only for them to fault back in as soon as they become runnable,
> is to implement something similar to what Sun implemented in Solaris 8
> called the cyclical page cache. The idea is that the pagecache pages against
> itself and is actually considered free memory from an anonymous memory
> perspective. The pagecache is free to grow all it wants, but since it is
> counted as free memory, anonymous memory allocation will cause the pagecache
> to shrink because it is considered free memory.
>

"the pagecache pages against itself", what does that mean?

> As these pages are evicted from the pagecache, they are placed on the
> opposite side of the cachelist (linked list that stores pages that have a
> vnode+offset already) than the side where pages are being overwritten. This
> way frequently re-accessed pages that were placed on the cache list and were
> eligible to be reclaimed, are found when the next minor fault occurs for
> that vnode+offset and moved back to the opposite side of the list so that
> they are not evicted.
> 

I failed to grasp the mechanics of the cachelist and its opposite sides.
And why does one side have pages being overwritten? Sounds strange. But
I don't know Solaris.

Linux has an approximately-LRU ordered list. Newly accessed pages go in
the top and come out the bottom where they are reclaimed (or in the front
and out the back).

> Since the cache list is counted as free memory, there is no way to wake up
> the LRU mechanism to scan physical memory until 1/64 of physical memory is
> consumed by anonymous memory.  
> 

That assumes that file backed cache is worth zero compared to
anonymous memory, which is not the case.

In Linux, we actually do the replacement in terms of mapped and
unmapped pages and bias replacement toward unmapped pages. We
will still evict long term inactive mapped pages though, which is
a good thing.

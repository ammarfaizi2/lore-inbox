Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267764AbTAXPzk>; Fri, 24 Jan 2003 10:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267769AbTAXPzk>; Fri, 24 Jan 2003 10:55:40 -0500
Received: from dial-ctb05175.webone.com.au ([210.9.245.175]:10756 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267764AbTAXPzj>;
	Fri, 24 Jan 2003 10:55:39 -0500
Message-ID: <3E316421.5070905@cyberone.com.au>
Date: Sat, 25 Jan 2003 03:04:49 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Andrew Morton <akpm@digeo.com>, Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel@alex.org.uk, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.59-mm5
References: <20030123195044.47c51d39.akpm@digeo.com> <946253340.1043406208@[192.168.100.5]> <20030124031632.7e28055f.akpm@digeo.com> <m3d6mmvlip.fsf@lexa.home.net> <20030124035017.6276002f.akpm@digeo.com> <20030124155626.GC9417@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:

>On Fri, Jan 24, 2003 at 03:50:17AM -0800, Andrew Morton wrote:
>
>>Alex Tomas <bzzz@tmi.comex.ru> wrote:
>>
>>>>>>>>Andrew Morton (AM) writes:
>>>>>>>>
>>> AM> But writes are completely different.  There is no dependency
>>> AM> between them and at any point in time we know where on-disk a lot
>>> AM> of writes will be placed.  We don't know that for reads, which is
>>> AM> why we need to twiddle thumbs until the application or filesystem
>>> AM> makes up its mind.
>>>
>>>
>>>it's significant that application doesn't want to wait read completion
>>>long and doesn't wait for write completion in most cases.
>>>
>>That's correct.  Reads are usually synchronous and writes are rarely
>>synchronous.
>>
>>The most common place where the kernel forces a user process to wait on
>>completion of a write is actually in unlink (truncate, really).  Because
>>truncate must wait for in-progress I/O to complete before allowing the
>>filesystem to free (and potentially reuse) the affected blocks.
>>
>>If there's a lot of writeout happening then truncate can take _ages_.  Hence
>>this patch:
>>
>
>An alternate approach might be to change the way the scheduler splits
>things. That is, rather than marking I/O read vs write and scheduling
>based on that, add a flag bit to mark them all sync vs async since
>that's the distinction we actually care about. The normal paths can
>all do read+sync and write+async, but you can now do things like
>marking your truncate writes sync and readahead async.
>
>And dependent/nondependent or stalling/nonstalling might be a clearer
>terminology.
>
That will be worth investigating to see if the complexity is worth it.
I think from a disk point of view, we still want to split batches between
reads and writes. Could be wrong.

Nick


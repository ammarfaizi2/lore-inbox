Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267176AbUBMTN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 14:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267177AbUBMTN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 14:13:27 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:45582 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S267176AbUBMTNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 14:13:10 -0500
Message-ID: <402D235F.7030401@techsource.com>
Date: Fri, 13 Feb 2004 14:19:59 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1,
 etc.
References: <402C0D0F.6090203@techsource.com> <20040213055350.GG29363@alpha.home.local>
In-Reply-To: <20040213055350.GG29363@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your suggestions.  They have aided me in my tests... read on.

Willy Tarreau wrote:
> On Thu, Feb 12, 2004 at 06:32:31PM -0500, Timothy Miller wrote:
>  
> 
>>For writes, iozone found an upper bound of about 10megs/sec, which is 
>>abysmal.  Typically, I'd expect writes to be faster (on a single drive) 
>>than reads, because once the write is sent, you can forget about it. 
>>You don't have to wait around for something to come back, and that 
>>latency for reads can hurt performance.  The OS can also buffer writes 
>>and reorder them in order to improve efficiency.
> 
> 
> It depends on the disk too. Lots of disks (specially IDE) are far slower
> on writes than they are on reads.

I wonder why that is.  What adds extra overhead to the writes?  Verify? 
    Given the lousy quality of today's hard drives, I can see why that 
might be necessary.

> 
> 
>>The 3ware has this write cache that you can turn on or off.  With it 
>>off, it ensures that writes make it to the disks in order.  With it on, 
>>it will reorder writes more efficiently.  However, I noticed that the 
>>performance only went up to about 16meg/sec with the cache ON.
> 
> 
> I don't think that the FS type has much importance once the cache is ON.

It might, but from my tests (see below), you're right.

> 
> 
>>What's the command?  How about this:
>>    time dd if=/dev/zero of=/dev/sga3 bs=1024 count=1024
> 
> 
> do it like this, but use higher values, particularly for bs which is only
> 1kB here. Using something like bs=65536 and count=4096 will give you a 256 MB
> file.
> 

I mistyped.  I did "bs=1024k count=1024".

> 
>>Will that do it?  Should I use an offset to avoid any kind of header or 
>>metadata?
> 
> 
> not needed. Just ensure that you write to the right partition, and better
> check twice.
> 

Done.  Here are my results:

As I had mentioned, I did raw read performance by timing a dd from 
/dev/sda to /dev/null.  That demonstrated a throughput of 47 megs/sec 
which is pretty close to the benchmarks that I find in reviews.

I was able to perform the write performance test last night.  The swap 
partition was actually /dev/sda2.  I think / and /boot are sda1 and 
sda3, but I forget the order.  Either way, the swap partition is not 
worst case.  In my test, I wrote 1 gigabyte in 1 meg blocks in 73.522 
seconds which translates into 13.92 megs/sec.  That's terrible -- worse 
because the 3ware's write cache is ON.

According to Tom's Hardware, raw write throughput for the WD1200JB 
varies from 39500 k/sec at the outer tracks to 14200 k/sec at the inner 
tracks.  Something is seriously bottle-necking the performance through 
the 3ware.

For comparison, my wife's computer has the same model of drive as its 
primary IDE.  This is a single drive, and the box runs Windows XP Pro 
with 1GB of RAM.  The disk was defragmented this morning at 5AM, and I 
ran the test this morning at about 9AM.  I ran SiSoft SANDRA, and these 
are the results:

Buffered Read     73 mb/s
Seqential Read    37 mb/s
Random read        6 mb/s
Buffered write    60 mb/s
Sequential write  39 mb/s
Random write      12 mb/s

Assuming that the "buffered" speeds are being buffered by the OS, we'll 
ignore those.  I am therefore observing that the writes to a single 
drive are 3 to 4 times faster than they are through the RAID controller, 
even with the 3ware write cache ON.

Does that make any sense?


[Kernel version:  Most recent Red Hat update, 2.4.20-something.
  3ware 7000-2 with two 120GB WD drives in RAID 1 array.]

Thanks.


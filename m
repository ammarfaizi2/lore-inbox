Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266672AbUBLXZy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 18:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUBLXZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 18:25:54 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:62474 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266672AbUBLXZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 18:25:52 -0500
Message-ID: <402C0D0F.6090203@techsource.com>
Date: Thu, 12 Feb 2004 18:32:31 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: File system performance, hardware performance, ext3, 3ware RAID1,
 etc.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm attempting to get some idea of how much overhead ext3 causes me on 
my workstation at home.  Furthermore, I'm trying to determine what sort 
of advantage I'm really getting from my 3ware RAID controller (model 
7000-2, configured for RAID1) over single disks.

Using iozone, I'm finding an upper bound for disk reads at about 40 
megs/sec, which is okay, but no better than single disk.  That's 
probably expected, since sequential reads can't come off the disk any 
faster than the disk spins.  RAID1 would show its greatest benefit with 
RANDOM reads.

To determine the highest upper bound for sequential read throughput, I 
timed a dd of the first gigabyte from /dev/sga (the raw device) to 
/dev/null.  This showed a throughput of 47meg/sec.  This shows that ext3 
  isn't hurting reads.

For writes, iozone found an upper bound of about 10megs/sec, which is 
abysmal.  Typically, I'd expect writes to be faster (on a single drive) 
than reads, because once the write is sent, you can forget about it. 
You don't have to wait around for something to come back, and that 
latency for reads can hurt performance.  The OS can also buffer writes 
and reorder them in order to improve efficiency.

The 3ware has this write cache that you can turn on or off.  With it 
off, it ensures that writes make it to the disks in order.  With it on, 
it will reorder writes more efficiently.  However, I noticed that the 
performance only went up to about 16meg/sec with the cache ON.

For comparison, I would like to estimate the maximum WRITE throughout 
for the raw device.  But I'm not ready to dump zeros to my working 
partitions.  I was thinking that I could do this with the SWAP 
partition.  I could turn off swap and then dd TO the swap partition. 
Being on the inner tracks, it won't perform as well as the max for the 
drive, but it'll give me a lower bound for raw write throughput to 
compare against.

IMPORTANT QUESTION:  Is there any metadata anywhere in the swap 
partition (when it's not in use) that I need to save before I fill it 
with zeros?

Also, what do I use as a source for zeros when writing with dd? 
"/dev/zero"?

What's the command?  How about this:
     time dd if=/dev/zero of=/dev/sga3 bs=1024 count=1024

Will that do it?  Should I use an offset to avoid any kind of header or 
metadata?

If anyone has numbers for what they get with WD1200JB drives, I'd love 
to compare.

Thanks!


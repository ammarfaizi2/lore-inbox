Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265746AbTL3M6v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 07:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbTL3M6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 07:58:51 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:51638 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S265746AbTL3M6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 07:58:48 -0500
Date: Tue, 30 Dec 2003 13:58:47 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: linux-kernel@vger.kernel.org
Cc: linux-lvm@sistina.com
Subject: Performance issue with non-4K blocksize on 3ware [was: Re: Speed drop /dev/sda -> /dev/sda1 -> /dev/vg0/test (3ware/LVM)]
Message-ID: <20031230125845.GA2577@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229125412.GA28262@cistron.nl>
Distribution: cistron
Organization: Cistron Group
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <cistron.20031229125412.GA28262@cistron.nl>,
Miquel van Smoorenburg  <miquels@cistron.nl> wrote:
>Hello,
>
>	I'm running Linux 2.6.0 with a 3ware 8506 controller in
>hardware RAID5 mode. The RAID5 array is built of 7+1 200 GB SATA
>disks.
>
>Now it appears that more "mappings" on the array have a bad
>influence on speed. /dev/sda is the fastest, /dev/sda1 is quite
>a bit slower, LVM on /dev/sda is slower yet and LVM on /dev/sda1
>is the slowest.

Okay, I found a clue. It appears that by default, the blocksize
of /dev/sda is 4096 and the blocksize of /dev/sda1 is 1024 on my system:

# blockdev --getbsz /dev/sda
4096
# blockdev --getbsz /dev/sda1
1024

On 2.4, setting the blocksize is sticky, on 2.6 it isn't. So I have
to work around that to test with other blocksizes, for example:

# /usr/bin/time -p sh -c "blockdev --setbsz 4096 /dev/stdout; dd if=/dev/zero bs=4k count=100000; sync" > /dev/sda1
100000+0 records in
100000+0 records out
real 5.00
user 0.03
sys 0.89

409600000 bytes in 5 seconds =~ 80 MB/sec, which is quite good and
the same throughput as through /dev/sda. So, it appears that the
3ware driver really really wants a 4K blocksize, otherwise performance
drops at least 30-40%.

Now with LVM on top of it, performance drops again. Say I create a
logical volume on /dev/sda1:

# pvcreate /dev/sda1
# vgcreate vg0 /dev/sda1
# lvcreate -L 100G -n test vg0

# blockdev --getbsz /dev/sda1
1024
# blockdev --getbsz /dev/vg0/test
4096

Performance:
# /usr/bin/time -p sh -c "dd if=/dev/zero of=/dev/vg0/test bs=4k count=100000; sync"
100000+0 records in
100000+0 records out
409600000 bytes transferred in 8.512663 seconds (48116553 bytes/sec)
real 8.54
user 0.04
sys 1.02

So, I tried a small patch in dm-table.c to set the blocksize of the
underlying device to 4096:

# diff -u dm-table.c.b4 dm-table.c
--- dm-table.c.b4       2003-12-29 15:18:18.000000000 +0100
+++ dm-table.c  2003-12-30 13:08:06.000000000 +0100
@@ -359,8 +359,10 @@
        r = bd_claim(bdev, _claim_ptr);
        if (r)
                blkdev_put(bdev, BDEV_RAW);
-       else
+       else {
                d->bdev = bdev;
+               set_blocksize(bdev, 4096);
+       }
        return r;
 }
  
While it appears to work, it doesn't seem to make any difference:

# blockdev --getbsz /dev/sda1
4096
# blockdev --getbsz /dev/vg0/test
4096

Performance:
# /usr/bin/time -p sh -c "dd if=/dev/zero of=/dev/vg0/test bs=4k count=100000; sync"
100000+0 records in
100000+0 records out
409600000 bytes transferred in 8.528826 seconds (48025367 bytes/sec)
real 8.54
user 0.05
sys 0.98

Not so weird, since in dm-table.c the device is opened in RAW mode
and raw devices do I/O at hardsect_size, right? So that would be
512 bytes, explaining the bad performance.

I'm hoping someone has read this far and can offer me a clue as
how to fix this. Are somehow requests not merged right, and are
small 512 byte requests submitted to the 3ware driver? Is the
3ware driver responsible for merging requests ? I really don't
know anything about the block layer or bio's so I'm kind of
lost here.

Mike.

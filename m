Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWHNQON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWHNQON (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWHNQON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:14:13 -0400
Received: from qb-out-0506.google.com ([72.14.204.230]:8790 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751035AbWHNQOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:14:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SXXvM5kTVH+EQsOt29xcy0ZCNe1j2dwOe6BGF8NmFIRCJMhwN8L9JrUVGeP/qErwAojGGNdzxTH/a6iFFnkwTkSRZeVwydJ7wns++GgDpdK6w6UmM7FvhHUuHeOSNdTjJtg1B5On6MqkvGudpcgcqof5rV9PjEKOSmpYr8VZyA8=
Message-ID: <401f4f10608140914x16ca8cfeif39039a72f143863@mail.gmail.com>
Date: Mon, 14 Aug 2006 19:14:09 +0300
From: "Pavel Mironchik" <tibor0@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Mempool_alloc, bio_alloc_bioset deadlocks
Cc: akpm@osdl.org, kobras@linux.de
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few days ago device mapper raid1 deadlock was discovered.
Adrew Morton made patch for that bug in mm tree:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/broken-out/dm-fix-deadlock-under-high-i-o-load-in-raid1-setup.patch

However I found that problem is more serious and depends on mempool.
I reproduced that very same situation on 2.6.17 with device-mapper
linear target.
Here my steps:
 - I used 2.6.17 kernel for xscale (arm), boot into initrd image
(initrd is SYSTEM_BOOTING state I assume) !!!!
 - with the help of evms.sf.net I made md raid1 with device mapper
volume on top of it.
-  create xfs volume ; mkfs.xfs /dev/evms/vol ; mount /dev/evms/vol /mnt
-  run: cat /dev/zero > /mnt/test &
- after some period cat, pdflush and raid1d threads went into deadlock
state, and I got the following (sysrq dump):

....
pdflush       D C02B5C88     0  1523      6          1583  1498 (L-TLB)
[<c02b5740>] (schedule+0x0/0x620) from [<c02b665c>] (io_schedule+0x34/0x5c)
[<c02b6628>] (io_schedule+0x0/0x5c) from [<c005bca4>] (mempool_alloc+0xbc/0xd8)
 r5 = C05EC3A0  r4 = 00011210
[<c005bbe8>] (mempool_alloc+0x0/0xd8) from [<c007c9fc>]
(bio_alloc_bioset+0xd4/0x144)
 r8 = C05EC3E0  r7 = 00000010  r6 = C6D764A0  r5 = 00000000
 r4 = 0000000C
[<c007c928>] (bio_alloc_bioset+0x0/0x144) from [<c007ccb4>]
(bio_clone+0x24/0x48)
 r8 = C6D76500  r7 = C6D6C120  r6 = C6D6C120  r5 = 00000004
 r4 = C6D76500
[<c007cc90>] (bio_clone+0x0/0x48) from [<bf02f72c>]
(make_request+0x4b4/0x65c [raid1])
 r4 = 00000004
[<bf02f278>] (make_request+0x0/0x65c [raid1]) from [<c01a11bc>]
(generic_make_request+0x1e4/0x204)
[<c01a0fd8>] (generic_make_request+0x0/0x204) from [<c023c3d4>]
(__map_bio+0x78/0xb8)
[<c023c35c>] (__map_bio+0x0/0xb8) from [<c023c664>] (__split_bio+0x1dc/0x544)
 r6 = CFC27ADC  r5 = CFC27B0C  r4 = CFC27AFC
[<c023c488>] (__split_bio+0x0/0x544) from [<c023cadc>] (dm_request+0x110/0x120)
[<c023c9cc>] (dm_request+0x0/0x120) from [<c01a11bc>]
(generic_make_request+0x1e4/0x204)
 r6 = C6D76560  r5 = 00000000  r4 = 00000008
[<c01a0fd8>] (generic_make_request+0x0/0x204) from [<c01a12a8>]
(submit_bio+0xcc/0xf0)
[<c01a11dc>] (submit_bio+0x0/0xf0) from [<c0079fb0>] (submit_bh+0x178/0x1a8)
 r7 = C6D76560  r6 = 00000000  r5 = 0001568A  r4 = 00000000
[<c0079e38>] (submit_bh+0x0/0x1a8) from [<c01881bc>]
(xfs_submit_page+0xdc/0x124)
[<c01880e0>] (xfs_submit_page+0x0/0x124) from [<c0188470>]
(xfs_convert_page+0x26c/0x28c)

and this ...

md255_raid1   D C02B5C88     0  1490      6          1498  1482 (L-TLB)
[<c02b5740>] (schedule+0x0/0x620) from [<c02b665c>] (io_schedule+0x34/0x5c)
[<c02b6628>] (io_schedule+0x0/0x5c) from [<c005bca4>] (mempool_alloc+0xbc/0xd8)
 r5 = C05EC3A0  r4 = 00011210
[<c005bbe8>] (mempool_alloc+0x0/0xd8) from [<c007c9fc>]
(bio_alloc_bioset+0xd4/0x144)
 r8 = C05EC3E0  r7 = 00000010  r6 = C6D76440  r5 = 00000000
 r4 = 0000000C
[<c007c928>] (bio_alloc_bioset+0x0/0x144) from [<c007ccb4>]
(bio_clone+0x24/0x48)
 r8 = 00000000  r7 = 00000000  r6 = 0009F4D8  r5 = 00000000
 r4 = CC09F860
[<c007cc90>] (bio_clone+0x0/0x48) from [<c023c45c>] (clone_bio+0x28/0x54)
 r4 = 00000001
[<c023c434>] (clone_bio+0x0/0x54) from [<c023c654>] (__split_bio+0x1cc/0x544)
 r7 = 00000000  r6 = CECB5DD0  r5 = CECB5E00  r4 = CECB5DF0
[<c023c488>] (__split_bio+0x0/0x544) from [<c023cadc>] (dm_request+0x110/0x120)
[<c023c9cc>] (dm_request+0x0/0x120) from [<c01a11bc>]
(generic_make_request+0x1e4/0x204)
 r6 = CC09F860  r5 = 00000000  r4 = 00000008
[<c01a0fd8>] (generic_make_request+0x0/0x204) from [<bf02fff4>]
(raid1d+0xa4/0xf18 [raid1])
[<bf02ff50>] (raid1d+0x0/0xf18 [raid1]) from [<c0235a60>]
(md_thread+0x124/0x140)


you can see that those threads are locked inside of mempool_alloc.
but I prepared patch:

diff --git a/mm/mempool.c b/mm/mempool.c
index fe6e052..10a7b1e 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -239,7 +239,7 @@ repeat_alloc:
        prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
        smp_mb();
        if (!pool->curr_nr)
-               io_schedule();
+               io_schedule_timeout(5*HZ);
        finish_wait(&pool->wait, &wait);

        goto repeat_alloc;


probably, I suppose this could be another solution for  raid1
deadlock problem described here:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/broken-out/dm-fix-deadlock-under-high-i-o-load-in-raid1-setup.patch
Of cource, that patch helped me with my device mapper issues.

Please dont be very rigorously about my patch, this is way of avoiding
problem but not solving.
-----------------------------------
Pavel S. Mironchik

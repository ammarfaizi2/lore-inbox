Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWGGTmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWGGTmN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWGGTmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:42:13 -0400
Received: from lucidpixels.com ([66.45.37.187]:41960 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932283AbWGGTmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:42:11 -0400
Date: Fri, 7 Jul 2006 15:42:09 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
cc: linux-raid@vger.kernel.org, neilb@suse.de
Subject: Re: Kernel 2.6.17 and RAID5 Grow Problem (critical section backup)
In-Reply-To: <Pine.LNX.4.64.0607071501000.14371@p34.internal.lan>
Message-ID: <Pine.LNX.4.64.0607071539020.2643@p34.internal.lan>
References: <Pine.LNX.4.64.0607070830450.2648@p34.internal.lan>
 <Pine.LNX.4.64.0607070845280.2648@p34.internal.lan>
 <Pine.LNX.4.64.0607070849140.3010@p34.internal.lan>
 <Pine.LNX.4.64.0607071037190.5153@p34.internal.lan>
 <Pine.LNX.4.64.0607071501000.14371@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jul 2006, Justin Piszcz wrote:

>
>
> On Fri, 7 Jul 2006, Justin Piszcz wrote:
>
>> 
>> 
>> On Fri, 7 Jul 2006, Justin Piszcz wrote:
>> 
>>> On Fri, 7 Jul 2006, Justin Piszcz wrote:
>>> 
>>>> On Fri, 7 Jul 2006, Justin Piszcz wrote:
>>>> 
>>>>> p34:~# mdadm /dev/md3 -a /dev/hde1
>>>>> mdadm: added /dev/hde1
>>>>> 
>>>>> p34:~# mdadm -D /dev/md3
>>>>> /dev/md3:
>>>>>        Version : 00.90.03
>>>>>  Creation Time : Fri Jun 30 09:17:12 2006
>>>>>     Raid Level : raid5
>>>>>     Array Size : 1953543680 (1863.04 GiB 2000.43 GB)
>>>>>    Device Size : 390708736 (372.61 GiB 400.09 GB)
>>>>>   Raid Devices : 6
>>>>>  Total Devices : 7
>>>>> Preferred Minor : 3
>>>>>    Persistence : Superblock is persistent
>>>>>
>>>>>    Update Time : Fri Jul  7 08:25:44 2006
>>>>>          State : clean
>>>>> Active Devices : 6
>>>>> Working Devices : 7
>>>>> Failed Devices : 0
>>>>>  Spare Devices : 1
>>>>>
>>>>>         Layout : left-symmetric
>>>>>     Chunk Size : 512K
>>>>>
>>>>>           UUID : e76e403c:7811eb65:73be2f3b:0c2fc2ce
>>>>>         Events : 0.232940
>>>>>
>>>>>    Number   Major   Minor   RaidDevice State
>>>>>       0      22        1        0      active sync   /dev/hdc1
>>>>>       1      56        1        1      active sync   /dev/hdi1
>>>>>       2       3        1        2      active sync   /dev/hda1
>>>>>       3       8       49        3      active sync   /dev/sdd1
>>>>>       4      88        1        4      active sync   /dev/hdm1
>>>>>       5       8       33        5      active sync   /dev/sdc1
>>>>>
>>>>>       6      33        1        -      spare   /dev/hde1
>>>>> p34:~# mdadm --grow /dev/md3 --raid-disks=7
>>>>> mdadm: Need to backup 15360K of critical section..
>>>>> mdadm: Cannot set device size/shape for /dev/md3: No space left on 
>>>>> device
>>>>> p34:~# mdadm --grow /dev/md3 --bitmap=internal --raid-disks=7
>>>>> mdadm: can change at most one of size, raiddisks, bitmap, and layout
>>>>> p34:~# umount /dev/md3
>>>>> p34:~# mdadm --grow /dev/md3 --raid-disks=7
>>>>> mdadm: Need to backup 15360K of critical section..
>>>>> mdadm: Cannot set device size/shape for /dev/md3: No space left on 
>>>>> device
>>>>> p34:~#
>>>>> 
>>>>> The disk only has about 350GB of 1.8TB used, any idea why I get this 
>>>>> error?
>>>>> 
>>>>> I searched google but could not find anything on this issue when trying 
>>>>> to grow the array?
>>>>> 
>>>>> 
>>>>> -
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>> 
>>>> 
>>>> Is it because I use a 512kb chunksize?
>>>> 
>>>> Jul  7 08:44:59 p34 kernel: [4295845.933000] raid5: reshape: not enough 
>>>> stripes.  Needed 512
>>>> Jul  7 08:44:59 p34 kernel: [4295845.962000] md: couldn't update array 
>>>> info. -28
>>>> 
>>>> So the RAID5 reshape only works if you use a 128kb or smaller chunk size?
>>>> 
>>>> Justin.
>>>> -
>>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>> 
>>> 
>>>> From the source:
>>> 
>>> /* Can only proceed if there are plenty of stripe_heads.
>>> @@ -2599,30 +2593,48 @@ static int raid5_reshape(mddev_t *mddev,
>>> * If the chunk size is greater, user-space should request more
>>> * stripe_heads first.
>>> */
>>> - if ((mddev->chunk_size / STRIPE_SIZE) * 4 > conf->max_nr_stripes) {
>>> + if ((mddev->chunk_size / STRIPE_SIZE) * 4 > conf->max_nr_stripes ||
>>> + (mddev->new_chunk / STRIPE_SIZE) * 4 > conf->max_nr_stripes) {
>>> printk(KERN_WARNING "raid5: reshape: not enough stripes. Needed %lu\n",
>>> (mddev->chunk_size / STRIPE_SIZE)*4);
>>> return -ENOSPC;
>>> }
>>> 
>>> I don't see anything that mentions one needs to use a certain chunk size?
>>> 
>>> Any idea what the problem is here?
>>> 
>>> Justin.
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>> 
>> 
>> Neil,
>> 
>> Any comments?
>> 
>> Justin.
>> 
>
> The --grow option worked, sort of.
>
> p34:~# mdadm /dev/md3 --grow --size=max
> p34:~# umount /dev/md3
> p34:~# mdadm -S /dev/md3
> p34:~# mount /dev/md3
> Segmentation fault
> p34:~#
>
> [4313355.425000] BUG: unable to handle kernel NULL pointer dereference at 
> virtual address 000000d4
> [4313355.425000]  printing eip:
> [4313355.425000] c03c377b
> [4313355.425000] *pde = 00000000
> [4313355.425000] Oops: 0002 [#1]
> [4313355.425000] PREEMPT SMP
> [4313355.425000] CPU:    0
> [4313355.425000] EIP:    0060:[<c03c377b>]    Not tainted VLI
> [4313355.425000] EFLAGS: 00010046   (2.6.17.3 #4)
> [4313355.425000] EIP is at _spin_lock_irqsave+0x14/0x61
> [4313355.425000] eax: 00000000   ebx: f7e6c000   ecx: c0333d12   edx: 
> 00000202
> [4313355.425000] esi: 000000d4   edi: f7fb9600   ebp: 000000d4   esp: 
> f7e6dc94
> [4313355.425000] ds: 007b   es: 007b   ss: 0068
> [4313355.425000] Process mount (pid: 22892, threadinfo=f7e6c000 
> task=c1a90580)
> [4313355.425000] Stack: c19947e4 00000000 c0333d32 00000002 c012aaa2 f7e6dccc 
> f7e6dc9c f7e6dc9c
> [4313355.425000]        f7e6dccc c0266b8d c19947e4 00000000 00000000 e11a61f8 
> f7e6dccc f7e6dccc
> [4313355.425000]        00000005 f7fda014 f7fda000 f7fe8c00 c0259a79 e11a61c0 
> 00000001 0000001f
> [4313355.425000] Call Trace:
> [4313355.425000]  <c0333d32> raid5_unplug_device+0x20/0x65  <c012aaa2> 
> flush_workqueue+0x67/0x87
> [4313355.425000]  <c0266b8d> xfs_flush_buftarg+0x1ab/0x1c1  <c0259a79> 
> xfs_mount+0x322/0xbb5
> [4313355.425000]  <c013e3f2> truncate_inode_pages+0x2f/0x33  <c015c3e5> 
> set_blocksize+0x83/0x91
> [4313355.425000]  <c026d804> xfs_fs_fill_super+0x94/0x232  <c02825b3> 
> snprintf+0x2b/0x2f
> [4313355.425000]  <c0189c8e> disk_name+0xa9/0xb3  <c015c412> 
> sb_set_blocksize+0x1f/0x46
> [4313355.425000]  <c015b5ff> get_sb_bdev+0x100/0x13f  <c016f104> 
> alloc_vfsmnt+0xab/0xd4
> [4313355.425000]  <c026ce9e> xfs_fs_get_sb+0x2f/0x33  <c026d770> 
> xfs_fs_fill_super+0x0/0x232
> [4313355.425000]  <c015abc4> do_kern_mount+0x49/0xc0  <c016ffc5> 
> do_mount+0x2c7/0x6e6
> [4313355.425000]  <c014372e> __handle_mm_fault+0x1fb/0x8a2  <c01439c2> 
> __handle_mm_fault+0x48f/0x8a2
> [4313355.425000]  <c013b6f5> __alloc_pages+0x53/0x2f1  <c013bbd2> 
> __get_free_pages+0x2d/0x4b
> [4313355.425000]  <c016ede0> copy_mount_options+0x2c/0x12e  <c0170481> 
> sys_mount+0x9d/0xde
> [4313355.425000]  <c0102df3> syscall_call+0x7/0xb
> [4313355.425000] Code: 85 c0 74 c3 f3 90 0f b6 06 84 c0 7e f0 eb b8 90 e8 60 
> f2 ff ff eb d1 56 53 89 c6 bb 00 e0 ff ff 21 e3 83 43 14 01 9c 5a fa 31 c0 
> <86> 06 84 c0 7e 0c c7 46 04 00 00 00 00 89 d0 5b 5e c3 52 9d 83
> [4313355.425000] EIP: [<c03c377b>] _spin_lock_irqsave+0x14/0x61 SS:ESP 
> 0068:f7e6dc94
> [4313355.425000]  <6>note: mount[22892] exited with preempt_count 1
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Deleting the old raid5 (had data backed up before I tried this), oh, and 
incase you are wondering, I rebooted and everything was fine, but I think 
the 512kb chunksize is my problem.  So I am deleting this array and then I 
am going to create the smallest raid5 possibly with 3 drives and then try 
to grow again.




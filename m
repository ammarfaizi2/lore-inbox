Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269838AbUJMUmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269838AbUJMUmc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 16:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269837AbUJMUmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 16:42:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:16582 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S269838AbUJMUmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 16:42:23 -0400
Message-ID: <416D9139.1060200@osdl.org>
Date: Wed, 13 Oct 2004 13:34:01 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Fitzpatrick <brad@danga.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [OOPS] 2.6.9-rc4, dual Opteron, NUMA, 8GB
References: <Pine.LNX.4.58.0410131204580.31327@danga.com> <416D8999.7080102@pobox.com> <Pine.LNX.4.58.0410131302190.31327@danga.com> <416D8C33.9080401@osdl.org> <Pine.LNX.4.58.0410131328400.31327@danga.com>
In-Reply-To: <Pine.LNX.4.58.0410131328400.31327@danga.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Fitzpatrick wrote:
> On Wed, 13 Oct 2004, Randy.Dunlap wrote:
> 
> 
>>Brad Fitzpatrick wrote:
>>
>>>On Wed, 13 Oct 2004, Jeff Garzik wrote:
>>>
>>>
>>>
>>>>Brad Fitzpatrick wrote:
>>>>
>>>>
>>>>>I'm reporting an oops.  Details follow.
>>>>>
>>>>>I have two of these machines.  I will happily be anybody's guinea pig
>>>>>to debug this.  (more details, access to machine, try patches, kernels...)
>>>>>Machines aren't in production.
>>>>>
>>>>>- Brad
>>>>>
>>>>>
>>>>>Kernel:  2.6.9-rc4 vanilla (.config below)
>>>>>
>>>>>Hardware:  IBM eServer 325, Dual Opteron 8GB ram (more info below)
>>>>>
>>>>>Pre-crash and crash:
>>>>>
>>>>>a1:~# mke2fs /dev/mapper/raid10-data
>>>>>mke2fs 1.35 (28-Feb-2004)
>>>>>Filesystem label=
>>>>>OS type: Linux
>>>>>Block size=4096 (log=2)
>>>>>Fragment size=4096 (log=2)
>>>>>25608192 inodes, 51200000 blocks
>>>>>2560000 blocks (5.00%) reserved for the super user
>>>>>First data block=0
>>>>>1563 block groups
>>>>>32768 blocks per group, 32768 fragments per group
>>>>>16384 inodes per group
>>>>>Superblock backups stored on blocks:
>>>>>       32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
>>>>>       4096000, 7962624, 11239424, 20480000, 23887872
>>>>>
>>>>>Writing inode tables: 1091/1563
>>>>>Message from syslogd@localhost at Wed Oct 13 11:46:01 2004 ...
>>>>>localhost kernel: Oops: 0000 [1] SMP
>>>>>
>>>>>Message from syslogd@localhost at Wed Oct 13 11:46:01 2004 ...
>>>>>localhost kernel: CR2: 0000000000001770
>>>>
>>>>
>>>>What's your block device configuration?  What block devices are sitting
>>>>on top of what other block devices?
>>>
>>>
>>>/dev/mapper/raid10-data is a LV taking 200GB of a 280GB VG ("raid10") with
>>>a single PV in it:  /dev/sdb1 -- ips driver, IBM ServeRAID 6M card,
>>>representing a RAID 10 atop 8 SCSI disks.
>>>
>>>I just made a new kernel without NUMA and made a filesystem on /dev/sdb1
>>>directly instead of using LVM and it worked fine, if not a little slowly.
>>>
>>>Now that I know it /can/ work, I'll try and narrow down whose fault it is:
>>>NUMA or LVM.
>>
>>Very similar to
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=109328505204081&w=2
>>and its follow-up:
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=109330259511819&w=2
>>
>>but no solutions there.
> 
> 
> Well, good to know I'm not alone?  :-)
> 
> I was just about to mail and report that disabling NUMA does help:
> 
>    NUMA + mke2fs on LVM:      OOPS  (mailed earlier)
> no NUMA + mke2fs on LVM:      okay
>    NUMA + mke2fs on sdb1:     OOPS  (below)
> no NUMA + mke2fs on sdb1:     okay
> 
> no NUMA + mount e2fs on LVM:  okay
> no NUMA + mount e2fs on sb1:  okay
>    NUMA + mount e2fs on LVM:  okay
>    NUMA + mount e2fs on sb1:  untested, assume okay
> 
> 
> OOPs when doing mke2fs on /dev/sdb1, with NUMA enabled:
> 
> Oct 13 13:24:37 localhost kernel: Unable to handle kernel paging request at 0000000000001770 RIP:
> Oct 13 13:24:37 localhost kernel: <ffffffff8015efe4>{kmem_getpages+132}
> Oct 13 13:24:37 localhost kernel: PML4 1f8fe6067 PGD 1f8fef067 PMD 0
> Oct 13 13:24:37 localhost kernel: Oops: 0000 [1] SMP
> Oct 13 13:24:37 localhost kernel: CPU 0
> Oct 13 13:24:37 localhost kernel: Modules linked in: af_packet tsdev mousedev joydev usbhid ohci_hcd hw_random amd74xx evdev tg3 dm_mod ide_generic ide_cd ide_core cdrom rtc ext3 jbd mbcache sd_mod ips mptscsih mptbase scsi_mod unix
> Oct 13 13:24:37 localhost kernel: Pid: 3145, comm: mke2fs Not tainted 2.6.9-rc4
> Oct 13 13:24:37 localhost kernel: RIP: 0010:[kmem_getpages+132/432] <ffffffff8015efe4>{kmem_getpages+132}
> Oct 13 13:24:37 localhost kernel: RSP: 0018:00000101f81b7aa8  EFLAGS: 00010213
> Oct 13 13:24:37 localhost kernel: RAX: ffffffff7fffffff RBX: 00000101fffc9680 RCX: 0000000000000000
> Oct 13 13:24:37 localhost kernel: RDX: 0000010000011700 RSI: 00000100000119c0 RDI: 0000010000012500
> Oct 13 13:24:37 localhost kernel: RBP: 00000101fffc9680 R08: 000001016bc01000 R09: 00000101fffc96e8
> Oct 13 13:24:37 localhost kernel: R10: 0000000000000000 R11: 00000000fffffffa R12: 00000101fffc9680
> Oct 13 13:24:37 localhost kernel: R13: 0000000000000000 R14: 00000101fffc9728 R15: 0000000000000001
> Oct 13 13:24:37 localhost kernel: FS:  0000002a95ddb4a0(0000) GS:ffffffff803df300(0000) knlGS:0000000000000000
> Oct 13 13:24:37 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> Oct 13 13:24:37 localhost kernel: CR2: 0000000000001770 CR3: 0000000000101000 CR4: 00000000000006e0
> Oct 13 13:24:37 localhost kernel: Process mke2fs (pid: 3145, threadinfo 00000101f81b6000, task 00000101fe9b4030)
> Oct 13 13:24:37 localhost kernel: Stack: 000001016c3fa000 0000000000000000 0000000000000050 ffffffff8015ff6e
> Oct 13 13:24:37 localhost kernel:        0000005000000010 000000000000003c 00000100fbf6b000 00000101fffc9680
> Oct 13 13:24:37 localhost kernel:        00000101fffc96c8 00000101fffc9728
> Oct 13 13:24:37 localhost kernel: Call Trace:<ffffffff8015ff6e>{cache_grow+190} <ffffffff801601c6>{cache_alloc_refill+422}
> Oct 13 13:24:37 localhost kernel:        <ffffffff801604b6>{kmem_cache_alloc+54} <ffffffff8017d761>{alloc_buffer_head+17}
> Oct 13 13:24:37 localhost kernel:        <ffffffff8017aeba>{create_buffers+42} <ffffffff8017b884>{create_empty_buffers+20}
> Oct 13 13:24:37 localhost kernel:        <ffffffff8017bcdf>{__block_prepare_write+175} <ffffffff80180190>{blkdev_get_block+0}
> Oct 13 13:24:37 localhost kernel:        <ffffffff8017c78a>{block_prepare_write+26} <ffffffff80158dc4>{generic_file_buffered_write+404}
> Oct 13 13:24:37 localhost kernel:        <ffffffff80193fae>{inode_update_time+158} <ffffffff801594dd>{generic_file_aio_write_nolock+765}
> Oct 13 13:24:37 localhost kernel:        <ffffffff801595b5>{generic_file_write_nolock+165} <ffffffff80134ef3>{__wake_up+67}
> Oct 13 13:24:37 localhost kernel:        <ffffffff802a46fe>{thread_return+41} <ffffffff80136890>{autoremove_wake_function+0}
> Oct 13 13:24:37 localhost kernel:        <ffffffff8018128a>{blkdev_file_write+26} <ffffffff801789e4>{vfs_write+228}
> Oct 13 13:24:37 localhost kernel:        <ffffffff80178b13>{sys_write+83} <ffffffff8011195a>{system_call+126}
> Oct 13 13:24:37 localhost kernel:
> Oct 13 13:24:37 localhost kernel:
> Oct 13 13:24:37 localhost kernel: Code: 48 8b 91 70 17 00 00 76 07 b8 00 00 00 80 eb 0a 48 b8 00 00
> Oct 13 13:24:37 localhost kernel: RIP <ffffffff8015efe4>{kmem_getpages+132} RSP <00000101f81b7aa8>
> Oct 13 13:24:37 localhost kernel: CR2: 0000000000001770
> 
> 
> 
> Randy, if you're interested and you're actually at OSDL Beaverton, I'm
> just across the street from you.  I could carry this 1U server and 3U
> drive cabinet over to you!  :)

I am at the Round in Beaverton.  It might be easier for me to go to
the server. :)

> Who's responsible for the K8_NUMA stuff?  I'd love to work with them to
> narrow this down.

Andi Kleen (SUSE).  Copied.

-- 
~Randy

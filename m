Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWGaKE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWGaKE7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 06:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWGaKE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 06:04:59 -0400
Received: from [219.153.9.10] ([219.153.9.10]:14227 "EHLO iblink.com.cn")
	by vger.kernel.org with ESMTP id S1751310AbWGaKE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 06:04:58 -0400
Message-ID: <44CDD5B9.8020608@idccenter.cn>
Date: Mon, 31 Jul 2006 18:04:41 +0800
From: kernel <linux@idccenter.cn>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>, jdi@l4x.org, lkmaillist@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: XFS Bug null pointer dereference in xfs_free_ag_extent
References: <44BF29CD.1000809@l4x.org> <44CB0BF7.6030204@idccenter.cn> <44CB1303.7010303@l4x.org> <20060731094424.E2280998@wobbly.melbourne.sgi.com> <44CDA156.6000105@idccenter.cn> <20060731165522.K2280998@wobbly.melbourne.sgi.com> <44CDB135.8080401@idccenter.cn> <20060731194310.A2301615@wobbly.melbourne.sgi.com>
In-Reply-To: <20060731194310.A2301615@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=GB18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've revent one of the patch,the other one will test today.

command lines: bonnie++ -u user     (user is a common user not 
root,bonnie++'s version is 1.03a)

[root@test hv]# xfs_info /dev/sdc1
meta-data=/dev/sdc1              isize=256    agcount=32, 
agsize=13926368 blks
         =                       sectsz=4096  attr=0
data     =                       bsize=4096   blocks=445643072, imaxpct=25
         =                       sunit=32     swidth=448 blks, unwritten=1
naming   =version 2              bsize=4096 
log      =internal               bsize=4096   blocks=32768, version=2
         =                       sectsz=4096  sunit=1 blks
realtime =none                   extsz=65536  blocks=0, rtextents=0

I'vs format partation with several different mkfs.xfs options.
mkfs.xfs /dev/sdc1
mkfs.xfs -l version=2,size=128m(64m,32m) /dev/sdc1
mkfs.xfs -l version=2,size=128m(64m,32m) -d su=128k,sw=14 -s size=4k 
/dev/sdc1
mkfs.xfs -s size=4k /dev/sdc1

with DEBUG patch, I got this...

Assertion failed: args.agbp != ((void *)0), file: fs/xfs/xfs_alloc.c, 
line: 2467
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at fs/xfs/support/debug.c:83
invalid opcode: 0000 [1] SMP
CPU 3
Modules linked in: qla2xxx scsi_transport_fc
Pid: 4931, comm: bonnie++ Not tainted 2.6.18-rc3 #1
RIP: 0010:[<ffffffff8032cc1c>]  [<ffffffff8032cc1c>] assfail+0x1a/0x29
RSP: 0018:ffff81007e99fd38  EFLAGS: 00010296
RAX: 0000000000000054 RBX: 0000000000000000 RCX: ffffffff804df348
RDX: ffffffff804df348 RSI: 0000000000040096 RDI: ffffffff804df340
RBP: ffff81007c413568 R08: ffff81007ef9f000 R09: 0000000000000080
R10: 0000000000000000 R11: 0000000000000080 R12: 0000000000000004
R13: 0000000000000000 R14: ffff81007e99fe38 R15: ffff810068340e70
FS:  00002b271d6359e0(0000) GS:ffff810002f68940(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000000050f298 CR3: 000000007e877000 CR4: 00000000000006e0
Process bonnie++ (pid: 4931, threadinfo ffff81007e99e000, task 
ffff81007c6f0000)
Stack:  ffff810068340e70 ffffffff802c0e49 ffff81007c413568 ffff81007cc77800
 0000000000000000 ffff81007e92d028 0000000000000000 0000002400000001
 0000000000000000 0000000000000001 ffff810000000000 0000000000000001
Call Trace:
 [<ffffffff802c0e49>] xfs_free_extent+0x105/0x173
 [<ffffffff80315156>] xfs_trans_get_efd+0x7e/0x86
 [<ffffffff802d3599>] xfs_bmap_finish+0x119/0x1b4
 [<ffffffff8031bcad>] xfs_inactive+0x510/0x549
 [<ffffffff8032b382>] xfs_fs_clear_inode+0xa7/0x118
 [<ffffffff8028342a>] clear_inode+0x97/0xca
 [<ffffffff802844d1>] generic_delete_inode+0x8e/0xf6
 [<ffffffff8027bc4f>] do_unlinkat+0xde/0x131
 [<ffffffff8027de50>] sys_getdents64+0xaa/0xba
 [<ffffffff8027d2a5>] sys_fcntl+0x2fd/0x309
 [<ffffffff802099c6>] system_call+0x7e/0x83


Code: 0f 0b 68 91 0e 47 80 c2 53 00 48 83 c4 08 c3 48 8b 35 26 5e
RIP  [<ffffffff8032cc1c>] assfail+0x1a/0x29
 RSP <ffff81007e99fd38>



Nathan Scott wrote:
> On Mon, Jul 31, 2006 at 03:28:53PM +0800, kernel wrote:
>   
>> I format the same partition and restart the testing server before each 
>> testing.
>> I'vs tested on each format at least twenty times.
>> With XFS and SAN, This crash happens on every bonnie++ testing.
>>     
>
> Its not clear to me - are you testing with the patches I mentioned
> earlier reverted or not?
>
>   
>> And I have tested such things on another mathine, results are same.
>>     
>
> Can you send me the xfs_info output from one of these filesystems,
> and the exact bonnie++ command line used so I can reproduce it here?
>
> thanks.
>
>   

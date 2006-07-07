Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWGGJRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWGGJRI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWGGJRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:17:07 -0400
Received: from tornado.reub.net ([202.89.145.182]:24549 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932079AbWGGJRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:17:06 -0400
Message-ID: <44AE268F.7080409@reub.net>
Date: Fri, 07 Jul 2006 21:17:03 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060706)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>
In-Reply-To: <20060703030355.420c7155.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/07/2006 10:03 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/
> 
> 
> - A major update to the e1000 driver.
> 
> - 1394 updates

This release has been working quite well after some initial hiccups (see -mm 
hotfix), but a couple of hours ago another bad thing (tm) happened.

At the time I was moving 100G of data from one partition on a non-raid partition 
to a new RAID-1 md that I had created earlier.  Both are ext3 partitions.

The word "barrier" of course comes to mind again, I'm not sure NeilB is the 
culprit this time either but I've cc'd him in just in case.

The file copy went on happily for quite a while (maybe 10 mins or so) under very 
high IO load before blowing up as below.  The terminal was spewing out constant 
traces but hopefully the right ones are here as these are the first few (if not, 
I have copied a bit more).


sh-3.1# mv /store-old/* /store/
Unable to handle kernel paging request at ffff81043e345490 RIP:
  [<ffffffff802620f2>] memcpy+0x12/0xb0
PGD 8063 PUD 0
Oops: 0000 [1] SMP
last sysfs file: /kernel/uevent_seqnum
CPU 1
Modules linked in: binfmt_misc ide_cd iTCO_wdt i2c_i801 cdrom serio_raw ide_disk
Pid: 165, comm: pdflush Not tainted 2.6.17-mm6 #2
RIP: 0010:[<ffffffff802620f2>]  [<ffffffff802620f2>] memcpy+0x12/0xb0
RSP: 0018:ffff81003ed31828  EFLAGS: 00010002
RAX: ffff810001faec18 RBX: 0000000000000010 RCX: 0000000000000001
RDX: 0000000000000080 RSI: ffff81043e345490 RDI: ffff810001faec18
RBP: ffff81003ed31898 R08: ffff81003f66a800 R09: 0000000000000000
R10: ffff810029b364b0 R11: 0000000000000000 R12: ffff810001faec00
R13: ffff81003f6ff140 R14: ffff81003f6ea240 R15: 0000000000000010
FS:  0000000000000000(0000) GS:ffff810037ffe440(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffff81043e345490 CR3: 000000003dc32000 CR4: 00000000000006e0
Process pdflush (pid: 165, threadinfo ffff81003ed30000, task ffff810037f2b840)
Stack:  0000000000000010 ffffffff8025e9f0 ffff81003f66a800 0001120000000000
  0000000000011200 000112003f650080 ffff81003eca39f0 ffff81003ed318c8
  ffff81003ed31898 0000000000000246 ffff81003f6ff140 0000000000011200
Call Trace:
  [<ffffffff8025e9f0>] cache_alloc_refill+0xc9/0x538
  [<ffffffff802b96c6>] __kmalloc+0x86/0x96
  [<ffffffff802ae460>] __kzalloc+0xf/0x2f
  [<ffffffff8041d598>] r1bio_pool_alloc+0x21/0x3a
  [<ffffffff802230e4>] mempool_alloc+0x44/0xfb
  [<ffffffff8041d1c4>] wait_barrier+0x20/0xfc
  [<ffffffff802bd143>] __bio_clone+0x84/0xa2
  [<ffffffff8041e072>] make_request+0xf2/0x611
  [<ffffffff802a97d8>] mempool_alloc_slab+0x11/0x13
  [<ffffffff8021c387>] generic_make_request+0x20d/0x256
  [<ffffffff8027f831>] __wake_up_common+0x41/0x71
  [<ffffffff80234c11>] submit_bio+0xd7/0xe6
  [<ffffffff8021aa6c>] submit_bh+0x100/0x126
  [<ffffffff8021c5ad>] __block_write_full_page+0x1dd/0x2ea
  [<ffffffff80310550>] ext3_get_block+0x0/0xf0
  [<ffffffff80310550>] ext3_get_block+0x0/0xf0
  [<ffffffff80217007>] block_write_full_page+0xa7/0xb0
  [<ffffffff80311df2>] ext3_ordered_writepage+0xfa/0x1aa
  [<ffffffff8021cdc6>] mpage_writepages+0x1f6/0x3ce
  [<ffffffff80311cf8>] ext3_ordered_writepage+0x0/0x1aa
  [<ffffffff80262fb5>] thread_return+0x0/0xcc
  [<ffffffff8025e345>] do_writepages+0x35/0x40
  [<ffffffff80231264>] __writeback_single_inode+0x1d4/0x3b0
  [<ffffffff802ccbbb>] generic_sync_sb_inodes+0x20b/0x300
  [<ffffffff80220cf5>] sync_sb_inodes+0x25/0x30
  [<ffffffff8025312d>] writeback_inodes+0x8d/0xd9
  [<ffffffff802ab723>] background_writeout+0x8f/0xc7
  [<ffffffff80259370>] pdflush+0x0/0x1e2
  [<ffffffff802594a7>] pdflush+0x137/0x1e2
  [<ffffffff802ab694>] background_writeout+0x0/0xc7
  [<ffffffff80259370>] pdflush+0x0/0x1e2
  [<ffffffff80234163>] kthread+0xd3/0x100
  [<ffffffff80260a02>] child_rip+0x8/0x12
  [<ffffffff80234090>] kthread+0x0/0x100
  [<ffffffff802609fa>] child_rip+0x0/0x12


Code: 4c 8b 1e 4c 8b 46 08 4c 89 1f 4c 89 47 08 4c 8b 4e 10 4c 8b
RIP  [<ffffffff802620f2>] memcpy+0x12/0xb0
  RSP <ffff81003ed31828>
CR2: ffff81043e345490
  <1>Unable to handle kernel paging request at ffff81003f800000 RIP:
  [<ffffffff80262114>] memcpy+0x34/0xb0
PGD 8063 PUD 9063 PMD 0
Oops: 0000 [2] SMP
last sysfs file: /kernel/uevent_seqnum
CPU 0
Modules linked in: binfmt_misc ide_cd iTCO_wdt i2c_i801 cdrom serio_raw ide_disk
Pid: 6, comm: events/0 Not tainted 2.6.17-mm6 #2
RIP: 0010:[<ffffffff80262114>]  [<ffffffff80262114>] memcpy+0x34/0xb0
RSP: 0018:ffff810037f51db8  EFLAGS: 00010003
RAX: ffff81003f660018 RBX: ffff81003f660018 RCX: 0000000003ff9807
RDX: 00000007fffffee0 RSI: ffff81003f7fffd8 RDI: ffff81003f7ffcd8
RBP: ffff810037f51dc8 R08: ffffffffffffffff R09: ffffffffffffffff
R10: ffffffffffffffff R11: ffffffffffffffff R12: ffff81003f660000
R13: 0000000000000060 R14: 0000000000000000 R15: ffff81003f6eadc0
FS:  0000000000000000(0000) GS:ffffffff8068a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffff81003f800000 CR3: 000000003dc32000 CR4: 00000000000006e0
Process events/0 (pid: 6, threadinfo ffff810037f50000, task ffff810037fef800)
Stack:  ffff81003f660018 ffffffff80222b5e ffff810037f51e08 ffffffff802b93b8
  ffff81003f6ff140 ffff81003f6eadc0 ffff81003f6ff140 ffff810037ffe3c0
  0000000000000000 0000000000000292 ffff810037f51e28 ffffffff802b9d83
Call Trace:
  [<ffffffff80222b5e>] memmove+0xe/0x3f
  [<ffffffff802b93b8>] drain_array+0xe8/0x100
  [<ffffffff802b9d83>] cache_reap+0xb2/0x12f
  [<ffffffff8024f488>] run_workqueue+0xb7/0x109
  [<ffffffff802b9cd1>] cache_reap+0x0/0x12f
  [<ffffffff8024bab0>] worker_thread+0x120/0x159
  [<ffffffff80280dbb>] default_wake_function+0x0/0xf
  [<ffffffff8024b990>] worker_thread+0x0/0x159
  [<ffffffff80234163>] kthread+0xd3/0x100
  [<ffffffff80260a02>] child_rip+0x8/0x12
  [<ffffffff80234090>] kthread+0x0/0x100
  [<ffffffff802609fa>] child_rip+0x0/0x12


Code: 4c 8b 46 28 4c 89 5f 20 4c 89 47 28 4c 8b 4e 30 4c 8b 56 38
RIP  [<ffffffff80262114>] memcpy+0x34/0xb0
  RSP <ffff810037f51db8>
CR2: ffff81003f800000
  <0>general protection fault: 0000 [3] SMP
last sysfs file: /kernel/uevent_seqnum
CPU 1
Modules linked in: binfmt_misc ide_cd iTCO_wdt i2c_i801 cdrom serio_raw ide_disk
Pid: 165, comm: pdflush Not tainted 2.6.17-mm6 #2
RIP: 0010:[<ffffffff802b8f37>]  [<ffffffff802b8f37>] __cache_free+0x25/0x118
RSP: 0018:ffff81003ed31568  EFLAGS: 00010092
RAX: 0000000000000001 RBX: ffff81003f6e9cc0 RCX: ffff810037f98238
RDX: 0000000000000000 RSI: ffff81003f25e140 RDI: ffff81003f6e9cc0
RBP: ffff81003ed315a8 R08: ffff810001fa62d0 R09: ffff810001fa62e0
R10: ffff810001fa62d0 R11: 000000000000137b R12: ffd9fe7e6ffffebb
R13: ffff81003f25e140 R14: ffff810037f2b8f0 R15: ffff810037f2b968
FS:  0000000000000000(0000) GS:ffff810037ffe440(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffff81043e345490 CR3: 000000003dc32000 CR4: 00000000000006e0
Process pdflush (pid: 165, threadinfo ffff81003ed30000, task ffff810037f2b840)
Stack:  00000000000000a5 0000000000000009 0000000000000000 0000000000000046
  ffff810037f2b840 ffff81003f25e140 ffff810037f2b8f0 ffff810037f2b968
  ffff81003ed315c8 ffffffff80207527 0000000000000000 ffff810001fa6080
Call Trace:
  [<ffffffff80207527>] kmem_cache_free+0x7f/0x88
  [<ffffffff80283573>] __cleanup_sighand+0x20/0x22
  [<ffffffff80217bb1>] release_task+0x241/0x315
  [<ffffffff80215c5b>] do_exit+0x8ba/0x94b
  [<ffffffff8039a6f2>] unblank_screen+0xb/0xd
  [<ffffffff8020ac17>] do_page_fault+0x7a7/0x893
  [<ffffffff80294909>] autoremove_wake_function+0x11/0x48
  [<ffffffff8027f831>] __wake_up_common+0x41/0x71
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff802620f2>] memcpy+0x12/0xb0
  [<ffffffff8025e9f0>] cache_alloc_refill+0xc9/0x538
  [<ffffffff802b96c6>] __kmalloc+0x86/0x96
  [<ffffffff802ae460>] __kzalloc+0xf/0x2f
  [<ffffffff8041d598>] r1bio_pool_alloc+0x21/0x3a
  [<ffffffff802230e4>] mempool_alloc+0x44/0xfb
  [<ffffffff8041d1c4>] wait_barrier+0x20/0xfc
  [<ffffffff802bd143>] __bio_clone+0x84/0xa2
  [<ffffffff8041e072>] make_request+0xf2/0x611
  [<ffffffff802a97d8>] mempool_alloc_slab+0x11/0x13
  [<ffffffff8021c387>] generic_make_request+0x20d/0x256
  [<ffffffff8027f831>] __wake_up_common+0x41/0x71
  [<ffffffff80234c11>] submit_bio+0xd7/0xe6
  [<ffffffff8021aa6c>] submit_bh+0x100/0x126
  [<ffffffff8021c5ad>] __block_write_full_page+0x1dd/0x2ea
  [<ffffffff80310550>] ext3_get_block+0x0/0xf0
  [<ffffffff80310550>] ext3_get_block+0x0/0xf0
  [<ffffffff80217007>] block_write_full_page+0xa7/0xb0
  [<ffffffff80311df2>] ext3_ordered_writepage+0xfa/0x1aa
  [<ffffffff8021cdc6>] mpage_writepages+0x1f6/0x3ce
  [<ffffffff80311cf8>] ext3_ordered_writepage+0x0/0x1aa
  [<ffffffff80262fb5>] thread_return+0x0/0xcc
  [<ffffffff8025e345>] do_writepages+0x35/0x40
  [<ffffffff80231264>] __writeback_single_inode+0x1d4/0x3b0
  [<ffffffff802ccbbb>] generic_sync_sb_inodes+0x20b/0x300
  [<ffffffff80220cf5>] sync_sb_inodes+0x25/0x30
  [<ffffffff8025312d>] writeback_inodes+0x8d/0xd9
  [<ffffffff802ab723>] background_writeout+0x8f/0xc7
  [<ffffffff80259370>] pdflush+0x0/0x1e2
  [<ffffffff802594a7>] pdflush+0x137/0x1e2
  [<ffffffff802ab694>] background_writeout+0x0/0xc7
  [<ffffffff80259370>] pdflush+0x0/0x1e2
  [<ffffffff80234163>] kthread+0xd3/0x100
  [<ffffffff80260a02>] child_rip+0x8/0x12
  [<ffffffff80234090>] kthread+0x0/0x100
  [<ffffffff802609fa>] child_rip+0x0/0x12


Code: 41 8b 14 24 41 3b 54 24 04 73 13 89 d0 49 89 74 c4 18 8d 42
RIP  [<ffffffff802b8f37>] __cache_free+0x25/0x118
  RSP <ffff81003ed31568>
  <1>Unable to handle kernel paging request at ffffffffffff4e87 RIP:
  [<ffffffff8029144a>] delayed_work_timer_fn+0x2c/0x37
PGD 203027 PUD 1deb067 PMD 0
Oops: 0000 [4] SMP
last sysfs file: /kernel/uevent_seqnum
CPU 1
Modules linked in: binfmt_misc ide_cd iTCO_wdt i2c_i801 cdrom serio_raw ide_disk
Pid: 165, comm: pdflush Not tainted 2.6.17-mm6 #2
RIP: 0010:[<ffffffff8029144a>]  [<ffffffff8029144a>] delayed_work_timer_fn+0x2c/0x37
RSP: 0018:ffff81003f617ed0  EFLAGS: 00010216
RAX: ffffffffffff4e7f RBX: ffff81003f60c000 RCX: ffff81003f6eb780
RDX: 0000000000000001 RSI: ffff810001dfa440 RDI: ffff810001dfa440
RBP: ffff81003f617ed0 R08: ffff810001dfa0e0 R09: ffff810001df9900
R10: 0000000000000000 R11: 00000000ffffffff R12: ffff81003f617ee0
R13: 0000000000000100 R14: ffffffff8029141e R15: 000000000000000a
FS:  0000000000000000(0000) GS:ffff810037ffe440(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffffffff4e87 CR3: 000000003dc32000 CR4: 00000000000006e0
Process pdflush (pid: 165, threadinfo ffff81003ed30000, task ffff810037f2b840)
Stack:  ffff81003f617f10 ffffffff8028afd9 ffff81003f617ee0 ffff81003f617ee0
  0000000000000001 ffffffff8068a410 ffffffff806dd020 0000000000000001
  ffff81003f617f50 ffffffff80211f6e 0000000000000001 0000000000000046
Call Trace:
  <IRQ> [<ffffffff8028afd9>] run_timer_softirq+0x149/0x1d0
  [<ffffffff80211f6e>] __do_softirq+0x63/0xe5
  [<ffffffff80260d52>] call_softirq+0x1e/0x28
  [<ffffffff8026a723>] do_softirq+0x34/0x8b
  [<ffffffff80287418>] irq_exit+0x48/0x4a
  [<ffffffff80271b72>] smp_apic_timer_interrupt+0x4e/0x55
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [5] SMP
last sysfs file: /kernel/uevent_seqnum
CPU 1
Modules linked in: binfmt_misc ide_cd iTCO_wdt i2c_i801 cdrom serio_raw ide_disk
Pid: 165, comm: pdflush Not tainted 2.6.17-mm6 #2
RIP: 0010:[<ffffffff80268f00>]  [<ffffffff80268f00>] show_trace+0x180/0x1c2
RSP: 0018:ffff81003f617c18  EFLAGS: 00010002
RAX: 0000000000000000 RBX: 5fd7539830a2b4e5 RCX: ffffffff88029988
RDX: 0000000000000000 RSI: 0000000000000046 RDI: ffffffff8057db08
RBP: ffff81003f617c58 R08: 0000000000009bb3 R09: 00000000ffffffff
R10: 0000000000000000 R11: 00000000fffffffb R12: ffffffff827ffffd
R13: 0000000000000000 R14: ffffffff806d8000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff810037ffe440(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 000000003dc32000 CR4: 00000000000006e0
Process pdflush (pid: 165, threadinfo ffff81003ed30000, task ffff810037f2b840)
Stack:  0000000000009951 0000000000000001 000000003f617c58 ffff81003f617f28
  000000000000000c ffff81003f613fc0 ffff81003f617fc0 0000000000000000
  ffff81003f617ca8 ffffffff80269049 ffffffff805759c7 ffff81003f617e28
Call Trace:
  <IRQ> [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff8027fe48>] task_rq_lock+0x3c/0x71
  [<ffffffff80280480>] find_busiest_group+0x260/0x6e0
  [<ffffffff8029141e>] delayed_work_timer_fn+0x0/0x37
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff8029141e>] delayed_work_timer_fn+0x0/0x37
  [<ffffffff8029144a>] delayed_work_timer_fn+0x2c/0x37
  [<ffffffff8028afd9>] run_timer_softirq+0x149/0x1d0
  [<ffffffff80211f6e>] __do_softirq+0x63/0xe5
  [<ffffffff80260d52>] call_softirq+0x1e/0x28
  [<ffffffff8026a723>] do_softirq+0x34/0x8b
  [<ffffffff80287418>] irq_exit+0x48/0x4a
  [<ffffffff80271b72>] smp_apic_timer_interrupt+0x4e/0x55
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [6] SMP
last sysfs file: /kernel/uevent_seqnum
CPU 1
Modules linked in: binfmt_misc ide_cd iTCO_wdt i2c_i801 cdrom serio_raw ide_disk
Pid: 165, comm: pdflush Not tainted 2.6.17-mm6 #2
RIP: 0010:[<ffffffff80268f00>]  [<ffffffff80268f00>] show_trace+0x180/0x1c2
RSP: 0018:ffff81003f617958  EFLAGS: 00010002
RAX: 0000000000000000 RBX: 5fd7539830a2b4e5 RCX: ffffffff88029988
RDX: 0000000000000000 RSI: 0000000000000046 RDI: ffffffff8057db08
RBP: ffff81003f617998 R08: 000000000000a46d R09: 00000000ffffffff
R10: 0000000000000000 R11: 00000000fffffffb R12: ffffffff827ffffd
R13: 0000000000000000 R14: ffffffff806d8000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff810037ffe440(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 000000003dc32000 CR4: 00000000000006e0
Process pdflush (pid: 165, threadinfo ffff81003ed30000, task ffff810037f2b840)
Stack:  000000000000a00f 0000000000000001 000000003f617998 ffff81003f617c70
  000000000000000c ffff81003f613fc0 ffff81003f617fc0 0000000000000000
  ffff81003f6179e8 ffffffff80269049 ffffffff805759c7 ffff81003f617b68
Call Trace:
  <IRQ> [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff8027fe48>] task_rq_lock+0x3c/0x71
  [<ffffffff80280480>] find_busiest_group+0x260/0x6e0
  [<ffffffff8029141e>] delayed_work_timer_fn+0x0/0x37
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff8029141e>] delayed_work_timer_fn+0x0/0x37
  [<ffffffff8029144a>] delayed_work_timer_fn+0x2c/0x37
  [<ffffffff8028afd9>] run_timer_softirq+0x149/0x1d0
  [<ffffffff80211f6e>] __do_softirq+0x63/0xe5
  [<ffffffff80260d52>] call_softirq+0x1e/0x28
  [<ffffffff8026a723>] do_softirq+0x34/0x8b
  [<ffffffff80287418>] irq_exit+0x48/0x4a
  [<ffffffff80271b72>] smp_apic_timer_interrupt+0x4e/0x55
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [7] SMP
last sysfs file: /kernel/uevent_seqnum
CPU 1
Modules linked in: binfmt_misc ide_cd iTCO_wdt i2c_i801 cdrom serio_raw ide_disk
Pid: 165, comm: pdflush Not tainted 2.6.17-mm6 #2
RIP: 0010:[<ffffffff80268f00>]  [<ffffffff80268f00>] show_trace+0x180/0x1c2
RSP: 0018:ffff81003f617698  EFLAGS: 00010002
RAX: 0000000000000000 RBX: 5fd7539830a2b4e5 RCX: ffffffff88029988
RDX: 0000000000000000 RSI: 0000000000000046 RDI: ffffffff8057db08
RBP: ffff81003f6176d8 R08: 000000000000af1b R09: 00000000ffffffff
R10: 0000000000000000 R11: 00000000fffffffb R12: ffffffff827ffffd
R13: 0000000000000000 R14: ffffffff806d8000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff810037ffe440(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 000000003dc32000 CR4: 00000000000006e0
Process pdflush (pid: 165, threadinfo ffff81003ed30000, task ffff810037f2b840)
Stack:  000000000000a8c9 0000000000000001 000000003f6176d8 ffff81003f6179b0
  000000000000000c ffff81003f613fc0 ffff81003f617fc0 0000000000000000
  ffff81003f617728 ffffffff80269049 ffffffff805759c7 ffff81003f6178a8
Call Trace:
  <IRQ> [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff8027fe48>] task_rq_lock+0x3c/0x71
  [<ffffffff80280480>] find_busiest_group+0x260/0x6e0
  [<ffffffff8029141e>] delayed_work_timer_fn+0x0/0x37
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff8029141e>] delayed_work_timer_fn+0x0/0x37
  [<ffffffff8029144a>] delayed_work_timer_fn+0x2c/0x37
  [<ffffffff8028afd9>] run_timer_softirq+0x149/0x1d0
  [<ffffffff80211f6e>] __do_softirq+0x63/0xe5
  [<ffffffff80260d52>] call_softirq+0x1e/0x28
  [<ffffffff8026a723>] do_softirq+0x34/0x8b
  [<ffffffff80287418>] irq_exit+0x48/0x4a
  [<ffffffff80271b72>] smp_apic_timer_interrupt+0x4e/0x55
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [8] SMP
last sysfs file: /kernel/uevent_seqnum
CPU 1
Modules linked in: binfmt_misc ide_cd iTCO_wdt i2c_i801 cdrom serio_raw ide_disk
Pid: 165, comm: pdflush Not tainted 2.6.17-mm6 #2
RIP: 0010:[<ffffffff80268f00>]  [<ffffffff80268f00>] show_trace+0x180/0x1c2
RSP: 0018:ffff81003f6173d8  EFLAGS: 00010002
RAX: 0000000000000000 RBX: 5fd7539830a2b4e5 RCX: ffffffff88029988
RDX: 0000000000000000 RSI: 0000000000000046 RDI: ffffffff8057db08
RBP: ffff81003f617418 R08: 000000000000bbbd R09: 00000000ffffffff
R10: 0000000000000000 R11: 00000000fffffffb R12: ffffffff827ffffd
R13: 0000000000000000 R14: ffffffff806d8000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff810037ffe440(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 000000003dc32000 CR4: 00000000000006e0
Process pdflush (pid: 165, threadinfo ffff81003ed30000, task ffff810037f2b840)
Stack:  000000000000b377 0000000000000001 000000003f617418 ffff81003f6176f0
  000000000000000c ffff81003f613fc0 ffff81003f617fc0 0000000000000000
  ffff81003f617468 ffffffff80269049 ffffffff805759c7 ffff81003f6175e8
Call Trace:
  <IRQ> [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff8027fe48>] task_rq_lock+0x3c/0x71
  [<ffffffff80280480>] find_busiest_group+0x260/0x6e0
  [<ffffffff8029141e>] delayed_work_timer_fn+0x0/0x37
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff8029141e>] delayed_work_timer_fn+0x0/0x37
  [<ffffffff8029144a>] delayed_work_timer_fn+0x2c/0x37
  [<ffffffff8028afd9>] run_timer_softirq+0x149/0x1d0
  [<ffffffff80211f6e>] __do_softirq+0x63/0xe5
  [<ffffffff80260d52>] call_softirq+0x1e/0x28
  [<ffffffff8026a723>] do_softirq+0x34/0x8b
  [<ffffffff80287418>] irq_exit+0x48/0x4a
  [<ffffffff80271b72>] smp_apic_timer_interrupt+0x4e/0x55
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [9] SMP
last sysfs file: /kernel/uevent_seqnum
CPU 1
Modules linked in: binfmt_misc ide_cd iTCO_wdt i2c_i801 cdrom serio_raw ide_disk
Pid: 165, comm: pdflush Not tainted 2.6.17-mm6 #2
RIP: 0010:[<ffffffff80268f00>]  [<ffffffff80268f00>] show_trace+0x180/0x1c2
RSP: 0018:ffff81003f617118  EFLAGS: 00010002
RAX: 0000000000000000 RBX: 5fd7539830a2b4e5 RCX: ffffffff88029988
RDX: 0000000000000000 RSI: 0000000000000046 RDI: ffffffff8057db08
RBP: ffff81003f617158 R08: 000000000000ca53 R09: 00000000ffffffff
R10: 0000000000000000 R11: 00000000fffffffb R12: ffffffff827ffffd
R13: 0000000000000000 R14: ffffffff806d8000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff810037ffe440(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 000000003dc32000 CR4: 00000000000006e0
Process pdflush (pid: 165, threadinfo ffff81003ed30000, task ffff810037f2b840)
Stack:  000000000000c019 0000000000000001 000000003f617158 ffff81003f617430
  000000000000000c ffff81003f613fc0 ffff81003f617fc0 0000000000000000
  ffff81003f6171a8 ffffffff80269049 ffffffff805759c7 ffff81003f617328
Call Trace:
  <IRQ> [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff8027fe48>] task_rq_lock+0x3c/0x71
  [<ffffffff80280480>] find_busiest_group+0x260/0x6e0
  [<ffffffff8029141e>] delayed_work_timer_fn+0x0/0x37
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff8029141e>] delayed_work_timer_fn+0x0/0x37
  [<ffffffff8029144a>] delayed_work_timer_fn+0x2c/0x37
  [<ffffffff8028afd9>] run_timer_softirq+0x149/0x1d0
  [<ffffffff80211f6e>] __do_softirq+0x63/0xe5
  [<ffffffff80260d52>] call_softirq+0x1e/0x28
  [<ffffffff8026a723>] do_softirq+0x34/0x8b
  [<ffffffff80287418>] irq_exit+0x48/0x4a
  [<ffffffff80271b72>] smp_apic_timer_interrupt+0x4e/0x55
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [10] SMP
last sysfs file: /kernel/uevent_seqnum
CPU 1
Modules linked in: binfmt_misc ide_cd iTCO_wdt i2c_i801 cdrom serio_raw ide_disk
Pid: 165, comm: pdflush Not tainted 2.6.17-mm6 #2
RIP: 0010:[<ffffffff80268f00>]  [<ffffffff80268f00>] show_trace+0x180/0x1c2
RSP: 0018:ffff81003f616e58  EFLAGS: 00010002
RAX: 0000000000000000 RBX: 5fd7539830a2b4e5 RCX: ffffffff88029988
RDX: 0000000000000000 RSI: 0000000000000046 RDI: ffffffff8057db08
RBP: ffff81003f616e98 R08: 000000000000dadd R09: 00000000ffffffff
R10: 0000000000000000 R11: 00000000fffffffb R12: ffffffff827ffffd
R13: 0000000000000000 R14: ffffffff806d8000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff810037ffe440(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 000000003dc32000 CR4: 00000000000006e0
Process pdflush (pid: 165, threadinfo ffff81003ed30000, task ffff810037f2b840)
Stack:  000000000000ceaf 0000000000000001 000000003f616e98 ffff81003f617170
  000000000000000c ffff81003f613fc0 ffff81003f617fc0 0000000000000000
  ffff81003f616ee8 ffffffff80269049 ffffffff805759c7 ffff81003f617068
Call Trace:
  <IRQ> [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff8027fe48>] task_rq_lock+0x3c/0x71
  [<ffffffff80280480>] find_busiest_group+0x260/0x6e0
  [<ffffffff8029141e>] delayed_work_timer_fn+0x0/0x37
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff8029141e>] delayed_work_timer_fn+0x0/0x37
  [<ffffffff8029144a>] delayed_work_timer_fn+0x2c/0x37
  [<ffffffff8028afd9>] run_timer_softirq+0x149/0x1d0
  [<ffffffff80211f6e>] __do_softirq+0x63/0xe5
  [<ffffffff80260d52>] call_softirq+0x1e/0x28
  [<ffffffff8026a723>] do_softirq+0x34/0x8b
  [<ffffffff80287418>] irq_exit+0x48/0x4a
  [<ffffffff80271b72>] smp_apic_timer_interrupt+0x4e/0x55
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [11] SMP
last sysfs file: /kernel/uevent_seqnum
CPU 1
Modules linked in: binfmt_misc ide_cd iTCO_wdt i2c_i801 cdrom serio_raw ide_disk
Pid: 165, comm: pdflush Not tainted 2.6.17-mm6 #2
RIP: 0010:[<ffffffff80268f00>]  [<ffffffff80268f00>] show_trace+0x180/0x1c2
RSP: 0018:ffff81003f616b98  EFLAGS: 00010002
RAX: 0000000000000000 RBX: 5fd7539830a2b4e5 RCX: ffffffff88029988
RDX: 0000000000000000 RSI: 0000000000000046 RDI: ffffffff8057db08
RBP: ffff81003f616bd8 R08: 000000000000ed5c R09: 00000000ffffffff
R10: 0000000000000000 R11: 00000000fffffffb R12: ffffffff827ffffd
R13: 0000000000000000 R14: ffffffff806d8000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff810037ffe440(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 000000003dc32000 CR4: 00000000000006e0
Process pdflush (pid: 165, threadinfo ffff81003ed30000, task ffff810037f2b840)
Stack:  000000000000df3a 0000000000000001 000000003f616bd8 ffff81003f616eb0
  000000000000000c ffff81003f613fc0 ffff81003f617fc0 0000000000000000
  ffff81003f616c28 ffffffff80269049 ffffffff805759c7 ffff81003f616da8
Call Trace:
  <IRQ> [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff80217237>] release_console_sem+0x1e7/0x23f
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff80268f00>] show_trace+0x180/0x1c2
  [<ffffffff80268f0c>] show_trace+0x18c/0x1c2
  [<ffffffff80269049>] _show_stack+0xe9/0xf8
  [<ffffffff802690e4>] show_registers+0x8c/0x101
  [<ffffffff802691f9>] __die+0xa0/0xe3
  [<ffffffff8020abf0>] do_page_fault+0x780/0x893
  [<ffffffff8027fe48>] task_rq_lock+0x3c/0x71
  [<ffffffff80280480>] find_busiest_group+0x260/0x6e0
  [<ffffffff8029141e>] delayed_work_timer_fn+0x0/0x37
  [<ffffffff80260849>] error_exit+0x0/0x84
  [<ffffffff8029141e>] delayed_work_timer_fn+0x0/0x37
  [<ffffffff8029144a>] delayed_work_timer_fn+0x2c/0x37
  [<ffffffff8028afd9>] run_timer_softirq+0x149/0x1d0
  [<ffffffff80211f6e>] __do_softirq+0x63/0xe5
  [<ffffffff80260d52>] call_softirq+0x1e/0x28
  [<ffffffff8026a723>] do_softirq+0x34/0x8b
  [<ffffffff80287418>] irq_exit+0x48/0x4a
  [<ffffffff80271b72>] smp_apic_timer_interrupt+0x4e/0x55
  [<ffffffff802606ed>] apic_timer_interrupt+0x65/0x6c
  <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
  [<ffffffff80268f00>] show_trace+0x180/0x1c2

reuben

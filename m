Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbVAQAxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbVAQAxt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 19:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVAQAxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 19:53:49 -0500
Received: from nacho.alt.net ([207.14.113.18]:37002 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S262656AbVAQAxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 19:53:43 -0500
Date: Sun, 16 Jan 2005 16:53:40 -0800 (PST)
To: linux-kernel@vger.kernel.org
Subject: bdev_lock deadlock in 2.6.10-ac8 / e1000 / rfc2385 patch
In-Reply-To: <Pine.LNX.4.44.0412171503510.22212-100000@nacho.alt.net>
Message-ID: <Pine.LNX.4.44.0501161644490.22840-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: Chris Caputo <ccaputo@alt.net>
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been seeing bdev_lock based deadlock's since 2.6.9.  Here's a latest
one with 2.6.10-ac8.  Not sure if the problem is related to the e1000
driver (with NAPI) or the rfc2385 patches or what.  Anyone else seeing
this?

Chris

--
2.6.10-ac8 + rfc2385 md5 patch:

<Jan/16 10:55 pm>SysRq : Show Regs
<Jan/16 10:55 pm>Pid: 820, comm:                   sh
<Jan/16 10:55 pm>EIP: 0060:[<c0309276>] CPU: 0
<Jan/16 10:55 pm>EIP is at _spin_lock+0x36/0x90
<Jan/16 10:55 pm> EFLAGS: 00000246    Not tainted  (2.6.10-ac8)
<Jan/16 10:55 pm>EAX: 00000000 EBX: 00000000 ECX: c0355300 EDX: c0414000
<Jan/16 10:55 pm>ESI: c03a1600 EDI: ffffffff EBP: c0414fc4 DS: 007b ES: 007b
<Jan/16 10:55 pm>CR0: 8005003b CR2: b7fd6f68 CR3: 02463000 CR4: 000006d0

>>EIP; c0309276 <_spin_lock+36/90>   <=====

>>ECX; c0355300 <contig_page_data+0/e00>
>>EDX; c0414000 <softirq_stack+0/4000>
>>ESI; c03a1600 <bdev_lock+0/80>
>>EDI; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>>EBP; c0414fc4 <softirq_stack+fc4/4000>

<Jan/16 10:55 pm> [<c02dc0f0>] defense_timer_handler+0x0/0x40
<Jan/16 10:55 pm> [<c015bbed>] nr_blockdev_pages+0xd/0x60
<Jan/16 10:55 pm>
<Jan/16 10:55 pm> [<c013a601>] si_meminfo+0x21/0x40
<Jan/16 10:55 pm> [<c02dbe97>] update_defense_level+0x17/0x270
<Jan/16 10:55 pm> [<c0121469>] __mod_timer+0xf9/0x140
<Jan/16 10:55 pm> [<c02336d4>] e1000_clean+0xb4/0xd0
<Jan/16 10:55 pm> [<c02dc0f0>] defense_timer_handler+0x0/0x40
<Jan/16 10:55 pm> [<c02dc0f8>] defense_timer_handler+0x8/0x40
<Jan/16 10:55 pm> [<c0121dda>] run_timer_softirq+0xda/0x1a0
<Jan/16 10:55 pm> [<c0278df1>] net_rx_action+0x81/0x110
<Jan/16 10:55 pm> [<c011db1a>] __do_softirq+0xba/0xd0
<Jan/16 10:55 pm> [<c01868f0>] meminfo_read_proc+0x0/0x240
<Jan/16 10:55 pm> [<c0104cba>] do_softirq+0x4a/0x60
<Jan/16 10:55 pm> =======================
<Jan/16 10:55 pm> [<c0133d59>] irq_exit+0x39/0x40
<Jan/16 10:55 pm> [<c010309c>] apic_timer_interrupt+0x1c/0x24
<Jan/16 10:55 pm> [<c01868f0>] meminfo_read_proc+0x0/0x240
<Jan/16 10:55 pm>
<Jan/16 10:55 pm> [<c013007b>] set_obsolete+0xfb/0x220
<Jan/16 10:55 pm> [<c030925a>] _spin_lock+0x1a/0x90
<Jan/16 10:55 pm> [<c015bbed>] nr_blockdev_pages+0xd/0x60
<Jan/16 10:55 pm> [<c013a601>] si_meminfo+0x21/0x40
<Jan/16 10:55 pm> [<c0186931>] meminfo_read_proc+0x41/0x240
<Jan/16 10:55 pm> [<c01819c7>] proc_read_inode+0x17/0x40
<Jan/16 10:55 pm> [<c016c79c>] d_rehash+0x6c/0x90
<Jan/16 10:55 pm>
<Jan/16 10:55 pm> [<c01848df>] proc_lookup+0x8f/0xd0
<Jan/16 10:55 pm> [<c0139fd4>] __alloc_pages+0x1d4/0x370
<Jan/16 10:55 pm> [<c0146981>] vma_merge+0xd1/0x1d0
<Jan/16 10:55 pm> [<c01868f0>] meminfo_read_proc+0x0/0x240
<Jan/16 10:55 pm> [<c01843e3>] proc_file_read+0xc3/0x250
<Jan/16 10:55 pm> [<c0153cf8>] vfs_read+0xb8/0x130
<Jan/16 10:55 pm> [<c0153fe1>] sys_read+0x51/0x80
<Jan/16 10:55 pm> [<c0102649>] sysenter_past_esp+0x52/0x75


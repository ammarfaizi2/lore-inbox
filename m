Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266073AbUHFSKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUHFSKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 14:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268234AbUHFSK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 14:10:29 -0400
Received: from pD951727D.dip.t-dialin.net ([217.81.114.125]:58504 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S268229AbUHFSJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 14:09:16 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Shane Shrybman <shrybman@aei.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408031019090.20420@devserv.devel.redhat.com>
References: <1091459297.2573.10.camel@mars>
	 <Pine.LNX.4.58.0408031019090.20420@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1091815684.7586.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 06 Aug 2004 20:08:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> On Mon, 2 Aug 2004, Shane Shrybman wrote:
> 
> > Also, had to turn of parport in the config to get it to compile.
> > 
> > drivers/parport/share.c:77: unknown field `generic_enable_irq' specified
> > in initializer
> > drivers/parport/share.c:78: unknown field `generic_disable_irq'
> > specified in initializer
> 
> thx - i fixed this in -O3.
> 
> 	Ingo

In the end I found the cause of those latency spikes I was seeing every
~8 seconds. They are caused by ACPI. I tried to narrow the problem down,
and they're here whenever I compile ACPI in (even with no option and no
additional module) unless I specify acpi=off or acpi=ht (I don't have a
HT cpu, but it could be a clue as the ACPI interpreter is disabled in
this mode). I don't really hope that this will ever get fixed as my
toshiba laptop model is known to have a buggy bios WRT ACPI (I already
tried an alternate dsdt table that fixed a battery status reporting
issue, but the latency problem was still there).

Using your updated version of wli's preempt-timing patch on top of -O2,
here are the results :

On X startup :

Aug  2 15:40:08 satellite (X/4647): 1587us non-preemptible critical
section violated 1000 us preempt threshold starting at
voluntary_resched+0x3e/0x70 and ending at sys_ioctl+0xdd/0x2a0
Aug  2 15:40:08 satellite [<c010574e>] dump_stack+0x1e/0x30
Aug  2 15:40:08 satellite [<c011723e>] dec_preempt_count+0x3e/0x50
Aug  2 15:40:08 satellite [<c016956d>] sys_ioctl+0xdd/0x2a0
Aug  2 15:40:08 satellite [<c01051a5>] sysenter_past_esp+0x52/0x71


While accessing the file system (this one is very frequent):

Aug  2 15:32:24 satellite (bash/5298): 1095us non-preemptible critical
section violated 1000 us preempt threshold starting at
search_by_key+0x120/0x1140 and ending at voluntary_resched+0x1a/0x70
Aug  2 15:32:24 satellite [<c010574e>] dump_stack+0x1e/0x30
Aug  2 15:32:24 satellite [<c01171a6>] touch_preempt_timing+0x36/0x50
Aug  2 15:32:24 satellite [<c042856a>] voluntary_resched+0x1a/0x70
Aug  2 15:32:24 satellite [<c0158c44>] __getblk+0x44/0x70
Aug  2 15:32:24 satellite [<c01ae348>] search_by_key+0x78/0x1140
Aug  2 15:32:24 satellite [<c01af4bc>]
search_for_position_by_key+0xac/0x3f0
Aug  2 15:32:24 satellite [<c019e0c4>]
reiserfs_allocate_blocks_for_region+0x354/0x15b0
Aug  2 15:32:24 satellite [<c01a0c4c>] reiserfs_file_write+0x61c/0x8d0
Aug  2 15:32:24 satellite [<c0155e2f>] vfs_write+0xcf/0x140
Aug  2 15:32:24 satellite [<c0155f3f>] sys_write+0x3f/0x60
Aug  2 15:32:24 satellite [<c01051a5>] sysenter_past_esp+0x52/0x71


Mounting a reiserfs volume :

Aug  2 15:26:22 satellite (mount/2965): 2462us non-preemptible critical
section
violated 1000 us preempt threshold starting at
voluntary_resched+0x3e/0x70 and ending at voluntary_resched+0x1a/0x70
Aug  2 15:26:22 satellite [<c010574e>] dump_stack+0x1e/0x30
Aug  2 15:26:22 satellite [<c01171a6>] touch_preempt_timing+0x36/0x50
Aug  2 15:26:22 satellite [<c042856a>] voluntary_resched+0x1a/0x70
Aug  2 15:26:22 satellite [<c0158c44>] __getblk+0x44/0x70
Aug  2 15:26:22 satellite [<c0158cef>] __bread+0x1f/0x40
Aug  2 15:26:22 satellite [<c01b6d05>] journal_read+0xa5/0x520
Aug  2 15:26:22 satellite [<c01b7b8c>] journal_init+0x6ac/0x7f0
Aug  2 15:26:22 satellite [<c01a772c>] reiserfs_fill_super+0x27c/0x6e0
Aug  2 15:26:22 satellite [<c015d17e>] get_sb_bdev+0x13e/0x170
Aug  2 15:26:22 satellite [<c01a7bff>] get_super_block+0x2f/0x40
Aug  2 15:26:22 satellite [<c015d3f5>] do_kern_mount+0xa5/0x180
Aug  2 15:26:22 satellite [<c0174721>] do_new_mount+0x71/0xb0
Aug  2 15:26:22 satellite [<c0174e09>] do_mount+0x169/0x1b0
Aug  2 15:26:22 satellite [<c0175250>] sys_mount+0xb0/0x140
Aug  2 15:26:22 satellite [<c01051a5>] sysenter_past_esp+0x52/0x71



Another problem I had while trying the preempt-timing patch is that
using clock=pmtmr flooded my logs because the resolution of the detected
violations was 1ms, as shown below :

Aug  2 15:22:35 satellite (pdflush/43): 1000us non-preemptible critical
section
violated 1000 us preempt threshold starting at
voluntary_resched+0x3e/0x70 and ending at do_journal_end+0x4cf/0xb80
Aug  2 15:22:35 satellite [<c010574e>] dump_stack+0x1e/0x30
Aug  2 15:22:35 satellite [<c01171a6>] touch_preempt_timing+0x36/0x50
Aug  2 15:22:35 satellite [<c01b99ef>] do_journal_end+0x4cf/0xb80
Aug  2 15:22:35 satellite [<c01b8acc>] journal_end_sync+0x4c/0x90
Aug  2 15:22:35 satellite [<c01a514e>] reiserfs_sync_fs+0x5e/0xb0
Aug  2 15:22:35 satellite [<c015c7bc>] sync_supers+0xfc/0x110
Aug  2 15:22:35 satellite [<c013d911>] wb_kupdate+0x31/0x110
Aug  2 15:22:35 satellite [<c013e466>] __pdflush+0xd6/0x200
Aug  2 15:22:35 satellite [<c013e5b8>] pdflush+0x28/0x30
Aug  2 15:22:35 satellite [<c012d96a>] kthread+0xaa/0xb0
Aug  2 15:22:35 satellite [<c01032f5>] kernel_thread_helper+0x5/0x10
Aug  2 15:22:43 satellite printk: 5 messages suppressed.
(I also had 2000us, 3000us, and 4000us violations)

Using clock=tsc worked just fine.

Thanks for all the work you've done and are still doing on this,
Thomas



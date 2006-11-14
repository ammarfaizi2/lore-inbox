Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933361AbWKNKEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933361AbWKNKEt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 05:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933362AbWKNKEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 05:04:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19073 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933361AbWKNKEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 05:04:48 -0500
Date: Tue, 14 Nov 2006 02:01:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: CaT <cat@zip.com.au>
Cc: "Dennis J.A. Bijwaard" <dennis@h8922032063.dsl.speedlinq.nl>,
       bijwaard@gmail.com, sct@redhat.com, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: soft lockup detected on CPU#0! in sys_close and ext3
Message-Id: <20061114020125.636c9006.akpm@osdl.org>
In-Reply-To: <20061114095818.GA2541@zip.com.au>
References: <20061015175640.GA3673@jumbo.lan>
	<20061015121202.378bdd41.akpm@osdl.org>
	<20061015215854.GA12890@jumbo.lan>
	<20061114095818.GA2541@zip.com.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 20:58:18 +1100
CaT <cat@zip.com.au> wrote:

> On Sun, Oct 15, 2006 at 11:58:55PM +0200, Dennis J.A. Bijwaard wrote:
> > Hi Andrew,
> > 
> > Thanks for your reply. The machine has 512MB and some more swap:
> > 
> > Mem:    510960k total,   504876k used,     6084k free,     1868k buffers
> > Swap:   674640k total,     2652k used,   671988k free,   354832k cached
> > 
> > Machine may be slow for current standards, it has 2 * 500Mhz
> 
> This looks like what I have come across yesterda, except my machine is
> far from slow. It's a dual core woodcrest 5130 cpu (2Ghz) with 4gb of
> ram. My call trace looks very similar and occurs when sda1 (for eg) is 
> involved or md0 (raid0 in this case) is. It happens multiple times in 
> each case (from memory).
> 
> Nov 13 09:46:04 localhost kernel: Call Trace:
> Nov 13 09:46:04 localhost kernel:  [show_trace+185/628] show_trace+0xb9/0x274
> Nov 13 09:46:04 localhost kernel:  [dump_stack+21/26] dump_stack+0x15/0x1a
> Nov 13 09:46:04 localhost kernel:  [softlockup_tick+231/264] softlockup_tick+0xe7/0x108
> Nov 13 09:46:04 localhost kernel:  [run_local_timers+19/21] run_local_timers+0x13/0x15
> Nov 13 09:46:04 localhost kernel:  [update_process_times+83/137] update_process_times+0x53/0x89
> Nov 13 09:46:04 localhost kernel:  [smp_local_timer_interrupt+46/89] smp_local_timer_interrupt+0x2e/0x59
> Nov 13 09:46:04 localhost kernel:  [smp_apic_timer_interrupt+92/106] smp_apic_timer_interrupt+0x5c/0x6a
> Nov 13 09:46:04 localhost kernel:  [apic_timer_interrupt+107/112] apic_timer_interrupt+0x6b/0x70
> Nov 13 09:46:04 localhost kernel:  [_write_unlock_irqrestore+81/95] _write_unlock_irqrestore+0x51/0x5f
> Nov 13 09:46:04 localhost kernel:  [test_clear_page_dirty+189/224] test_clear_page_dirty+0xbd/0xe0
> Nov 13 09:46:04 localhost kernel:  [try_to_free_buffers+123/174] try_to_free_buffers+0x7b/0xae
> Nov 13 09:46:04 localhost kernel:  [try_to_release_page+68/74] try_to_release_page+0x44/0x4a
> Nov 13 09:46:04 localhost kernel:  [invalidate_complete_page+54/191] invalidate_complete_page+0x36/0xbf
> Nov 13 09:46:04 localhost kernel:  [invalidate_mapping_pages+157/280] invalidate_mapping_pages+0x9d/0x118
> Nov 13 09:46:04 localhost kernel:  [invalidate_inode_pages+18/20] invalidate_inode_pages+0x12/0x14
> Nov 13 09:46:04 localhost kernel:  [invalidate_bdev+47/56] invalidate_bdev+0x2f/0x38
> Nov 13 09:46:04 localhost kernel:  [kill_bdev+25/52] kill_bdev+0x19/0x34
> Nov 13 09:46:04 localhost kernel:  [__blkdev_put+88/314] __blkdev_put+0x58/0x13a
> Nov 13 09:46:04 localhost kernel:  [blkdev_put+11/13] blkdev_put+0xb/0xd
> Nov 13 09:46:04 localhost kernel:  [blkdev_close+52/61] blkdev_close+0x34/0x3d
> Nov 13 09:46:04 localhost kernel:  [__fput+170/306] __fput+0xaa/0x132
> Nov 13 09:46:04 localhost kernel:  [fput+21/23] fput+0x15/0x17
> Nov 13 09:46:04 localhost kernel:  [filp_close+109/129] filp_close+0x6d/0x81
> Nov 13 09:46:04 localhost kernel:  [sys_close+140/168] sys_close+0x8c/0xa8
> Nov 13 09:46:04 localhost kernel:  [system_call+126/131] system_call+0x7e/0x83
> Nov 13 09:46:04 localhost kernel:  [phys_startup_64+-1072859838/2147483392]
> 
> > > So the kernel was doing a lot of work, on a slow CPU.  Perhaps that simply
> > > exceeded the softlockup timeout.  If that's true then the machine should
> > > have recovered.  Once it did, and once it didn't.  I don't know why it
> > > didn't.
> 
> It did for me in all cases. Should it be taking long enough to trigger
> the softlock timeout to do this? The size of the device is approx 280gig.
> 

It's a bit of a worry if it's taking all that time to shoot down 4g of
pagecache.  The 280G will affect things - the radix-tree will be sparse and
the invalidate has firther to walk.  But still...

I assume that a fsck does the same thing?


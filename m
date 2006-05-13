Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWEMOgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWEMOgt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 10:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWEMOgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 10:36:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751080AbWEMOgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 10:36:48 -0400
Date: Sat, 13 May 2006 07:33:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages. (might
 be dm related)
Message-Id: <20060513073344.4fcbc46b.akpm@osdl.org>
In-Reply-To: <20060513134908.GA4480@uio.no>
References: <20060420160549.7637.patches@notabene>
	<1060420062955.7727@suse.de>
	<20060420003839.1a41c36f.akpm@osdl.org>
	<20060426204809.GA15462@uio.no>
	<20060426135809.10a37ec3.akpm@osdl.org>
	<20060513134908.GA4480@uio.no>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steinar H. Gunderson" <sgunderson@bigfoot.com> wrote:
>
> On Wed, Apr 26, 2006 at 01:58:09PM -0700, Andrew Morton wrote:
> >> I tried this patch against 2.6.17-rc2 (I hoped that it might be fixing my
> >> kswapd oopses too, as they seem related; see
> >> http://lkml.org/lkml/2006/4/26/124 and followups), and it simply makes my
> >> machine hang on bootup -- it seems to make modprobe hang forever on some lock
> >> or something right after it loads raid6.ko (pulled in by evms_activate) in
> >> initramfs. Without the patch, the machine boots just fine.
> > It had a silly bug.  Fixed version:
> 
> That worked fine for a long time (>14 days), but I had to switch motherboards
> (from a cheap Epox to a Tyan server-board) due to external factors. Since
> then, stuff has started panicing again wildly -- 2.6.17-rc2 doesn't even
> boot, 2.6.17-rc3 and 2.6.17-rc4 lives for an hour or so and then gives up:
> 
> [ 1127.842645] Unable to handle kernel NULL pointer dereference at 0000000000000040 RIP: 
> [ 1127.848117] <ffffffff803a1ae8>{__lock_text_start+0}
> [ 1127.855474] PGD 5e38a067 PUD 5e39d067 PMD 0 
> [ 1127.859770] Oops: 0002 [1] SMP 
> [ 1127.862931] CPU 1 
> [ 1127.864957] Modules linked in: w83627hf_wdt eeprom ide_generic ide_disk ide_cd cdrom ipv6 psmouse i2c_nforce2 serio_raw pcspkr i2c_core parport_pc parport rtc e
> xt3 jbd mbcahe raid6 raid5 xor raid10 raid1 raid0 linear mdd dm_mod sd_mod sata_nv sata_sil libata scsi_mod amd74xx generic forcedeth tg3 ide_core ohci_hcd ehci_hc
> d thermal processor fan unix
> [ 1127.896622] Pid: 0, comm: swapper Not tainted 2.6.17-rc4 #1
> [ 1127.902191] RIP: 0010:[<ffffffff803a1ae8>] <ffffffff803a1ae8>{__lock_text_start+0}
> [ 1127.909589] RSP: 0018:ffff81000245bd70  EFLAGS: 00010002
> [ 1127.915094] RAX: 0000000000005d09 RBX: 0000000000005d09 RCX: ffff8100020446a8
> [ 1127.922221] RDX: ffff81007e2ee800 RSI: ffff810002044648 RDI: 0000000000000040
> [ 1127.929346] RBP: 0000000000005d09 R08: 0000000000000000 R09: 0000000000000000
> [ 1127.936472] R10: 0000000000000001 R11: ffffffff8024c868 R12: ffff81007ddb41c0
> [ 1127.943599] R13: 0000000000000296 R14: ffff81007caaf650 R15: 0000000000000000
> [ 1127.950726] FS:  0000000000000000(0000) GS:ffff81007f827840(0000) knlGS:00000000f7d666c0
> [ 1127.958819] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> [ 1127.964559] CR2: 0000000000000040 CR3: 0000000062aec000 CR4: 00000000000006e0
> [ 1127.971686] Process swapper (pid: 0, threadinfo ffff810002452000, task ffff810002444080)
> [ 1127.979777] Stack: ffffffff802668fb ffff81007caaf650 ffffffff880d3a29 ffff81007caaf650 
> [ 1127.987634]        0000000000000000 ffff81007cf689f0 ffff81003d41d240 0000000000000000 
> [ 1127.995684]        ffffffff880d3b5f ffff81007e3530e8 
> [ 1128.000757] Call Trace: <IRQ> <ffffffff802668fb>{kmem_cache_free+253}
> [ 1128.007231]        <ffffffff880d3a29>{:dm_mod:dec_pending+169} <ffffffff880d3b5f>{:dm_mod:clone_endio+127}
> [ 1128.016932]        <ffffffff802c9372>{__end_that_request_first+420} <ffffffff8808e8a6>{:scsi_mod:scsi_end_request+40}
> [ 1128.027589]        <ffffffff8808eb51>{:scsi_mod:scsi_io_completion+522}
> [ 1128.034222]        <ffffffff880cc4a1>{:sd_mod:sd_rw_intr+623} <ffffffff8808f5d6>{:scsi_mod:scsi_device_unbusy+85}
> [ 1128.044527]        <ffffffff802c86cb>{blk_done_softirq+113} <ffffffff8022c41b>{__do_softirq+86}
> [ 1128.053265]        <ffffffff8020a742>{call_softirq+30} <ffffffff8020b902>{do_softirq+44}
> [ 1128.061396]        <ffffffff8020b947>{do_IRQ+65} <ffffffff8020827b>{default_idle+0}
> [ 1128.069091]        <ffffffff80209aa0>{ret_from_intr+0} <EOI> <ffffffff803a02a0>{thread_return+0}
> [ 1128.077926]        <ffffffff802082a8>{default_idle+45} <ffffffff80208335>{cpu_idle+98}
> [ 1128.085883]        <ffffffff804d5c22>{start_secondary+1127}
> [ 1128.091670] 
> [ 1128.091671] Code: f0 ff 0f 0f 88 c8 01 00 00 c3 f0 ff 0f 8b 07 ba 01 00 00 00 
> [ 1128.100588] RIP <ffffffff803a1ae8>{__lock_text_start+0} RSP <ffff81000245bd70>
> [ 1128.107832] CR2: 0000000000000040
> [ 1128.111378]  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
> [ 1128.118498]  <0>Rebooting in 60 seconds..
> 
> This is with the remove-softlockup-from-invalidate_mapping_pages patch, but
> it looks like it's crashing somewhere else. Any good ideas? Is this related
> to the memory management at all, or is is better left to the dm people?
> 

Well if it's the same software lineup on new hardware, one would also
suspect that hardware.  Is it new?

Does it run other kernels OK?

Does it always crash in the same manner?

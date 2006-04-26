Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWDZPPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWDZPPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWDZPPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:15:39 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:58564 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932475AbWDZPPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:15:38 -0400
Date: Wed, 26 Apr 2006 17:15:35 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: kswapd oops reproduced with 2.6.17-rc2 (was Oops with 2.6.15.3 on amd64)
Message-ID: <20060426151535.GA13203@uio.no>
References: <20060422221232.GA6269@uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060422221232.GA6269@uio.no>
X-Operating-System: Linux 2.6.14.3 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11+cvs20060403
X-Spam-Score: -0.0 (/)
X-Spam-Report: Status=No hits=-0.0 required=5.0 tests=NO_RELAYS version=3.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2006 at 12:12:32AM +0200, Steinar H. Gunderson wrote:
> My dual-core AMD64 machine (Athlon 64 X2 3800+) has been unstable (hanging
> completely from the to time) since I ever got it, with various kernels (2.6.8
> up to 2.6.17-rc1), even more so after the I/O load increased on it (earlier
> it hung about once a month; now it's more once a day). This time, however, I
> had a minicom logging everything on the serial console, so I have a
> traceback:

I reproduced this with 2.6.17-rc2 on the same machine:

[261604.531829] Unable to handle kernel paging request at ffff8000020369d8 RIP: 
[261604.536538] <ffffffff802509e6>{isolate_lru_pages+74}
[261604.544074] PGD 0 
[261604.546196] Oops: 0002 [1] SMP 
[261604.549475] CPU 0 
[261604.551606] Modules linked in: af_packet w83627hf hwmon_vid i2c_isa ide_generic ide_disk ide_cd cdrom ipv6 i810_audio ac97_codec psmouse serio_raw analog snd_intel8x0 snd_ac97_codec snd_ac97_bus floppy snd_pcm snd_timer snd i2c_nforce2 gameport parport_pc pcspkr rtc soundcore i2c_core parport snd_page_alloc ext3 jbd mbcache raid6 raid5 xor raid10 raid1 raid0 linear md_mod dm_mod sd_mod sata_nv libata scsi_mod forcedeth generic amd74xx ehci_hcd ide_core ohci_hcd thermal processor fan unix
[261604.595778] Pid: 194, comm: kswapd0 Not tainted 2.6.17-rc2 #1
[261604.601603] RIP: 0010:[<ffffffff802509e6>] <ffffffff802509e6>{isolate_lru_pages+74}
[261604.609194] RSP: 0000:ffff81007fe3fc90  EFLAGS: 00210002
[261604.614839] RAX: ffff8000020369d8 RBX: 0000000000000020 RCX: ffff81007fe3fe20
[261604.622128] RDX: ffff81000000c5c8 RSI: ffff81000000c5c8 RDI: ffff81007fe3fcf8
[261604.629406] RBP: 0000000000000002 R08: ffff810000dabba0 R09: ffff810000dabb78
[261604.636625] R10: 0000000000000012 R11: 0000000000000012 R12: 0000000000000000
[261604.643904] R13: ffff81007fe3fe98 R14: 0000000000000001 R15: 0000000000000000
[261604.651167] FS:  0000000000000000(0000) GS:ffffffff804be000(0000) knlGS:00000000ed5e8bb0
[261604.659345] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[261604.665188] CR2: ffff8000020369d8 CR3: 000000000dc2b000 CR4: 00000000000006e0
[261604.672416] Process kswapd0 (pid: 194, threadinfo ffff81007fe3e000, task ffff81007fe1a8a0)
[261604.680768] Stack: 0000000000000020 ffff81000000c340 ffffffff80250f25 000000000000000f 
[261604.688747]        000000000000000c 0000000000000064 0000000000000005 0000000000000000 
[261604.696909]        0000000000000020 0000000000000020 
[261604.702111] Call Trace: <ffffffff80250f25>{shrink_zone+402} <ffffffff88112114>{:mbcache:mb_cache_shrink_fn+39}
[261604.712303]        <ffffffff80250945>{shrink_slab+317} <ffffffff80251bc2>{balance_pgdat+536}
[261604.720911]        <ffffffff80251e11>{kswapd+263} <ffffffff80238998>{autoremove_wake_function+0}
[261604.729848]        <ffffffff8020a3d6>{child_rip+8} <ffffffff80214ee8>{flat_send_IPI_mask+0}
[261604.738357]        <ffffffff80251d0a>{kswapd+0} <ffffffff8020a3ce>{child_rip+0}
[261604.746032] 
[261604.746033] Code: 48 89 10 41 8b 50 e0 49 c7 00 00 01 10 00 49 c7 40 08 00 02 
[261604.755292] RIP <ffffffff802509e6>{isolate_lru_pages+74} RSP <ffff81007fe3fc90>
[261604.762729] CR2: ffff8000020369d8
[261604.766157]  NMI Watchdog detected LOCKUP on CPU 1
[261609.865491] CPU 1 
[261609.867613] Modules linked in: af_packet w83627hf hwmon_vid i2c_isa ide_generic ide_disk ide_cd cdrom ipv6 i810_audio ac97_codec psmouse serio_raw analog snd_intel8x0 snd_ac97_codec snd_ac97_bus floppy snd_pcm snd_timer snd i2c_nforce2 gameport parport_pc pcspkr rtc soundcore i2c_core parport snd_page_alloc ext3 jbd mbcache raid6 raid5 xor raid10 raid1 raid0 linear md_mod dm_mod sd_mod sata_nv libata scsi_mod forcedeth generic amd74xx ehci_hcd ide_core ohci_hcd thermal processor fan unix
[261609.911819] Pid: 32429, comm: apache2 Not tainted 2.6.17-rc2 #1
[261609.917827] RIP: 0010:[<ffffffff8039fc92>] <ffffffff8039fc92>{.text.lock.spinlock+49}
[261609.925660] RSP: 0000:ffff8100168e9c30  EFLAGS: 00200082
[261609.931243] RAX: 0000000000000001 RBX: ffff810001cccba0 RCX: ffff810002117040
[261609.938532] RDX: ffff810000635710 RSI: 0000000000000000 RDI: ffff81000000c5c0
[261609.945742] RBP: ffff81000000c340 R08: 0000000000000000 R09: 0000000000000000
[261609.952970] R10: 0000000000000000 R11: 0000000000000000 R12: ffff810002117040
[261609.960249] R13: 0000000000000000 R14: ffff81007aa0e608 R15: 0000000000000000
[261609.967539] FS:  0000000000000000(0000) GS:ffff81000245b940(0063) knlGS:00000000f65fabb0
[261609.975725] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[261609.981550] CR2: 00000000e9052004 CR3: 0000000049f38000 CR4: 00000000000006e0
[261609.988763] Process apache2 (pid: 32429, threadinfo ffff8100168e8000, task ffff81007fa609e0)
[261609.997287] Stack: ffffffff8024ff25 0000000000000000 0000000000000000 ffff810000635710 
[261610.005273]        00000000000200d2 ffff81007f895528 ffffffff8024928b ffff81007aa0e608 
[261610.013437]        0000000000000000 ffff810000635710 
[261610.018620] Call Trace: <ffffffff8024ff25>{__pagevec_lru_add+76}
[261610.024780]        <ffffffff8024928b>{add_to_page_cache_lru+25} <ffffffff80263ccd>{shmem_getpage+1119}
[261610.034241]        <ffffffff80264744>{shmem_nopage+80} <ffffffff8025602c>{__handle_mm_fault+872}
[261610.043202]        <ffffffff803a1994>{do_page_fault+1087} <ffffffff8039fea5>{__kprobes_text_start+253}
[261610.052668]        <ffffffff8039e248>{thread_return+0} <ffffffff8039dc77>{schedule+334}
[261610.060848]        <ffffffff8020a21d>{error_exit+0}
[261610.066065] 
[261610.066066] Code: 7e f9 e9 c1 fe ff ff f3 90 83 3f 00 7e f9 e9 d2 fe ff ff e8 
[261610.075325] console shuts up ...
[261610.078632]  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
[261610.085970]  NMI Watchdog detected LOCKUP on CPU 0
[261615.835545] CPU 0 
[261615.837677] Modules linked in: af_packet w83627hf hwmon_vid i2c_isa ide_generic ide_disk ide_cd cdrom ipv6 i810_audio ac97_codec psmouse serio_raw analog snd_intel8x0 snd_ac97_codec snd_ac97_bus floppy snd_pcm snd_timer snd i2c_nforce2 gameport parport_pc pcspkr rtc soundcore i2c_core parport snd_page_alloc ext3 jbd mbcache raid6 raid5 xor raid10 raid1 raid0 linear md_mod dm_mod sd_mod sata_nv libata scsi_mod forcedeth generic amd74xx ehci_hcd ide_core ohci_hcd thermal processor fan unix
[261615.882039] Pid: 32474, comm: apache2 Not tainted 2.6.17-rc2 #1
[261615.888047] RIP: 0010:[<ffffffff8039fc8d>] <ffffffff8039fc8d>{.text.lock.spinlock+44}
[261615.895846] RSP: 0000:ffff81000edfdc30  EFLAGS: 00200082
[261615.901482] RAX: 0000000000000001 RBX: ffff810000afb648 RCX: ffff81000210f040
[261615.908701] RDX: ffff810000a06760 RSI: 0000000000000000 RDI: ffff81000000c5c0
[261615.915947] RBP: ffff81000000c340 R08: 0000000000000000 R09: 0000000000000000
[261615.923182] R10: 0000000000000000 R11: 0000000000000000 R12: ffff81000210f040
[261615.930402] R13: 0000000000000000 R14: ffff81005ede6ac0 R15: 0000000000000000
[261615.937630] FS:  0000000000000000(0000) GS:ffffffff804be000(0063) knlGS:00000000ed5e8bb0
[261615.945868] CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
[261615.951702] CR2: 00000000e3784004 CR3: 000000000dc2b000 CR4: 00000000000006e0
[261615.958932] Process apache2 (pid: 32474, threadinfo ffff81000edfc000, task ffff81007fa0b5a0)
[261615.967472] Stack: ffffffff8024ff25 0000000000000000 0000000000000000 ffff810000a06760 
[261615.975496]        00000000000200d2 ffff81007e16c3d0 ffffffff8024928b ffff81005ede6ac0 
[261615.983666]        0000000000000000 ffff810000a06760 
[261615.988859] Call Trace: <ffffffff8024ff25>{__pagevec_lru_add+76}
[261615.994999]        <ffffffff8024928b>{add_to_page_cache_lru+25} <ffffffff80263ccd>{shmem_getpage+1119}
[261616.004495]        <ffffffff8024a9cb>{filemap_nopage+389} <ffffffff80264744>{shmem_nopage+80}
[261616.013219]        <ffffffff8025602c>{__handle_mm_fault+872} <ffffffff8039f5fe>{__down_read+130}
[261616.022205]        <ffffffff803a1994>{do_page_fault+1087} <ffffffff8039fea5>{__kprobes_text_start+253}
[261616.031726]        <ffffffff803a2280>{kprobe_flush_task+30} <ffffffff8039e2be>{thread_return+118}
[261616.040826]        <ffffffff8020a21d>{error_exit+0}
[261616.046039] 
[261616.046040] Code: f3 90 83 3f 00 7e f9 e9 c1 fe ff ff f3 90 83 3f 00 7e f9 e9 
[261616.055293] console shuts up ...
[261616.058609]  

/* Steinar */
-- 
Homepage: http://www.sesse.net/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWIXRA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWIXRA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 13:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWIXRA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 13:00:29 -0400
Received: from pas38-1-82-67-71-117.fbx.proxad.net ([82.67.71.117]:5323 "EHLO
	siegfried.gbfo.org") by vger.kernel.org with ESMTP id S1751159AbWIXRA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 13:00:27 -0400
Date: Sun, 24 Sep 2006 19:01:27 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@gmail.com>
X-X-Sender: saffroy@erda.mds
To: linux-kernel@vger.kernel.org
Subject: oops in :snd_pcm_oss:resample_expand+0x19c/0x1f0
Message-ID: <Pine.LNX.4.64.0609241825280.4838@erda.mds>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I hit the following bug a few times on my desktop:

Unable to handle kernel paging request at ffffc200100e4466 RIP:
  [<ffffffff882234cc>] :snd_pcm_oss:resample_expand+0x19c/0x1f0
PGD 37919067 PUD 37918067 PMD 37f5b067 PTE 0
Oops: 0002 [1] SMP
CPU 0
Modules linked in: nvidia nfsd exportfs lockd nfs_acl sunrpc button ac 
battery ipv6 nls_iso8859_1 nls_cp437 vfat fat usb_storage tuner 
snd_intel8x0 snd_ac97_codec snd_ac97_bus bttv snd_pcm_oss video_buf 
firmware_class snd_mixer_oss ir_common snd_pcm compat_ioctl32 i2c_algo_bit 
snd_timer i2c_nforce2 psmouse snd btcx_risc tveeprom videodev v4l1_compat 
v4l2_common i2c_core ohci_hcd ehci_hcd forcedeth serio_raw soundcore 
snd_page_alloc pcspkr evdev thermal processor fan generic amd74xx sata_nv 
libata ide_cd sd_mod ide_generic raid0 ext3 jbd mbcache ide_disk ide_core 
sr_mod scsi_mod cdrom dm_mirror dm_snapshot dm_mod raid1 md_mod
Pid: 4860, comm: firefox-bin Tainted: P      2.6.18 #3
RIP: 0010:[<ffffffff882234cc>]  [<ffffffff882234cc>] :snd_pcm_oss:resample_expand+0x19c/0x1f0
RSP: 0000:ffff81002c243d88  EFLAGS: 00010207
RAX: 0000000000000000 RBX: 000000000000024d RCX: 000000000000007d
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc20000028e0e
RBP: ffff81002c243de8 R08: 00000000000002eb R09: ffffc200100e4466
R10: 000000000000007d R11: 0000000000000000 R12: 0000000000000000
R13: ffff81003f2e9f58 R14: 0000000000000004 R15: ffff81003f2e9f7c
FS:  00002ad1bd680ae0(0000) GS:ffffffff80586000(0063) knlGS:00000000f73676c0
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: ffffc200100e4466 CR3: 000000002bc6b000 CR4: 00000000000006e0
Process firefox-bin (pid: 4860, threadinfo ffff81002c242000, task ffff810037a1a080)
Stack:  ffff810025646000 0000040000001806 ffff81002412e140 ffff81001fe532c0
  ffff81003f2e9ec0 0000000000000004 0000000125135c00 0000000000001806
  0000000000000400 ffff81003f2e9ec0 ffff81002412e140 ffff81001fe532c0
Call Trace:
  [<ffffffff8822387b>] :snd_pcm_oss:rate_transfer+0x5b/0x80
  [<ffffffff88221438>] :snd_pcm_oss:snd_pcm_plug_write_transfer+0xb8/0x100
  [<ffffffff88221319>] :snd_pcm_oss:snd_pcm_plug_client_channels_buf+0x59/0xc0
  [<ffffffff8821f4b5>] :snd_pcm_oss:snd_pcm_oss_write2+0x95/0x100
  [<ffffffff882207e6>] :snd_pcm_oss:snd_pcm_oss_write+0x1b6/0x250
  [<ffffffff80215a22>] vfs_write+0xe2/0x1a0
  [<ffffffff80216320>] sys_write+0x50/0x90
  [<ffffffff8026480e>] ia32_sysret+0x0/0xa

Code: 66 41 89 11 4d 01 f1 41 8d 40 01 41 03 5d 00 85 c0 0f 8f 6d
RIP  [<ffffffff882234cc>] :snd_pcm_oss:resample_expand+0x19c/0x1f0
  RSP <ffff81002c243d88>

Yes yes, I know the kernel is tainted "P" (courtesy of the infamous Nvidia 
module), so flame me if you want, but some investigation leads me to think 
it could be an issue in core kernel modules, so read on if you still want 
the gory details. ;-)

The kernel is vanilla 2.6.18 on Debian etch, the box is a dual core Athlon 
in x86-64 mode (in case you didn't notice the long pointers ;-). The 
offending process is a chroot'ed IA32 Firefox. At first I suspected a 
problem with 32-bit compatibility, but stack traces below and source code 
suggest the problem could be different:

  - CPU #0 crashes in resample_expand() at line 116:

  116                         *dst = val;

The target address is at ffffc200100e4466, which looks like a vmalloc'ed 
buffer (according to Documentation/x86_64/mm.txt).

  - CPU #1 is somewhere down vfree() called by snd_pcm_oss_change_params(), 
at line 1010:

1010         vfree(runtime->oss.buffer);
1011         runtime->oss.buffer = vmalloc(runtime->oss.period_bytes);

Now it really looks like it *could* be a race between two threads using 
the same device, maybe the same buffers somehow, but I'm getting lost in 
the data structures, so help from knowledgeable people would be welcome.

I keep a crash dump from kdump, below are the stack traces from the crash 
command; I can post more results if requested. The stack frames on CPU #0 
between 1 and 7 seem to me to be bogus.

Oh and I wish I could use gdb on a kdump core. :-)

%%%%%%% crash> bt -loa

PID: 4860   TASK: ffff810037a1a080  CPU: 0   COMMAND: "firefox-bin"
  #0 [ffff81002c243aa0] crash_kexec at ffffffff802a855b
     /home/saffroy/kernel/linux-2.6.18/kernel/kexec.c: 1062
  #1 [ffff81002c243b28] resample_expand at ffffffff882234cc
     /home/saffroy/kernel/linux-2.6.18/sound/core/oss/rate.c: 116
  #2 [ffff81002c243b70] __die at ffffffff80268c23
     /home/saffroy/kernel/linux-2.6.18/arch/x86_64/kernel/traps.c: 561
  #3 [ffff81002c243bc0] do_page_fault at ffffffff8026a887
     /home/saffroy/kernel/linux-2.6.18/arch/x86_64/mm/fault.c: 579
  #4 [ffff81002c243bd0] snd_pcm_do_reset at ffffffff881e612e
     /home/saffroy/kernel/linux-2.6.18/sound/core/pcm_native.c: 1253
  #5 [ffff81002c243c60] mutex_unlock at ffffffff80266b69
     /home/saffroy/kernel/linux-2.6.18/kernel/mutex.c: 117
  #6 [ffff81002c243c70] snd_pcm_common_ioctl1 at ffffffff881e9e9d
     /home/saffroy/kernel/linux-2.6.18/include/sound/core.h: 158
  #7 [ffff81002c243cd0] error_exit at ffffffff8026374d
     /home/saffroy/kernel/linux-2.6.18/include/linux/bitops.h: 42
     [exception RIP: resample_expand+412]
     RIP: ffffffff882234cc  RSP: ffff81002c243d88  RFLAGS: 00010207
     RAX: 0000000000000000  RBX: 000000000000024d  RCX: 000000000000007d
     RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffffc20000028e0e
     RBP: ffff81002c243de8   R8: 00000000000002eb   R9: ffffc200100e4466
     R10: 000000000000007d  R11: 0000000000000000  R12: 0000000000000000
     R13: ffff81003f2e9f58  R14: 0000000000000004  R15: ffff81003f2e9f7c
     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
  #8 [ffff81002c243df0] rate_transfer at ffffffff8822387b
     /home/saffroy/kernel/linux-2.6.18/sound/core/oss/rate.c: 281
  #9 [ffff81002c243e30] snd_pcm_plug_write_transfer at ffffffff88221438
     /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_plugin.c: 594
#10 [ffff81002c243e40] snd_pcm_plug_client_channels_buf at 
ffffffff88221319
     /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_plugin.c: 555
#11 [ffff81002c243e80] snd_pcm_oss_write2 at ffffffff8821f4b5
     /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c: 1284
#12 [ffff81002c243ec0] snd_pcm_oss_write at ffffffff882207e6
     /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c: 1342
#13 [ffff81002c243f00] vfs_write at ffffffff80215a22
     /home/saffroy/kernel/linux-2.6.18/fs/read_write.c: 316
#14 [ffff81002c243f40] sys_write at ffffffff80216320
     /home/saffroy/kernel/linux-2.6.18/fs/read_write.c: 369
     RIP: 00000000f7e2f3a1  RSP: 00000000ffd1b284  RFLAGS: 00000293
     RAX: 0000000000000004  RBX: ffffffff8026480e  RCX: 000000000ac13178
     RDX: 0000000000002000  RSI: 00000000ffd1b2a0  RDI: 0000000000000000
     RBP: 00000000ffd1b2c8   R8: ffffffffffffff10   R9: 00000000f756eff4
     R10: 0000000000000002  R11: 0000000000000002  R12: 0000000000000000
     R13: 0000000000000000  R14: 0000000000000000  R15: 000000000000003e
     ORIG_RAX: 0000000000000004  CS: 0023  SS: 002b

PID: 5220   TASK: ffff81001ee6b830  CPU: 1   COMMAND: "firefox-bin"
  #0 [ffff81003ffbff20] crash_nmi_callback at ffffffff8027b317
     include2/asm/atomic.h: 117
  #1 [ffff81003ffbff30] do_nmi at ffffffff80269411
     /home/saffroy/kernel/linux-2.6.18/arch/x86_64/kernel/nmi.c: 599
  #2 [ffff81003ffbff50] nmi at ffffffff80268857
     /home/saffroy/arch/x86_64/kernel/entry.S
     [exception RIP: __smp_call_function+118]
     RIP: ffffffff80277df6  RSP: ffff8100205fdb78  RFLAGS: 00000202
     RAX: 0000000000000000  RBX: 0000000000000001  RCX: 0000000000000001
     RDX: 00000000000c08fc  RSI: 0000000000000000  RDI: 0000000000000000
     RBP: ffff8100205fdbb8   R8: 0000000000000000   R9: 0000000000000000
     R10: 0000000000018b59  R11: 0000000000000001  R12: 0000000000000001
     R13: ffffffff80277cd0  R14: 0000000000000000  R15: ffff810037918008
     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
WARNING: possibly bogus exception frame
--- <exception stack> ---
  #3 [ffff8100205fdb78] __smp_call_function at ffffffff80277df6
     include2/asm/processor.h: 396
  #4 [ffff8100205fdbc0] smp_call_function at ffffffff80277f42
     include2/asm/spinlock.h: 62
  #5 [ffff8100205fdbf0] on_each_cpu at ffffffff8028fa8f
     /home/saffroy/kernel/linux-2.6.18/kernel/softirq.c: 630
  #6 [ffff8100205fdc20] flush_tlb_all at ffffffff80277c0c
     /home/saffroy/kernel/linux-2.6.18/arch/x86_64/kernel/smp.c: 285
  #7 [ffff8100205fdc30] unmap_vm_area at ffffffff80255b87
     /home/saffroy/kernel/linux-2.6.18/mm/vmalloc.c: 85
  #8 [ffff8100205fdc38] init_level4_pgt at ffffffff80201c28
  #9 [ffff8100205fdca0] __remove_vm_area at ffffffff802be3c8
     /home/saffroy/kernel/linux-2.6.18/mm/vmalloc.c: 285
#10 [ffff8100205fdcc0] remove_vm_area at ffffffff802be780
     include2/asm/spinlock.h: 130
#11 [ffff8100205fdce0] __vunmap at ffffffff802be7f5
     /home/saffroy/kernel/linux-2.6.18/mm/vmalloc.c: 326
#12 [ffff8100205fdd10] vfree at ffffffff802be92f
     /home/saffroy/kernel/linux-2.6.18/mm/vmalloc.c: 368
#13 [ffff8100205fdd20] snd_pcm_oss_change_params at ffffffff8821e99b
     /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c: 1011
#14 [ffff8100205fde60] snd_pcm_oss_get_active_substream at 
ffffffff8821f10e
     /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c: 1039
#15 [ffff8100205fde90] snd_pcm_oss_get_rate at ffffffff8821f151
     /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c: 1636
#16 [ffff8100205fdea0] snd_pcm_oss_set_channels at ffffffff8821f229
     /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c: 1660
#17 [ffff8100205fdeb0] snd_pcm_oss_ioctl at ffffffff8821fd6c
     /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c: 2409
#18 [ffff8100205fdf10] compat_sys_ioctl at ffffffff802e3a81
     /home/saffroy/kernel/linux-2.6.18/fs/compat.c: 426
#19 [ffff8100205fdf30] compat_sys_fcntl64 at ffffffff802e2508
     /home/saffroy/kernel/linux-2.6.18/fs/compat.c: 585
     RIP: 00000000f7504904  RSP: 00000000b9a62088  RFLAGS: 00000246
     RAX: 0000000000000036  RBX: ffffffff8026480e  RCX: 00000000c0045002
     RDX: 00000000b9a620f4  RSI: 0000000000000000  RDI: 0000000000000000
     RBP: 00000000b9a620e8   R8: ffffffffffffffed   R9: 0000000000000001
     R10: 0000000000000001  R11: 00000000b9a622dc  R12: 0000000000000000
     R13: 0000000000000000  R14: 0000000000000000  R15: 0000000000000000
     ORIG_RAX: 0000000000000036  CS: 0023  SS: 002b


Cheers,

-- 
saffroy@gmail.com

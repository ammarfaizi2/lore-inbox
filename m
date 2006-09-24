Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWIXUyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWIXUyb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 16:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWIXUyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 16:54:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932090AbWIXUya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 16:54:30 -0400
Date: Sun, 24 Sep 2006 13:54:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jean-Marc Saffroy <saffroy@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: oops in :snd_pcm_oss:resample_expand+0x19c/0x1f0
Message-Id: <20060924135417.c0c18b76.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609241825280.4838@erda.mds>
References: <Pine.LNX.4.64.0609241825280.4838@erda.mds>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 19:01:27 +0200 (CEST)
Jean-Marc Saffroy <saffroy@gmail.com> wrote:

> Hello folks,
> 
> I hit the following bug a few times on my desktop:
> 
> Unable to handle kernel paging request at ffffc200100e4466 RIP:
>   [<ffffffff882234cc>] :snd_pcm_oss:resample_expand+0x19c/0x1f0
> 
> ...
>
> I keep a crash dump from kdump,

Whoa.  Impressed.  Which distro are you using and how did you go about this
and how much fuss was it to set up?

> Oh and I wish I could use gdb on a kdump core. :-)

Would be nice, but this is much better than what we usually get, no?

> %%%%%%% crash> bt -loa
> 
> PID: 4860   TASK: ffff810037a1a080  CPU: 0   COMMAND: "firefox-bin"
>   #0 [ffff81002c243aa0] crash_kexec at ffffffff802a855b
>      /home/saffroy/kernel/linux-2.6.18/kernel/kexec.c: 1062
>   #1 [ffff81002c243b28] resample_expand at ffffffff882234cc
>      /home/saffroy/kernel/linux-2.6.18/sound/core/oss/rate.c: 116
>   #2 [ffff81002c243b70] __die at ffffffff80268c23
>      /home/saffroy/kernel/linux-2.6.18/arch/x86_64/kernel/traps.c: 561
>   #3 [ffff81002c243bc0] do_page_fault at ffffffff8026a887
>      /home/saffroy/kernel/linux-2.6.18/arch/x86_64/mm/fault.c: 579
>   #4 [ffff81002c243bd0] snd_pcm_do_reset at ffffffff881e612e
>      /home/saffroy/kernel/linux-2.6.18/sound/core/pcm_native.c: 1253
>   #5 [ffff81002c243c60] mutex_unlock at ffffffff80266b69
>      /home/saffroy/kernel/linux-2.6.18/kernel/mutex.c: 117
>   #6 [ffff81002c243c70] snd_pcm_common_ioctl1 at ffffffff881e9e9d
>      /home/saffroy/kernel/linux-2.6.18/include/sound/core.h: 158
>   #7 [ffff81002c243cd0] error_exit at ffffffff8026374d
>      /home/saffroy/kernel/linux-2.6.18/include/linux/bitops.h: 42
>      [exception RIP: resample_expand+412]
>      RIP: ffffffff882234cc  RSP: ffff81002c243d88  RFLAGS: 00010207
>      RAX: 0000000000000000  RBX: 000000000000024d  RCX: 000000000000007d
>      RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffffc20000028e0e
>      RBP: ffff81002c243de8   R8: 00000000000002eb   R9: ffffc200100e4466
>      R10: 000000000000007d  R11: 0000000000000000  R12: 0000000000000000
>      R13: ffff81003f2e9f58  R14: 0000000000000004  R15: ffff81003f2e9f7c
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
>   #8 [ffff81002c243df0] rate_transfer at ffffffff8822387b
>      /home/saffroy/kernel/linux-2.6.18/sound/core/oss/rate.c: 281
>   #9 [ffff81002c243e30] snd_pcm_plug_write_transfer at ffffffff88221438
>      /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_plugin.c: 594
> #10 [ffff81002c243e40] snd_pcm_plug_client_channels_buf at 
> ffffffff88221319
>      /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_plugin.c: 555
> #11 [ffff81002c243e80] snd_pcm_oss_write2 at ffffffff8821f4b5
>      /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c: 1284
> #12 [ffff81002c243ec0] snd_pcm_oss_write at ffffffff882207e6
>      /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c: 1342
> #13 [ffff81002c243f00] vfs_write at ffffffff80215a22
>      /home/saffroy/kernel/linux-2.6.18/fs/read_write.c: 316
> #14 [ffff81002c243f40] sys_write at ffffffff80216320
>      /home/saffroy/kernel/linux-2.6.18/fs/read_write.c: 369
>      RIP: 00000000f7e2f3a1  RSP: 00000000ffd1b284  RFLAGS: 00000293
>      RAX: 0000000000000004  RBX: ffffffff8026480e  RCX: 000000000ac13178
>      RDX: 0000000000002000  RSI: 00000000ffd1b2a0  RDI: 0000000000000000
>      RBP: 00000000ffd1b2c8   R8: ffffffffffffff10   R9: 00000000f756eff4
>      R10: 0000000000000002  R11: 0000000000000002  R12: 0000000000000000
>      R13: 0000000000000000  R14: 0000000000000000  R15: 000000000000003e
>      ORIG_RAX: 0000000000000004  CS: 0023  SS: 002b
> 
> PID: 5220   TASK: ffff81001ee6b830  CPU: 1   COMMAND: "firefox-bin"
>   #0 [ffff81003ffbff20] crash_nmi_callback at ffffffff8027b317
>      include2/asm/atomic.h: 117
>   #1 [ffff81003ffbff30] do_nmi at ffffffff80269411
>      /home/saffroy/kernel/linux-2.6.18/arch/x86_64/kernel/nmi.c: 599
>   #2 [ffff81003ffbff50] nmi at ffffffff80268857
>      /home/saffroy/arch/x86_64/kernel/entry.S
>      [exception RIP: __smp_call_function+118]
>      RIP: ffffffff80277df6  RSP: ffff8100205fdb78  RFLAGS: 00000202
>      RAX: 0000000000000000  RBX: 0000000000000001  RCX: 0000000000000001
>      RDX: 00000000000c08fc  RSI: 0000000000000000  RDI: 0000000000000000
>      RBP: ffff8100205fdbb8   R8: 0000000000000000   R9: 0000000000000000
>      R10: 0000000000018b59  R11: 0000000000000001  R12: 0000000000000001
>      R13: ffffffff80277cd0  R14: 0000000000000000  R15: ffff810037918008
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
> WARNING: possibly bogus exception frame
> --- <exception stack> ---
>   #3 [ffff8100205fdb78] __smp_call_function at ffffffff80277df6
>      include2/asm/processor.h: 396
>   #4 [ffff8100205fdbc0] smp_call_function at ffffffff80277f42
>      include2/asm/spinlock.h: 62
>   #5 [ffff8100205fdbf0] on_each_cpu at ffffffff8028fa8f
>      /home/saffroy/kernel/linux-2.6.18/kernel/softirq.c: 630
>   #6 [ffff8100205fdc20] flush_tlb_all at ffffffff80277c0c
>      /home/saffroy/kernel/linux-2.6.18/arch/x86_64/kernel/smp.c: 285
>   #7 [ffff8100205fdc30] unmap_vm_area at ffffffff80255b87
>      /home/saffroy/kernel/linux-2.6.18/mm/vmalloc.c: 85
>   #8 [ffff8100205fdc38] init_level4_pgt at ffffffff80201c28
>   #9 [ffff8100205fdca0] __remove_vm_area at ffffffff802be3c8
>      /home/saffroy/kernel/linux-2.6.18/mm/vmalloc.c: 285
> #10 [ffff8100205fdcc0] remove_vm_area at ffffffff802be780
>      include2/asm/spinlock.h: 130
> #11 [ffff8100205fdce0] __vunmap at ffffffff802be7f5
>      /home/saffroy/kernel/linux-2.6.18/mm/vmalloc.c: 326
> #12 [ffff8100205fdd10] vfree at ffffffff802be92f
>      /home/saffroy/kernel/linux-2.6.18/mm/vmalloc.c: 368
> #13 [ffff8100205fdd20] snd_pcm_oss_change_params at ffffffff8821e99b
>      /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c: 1011
> #14 [ffff8100205fde60] snd_pcm_oss_get_active_substream at 
> ffffffff8821f10e
>      /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c: 1039
> #15 [ffff8100205fde90] snd_pcm_oss_get_rate at ffffffff8821f151
>      /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c: 1636
> #16 [ffff8100205fdea0] snd_pcm_oss_set_channels at ffffffff8821f229
>      /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c: 1660
> #17 [ffff8100205fdeb0] snd_pcm_oss_ioctl at ffffffff8821fd6c
>      /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c: 2409
> #18 [ffff8100205fdf10] compat_sys_ioctl at ffffffff802e3a81
>      /home/saffroy/kernel/linux-2.6.18/fs/compat.c: 426
> #19 [ffff8100205fdf30] compat_sys_fcntl64 at ffffffff802e2508
>      /home/saffroy/kernel/linux-2.6.18/fs/compat.c: 585
>      RIP: 00000000f7504904  RSP: 00000000b9a62088  RFLAGS: 00000246
>      RAX: 0000000000000036  RBX: ffffffff8026480e  RCX: 00000000c0045002
>      RDX: 00000000b9a620f4  RSI: 0000000000000000  RDI: 0000000000000000
>      RBP: 00000000b9a620e8   R8: ffffffffffffffed   R9: 0000000000000001
>      R10: 0000000000000001  R11: 00000000b9a622dc  R12: 0000000000000000
>      R13: 0000000000000000  R14: 0000000000000000  R15: 0000000000000000
>      ORIG_RAX: 0000000000000036  CS: 0023  SS: 002b
>

[from other mail]

> is there a race between snd_pcm_oss_change_params() reallocating 
> a buffer and resample_expand() using another (possibly the same)?

It does rather look like that.

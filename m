Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVAMB0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVAMB0g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVAMBYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 20:24:15 -0500
Received: from hqemgate03.nvidia.com ([216.228.112.143]:40971 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S261476AbVAMBWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 20:22:02 -0500
Date: Wed, 12 Jan 2005 19:21:59 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Voluspa <lista1@telia.com>
Cc: linux-kernel@vger.kernel.org, tripperda@nvidia.com
Subject: Re: Linux 2.6.11-rc1
Message-ID: <20050113012159.GB15008@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20050112095238.32a89245.lista1@telia.com> <20050113021328.137435b8.lista1@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113021328.137435b8.lista1@telia.com>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7
X-OriginalArrivalTime: 13 Jan 2005 01:22:00.0842 (UTC) FILETIME=[482466A0:01C4F90E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this looks suspiciously like a kernel bug Andi Kleen and I are
currently investigating. He has fixes in the bk branches. I would have
expected them to be in such a new kernel, but I noticed that you're
using an x86 kernel, and his initial fixes were only in the x86_64
arch files.

change_page_attr has a book-keeping bug that surprisingly hasn't
caused problems until recently (on my todo list is to track down what
caused this problem to suddenly start triggering).

the x86_64 change in bk is here, but the only thing you really need is
the 'get_page' fix. you should be able to manually edit
linux/arch/i386/mm/pageattr.c:__change_page_attr(), update that single
line and be fine:

http://linux.bkbits.net:8080/linux-2.6/diffs/arch/x86_64/mm/pageattr.c@1.13?nav=index.html|src/|src/arch|src/arch/x86_64|src/arch/x86_64/mm|hist/arch/x86_64/mm/pageattr.c

Thanks,
Terence

On Thu, Jan 13, 2005 at 02:13:28AM +0100, lista1@telia.com wrote:
> On Wed, 12 Jan 2005 09:52:38 +0100 Voluspa wrote:
> 
> > Yes, tainted. X black screen, no keyboard. Power button to turn off. I
> > really don't feel like compiling lots of debug-kernels to chase this,
> > unless someone is really interested, which I doubt.
> 
> A fyi directed to other users: It was the nvidia module. Xorg nv is
> fine. Did a CONFIG_KALLSYMS=y kernel and am attaching the output.
> 
> Turning on relevant debugging options in "Kernel hacking" hides the bug
> (ie prevents it from happening). Very annoying and is a behaviour I've
> seen before with other bugs. The price of kernel complexity, I guess.
> 
> -- 
> Mvh
> Mats Johannesson

> [-- mutt.octet.filter file type: "ASCII text, with very long lines" --]
> 
> 
> Jan 13 01:09:42 loke kernel: ------------[ cut here ]------------
> Jan 13 01:09:42 loke kernel: kernel BUG at <bad filename>:395!
> Jan 13 01:09:42 loke kernel: invalid operand: 0000 [#1]
> Jan 13 01:09:42 loke kernel: PREEMPT 
> Jan 13 01:09:42 loke kernel: Modules linked in: nvidia 8139too crc32 snd_seq_oss snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_event snd_seq_midi_emul snd_seq snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore
> Jan 13 01:09:42 loke kernel: CPU:    0
> Jan 13 01:09:42 loke kernel: EIP:    0060:[__change_page_attr+169/286]    Tainted: P      VLI
> Jan 13 01:09:42 loke kernel: EFLAGS: 00213002   (2.6.11-rc1) 
> Jan 13 01:09:42 loke kernel: EIP is at __change_page_attr+0xa9/0x11e
> Jan 13 01:09:42 loke kernel: eax: 054001e3   ebx: 05530000   ecx: c1006c40   edx: 054001e3
> Jan 13 01:09:42 loke kernel: esi: c0362c54   edi: 00000163   ebp: c1000000   esp: ca147db4
> Jan 13 01:09:42 loke kernel: ds: 007b   es: 007b   ss: 0068
> Jan 13 01:09:42 loke kernel: Process X (pid: 575, threadinfo=ca147000 task=cd4b4060)
> Jan 13 01:09:42 loke kernel: Stack: c5530000 c10aa600 00000010 00000000 00203246 c010db9d 00000163 00000011 
> Jan 13 01:09:42 loke kernel:        c10aa400 ce2eda60 cd54fc00 ca147e20 c010d883 00010000 d0a80000 d0f75bec 
> Jan 13 01:09:42 loke kernel:        d0d8a180 d0a80000 00010000 cd54fc00 d0d8a173 cff08400 cd54f400 ca147e60 
> Jan 13 01:09:42 loke kernel: Call Trace:
> Jan 13 01:09:42 loke kernel:  [change_page_attr+48/97] change_page_attr+0x30/0x61
> Jan 13 01:09:42 loke kernel:  [iounmap+101/118] iounmap+0x65/0x76
> Jan 13 01:09:42 loke kernel:  [pg0+280927212/1070015488] os_unmap_kernel_space+0x9/0xa [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278913408/1070015488] _nv001706rm+0x20/0x2c [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278913395/1070015488] _nv001706rm+0x13/0x2c [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278898481/1070015488] _nv002359rm+0xe9/0x184 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278862458/1070015488] _nv001955rm+0x36/0xe0 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278935092/1070015488] _nv001297rm+0x9c/0xa8 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278940044/1070015488] rm_teardown_agp+0x48/0x50 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278862458/1070015488] _nv001955rm+0x36/0xe0 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+280919192/1070015488] nv_agp_teardown+0x4c/0x7c [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278922699/1070015488] _nv001708rm+0x73/0xa0 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278865062/1070015488] _nv001847rm+0x26/0x2c [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278925180/1070015488] _nv000650rm+0x58/0xcc [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278925271/1070015488] _nv000650rm+0xb3/0xcc [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278926961/1070015488] _nv001362rm+0x71/0xb0 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278926974/1070015488] _nv001362rm+0x7e/0xb0 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278914238/1070015488] _nv001820rm+0x12/0x18 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278937831/1070015488] rm_disable_adapter+0x2f/0x8c [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278937879/1070015488] rm_disable_adapter+0x5f/0x8c [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278937867/1070015488] rm_disable_adapter+0x53/0x8c [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+280910374/1070015488] nv_kern_close+0x168/0x1e1 [nvidia]
> Jan 13 01:09:42 loke kernel:  [__fput+61/228] __fput+0x3d/0xe4
> Jan 13 01:09:42 loke kernel:  [filp_close+89/95] filp_close+0x59/0x5f
> Jan 13 01:09:42 loke kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
> Jan 13 01:09:42 loke kernel: Code: 56 37 c0 c1 f9 05 c1 e1 0c 0b 0d c8 62 2c c0 e8 10 ff ff ff 89 d9 ff 41 04 eb 12 a9 80 00 00 00 75 09 09 fb 89 1e ff 49 04 eb 02 <0f> 0b 8b 01 f6 c4 08 75 64 8b 41 04 40 75 02 0f 0b a1 0c 4e 2c 
> Jan 13 01:09:42 loke kernel:  <6>note: X[575] exited with preempt_count 1
> Jan 13 01:09:42 loke kernel: scheduling while atomic: X/0x00000001/575
> Jan 13 01:09:42 loke kernel:  [schedule+64/1068] schedule+0x40/0x42c
> Jan 13 01:09:42 loke kernel:  [autoremove_wake_function+0/45] autoremove_wake_function+0x0/0x2d
> Jan 13 01:09:42 loke kernel:  [__sched_text_start+134/237] __down+0x86/0xed
> Jan 13 01:09:42 loke kernel:  [default_wake_function+0/12] default_wake_function+0x0/0xc
> Jan 13 01:09:42 loke kernel:  [release_mem+446/458] release_mem+0x1be/0x1ca
> Jan 13 01:09:42 loke kernel:  [__down_failed+7/12] __down_failed+0x7/0xc
> Jan 13 01:09:42 loke kernel:  [pg0+280927615/1070015488] .text.lock.os_interface+0x7/0x18 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278914238/1070015488] _nv001820rm+0x12/0x18 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278939386/1070015488] rm_free_unused_clients+0x2e/0x88 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278939410/1070015488] rm_free_unused_clients+0x46/0x88 [nvidia]
> Jan 13 01:09:42 loke kernel:  [dput+27/459] dput+0x1b/0x1cb
> Jan 13 01:09:42 loke kernel:  [pg0+280913993/1070015488] nv_kern_ctl_close+0x77/0xa1 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+280910265/1070015488] nv_kern_close+0xfb/0x1e1 [nvidia]
> Jan 13 01:09:42 loke kernel:  [destroy_inode+34/49] destroy_inode+0x22/0x31
> Jan 13 01:09:42 loke kernel:  [__fput+61/228] __fput+0x3d/0xe4
> Jan 13 01:09:42 loke kernel:  [filp_close+89/95] filp_close+0x59/0x5f
> Jan 13 01:09:42 loke kernel:  [put_files_struct+86/169] put_files_struct+0x56/0xa9
> Jan 13 01:09:42 loke kernel:  [do_exit+257/703] do_exit+0x101/0x2bf
> Jan 13 01:09:42 loke kernel:  [do_trap+0/162] do_trap+0x0/0xa2
> Jan 13 01:09:42 loke kernel:  [do_invalid_op+0/139] do_invalid_op+0x0/0x8b
> Jan 13 01:09:42 loke kernel:  [do_invalid_op+127/139] do_invalid_op+0x7f/0x8b
> Jan 13 01:09:42 loke kernel:  [__change_page_attr+169/286] __change_page_attr+0xa9/0x11e
> Jan 13 01:09:42 loke kernel:  [kobject_get+15/19] kobject_get+0xf/0x13
> Jan 13 01:09:42 loke kernel:  [get_device+14/20] get_device+0xe/0x14
> Jan 13 01:09:42 loke kernel:  [pci_dev_get+15/19] pci_dev_get+0xf/0x13
> Jan 13 01:09:42 loke kernel:  [pci_get_subsys+174/206] pci_get_subsys+0xae/0xce
> Jan 13 01:09:42 loke kernel:  [pci_get_device+11/14] pci_get_device+0xb/0xe
> Jan 13 01:09:42 loke kernel:  [pg0+280926374/1070015488] os_pci_init_handle+0x7d/0x86 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pci_read+28/33] pci_read+0x1c/0x21
> Jan 13 01:09:42 loke kernel:  [error_code+43/48] error_code+0x2b/0x30
> Jan 13 01:09:42 loke kernel:  [__change_page_attr+169/286] __change_page_attr+0xa9/0x11e
> Jan 13 01:09:42 loke kernel:  [change_page_attr+48/97] change_page_attr+0x30/0x61
> Jan 13 01:09:42 loke kernel:  [iounmap+101/118] iounmap+0x65/0x76
> Jan 13 01:09:42 loke kernel:  [pg0+280927212/1070015488] os_unmap_kernel_space+0x9/0xa [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278913408/1070015488] _nv001706rm+0x20/0x2c [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278913395/1070015488] _nv001706rm+0x13/0x2c [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278898481/1070015488] _nv002359rm+0xe9/0x184 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278862458/1070015488] _nv001955rm+0x36/0xe0 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278935092/1070015488] _nv001297rm+0x9c/0xa8 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278940044/1070015488] rm_teardown_agp+0x48/0x50 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278862458/1070015488] _nv001955rm+0x36/0xe0 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+280919192/1070015488] nv_agp_teardown+0x4c/0x7c [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278922699/1070015488] _nv001708rm+0x73/0xa0 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278865062/1070015488] _nv001847rm+0x26/0x2c [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278925180/1070015488] _nv000650rm+0x58/0xcc [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278925271/1070015488] _nv000650rm+0xb3/0xcc [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278926961/1070015488] _nv001362rm+0x71/0xb0 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278926974/1070015488] _nv001362rm+0x7e/0xb0 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278914238/1070015488] _nv001820rm+0x12/0x18 [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278937831/1070015488] rm_disable_adapter+0x2f/0x8c [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278937879/1070015488] rm_disable_adapter+0x5f/0x8c [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+278937867/1070015488] rm_disable_adapter+0x53/0x8c [nvidia]
> Jan 13 01:09:42 loke kernel:  [pg0+280910374/1070015488] nv_kern_close+0x168/0x1e1 [nvidia]
> Jan 13 01:09:42 loke kernel:  [__fput+61/228] __fput+0x3d/0xe4
> Jan 13 01:09:42 loke kernel:  [filp_close+89/95] filp_close+0x59/0x5f
> Jan 13 01:09:42 loke kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
> 


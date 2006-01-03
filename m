Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWACI0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWACI0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 03:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWACI0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 03:26:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8863 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751177AbWACI0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 03:26:11 -0500
Date: Tue, 3 Jan 2006 03:26:09 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: mm/rmap.c negative page map count BUG.
Message-ID: <20060103082609.GB11738@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has cropped up from time to time in the last few Fedora
kernels, by several users. I just got another report that it's
still a problem on 2.6.15rc7 based kernels (so likely .15 final too).

 kernel: kernel BUG at mm/rmap.c:486!
 kernel: invalid operand: 0000 [#1]
 kernel: Modules linked in: parport_pc lp parport nfs lockd nfs_acl autofs4 sunrpc dm_mod ipv6 uhci_hcd shpchp i2c_piix4 i2c_core snd_es18xx snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore tlan floppy ext3 jbd aic7xxx scsi_transport_spi sd_mod scsi_mod
 kernel: CPU:    0
 kernel: EIP:    0060:[<c01502b2>]    Not tainted VLI
 kernel: EFLAGS: 00010286   (2.6.14-1.1769_FC4) 
 kernel: EIP is at page_remove_rmap+0x25/0x2f
 kernel: eax: ffffffff   ebx: c8331e30   ecx: c1152360   edx: c1152360
 kernel: esi: 08f8c000   edi: c1152360   ebp: 00000000   esp: c2114d78
 kernel: ds: 007b   es: 007b   ss: 0068
 kernel: Process udevd (pid: 11892, threadinfo=c2114000 task=c54af030)
 kernel: Stack: c0149a90 c3d70e34 c0419b20 c349d440 ffffffff ffffff3f c349d490 c2e6b08c 
 kernel:        09000000 c2114dfc c2e6b08c c0149ccb 08ecb000 09000000 c2114dfc 00000000 
 kernel:        c3d70e34 c0419b20 c2e6b08c 0913dfff 08ecb000 c3d70e34 0913e000 c2114e24 
 kernel: Call Trace:
 kernel:  [<c0149a90>] zap_pte_range+0x105/0x25a  [<c0149ccb>] unmap_page_range+0xe6/0x110
 kernel:  [<c0149dc7>] unmap_vmas+0xd2/0x1f1     [<c014e5f2>] exit_mmap+0x5f/0xda
 kernel:  [<c0119669>] mmput+0x1f/0x95     [<c0162f1f>] exec_mmap+0xc7/0x149
 kernel:  [<c0163084>] flush_old_exec+0x7b/0x8b7     [<c01595ff>] vfs_read+0xf6/0x158
 kernel:  [<c0162e4e>] kernel_read+0x37/0x41     [<c0182e30>] load_elf_binary+0x2b9/0xd8e
 kernel:  [<c01408b0>] __alloc_pages+0x57/0x2ed     [<c01df430>] copy_from_user+0x42/0x82
 kernel:  [<c0182b77>] load_elf_binary+0x0/0xd8e     [<c0163b32>] search_binary_handler+0x7a/0x243
 kernel:  [<c0163ee3>] do_execve+0x1e8/0x210     [<c0101b3f>] sys_execve+0x30/0x72
 kernel:  [<c0102ec5>] syscall_call+0x7/0xb    
 kernel: Code: 2e 0d 33 c0 eb bf 89 c2 83 40 08 ff 0f 98 c0 84 c0 75 01 c3 8b 42 08 83 c0 01 78 0f ba ff ff ff ff b8 10 00 00 00 e9 32 0b ff ff <0f> 0b e6 01 2e 0d 33 c0 eb e7 55 57 56 53 83 ec 0c 89 c7 89 d3 

The BUG it's hitting is the BUG_ON(page_mapcount(page) < 0); in page_remove_rmap()

anyone with any ideas wtf happened here ?

shortly after hitting this, the users usually report thing likes like ...

kernel: Bad page state at free_hot_cold_page (in process 'kswapd0', page c1152360)
kernel: flags:0x80000010 mapping:00000000 mapcount:-1 count:0

In no examples seen have there been binary modules loaded, and no obvious
signs of hardware failure (some of them have run memtest86 with no problems found)

		Dave


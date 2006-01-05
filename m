Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752107AbWAEHrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbWAEHrn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 02:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbWAEHrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 02:47:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38878 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752107AbWAEHrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 02:47:42 -0500
Date: Thu, 5 Jan 2006 02:47:18 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: mm/rmap.c negative page map count BUG.
Message-ID: <20060105074718.GF20809@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
	linux-kernel@vger.kernel.org
References: <20060103082609.GB11738@redhat.com> <43BA630F.1020805@yahoo.com.au> <20060103135312.GB18060@redhat.com> <20060104155326.351a9c01.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104155326.351a9c01.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 03:53:26PM -0800, Andrew Morton wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > >
 > >  > Can you print ->flags, ->count, ->mapping, etc instead of going BUG?
 > > 
 > > I can add some instrumentation like this though, and see what turns up.
 > 
 > Can we get that instrumentation into the upstream kernel please?  We do
 > seem to be hitting rmap assertions too often for it to be dud
 > hardware/bodgy drivers/etc.

I had a quick skim through bugme.osdl.org & Red Hat bugzilla.

Seems to be a few variants of this problem reported.
Quite a few Fedora users have hit it over the last year,
but what I find fascinating is that there's not a single
occurance of "BUG at mm/rmap.c" in our 2.6.9 based RHEL4 bug reports.

		Dave


2005-08-07
http://bugme.osdl.org/show_bug.cgi?id=3636

	Oct 25 04:41:47 www kernel: kernel BUG at mm/rmap.c:474!
	Oct 25 04:41:47 www kernel: invalid operand: 0000 [#4]
	Oct 25 04:41:47 www kernel: PREEMPT
	Oct 25 04:41:47 www kernel: Modules linked in:
	Oct 25 04:41:47 www kernel: CPU:    0
	Oct 25 04:41:47 www kernel: EIP:    0060:[<c0147319>]    Not tainted VLI
	Oct 25 04:41:47 www kernel: EFLAGS: 00010286   (2.6.9)
	Oct 25 04:41:47 www kernel: EIP is at page_remove_rmap+0x29/0x40
	Oct 25 04:41:47 www kernel: eax: ffffffff   ebx: 000dd000   ecx: c1160bc0   edx: c1160bc0
	Oct 25 04:41:47 www kernel: esi: c5e6f894   edi: c1160bc0   ebp: 00100000   esp: c9e93e90
	Oct 25 04:41:47 www kernel: ds: 007b   es: 007b   ss: 0068
	Oct 25 04:41:47 www kernel: Process show_bug.cgi (pid: 16375, threadinfo=c9e92000 task=cdac9020)
	Oct 25 04:41:47 www kernel: Stack: c0140ce6 c1160bc0 c02e6790 c9dec7a0 00000000 0b05e067 08948000 c4325088
	Oct 25 04:41:47 www kernel:        08648000 00000000 c0140e47 c045a008 c4325084 08548000 00100000 00000000
	Oct 25 04:41:47 www kernel:        c045a008 08548000 c4325088 08648000 00000000 c0140ebb c045a008 c4325084
	Oct 25 04:41:47 www kernel: Call Trace:
	Oct 25 04:41:47 www kernel:  [<c0140ce6>] zap_pte_range+0x126/0x230
	Oct 25 04:41:47 www kernel:  [<c02e6790>] ip_rcv_finish+0x0/0x270
	Oct 25 04:41:47 www kernel:  [<c0140e47>] zap_pmd_range+0x57/0x80
	Oct 25 04:41:47 www kernel:  [<c0140ebb>] unmap_page_range+0x4b/0x80
	Oct 25 04:41:47 www kernel:  [<c0140fed>] unmap_vmas+0xfd/0x1c0
	Oct 25 04:41:47 www kernel:  [<c0145593>] exit_mmap+0x83/0x160
	Oct 25 04:41:47 www kernel:  [<c01161d4>] mmput+0x64/0xb0
	Oct 25 04:41:47 www kernel:  [<c011aa72>] do_exit+0x152/0x420
	Oct 25 04:41:47 www kernel:  [<c010654d>] do_IRQ+0xfd/0x130
	Oct 25 04:41:47 www kernel:  [<c011adca>] do_group_exit+0x3a/0xb0
	Oct 25 04:41:47 www kernel:  [<c010421b>] syscall_call+0x7/0xb

2005-03-22
http://bugme.osdl.org/show_bug.cgi?id=4388

	Nov  4 13:55:03 localhost kernel: kernel BUG at mm/rmap.c:487!
	Nov  4 13:55:03 localhost kernel: invalid operand: 0000 [#1]
	Nov  4 13:55:03 localhost kernel: PREEMPT 
	Nov  4 13:55:03 localhost kernel: Modules linked in: radeon drm
	Nov  4 13:55:03 localhost kernel: CPU:    0
	Nov  4 13:55:03 localhost kernel: EIP:    0060:[page_remove_rmap+71/96]    Not tainted VLI
	Nov  4 13:55:03 localhost kernel: EFLAGS: 00010286   (2.6.14) 
	Nov  4 13:55:03 localhost kernel: EIP is at page_remove_rmap+0x47/0x60
	Nov  4 13:55:03 localhost kernel: eax: ffffffff   ebx: ccdbd244   ecx: 00000002   edx: c11cb8c0
	Nov  4 13:55:03 localhost kernel: esi: c11cb8c0   edi: 41891000   ebp: ce246d88   esp: ce246d80
	Nov  4 13:55:03 localhost kernel: ds: 007b   es: 007b   ss: 0068
	Nov  4 13:55:03 localhost kernel: Process postmaster (pid: 1914, threadinfo=ce246000 task=ce179560)
	Nov  4 13:55:04 localhost kernel: Stack: c014943d ccdbd244 ce246dac c014dd6c c11cb8c0 00000000 00000001 0e5c6025 
	Nov  4 13:55:04 localhost kernel:        cebab41c 41897000 41897000 ce246dd8 c014df24 c04e94ac cebab418 4188f000 
	Nov  4 13:55:04 localhost kernel:        41897000 00000000 41896fff 00008000 41897000 cd7a8634 ce246e18 c014e039 
	Nov  4 13:55:04 localhost kernel: Call Trace:
	Nov  4 13:55:04 localhost kernel:  [show_stack+171/240] show_stack+0xab/0xf0
	Nov  4 13:55:04 localhost kernel:  [show_registers+399/560] show_registers+0x18f/0x230
	Nov  4 13:55:04 localhost kernel:  [die+237/400] die+0xed/0x190
	Nov  4 13:55:04 localhost kernel:  [do_trap+137/208] do_trap+0x89/0xd0
	Nov  4 13:55:04 localhost kernel:  [do_invalid_op+170/192] do_invalid_op+0xaa/0xc0
	Nov  4 13:55:04 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
	Nov  4 13:55:04 localhost kernel:  [zap_pte_range+220/512] zap_pte_range+0xdc/0x200
	Nov  4 13:55:04 localhost kernel:  [unmap_page_range+148/208] unmap_page_range+0x94/0xd0
	Nov  4 13:55:04 localhost kernel:  [unmap_vmas+217/544] unmap_vmas+0xd9/0x220
	Nov  4 13:55:04 localhost kernel:  [exit_mmap+130/352] exit_mmap+0x82/0x160
	Nov  4 13:55:04 localhost kernel:  [mmput+53/176] mmput+0x35/0xb0
	Nov  4 13:55:04 localhost kernel:  [exit_mm+170/352] exit_mm+0xaa/0x160
	Nov  4 13:55:04 localhost kernel:  [do_exit+206/1184] do_exit+0xce/0x4a0
	Nov  4 13:55:04 localhost kernel:  [do_group_exit+59/208] do_group_exit+0x3b/0xd0
	Nov  4 13:55:04 localhost kernel:  [get_signal_to_deliver+515/848] get_signal_to_deliver+0x203/0x350
	Nov  4 13:55:04 localhost kernel:  [do_signal+87/288] do_signal+0x57/0x120
	Nov  4 13:55:04 localhost kernel:  [do_notify_resume+42/60] do_notify_resume+0x2a/0x3c
	Nov  4 13:55:04 localhost kernel:  [work_notifysig+19/25] work_notifysig+0x13/0x19

2005-08-23
http://bugme.osdl.org/show_bug.cgi?id=4873

	Jul 11 17:55:09 us401 kernel: kernel BUG at mm/rmap.c:493!
	Jul 11 17:55:09 us401 kernel: invalid operand: 0000 [#1]
	Jul 11 17:55:09 us401 kernel: SMP 
	Jul 11 17:55:09 us401 kernel: Modules linked in: netconsole iptable_nat ipv6 ipt_TOS iptable_mangle ip_conntrack_ftp ip_conntrack_irc ipt_LOG ipt_limit ipt_multiport autofs ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables sg scsi_mod parport_pc parport microcode loop video thermal processor fan button battery ac raid1
	Jul 11 17:55:09 us401 kernel: CPU:    2
	Jul 11 17:55:09 us401 kernel: EIP:    0060:[<c0151e99>]    Not tainted VLI
	Jul 11 17:55:09 us401 kernel: EFLAGS: 00010286   (2.6.12.1) 
	Jul 11 17:55:09 us401 kernel: EIP is at page_remove_rmap+0x39/0x50
	Jul 11 17:55:09 us401 kernel: eax: ffffffff   ebx: 00013508   ecx: 00000038   edx: c126a100
	Jul 11 17:55:09 us401 kernel: esi: ef60d720   edi: c126a100   ebp: 08ae4000   esp: ee869e84
	Jul 11 17:55:09 us401 kernel: ds: 007b   es: 007b   ss: 0068
	Jul 11 17:55:09 us401 kernel: Process httpd (pid: 28353, threadinfo=ee868000 task=d2d0c530)
	Jul 11 17:55:09 us401 kernel: Stack: c0145cd4 00013508 c014a9a7 c126a100 d2065be8 13508067 00000000 00000000 
	Jul 11 17:55:09 us401 kernel:        f5e52228 08ad0000 08b27000 c014ac16 c201a900 f5e52228 08ad0000 08b27000 
	Jul 11 17:55:09 us401 kernel:        00000000 08b26fff 08b26fff 08b27000 f77ba380 00057000 08b27000 08b27000 
	Jul 11 17:55:09 us401 kernel: Call Trace:
	Jul 11 17:55:09 us401 kernel:  [<c0145cd4>] mark_page_accessed+0x34/0x40
	Jul 11 17:55:09 us401 kernel:  [<c014a9a7>] zap_pte_range+0x107/0x270
	Jul 11 17:55:09 us401 kernel:  [<c014ac16>] unmap_page_range+0x106/0x150
	Jul 11 17:55:09 us401 kernel:  [<c014ad56>] unmap_vmas+0xf6/0x250
	Jul 11 17:55:09 us401 kernel:  [<c014f6b3>] unmap_region+0xb3/0x160
	Jul 11 17:55:09 us401 kernel:  [<c014f9df>] do_munmap+0x10f/0x150
	Jul 11 17:55:09 us401 kernel:  [<c014de22>] sys_brk+0x112/0x120
	Jul 11 17:55:09 us401 kernel:  [<c0102daf>] sysenter_past_esp+0x54/0x75
	Jul 11 17:55:09 us401 kernel: Code: f0 83 42 08 ff 0f 98 c0 84 c0 74 1b 8b 42 08 40 78 19 c7 04 24 10 00 00 00 b8 ff ff ff ff 89 44 24 04 e8 bb f3 fe ff 83 c4 08 c3

2005-11-27
http://bugme.osdl.org/show_bug.cgi?id=5666

	kernel BUG at mm/rmap.c:487!    
	invalid operand: 0000 [#1]    
	Modules linked in: af_packet ipt_limit ipt_state iptable_mangle iptable_nat    
	ip_nat iptable_filter ipt_ULOG ip_tables ipv6 ip_conntrack_ftp ip_conntrack    
	via_rhine sis900 mii unix    
	CPU:    0    
	EIP:    0060:[<c014b5a7>]    Tainted: G   M  VLI    
	EFLAGS: 00010286   (2.6.14)    
	EIP is at page_remove_rmap+0x37/0x50    
	eax: ffffffff   ebx: d5097c20   ecx: c03e9dcc   edx: c11fa560    
	esi: b7f08000   edi: c11fa560   ebp: 00000020   esp: cf9ddebc    
	ds: 007b   es: 007b   ss: 0068    
	Process apache2 (pid: 22104, threadinfo=cf9dc000 task=dd0850b0)    
	Stack: c11f3fe0 d5097c20 c0145298 c11fa560 b76bc000 d7daab7c b7f2d000 b7f2d000    
	       b7f2cfff c014541a c03e9dcc d7daab7c b7f06000 b7f2d000 00000000 00027000    
	       b7f2d000 b7f2d000 d15e7284 c0145529 c03e9dcc d15e7284 b7f06000 b7f2d000    
	Call Trace:    
	 [<c0145298>] zap_pte_range+0xd8/0x1d0    
	 [<c014541a>] unmap_page_range+0x8a/0xb0    
	 [<c0145529>] unmap_vmas+0xe9/0x1e0    
	 [<c0149a59>] exit_mmap+0x79/0x150    
	 [<c01181dc>] mmput+0x2c/0x80    
	 [<c011c3a8>] do_exit+0xd8/0x390    
	 [<c011c6d4>] do_group_exit+0x34/0x70    
	 [<c0103075>] syscall_call+0x7/0xb    
	Code: 75 33 83 42 08 ff 0f 98 c0 84 c0 74 1a 8b 42 08 40 78 18 c7 44 24 04 ff    
	ff ff ff c7 04 24 10 00 00 00 e8 8d 10 ff ff 83 c4 08 c3 <0f> 0b e7 01 c0 2a 33    
	c0 eb de 0f 0b e4 01 c0 2a 33 c0 eb c3 90  

2005-12-16
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175925

Dec 15 02:57:13 garvin kernel: kernel BUG at mm/rmap.c:487!
Dec 15 02:57:13 garvin kernel: invalid operand: 0000 [#1]
Dec 15 02:57:13 garvin kernel: Modules linked in: loop parport_pc lp parport nfs
 lockd nfs_acl autofs4 sunrpc dm_mod ipv6 uhci_hcd i2c_piix4 i2c_core snd_es18xx
 snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss 
snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawm
idi snd_seq_device snd soundcore tlan floppy ext3 jbd aic7xxx scsi_transport_spi
 sd_mod scsi_mod
Dec 15 02:57:13 garvin kernel: CPU:    0
Dec 15 02:57:13 garvin kernel: EIP:    0060:[<c014f97b>]    Not tainted VLI
Dec 15 02:57:13 garvin kernel: EFLAGS: 00010286   (2.6.14-1.1637_FC4) 
Dec 15 02:57:13 garvin kernel: EIP is at page_remove_rmap+0x37/0x41
Dec 15 02:57:13 garvin kernel: eax: ffffffff   ebx: c85d5e30   ecx: 00000006   edx: c115c580
Dec 15 02:57:13 garvin kernel: esi: c115c580   edi: 0038c000   ebp: c03f7a7c   esp: cd7ddec8
Dec 15 02:57:13 garvin kernel: ds: 007b   es: 007b   ss: 0068
Dec 15 02:57:13 garvin kernel: Process udev (pid: 4008, threadinfo=cd7dd000 task=c7059ab0)
Dec 15 02:57:13 garvin kernel: Stack: c0149137 00000000 00391000 c03f7a7c c0a7d000 00391000 00391000 00390fff 
Dec 15 02:57:13 garvin kernel:        c01492ca 00391000 00000000 c03f7a7c 00009000 00391000 c4ce3ddc 00391000 
Dec 15 02:57:13 garvin kernel:        c0149401 00391000 00000000 cd7dd000 cdb671c0 cd7ddf58 002d7000 00000000 
Dec 15 02:57:13 garvin kernel: Call Trace:
Dec 15 02:57:13 garvin kernel:  [<c0149137>] zap_pte_range+0xe5/0x1f5
Dec 15 02:57:13 garvin kernel:  [<c01492ca>] unmap_page_range+0x83/0xb7
Dec 15 02:57:13 garvin kernel:  [<c0149401>] unmap_vmas+0x103/0x222
Dec 15 02:57:13 garvin kernel:  [<c014dc05>] exit_mmap+0x7c/0x14c
Dec 15 02:57:13 garvin kernel:  [<c01189a0>] mmput+0x1f/0x95
Dec 15 02:57:13 garvin kernel:  [<c011d33d>] do_exit+0xe0/0x3b8
Dec 15 02:57:13 garvin kernel:  [<c011d66a>] do_group_exit+0x29/0x90
Dec 15 02:57:13 garvin kernel:  [<c0102edd>] syscall_call+0x7/0xb
Dec 15 02:57:13 garvin kernel: Code: ff 0f 98 c0 84 c0 75 01 c3 8b 42 08 83 c0 0
1 90 78 19 ba ff ff ff ff b8 10 00 00 00 e9 43 0c ff ff 0f 0b e4 01 ad 4a 32 c0 
eb d2 <0f> 0b e7 01 ad 4a 32 c0 eb dd 55 57 56 53 83 ec 04 89 c7 89 d3 

2004-09-11
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=121902
(mention of the BUG in comment #46 on 2.6.8, albeit nvidia tainted).

2004-06-21
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=126454

Two instances, at least one 'went away' with a hardware upgrade.
Could be a coincidence.

2004-07-15
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=127903
Wow, the oldest so far. All the way back to 2.6.6.
But again 'went away' with memory module replacements.

2004-11-28
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=141035
Several flavours. Nothing conclusive. Was mistakenly
believed to be possibly related to the amd errata at the time
and closed.

2005-06-02
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=157557
More of the same. Memory corruption after the first oops perhaps?

2005-07-09
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=159364
Another AMD user. Reports the problem 'went away' with an
update to 2.6.12.3


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUGZJA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUGZJA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 05:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbUGZJA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 05:00:28 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:58861 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265074AbUGZJAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 05:00:24 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-J3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: William Lee Irwin III <wli@holomorphy.com>, Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040726083537.GA24948@elte.hu>
References: <20040713122805.GZ21066@holomorphy.com>
	 <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com>
	 <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe>
	 <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe>
	 <20040726083537.GA24948@elte.hu>
Content-Type: text/plain
Message-Id: <1090832436.6936.105.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Jul 2004 05:00:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-26 at 04:35, Ingo Molnar wrote:
> > Yes, jackd does exactly this, mlockall then opens the ALSA driver with
> > mmap.
> 
> ok, i fixed this in -J3:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-J3
> 
> -J3 also includes a number of softirq latency fixes for the networking
> layer.
> 

OK, I will try this.  I have not seen any latency issues with softirqs
with -I4.  Other than the few remaining hot spots, the only thing that
triggers latencies over 100 usecs during normal operation is the IDE I/O
completion, which can be easily controlled by lowering the max SG size.
 
Here is one that I think happens when deleting a large number of files,
or a directory that had a large number of files.  Specifically, this
happens when bonnie exits.

Jul 25 20:25:36 mindpipe kernel: 16ms non-preemptible critical section violated 1 ms preempt threshold starting at select_parent+0x18/0xd0 and ending at select_parent+0x94/0xd0
Jul 25 20:25:36 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 25 20:25:36 mindpipe kernel:  [dec_preempt_count+270/288] dec_preempt_count+0x10e/0x120
Jul 25 20:25:36 mindpipe kernel:  [select_parent+148/208] select_parent+0x94/0xd0
Jul 25 20:25:36 mindpipe kernel:  [shrink_dcache_parent+22/48] shrink_dcache_parent+0x16/0x30
Jul 25 20:25:36 mindpipe kernel:  [d_unhash+60/176] d_unhash+0x3c/0xb0
Jul 25 20:25:36 mindpipe kernel:  [vfs_rmdir+108/432] vfs_rmdir+0x6c/0x1b0
Jul 25 20:25:36 mindpipe kernel:  [sys_rmdir+207/240] sys_rmdir+0xcf/0xf0
Jul 25 20:25:36 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 25 20:27:45 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 25 20:27:45 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 25 20:27:45 mindpipe kernel:  [__crc_totalram_pages+1165/3197748] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 25 20:27:45 mindpipe kernel:  [__crc_totalram_pages+65879/3197748] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 25 20:27:45 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 25 20:27:45 mindpipe kernel:  [do_IRQ+167/368] do_IRQ+0xa7/0x170
Jul 25 20:27:45 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 25 20:27:45 mindpipe kernel:  [shrink_dcache_parent+22/48] shrink_dcache_parent+0x16/0x30
Jul 25 20:27:45 mindpipe kernel:  [d_unhash+60/176] d_unhash+0x3c/0xb0
Jul 25 20:27:45 mindpipe kernel:  [vfs_rmdir+108/432] vfs_rmdir+0x6c/0x1b0
Jul 25 20:27:45 mindpipe kernel:  [sys_rmdir+207/240] sys_rmdir+0xcf/0xf0
Jul 25 20:27:45 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

I am also seeing a lot of shorter timing violations that involve
unmap_vmas.  Not sure what triggers this one.

Jul 25 21:05:04 mindpipe kernel: 2ms non-preemptible critical section violated 1 ms preempt threshold starting at unmap_vmas+0x1ff/0x210 and ending at unmap_vmas+0x1f5/0x210
Jul 25 21:05:04 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 25 21:05:04 mindpipe kernel:  [dec_preempt_count+270/288] dec_preempt_count+0x10e/0x120
Jul 25 21:05:04 mindpipe kernel:  [unmap_vmas+501/528] unmap_vmas+0x1f5/0x210
Jul 25 21:05:04 mindpipe kernel:  [exit_mmap+94/336] exit_mmap+0x5e/0x150
Jul 25 21:05:04 mindpipe kernel:  [mmput+114/160] mmput+0x72/0xa0
Jul 25 21:05:04 mindpipe kernel:  [do_exit+251/1072] do_exit+0xfb/0x430
Jul 25 21:05:04 mindpipe kernel:  [do_group_exit+50/192] do_group_exit+0x32/0xc0
Jul 25 21:05:04 mindpipe kernel:  [get_signal_to_deliver+605/880] get_signal_to_deliver+0x25d/0x370
Jul 25 21:05:04 mindpipe kernel:  [do_signal+86/208] do_signal+0x56/0xd0
Jul 25 21:05:04 mindpipe kernel:  [do_notify_resume+71/80] do_notify_resume+0x47/0x50
Jul 25 21:05:04 mindpipe kernel:  [work_notifysig+19/21] work_notifysig+0x13/0x15
Jul 25 21:05:04 mindpipe kernel: 2ms non-preemptible critical section violated 1 ms preempt threshold starting at unmap_vmas+0x1ff/0x210 and ending at unmap_vmas+0x1f5/0x210
Jul 25 21:05:04 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 25 21:05:04 mindpipe kernel:  [dec_preempt_count+270/288] dec_preempt_count+0x10e/0x120
Jul 25 21:05:04 mindpipe kernel:  [unmap_vmas+501/528] unmap_vmas+0x1f5/0x210
Jul 25 21:05:04 mindpipe kernel:  [exit_mmap+94/336] exit_mmap+0x5e/0x150
Jul 25 21:05:04 mindpipe kernel:  [mmput+114/160] mmput+0x72/0xa0
Jul 25 21:05:04 mindpipe kernel:  [do_exit+251/1072] do_exit+0xfb/0x430
Jul 25 21:05:04 mindpipe kernel:  [do_group_exit+50/192] do_group_exit+0x32/0xc0
Jul 25 21:05:04 mindpipe kernel:  [get_signal_to_deliver+605/880] get_signal_to_deliver+0x25d/0x370
Jul 25 21:05:04 mindpipe kernel:  [do_signal+86/208] do_signal+0x56/0xd0
Jul 25 21:05:04 mindpipe kernel:  [do_notify_resume+71/80] do_notify_resume+0x47/0x50
Jul 25 21:05:04 mindpipe kernel:  [work_notifysig+19/21] work_notifysig+0x13/0x15
Jul 25 21:05:17 mindpipe kernel: 2ms non-preemptible critical section violated 1 ms preempt threshold starting at unmap_vmas+0x1ff/0x210 and ending at unmap_vmas+0x1f5/0x210
Jul 25 21:05:17 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 25 21:05:17 mindpipe kernel:  [dec_preempt_count+270/288] dec_preempt_count+0x10e/0x120
Jul 25 21:05:17 mindpipe kernel:  [unmap_vmas+501/528] unmap_vmas+0x1f5/0x210
Jul 25 21:05:17 mindpipe kernel:  [exit_mmap+94/336] exit_mmap+0x5e/0x150
Jul 25 21:05:17 mindpipe kernel:  [mmput+114/160] mmput+0x72/0xa0
Jul 25 21:05:17 mindpipe kernel:  [do_exit+251/1072] do_exit+0xfb/0x430
Jul 25 21:05:17 mindpipe kernel:  [do_group_exit+50/192] do_group_exit+0x32/0xc0
Jul 25 21:05:17 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Lee


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUG0Xbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUG0Xbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 19:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUG0Xbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 19:31:50 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43180 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266721AbUG0Xbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 19:31:48 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20040727162759.GA32548@elte.hu>
References: <40F3F0A0.9080100@vision.ee>
	 <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu>  <20040727162759.GA32548@elte.hu>
Content-Type: text/plain
Message-Id: <1090971124.743.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Jul 2004 19:32:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-27 at 12:27, Ingo Molnar wrote:
> i've uploaded -L2:
>  
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-L2
> 

Much better.  With 2:1 Bonnie produced a single XRUN:

ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c01413ef>] filemap_sync_pte_range+0x9f/0xc0
 [<c01414a0>] filemap_sync+0x90/0x110
 [<c014156b>] msync_interval+0x4b/0xe0
 [<c0141724>] sys_msync+0x124/0x136
 [<c0106047>] syscall_call+0x7/0xb

And the mlockall/mmap2 problem is not completely solved.  Starting a
jackd while another is running still produces XRUNs:

ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D0p
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956477>] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c013d89e>] do_no_page+0x4e/0x310
 [<c013dd21>] handle_mm_fault+0xc1/0x170
 [<c013c712>] get_user_pages+0x102/0x370
 [<c013de68>] make_pages_present+0x68/0x90
 [<c013f5d6>] do_mmap_pgoff+0x3e6/0x620
 [<c010be66>] sys_mmap2+0x76/0xb0
 [<c0106047>] syscall_call+0x7/0xb
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D0p
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956477>] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107e5d>] do_IRQ+0xbd/0x1a0
 [<c0106268>] common_interrupt+0x18/0x20
 [<c013de68>] make_pages_present+0x68/0x90
 [<c013e2bd>] mlock_fixup+0x8d/0xb0
 [<c013e5a0>] do_mlockall+0x70/0x90
 [<c013e659>] sys_mlockall+0x99/0xa0
 [<c0106047>] syscall_call+0x7/0xb

Works great otherwise.

Lee


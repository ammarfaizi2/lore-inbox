Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267765AbUHJV7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbUHJV7V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267766AbUHJV7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:59:21 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:22745 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267765AbUHJV7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:59:09 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040810132654.GA28915@elte.hu>
References: <1090795742.719.4.camel@mindpipe>
	 <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe>
	 <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu>  <20040810132654.GA28915@elte.hu>
Content-Type: text/plain
Message-Id: <1092175165.5061.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 17:59:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 09:26, Ingo Molnar wrote:
> i've uploaded the latest version of the voluntary-preempt patch:
>     
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc3-O5
> 
> -O5 fixes the APIC lockup issues. The bug was primarily caused by PCI
> POST delays causing IRQ storms of level-triggered IRQ sources that were
> hardirq-redirected. Also found some bugs in delayed-IRQ masking and
> unmasking. SMP should thus work again too.
> 

Correction, mlockall-test *does* cause xruns.  Here is the trace:

(mlockall-test/12466): 10303us non-preemptible critical section violated 400 us preempt threshold starting at get_user_pages+0xa5/0x3d0 and ending at get_user_pages+0x2e7/0x3d0
 [<c0106777>] dump_stack+0x17/0x20
 [<c01140eb>] sub_preempt_count+0x4b/0x60
 [<c013dbe7>] get_user_pages+0x2e7/0x3d0
 [<c013f198>] make_pages_present+0x68/0x90
 [<c013f5ed>] mlock_fixup+0x8d/0xb0
 [<c013f8d0>] do_mlockall+0x70/0x90
 [<c013f989>] sys_mlockall+0x99/0xa0
 [<c0106117>] syscall_call+0x7/0xb
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c0106777>] dump_stack+0x17/0x20
 [<de92f79b>] snd_pcm_period_elapsed+0x28b/0x3f0 [snd_pcm]
 [<de96c1d1>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c011ac63>] generic_handle_IRQ_event+0x33/0x60
 [<c0107a27>] do_IRQ+0xb7/0x190
 [<c0106338>] common_interrupt+0x18/0x20
 [<c0114008>] __touch_preempt_timing+0x8/0x20
 [<c013dbf4>] get_user_pages+0x2f4/0x3d0
 [<c013f198>] make_pages_present+0x68/0x90
 [<c013f5ed>] mlock_fixup+0x8d/0xb0
 [<c013f8d0>] do_mlockall+0x70/0x90
 [<c013f989>] sys_mlockall+0x99/0xa0
 [<c0106117>] syscall_call+0x7/0xb

Here is a different one:

ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D0p
 [<c0106777>] dump_stack+0x17/0x20
 [<de92f79b>] snd_pcm_period_elapsed+0x28b/0x3f0 [snd_pcm]
 [<de96c437>] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
 [<c011ac63>] generic_handle_IRQ_event+0x33/0x60
 [<c0107a27>] do_IRQ+0xb7/0x190
 [<c0106338>] common_interrupt+0x18/0x20
 [<c0266777>] schedule+0x2d7/0x5b0
 [<c0266fa7>] schedule_timeout+0x57/0xa0
 [<c015fef1>] do_poll+0xa1/0xc0
 [<c0160041>] sys_poll+0x131/0x220
 [<c0106117>] syscall_call+0x7/0xb
(jackd/12430): 17135us non-preemptible critical section violated 400 us preempt threshold starting at schedule+0x57/0x5b0 and ending at schedule+0x2ef/0x5b0
 [<c0106777>] dump_stack+0x17/0x20
 [<c01140eb>] sub_preempt_count+0x4b/0x60
 [<c026678f>] schedule+0x2ef/0x5b0
 [<c0266fa7>] schedule_timeout+0x57/0xa0
 [<c015fef1>] do_poll+0xa1/0xc0
 [<c0160041>] sys_poll+0x131/0x220
 [<c0106117>] syscall_call+0x7/0xb





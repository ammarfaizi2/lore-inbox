Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUG0Wrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUG0Wrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUG0Wrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:47:43 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20649 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266687AbUG0WrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:47:21 -0400
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
Message-Id: <1090968457.743.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Jul 2004 18:47:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-27 at 12:27, Ingo Molnar wrote:

> i've done a softirq lock-break in the atkbd and ps2mouse drivers - this
> should fix the big latencies triggered by NumLock/CapsLock, reported by
> Lee Revell.
> 

L2 does not fix this problem.  Previously, toggling CapsLock would
trigger a single large XRUN.  Now it seems to actually prevent the
soundcard interrupt handler from executing in time, as well as
triggering smaller XRUNs.  This is with preempt=1, voluntary-preempt=3.

ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:211: Unexpected hw_pointer value [1] (stream = 0, delta: -12, max jitter = 32): wrong interrupt acknowledge?
 [<c01066a7>] dump_stack+0x17/0x20
 [<de936497>] snd_pcm_period_elapsed+0x1c7/0x3e0 [snd_pcm]
 [<de956477>] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107c2f>] do_hardirq+0xaf/0x180
 [<c0113cbf>] cond_resched_softirq+0x4f/0x90
 [<c0211245>] atkbd_sendbyte+0x45/0x90
 [<c021144f>] atkbd_command+0x1bf/0x200
 [<c02115fb>] atkbd_event+0x16b/0x200
 [<c020e775>] input_event+0x115/0x3d0
 [<c01e7d9b>] kbd_bh+0xbb/0x160
 [<c011a7d4>] tasklet_action+0x44/0x70
 [<c011a593>] ___do_softirq+0x73/0x80
 [<c011a5e9>] _do_softirq+0x9/0x10
 [<c011a975>] irqd+0x75/0xc0
 [<c01284f4>] kthread+0xa4/0xb0
 [<c0104395>] kernel_thread_helper+0x5/0x10
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c01066a7>] dump_stack+0x17/0x20
 [<de93654b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de956211>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107c2f>] do_hardirq+0xaf/0x180
 [<c0113cbf>] cond_resched_softirq+0x4f/0x90
 [<c0211245>] atkbd_sendbyte+0x45/0x90
 [<c021144f>] atkbd_command+0x1bf/0x200
 [<c02115fb>] atkbd_event+0x16b/0x200
 [<c020e775>] input_event+0x115/0x3d0
 [<c01e7d9b>] kbd_bh+0xbb/0x160
 [<c011a7d4>] tasklet_action+0x44/0x70
 [<c011a593>] ___do_softirq+0x73/0x80
 [<c011a5e9>] _do_softirq+0x9/0x10
 [<c011a975>] irqd+0x75/0xc0
 [<c01284f4>] kthread+0xa4/0xb0
 [<c0104395>] kernel_thread_helper+0x5/0x10
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:211: Unexpected hw_pointer value [1] (stream = 0, delta: -7, max jitter = 32): wrong interrupt acknowledge?
 [<c01066a7>] dump_stack+0x17/0x20
 [<de936497>] snd_pcm_period_elapsed+0x1c7/0x3e0 [snd_pcm]
 [<de956477>] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
 [<c01078c8>] handle_IRQ_event+0x38/0x80
 [<c0107c2f>] do_hardirq+0xaf/0x180
 [<c011a99b>] irqd+0x9b/0xc0
 [<c01284f4>] kthread+0xa4/0xb0
 [<c0104395>] kernel_thread_helper+0x5/0x10

Lee


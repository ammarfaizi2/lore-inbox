Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266527AbUGUD1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUGUD1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 23:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266550AbUGUD1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 23:27:53 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:35767 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266527AbUGUD1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 23:27:50 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040719102954.GA5491@elte.hu>
References: <20040709182638.GA11310@elte.hu>
	 <20040710222510.0593f4a4.akpm@osdl.org>
	 <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
	 <20040712174639.38c7cf48.akpm@osdl.org>  <20040719102954.GA5491@elte.hu>
Content-Type: text/plain
Message-Id: <1090380467.1212.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Jul 2004 23:27:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-19 at 06:29, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > >  Should I try ext3?
> > 
> > ext3 is certainly better than that, but still has a couple of
> > potential problem spots.  ext2 is probably the best at this time.
> 
> with the voluntary-preempt patch applied ext3 is below ~500 usecs for
> all things i tried on a 2GHz CPU. Without the patch i can trigger
> latencies up to milliseconds (even with CONFIG_PREEMPT) by triggering a
> bigger commit stream via some large file write or a cached du / causing
> a stream of atime updates. (I very much suspect that all other
> journalled filesystems have similar problems and they'll need
> measurements and fixing just like ext3 does.)
> 
> another bigger problem area is the VM - see my patch for details. 
> pagetable zapping and page reclaim are both problematic and need fixups
> even under CONFIG_PREEMPT. Doing a simple 'make -j' kernel build that
> hits swap triggers these easily. (after applying my patch the latencies
> go below 1msec even with a 'make -j' overload.)
> 

I discovered I can reliably produce a large XRUN by toggling Caps Lock, 
Scroll Lock, or Num Lock.  This is with 2.6.8-rc1-mm1 + voluntary
preempt (I modified the patch by hand to apply on this kernel, as
2.6.8-rc2 disables my network card).  Here is the XRUN trace.

ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
 [<c01066f7>] dump_stack+0x17/0x20
 [<de952477>] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
 [<de962477>] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
 [<c0107913>] handle_IRQ_event+0x33/0x60
 [<c0107c55>] do_IRQ+0xa5/0x170
 [<c01062b8>] common_interrupt+0x18/0x20
 [<c01d3f7f>] __delay+0xf/0x20
 [<c021881a>] atkbd_sendbyte+0x5a/0xa0
 [<c0218a35>] atkbd_command+0x1d5/0x200
 [<c0218bcb>] atkbd_event+0x16b/0x200
 [<c0215a95>] input_event+0x115/0x3d0
 [<c01ecaeb>] kbd_bh+0xbb/0x160
 [<c011a554>] tasklet_action+0x44/0x70
 [<c011a303>] __do_softirq+0x83/0x90
 [<c011a345>] do_softirq+0x35/0x40
 [<c0107cc5>] do_IRQ+0x115/0x170
 [<c01062b8>] common_interrupt+0x18/0x20
 [<c014b95e>] sys_read+0x2e/0x50
 [<c0106097>] syscall_call+0x7/0xb

Lee


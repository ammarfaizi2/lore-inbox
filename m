Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUGMTpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUGMTpS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 15:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265737AbUGMTpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 15:45:18 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:49640 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263769AbUGMTpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 15:45:06 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary
	Kernel	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Benno Senoner <sbenno@gardena.net>
Cc: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <40F3E31D.9020504@gardena.net>
References: <20040709182638.GA11310@elte.hu>
	 <20040710222510.0593f4a4.akpm@osdl.org>
	 <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>  <40F3E31D.9020504@gardena.net>
Content-Type: text/plain
Message-Id: <1089747918.22026.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 15:45:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 09:26, Benno Senoner wrote:
> Lee Revell wrote:
> 
> >On Mon, 2004-07-12 at 19:31, Andrew Morton wrote:
> >  
> >
> >>
> >>OK, thanks.  The problem areas there are the timer-based route cache
> >>flushing and reiserfs.
> >>
> >>We can probably fix the route caceh thing by rescheduling the timer after
> >>having handled 1000 routes or whatever, although I do wonder if this is a
> >>thing we really need to bother about - what else was that machine up to?
> >>
> >>    
> >>
> >
> >Gnutella client.  Forgot about that.  I agree, it is not reasonable to
> >expect low latency with this kind of network traffic happening.  I am
> >impressed it worked as well as it did.
> >  
> >
> 
> Why not reasonable ? It is very important that networking and HD I/O 
> both don't interfere with low latency audio.
> Think about large audio setups where you use PC hardware to act as 
> dedicated samplers, software synthesizers etc.

Right, I did not think of these.  I just meant that you would not
typically run Gnutella on a DAW.  This should never interfere with audio
latency, as Gnutella is running at normal priority and JACK is running
SCHED_FIFO.

Besides, it looks like there is a real problem with the route cache
flushing.  I ran the same test with no significant network traffic and I
am still seeing spikes in latency.  There are all of 5 entries in the
route cache.

Kernel IP routing cache
Source          Destination     Gateway         Flags Metric Ref    Use Iface
vmail-mx.dca.ne 192.168.2.102   192.168.2.102   l     0      1      838 lo
192.168.2.102   vmail-mx.dca.ne .                     0      0        4 eth0
vmail-mx.dca.ne 192.168.2.102   192.168.2.102   l     0      1      838 lo
192.168.2.102   .               .                     0      0        2 eth0
192.168.2.102   vmail-mx.dca.ne .                     0      0        4 eth0

Jul 13 15:15:49 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 15:15:49 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 13 15:15:49 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 15:15:49 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 15:15:49 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 15:15:49 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 15:15:49 mindpipe kernel:  [rt_run_flush+77/144] rt_run_flush+0x4d/0x90
Jul 13 15:15:49 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 13 15:15:49 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 13 15:15:49 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 13 15:15:49 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 13 15:15:49 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 13 15:15:49 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 13 15:15:49 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 15:15:49 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 13 15:15:49 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 13 15:15:49 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 13 15:15:49 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0
Jul 13 15:15:49 mindpipe kernel:
Jul 13 15:25:49 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 13 15:25:49 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
Jul 13 15:25:49 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
Jul 13 15:25:49 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
Jul 13 15:25:49 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
Jul 13 15:25:49 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 15:25:49 mindpipe kernel:  [local_bh_enable+17/112] local_bh_enable+0x11/0x70
Jul 13 15:25:49 mindpipe kernel:  [rt_run_flush+92/144] rt_run_flush+0x5c/0x90
Jul 13 15:25:49 mindpipe kernel:  [rt_secret_rebuild+0/48] rt_secret_rebuild+0x0/0x30
Jul 13 15:25:49 mindpipe kernel:  [rt_secret_rebuild+14/48] rt_secret_rebuild+0xe/0x30
Jul 13 15:25:49 mindpipe kernel:  [run_timer_softirq+201/416] run_timer_softirq+0xc9/0x1a0
Jul 13 15:25:49 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 13 15:25:49 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 13 15:25:49 mindpipe kernel:  [do_IRQ+261/352] do_IRQ+0x105/0x160
Jul 13 15:25:49 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 13 15:25:49 mindpipe kernel:  [default_idle+35/64] default_idle+0x23/0x40
Jul 13 15:25:49 mindpipe kernel:  [apm_cpu_idle+165/384] apm_cpu_idle+0xa5/0x180
Jul 13 15:25:49 mindpipe kernel:  [cpu_idle+45/64] cpu_idle+0x2d/0x40
Jul 13 15:25:49 mindpipe kernel:  [start_kernel+392/464] start_kernel+0x188/0x1d0
Jul 13 15:25:49 mindpipe kernel:



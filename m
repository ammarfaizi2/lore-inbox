Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUGWXuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUGWXuV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 19:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUGWXuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 19:50:21 -0400
Received: from pD9517AB1.dip.t-dialin.net ([217.81.122.177]:20097 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S264585AbUGWXuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 19:50:08 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-I3
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040723120014.GA5573@elte.hu>
References: <20040722161941.GA23972@elte.hu>
	 <20040722172428.GA5632@ss1000.ms.mff.cuni.cz>
	 <20040722175457.GA5855@ss1000.ms.mff.cuni.cz>
	 <20040722180142.GC30059@elte.hu> <20040722180821.GA377@elte.hu>
	 <20040722181426.GA892@elte.hu> <20040723104246.GA2752@elte.hu>
	 <4d8e3fd30407230358141e0e58@mail.gmail.com> <20040723110430.GA3787@elte.hu>
	 <4d8e3fd30407230442afe80c1@mail.gmail.com>  <20040723120014.GA5573@elte.hu>
Content-Type: text/plain
Message-Id: <1090626523.4851.32.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Jul 2004 01:48:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> All known performance problems have been fixed in -I4. The focus is
> mainly on latency. You can best support this patch by trying it out and
> doing measurements - both latency and throughput measurements are
> welcome. Latency measurement can be done via the latencytest tool:
> 
>   http://www.alsa-project.org/~iwai/latencytest-0.5.4.tar.gz
> 
> If you enable both CONFIG_PREEMPT_VOLUNTARY and CONFIG_PREEMPT then you
> can use the /proc/sys/kernel/voluntary_preemption|kernel_preemption
> sysctl knobs to turn the preemption features on/off. The following flag
> combinations can be used to do comparisons:
> 
>  vanilla:                                             vp:0 kp:0
>  CONFIG_PREEMPT:                                      vp:0 kp:1
>  voluntary-preempt:                                   vp:1 kp:0
>  voluntary-preempt + CONFIG_PREEMPT:                  vp:1 kp:1
>  voluntary-preempt + softirq defer:                   vp:2 kp:0 [default]
>  voluntary-preempt + softirq defer + CONFIG_PREEMPT:  vp:2 kp:1
> 
> each of the above combinations should work and should pretty exactly
> represent that particular kernel (i.e. you can get vanilla
> non-preemptible 2.6.8-rc2 kernel behavior by switching both flags on) -
> but i typically use the default one for testing. 
> 
> 	Ingo

Hi,

I'm experiencing hard freezes in the early stage of the latency test
suite (X11 test, latencytest-0.5.4) with 2.6.8-rc2-I4, both with the
default vp:2 kp:0 and with vp:0 kp:0 (nvidia card, xfree drivers). I was
also experiencing hard freezes before with 2.6.7-mm7-H4 while doing
intensive disk I/O on reiserfs (e.g. tar big_file.tar.gz)

As for the tests, I have 2 remaining problems, one with mmap in
conjunction with mlockall(MCL_CURRENT|MCL_FUTURE) :

XRUN: pcmC2D0c
 [<c0105f6e>] dump_stack+0x1e/0x30
 [<c03673b1>] snd_pcm_period_elapsed+0x2e1/0x420
 [<c039d3d4>] snd_hdsp_interrupt+0x174/0x180
 [<c01073bb>] handle_IRQ_event+0x3b/0x70
 [<c0107746>] do_IRQ+0x96/0x150
 [<c0105b14>] common_interrupt+0x18/0x20
 [<c014890f>] do_no_page+0x5f/0x300
 [<c0148da2>] handle_mm_fault+0xe2/0x190
 [<c01477a0>] get_user_pages+0x130/0x370
 [<c0148f17>] make_pages_present+0x87/0xb0
 [<c014a916>] do_mmap_pgoff+0x476/0x6d0
 [<c010ba50>] sys_mmap2+0xa0/0xe0
 [<c0105155>] sysenter_past_esp+0x52/0x71
XRUN: pcmC2D0p
 [<c0105f6e>] dump_stack+0x1e/0x30
 [<c03673b1>] snd_pcm_period_elapsed+0x2e1/0x420
 [<c039d3b4>] snd_hdsp_interrupt+0x154/0x180
 [<c01073bb>] handle_IRQ_event+0x3b/0x70
 [<c0107746>] do_IRQ+0x96/0x150
 [<c0105b14>] common_interrupt+0x18/0x20
 [<c014890f>] do_no_page+0x5f/0x300
 [<c0148da2>] handle_mm_fault+0xe2/0x190
 [<c01477a0>] get_user_pages+0x130/0x370
 [<c0148f17>] make_pages_present+0x87/0xb0
 [<c014a916>] do_mmap_pgoff+0x476/0x6d0
 [<c010ba50>] sys_mmap2+0xa0/0xe0
 [<c0105155>] sysenter_past_esp+0x52/0x71

and the other one when accessing the keyboard at a sensible moment. Such
a moment occurs rather precisely every 8.079 seconds on my system (+/-
2ms). I could verify this by keeping a key pressed (xrun every 8.079
second), or just using the keyboard normally (xruns happen more or less
randomly but the time interval to the previous one is always a multiple
of this 8.079 period) :

XRUN: pcmC2D0c
 [<c0105f6e>] dump_stack+0x1e/0x30
 [<c03673b1>] snd_pcm_period_elapsed+0x2e1/0x420
 [<c039d3d4>] snd_hdsp_interrupt+0x174/0x180
 [<c01073bb>] handle_IRQ_event+0x3b/0x70
 [<c0107746>] do_IRQ+0x96/0x150
 [<c0105b14>] common_interrupt+0x18/0x20
 [<c0107746>] do_IRQ+0x96/0x150
 [<c0105b14>] common_interrupt+0x18/0x20
 [<c01030f4>] cpu_idle+0x34/0x40
 [<c054880d>] start_kernel+0x16d/0x190
 [<c010019f>] 0xc010019f

Can you think of a possible explanation for this one ?

Thomas



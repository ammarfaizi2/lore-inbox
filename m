Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267395AbUG2BIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267395AbUG2BIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 21:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUG2BIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 21:08:09 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:19658 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267395AbUG2BH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 21:07:56 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <1091051452.791.52.camel@mindpipe>
References: <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040727162759.GA32548@elte.hu>
	 <1090968457.743.3.camel@mindpipe>  <20040728050535.GA14742@elte.hu>
	 <1091051452.791.52.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1091063295.18598.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 21:08:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 17:50, Lee Revell wrote:
> On Wed, 2004-07-28 at 01:05, Ingo Molnar wrote:
> > * Lee Revell <rlrevell@joe-job.com> wrote:
> > if your soundcard doesnt share the irq line with any other 'heavy' 
> > interrupt then you can make the irq 'direct' via a simple change to 
> > arch/i386/kernel/irq.c, change this line from:
> > 
> >  #define redirectable_irq(irq) ((irq) != 0)
> > 
> > to:
> > 
> >  #define redirectable_irq(irq) (((irq) != 0) && ((irq) != 10))
> > 
> > (if the soundcard is on IRQ 10).
> > 
> > does such a change combined with v=3 fix the latencies you are seeing?
> 
> With L2, 1:3, max_sectors_kb=256, and the above change, the performance
> is truly amazing.  Over 20 million interrupts, on a 600Mhz machine, the
> worst latency I was able to trigger was 46 usecs.  There does not seem
> to be any adverse affect on any aspect of the system.
> 

Here are some more results.  I am up to 56 million interrupts and I have
yet to trigger a latency higher than 46 usecs.  It looks like this is a
hard upper limit.

I did get a couple XRUNs, some of which I have never seen before.  One
seemed to be caused by apt-get update/upgrade or exiting dselect.

The 'rtc: lost some interrupts' message is also new.  I believe mplayer
is using the RTC for timing.

Jul 28 20:23:17 mindpipe kernel: rtc: lost some interrupts at 1024Hz.
Jul 28 20:23:40 mindpipe kernel: rtc: lost some interrupts at 1024Hz.
Jul 28 20:23:54 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
Jul 28 20:23:54 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 28 20:23:54 mindpipe kernel:  [__crc_totalram_pages+29841/2369476] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
Jul 28 20:23:54 mindpipe kernel:  [__crc_totalram_pages+274775/2369476] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 28 20:23:54 mindpipe kernel:  [handle_IRQ_event+71/144] handle_IRQ_event+0x47/0x90
Jul 28 20:23:54 mindpipe kernel:  [do_IRQ+227/432] do_IRQ+0xe3/0x1b0
Jul 28 20:23:54 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 28 20:23:54 mindpipe kernel:  [set_page_dirty+70/96] set_page_dirty+0x46/0x60
Jul 28 20:23:54 mindpipe kernel:  [filemap_sync_pte+92/112] filemap_sync_pte+0x5c/0x70
Jul 28 20:23:54 mindpipe kernel:  [filemap_sync_pte_range+159/192] filemap_sync_pte_range+0x9f/0xc0
Jul 28 20:23:54 mindpipe kernel:  [filemap_sync+144/272] filemap_sync+0x90/0x110
Jul 28 20:23:54 mindpipe kernel:  [msync_interval+75/224] msync_interval+0x4b/0xe0
Jul 28 20:23:54 mindpipe kernel:  [sys_msync+292/310] sys_msync+0x124/0x136
Jul 28 20:23:54 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 28 20:30:24 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
Jul 28 20:30:24 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 28 20:30:24 mindpipe kernel:  [__crc_totalram_pages+29841/2369476] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
Jul 28 20:30:24 mindpipe kernel:  [__crc_totalram_pages+274775/2369476] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 28 20:30:24 mindpipe kernel:  [handle_IRQ_event+71/144] handle_IRQ_event+0x47/0x90
Jul 28 20:30:24 mindpipe kernel:  [do_IRQ+227/432] do_IRQ+0xe3/0x1b0
Jul 28 20:30:24 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 28 20:30:26 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
Jul 28 20:30:26 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 28 20:30:26 mindpipe kernel:  [__crc_totalram_pages+29841/2369476] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
Jul 28 20:30:26 mindpipe kernel:  [__crc_totalram_pages+274775/2369476] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 28 20:30:26 mindpipe kernel:  [handle_IRQ_event+71/144] handle_IRQ_event+0x47/0x90
Jul 28 20:30:26 mindpipe kernel:  [do_IRQ+227/432] do_IRQ+0xe3/0x1b0
Jul 28 20:30:26 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 28 20:30:26 mindpipe kernel:  [do_anonymous_page+124/384] do_anonymous_page+0x7c/0x180
Jul 28 20:30:26 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
Jul 28 20:30:26 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
Jul 28 20:30:26 mindpipe kernel:  [get_user_pages+258/880] get_user_pages+0x102/0x370
Jul 28 20:30:26 mindpipe kernel:  [make_pages_present+104/144] make_pages_present+0x68/0x90
Jul 28 20:30:26 mindpipe kernel:  [do_mmap_pgoff+998/1568] do_mmap_pgoff+0x3e6/0x620
Jul 28 20:30:26 mindpipe kernel:  [sys_mmap2+118/176] sys_mmap2+0x76/0xb0
Jul 28 20:30:26 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 28 20:32:18 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
Jul 28 20:32:18 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 28 20:32:18 mindpipe kernel:  [__crc_totalram_pages+29841/2369476] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
Jul 28 20:32:18 mindpipe kernel:  [__crc_totalram_pages+274775/2369476] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 28 20:32:18 mindpipe kernel:  [handle_IRQ_event+71/144] handle_IRQ_event+0x47/0x90
Jul 28 20:32:18 mindpipe kernel:  [do_IRQ+227/432] do_IRQ+0xe3/0x1b0
Jul 28 20:32:18 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 28 20:32:18 mindpipe kernel:  [set_page_dirty+70/96] set_page_dirty+0x46/0x60
Jul 28 20:32:18 mindpipe kernel:  [filemap_sync_pte+92/112] filemap_sync_pte+0x5c/0x70
Jul 28 20:32:18 mindpipe kernel:  [filemap_sync_pte_range+159/192] filemap_sync_pte_range+0x9f/0xc0
Jul 28 20:32:18 mindpipe kernel:  [filemap_sync+144/272] filemap_sync+0x90/0x110
Jul 28 20:32:18 mindpipe kernel:  [msync_interval+75/224] msync_interval+0x4b/0xe0
Jul 28 20:32:18 mindpipe kernel:  [sys_msync+292/310] sys_msync+0x124/0x136
Jul 28 20:32:18 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Lee


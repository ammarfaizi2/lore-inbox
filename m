Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268788AbUHLWRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268788AbUHLWRq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268826AbUHLWRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:17:46 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47571 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268831AbUHLWQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:16:17 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040811073149.GA4312@elte.hu>
References: <1090830574.6936.96.camel@mindpipe>
	 <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe>
	 <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	 <1092174959.5061.6.camel@mindpipe>  <20040811073149.GA4312@elte.hu>
Content-Type: text/plain
Message-Id: <1092349009.1304.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 18:16:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-11 at 03:31, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > (jackd/12427): 10882us non-preemptible critical section violated 400
> > us preempt threshold starting at kernel_fpu_begin+0x10/0x60 and ending
> > at fast_clear_page+0x75/0xa0
> 
> to make sure this is a real latency and not some rdtsc weirdness, could
> you try the latest version of preempt-timing:
> 
>  http://redhat.com/~mingo/voluntary-preempt/preempt-timing-on-2.6.8-rc3-O5-A2
> 
> this adds jiffies-based latency values to the printout, e.g.:
> 
>   (ksoftirqd/0/2): 3860us [3 jiffy] non-preemptible critical section
>   violated 100 us preempt threshold starting at ___do_softirq+0x1b/0x90
>   and ending at cond_resched_softirq+0x57/0x70
> 
> shows that a 10 jiffy (10 msec) latency happened - which matches the
> rdtsc-based 3860 usecs value.
> 

Here is the preempt-timing violation and accompanying xrun I got when
starting jackd.  It looks like the jiffies value matches the rdtsc:

ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139:
XRUN: pcmC0D2c
 [<c0106497>] dump_stack+0x17/0x20
 [<de92714b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de963171>] snd_emu10k1_interrupt+0xd1/0x380 [snd_emu10k1]
 [<c011a693>] generic_handle_IRQ_event+0x33/0x60
 [<c010765e>] do_IRQ+0xbe/0x180
 [<c0106078>] common_interrupt+0x18/0x20
 [<c013d28e>] do_no_page+0x4e/0x300
 [<c013d6e1>] handle_mm_fault+0xb1/0x150
 [<c013c118>] get_user_pages+0x138/0x3e0
 [<c013d828>] make_pages_present+0x68/0x90
 [<c013ef5f>] do_mmap_pgoff+0x40f/0x670
 [<c010b245>] sys_mmap2+0x75/0xb0
 [<c0105e57>] syscall_call+0x7/0xb
(jackd/1359): 9174us [10 jiffy] non-preemptible critical section
violated 400 us preempt threshold starting at do_IRQ+0x19/0x180 and
ending at do_IRQ+0x121/0x180 [<c0106497>] dump_stack+0x17/0x20
 [<c0113e5b>] sub_preempt_count+0x4b/0x60
 [<c01076c1>] do_IRQ+0x121/0x180
 [<c0106078>] common_interrupt+0x18/0x20
 [<c013d28e>] do_no_page+0x4e/0x300
 [<c013d6e1>] handle_mm_fault+0xb1/0x150
 [<c013c118>] get_user_pages+0x138/0x3e0
 [<c013d828>] make_pages_present+0x68/0x90
 [<c013ef5f>] do_mmap_pgoff+0x40f/0x670
 [<c010b245>] sys_mmap2+0x75/0xb0
 [<c0105e57>] syscall_call+0x7/0xb

Lee


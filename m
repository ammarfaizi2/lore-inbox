Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269292AbUIHSmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269292AbUIHSmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269289AbUIHSmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:42:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:62605 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269300AbUIHSlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:41:11 -0400
Date: Wed, 8 Sep 2004 20:42:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Message-ID: <20040908184231.GA8318@elte.hu>
References: <OFD3DB738F.105F62D0-ON86256F08.005CDE25-86256F08.005CDE44@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD3DB738F.105F62D0-ON86256F08.005CDE25-86256F08.005CDE44@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> If you look at the date / time of the traces, you will notice that
> most occur in the latter part of the test. This is during the "disk
> copy" and "disk read" parts of the testing. [...]

would it be possible to test with DMA disabled? (hdparm -d0 /dev/hda) It
might take some extra work to shun the extra latency reports from the
PIO IDE path (which is quite slow) but once that is done you should be
able to see whether these long 0.5 msec delays remain even if all (most)
DMA activity has been eliminated.

> preemption latency trace v1.0.5 on 2.6.9-rc1-VP-R1
> --------------------------------------------------
>  latency: 550 us, entries: 6 (6)
>     -----------------
>     | task: cat/6771, uid:0 nice:0 policy:0 rt_prio:0
>     -----------------
>  => started at: kmap_atomic+0x23/0xe0
>  => ended at:   kunmap_atomic+0x7b/0xa0
> =======>
> 00000001 0.000ms (+0.000ms): kmap_atomic (file_read_actor)
> 00000001 0.000ms (+0.000ms): page_address (file_read_actor)
> 00000001 0.000ms (+0.549ms): __copy_to_user_ll (file_read_actor)
> 00000001 0.550ms (+0.000ms): kunmap_atomic (file_read_actor)
> 00000001 0.550ms (+0.000ms): sub_preempt_count (kunmap_atomic)
> 00000001 0.550ms (+0.000ms): update_max_trace (check_preempt_timing)

this is a full page copy, from userspace into a kernelspace pagecache
page. This shouldnt take 500 usecs on any hardware. Since this is a
single instruction (memcpy's rep; movsl instruction) there's nothing
that Linux can do to avoid (or even to cause) such a situation.

> 00010002 0.141ms (+0.000ms): mark_offset_tsc (timer_interrupt) [0]
> 00010002 0.141ms (+0.000ms): mark_offset_tsc (timer_interrupt) [1]
> 00010002 0.141ms (+0.000ms): spin_lock (mark_offset_tsc)
> 00010003 0.141ms (+0.000ms): spin_lock (<00000000>)
> 00010003 0.141ms (+0.131ms): mark_offset_tsc (timer_interrupt) [2]
> 00010003 0.273ms (+0.000ms): mark_offset_tsc (timer_interrupt) [3]

note that there's no spinning on the spinlock, the (<00000000>) shows 
that there was no contention at all.

> For reference, the steps in the code read (w/o comments):
> 
>         mcount(); [1]
>         write_seqlock(&monotonic_lock);
>         mcount(); [2]
>         last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
>         rdtsc(last_tsc_low, last_tsc_high);
>         mcount(); [3]

the 131 usec delay occured between [2] and [3] - which, if you check the 
assembly, there are only 14 instructions between those two mcount() 
calls:

 1a0:   31 db                   xor    %ebx,%ebx
 1a2:   8b 0d 10 00 00 00       mov    0x10,%ecx
                        1a4: R_386_32   .bss
 1a8:   a1 14 00 00 00          mov    0x14,%eax
                        1a9: R_386_32   .bss
 1ad:   89 c2                   mov    %eax,%edx
 1af:   31 c0                   xor    %eax,%eax
 1b1:   89 c7                   mov    %eax,%edi
 1b3:   09 cf                   or     %ecx,%edi
 1b5:   89 7d e0                mov    %edi,0xffffffe0(%ebp)
 1b8:   89 d7                   mov    %edx,%edi
 1ba:   09 df                   or     %ebx,%edi
 1bc:   89 7d e4                mov    %edi,0xffffffe4(%ebp)
 1bf:   0f 31                   rdtsc
 1c1:   89 15 14 00 00 00       mov    %edx,0x14
                        1c3: R_386_32   .bss
 1c7:   a3 10 00 00 00          mov    %eax,0x10
                        1c8: R_386_32   .bss

no loop, no nothing. No way can this take 131 usecs without hardware 
effects.

> Clear Page Tables
> =================
> 
> This is the longest single latency with the following traces:
> 
> # grep '(+0.6' lt040907/lt*/lt.*
> lt040907/lt001.v3k1/lt.28:00000001 0.001ms (+0.635ms): clear_page_tables
> (exit_mmap)
> lt040907/lt002.v3k1/lt.75:00000001 0.001ms (+0.628ms): clear_page_tables
> (exit_mmap)

this one might be a real latency - but it's hard to tell if there are 
random 500 usec latencies all around the place.

> __modify_IO_APIC_irq
> ====================

> 00000003 0.001ms (+0.000ms): __unmask_IO_APIC_irq (unmask_IO_APIC_irq)
> 00000003 0.002ms (+0.567ms): __modify_IO_APIC_irq (__unmask_IO_APIC_irq)
> 00010001 0.569ms (+0.000ms): do_nmi (smp_apic_timer_interrupt)

this too seems to be one of these random 500 usec latencies that have no 
connection whatsoever to what is being done. It's just some unfortunate 
piece of code that is more likely to access the memory bus or happens to 
be on a page boundary or something like that.

> Spin Lock
> =========
> 
> We seem to have gotten stuck here in a spin lock...

none of the spinlocks had a counter different from zero so there was no
contention. The extra trace entry after a spinlock:

> 00000002 0.000ms (+0.000ms): spin_lock (<00000000>)

shows the number of times the spinlock had to spin internally before it
got the lock. For real contention this should be some large nonzero
number.

> 00000002 0.008ms (+0.000ms): snd_ensoniq_trigger (snd_pcm_do_stop)
> 00000002 0.009ms (+0.000ms): spin_lock (snd_ensoniq_trigger)
> 00000003 0.009ms (+0.549ms): spin_lock (<00000000>)

this too seems to be caused by that 'magic' latency - a noncontended
spinlock cannot take 500 usecs to execute ...

> Context Switch
> ==============

same for the context-switch codepath. I'm very convinced that the 'magic
latencies' are distributed more or less randomly across kernel code. 
Code that accesses the main memory bus more likely will be affected more
by DMA starvation, that's what makes some of these functions more
prominent than others.

> 00000002 0.005ms (+0.000ms): dummy_cs_switch_mm (context_switch)
> 00000002 0.005ms (+0.111ms): context_switch (schedule)

since this includes a cr3 flush it is very likely accessing main memory. 
(it's possibly re-fetching lots of TLB entries from a new pagetable
which is likely cache-cold.)

so my main candidate is still IDE DMA. Please disable IDE DMA and see
what happens (after hiding the PIO IDE codepath via
touch_preempt_timing()).

	Ingo

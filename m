Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbVJNVgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVJNVgH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 17:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbVJNVgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 17:36:07 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:57013 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1750934AbVJNVgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 17:36:06 -0400
Date: Fri, 14 Oct 2005 23:32:18 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
Subject: Re: 1.6ms jitter in rtc_wakeup (Re: 2.6.14-rc4-rt1)
In-Reply-To: <20051014034513.GA6513@elte.hu>
Message-Id: <Pine.OSF.4.05.10510142325150.24215-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > I set up rtc_wakeup and got a jitter up 1.6ms!
> > It came when I cd'en into a nfs-mount and typed ls.
> 
> >       ls-11239 0Dn..    4us : profile_hit (__schedule)
> >       ls-11239 0Dn.1    4us : sched_clock (__schedule)
> >       ls-11239 0Dn.1    5us : check_tsc_unstable (sched_clock)
> >       ls-11239 0Dn.1    5us : tsc_read_c3_time (sched_clock)
> >    IRQ 8-775   0D..2    6us : __switch_to (__schedule)
> >    IRQ 8-775   0D..2    7us!: __schedule <ls-11239> (75 0)
> >    IRQ 8-775   0...1 1594us : trace_stop_sched_switched (__schedule)
> >    IRQ 8-775   0D..2 1594us : trace_stop_sched_switched <IRQ 8-775> (0 0)
> >    IRQ 8-775   0D..2 1595us : trace_stop_sched_switched (__schedule)
> 
> ouch! This very much looks like a hardware induced latency, because the 
> codepath from those two __schedule points is extremely short and there 
> is no loop there. Have you tested this particular box before too? If 
> not, can you reproduce this latency with older versions of -rt too on 
> the same box, or is this completely new? 
I have been testing on this box before but never with such long latencies
before.
> Occasionally there are boxes 
> that show clear signs of hardware latencies - there's little the kernel 
> can do about those.
I actually felt like the box went to sleep.

> 
> Wild shot in the dark: are there any power-saving modes enabled on the 
> box? 

I have had problems with power-saving before on this box. The  effect is
usually the other way around: The rtdcs used to meassure the timing slows
down. I.e. it ought to meassure very short times, not very long times.

I'll try to disable power-management.

> Another shot in the dark: can you trigger these latencies if the 
> networking card is ifconfig down-ed? I.e. perhaps it's related to DMA 
> done by the networking device. Playing with BIOS settings / DMA/PCI 
> priorities might help reduce DMA related latencies ...

Hmm. If it is a DMA transfer for the network device it ought to make bad
latencies for any network traffic not only NFS. I will have to test
various things during the weekend.

Esben

> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUJVSy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUJVSy2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267376AbUJVSw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:52:27 -0400
Received: from mail4.utc.com ([192.249.46.193]:37585 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S266511AbUJVSuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:50:25 -0400
Message-ID: <41795653.6020802@cybsft.com>
Date: Fri, 22 Oct 2004 13:49:55 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark_H_Johnson@raytheon.com
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9.3
References: <OF7FC21EAE.3A2E362A-ON86256F35.0066D568-86256F35.0066D58B@raytheon.com>
In-Reply-To: <OF7FC21EAE.3A2E362A-ON86256F35.0066D568-86256F35.0066D58B@raytheon.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark_H_Johnson@raytheon.com wrote:
>>i have released the -U9.3 Real-Time Preemption patch, ...
>>
> 
> It is getting hard to keep up with the updates....
> 
> This version built OK and since I noticed it includes fixes for the
> parallel port, I added that back to my configuration and built / booted
> without any problems. I still see the BUG from:
> 
> Oct 22 12:27:50 dws77 kernel: 8139too Fast Ethernet driver 0.9.27
> Oct 22 12:27:50 dws77 kernel: eth0: RealTek RTL8139 at 0xdc00,
> 00:50:bf:39:11:fc, IRQ 11
> Oct 22 12:27:50 dws77 kernel: BUG: atomic counter underflow at:
> Oct 22 12:27:50 dws77 kernel:  [<c02b8f88>] qdisc_destroy+0x98/0xa0 (12)
> 
> I saw the messages about fixes for the other network drivers, but
> don't forget this one.

I still get this also. This is not fixed by the network driver fix, but 
I don't think it was expected to be.

> 
> Real time stress tests ran more smoothly this time with fewer
> odd symptoms but a few new symptoms showed up too. I'll send the
> boot log and traces separately. The following summarizes the tests
> and results.
> 
> [1] X11 stress - very clean, max CPU delay was only 20 usec.
> 
> [2] proc stress - very clean, max CPU delay was only 30 usec.
> 
> [3] network output stress - only trace much worse than U9.2. An odd
> pattern in the graph showing a delay of roughly 400 usec every 5
> seconds with a much smaller delay following. There were also a couple
> bursts of delays at 90-100 seconds, and 250-260 seconds. Did not
> see this pattern on any other test.
> 
> [4] network input stress - very clean, max CPU delay was only 80 usec.
> 
> [5] disk write stress - very clean, max CPU delay only 70 usec.
> 
> [6] disk copy stress - very clean, max CPU delay only 90 usec.
> 
> [7] disk read stress - first 25 seconds, had a pattern of roughly 100 usec
> CPU delays with a few peaks at 500 usec. After that, was very clean, almost
> 99.7% of the CPU delays were under 100 usec.
> 
> During these tests (total 25-30 minutes) had seven latency traces
> over >200 usec. Summary follows:
> 
> 00 - find_symbol, a single trace line over 400 usec as follows
> preemption latency trace v1.0.7 on 2.6.9-rc4-mm1-RT-U9.3
> -------------------------------------------------------
>  latency: 495 us, entries: 9 (9)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
>     -----------------
>     | task: modprobe/3643, uid:0 nice:-10 policy:0 rt_prio:0
>     -----------------
>  => started at: _spin_lock_irqsave+0x1f/0x80 <c0314f4f>
>  => ended at:   _spin_unlock_irq+0x1b/0x40 <c031538b>
> =======>
> 00000001 0.000ms (+0.000ms): _spin_lock_irqsave (resolve_symbol)
> 00000001 0.000ms (+0.447ms): __find_symbol (resolve_symbol)
> 00010001 0.448ms (+0.000ms): do_nmi (__find_symbol)
> 00010001 0.448ms (+0.000ms): do_nmi (add_preempt_count)
> 00010001 0.449ms (+0.042ms): do_nmi (<00200093>)
> 00000001 0.491ms (+0.000ms): use_module (resolve_symbol)
> 00000001 0.492ms (+0.001ms): already_uses (use_module)
> 00000001 0.493ms (+0.000ms): kmem_cache_alloc (use_module)
> 00000001 0.494ms (+0.000ms): _spin_unlock_irq (resolve_symbol)
> 
> 01, 02, 03, 05, 06 - flush_tlb
>  latency: 1815 us, entries: 108 (108)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
>  latency: 8959 us, entries: 180 (180)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
>  latency: 175300 us, entries: 4000 (8116)   |   [VP:1 KP:1 SP:1 HP:1
> #CPUS:2]
>  latency: 80679 us, entries: 1545 (1545)   |   [VP:1 KP:1 SP:1 HP:1
> #CPUS:2]
>  latency: 76801 us, entries: 3561 (3561)   |   [VP:1 KP:1 SP:1 HP:1
> #CPUS:2]
> 
> This is that symptom I reported before where something gets "stuck"
> and one or more clock ticks later, it finally gets freed up. Note that
> the real time application did not see any of these delays. It may
> be interesting to do another test w/ two real time tasks to see if
> these are real or a sampling artifact.
> 
> 04 - avc_insert, a single > 200 usec trace entry.
> 
> preemption latency trace v1.0.7 on 2.6.9-rc4-mm1-RT-U9.3
> -------------------------------------------------------
>  latency: 216 us, entries: 4 (4)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
>     -----------------
>     | task: fam/2933, uid:0 nice:0 policy:0 rt_prio:0
>     -----------------
>  => started at: _spin_lock_irqsave+0x1f/0x80 <c0314f4f>
>  => ended at:   _spin_unlock_irqrestore+0x20/0x50 <c0315340>
> =======>
> 00000001 0.000ms (+0.000ms): _spin_lock_irqsave (avc_has_perm_noaudit)
> 00000001 0.000ms (+0.214ms): avc_insert (avc_has_perm_noaudit)
> 00000001 0.214ms (+0.000ms): memcpy (avc_has_perm_noaudit)
> 00000001 0.215ms (+0.000ms): _spin_unlock_irqrestore (avc_has_perm_noaudit)
> 
>   --Mark
> 
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUGZMnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUGZMnQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 08:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUGZMnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 08:43:16 -0400
Received: from mx2.elte.hu ([157.181.151.9]:30346 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265250AbUGZMnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 08:43:13 -0400
Date: Mon, 26 Jul 2004 14:40:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-J3
Message-ID: <20040726124059.GA14005@elte.hu>
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090832436.6936.105.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> > > Yes, jackd does exactly this, mlockall then opens the ALSA driver with
> > > mmap.
> > 
> > ok, i fixed this in -J3:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-J3
> > 
> > -J3 also includes a number of softirq latency fixes for the networking
> > layer.
> 
> OK, I will try this.  I have not seen any latency issues with softirqs
> with -I4. [...]

i'm going through the subsystems systematically and i'm stressing them
beyond normal use. These networking latencies need a high number of in
flight packets, multiple TCP sockets, and a 100 mbit link or faster. 
(this is a more common workload on a corporate desktop, but not typical
on a home desktop.)

> [...]  Other than the few remaining hot spots, the only thing that
> triggers latencies over 100 usecs during normal operation is the IDE
> I/O completion, which can be easily controlled by lowering the max SG
> size.

ok, i'll take a look whether there's a way to control this without
having to artificially impact the IO patterns.

> Here is one that I think happens when deleting a large number of
> files, or a directory that had a large number of files.  Specifically,
> this happens when bonnie exits.
> 
> Jul 25 20:25:36 mindpipe kernel:
>
> [...] 16ms non-preemptible critical section violated 1 ms preempt 
> threshold starting at select_parent+0x18/0xd0 and ending at
> select_parent+0x94/0xd0

ok, this should be the dcache/icache zapping. I've done some latency
reduction in this area but apparently not enough.

> I am also seeing a lot of shorter timing violations that involve
> unmap_vmas.  Not sure what triggers this one.

it might just be a common operation, being hit by the IDE hardirq
latency. (which thus is added to the 'scheduling' latency.) Although
none of the traces show IDE hardirq leftovers [but they might be cleared
from the stack by the time we notice the latency.]

Can you see these 1-2 msec latencies even if you reduce the IDE sg-size
drastically via the max_sectors tunable? (just for testing purposes, to
eliminate hardirq latencies as much as possible)

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268056AbUHKNeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268056AbUHKNeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 09:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUHKNeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 09:34:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:63194 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268056AbUHKNeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 09:34:20 -0400
X-Authenticated: #4399952
Date: Wed, 11 Aug 2004 15:44:14 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
Message-Id: <20040811154414.4538027d@mango.fruits.de>
In-Reply-To: <20040811124342.GA17017@elte.hu>
References: <20040729222657.GA10449@elte.hu>
	<20040801193043.GA20277@elte.hu>
	<20040809104649.GA13299@elte.hu>
	<20040810132654.GA28915@elte.hu>
	<1092174959.5061.6.camel@mindpipe>
	<20040811073149.GA4312@elte.hu>
	<20040811074256.GA5298@elte.hu>
	<1092210765.1650.3.camel@mindpipe>
	<20040811090639.GA8354@elte.hu>
	<20040811141649.447f112f@mango.fruits.de>
	<20040811124342.GA17017@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004 14:43:42 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > > i'm currently running a loop of mlockall-test 100MB on a 466 MHz
> > > Celeron, and not a single blip on the radar with a 1000 usecs
> > > threshold, after 1 hour of runtime ...
> > 
> > I suppose you're not using jackd. As i have noticed that these
> > critical sections only get reported when jackd is running. It seems
> > jackd is producing a certain kind of load which exposes them..
> 
> so you can only trigger the latencies via mlockall-test if jackd is
> also running? 

Yes. I can happily mlockall 500 megs of ram when jackd is not running
and i do not get any preempt-timing reports.. As soon as jackd is
running even mlockall'ing only 20megs triggers a preempt-timing report
and also a alsa xrun report. Hmm, let me try turning off xrun_debug
traces while leaving preempt timing reports enabled... 

Ok, when xrun_debug traces are disabled [but preempt timing is on].
mlocking 20 megs of memory triggers an xrun [now only reported by jackd
in it's stdout, not in syslog] but not a preempt timing report. Lee, can
you verify? 

So it seems that the xrun_debug reports from the alsa interface jackd is
using triggers the preempt timing reports. So these are really
suspicious...

So i'm asking myself: How can jackd experience an xrun, when there's no
preempt-timing report showing a kernel latency. Jackd is running
SCHED_FIFO, so the mlockall_test program should not take away the cpu
from jackd. Is mlockall() special in another way? Sorry, i know too
little about the kernel internals to ask the right question. Maybe the
alsa driver is reacting to the mlockall_test..

Another piece of info which might be valuable (i cannot judge this): I
use jackd and mlockall not as root, but as normal user utilizing the
realtime lsm which allows non root users to mlock, mlockall  and change
the scheduling class (via sched_setsched()?). I'll try runnign jackd and
the mlockall_test as root to see if the results differ..

> Or do the latencies only trigger in jackd (and related 
> programs)?

Sorry, i don't understand that question..

> 
> if the later, then i'm wondering whether any of the audio code turns
> off caching for specific pages or does DMA to user pages, or mmap()s
> device(PCI) memory?

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/


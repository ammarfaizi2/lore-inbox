Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267359AbUHPCnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUHPCnF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUHPCnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:43:04 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:60899 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267359AbUHPCmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 22:42:54 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816023655.GA8746@elte.hu>
References: <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu>
	 <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu>
	 <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu>
	 <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu>
Content-Type: text/plain
Message-Id: <1092624221.867.118.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 22:43:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 22:36, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > There are a number of samples above 700us.  I am working with a period
> > time of 666 usecs, and since there are 2 periods per buffer, we would
> > have to hit two > 666 usec latencies in a row for an xrun - it appears
> > that there are many individual latencies above 666, certainly more
> > than there are xruns.  So, maybe the mlockall issue is not a result of
> > triggering a single large latency, but of increasing the frequency of
> > these higher latencies so that we are more likely to hit 2 in a row.
> 
> hm, it seems the mlockall() issue is too deterministic for it to be a
> statistical-only phenomenon. Also, isnt that xrun on the order of 15
> msecs? That's way too big too.
> 

I believe the constant-time behavior that I reported was an artifact of
ALSA xrun debugging.  Now it seems like the latency produced *does*
correspond directly to the amount of memory being mlockall'ed.  If
./mlockall-test 1500 triggers an xrun at all it's ~0.2ms.  3000 triggers
a ~1ms xrun, and 10000 a ~3 ms xrun.

> > IIRC ksoftirqd will defer more work under load, and ksoftirqd is one
> > of the more common offenders to hit the extract_entropy latency. 
> > Maybe mlockall causes more softirqs to be deferred, thus increaing the
> > change that we will have to do more than 666 usecs worth of work on 2
> > successive wakeups.
> 
> there should be no relation between softirqs and mlockall().
> 
> this is truly a mind-boggling latency. mlockall() is fully preemptible. 
> All it does is to pre-fault the whole range of pages that a process has.
> 
> could you try another thing: modify mlockall-test.cc to use mlock() on
> the freshly allocated anonymous pages? Does this produce the same
> latencies? mlockall() prefaults _all_ pages the process currently has. 
> Maybe mlockall() touches some page that is mapped both by jackd and
> mlockall-test and thus somehow interacts with jackd's scheduling.
> 

I don't know C++, Florian wrote this program.  Can you provide a
pseudo-patch?

> the anonymous pages themselves can have no IPC-alike connection to any
> page jackd owns. It is unlikely for that to be any connection between
> jackd and mlockall-test - other than both map glibc. To further exclude
> any possibility of resource sharing between jackd and mlockall-test,
> could you compile the later with -static?

Sure, I will try this.

Lee


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUHPCfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUHPCfd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267358AbUHPCfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:35:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41191 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265970AbUHPCfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 22:35:24 -0400
Date: Mon, 16 Aug 2004 04:36:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040816023655.GA8746@elte.hu>
References: <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de> <1092622121.867.109.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092622121.867.109.camel@krustophenia.net>
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

> There are a number of samples above 700us.  I am working with a period
> time of 666 usecs, and since there are 2 periods per buffer, we would
> have to hit two > 666 usec latencies in a row for an xrun - it appears
> that there are many individual latencies above 666, certainly more
> than there are xruns.  So, maybe the mlockall issue is not a result of
> triggering a single large latency, but of increasing the frequency of
> these higher latencies so that we are more likely to hit 2 in a row.

hm, it seems the mlockall() issue is too deterministic for it to be a
statistical-only phenomenon. Also, isnt that xrun on the order of 15
msecs? That's way too big too.

> IIRC ksoftirqd will defer more work under load, and ksoftirqd is one
> of the more common offenders to hit the extract_entropy latency. 
> Maybe mlockall causes more softirqs to be deferred, thus increaing the
> change that we will have to do more than 666 usecs worth of work on 2
> successive wakeups.

there should be no relation between softirqs and mlockall().

this is truly a mind-boggling latency. mlockall() is fully preemptible. 
All it does is to pre-fault the whole range of pages that a process has.

could you try another thing: modify mlockall-test.cc to use mlock() on
the freshly allocated anonymous pages? Does this produce the same
latencies? mlockall() prefaults _all_ pages the process currently has. 
Maybe mlockall() touches some page that is mapped both by jackd and
mlockall-test and thus somehow interacts with jackd's scheduling.

the anonymous pages themselves can have no IPC-alike connection to any
page jackd owns. It is unlikely for that to be any connection between
jackd and mlockall-test - other than both map glibc. To further exclude
any possibility of resource sharing between jackd and mlockall-test,
could you compile the later with -static?

	Ingo

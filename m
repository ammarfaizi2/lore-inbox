Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUHNI53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUHNI53 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 04:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUHNI5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 04:57:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:19850 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266204AbUHNIzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 04:55:53 -0400
Date: Sat, 14 Aug 2004 10:57:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040814085731.GA7033@elte.hu>
References: <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <20040813124249.13066d94@mango.fruits.de> <20040813105406.GJ8135@elte.hu> <20040813140321.78da570d@mango.fruits.de> <20040813120302.GA18221@elte.hu> <20040813145510.60e9e0f3@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813145510.60e9e0f3@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> This is something i wanted to ask anyways: In one of your first VP
> announcements you mentioned you wanted to eliminate all latencies > 1
> ms. To me it seems, that that goal is pretty much reached [at least i
> don't see any longer ones except for at boot and shutdown]. So the
> question is: What is the lower limit for laterncies that you want to
> hear reports about?

well ... i'm interested in all latencies that are well above the typical
average latencies in the system. E.g. when the average is around 20-30
usecs then reports of 200-300 usecs would be interesting.

there's no hard limit, really. Also, sometimes latencies that are 0.3
msec in the report could be 3 msec if triggered properly. So a seemingly
lower than 1 msec latency can very well pinpoint a problem area.

> WRT mlockall: i tried mlockall'ing 500 megs. This produced a new max
> latency of 299 us. the trace is rather long. This one is with jackd
> running and the one below this is w/o jackd running:

>  0.010ms (+0.000ms): free_page_and_swap_cache (clear_page_tables)
>  0.010ms (+0.000ms): __page_cache_release (clear_page_tables)
>  0.010ms (+0.000ms): free_hot_page (clear_page_tables)

hm, the reason for this one is that clear_page_tables() does all the
freeing in a single uninterrupted critical section covered by
mm->page_table_lock.

This function needs a lock-break i believe. Especially in the
process-exit case (exit_mmap()) the lock seems unjustified - the current
task is the sole owner of a never-to-be-used-again collection of
pagetables.

	Ingo

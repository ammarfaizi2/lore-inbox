Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268525AbUILHsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268525AbUILHsN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 03:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268528AbUILHsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 03:48:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51619 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268525AbUILHrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 03:47:52 -0400
Date: Sun, 12 Sep 2004 09:49:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Yielding processor resources during lock contention
Message-ID: <20040912074904.GA7777@elte.hu>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com> <16703.60725.153052.169532@cargo.ozlabs.ibm.com> <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com> <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org> <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com> <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com>
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


* Zwane Mwaikambo <zwane@fsmlabs.com> wrote:

> > Agreed, Paul we may as well remove the cpu_relax() in __preempt_spin_lock 
> > and use something like "cpu_yield" (architectures not supporting it would 
> > just call cpu_relax) i'll have something for you later.
> 
> The following patch introduces cpu_lock_yield which allows
> architectures to possibly yield processor resources during lock
> contention. [...]

it is not clear from the Intel documentation how well MONITOR+MWAIT
works on SMP. It seems to be targeted towards hyperthreaded CPUs - where
i suspect it's much easier to monitor the stream of stores done to an
address.

on SMP MESI caches the question is, does MONITOR+MWAIT detect a
cacheline invalidate or even a natural cacheline flush? I doubt it does.
But without having the monitored cacheline in Modified state in the
sleeping CPU for sure it's fundamentally racy and it's not possible to
guarantee latencies: another CPU could have grabbed the cacheline and
could keep it dirty indefinitely. (it could itself go idle forever after
this point!)

the only safe way would be if MONITOR moved the cacheline into Exclusive
state and if it would watch that cacheline possibly going away (i.e. 
another CPU unlocking the spinlock) after this point - in addition to
watching the stores of any HT sibling. But there is no description of
the SMP behavior in the Intel docs - and i truly suspect it would be
documented all over the place if it worked correctly on SMP... So i
think this is an HT-only instruction. (and in that limited context we
could indeed use it!)

one good thing to do would be to test the behavior and count cycles - it
is possible to set up the 'wrong' caching case that can potentially lead
to indefinite delays in mwait. If it turns out to work the expected way
then it would be nice to use. (The deep-sleep worries are not a too big
issue for latency-sensitive users as deep sleep can already occur via
the idle loop so it has to be turned off / tuned anyway.)

but unless the SMP case is guaranteed to work in a time-deterministic
way i dont think this patch can be added :-( It's not just the question
of high latencies, it's the question of fundamental correctness: with
large enough caches there is no guarantee that a CPU will _ever_ flush a
dirty cacheline to RAM.

	Ingo

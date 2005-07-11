Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVGKFYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVGKFYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 01:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVGKFYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 01:24:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11403 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262242AbVGKFYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 01:24:45 -0400
Date: Mon, 11 Jul 2005 07:24:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kristian Benoit <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       tglx@linutronix.de, karim@opersys.com, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, part 4
Message-ID: <20050711052413.GA13293@elte.hu>
References: <42CF05BE.3070908@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CF05BE.3070908@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Kristian Benoit <kbenoit@opersys.com> wrote:

[...]
> "plain" run:
> 
> Measurements   |   Vanilla   |  preempt_rt    |   ipipe
> ---------------+-------------+----------------+-------------
> fork           |      97us   |   91us (-6%)   |  101us (+4%)
> mmap           |     776us   |  629us (-19%)  |  794us (+2%)

some of you have wondered how it's possible that the PREEMPT_RT kernel 
is _faster_ than the vanilla kernel in these two metrics.

I've done some more profiling, and one reason is kmap_atomic(). As i 
pointed out in an earlier mail, in your tests you not only had HIGHMEM64 
enabled, but also HIGHPTE, which is a heavy kmap_atomic() user. [and 
which is an option meant for systems with 8GB or more RAM, not the 
typical embedded target.]

kmap_atomic() is a pretty preemption-unfriendly per-CPU construct, which 
under PREEMPT_RT had to be changed and was mapped into kmap(). The 
performance advantage comes from the caching built into kmap() and not 
having to do per-page invlpg calls. (which can be pretty slow, 
expecially on highmem64) The 'mapping kmap_atomic into kmap' technique 
is perfectly fine under PREEMPT_RT because all kernel code is 
preemptible, but it's not really possible in the vanilla kernel due to 
the fundamental non-preemptability of interrupts, the preempt-off-ness 
of the mmu_gather mechanism, the atomicity of the ->page_table_lock 
spinlock, etc.

so this is a case of 'fully preemptible beats non-preemptible due to 
flexibility', but it should be more of an exception than the rule, 
because generally the fully preemptible kernel tries to be 1:1 identical 
to the vanilla kernel. But it's an interesting phenomenon from a 
conceptual angle nevertheless.

	Ingo

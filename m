Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268799AbUILTdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268799AbUILTdT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 15:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268805AbUILTdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 15:33:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39630 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268799AbUILTdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 15:33:17 -0400
Date: Sun, 12 Sep 2004 21:34:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Yielding processor resources during lock contention
Message-ID: <20040912193412.GA28791@elte.hu>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com> <16703.60725.153052.169532@cargo.ozlabs.ibm.com> <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com> <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org> <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com> <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com> <20040912074904.GA7777@elte.hu> <Pine.LNX.4.53.0409121157110.2297@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0409121157110.2297@montezuma.fsmlabs.com>
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


* Zwane Mwaikambo <zwane@linuxpower.ca> wrote:

> > but unless the SMP case is guaranteed to work in a time-deterministic
> > way i dont think this patch can be added :-( It's not just the question
> > of high latencies, it's the question of fundamental correctness: with
> > large enough caches there is no guarantee that a CPU will _ever_ flush a
> > dirty cacheline to RAM.
> 
> The suggested usage of monitor/mwait avoids that scenario, the recommended 
> usage being;
> 
> while (*addr != condition) {
> 	monitor(addr)
> 	if (*addr != condition)
> 		mwait();
> }
> 
> This method is used because you can receive spurious wakeups from
> mwait.  Like 'hlt' an interrupt, NMI, SMI etc will cause the processor
> to continue executing the next instruction after mwait. The extended
> sleep state however could occur if interrupts are disabled which isn't
> the case with the current users. So there is a sense of time
> deterministic behaviour with an operating system which uses a periodic
> timer tick for example. But regardless of that, i also think this
> requires further clarification with respect to side effects and
> benchmarking with current hardware.

right now we might have a periodic timer interrupt, but for the sake of
powersaving (and for virtualization) we want to try variable rate timer
interrupts real soon, which would remove any sort of determinism from
the mwait() loop. So we cannot take this approach unless CPU makers
guarantee the behavior. Right now it's inherently fragile.

Besides, even a 1msec upper cap on spinlock-wait times is totally
unacceptable from a latency and quality of implementation point of view.

	Ingo

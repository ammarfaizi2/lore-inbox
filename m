Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVCONgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVCONgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVCONgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:36:46 -0500
Received: from mx2.elte.hu ([157.181.151.9]:31966 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261225AbVCONgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:36:14 -0500
Date: Tue, 15 Mar 2005 14:35:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050315133540.GB4686@elte.hu>
References: <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain> <1110574019.19093.23.camel@mindpipe> <1110578809.19661.2.camel@mindpipe> <Pine.LNX.4.58.0503140214360.697@localhost.localdomain> <Pine.LNX.4.58.0503140427560.697@localhost.localdomain> <Pine.LNX.4.58.0503140509170.697@localhost.localdomain> <Pine.LNX.4.58.0503141024530.697@localhost.localdomain> <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu> <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > good progress - but the global lock may be a scalability worry on
> > upstream though. Would it be possible to just mirror much of the current
> > lock logic, but with spinlocks instead of bitlocks? And there should be
> > no #ifdefs on PREEMPT_RT.
> 
> The first patch I had just converted the bit spinlocks to spinlocks
> but I thought that adding two spinlocks was too much for every buffer
> head, even if it wasn't in the ext3 file system. The journal head
> spinlock is just used to add and remove the journal heads from the
> buffer heads, so I'm not sure how much contention is on them. I only
> have a dual smp system, so I can't test the system on large number of
> CPUs. What do you think, should we sacrafice memory for speed?

there are two bad effects of global spinlocks: 1) contention 2)
cacheline bouncing. It's #2 that would affect this spinlock. While i'm
not sure this would show up in usual benchmarks, we should rather err on
the side of more scalability. Two spinlocks are just two more machine
words on most architectures, so i dont think it matters all that much,
while it removes a major wart - as long as the two extra locks are for
ext3 buffer-heads only.

> What should we use instead of #ifdef PREEMPT_RT? Or should we just
> keep it the same for both.  Since this fix is only to fix spinlocks
> that schedule, I figured that it would be better not to waste the
> memory of those not using PREEMPT_RT.  Should I use the opposite
> PREEMPT_DESKTOP?

i'd go for removing bit-spinlocks altogether, in the upstream kernel. It
would simplify things, besides making PREEMPT_RT simpler as well. The
memory overhead is not a big issue i believe. (8 more bytes per ext3 bh,
on x86)

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269065AbUHMKso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269065AbUHMKso (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269070AbUHMKso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:48:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:38336 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269065AbUHMKrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:47:19 -0400
Date: Fri, 13 Aug 2004 12:48:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: [patch] voluntary-preempt-2.6.8-rc4-O7
Message-ID: <20040813104817.GI8135@elte.hu>
References: <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092382825.3450.19.camel@mindpipe>
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

> Here's another weird one.  This happens when you create a new tab in
> gnome-terminal, which causes a fork().
> 
> preemption latency trace v1.0
> -----------------------------
>  latency: 613 us, entries: 697 (697)
>  process: gnome-terminal/3467, uid: 1000
>  nice: 0, policy: 0, rt_priority: 0
> =======>

>  0.459ms (+0.000ms): preempt_schedule (copy_page_range)
>  0.459ms (+0.000ms): preempt_schedule (copy_page_range)
>  0.460ms (+0.000ms): preempt_schedule (copy_page_range)
>  0.461ms (+0.000ms): preempt_schedule (copy_page_range)

ok, it seems the lock-break of the outer loop was not enough - the up to
1024 iterations in the inner loop can generate quite high latencies too.

in -O7 i've added a runtime flag to disable/enable tracing without
having to recompile the kernel:

 http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O7

/proc/sys/kernel/tracing_enabled controls whether full tracing is done
or not. (some overhead still occurs due to the instrumentation but most
of the tracing overhead should vanish.)

It would be nice to check whether the same overhead occurs with tracing
disabled too - the copy_page_range() loop could be one piece of code
that could get roughly twice as slow with tracing enabled as with
tracing disabled. But 300 usecs is too much too.

-O7 also adds your EXPORT_SYMBOL fix and Peter Zijlstra's compilation
fix.

	Ingo

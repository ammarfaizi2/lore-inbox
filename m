Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760310AbWLFIiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760310AbWLFIiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760305AbWLFIiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:38:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47973 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760300AbWLFIiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:38:20 -0500
Date: Wed, 6 Dec 2006 09:37:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let WARN_ON() output the condition
Message-ID: <20061206083730.GB24851@elte.hu>
References: <Pine.LNX.4.64.0612060149220.28502@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612060149220.28502@twin.jikos.cz>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiri Kosina <jkosina@suse.cz> wrote:

> [PATCH] let WARN_ON() output the condition
> 
> It is possible, in some cases, that the output of WARN_ON() is 
> ambiguous and can't be properly used to identify the exact condition 
> which caused the warning to trigger. This happens whenever there is a 
> macro that contains multiple WARN_ONs inside. Notable example is 
> spin_lock_mutex(). If any of the two WARN_ONs trigger, we are not able 
> to say which one was the cause (as we get only line number, which 
> however belongs to the place where the macro was expanded).

a WARN_ON() also triggers a stack dump, which should pinpoint the exact 
location. (especially if combined with kallsyms) For example:

posix_cpu_timer/13[CPU#1]: BUG in trace_stop_sched_switched at kernel/latency_trace.c:2142

Call Trace:
 [<ffffffff8020b272>] dump_trace+0xaf/0x3f4
 [<ffffffff8020b5f6>] show_trace+0x3f/0x5d
 [<ffffffff8020b8c1>] dump_stack+0x1a/0x1c
 [<ffffffff8022ef09>] __WARN_ON+0x65/0x80
 [<ffffffff80252c37>] trace_stop_sched_switched+0xad/0x30a
 [<ffffffff804ae810>] thread_return+0xa5/0x123
 [<ffffffff804aea15>] schedule+0xdd/0x101
 [<ffffffff8024298f>] posix_cpu_timers_thread+0x86/0xe5
 [<ffffffff80240c26>] kthread+0xd6/0x100
 [<ffffffff8020a938>] child_rip+0xa/0x12

here the "trace_stop_sched_switched+0xad/0x30a" is a perfect 
identification of the WARN_ON() code location - if there's any doubt 
about why the problem happened.

> This patch lets WARN_ON() to output also the condition and fixes the 
> DEBUG_LOCKS_WARN_ON() macro to pass the condition properly to WARN_ON. 
> The possible drawback could be when someone passes a condition which 
> has sideeffects. Then it would be evaluated twice, instead of current 
> one evaluation. On the other hand, when anyone passes expression with 
> sideeffects to WARN_ON(), he is asking for problems anyway.

side-effects happen regularly in WARN_ON()s and while they should be 
avoided, they are not noticed by the compiler and can cause nasty bugs 
if executed twice. Do we really need this change?

	Ingo

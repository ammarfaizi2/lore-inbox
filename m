Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVDIG4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVDIG4U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 02:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVDIG4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 02:56:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15565 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261303AbVDIG4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 02:56:03 -0400
Date: Sat, 9 Apr 2005 08:55:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
Subject: Re: [patch] sched: unlocked context-switches
Message-ID: <20050409065507.GA4866@elte.hu>
References: <B8E391BBE9FE384DAA4C5C003888BE6F033DB07E@scsmsx401.amr.corp.intel.com> <20050409043848.GA2677@elte.hu> <42577602.8090507@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42577602.8090507@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.223, required 5.9,
	BAYES_00 -4.90, SUBJ_HAS_UNIQ_ID 2.68
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Well that does look like a pretty good cleanup. It certainly is the 
> final step in freeing complex architecture switching code from 
> entanglement with scheduler internal locking, and unifies the locking 
> scheme.
> 
> I did propose doing unconditionally unlocked switches a while back 
> when my patch first popped up - you were against it then, but I guess 
> you've had second thoughts?

the reordering of switch_to() and the switch_mm()-related logic was that 
made it really worthwile and clean. I.e. we pick a task atomically, we 
switch stacks, and then we switch the MM. Note that this setup still 
leaves the possibility open to move the stack-switching back under the 
irq-disabled section in a natural way.

> It does add an extra couple of stores to on_cpu, and a wmb() for 
> architectures that didn't previously need the unlocked switches. And 
> ia64 needs the extra interrupt disable / enable. Probably worth it?

it also removes extra stores to rq->prev_mm and other stores. I havent 
measured any degradation on x86.

If the irq disable/enable becomes widespread i'll do another patch to 
push the irq-enabling into switch_to() so the arch can do the 
stack-switch first and then enable interrupts and do the rest - but i 
didnt want to complicate things unnecessarily for now.

> Minor style request: I like that you're accessing ->on_cpu through 
> functions so the !SMP case doesn't clutter the code with ifdefs... but 
> can you do set_task_on_cpu(p) and clear_task_on_cpu(p) ?

yeah, i thought about these two variants and went for set_task_on_cpu() 
so that it's less encapsulated (it's really just a conditional 
assignment) and that it parallels set_task_cpu() use. But no strong 
feelings either way. Anyway, lets try what we have now, i'll do the rest 
in deltas.

	Ingo

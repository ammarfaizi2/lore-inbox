Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbUKSAv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUKSAv2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbUKSAoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 19:44:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:26579 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262884AbUKRTFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:05:42 -0500
Date: Thu, 18 Nov 2004 11:05:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] fix __flush_tlb*() preemption bug on
 CONFIG_PREEMPT
In-Reply-To: <20041118194619.GA23483@elte.hu>
Message-ID: <Pine.LNX.4.58.0411181056550.2222@ppc970.osdl.org>
References: <20041118124656.GA4256@elte.hu> <Pine.LNX.4.58.0411180742290.2222@ppc970.osdl.org>
 <20041118194619.GA23483@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Nov 2004, Ingo Molnar wrote:
> 
> yeah, if we have such a debugging check then it should be pretty safe to
> find the places one by one and fix them. The patch below (against -rc2)
> adds the debugging check and fixes ioremap, on x86. I've done a quick
> testboot and it doesnt trigger any other warnings.

What about moving the "preempt_disable/enable" into the special flush
cases (ie "global_flush_tlb()" and "flush_tlb_all()"). I don't think it 
makes sense in the code that uses them.

Then we'd just make it a rule that TLB flushing _has_ to be done either
from a valid VM context (that follows the flush) or non-preemptible.  
Otherwise it's kind of undefined what happens to the current context, not
just from an implementation angle, but from a _conceptual_ standpoint.

In contrast, the "global" flushes obviously make sense from any context
(there is no "conceptual" confusion there and the confusion is purely an
implementation bug), which is why I think they should do the preemption
disable themselves.

I really want core kernel code to make sense from a conceptual angle. Not 
just "it works", but "it works because it makes sense".

> (maybe we want to change that check to WARN_ON(!preempt_count()), while
> non-lazy-TLB tasks are fine right now, it's quite fragile i think to
> allow a TLB flush to preempt and it's a ticking timebomb i think.)

Hmm.. I don't see the problem. Maybe we should have other rules (like "you 
have to hold the page table lock") that would make that true, but I'd 
prefer the warning to have some "raison d'etre", if you see what I mean?

Another way of saying the same thing: if we cannot put a comment saying
"this is why we check _this_ condition", then we shouldn't check that
condition.

But yes, it may well make perfect sense to say "we have to hold the page 
table spinlock in order to flush the tlb". Is that actually true right 
now?

		Linus

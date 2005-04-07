Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVDGTAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVDGTAj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 15:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVDGTAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 15:00:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37004 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262563AbVDGTAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 15:00:14 -0400
Date: Thu, 7 Apr 2005 20:59:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: arjan@infradead.org, kaos@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2 in_atomic() picks up preempt_disable()
Message-ID: <20050407185923.GA12012@elte.hu>
References: <200504071840.j37Iei25019895@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504071840.j37Iei25019895@harpo.it.uu.se>
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


* Mikael Pettersson <mikpe@csd.uu.se> wrote:

> On Thu, 07 Apr 2005 12:17:37 +0200, Arjan van de Ven wrote:
> >On Thu, 2005-04-07 at 20:10 +1000, Keith Owens wrote:
> >> 2.6.12-rc2, with CONFIG_PREEMPT and CONFIG_PREEMPT_DEBUG.  The
> >> in_atomic() macro thinks that preempt_disable() indicates an atomic
> >> region so calls to __might_sleep() result in a stack trace.
> >
> >but you're not allowed to schedule when preempt is disabled!
> 
> That sounds draconian. Where is that requirement stated?

(in the code, and in lkml discussions, as usual. There's tons of code 
that correctly handled it and continues to handle it. Let me be clear, 
this isnt some obscure side-effect, this is one of the cornerstones, 
preempt_disable()/enable() always had these semantics, and this is very 
much being relied on in a number of areas.)

> A preempt-disabled region ought to have the same semantics as in a 
> CONFIG_PREEMPT=n kernel, and since schedule is Ok in the latter case 
> it should be Ok in the former too.
> 
> All that preempt_disable() should do is prevent involuntary schedules.  
> But the conditional schedules introduced by may-sleep functions are 
> _voluntary_, so there's no reason to forbid them.

this just hides bugs and introduces bugs. From a critical section POV a 
voluntary preemption is almost the same thing as a voluntary preemption 
- the task may wander to another CPU, and smp_processor_id() might 
become different. If it's not a problem for your code to preempt then 
just enable preemption before calling it. Anyway, preempt_disable() / 
preempt_enable() is pretty much an internal interface and shouldnt be 
used lightly.

	Ingo

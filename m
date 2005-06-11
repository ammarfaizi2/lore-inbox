Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVFKNuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVFKNuP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 09:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVFKNuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 09:50:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62849 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261697AbVFKNuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 09:50:05 -0400
Date: Sat, 11 Jun 2005 15:46:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
Message-ID: <20050611134609.GA31025@elte.hu>
References: <1118449247.27756.47.camel@dhcp153.mvista.com> <Pine.OSF.4.05.10506111455240.2917-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506111455240.2917-100000@da410.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> > Plus take into
> > account that the average interrupt disable section is very small .. I
> > also think it's possible to extend my version to allow those section to
> > be preemptible but keep the cost equally low.
> > 
> 
> The more I think about it the more dangerous I think it is. What does 
> local_irq_disable() protect against? All local threads as well as 
> irq-handlers. If these sections keeped mutual exclusive but preemtible 
> we will not have protected against a irq-handler.

one way to make it safe/reviewable is to runtime warn if 
local_irq_disable() is called from a !preempt_count() section. But this 
will uncover quite some code. There's some code in the VM, in the 
buffer-cache, in the RCU code - etc. that uses per-CPU data structures 
and assumes non-preemptability of local_irq_disable().

> I will start to play around with the following:
> 1) Make local_irq_disable() stop compiling to see how many we are really
> talking about.

there are roughly 100 places:

 $ objdump -d vmlinux | grep -w call |
      grep -wE 'local_irq_disable|local_irq_save' | wc -l
 116

the advantage of having such primitives as out-of-line function calls :)

> 2) Make local_cpu_lock, which on PREEMPT_RT is a rt_mutex and on
> !PREEMPT_RT turns into local_irq_disable()/enable() pairs. To introduce
> this will demand some code-analyzing for each case but I am afraid there
> is no general one-size solution to all the places.

I'm not sure we'd gain much from this. Lets assume we have a highprio RT 
task that is waiting for an external event. Will it be able to preempt 
the IRQ mutex?  Yes. Will it be able to make any progress: no, because 
it needs an IRQ thread to run to get the wakeup in the first place, and 
the IRQ thread needs to take the IRQ mutex => serialization.

what seems a better is to rewrite per-CPU-local-irq-disable users to 
make use of the DEFINE_PER_CPU_LOCKED/per_cpu_locked/get_cpu_lock 
primitives to use preemptible per-CPU data structures. In this case 
these sections would be truly preemptible. I've done this for a couple 
of cases already, where it was unavoidable for lock-dependency reasons.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbWFKGib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWFKGib (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 02:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWFKGia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 02:38:30 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:18824 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161087AbWFKGia (ORCPT
	<rfc822;linux-kerneL@vger.kernel.org>);
	Sun, 11 Jun 2006 02:38:30 -0400
Date: Sun, 11 Jun 2006 08:37:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: linux-kerneL@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH -rt] Priority preemption latency
Message-ID: <20060611063746.GA11558@elte.hu>
References: <200606091701.55185.dvhltc@us.ibm.com> <20060610064850.GA11002@elte.hu> <200606102249.26063.dvhltc@us.ibm.com> <20060611055828.GA9452@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060611055828.GA9452@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5349]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> i slept on it meanwhile, and i think the safest would be to also do 
> the attached patch ontop of -rt3. This makes the 'kick other CPUs' 
> logic totally unconditional - so whatever happens the wakeup code will 
> notice if an RT task is in trouble finding the right CPU. Under -rt3 
> we'd only run into this branch if we stayed on the same CPU - but 
> there can be cases when we have your scenario even in precisely such a 
> case. It's rare but possible.

just to elaborate on that possibility a bit more, it's this portion of 
the wakeup code that could cause problems:

        new_cpu = wake_idle(new_cpu, p);
        if (new_cpu != cpu) {
                set_task_cpu(p, new_cpu);
                task_rq_unlock(rq, &flags);
                /* might preempt at this point */
                rq = task_rq_lock(p, &flags);
                old_state = p->state;
                if (!(old_state & state))

at the 'might preempt' point the kernel can go to any other CPU. The 
stock kernel does not care because it's really rare and wakeup placement 
of tasks is a statistical thing to it. But for RT it's important to get 
it right all the time, so my patch removes the RT-overload check from 
the else branch to an unconditional place. (I doubt you can trigger it 
normally, but it's a possibility nevertheless.)

(i'll do a patch for the upstream scheduler to not re-enable interrupts 
at this point [it's a waste of cycles], but even if we couldnt go to 
another CPU the whole scheduling scenario might change while we are 
trying to acquire the runqueue lock, so it's still beneficial to have 
the RT-overload check unconditional.)

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267993AbUJOO7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267993AbUJOO7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267998AbUJOO7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:59:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9375 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267993AbUJOO7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:59:10 -0400
Date: Fri, 15 Oct 2004 16:58:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Robert Wisniewski <bob@watson.ibm.com>
Cc: Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org,
       Thomas Zanussi <trz@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041015145859.GA32034@elte.hu>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <416F0071.3040304@opersys.com> <20041014234603.GA22964@elte.hu> <416F14B4.8070002@opersys.com> <20041015065905.GA7457@elte.hu> <16751.49753.647324.718354@kix.watson.ibm.com> <20041015131138.GA27811@elte.hu> <16751.57790.72834.878118@kix.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16751.57790.72834.878118@kix.watson.ibm.com>
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


* Robert Wisniewski <bob@watson.ibm.com> wrote:

> Ingo Molnar writes:
>  > 
>  > * Robert Wisniewski <bob@watson.ibm.com> wrote:
>  > 
>  > >  > > cmpxchg (basically: try reserve; if fail retry; else write), with
>  > >  > > per-cpu buffers.
>  > >  > 
>  > >  > this still does not solve all problems related to irq entries: if the
>  > >  > IRQ interrups the tracing code after a 'successful reserve' but before
>  > >  > the 'else write' point, and the trace is printed/saved from an
>  > >  > interrupt, then there will be an incomplete entry in the trace.
>  > > 
>  > > That is incorrect.  The system behavior needed to generate an
>  > > incomplete entry is far more complicated and unlikely than what you
>  > > describe.
>  > 
>  > ah, but i'm talking about actual first-hand experience, not supposition. 
>  > It happens quite easily with latency traces (which are saved/printed
>  > from IRQ entries) and it can be very annoying to analyze. My first
>  > tracers tried to do things without the IRQ flag, so i've seen both
>  > methods.
> 
> This means that other code you've written has this happen, it doesn't mean
> the fundamental model is broken.  Also, if what you claim is true and there
> really is this contention, then it both means that 1) there are many many
> other higher priority tasks in the system than the one you are trying to
> trace, and 2) it's questionable whether you want to use locks.

_interrupts_. The latency tracer does traces like:

 00000002 0.022ms (+0.000ms): mark_page_accessed (zap_pte_range)
 00000002 0.022ms (+0.000ms): page_remove_rmap (zap_pte_range)
 00000002 0.022ms (+0.000ms): free_page_and_swap_cache (zap_pte_range)
 00000002 0.022ms (+0.001ms): put_page (zap_pte_range)
 00010002 0.023ms (+0.000ms): do_IRQ (zap_pte_range)
 00010002 0.023ms (+0.000ms): do_IRQ (<00000000>)
 00010003 0.024ms (+0.004ms): mask_and_ack_8259A (do_IRQ)
 00010003 0.029ms (+0.000ms): redirect_hardirq (do_IRQ)
 00010000 0.029ms (+0.000ms): handle_IRQ_event (do_IRQ)

and i just pointed out why i didnt use relayfs.

	Ingo

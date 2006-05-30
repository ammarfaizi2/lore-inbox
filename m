Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWE3Trc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWE3Trc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWE3Trc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:47:32 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:50661 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932447AbWE3Trb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:47:31 -0400
Date: Tue, 30 May 2006 21:47:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch, -rc5-mm1] lock validator: disable NMI watchdog if CONFIG_LOCKDEP, i386
Message-ID: <20060530194748.GC22742@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <20060530111138.GA5078@elte.hu> <1148990326.7599.4.camel@homer> <1148990725.8610.1.camel@homer> <20060530120641.GA8263@elte.hu> <1148991422.8610.8.camel@homer> <20060530121952.GA9625@elte.hu> <1148992098.8700.2.camel@homer> <20060530122950.GA10216@elte.hu> <p73mzcz1g0h.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73mzcz1g0h.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> > 
> > The NMI watchdog uses spinlocks (notifier chains, etc.),
> > so it's not lockdep-safe at the moment.
> 
> That's totally unsafe even without lockdep and should be fixed 
> instead. I guess someone bungled the notifier chain conversion. The 
> NMI notifiers need to be lockless.

yeah, totally agreed, they need to be raw notifiers. Havent had time to 
investigate it in detail yet - i went for the easier hack of disabling 
NMIs while lockdep is enabled.

Here's the kernel trace of it happening on x86_64:

   <...>-417   0D... 2983us : __lockdep_acquire (ffffffff81a5cb18 0 0)
   <...>-417   0D... 2983us : __lockdep_acquire (0 0 0)
   <...>-417   0D... 2984us : do_nmi (nmi)
   <...>-417   0D.h. 2985us : default_do_nmi (do_nmi)
   <...>-417   0D.h. 2986us : atomic_notifier_call_chain (default_do_nmi)
   <...>-417   0D.h. 2986us : notifier_call_chain (atomic_notifier_call_chain)
   <...>-417   0D.h. 2987us : nmi_watchdog_tick (default_do_nmi)
   <...>-417   0D.h. 2987us : atomic_notifier_call_chain (nmi_watchdog_tick)
   <...>-417   0D.h. 2987us : notifier_call_chain (atomic_notifier_call_chain)
   <...>-417   0D... 2988us : trace_hardirqs_off (trace_hardirqs_off_thunk)
   <...>-417   0D... 2989us : __lockdep_acquire (1 1 0)
   <...>-417   0D... 2989us : mark_lock (__lockdep_acquire)
   <...>-417   0D... 2989us : mark_lock (__lockdep_acquire)
   <...>-417   0D... 2989us+: mark_lock (__lockdep_acquire)
   <...>-417   0D... 2991us : check_chain_key (__lockdep_acquire)
   <...>-417   0.... 2992us : _raw_spin_lock (_spin_lock)
   <...>-417   0.... 2992us : _spin_lock (dput)

that shouldnt be an atomic_notifier but a raw_notifier.

	Ingo

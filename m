Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUEOTQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUEOTQv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 15:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUEOTQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 15:16:50 -0400
Received: from colin2.muc.de ([193.149.48.15]:40197 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264635AbUEOTQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 15:16:45 -0400
Date: 15 May 2004 21:16:43 +0200
Date: Sat, 15 May 2004 21:16:43 +0200
From: Andi Kleen <ak@muc.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][3/7] perfctr-2.7.2 for 2.6.6-mm2: x86_64
Message-ID: <20040515191643.GA5748@colin2.muc.de>
References: <200405151442.i4FEgkjY001401@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405151442.i4FEgkjY001401@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 04:42:46PM +0200, Mikael Pettersson wrote:
> Computing the mapping in the kernel would need lots of code, unless
> it cheats like oprofile does on the P4 and hides most counters.
> Neither hiding counters nor computing imperfect mappings is acceptable.

So how do you get oprofile and the perfctr based NMI watchdog 
to cooperate?  IMHO just silently breaking each other is not a good idea, 
and clearly the kernel users cannot depend on user space management.

Also how does the user space management with multiple processes when
the virtual counters are disabled? 

If you think doing it for individual registers is too complicated
how about a global lock? - Each application could reserve the full
perfctr bank.

This would require disabling the non IO-APIC NMI watchdog completely 
when any other users are active, but that is probably tolerable.

> >+	if( perfctr_cstatus_has_tsc(cstatus) )
> >+		rdtscl(ctrs->tsc);
> >+	nrctrs = perfctr_cstatus_nractrs(cstatus);
> >+	for(i = 0; i < nrctrs; ++i) {
> >+		unsigned int pmc = state->pmc[i].map;
> >+		rdpmc_low(pmc, ctrs->pmc[i]);
> >+	}
> >
> >K8 has speculative rdtsc. Most likely you want a sync_core() somewhere
> >in there.
> 
> What's the cost for sync_core()? The counts don't have to be
> perfect.

It's a CPUID to force a pipeline flush. Let's say 20-30 cycles.

-Andi

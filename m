Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265243AbUFAVlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265243AbUFAVlE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265244AbUFAVlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:41:04 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:25426 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265243AbUFAVlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:41:00 -0400
From: Dimitri Sivanich <sivanich@sgi.com>
Message-Id: <200406012140.i51LeGjV043356@fsgi142.americas.sgi.com>
Subject: Re: Slab cache reap and CPU availability
To: akpm@osdl.org (Andrew Morton)
Date: Tue, 1 Jun 2004 16:40:16 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20040524145303.45c8f8a6.akpm@osdl.org> from "Andrew Morton" at May 24, 2004 02:53:03 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Dimitri Sivanich <sivanich@sgi.com> wrote:
> >
> > The IA/64 backtrace with all the cruft removed looks as follows:
> > 
> > 0xa000000100149ac0 reap_timer_fnc+0x100
> > 0xa0000001000f4d70 run_timer_softirq+0x2d0
> > 0xa0000001000e9440 __do_softirq+0x200
> > 0xa0000001000e94e0 do_softirq+0x80
> > 0xa000000100017f50 ia64_handle_irq+0x190
> > 
> > The system is running mostly AIM7, but I've seen holdoffs > 30 usec with
> > virtually no load on the system.
> 
> They're pretty low latencies you're talking about there.
> 
> You should be able to reduce the amount of work in that timer handler by
> limiting the size of the per-cpu caches in the slab allocator.  You can do
> that by writing a magic incantation to /proc/slabinfo or:
> 
> --- 25/mm/slab.c~a	Mon May 24 14:51:32 2004
> +++ 25-akpm/mm/slab.c	Mon May 24 14:51:37 2004
> @@ -2642,6 +2642,7 @@ static void enable_cpucache (kmem_cache_
>  	if (limit > 32)
>  		limit = 32;
>  #endif
> +	limit = 8;

I tried several values for this limit, but these had little effect.

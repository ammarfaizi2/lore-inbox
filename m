Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265514AbUFDBvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbUFDBvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 21:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265516AbUFDBvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 21:51:12 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:48537 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S265514AbUFDBvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 21:51:07 -0400
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
	implementation
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
       Jesse Barnes <jbarnes@sgi.com>, Joe Korty <joe.korty@ccur.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Simon Derr <Simon.Derr@bull.net>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20040603101010.4b15734a.pj@sgi.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	 <20040603101010.4b15734a.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1086313667.29381.897.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 04 Jun 2004 11:47:47 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-04 at 03:10, Paul Jackson wrote:
> cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
> 
> 	Major rewrite of cpumask to use a single implementation,
> 	as a struct-wrapped bitmap.

Go Paul!

> + * 1) The 'type-checked' form of cpu_isset() causes gcc (3.3.2, anyway)
> + *    to generate slightly worse code.  Note for example the additional
> + *    40 lines of assembly code compiling the "for each possible cpu"
> + *    loops buried in the disk_stat_read() macros calls when compiling
> + *    drivers/block/genhd.c (arch i386, CONFIG_SMP=y).  So use a simple
> + *    one-line #define for cpu_isset(), instead of wrapping an inline
> + *    inside a macro, the way we do the other calls.

Hmm... 

> +/* No static inline type checking - see Subtlety (1) above. */
> +#define cpu_isset(cpu, cpumask) test_bit((cpu), (cpumask).bits)

How about something really grungy like:

#define cpu_isset(cpu, cpumask)				\
	({ __typeof__(cpumask) __cpumask;		\
	   (void)(&__cpumask) == (cpumask_t *)0);	\
	   test_bit((cpu), (cpumask).bits); })

> +#define cpus_addr(src) ((src).bits)

We've discussed this before when talking about whether it'd be easier to
just make people use raw bitop functions directly, so I know we have
philosophical differences here.

So, opinion alert: if I were doing this, I'd probably live without this
macro; in my mind it crosses the "too much abstraction" line.  I did
momentarily wonder what this macro did when I saw it used in the
succeeding patches.

But it's a minor nit; thanks for doing these.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell


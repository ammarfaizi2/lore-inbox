Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUENPSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUENPSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 11:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUENPSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 11:18:20 -0400
Received: from zero.aec.at ([193.170.194.10]:38415 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261375AbUENPOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 11:14:47 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][3/7] perfctr-2.7.2 for 2.6.6-mm2: x86_64
References: <1VLRr-38z-19@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 14 May 2004 17:14:43 +0200
In-Reply-To: <1VLRr-38z-19@gated-at.bofh.it> (Mikael Pettersson's message of
 "Fri, 14 May 2004 16:30:13 +0200")
Message-ID: <m3oeorvy58.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

Before merging all that I would definitely recommend some generic
module to allocate performance counters. IBM had a patch for this
long ago, and it is even more needed now.

> diff -ruN linux-2.6.6-mm2/drivers/perfctr/x86_64.c linux-2.6.6-mm2.perfctr-2.7.2.x86_64/drivers/perfctr/x86_64.c
> --- linux-2.6.6-mm2/drivers/perfctr/x86_64.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.6-mm2.perfctr-2.7.2.x86_64/drivers/perfctr/x86_64.c	2004-05-14 14:45:43.990230001 +0200
> @@ -0,0 +1,660 @@
> +/* $Id: x86_64.c,v 1.27 2004/05/13 23:32:50 mikpe Exp $
> + * x86_64 performance-monitoring counters driver.

[...]

Can't you share most/all of that file with i386 ? 
You'll want that definitely once you support Intel CPUs too, 
and you have to do that eventually.

Same for include/asm-x86_64/perfctr.h

+struct per_cpu_cache {	/* roughly a subset of perfctr_cpu_state */
+	union {
+		unsigned int id;	/* cache owner id */
+	} k1;
+	struct {
+		/* NOTE: these caches have physical indices, not virtual */
+		unsigned int evntsel[4];
+	} control;
+} ____cacheline_aligned;
+static struct per_cpu_cache per_cpu_cache[NR_CPUS] __cacheline_aligned;

This should use per_cpu_data

+static unsigned int new_id(void)

[...]

Why can't that wrap? Maybe it should use the functions in lib/idr.c ?

+	if( perfctr_cstatus_has_tsc(cstatus) )
+		rdtscl(ctrs->tsc);
+	nrctrs = perfctr_cstatus_nractrs(cstatus);
+	for(i = 0; i < nrctrs; ++i) {
+		unsigned int pmc = state->pmc[i].map;
+		rdpmc_low(pmc, ctrs->pmc[i]);
+	}

K8 has speculative rdtsc. Most likely you want a sync_core() somewhere
in there.

The way you set your brackets is weird.

Why do you check for K8 C stepping? I don't see any code that
does anything special with that.

-Andi


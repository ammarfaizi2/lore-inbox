Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUEOOop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUEOOop (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 10:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUEOOoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 10:44:44 -0400
Received: from aun.it.uu.se ([130.238.12.36]:6349 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262744AbUEOOmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 10:42:55 -0400
Date: Sat, 15 May 2004 16:42:46 +0200 (MEST)
Message-Id: <200405151442.i4FEgkjY001401@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@muc.de
Subject: Re: [PATCH][3/7] perfctr-2.7.2 for 2.6.6-mm2: x86_64
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004 17:14:43 +0200, Andi Kleen wrote:
>Mikael Pettersson <mikpe@csd.uu.se> writes:
>
>Before merging all that I would definitely recommend some generic
>module to allocate performance counters. IBM had a patch for this
>long ago, and it is even more needed now.

No. Managing the mapping to physical counters can and should be
done in user-space. Due to hardware irregularities, user-space
needs the ability to control the mapping. Due to the low-overhead
user-space sampling code, user-space needs the ability to read
the mapping. None of this is a kernel-level problem -- user-space
already does all of this.

Computing the mapping in the kernel would need lots of code, unless
it cheats like oprofile does on the P4 and hides most counters.
Neither hiding counters nor computing imperfect mappings is acceptable.

>> diff -ruN linux-2.6.6-mm2/drivers/perfctr/x86_64.c linux-2.6.6-mm2.perfctr-2.7.2.x86_64/drivers/perfctr/x86_64.c
>> --- linux-2.6.6-mm2/drivers/perfctr/x86_64.c	1970-01-01 01:00:00.000000000 +0100
>> +++ linux-2.6.6-mm2.perfctr-2.7.2.x86_64/drivers/perfctr/x86_64.c	2004-05-14 14:45:43.990230001 +0200
>> @@ -0,0 +1,660 @@
>> +/* $Id: x86_64.c,v 1.27 2004/05/13 23:32:50 mikpe Exp $
>> + * x86_64 performance-monitoring counters driver.
>
>[...]
>
>Can't you share most/all of that file with i386 ? 
>You'll want that definitely once you support Intel CPUs too, 
>and you have to do that eventually.
>
>Same for include/asm-x86_64/perfctr.h

Yes, that's on my TODO list. x86_64 started as a separate file because
it was so much simpler than x86. Now that Intel will do a P4-like
64-bitter, it makes sense to merge.

>+struct per_cpu_cache {	/* roughly a subset of perfctr_cpu_state */
>+	union {
>+		unsigned int id;	/* cache owner id */
>+	} k1;
>+	struct {
>+		/* NOTE: these caches have physical indices, not virtual */
>+		unsigned int evntsel[4];
>+	} control;
>+} ____cacheline_aligned;
>+static struct per_cpu_cache per_cpu_cache[NR_CPUS] __cacheline_aligned;
>
>This should use per_cpu_data

Yes. per_cpu() doesn't (or at least didn't originally) work in modules,
I just forgot to change this when I removed modular support.

>+static unsigned int new_id(void)
>
>[...]
>
>Why can't that wrap? Maybe it should use the functions in lib/idr.c ?

idr.c didn't exist when this was written. The driver doesn't
release ids because the ids propagate from the high-level driver's
state to any number of per-cpu caches -- and way back it also
propagated to child processes but that's no longer the case.

I will change things so that the high-level drivers are required
to invoke the low-level driver before the control state dies.
This allows the low-level driver to release the cache id.

>+	if( perfctr_cstatus_has_tsc(cstatus) )
>+		rdtscl(ctrs->tsc);
>+	nrctrs = perfctr_cstatus_nractrs(cstatus);
>+	for(i = 0; i < nrctrs; ++i) {
>+		unsigned int pmc = state->pmc[i].map;
>+		rdpmc_low(pmc, ctrs->pmc[i]);
>+	}
>
>K8 has speculative rdtsc. Most likely you want a sync_core() somewhere
>in there.

What's the cost for sync_core()? The counts don't have to be
perfect.

>The way you set your brackets is weird.

I have an old habit of spacing the parens in conditionals so
as to make the conditional expression more visible. I can
change that; I know it looks awkward to other people.

>Why do you check for K8 C stepping? I don't see any code that
>does anything special with that.

Old API mistake. The previous APIs placed the burden of CPU
detection on the driver not user-space (it's exported via the
perfctr_info stuff), but this is broken and wrong. I wasn't
able to change that previously for compatibility reasons, but
with a new API (however it will turn out to be) there will
have to be a new user-space library, so this is no longer
a problem. Thanks for reminding me.

/Mikael

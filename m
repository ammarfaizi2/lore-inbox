Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTEVI1W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 04:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTEVI1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 04:27:22 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:37614 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S262598AbTEVI1V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 04:27:21 -0400
From: Rusty Russell <rusty@au1.ibm.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, David Mosberger-Tang <davidm@hpl.hp.com>
Subject: Re: [PATCH 4/3] Replace dynamic percpu implementation 
In-reply-to: Your message of "Thu, 22 May 2003 13:44:23 +0530."
             <20030522081423.GC27614@in.ibm.com> 
Date: Thu, 22 May 2003 18:36:31 +1000
Message-Id: <20030522083948.C7F4317DE5@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030522081423.GC27614@in.ibm.com> you write:
> 4. Extra dereferences in alloc_percpu were not significant, but alloc_percpu
>    was interlaced and kmalloc_percpu_new wasn't.  Insn profile seemed to
>    indicate extra cost in memory dereferencing of alloc_percpu was
>    offset by the interlacing/objects sharing the same cacheline part.
>    but then insn profiles are only indicative...not accurate.

Interesting: personally I consider the cacheline sharing a feature,
and unless you've done something special, the static declaration
should be interlaced too, no?

If you don't want interlaced, you should make your type
____cacheline_aligned for alloc_percpu, or use

	__alloc_percpu(ALIGN(sizeof(x), SMP_CACHE_BYTES), SMP_CACHE_BYTES)

Aside: if kmalloc_percpu uses the per-cpu offset too, it probably
makes sense to make the per-cpu offset to a first class citizen, and
smp_processor_id to be derived, rather than the other way around as at
the moment.  This would offer further speedup by removing a level of
indirection.

If you're interested I can probably produce such a patch for x86...

Thanks for the results!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

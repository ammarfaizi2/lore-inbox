Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbTECEdx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 00:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263257AbTECEdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 00:33:52 -0400
Received: from dp.samba.org ([66.70.73.150]:60602 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263253AbTECEdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 00:33:51 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: davidm@hpl.hp.com
Subject: Re: [PATCH] per-cpu change 
Cc: linux-kernel@vger.kernel.org
In-reply-to: Your message of "Fri, 02 May 2003 09:51:30 MST."
             <16050.41490.798865.517036@napali.hpl.hp.com> 
Date: Sat, 03 May 2003 14:40:57 +1000
Message-Id: <20030503044617.DE0642C003@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <16050.41490.798865.517036@napali.hpl.hp.com> you write:
>  - On NUMA, you want to allocate the per-CPU areas in node-local memory.

Thanks: I'd forgotten about this.  Even "big smp" machines often have
different memory latencies.

I need to allow archs to override the core allocation.

>  - It's important to initialize the per-CPU area early enough.  We
>    currently do it in cpu_init().  Anything later would probably break
>    things.

Yep, I imagine you'd explicitly call setup_per_cpu_areas() in
cpu_init.  (the later call will do nothing).

> I am a little concerned with supporting per-CPU storage in modules.
> What happens if the per-CPU area fills up?  With the normal kernel,
> you'll get a link-time error, but with modules, you won't know until
> you try to insert a module.

Yes.  In fact, you get a boot error not a link error in my
implementation.

My previous implementation used a linked-list of memory chunks, like
so:

	Core kernel percpu	First dynamic percpu     Second dynamic percpu
	+----+----+---...-+  -> +----+----+---...-+  -> +----+----+---...-+ ->
	 CPU0 CPU1 CPU2...

You can then use the same __per_cpu_offset[], as the spacing between
each cpu's variables in the dynamically allocated sections is the same
as in the core kernel.  You can __alloc_percpu any size up to the
initial inter-cpu spacing (which was equal to the initial amount of
static per-cpu data, or 4k, whatever is more).

But if the cpu's variables are not consecutive (ie your NUMA point),
this scheme breaks down: you'd need to allocate areas with the same
spacing between them, which won't happen.

So I think the current, simpler choice is preferable.

> But the alternative of using something similar to the user-level TLS
> model doesn't look exactly attractive either.

Yes, I spoke with Alan Modra about what he had to do on PPC64, and ran
screaming.  We can live with more constraints, in the kernel, I think,
especially when the result is so fast and simple.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

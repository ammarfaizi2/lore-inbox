Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbUBBLMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 06:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265353AbUBBLMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 06:12:12 -0500
Received: from dp.samba.org ([66.70.73.150]:18625 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265350AbUBBLML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 06:12:11 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: [PATCH 1/4] 2.6.2-rc2-mm2 CPU Hotplug: cpu_active_map 
In-reply-to: Your message of "Mon, 02 Feb 2004 11:08:27 BST."
             <20040202100827.GA28870@elte.hu> 
Date: Mon, 02 Feb 2004 22:08:44 +1100
Message-Id: <20040202111224.D7A172C26C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040202100827.GA28870@elte.hu> you write:
> 
> * Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > D: When CPUs are going down, there is a time when cpu_online(cpu) is
> > D: false, but they are still scheduling and responding to interrupts
> > D: (we are migrating things off the CPU, shutting down per-cpu
> > D: threads, etc).  It turns out that RCU cares about these CPUs, so
> > D: the decision was made to expose this mask (previously internal to x86,
> > D: and only used for IPIs).
> 
> these kinds of problems could be avoided by making the CPU-off as much
> of an atomic operation as possible. The less atomic it is, the more
> kernel code is exposed to the transitional state - and since this is a
> rare situation it will always have quality problems. Is there any killer
> argument that makes it impossible to down a CPU atomically? Kernel
> threads can get their callbacks on other CPUs just fine.

Well, we could grab control of the machine, unconditionally move all
the threads and kill the cpu.

We'd need a lot of locks, but we could just use a bogolock (a-la
module.c's schedule a thread per cpu and tell them all to disable
interrupts) which has the same effect of grabbing every spinlock.

It means that kernel threads must not use smp_processor_id(), because
it might change under them (get_cpu() would protect from this).  You'd
still need explicit shutdown code.

> Other tasks should not care. If the migrate-off operation is done
> 100% atomically then zero knowledge is needed by unrelated scheduler
> code about the act of disabling a CPU.

No, migration code still needs to check the cpu is still up after
you've slept.

I'll sleep on it and see if it still sounds like a good idea in the
morning 8)
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

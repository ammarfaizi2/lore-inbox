Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269196AbUINH45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269196AbUINH45 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 03:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269192AbUINHz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 03:55:58 -0400
Received: from holomorphy.com ([207.189.100.168]:54161 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269191AbUINHzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 03:55:48 -0400
Date: Tue, 14 Sep 2004 00:55:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: raybry@sgi.com, jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914075544.GI9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914044748.GZ9106@holomorphy.com> <20040913220521.03d0e539.akpm@osdl.org> <20040914052118.GA9106@holomorphy.com> <20040914064325.GG9106@holomorphy.com> <20040913235225.0fb6039b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913235225.0fb6039b.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
[...]

On Mon, Sep 13, 2004 at 11:52:25PM -0700, Andrew Morton wrote:
> A few comments which describe the design would be nice...

Okay, I'll add a few in another update. I suppose what's going on may
not be as obvious to everyone else even with the code in hand.


On Mon, Sep 13, 2004 at 11:52:25PM -0700, Andrew Morton wrote:
>>  +	local_irq_save(flags);
>>  +	per_cpu(cpu_profile_flip, cpu) = !per_cpu(cpu_profile_flip, cpu);
>>  +	local_irq_restore(flags);
>>  +	put_cpu();
>>  +}

On Mon, Sep 13, 2004 at 11:52:25PM -0700, Andrew Morton wrote:
> hm.  Does an IPI handler need to disable local IRQs?

It's for exclusion from the timer interrupt. It looks like ia32 enters
the calls with interrupts disabled, so it's probably safe to assume
it's called with disabled interrupts for all architectures (or what
architectures don't are broken by other callers elsewhere). I'll send
out an update with the explicit interrupt disablement removed.


William Lee Irwin III <wli@holomorphy.com> wrote:
>>  +	down(&profile_flip_mutex);
>>  +	j = per_cpu(cpu_profile_flip, smp_processor_id());

On Mon, Sep 13, 2004 at 11:52:25PM -0700, Andrew Morton wrote:
> Is this preempt-safe?

Yes. It's irrelevant which cpu's cpu_profile_flip is sampled. But
it's not cpu hotplug -safe, as the cpu may be offlined and the per-cpu
storage freed in the duration between calling smp_processor_id()
and dereferencing the offset from the start of the per-cpu area.
Disabling preemption while it's being sampled (no longer than that is
necessary) would repair it for cpu hotplug, as it would then have a
valid cpu (the one on which it's executing) while the flip state is
being sampled (it can't change because we own the semaphore, and won't
vary by cpu unless the on_each_cpu() is in flight, but we have to have
a valid cpu number to sample it). The cpucontrol semaphore would
be excessively heavyweight and we'd either have to conditionally
compile out the native semaphore for the cpu hotplug case or otherwise
acquire two semaphores in succession.

This raises an interesting question of how on earth for_each_online_cpu()
is handled by cpu hotplug, but I don't feel responsible for answering it.

So, my preferred fix is the following, with which I'll send out an
updated patch if everyone agrees:

Index: mm5-2.6.9-rc1/kernel/profile.c
===================================================================
--- mm5-2.6.9-rc1.orig/kernel/profile.c	2004-09-13 23:12:27.574463744 -0700
+++ mm5-2.6.9-rc1/kernel/profile.c	2004-09-14 00:10:29.820081944 -0700
@@ -209,7 +209,8 @@
 	int i, j, cpu;
 
 	down(&profile_flip_mutex);
-	j = per_cpu(cpu_profile_flip, smp_processor_id());
+	j = per_cpu(cpu_profile_flip, get_cpu());
+	put_cpu();
 	on_each_cpu(__profile_flip_buffers, NULL, 0, 1);
 	for_each_online_cpu(cpu) {
 		struct profile_hit *hits = per_cpu(cpu_profile_hits, cpu)[j];

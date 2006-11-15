Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966634AbWKOEm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966634AbWKOEm1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966635AbWKOEm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:42:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:44461 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S966634AbWKOEm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:42:26 -0500
From: Andi Kleen <ak@suse.de>
To: Suleiman Souhlal <ssouhlal@freebsd.org>
Subject: Re: [PATCH 1/1] Make the TSC safe to be used by gettimeofday().
Date: Wed, 15 Nov 2006 05:42:14 +0100
User-Agent: KMail/1.9.5
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Jiri Bohac <jbohac@suse.cz>
References: <455A512F.6030907@FreeBSD.org> <455A52E9.9030505@FreeBSD.org>
In-Reply-To: <455A52E9.9030505@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611150542.14239.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 00:36, Suleiman Souhlal wrote:
> This is done by a per-cpu vxtime structure that stores the last TSC and HPET
> values.
> 
> Whenever we switch to a userland process after a HLT instruction has been
> executed or after the CPU frequency has changed, we force a new read of the
> TSC, HPET and xtime so that we know the correct frequency we have to deal
> with.
> 
> We also force a resynch once every second, on every CPU.

Hmm, not sure we want to do it this way. Especially since you
got unsolved races. But patch review ignoring the 10k foot picture again.


>  static void default_idle(void)
>  {
> +	int cpu;
> +
> +	cpu = smp_processor_id();
> +


This is not used? 

> +
> +	/*
> +	 * If we are switching away from a process in vsyscall, touch
> +	 * the vxtime seq lock so that userland is aware that a context switch
> +	 * has happened.
> +	 */
> +	rip = *(unsigned long *)(prev->rsp0 +
> +	    offsetof(struct user_regs_struct, rip) - sizeof(struct pt_regs));
> +	if (unlikely(rip > VSYSCALL_START) && unlikely(rip < VSYSCALL_END)) {
> +		write_seqlock(&vxtime.vx_seq);
> +		write_sequnlock(&vxtime.vx_seq);
> +	}
> +

Can't this starve? If a process is unlucky enough (e.g. from 
lots of interrupts) that it can't go through the vsyscall without at 
least one context switch it will never finish. Ok maybe it's an 
unlikely enough livelock, but it still makes me uncomfortable.

unlikely should be normally top level in the condition.

It would need to be rip >= 

There's a macro to hide the rip lookup


> @@ -135,9 +138,11 @@ void do_gettimeofday(struct timeval *tv)
>  		   be found. Note when you fix it here you need to do the same
>  		   in arch/x86_64/kernel/vsyscall.c and export all needed
>  		   variables in vmlinux.lds. -AK */ 
> -		usec += do_gettimeoffset();
> -
> -	} while (read_seqretry(&xtime_lock, seq));
> +		rdtscll(t);

Not calling do_gettimeoffset anymore?

This means notsc won't work anymore. And the CPUID sync is also gone

>  
> -  .vxtime : AT(VLOAD(.vxtime)) { *(.vxtime) }
> -  vxtime = VVIRT(.vxtime);
> -
>    .vgetcpu_mode : AT(VLOAD(.vgetcpu_mode)) { *(.vgetcpu_mode) }
>    vgetcpu_mode = VVIRT(.vgetcpu_mode);
>  
> @@ -119,6 +116,9 @@ #define VVIRT(x) (ADDR(x) - VVIRT_OFFSET
>    .vsyscall_2 ADDR(.vsyscall_0) + 2048: AT(VLOAD(.vsyscall_2)) { *(.vsyscall_2) }
>    .vsyscall_3 ADDR(.vsyscall_0) + 3072: AT(VLOAD(.vsyscall_3)) { *(.vsyscall_3) }
>  
> +  .vxtime : AT(VLOAD(.vxtime)) { *(.vxtime) }
> +  vxtime = VVIRT(.vxtime);

Why did you move it?

> +long vgetcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache);

externs in c code are still forbidden, even if they don't have
extern


>  static __always_inline void do_vgettimeofday(struct timeval * tv)

Has similar problems are the in kernel gtod

> +static int vxtime_periodic(void *arg)
> +{
> +	while (1) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(msecs_to_jiffies(1000));
> +
> +		smp_call_function(_vxtime_update_pcpu, NULL, 1, 1);
> +		_vxtime_update_pcpu(NULL);
> +	}
> +
> +	return (0); /* NOTREACHED */

I don't see why this should be a thread and not a timer? Threads
are expensive and there are already too many


> +
> +static __init int vxtime_init_pcpu(void)
> +{
> +	seqlock_init(&vxtime.vx_seq);
> +
> +	/*
> +	 * Don't bother updating the per-cpu data after each HLT
> +	 * if we don't need to.
> +	 */
> +	if (!unsynchronized_tsc())

So why did you drop the __cpuinit for unsynchronized_tsc if it's only
called from __init?

-Andi

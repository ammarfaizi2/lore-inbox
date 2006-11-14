Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933052AbWKNCFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933052AbWKNCFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 21:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933068AbWKNCFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 21:05:07 -0500
Received: from mail.suse.de ([195.135.220.2]:47531 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933052AbWKNCFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 21:05:05 -0500
From: Andi Kleen <ak@suse.de>
To: Suleiman Souhlal <ssouhlal@freebsd.org>
Subject: Re: [PATCH 1/2] Make the TSC safe to be used by gettimeofday().
Date: Tue, 14 Nov 2006 03:05:00 +0100
User-Agent: KMail/1.9.5
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Jiri Bohac <jbohac@suse.cz>
References: <455916A5.2030402@FreeBSD.org> <45591706.3030106@FreeBSD.org>
In-Reply-To: <45591706.3030106@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611140305.00383.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 November 2006 02:08, Suleiman Souhlal wrote:
> This is done by a per-cpu vxtime structure that stores the last TSC and HPET
> values.
> 
> Whenever we switch to a userland process after a HLT instruction has been
> executed or after the CPU frequency has changed, we force a new read of the
> TSC, HPET and xtime so that we know the correct frequency we have to deal
> with.

Hmm, interesting approach. 

> 
> With this, we can safely use RDTSC in gettimeofday() in CPUs where the
> TSCs are not synchronized, such as Opterons, instead of doing a very expensive
> HPET read.

> +	cpu = hard_smp_processor_id();

Why not smp_processor_id ? 


> +
> +	apicid = hard_smp_processor_id();

The apicid <-> linux cpuid mapping should be 1:1 so i don't know
why you do this separately. All the uses of hard_smp_processor_id
are bogus.

> +
> +	/*
> +	 * We will need to also do this when switching to kernel tasks if we
> +	 * want to use the per-cpu monotonic_clock in the kernel
> +	 */
> +	if (vxtime.pcpu[apicid].need_update == 1 && next_p->mm != NULL)
> +		vxtime_update_pcpu();

Why? It should be really only needed on HLT/cpufreq change, or?

Anyways, I'm not very fond of adding code to the context switch critical
path.


>  		seq = read_seqbegin(&xtime_lock);
> +		preempt_disable();
> +		cpu = hard_smp_processor_id();

Again, shouldn't use hard

>  
> -		sec = xtime.tv_sec;
> -		usec = xtime.tv_nsec / NSEC_PER_USEC;
> +		sec = vxtime.pcpu[cpu].tv_sec;
> +		usec = vxtime.pcpu[cpu].tv_usec;
>  
>  		/* i386 does some correction here to keep the clock 
>  		   monotonous even when ntpd is fixing drift.
> @@ -135,9 +138,13 @@ void do_gettimeofday(struct timeval *tv)
>  		   be found. Note when you fix it here you need to do the same
>  		   in arch/x86_64/kernel/vsyscall.c and export all needed
>  		   variables in vmlinux.lds. -AK */ 
> -		usec += do_gettimeoffset();
> +		t = get_cycles_sync();
> +		x = (((t - vxtime.pcpu[cpu].last_tsc) *
> +		    vxtime.pcpu[cpu].tsc_nsquot) >> NS_SCALE) / NSEC_PER_USEC;
> +		usec += x;
>  
>  	} while (read_seqretry(&xtime_lock, seq));
> +	preempt_enable();

If it can be implemented without races in user space, why does
it need preempt disable in kernel space?

The faster way to access all the vxtime code would be to stick
a pointer to the per CPU vxtime data into the PDA


> +#define NSEC_PER_TICK (NSEC_PER_SEC / HZ)
> +extern unsigned long hpet_tick;
> +
> +extern unsigned long vxtime_hz;

No externs in .c files. Happened earlier too I think

> +
>  static __always_inline void timeval_normalize(struct timeval * tv)
>  {
>  	time_t __sec;
> @@ -57,35 +67,107 @@ static __always_inline void timeval_norm
>  	}
>  }
>  
> +inline int apicid(void)
> +{
> +	int cpu;
> +
> +	__asm __volatile("cpuid" : "=b" (cpu) : "a" (1) : "cx", "dx");
> +	return (cpu >> 24);

The faster way to do this is to use LSL from a magic GDT entry.

> +}
> +
>  static __always_inline void do_vgettimeofday(struct timeval * tv)
>  {
>  	long sequence, t;
>  	unsigned long sec, usec;
> +	int cpu;
>  
>  	do {
>  		sequence = read_seqbegin(&__xtime_lock);
> -		
> -		sec = __xtime.tv_sec;
> -		usec = __xtime.tv_nsec / 1000;
> -
> -		if (__vxtime.mode != VXTIME_HPET) {
> -			t = get_cycles_sync();
> -			if (t < __vxtime.last_tsc)
> -				t = __vxtime.last_tsc;
> -			usec += ((t - __vxtime.last_tsc) *
> -				 __vxtime.tsc_quot) >> 32;
> -			/* See comment in x86_64 do_gettimeofday. */
> -		} else {
> -			usec += ((readl((void __iomem *)
> -				   fix_to_virt(VSYSCALL_HPET) + 0xf0) -
> -				  __vxtime.last) * __vxtime.quot) >> 32;
> -		}
> -	} while (read_seqretry(&__xtime_lock, sequence));
> +		cpu = apicid();
> +
> +		sec = __vxtime.pcpu[cpu].tv_sec;
> +		usec = __vxtime.pcpu[cpu].tv_usec;
> +		rdtscll(t);
> +
> +		usec += (((t - __vxtime.pcpu[cpu].last_tsc) *
> +		    __vxtime.pcpu[cpu].tsc_nsquot) >> NS_SCALE) / NSEC_PER_USEC;
> +	} while (read_seqretry(&__xtime_lock, sequence) || apicid() != cpu);

Hmm, isn't there still a (unlikely, but possible) race: 

         CPU #0                          CPU #1
         read cpu number
 	 switch to CPU #1
                                         read TSC 
                                         switch back to CPU #0
         check cpu number
         check succeeds, but you got wrong TSC data

How do you prevent that? I suppose you could force the seqlock to retry
in this case in the context switch, but I don't think you do that? 

Also I'm not sure what your context switch code is good for.

-Andi

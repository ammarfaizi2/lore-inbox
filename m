Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277758AbRJIPM6>; Tue, 9 Oct 2001 11:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277755AbRJIPMt>; Tue, 9 Oct 2001 11:12:49 -0400
Received: from yktgi01e0-s1.watson.ibm.com ([198.81.209.16]:28604 "HELO
	ssm22.watson.ibm.com") by vger.kernel.org with SMTP
	id <S277767AbRJIPMh>; Tue, 9 Oct 2001 11:12:37 -0400
Date: Tue, 9 Oct 2001 09:12:22 -0400
From: Hubertus Franke <frankeh@watson.ibm.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] Race between init_idle and reschedule_idle
Message-ID: <20011009091222.A4644@watson.ibm.com>
In-Reply-To: <1076429074.1001803809@[10.10.1.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <1076429074.1001803809@[10.10.1.2]>; from Martin J. Bligh on Sat, Sep 29, 2001 at 10:50:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin J. Bligh <Martin.Bligh@us.ibm.com> [20010930 01;50]:"
> On an SMP system, if the boot cpu calls reschedule_idle before the
> secondary cpus have all called init_idle, we hit the following code
> in reschedule_idle:
> 
> ...
>     for (i = 0; i < smp_num_cpus; i++) {
>         cpu = cpu_logical_map(i);
>         if (!can_schedule(p, cpu))
>             continue;
>         tsk = cpu_curr(cpu);
> ...
> 
> Because init_idle hasn't run for all cpus yet, the expression 
> "cpu_curr(cpu)"
> gives us NULL. When we derefernce an offset of 0x50 off tsk a few
> nanoseconds later we panic, complaining vaddr 0x00000050 is invalid.
> 
> This is more likely to happen on larger systems, but could happen on any
> SMP system (especially if I enable serial console, which really slows down
> the secondary procs doing printk ;-) ). If you want to see the panic / 
> analysis,
> I can send it.
> 
> Thanks to Alan Cox & Andrew Morton for showing me how to serialise the
> cpus to make the panic legible. The following patch holds back the boot
> cpu at the end of smp_init until all the secondarys have done init_idle:
> 

martin, we experienced the same problem way back when we brought our
Fujitsu based Numa machine up. We also experience the problem with 
our cpu pooling and load balancing approach. I think the ksoftirq might
have similar problems.
We solved it in a similar fashion, through counters.
I strongly suggest to put this code into the main track.

-- Hubertus

> --- virgin-2.4.10/kernel/sched.c	Mon Sep 17 23:03:09 2001
> +++ linux-2.4.10/kernel/sched.c	Sat Sep 29 19:57:10 2001
> @@ -1309,6 +1309,8 @@
>  	atomic_inc(&current->files->count);
>  }
> 
> +extern volatile unsigned long wait_init_idle;
> +
>  void __init init_idle(void)
>  {
>  	struct schedule_data * sched_data;
> @@ -1321,6 +1323,7 @@
>  	}
>  	sched_data->curr = current;
>  	sched_data->last_schedule = get_cycles();
> +	clear_bit(current->processor, &wait_init_idle);
>  }
> 
>  extern void init_timervecs (void);
> --- virgin-2.4.10/init/main.c	Thu Sep 20 21:02:01 2001
> +++ linux-2.4.10/init/main.c	Sat Sep 29 21:11:52 2001
> @@ -477,6 +477,8 @@
>  extern void setup_arch(char **);
>  extern void cpu_idle(void);
> 
> +volatile unsigned long wait_init_idle = 0UL;
> +
>  #ifndef CONFIG_SMP
> 
>  #ifdef CONFIG_X86_IO_APIC
> @@ -490,13 +492,25 @@
> 
>  #else
> 
> +
>  /* Called by boot processor to activate the rest. */
>  static void __init smp_init(void)
>  {
>  	/* Get other processors into their bootup holding patterns. */
>  	smp_boot_cpus();
> +	wait_init_idle = cpu_online_map;
> +	clear_bit(current->processor, &wait_init_idle); /* Don't wait on me! */
> +	printk("Waiting on wait_init_idle (map = 0x%lx)\n", wait_init_idle);
>  	smp_threads_ready=1;
>  	smp_commence();
> +
> +	/* Wait for the other cpus to set up their idle processes */
> +        while (1) {
> +                if (!wait_init_idle)
> +                        break;
> +                rep_nop();
> +        }
> +	printk("All processors have done init_idle\n");
>  }		
> 
>  #endif
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

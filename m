Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276545AbRJBSoK>; Tue, 2 Oct 2001 14:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276532AbRJBSoA>; Tue, 2 Oct 2001 14:44:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41211 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S276548AbRJBSn5>; Tue, 2 Oct 2001 14:43:57 -0400
Message-ID: <3BBA0AB4.3B85028B@mvista.com>
Date: Tue, 02 Oct 2001 11:43:00 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] Race between init_idle and reschedule_idle
In-Reply-To: <1076429074.1001803809@[10.10.1.2]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
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

Isn't the real problem that smp_num_cpus is pushed prior to the cpus
idle task being set up.  How about a solution that only pushs
smp_num_cpus AFTER the idle task is up?

George

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
> --- virgin-2.4.10/kernel/sched.c        Mon Sep 17 23:03:09 2001
> +++ linux-2.4.10/kernel/sched.c Sat Sep 29 19:57:10 2001
> @@ -1309,6 +1309,8 @@
>         atomic_inc(&current->files->count);
>  }
> 
> +extern volatile unsigned long wait_init_idle;
> +
>  void __init init_idle(void)
>  {
>         struct schedule_data * sched_data;
> @@ -1321,6 +1323,7 @@
>         }
>         sched_data->curr = current;
>         sched_data->last_schedule = get_cycles();
> +       clear_bit(current->processor, &wait_init_idle);
>  }
> 
>  extern void init_timervecs (void);
> --- virgin-2.4.10/init/main.c   Thu Sep 20 21:02:01 2001
> +++ linux-2.4.10/init/main.c    Sat Sep 29 21:11:52 2001
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
>         /* Get other processors into their bootup holding patterns. */
>         smp_boot_cpus();
> +       wait_init_idle = cpu_online_map;
> +       clear_bit(current->processor, &wait_init_idle); /* Don't wait on me! */
> +       printk("Waiting on wait_init_idle (map = 0x%lx)\n", wait_init_idle);
>         smp_threads_ready=1;
>         smp_commence();
> +
> +       /* Wait for the other cpus to set up their idle processes */
> +        while (1) {
> +                if (!wait_init_idle)
> +                        break;
> +                rep_nop();
> +        }
> +       printk("All processors have done init_idle\n");
>  }
> 
>  #endif
>

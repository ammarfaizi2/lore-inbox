Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283966AbRLAHMG>; Sat, 1 Dec 2001 02:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283969AbRLAHL5>; Sat, 1 Dec 2001 02:11:57 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:48635 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S283966AbRLAHLn>; Sat, 1 Dec 2001 02:11:43 -0500
Message-ID: <3C08828A.8CFA0670@mvista.com>
Date: Fri, 30 Nov 2001 23:11:06 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: NMI is broken!
In-Reply-To: <3C074D02.83836A9A@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> It appears that the NMI generation set up code is NOT correctly setting
> up the system to generate NMIs if the interrupt system is off!  Kernel
> version 2.4.2 NMI worked correctly, 2.4.7 and later do not.  I have not
> tested kernels 2.4.3 thru 2.4.6.  If the interrupt system is on, NMIs
> are being correctly generated.

Oops!  I did it!  It appears that PIT interrupt requests are somehow
involved in the NMI generation.  Since the high-res-timers patch
programs the PIT to interrupt once at the end of each PIT interrupt, it
stops interrupting if the interrupt system is off.  At least this
appears to be the problem.  Now if someone could explain just how this
is done, or at least point me to the the appropriate documentation...

So, sorry for the noise, but still, I think the patch below is a good
thing(tm).

George

> 
> IMHO the check_nmi_watchdog() test is flawed in that it explicitly
> enables interrupts prior to the test.  Below is a patch to fix this
> issue.  When this patch is applied to the 2.4.2 kernel, the test works
> correctly, however, 2.4.7 and above all report "NMI appears to be
> stuck".  (Note, the check_nmi_watchdog() code is in io_apic.c in the
> 2.4.2 kernel and is called "nmi_irq_works()".)
> 
> Note that this is not just a testing issue, NMI is no longer pulling the
> system out of deadlocks with any of the irq spinlocks.
> 
> I am afraid that I don't know enough or have the right documentation to
> figure out what changed, but it appears that the change was about the
> same time that the nmi.c module was introduced.
> 
> Here is the recommended patch for nmi.c:
> 
> --- linux-2.4.13-org/arch/i386/kernel/nmi.c     Tue Sep 25 00:34:57 2001
> +++ linux/arch/i386/kernel/nmi.c        Fri Nov 30 00:31:03 2001
> @@ -46,28 +54,30 @@
>  int __init check_nmi_watchdog (void)
>  {
>         irq_cpustat_t tmp[NR_CPUS];
> -       int j, cpu;
> +       int j, cpu, err = 0;
> 
>         printk(KERN_INFO "testing NMI watchdog ... ");
> 
>         memcpy(tmp, irq_stat, sizeof(tmp));
> -       sti();
> +       cli();
>         mdelay((10*1000)/nmi_hz); // wait 10 ticks
> 
>         for (j = 0; j < smp_num_cpus; j++) {
>                 cpu = cpu_logical_map(j);
>                 if (nmi_count(cpu) - tmp[cpu].__nmi_count <= 5) {
>                         printk("CPU#%d: NMI appears to be stuck!\n", cpu);
> -                       return -1;
> +                       err = -1;
>                 }
>         }
> -       printk("OK.\n");
> +        if (! err ){
> +                printk("OK.\n");
> +        }
> 
>         /* now that we know it works we can reduce NMI frequency to
>            something more reasonable; makes a difference in some configs */
>         if (nmi_watchdog == NMI_LOCAL_APIC)
>                 nmi_hz = 1;
> -
> +        sti();
>         return 0;
>  }
> 
> 
> --
> George           george@mvista.com
> High-res-timers: http://sourceforge.net/projects/high-res-timers/
> Real time sched: http://sourceforge.net/projects/rtsched/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/

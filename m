Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbSLVJue>; Sun, 22 Dec 2002 04:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbSLVJue>; Sun, 22 Dec 2002 04:50:34 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:41208 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264877AbSLVJub>;
	Sun, 22 Dec 2002 04:50:31 -0500
Message-ID: <3E058CB5.B810FAED@mvista.com>
Date: Sun, 22 Dec 2002 01:58:13 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH]Timer list init is done AFTER use
References: <3E02D81F.13A5A59D@mvista.com> <3E02F073.BF57207C@digeo.com> <3E0350CA.6B99F722@mvista.com> <3E0370C1.21909EF5@digeo.com> <3E03772A.D5D85171@mvista.com> <3E0579F8.CF1D94A9@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks ok.  I will give it a spin on Monday.

-g

Andrew Morton wrote:
> 
> george anzinger wrote:
> >
> > ...
> > I am not sure.  The first question is when does the online
> > bit get set for cpu 0.  The next is that it does inhibit a
> > rather large block of printks.  Is this ok?
> >
> 
> The boot cpu is set online extremely late.  Strangely late.  Why
> is this?
> 
> How about something like the below?  We mark the boot cpu
> online in generic code as soon as it has initialised its per-cpu
> storage (seems appropriate?)
> 
> This will then allow that cpu to actually start calling into console
> drivers, if they have been registered.  If those drivers do a mod_timer()
> (as the vga console does) then that will work OK.
> 
> Secondary CPUs also are not marked online until their per-cpu storage is
> initialised, and their notifiers have been called.
> 
> If a non-online cpu calls printk, its output will be buffered.  It will
> be displayed by the next call to printk by an online CPU.
> 
> (The patch needs set_cpu_online()/set_cpu_possible() implementations
> done for the other architectures)
> 
>  arch/i386/kernel/smpboot.c |    5 -----
>  include/asm-i386/smp.h     |   29 +++++++++++++++++++++++------
>  include/linux/smp.h        |    7 ++++++-
>  init/main.c                |    8 ++++++++
>  kernel/printk.c            |    6 +++++-
>  5 files changed, 42 insertions(+), 13 deletions(-)
> 
> --- 25/kernel/printk.c~ga       Sat Dec 21 23:27:08 2002
> +++ 25-akpm/kernel/printk.c     Sat Dec 21 23:27:08 2002
> @@ -43,7 +43,11 @@
>  #define LOG_BUF_MASK   (LOG_BUF_LEN-1)
> 
>  #ifndef arch_consoles_callable
> -#define arch_consoles_callable() (1)
> +/*
> + * Some console drivers may assume that per-cpu resources have been allocated.
> + * So don't allow them to be called by this CPU until it is officially up.
> + */
> +#define arch_consoles_callable() cpu_online(smp_processor_id())
>  #endif
> 
>  /* printk's without a loglevel use this.. */
> --- 25/init/main.c~ga   Sat Dec 21 23:48:03 2002
> +++ 25-akpm/init/main.c Sat Dec 21 23:55:00 2002
> @@ -361,6 +361,14 @@ asmlinkage void __init start_kernel(void
>         printk(linux_banner);
>         setup_arch(&command_line);
>         setup_per_cpu_areas();
> +
> +       /*
> +        * Once the boot CPU's per-cpu memory is set up it may be considered
> +        * online.  This is mainly to turn on printk output.
> +        */
> +       set_cpu_online(smp_processor_id());
> +       set_cpu_possible(smp_processor_id());
> +
>         build_all_zonelists();
>         page_alloc_init();
>         printk("Kernel command line: %s\n", saved_command_line);
> --- 25/include/asm-i386/smp.h~ga        Sat Dec 21 23:49:43 2002
> +++ 25-akpm/include/asm-i386/smp.h      Sat Dec 21 23:54:16 2002
> @@ -80,15 +80,32 @@ extern volatile int logical_apicid_to_cp
> 
>  extern volatile unsigned long cpu_callout_map;
> 
> -#define cpu_possible(cpu) (cpu_callout_map & (1<<(cpu)))
> -#define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
> +static inline int cpu_possible(int cpu)
> +{
> +       return cpu_callout_map & (1 << cpu);
> +}
> +
> +static inline void set_cpu_possible(int cpu)
> +{
> +       cpu_callout_map |= (1 << cpu);
> +}
> +
> +static inline int cpu_online(int cpu)
> +{
> +       return cpu_online_map & (1 << cpu);
> +}
> +
> +static inline void set_cpu_online(int cpu)
> +{
> +       cpu_online_map |= (1 << cpu);
> +}
> 
> -extern inline unsigned int num_online_cpus(void)
> +static inline unsigned int num_online_cpus(void)
>  {
>         return hweight32(cpu_online_map);
>  }
> 
> -extern inline int any_online_cpu(unsigned int mask)
> +static inline int any_online_cpu(unsigned int mask)
>  {
>         if (mask & cpu_online_map)
>                 return __ffs(mask & cpu_online_map);
> @@ -96,13 +113,13 @@ extern inline int any_online_cpu(unsigne
>         return -1;
>  }
> 
> -static __inline int hard_smp_processor_id(void)
> +static inline int hard_smp_processor_id(void)
>  {
>         /* we don't want to mark this access volatile - bad code generation */
>         return GET_APIC_ID(*(unsigned long *)(APIC_BASE+APIC_ID));
>  }
> 
> -static __inline int logical_smp_processor_id(void)
> +static inline int logical_smp_processor_id(void)
>  {
>         /* we don't want to mark this access volatile - bad code generation */
>         return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
> --- 25/arch/i386/kernel/smpboot.c~ga    Sat Dec 21 23:52:51 2002
> +++ 25-akpm/arch/i386/kernel/smpboot.c  Sat Dec 21 23:54:43 2002
> @@ -992,11 +992,6 @@ static void __init smp_boot_cpus(unsigne
>         printk("CPU%d: ", 0);
>         print_cpu_info(&cpu_data[0]);
> 
> -       /*
> -        * We have the boot CPU online for sure.
> -        */
> -       set_bit(0, &cpu_online_map);
> -       set_bit(0, &cpu_callout_map);
>         boot_cpu_logical_apicid = logical_smp_processor_id();
>         map_cpu_to_boot_apicid(0, boot_cpu_apicid);
> 
> --- 25/include/linux/smp.h~ga   Sun Dec 22 00:29:05 2002
> +++ 25-akpm/include/linux/smp.h Sun Dec 22 00:30:15 2002
> @@ -94,7 +94,12 @@ static inline void smp_send_reschedule_a
>  #define cpu_online(cpu)                                ({ BUG_ON((cpu) != 0); 1; })
>  #define num_online_cpus()                      1
>  #define num_booting_cpus()                     1
> -#define cpu_possible(cpu)                              ({ BUG_ON((cpu) != 0); 1; })
> +#define cpu_possible(cpu)                      ({ BUG_ON((cpu) != 0); 1; })
> +static inline void set_cpu_online(int cpu)
> +{}
> +static inline void set_cpu_possible(int cpu)
> +{}
> +
> 
>  struct notifier_block;
> 
> 
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265034AbUFGUWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265034AbUFGUWn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 16:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265035AbUFGUWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 16:22:43 -0400
Received: from web51801.mail.yahoo.com ([206.190.38.232]:43611 "HELO
	web51801.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265034AbUFGUW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 16:22:27 -0400
Message-ID: <20040607195735.46697.qmail@web51801.mail.yahoo.com>
Date: Mon, 7 Jun 2004 12:57:35 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
To: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <200406070139.38433.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

I have had a chance to test this patch.  I have a make
system that has presented 2.6 kernels with problems,
so  I am using this as the test.  Observations show
that turning off interactive is much more
deterministic:

2.6.7-rc2-bk8-s63:
echo 0 > /proc/sys/kernel/interactive

A:  35.57user 38.18system 1:20.28elapsed 91%CPU 
B:  35.54user 38.40system 1:19.48elapsed 93%CPU
C:  35.48user 38.28system 1:20.94elapsed 91%CPU

2.6.7-rc2-bk8-s63:
A:  35.32user 38.51system 1:26.47elapsed 85%CPU
B:  35.43user 38.35system 1:20.79elapsed 91%CPU
C:  35.61user 38.23system 1:25.00elapsed 86%CPU

However, something is still slower than the 2.4.x
kernels:

2.4.23:
A:  28.32user 29.51system 1:01.17elapsed 93%CPU
B:  28.54user 29.40system 1:01.48elapsed 92%CPU
B:  28.23user 28.80system 1:00.21elapsed 94%CPU

Nice work, as I can now turn off some functionality
within the kernel that is causing me some slow down.

Thanks!
Phy


--- Con Kolivas <kernel@kolivas.org> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This is an update of the scheduler policy mechanism
> rewrite using the 
> infrastructure of the current O(1) scheduler. Slight
> changes from the 
> original design require a detailed description. The
> change to the original 
> design has enabled all known corner cases to be
> abolished and cpu 
> distribution to be much better maintained. It has
> proven to be stable in my 
> testing and is ready for more widespread public
> testing now.
> 
> 
> Aims:
>  - Interactive by design rather than have
> interactivity bolted on.
>  - Good scalability.
>  - Simple predictable design.
>  - Maintain appropriate cpu distribution and
> fairness.
>  - Low scheduling latency for normal policy tasks.
>  - Low overhead.
>  - Making renicing processes actually matter for CPU
> distribution (nice 0 gets 
> 20 times what nice +20 gets)
>  - Resistant to priority inversion
>  - More forgiving of poor locking
>  - Tunable for a server workload or computational
> tasks
> 
> 
> Description:
>  - All tasks start at a dynamic priority based on
> their nice value. They run 
> for one RR_INTERVAL (nominally set to 10ms) and then
> drop one stair 
> (priority). If they sleep before running again they
> get to run for 2 
> intervals before being demoted a priority and so on
> until they get all their 
> intervals at their best priority: 20 intervals for
> nice 0; 1 interval for 
> nice +19.
> 
> 
> - - The staircase elevation mechanism can be
> disabled and all tasks can simply 
> descend stairs using the sysctl:
> 
> echo 0 > /proc/sys/kernel/interactive
> 
> this has the effect of maintaining cpu distribution
> much more strictly 
> according to nice whereas the default mechanism
> allows bursts of cpu by 
> interactive tasks before settling to appropriate cpu
> distribution.
> 
> 
> - - The time tasks are cpu bound can be increased by
> using the sysctl:
> 
> echo 1 > /proc/sys/kernel/compute
> 
> which extends the RR_INTERVAL to 100ms and disables
> the staircase elevation 
> improving conditions for pure computational tasks by
> optimising cache 
> benefits and decreasing context switching (gains
> another 1.5% on kernbench).
> 
> 
> Performance:
> - - All cpu throughput benchmarks show equivalent or
> better performance than 
> mainline. Note that disabling the interactive
> setting actually _worsens_ some 
> benchmarks because of their dependence on yield() so
> I don't recommend 
> disabling it unless you do a comparison first. 
> - - Interactivity is approximately equivalent to
> mainline 2.6 but with faster 
> application startup and no known behavioural quirks.
> 
> 
> Comments and testing welcome.
> 
>  fs/proc/array.c        |    2
>  include/linux/sched.h  |    8
>  include/linux/sysctl.h |    2
>  kernel/sched.c         |  676 
> +++++++++++++------------------------------------
>  kernel/sysctl.c        |   16 +
>  5 files changed, 212 insertions(+), 492
> deletions(-)
> 
> Can be downloaded here:
>
http://ck.kolivas.org/patches/2.6/2.6.7-rc2/patch-2.6.7-rc2-s6.3
> 
> and below
> Con
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> 
>
iD8DBQFAwzquZUg7+tp6mRURArBHAJ9SIBOKX6MYOdkJzdb+xRNnW82JQgCghLou
> wXhrRsBsfY2BIqbLT1tUWcs=
> =g1no
> -----END PGP SIGNATURE-----
> > diff -Naurp --exclude-from=dontdiff
> linux-2.6.7-rc2-base/fs/proc/array.c
> linux-2.6.7-rc2-s6.3/fs/proc/array.c
> --- linux-2.6.7-rc2-base/fs/proc/array.c	2004-05-31
> 21:29:15.000000000 +1000
> +++ linux-2.6.7-rc2-s6.3/fs/proc/array.c	2004-06-07
> 00:03:56.959133536 +1000
> @@ -155,7 +155,6 @@ static inline char *
> task_state(struct t
>  	read_lock(&tasklist_lock);
>  	buffer += sprintf(buffer,
>  		"State:\t%s\n"
> -		"SleepAVG:\t%lu%%\n"
>  		"Tgid:\t%d\n"
>  		"Pid:\t%d\n"
>  		"PPid:\t%d\n"
> @@ -163,7 +162,6 @@ static inline char *
> task_state(struct t
>  		"Uid:\t%d\t%d\t%d\t%d\n"
>  		"Gid:\t%d\t%d\t%d\t%d\n",
>  		get_task_state(p),
> -		(p->sleep_avg/1024)*100/(1020000000/1024),
>  	       	p->tgid,
>  		p->pid, p->pid ? p->real_parent->pid : 0,
>  		p->pid && p->ptrace ? p->parent->pid : 0,
> diff -Naurp --exclude-from=dontdiff
> linux-2.6.7-rc2-base/include/linux/sched.h
> linux-2.6.7-rc2-s6.3/include/linux/sched.h
> --- linux-2.6.7-rc2-base/include/linux/sched.h
> 2004-05-31 21:29:21.000000000 +1000
> +++ linux-2.6.7-rc2-s6.3/include/linux/sched.h
> 2004-06-07 00:10:37.450576503 +1000
> @@ -164,6 +164,7 @@ extern void show_stack(struct
> task_struc
>  
>  void io_schedule(void);
>  long io_schedule_timeout(long timeout);
> +extern int interactive, compute;
>  
>  extern void cpu_init (void);
>  extern void trap_init(void);
> @@ -394,14 +395,13 @@ struct task_struct {
>  	struct list_head run_list;
>  	prio_array_t *array;
>  
> -	unsigned long sleep_avg;
> -	long interactive_credit;
>  	unsigned long long timestamp;
> -	int activated;
> +	unsigned long runtime, totalrun;
> +	unsigned int deadline;
>  
>  	unsigned long policy;
>  	cpumask_t cpus_allowed;
> -	unsigned int time_slice, first_time_slice;
> +	unsigned int slice, time_slice, first_time_slice;
>  
>  	struct list_head tasks;
>  	struct list_head ptrace_children;
> diff -Naurp --exclude-from=dontdiff
> linux-2.6.7-rc2-base/include/linux/sysctl.h
> linux-2.6.7-rc2-s6.3/include/linux/sysctl.h
> --- linux-2.6.7-rc2-base/include/linux/sysctl.h
> 2004-05-31 21:29:21.000000000 +1000
> +++ linux-2.6.7-rc2-s6.3/include/linux/sysctl.h
> 2004-06-07 00:06:13.007895851 +1000
> @@ -133,6 +133,8 @@ enum
>  	KERN_NGROUPS_MAX=63,	/* int: NGROUPS_MAX */
>  	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console
> power-off halt */
>  	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
> +	KERN_INTERACTIVE=66,	/* interactive tasks to have
> cpu bursts */
> +	KERN_COMPUTE=67,	/* adjust timeslices for a
> compute server */
>  };
>  
>  
> diff -Naurp --exclude-from=dontdiff
> linux-2.6.7-rc2-base/kernel/sched.c
> linux-2.6.7-rc2-s6.3/kernel/sched.c
> --- linux-2.6.7-rc2-base/kernel/sched.c	2004-05-31
> 21:29:24.000000000 +1000
> +++ linux-2.6.7-rc2-s6.3/kernel/sched.c	2004-06-07
> 00:36:43.382396246 +1000
> @@ -16,7 +16,10 @@
>   *		by Davide Libenzi, preemptible kernel bits by
> Robert Love.
>   *  2003-09-03	Interactivity tuning by Con Kolivas.
>   *  2004-04-02	Scheduler domains code by Nick
> Piggin
> - */
> + *  2004-03-19.	New staircase scheduling policy by
> Con Kolivas with help
> + *		from Zwane Mwaikambo and useful suggestions by 
> + *		William Lee Irwin III. 
> +*/
>  
>  #include <linux/mm.h>
>  #include <linux/module.h>
> @@ -66,8 +69,6 @@
>  #define USER_PRIO(p)		((p)-MAX_RT_PRIO)
>  #define TASK_USER_PRIO(p)
> USER_PRIO((p)->static_prio)
>  #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
> -#define AVG_TIMESLICE	(MIN_TIMESLICE +
> ((MAX_TIMESLICE - MIN_TIMESLICE) *\
> -			(MAX_PRIO-1-NICE_TO_PRIO(0))/(MAX_USER_PRIO -
> 1)))
>  
>  /*
>   * Some helpers for converting nanosecond timing to
> jiffy resolution
> @@ -75,110 +76,18 @@
>  #define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 /
> HZ))
>  #define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 /
> HZ))
>  
> -/*
> - * These are the 'tuning knobs' of the scheduler:
> - *
> - * Minimum timeslice is 10 msecs, default timeslice
> is 100 msecs,
> - * maximum timeslice is 200 msecs. Timeslices get
> refilled after
> - * they expire.
> - */
> -#define MIN_TIMESLICE		( 10 * HZ / 1000)
> -#define MAX_TIMESLICE		(200 * HZ / 1000)
> -#define ON_RUNQUEUE_WEIGHT	 30
> -#define CHILD_PENALTY		 95
> -#define PARENT_PENALTY		100
> -#define EXIT_WEIGHT		  3
> -#define PRIO_BONUS_RATIO	 25
> -#define MAX_BONUS		(MAX_USER_PRIO *
> PRIO_BONUS_RATIO / 100)
> -#define INTERACTIVE_DELTA	  2
> -#define MAX_SLEEP_AVG		(AVG_TIMESLICE * MAX_BONUS)
> -#define STARVATION_LIMIT	(MAX_SLEEP_AVG)
> -#define NS_MAX_SLEEP_AVG
> (JIFFIES_TO_NS(MAX_SLEEP_AVG))
> -#define CREDIT_LIMIT		100
> -
> -/*
> - * If a task is 'interactive' then we reinsert it
> in the active
> - * array after it has expired its current
> timeslice. (it will not
> - * continue to run immediately, it will still
> roundrobin with
> - * other interactive tasks.)
> - *
> - * This part scales the interactivity limit
> depending on niceness.
> - *
> - * We scale it linearly, offset by the
> INTERACTIVE_DELTA delta.
> - * Here are a few examples of different nice
> levels:
> - *
> - *  TASK_INTERACTIVE(-20): [1,1,1,1,1,1,1,1,1,0,0]
> - *  TASK_INTERACTIVE(-10): [1,1,1,1,1,1,1,0,0,0,0]
> - *  TASK_INTERACTIVE(  0): [1,1,1,1,0,0,0,0,0,0,0]
> - *  TASK_INTERACTIVE( 10): [1,1,0,0,0,0,0,0,0,0,0]
> - *  TASK_INTERACTIVE( 19): [0,0,0,0,0,0,0,0,0,0,0]
> - *
> - * (the X axis represents the possible -5 ... 0 ...
> +5 dynamic
> - *  priority range a task can explore, a value of
> '1' means the
> - *  task is rated interactive.)
> - *
> - * Ie. nice +19 tasks can never get 'interactive'
> enough to be
> - * reinserted into the active array. And only
> heavily CPU-hog nice -20
> - * tasks will be expired. Default nice 0 tasks are
> somewhere between,
> - * it takes some effort for them to get
> interactive, but it's not
> - * too hard.
> - */
> -
> -#define CURRENT_BONUS(p) \
> -	(NS_TO_JIFFIES((p)->sleep_avg) * MAX_BONUS / \
> -		MAX_SLEEP_AVG)
> -
> -#ifdef CONFIG_SMP
> -#define TIMESLICE_GRANULARITY(p)	(MIN_TIMESLICE * \
> -		(1 << (((MAX_BONUS - CURRENT_BONUS(p)) ? : 1) -
> 1)) * \
> -			num_online_cpus())
> -#else
> -#define TIMESLICE_GRANULARITY(p)	(MIN_TIMESLICE * \
> -		(1 << (((MAX_BONUS - CURRENT_BONUS(p)) ? : 1) -
> 1)))
> -#endif
> -
> -#define SCALE(v1,v1_max,v2_max) \
> -	(v1) * (v2_max) / (v1_max)
> 
=== message truncated ===



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 

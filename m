Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262870AbTCSBCY>; Tue, 18 Mar 2003 20:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262875AbTCSBCY>; Tue, 18 Mar 2003 20:02:24 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:7422 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262870AbTCSBCS>;
	Tue, 18 Mar 2003 20:02:18 -0500
Message-ID: <3E77C40D.4090700@mvista.com>
Date: Tue, 18 Mar 2003 17:12:45 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rm <async@cc.gatech.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] limits on SCHED_FIFO tasks
References: <20030318185135.D1361@tokyo.cc.gatech.edu>
In-Reply-To: <20030318185135.D1361@tokyo.cc.gatech.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the issue is regaining control after some RT task goes into a loop, 
the way this is usually done is to keep a session around with a higher 
priority.  Using this concept, one might provide tools that, from 
userland, insure that such a session exists prior to launching the 
"suspect" code.  I fail to see the need for this sort of code in the 
kernel.

-g

rm wrote:
> Hi,
> 
> 	I've included a preliminary proof-of-concept patch to
> 2.4.20(+ll) which allows the superuser to set a limit using sysctl's
> on the number of cpu cycles SCHED_FIFO tasks may use.  (right now,
> uniprocessor only (no APIC), and doesn't handle rollover).
> 
>     rt_period_reserved is the number of jiffies out of every
> rt_period_length jiffies which are available to SCHED_FIFO tasks.  so
> for example 
> 
>     rt_period_length = 50
>     rt_period_reserved = 25
> 
> allows SCHED_FIFO tasks to use half of all available ticks during a 50
> tick period.  setting rt_period_reserved = 50, would allow the current
> behaviour.
> 
> the rationale for this approach is that in audio applications (for
> example), low-latency real-time performance is desired.  this in turn
> means small audio buffers and tight timing constraints to guarantee
> glitch-free audio.  lately, SCHED_FIFO (with low-latency, and
> preemption patches) has been successful used to do this, but one huge
> downside is that if there is a bug in the SCHED_FIFO task, it is very
> easy to completely hang the box. since programmers aren't going to
> suddenly start writing perfect code, this is what i came up with (it's
> similar to what mach's constrained scheduling policy does).  with this
> patch i've been able to keep a console (slowly) interactive using
> 45/50 settings while a SCHED_FIFO task does while(1);.
> 
> in the same vein, allowing a limited amount of memory pinning by
> non-privileged users is the sort of change which audio folks would
> like to see, to make proaudio applications extremely reliable without
> compromising the underlying security of the system.
> 
> i'm interested in hearing folks' thoughts on this.  (please CC replies).
> 
> 			  thanks, 
> 			  rob
> 			  
> --- pristine/linux-2.4.20/kernel/sched.c	2003-03-17 23:24:02.000000000 -0500
> +++ linux/kernel/sched.c	2003-03-18 13:22:38.000000000 -0500
> @@ -43,6 +43,12 @@ extern void immediate_bh(void);
>  
>  unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
>  
> +unsigned long rt_period_start = 0; 
> +unsigned long rt_period_end = 0; 
> +unsigned long rt_period_remain = 0; 
> +unsigned long rt_period_length = 50;
> +unsigned long rt_period_reserved = 45;
> +
>  extern void mem_use(void);
>  
>  /*
> @@ -188,7 +194,35 @@ static inline int goodness(struct task_s
>  	 * runqueue (taking priorities within processes
>  	 * into account).
>  	 */
> +
> +	
> +	
> +	/*
> +	 *   check if we are in the right time period
> +	 *
> +	 *   XXX if it burns though it's entire quantum and
> +	 *       into the next ? 
> +	 *     
> +	 */
> +	if (jiffies >= rt_period_end) { 
> +	  /* no, start over from now */
> +	  rt_period_start = jiffies;
> +	  rt_period_end = rt_period_length + rt_period_start;
> +	  rt_period_remain = rt_period_reserved; 
> +	}
> +	
> +	/*
> +	 *  is there any remaining time ? 
> +	 *  
> +	 */
> +	
> +	if (rt_period_remain > 0) { 
>  	weight = 1000 + p->rt_priority;
> +	}  else { 
> +	  /* redundent, for clarity */
> +	  weight = -1; 
> +	}
> +
>  out:
>  	return weight;
>  }
> --- pristine/linux-2.4.20/kernel/sysctl.c	2003-03-17 23:24:02.000000000 -0500
> +++ linux/kernel/sysctl.c	2003-03-18 13:05:22.000000000 -0500
> @@ -51,6 +51,11 @@ extern int sysrq_enabled;
>  extern int core_uses_pid;
>  extern int cad_pid;
>  
> +
> +extern unsigned long rt_period_length;
> +extern unsigned long rt_period_reserved;
> +
> +
>  /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
>  static int maxolduid = 65535;
>  static int minolduid;
> @@ -260,6 +265,12 @@ static ctl_table kern_table[] = {
>  	{KERN_LOWLATENCY, "lowlatency", &enable_lowlatency, sizeof (int),
>  	 0644, NULL, &proc_dointvec},
>  #endif
> +
> +	{KERN_FIFOSCHED_PERIOD, "rtsched-period", &rt_period_length, 
> +	   sizeof (int), 0644, NULL, &proc_dointvec},
> +	{KERN_FIFOSCHED_RESERV, "rtsched-reserve", 
> +	 &rt_period_reserved, sizeof (int), 0644, NULL, &proc_dointvec},
> +
>  	{0}
>  };
>  
> --- pristine/linux-2.4.20/include/linux/sysctl.h	2003-03-17 23:24:02.000000000 -0500
> +++ linux/include/linux/sysctl.h	2003-03-18 13:03:37.000000000 -0500
> @@ -125,6 +125,8 @@ enum
>  	KERN_TAINTED=53,	/* int: various kernel tainted flags */
>  	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
>  	KERN_LOWLATENCY=55,     /* int: enable low latency scheduling */
> +	KERN_FIFOSCHED_PERIOD=56, /* max time rt processes can take up */
> +	KERN_FIFOSCHED_RESERV=57, /* "" */
>  };
>  
>  
> --- pristine/linux-2.4.20/kernel/timer.c	2002-11-28 18:53:15.000000000 -0500
> +++ linux/kernel/timer.c	2003-03-18 12:41:05.000000000 -0500
> @@ -105,6 +105,16 @@ static struct list_head * run_timer_list
>  
>  #define NOOF_TVECS (sizeof(tvecs) / sizeof(tvecs[0]))
>  
> +extern unsigned long rt_period_start; 
> +extern unsigned long rt_period_end;  
> +extern unsigned long rt_period_remain; 
> +extern unsigned long rt_period_length;
> +extern unsigned long rt_period_reserved;
> +
> +
> +
> +
> +
>  void init_timervecs (void)
>  {
>  	int i;
> @@ -610,6 +620,15 @@ void update_process_times(int user_tick)
>  				p->need_resched = 1;
>  			}
>  		}
> +		
> +		if (p->policy == SCHED_FIFO) { 
> +		  if (rt_period_remain == 0) { 
> +		    p->need_resched = 1;
> +		  } else { 
> +		    rt_period_remain--;
> +		  }
> +		}
> +
>  		if (p->nice > 0)
>  			kstat.per_cpu_nice[cpu] += user_tick;
>  		else
> --------------------- end -----------------------------------------
> 
> ----
> Robert Melby
> Georgia Institute of Technology, Atlanta Georgia, 30332
> uucp:     ...!{decvax,hplabs,ncar,purdue,rutgers}!gatech!prism!gt4255a
> Internet: async@cc.gatech.edu
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


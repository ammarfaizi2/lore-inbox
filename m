Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262845AbTCRXkm>; Tue, 18 Mar 2003 18:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262846AbTCRXkm>; Tue, 18 Mar 2003 18:40:42 -0500
Received: from sark.cc.gatech.edu ([130.207.7.23]:4561 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S262845AbTCRXki>; Tue, 18 Mar 2003 18:40:38 -0500
Date: Tue, 18 Mar 2003 18:51:35 -0500
From: rm <async@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] limits on SCHED_FIFO tasks
Message-ID: <20030318185135.D1361@tokyo.cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I've included a preliminary proof-of-concept patch to
2.4.20(+ll) which allows the superuser to set a limit using sysctl's
on the number of cpu cycles SCHED_FIFO tasks may use.  (right now,
uniprocessor only (no APIC), and doesn't handle rollover).

    rt_period_reserved is the number of jiffies out of every
rt_period_length jiffies which are available to SCHED_FIFO tasks.  so
for example 

    rt_period_length = 50
    rt_period_reserved = 25

allows SCHED_FIFO tasks to use half of all available ticks during a 50
tick period.  setting rt_period_reserved = 50, would allow the current
behaviour.

the rationale for this approach is that in audio applications (for
example), low-latency real-time performance is desired.  this in turn
means small audio buffers and tight timing constraints to guarantee
glitch-free audio.  lately, SCHED_FIFO (with low-latency, and
preemption patches) has been successful used to do this, but one huge
downside is that if there is a bug in the SCHED_FIFO task, it is very
easy to completely hang the box. since programmers aren't going to
suddenly start writing perfect code, this is what i came up with (it's
similar to what mach's constrained scheduling policy does).  with this
patch i've been able to keep a console (slowly) interactive using
45/50 settings while a SCHED_FIFO task does while(1);.

in the same vein, allowing a limited amount of memory pinning by
non-privileged users is the sort of change which audio folks would
like to see, to make proaudio applications extremely reliable without
compromising the underlying security of the system.

i'm interested in hearing folks' thoughts on this.  (please CC replies).

			  thanks, 
			  rob
			  
--- pristine/linux-2.4.20/kernel/sched.c	2003-03-17 23:24:02.000000000 -0500
+++ linux/kernel/sched.c	2003-03-18 13:22:38.000000000 -0500
@@ -43,6 +43,12 @@ extern void immediate_bh(void);
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
 
+unsigned long rt_period_start = 0; 
+unsigned long rt_period_end = 0; 
+unsigned long rt_period_remain = 0; 
+unsigned long rt_period_length = 50;
+unsigned long rt_period_reserved = 45;
+
 extern void mem_use(void);
 
 /*
@@ -188,7 +194,35 @@ static inline int goodness(struct task_s
 	 * runqueue (taking priorities within processes
 	 * into account).
 	 */
+
+	
+	
+	/*
+	 *   check if we are in the right time period
+	 *
+	 *   XXX if it burns though it's entire quantum and
+	 *       into the next ? 
+	 *     
+	 */
+	if (jiffies >= rt_period_end) { 
+	  /* no, start over from now */
+	  rt_period_start = jiffies;
+	  rt_period_end = rt_period_length + rt_period_start;
+	  rt_period_remain = rt_period_reserved; 
+	}
+	
+	/*
+	 *  is there any remaining time ? 
+	 *  
+	 */
+	
+	if (rt_period_remain > 0) { 
 	weight = 1000 + p->rt_priority;
+	}  else { 
+	  /* redundent, for clarity */
+	  weight = -1; 
+	}
+
 out:
 	return weight;
 }
--- pristine/linux-2.4.20/kernel/sysctl.c	2003-03-17 23:24:02.000000000 -0500
+++ linux/kernel/sysctl.c	2003-03-18 13:05:22.000000000 -0500
@@ -51,6 +51,11 @@ extern int sysrq_enabled;
 extern int core_uses_pid;
 extern int cad_pid;
 
+
+extern unsigned long rt_period_length;
+extern unsigned long rt_period_reserved;
+
+
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
@@ -260,6 +265,12 @@ static ctl_table kern_table[] = {
 	{KERN_LOWLATENCY, "lowlatency", &enable_lowlatency, sizeof (int),
 	 0644, NULL, &proc_dointvec},
 #endif
+
+	{KERN_FIFOSCHED_PERIOD, "rtsched-period", &rt_period_length, 
+	   sizeof (int), 0644, NULL, &proc_dointvec},
+	{KERN_FIFOSCHED_RESERV, "rtsched-reserve", 
+	 &rt_period_reserved, sizeof (int), 0644, NULL, &proc_dointvec},
+
 	{0}
 };
 
--- pristine/linux-2.4.20/include/linux/sysctl.h	2003-03-17 23:24:02.000000000 -0500
+++ linux/include/linux/sysctl.h	2003-03-18 13:03:37.000000000 -0500
@@ -125,6 +125,8 @@ enum
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
 	KERN_LOWLATENCY=55,     /* int: enable low latency scheduling */
+	KERN_FIFOSCHED_PERIOD=56, /* max time rt processes can take up */
+	KERN_FIFOSCHED_RESERV=57, /* "" */
 };
 
 
--- pristine/linux-2.4.20/kernel/timer.c	2002-11-28 18:53:15.000000000 -0500
+++ linux/kernel/timer.c	2003-03-18 12:41:05.000000000 -0500
@@ -105,6 +105,16 @@ static struct list_head * run_timer_list
 
 #define NOOF_TVECS (sizeof(tvecs) / sizeof(tvecs[0]))
 
+extern unsigned long rt_period_start; 
+extern unsigned long rt_period_end;  
+extern unsigned long rt_period_remain; 
+extern unsigned long rt_period_length;
+extern unsigned long rt_period_reserved;
+
+
+
+
+
 void init_timervecs (void)
 {
 	int i;
@@ -610,6 +620,15 @@ void update_process_times(int user_tick)
 				p->need_resched = 1;
 			}
 		}
+		
+		if (p->policy == SCHED_FIFO) { 
+		  if (rt_period_remain == 0) { 
+		    p->need_resched = 1;
+		  } else { 
+		    rt_period_remain--;
+		  }
+		}
+
 		if (p->nice > 0)
 			kstat.per_cpu_nice[cpu] += user_tick;
 		else
--------------------- end -----------------------------------------

----
Robert Melby
Georgia Institute of Technology, Atlanta Georgia, 30332
uucp:     ...!{decvax,hplabs,ncar,purdue,rutgers}!gatech!prism!gt4255a
Internet: async@cc.gatech.edu

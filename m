Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269364AbSIRS37>; Wed, 18 Sep 2002 14:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269365AbSIRS37>; Wed, 18 Sep 2002 14:29:59 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:15015 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S269364AbSIRS3x>;
	Wed, 18 Sep 2002 14:29:53 -0400
Date: Thu, 19 Sep 2002 00:10:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read-Copy Update 2.5.36
Message-ID: <20020919001018.C23055@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <200209181937.39385.m.c.p@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209181937.39385.m.c.p@gmx.net>; from m.c.p@wolk-project.de on Wed, Sep 18, 2002 at 07:38:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 07:38:30PM +0200, Marc-Christian Petersen wrote:
> Hi Dipankar,
> 
> > Here is RCU for 2.5.36. It is just a rediff from earlier version.
> unfortunately it does not build the modules correctly.
> 
> Output of "make modules"
> 
> make[1]: Entering directory `/usr/src/linux-2.5.36-vanilla/fs'
>   gcc -Wp,-MD,./.binfmt_misc.o.d -D__KERNEL__ 
> -I/usr/src/linux-2.5.36-vanilla/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include 
> -DMODULE   -DKBUILD_BASENAME=binfmt_misc   -c -o binfmt_misc.o binfmt_misc.c
> In file included from /usr/src/linux-2.5.36-vanilla/include/linux/mm.h:4,
>                  from /usr/src/linux-2.5.36-vanilla/include/linux/pagemap.h:7,
>                  from binfmt_misc.c:26:
> /usr/src/linux-2.5.36-vanilla/include/linux/sched.h:480: parse error before 
> `cpu_quiescent'
> /usr/src/linux-2.5.36-vanilla/include/linux/sched.h:480: warning: type 
> defaults to `int' in declaration of `DEFINE_PER_CPU'
> /usr/src/linux-2.5.36-vanilla/include/linux/sched.h:480: warning: function 
> declaration isn't a prototype

Ok, so DEFINE_PER_CPU() has now been excluded when MODULE is defined.
The included patch below should fix that.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


--- linux-2.5.36-rcu_poll/include/linux/sched.h.orig	Wed Sep 18 22:33:16 2002
+++ linux-2.5.36-rcu_poll/include/linux/sched.h	Wed Sep 18 22:49:51 2002
@@ -477,7 +477,9 @@
 
 extern struct   mm_struct init_mm;
 extern struct task_struct *init_tasks[NR_CPUS];
+#ifndef MODULE
 extern DEFINE_PER_CPU(long, cpu_quiescent);
+#endif
 
 /* PID hashing. (shouldnt this be dynamic?) */
 #define PIDHASH_SZ 8192
@@ -1029,7 +1031,7 @@
 
 #endif /* CONFIG_SMP */
 
-#ifdef CONFIG_PREEMPT
+#if defined(CONFIG_PREEMPT) && !defined(MODULE)
 
 extern DEFINE_PER_CPU(atomic_t[2], rcu_preempt_cntr);
 extern DEFINE_PER_CPU(atomic_t, *curr_preempt_cntr);

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbUCHMBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 07:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbUCHMBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 07:01:20 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:62338 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262481AbUCHMBM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 07:01:12 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Date: Mon, 8 Mar 2004 17:30:58 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, george@mvista.com,
       pavel@ucw.cz
References: <200403081504.30840.amitkale@emsyssoft.com> <200403081714.05521.amitkale@emsyssoft.com> <20040308035416.62929bfe.akpm@osdl.org>
In-Reply-To: <20040308035416.62929bfe.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403081730.58208.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 Mar 2004 5:24 pm, Andrew Morton wrote:
> "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > Here is the intrusive piece of code that helps get thread state
> > correctly. Any ideas on cleaning it?
>
> I think George's stub has diverged rather a lot from yours.  Much more than
> I was aware.

Yes. It has.
At this point of time no one knows precisely where all they differ and 
how/whether they could be merged.

The threads code in my version saves all registers during a context switch. 
This provides two benefits:
1. GDB doesn't lose track of registers when going up a stack trace starting 
with switch_to.
2. If a thread calls schedule, the thread backtrace starts from caller of 
schedule rather than schedule itself. So info threads command shows a more 
meaningful output.

-Amit

>
> >  --- linux-2.6.3-kgdb.orig/include/linux/sched.h	2004-02-24
> > 10:44:47.000000000 +0530
> >  +++ linux-2.6.3-kgdb/include/linux/sched.h	2004-03-04 18:42:56.324188184
> > +0530 @@ -173,7 +173,9 @@
> >
> >   #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
> >   extern signed long FASTCALL(schedule_timeout(signed long timeout));
> >  -asmlinkage void schedule(void);
> >  +asmlinkage void do_schedule(void);
> >  +asmlinkage void kern_schedule(void);
> >  +asmlinkage void kern_do_schedule(struct pt_regs);
>
> The stub in -mm has only a single change to sched.c:
>
> diff -puN kernel/sched.c~kgdb-ga kernel/sched.c
> --- 25/kernel/sched.c~kgdb-ga	2004-03-07 01:57:48.000000000 -0800
> +++ 25-akpm/kernel/sched.c	2004-03-07 01:57:48.000000000 -0800
> @@ -2015,6 +2015,13 @@ out_unlock:
>
>  EXPORT_SYMBOL(set_user_nice);
>
> +#if defined( CONFIG_KGDB)
> +struct task_struct * kgdb_get_idle(int this_cpu)
> +{
> +        return cpu_rq(this_cpu)->idle;
> +}
> +#endif
> +
>  #ifndef __alpha__
>
>  /*


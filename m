Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVBXJdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVBXJdb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 04:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVBXJdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 04:33:31 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:57570 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262116AbVBXJdI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:33:08 -0500
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM: 2/10 CKRM: Accurate delay accounting 
In-reply-to: Your message of Mon, 29 Nov 2004 13:38:25 PST.
             <20041129213825.GB19892@kroah.com> 
Date: Thu, 24 Feb 2005 01:33:05 -0800
Message-Id: <E1D4FMo-0006uj-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Nov 2004 13:38:25 PST, Greg KH wrote:
> On Mon, Nov 29, 2004 at 10:46:53AM -0800, Gerrit Huizenga wrote:
> > @@ -912,6 +915,9 @@
> >  extern void set_task_comm(struct task_struct *tsk, char *from);
> >  extern void get_task_comm(char *to, struct task_struct *tsk);
> >  
> > +#define PF_MEMIO   	0x00400000      /* I am  potentially doing I/O for mem */
> > +#define PF_IOWAIT       0x00800000      /* I am waiting on disk I/O */
> > +
> 
> Mix of tabs and spaces :(
 
Fixed.

> >  #ifdef CONFIG_SMP
> >  extern void wait_task_inactive(task_t * p);
> >  #else
> > @@ -1111,6 +1117,86 @@
> >  
> >  #endif
> >  
> > +/* API for registering delay info */
> > +#ifdef CONFIG_DELAY_ACCT
> > +
> > +#define test_delay_flag(tsk,flg)                ((tsk)->flags & (flg))
> > +#define set_delay_flag(tsk,flg)                 ((tsk)->flags |= (flg))
> > +#define clear_delay_flag(tsk,flg)               ((tsk)->flags &= ~(flg))
> > +
> > +#define def_delay_var(var)		        unsigned long long var
> > +#define get_delay(tsk,field)                    ((tsk)->delays.field)
> > +
> > +#define start_delay(var)                        ((var) = sched_clock())
> > +#define start_delay_set(var,flg)                (set_delay_flag(current,flg),(var) = sched_clock())
> 
> You mixed tabs and spaces here.  Just use tabs please.
 
Fixed.

> > +#define add_delay_clear(tsk,field,start_ts,flg)        \
> > +	do {                                           \
> > +		unsigned long long now = sched_clock();\
> > +           	add_delay_ts(tsk,field,start_ts,now);  \
> > +           	clear_delay_flag(tsk,flg);             \
> > +        } while (0)
> 
> -ENOTABS
 
Fixed.

> > +#else
> > +
> > +#define test_delay_flag(tsk,flg)                (0)
> > +#define set_delay_flag(tsk,flg)                 do { } while (0)
> > +#define clear_delay_flag(tsk,flg)               do { } while (0)
> > +
> > +#define def_delay_var(var)			      
> > +#define get_delay(tsk,field)                    (0)
> > +
> > +#define start_delay(var)                        do { } while (0)
> > +#define start_delay_set(var,flg)                do { } while (0)
> > +
> > +#define inc_delay(tsk,field)                    do { } while (0)
> > +#define add_delay_ts(tsk,field,start_ts,now)    do { } while (0)
> > +#define add_delay_clear(tsk,field,start_ts,flg) do { } while (0)
> > +#define add_io_delay(dstart)			do { } while (0) 
> > +#define init_delays(tsk)                        do { } while (0)
> > +#endif
> > +
> 
> It's that key over there on the left hand side of the keyboard...
 
Found it.  Thanks!

> > +/* Changes
> > + *
> > + * 24 Aug 2003
> > + *    Created.
> > + */
> 
> No changelogs in files again please.
 
Globally gone.

> > +
> > +#ifndef _LINUX_TASKDELAYS_H
> > +#define _LINUX_TASKDELAYS_H
> > +
> > +#include <linux/config.h>
> > +#include <linux/types.h>
> > +
> > +struct task_delay_info {
> > +#if defined CONFIG_DELAY_ACCT 
> > +	/* delay statistics in usecs */
> > +	uint64_t waitcpu_total;
> > +	uint64_t runcpu_total;
> > +	uint64_t iowait_total;
> > +	uint64_t mem_iowait_total;
> > +	uint32_t runs;
> > +	uint32_t num_iowaits;
> > +	uint32_t num_memwaits;
> > +#endif				
> > +};
> 
> A null structure otherwise?  Why?
 
Bizarro world.  Fixed.

> > +#ifdef CONFIG_DELAY_ACCT
> > +int task_running_sys(struct task_struct *p)
> > +{
> > +	return task_is_running(p);
> > +}
> > +EXPORT_SYMBOL_GPL(task_running_sys);
> > +#endif
> 
> So LGPL code can use EXPORT_SYMBOL_GPL?

You lost me on this one - what LGPL code is using task_running_sys?
(and actually, I've held off on resubmitting the RBCE code for a few
days which is the code that uses this while we get some air time on
the broken up patch).

gerrit

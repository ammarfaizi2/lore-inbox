Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261791AbSJJRkU>; Thu, 10 Oct 2002 13:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbSJJRkU>; Thu, 10 Oct 2002 13:40:20 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:62855 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261791AbSJJRkT> convert rfc822-to-8bit; Thu, 10 Oct 2002 13:40:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [PATCH] pooling NUMA scheduler with initial load balancing
Date: Thu, 10 Oct 2002 12:34:34 -0500
X-Mailer: KMail [version 1.4]
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200210091826.20759.efocht@ess.nec.de> <200210091258.08379.habanero@us.ibm.com> <200210100102.13980.efocht@ess.nec.de>
In-Reply-To: <200210100102.13980.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210101234.34345.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 October 2002 6:02 pm, Erich Focht wrote:
> > > Starting migration thread for cpu 3
> > > Bringing up 4
> > > CPU>dividNOWrro!
> >
> > I got the same thing on 2.5.40-mm1.  It looks like it may be a a divide
> > by zero in calc_pool_load.  I am attempting to boot a band-aid version
> > right now.  OK, got a little further:
>
> This opened my eyes, thanks for all your help and patience!!!
>
> The problem is that the load balancer is called before the CPU pools
> were set up. That's fine, I thought, because I define in sched_init
> the default pool 0 to include all CPUs. But: in find_busiest_queue()
> the cpu_to_node(this_cpu) delivers a non-zero pool which is not set up
> yet, therefore pool_nr_cpus[pool]=0 and we get a zero divide.
>
> I'm still wondering why this doesn't happen on our architecture. Maybe
> the interrupts are disabled longer, I'll check. Anyway, a fix is to
> force this_pool to be 0 as long as numpools=1. The attached patch is a
> quick untested hack, maybe one can do it better. Has to be applied on top
> of the other 2.

Thanks very much Erich.  I did come across another problem here on numa-q.  In 
task_to_steal() there is a divide by cache_decay_ticks, which apparantly is 0 
on my system.  This may have to do with notsc, but I am not sure.  I set 
cache_decay_ticks to 8, (I cannot boot without using notsc) which is probably 
not correct, but I can now boot 16 processor numa-q on 2.5.40-mm1 with your 
patches!  I'll get some benchmark results soon.  

Andrew Theurer

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317829AbSHaR0m>; Sat, 31 Aug 2002 13:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317816AbSHaR0m>; Sat, 31 Aug 2002 13:26:42 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:42146 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S317829AbSHaR0m>; Sat, 31 Aug 2002 13:26:42 -0400
Message-ID: <20020831173107.13829.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Sat, 31 Aug 2002 19:31:07 +0200
To: Ingo Molnar <mingo@elte.hu>
Cc: Burton Windle <bwindle@fint.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kpreempt-tech@lists.sourceforge.net, rml@tech9.net
Subject: Re: 2.5.32: DEBUG_SLAB and PREEMPT = constant oops in schedule()
References: <20020829090739.18655.qmail@thales.mathematik.uni-ulm.de> <Pine.LNX.4.44.0208300904200.7451-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208300904200.7451-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 09:06:38AM +0200, Ingo Molnar wrote:
> 
> On Thu, 29 Aug 2002, Christian Ehrhardt wrote:
> 
> > sys_sched_setaffinity, lines:
> >    1571         get_task_struct(p);
> >    1572         read_unlock(&tasklist_lock);
> 
> > Line 1571 calls get_task_struct because the task might exit during the
> > syscall. Suppose that this is exactly what happens. This means that line
> > 1583 will effectivly free the task. But set_cpus_allowed stuffed a
> > pointer to the task into a request struct without incrementing the usage
> > count of the task struct.
> 
> note that the scenario you describe is not possible, because
> set_cpus_allowed() will wait for the migration thread to do its work - so
> the put_task_struct can never come before the last use of the task
> structure. See the 'down(&req.sem)' in set_cpus_allowed(), and the
> up(&req->sem) in migration_thread().

Agreed. Is there anything that prevents the other scenario described
in the original mail, i.e. sys_wait frees the task struct before the
task finally scheduled away? There used to be a lock_kernel in sys_wait
and sys_exit to make sure this doesn't happen but it is gone in 2.5.

    regards  Christian

-- 
THAT'S ALL FOLKS!

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319461AbSH3G6x>; Fri, 30 Aug 2002 02:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319475AbSH3G6x>; Fri, 30 Aug 2002 02:58:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49281 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319461AbSH3G6w>;
	Fri, 30 Aug 2002 02:58:52 -0400
Date: Fri, 30 Aug 2002 09:06:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
Cc: Burton Windle <bwindle@fint.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <kpreempt-tech@lists.sourceforge.net>, <rml@tech9.net>
Subject: Re: 2.5.32: DEBUG_SLAB and PREEMPT = constant oops in schedule()
In-Reply-To: <20020829090739.18655.qmail@thales.mathematik.uni-ulm.de>
Message-ID: <Pine.LNX.4.44.0208300904200.7451-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Aug 2002, Christian Ehrhardt wrote:

> sys_sched_setaffinity, lines:
>    1571         get_task_struct(p);
>    1572         read_unlock(&tasklist_lock);

> Line 1571 calls get_task_struct because the task might exit during the
> syscall. Suppose that this is exactly what happens. This means that line
> 1583 will effectivly free the task. But set_cpus_allowed stuffed a
> pointer to the task into a request struct without incrementing the usage
> count of the task struct.

note that the scenario you describe is not possible, because
set_cpus_allowed() will wait for the migration thread to do its work - so
the put_task_struct can never come before the last use of the task
structure. See the 'down(&req.sem)' in set_cpus_allowed(), and the
up(&req->sem) in migration_thread().

	Ingo


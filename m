Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSKISrI>; Sat, 9 Nov 2002 13:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262453AbSKISrI>; Sat, 9 Nov 2002 13:47:08 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:45064
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262457AbSKISrH>; Sat, 9 Nov 2002 13:47:07 -0500
Subject: Re: [patch] get/put_cpu in up need not disable preemption
From: Robert Love <rml@tech9.net>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021109153634.M2298@in.ibm.com>
References: <20021109153634.M2298@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Nov 2002 13:53:52 -0500
Message-Id: <1036868033.760.6996.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-09 at 05:06, Ravikiran G Thirumalai wrote:

> AFAICS, get_cpu, put_cpu and put_cpu_no_resched need not disable 
> preemption on a uniprocessor. Foll patch removes the disable/enable
> premeption stuff for the UP case.  Tested on a PIII 4 way for both
> UP and SMP configs. Pls apply.

No, it needs to.

Per-CPU data can alleviate the need for a lock.  On SMP, a per-CPU
variable does not need a lock since it is impossible for another task to
enter the same critical section and access the same variable, from
another CPU.  On preempt it is fully possible.

For example, this is a critical section, and you do not want two threads
on the same CPU concurrently inside:

	extern struct my_struct[NR_CPUS];
	int cpu = get_cpu();

	do_stuff(my_struct[cpu]);
	do_more_stuff(my_struct[cpu]);
	foo = my_struct[cpu].bar;

	put_cpu();

So get_cpu() must disable preemption even on UP.  The problem you are
thinking of (being preempted and returning on a different CPU) is only a
subset of the issues.  All processor accesses must be atomic.

	Robert Love


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262854AbTC1J7V>; Fri, 28 Mar 2003 04:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262857AbTC1J7U>; Fri, 28 Mar 2003 04:59:20 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:34948 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S262854AbTC1J7T>;
	Fri, 28 Mar 2003 04:59:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16004.8084.271596.293605@gargle.gargle.HOWL>
Date: Fri, 28 Mar 2003 11:10:28 +0100
From: mikpe@csd.uu.se
To: Keith Owens <kaos@ocs.com.au>
Cc: mikpe@csd.uu.se, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.21-pre5 correct scheduling of idle tasks [ all arch ] 
In-Reply-To: <19527.1048803432@ocs3.intra.ocs.com.au>
References: <16003.7879.340300.737153@gargle.gargle.HOWL>
	<19527.1048803432@ocs3.intra.ocs.com.au>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
 > On Thu, 27 Mar 2003 16:54:47 +0100, 
 > mikpe@csd.uu.se wrote:
 > >Keith Owens writes:
 > > > There are several inconsistencies in the scheduling of idle tasks and,
 > > > for UP, tracking which task is on the cpu.  This patch standardizes
 > > > idle task scheduling across all architectures and corrects the UP
 > > > error, it is just a bug fix.
 > >...
 > > > To make it worse, on UP a task is assigned to a cpu but never released.
 > > > Very quickly, all tasks are marked as currently running on cpu 0 :(.
 > >
 > >->cpus_runnable and task_has_cpu() are SMP-only, as a quick grep
 > >through 2.4.20 will tell you. There is no UP bug here to fix.
 > 
 > cpus_runnable has task_has_cpu are not guarded by CONFIG_SMP.
 > task_set_cpu() is called for UP as well as SMP.  UP is missing the
 > corresponding call to task_release_cpu().

No generic kernel code _uses_ ->cpus_runnable on UP.
arch/s390{,x}/kernel/traps.c appears to use task_has_cpu() on UP,
but that's their bug and not an argument for slowing down UP kernels.

Hence, kernel/sched.c not calling task_release_cpu() to reset
->cpus_runnable to ~0 is not a bug.

The only bug (apart from s390's trap.c) is that task_set_cpu() performs
an unnecessary assignment to ->cpus_runnable on UP.

/Mikael

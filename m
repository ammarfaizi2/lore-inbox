Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbVI1GVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbVI1GVs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 02:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVI1GVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 02:21:48 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:25776 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751056AbVI1GVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 02:21:47 -0400
Date: Wed, 28 Sep 2005 15:21:42 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: Paul Jackson <pj@sgi.com>
Cc: taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH 1/3] CPUMETER: add cpumeter framework to
 the CPUSETS
In-Reply-To: <20050927084905.7d77bdde.pj@sgi.com>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
	<20050927084905.7d77bdde.pj@sgi.com>
X-Mailer: Sylpheed version 2.1.2+svn (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050928062146.6038E70041@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005 08:49:05 -0700
Paul Jackson <pj@sgi.com> wrote:

> Instead of doing the impossible and trying to mark all the children
> of C as meter_cpu all at same instant in time, I should just mark the
> parent cpuset C, one time.  

I agree with your idea.
Marking the parent cpuset C instead of marking each child seems to make
things quite easier.

> Then if C is so marked, its -children- now
> have the meter_cpu_* files, which can default at that instant in time to
> providing (1/N) of the cpu to each of the N children of C.

Maybe the default value of meter_cpu_guar (guarantee) could be 0 
in this design, since guarantee 0 means no guarantee.  Resources
can even be allocated without guarantee.

> I would say that C can only be marked meter_cpu if:
>  * C is already marked cpu_exclusive.
>  * All of its children have the same 'cpus' setting as C.
>  * Any new child of C created after C is marked meter_cpu will
>    automatically start with the same 'cpus' setting as C, and
>    with the meter_cpu_* files.
>  * It is prohibited to change the 'cpus' of any cpuset whose
>    parent is marked meter_cpu.
>  * Changing the 'cpus' of a cpuset such as C that is itself
>    marked meter_cpu will instantly change the 'cpus' of each
>    of its children.
>  * It is prohibited to turn on the cpu_exclusive flag of a cpuset
>    whose parent is marked meter_cpu, or to turn off the cpu_exclusive
>    flag on a cpuset that is itself marked meter_cpu.

These seem good for me.

> The metered children of C may have their own children in turn, which
> may have cpus any subset of the cpus in C, but which cannot be marked
> cpu_exclusive or meter_cpu.
> 
> Borrowing your fine art work, and modifying it slightly, this looks
> like:
> 
>       +-----------------------------------+
>       |                                   |
>    CPUSET 0                            CPUSET 1 (aka 'C')
>    sched domain A                      sched domain B
>    cpus: 0, 1                          cpus: 2, 3
>    cpu_exclusive=1                     cpu_exclusive=1
>    meter_cpu=0                         meter_cpu=1
>                                           |
>                          +----------------+----------------+
>                          |                |                |
>                       CPUSET 1a        CPUSET 1b        CPUSET 1c
>                       cpus: 2, 3       cpus: 2, 3       cpus: 2, 3
>                       cpu_exclusive=0  cpu_exclusive=0  cpu_exclusive=0
>                       meter_cpu=0      meter_cpu=0      meter_cpu=0
>                       meter_cpu_*      meter_cpu_*      meter_cpu_*
>                          |
>             +------------+------------+
>             |                         |
>          CPUSET 2a                CPUSET 2b
>          cpus: 2                  cpus: 3
>          meter_cpu=0              meter_cpu=0
>          cpu_exclusive=0          cpu_exclusive=0
> 
> Note here that marking C (CPUSET 1) as meter_cpu exposes the meter_cpu_*
> files in the children of C.

If we split the cpus {2, 3} into {2} and {3} by creating CPUSET 2a 
and CPUSET 2b, the guarantee assigned to CPUSET 1a might not be
satisfied.  For example, the maximum cpu resource usage of tasks 
in CPUSET 2a should essentially be 50% because tasks in CPUSET 2a
can only use the half number of cpus.  If we set meter_cpu_guar=60% 
on CPUSET 1a, the problem might occur.  Maybe (or maybe not), we can 
leave this problem as it is.

> > Is it prohibited for any decendant of C's children to set meter_cpu=1 ?
> 
> Yes, I presume so, and made up my new rules above assuming that.  It is
> definitely worth an effort in my opinion to allow creating nested
> ordinary (not metered) cpusets below the children of C, but I am
> guessing it would be too hard to try to allow nesting of metered
> cpusets below metered cpusets.  If you have a mind to try that however,
> I am more than willing to listen to your proposal.

Probably allowing nested metered cpusets is too hard both to implement
and to use.  So far, I woundn't like to implement it.

> Therefore I propose some new cpuset flags:
>  * 'sched_domain' to mark sched domains (now done by the cpu_exclusive
>    flag),
>  * 'kernel_memory' to mark the constraints on GFP_KERNEL allocations,
>  * 'oom_killer' to mark the constraints on oom killing,
>  * your 'meter_cpu' flag to mark a set of metered cpus, and
>  * your 'meter_mem' flag to mark a set of metered mems.

This seems very interesting.  Tasks enclosed by a certain cpuset may
want to change the behavior of oom_killer.

-- 
KUROSAWA, Takahiro

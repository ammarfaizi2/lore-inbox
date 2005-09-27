Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbVI0Pt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVI0Pt0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVI0Pt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:49:26 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29656 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964983AbVI0PtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:49:25 -0400
Date: Tue, 27 Sep 2005 08:49:05 -0700
From: Paul Jackson <pj@sgi.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH 1/3] CPUMETER: add cpumeter framework to
 the CPUSETS
Message-Id: <20050927084905.7d77bdde.pj@sgi.com>
In-Reply-To: <20050927113902.C78A570046@sv1.valinux.co.jp>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takahiro-san asks perceptive question:
> If it is prohibited to set meter_cpu=0 for the immediate children 
> of C, cpuset_create() needs a check whether the siblings are
> metered or not. 

Very good question.  It exposes an impossibility in my proposal, as
stated.  The rule I had in mind was that either all the children of C
had meter_cpu set, or none of them.  But since one can only mark one
cpuset at a time, this is impossible to setup if there is more than
one child already.

Allow me to try to fix my proposal.

Instead of doing the impossible and trying to mark all the children
of C as meter_cpu all at same instant in time, I should just mark the
parent cpuset C, one time.  Then if C is so marked, its -children- now
have the meter_cpu_* files, which can default at that instant in time to
providing (1/N) of the cpu to each of the N children of C.  I would
say that C can only be marked meter_cpu if:
 * C is already marked cpu_exclusive.
 * All of its children have the same 'cpus' setting as C.
 * Any new child of C created after C is marked meter_cpu will
   automatically start with the same 'cpus' setting as C, and
   with the meter_cpu_* files.
 * It is prohibited to change the 'cpus' of any cpuset whose
   parent is marked meter_cpu.
 * Changing the 'cpus' of a cpuset such as C that is itself
   marked meter_cpu will instantly change the 'cpus' of each
   of its children.
 * It is prohibited to turn on the cpu_exclusive flag of a cpuset
   whose parent is marked meter_cpu, or to turn off the cpu_exclusive
   flag on a cpuset that is itself marked meter_cpu.

Similar rules would apply for mem_exclusive and meter_mem.

The metered children of C may have their own children in turn, which
may have cpus any subset of the cpus in C, but which cannot be marked
cpu_exclusive or meter_cpu.

Borrowing your fine art work, and modifying it slightly, this looks
like:

      +-----------------------------------+
      |                                   |
   CPUSET 0                            CPUSET 1 (aka 'C')
   sched domain A                      sched domain B
   cpus: 0, 1                          cpus: 2, 3
   cpu_exclusive=1                     cpu_exclusive=1
   meter_cpu=0                         meter_cpu=1
                                          |
                         +----------------+----------------+
                         |                |                |
                      CPUSET 1a        CPUSET 1b        CPUSET 1c
                      cpus: 2, 3       cpus: 2, 3       cpus: 2, 3
                      cpu_exclusive=0  cpu_exclusive=0  cpu_exclusive=0
                      meter_cpu=0      meter_cpu=0      meter_cpu=0
                      meter_cpu_*      meter_cpu_*      meter_cpu_*
                         |
            +------------+------------+
            |                         |
         CPUSET 2a                CPUSET 2b
         cpus: 2                  cpus: 3
         meter_cpu=0              meter_cpu=0
         cpu_exclusive=0          cpu_exclusive=0

Note here that marking C (CPUSET 1) as meter_cpu exposes the meter_cpu_*
files in the children of C.

> Is it prohibited for any decendant of C's children to set meter_cpu=1 ?

Yes, I presume so, and made up my new rules above assuming that.  It is
definitely worth an effort in my opinion to allow creating nested
ordinary (not metered) cpusets below the children of C, but I am
guessing it would be too hard to try to allow nesting of metered
cpusets below metered cpusets.  If you have a mind to try that however,
I am more than willing to listen to your proposal.

The above proposal makes it more obvious than ever that I am starting
to overload the meaning of cpu_exclusive and mem_exclusive perhaps a
bit too much.

One or the other of the two *_exclusive flags should be required
preconditions for some of these special properties (sched domains,
GFP_KERNEL memory allocation confinement, oom killer confinement, cpu
metering and memory metering), but perhaps actually enabling any of
these special properties should be an additional and distinct choice.

Therefore I propose some new cpuset flags:
 * 'sched_domain' to mark sched domains (now done by the cpu_exclusive
   flag),
 * 'kernel_memory' to mark the constraints on GFP_KERNEL allocations,
 * 'oom_killer' to mark the constraints on oom killing,
 * your 'meter_cpu' flag to mark a set of metered cpus, and
 * your 'meter_mem' flag to mark a set of metered mems.

Each of these new flags would require the appropriate cpu_exclusive or
mem_exclusive flag on the same cpuset to already be set, but just
setting the *_exclusive flags by themselves would not be enough to get
you the special behaviour.  You would also have to set the appropriate
one of these new flags.

So, for example, the condition to define a sched domain would change,
from just being the lowest level cpuset marked cpu_exclusive (or the
left over CPUs not marked exclusive), to being both that -and- having
its "sched_domain" flag marked True (or being the left over CPUs,
again).

At first writing, I like the sound of this.  But then I often
think my suggestions are good, when I first write them <grin>.

Without these new flags, the interface has an odd assymmetry to it.
Just setting cpu_exclusive could get you a sched domain for instance,
but you had to have both cpu_exclusive and meter_cpu to get the
cpu metering code.  The only reason for this was that Dinakar got his
sched domain patch in before you got your cpu meter patch in, which is
a poor reason if I do say so.

These extra flags have an additional benefit.  They make explicit
to the user level what additional semantics are switched on, rather
than hiding them as implicit side affects of the cpu_exclusive
configuration.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

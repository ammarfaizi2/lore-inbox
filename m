Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281707AbRLKQSq>; Tue, 11 Dec 2001 11:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281726AbRLKQSh>; Tue, 11 Dec 2001 11:18:37 -0500
Received: from mail.ccur.com ([208.248.32.212]:42762 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id <S281707AbRLKQSS>;
	Tue, 11 Dec 2001 11:18:18 -0500
Subject: Re: [RFC] Multiprocessor Control Interfaces
From: Jason Baietto <jason.baietto@ccur.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1008052151.4300.18.camel@phantasy>
In-Reply-To: <1008015291.15138.0.camel@soybean> 
	<1008052151.4300.18.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 11 Dec 2001 11:18:08 -0500
Message-Id: <1008087492.16657.2.camel@soybean>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-11 at 01:29, Robert Love wrote:
> 
> One idea would be to allow users to set CPUs processes _can't_
> run on.

A technique that many of our customers currently use with the run
command is to shield a sensitive CPU in rc.sysinit by simply using run
to bias the init process.  For example, on a four CPU system, the
following command:

   run --bias 1-3 --pid 1

would bias init to only run on CPUs 1, 2 or 3.  Since all children
inherit CPU affinity, this effectively makes CPU 0 off limits for any
process that doesn't explicitly bias itself to CPU 0 via "run".

> On high-end systems sometimes a CPU is affined to a particular IRQ
> (say, network interface).  Another situation is where you bind a RT
> task to a given CPU.  In these situations, you want everything else
> to _not_ run on the CPUs.  I.e., `run --bind=!1' (note its easy to
> generate the bitmask here too, by ANDing the inverse of the given
> CPU against -1).

I like it.  I will add the "!" syntax to the next release of run.
However, I suspect that this is a more error prone method of providing
generic process shielding than the init method discussed above as
processes that don't explicitly get biased can still find their way to
the shielded CPU.

> At any rate, what is needed most is to standardize on an interface for
> these scheduling mechanisms.  I guess its just CPU affinity we have to
> go ... since not much progress was made of my (proc-based) method vs.
> Ingo's (syscall-based) method, at this point either of the two being
> merged would make me happy.

I will happily add support to "run" for Ingo's system calls if they
get merged.  However, many of the more powerful features of the "run"
command currently require /proc for other reasons.  For example,
setting the CPU bias for all processes in a specified list of process
groups, or setting the CPU bias for all processes owned by a specified
list of users all require that I walk /proc to find matching processes.

Also, regarding the mpadvise(3) library service that I've proposed,
commands like MPA_CPU_ACTIVE and MPA_PRC_GETRUN currently parse files
in /proc to determine the list of active CPUs on the system and the
CPU that a process is currently running on.  Thus, until I can get all
of the CPU-centric information that I need via system calls, adding
Ingo's system calls doesn't help me too much (though they would allow
"run" to do simple CPU biasing tasks on systems without /proc).

> I assume you have no problems with it ... 

It's exactly what I needed.  I've been using it for a few weeks
without any problems.

> I think I'd like to add the change that the CPUs reported correspond
> to the physical CPU number and not the logical value we derive.  On
> x86 this won't make a difference, but its a proper method I suspect.

I don't have a strong opinion here, though note that in our
proprietary RTOS our policy is to try to never expose physical values
to the user unless they really, really need to know them.  If you
change the interface to physical values, I will probably abstract back
to logical inside my code so the user still deals with logical (though
I could add a --physical option to force the bias to be interpreted as
physical values).

Take care,
Jason



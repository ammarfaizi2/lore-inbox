Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284940AbRLFCW3>; Wed, 5 Dec 2001 21:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284942AbRLFCWU>; Wed, 5 Dec 2001 21:22:20 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12502 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S284940AbRLFCWE>;
	Wed, 5 Dec 2001 21:22:04 -0500
Message-ID: <3C0ED52E.B15F0ED7@us.ibm.com>
Date: Wed, 05 Dec 2001 18:17:18 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] cpus_allowed/launch_policy patch, 2.4.16
In-Reply-To: <3C0ECBE0.F21464FA@us.ibm.com> <Pine.LNX.4.40.0112051800400.1644-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On Wed, 5 Dec 2001, Matthew Dobson wrote:
> 
> > In response (albeit a week plus late) to the recent hubbub about the cpu
> > affinity patches,
> > I'd like to throw a third contender in the ring.
> >
> > Attatched is a patch (against 2.4.16) which implements a /proc and a prctl()
> > interface to
> > the cpus_allowed flag.  The truly exciting (at least for me) part of this patch
> > is the
> > launch_policy flag that it also introduces.  The launch_policy flag is used
> > similarly to
> > the cpus_allowed flag, but it controls the cpus_allowed flags of any subsequent
> > children
> > of the process, instead of the cpus_allowed of the process itself.  Via this
> > flag, there
> > are no worries about processes being able to fork children before a 'chaff' or
> > 'echo' or
> > anything else for that matter can be executed.  The child process is assigned
> > the desired
> > cpus_allowed at fork/exec time.  All this without having to bounce the current
> > process to
> > different cpus to (hopefully) acheive the same results.
> >
> > The launch_policy flag can acually be quite powerful.  It allows for children
> > to be
> > instantiated on the correct cpu/node with a minimum of memory footprint on the
> > wrong
> > cpu/node.  This can be taken advantage of via the /proc interface (for smp/numa
> > unaware
> > programs) or through prctl() for more clueful programs.
> 
> What you probably want to do in real life is to move a process to a cpu
> and have all its child spawned on that cpu, that is the actual behavior.
If you want a process moved, you change cpus_allowed; if you want the children
spawned
somewhere in particular, you change launch_policy; if you really want both, you
change both...

> Can't You achieve the same by coding a :
> 
> pid_t affine_fork(int cpumask) {
>         pid_t pp = fork();
>         if (pp == 0) {
>                 set_affinity(getpid(), cpumask);
>                 ...
>         }
>         return pp;
> } 
>
> in your application and having the default bahavior to propagate it to the
> following fork()s.
you could do that, but that means you have to keep track of the cpumask
somewhere.
i suppose you could force your children to:

pid_t enforce_launch_policy_fork() {
        pid_t pp = fork();
        if (pp == 0) {
                set_affinity(getpid(), get_affinity());
                ...
        }
        return pp;
}

but, as soon as one of them exec()'s their no longer going to be using your
functions.
By making it a default part of fork's behavior, processes naturally end up
where they're
supposed to be.  And the default launch_policy if 0xffffffff, so unless you
purposely
change launch_policy, the old default behavior (run wherever you can) is
preserved.

> 
> > +int proc_pid_cpus_allowed_read(struct task_struct *task, char * buffer)
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^
> You want Al Viro screaming, don't You ? :)
> 
> - Davide
If that is the biggest complaint about the patch, then I'll be quite happy
with some yelling and screaming about descriptive function names! ;)

Cheers!

-matt



> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284929AbRLFB55>; Wed, 5 Dec 2001 20:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284930AbRLFB5q>; Wed, 5 Dec 2001 20:57:46 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:35855 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284929AbRLFB5d>; Wed, 5 Dec 2001 20:57:33 -0500
Date: Wed, 5 Dec 2001 18:08:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Matthew Dobson <colpatch@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] cpus_allowed/launch_policy patch, 2.4.16
In-Reply-To: <3C0ECBE0.F21464FA@us.ibm.com>
Message-ID: <Pine.LNX.4.40.0112051800400.1644-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Matthew Dobson wrote:

> In response (albeit a week plus late) to the recent hubbub about the cpu
> affinity patches,
> I'd like to throw a third contender in the ring.
>
> Attatched is a patch (against 2.4.16) which implements a /proc and a prctl()
> interface to
> the cpus_allowed flag.  The truly exciting (at least for me) part of this patch
> is the
> launch_policy flag that it also introduces.  The launch_policy flag is used
> similarly to
> the cpus_allowed flag, but it controls the cpus_allowed flags of any subsequent
> children
> of the process, instead of the cpus_allowed of the process itself.  Via this
> flag, there
> are no worries about processes being able to fork children before a 'chaff' or
> 'echo' or
> anything else for that matter can be executed.  The child process is assigned
> the desired
> cpus_allowed at fork/exec time.  All this without having to bounce the current
> process to
> different cpus to (hopefully) acheive the same results.
>
> The launch_policy flag can acually be quite powerful.  It allows for children
> to be
> instantiated on the correct cpu/node with a minimum of memory footprint on the
> wrong
> cpu/node.  This can be taken advantage of via the /proc interface (for smp/numa
> unaware
> programs) or through prctl() for more clueful programs.

What you probably want to do in real life is to move a process to a cpu
and have all its child spawned on that cpu, that is the actual behavior.
Can't You achieve the same by coding a :

pid_t affine_fork(int cpumask) {
	pid_t pp = fork();
	if (pp == 0) {
		set_affinity(getpid(), cpumask);
		...
	}
	return pp;
}

in your application and having the default bahavior to propagate it to the
following fork()s.


> +int proc_pid_cpus_allowed_read(struct task_struct *task, char * buffer)
       ^^^^^^^^^^^^^^^^^^^^^^^^^^
You want Al Viro screaming, don't You ? :)




- Davide




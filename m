Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281843AbRKWAxK>; Thu, 22 Nov 2001 19:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281845AbRKWAwx>; Thu, 22 Nov 2001 19:52:53 -0500
Received: from ns01.netrox.net ([64.118.231.130]:46528 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S281843AbRKWAwd>;
	Thu, 22 Nov 2001 19:52:33 -0500
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
From: Robert Love <rml@tech9.net>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <E16744i-0004zQ-00@localhost>
In-Reply-To: <Pine.LNX.4.33.0111220951240.2446-300000@localhost.localdomain>
	<1006472754.1336.0.camel@icbm>  <E16744i-0004zQ-00@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 22 Nov 2001 19:51:22 -0500
Message-Id: <1006476685.1331.9.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-22 at 19:20, Ryan Cumming wrote:

>  Here here, I was just thinking "Well, I like the CPU affinity idea, but I 
> loathe syscall creep... I hope this Robert Love fellow says something about 
> that" as I read your email's header.

Ah, we think the same way.  The reason I spoke up, though, is in
addition to disliking the syscall way and liking the proc way, I thought
Ingo's implementation was nicely done.  In particular, the use of
cpu_online_map and forcing the reschedule were things I probably
wouldn't of thought of.
 
>  In addition to keeping the syscall table from being filled with very 
> specific, non-standard, and use-once syscalls, a /proc interface would allow 
> me to change the CPU affinity of processes that aren't {get, set}_affinity 
> aware (i.e., all Linux applications written up to this point). This isn't 
> very different from how it's possible to change a processes other scheduling 
> properties (priority, scheduler) from another process. Imagine if renice(8) 
> had to be implemented as attaching to a process and calling nice(2)... ick. 

Heh, this seems like the strongest argument yet, and I didn't even
mention it.  Note, however, that there is a pid_t field in the syscall
and from glossing over the code it seems you can set the affinity of any
arbitrary task given you have the right permissions.  Thus, we could
make a binary that took in a pid and a cpu mask, and set the affinity. 
But I still think "echo 0xffffffff > /proc/768/cpu_affinity" is nicer.

This opens up the issue of permissions with my proc suggestion, and we
have some options:

	Users can set the affinity of their own task, root can set anything.
	One needs a CAP capability to set affinity (which root of course has).
	Everyone can set anything, or only root can set affinity.

I would suggest letting users set their own affinity (since it only
lessens what they can do) and let a capability dictate if non-root users
can set other user's tasks affinities.  CAP_SYS_ADMIN would do fine.

>  Also, as an application developer, I try to avoid conditionally compiled, 
> system-specific calls. I would have much less "cleanliness" objections 
> towards testing for the /proc/<pid>/cpu_affinity files existance and 
> conditionally writing to it. Compare this to the hacks some network servers 
> use to try to detect sendfile(2)'s presence at runtime, and you'll see what I 
> mean. Remember, everything is a file ;)

Agreed. This:

	sprintf(p, "%s%d%s", "/proc/", pid(), "/cpu_affinity");
	f = open(p, "rw");
	if (!f) /* no cpu_affinity ... */
	
Is a very simple check vs. the sort of magic hackery that I see to find
out if a syscall is supported at run-time.

Again I mention how we can move cpus_allowed now to any size, and even
support old sizes, since it is a non-issue with a string.

>  And one final thing... what sort of benifit does CPU affinity have if we 
> have the scheduler take in account CPU migration costs correctly? I can think 
> of a lot of corner cases, but in general, it seems to me that it's a lot more 
> sane to have the scheduler decide where processes belong. What if an 
> application with n threads, where n is less than the number of CPUs, has to 
> decide which CPUs to bind its threads to? What if a similar app, or another 
> instance of the same app, already decided to bind against the same set of 
> CPUs? The scheduler is stuck with an unfair scheduling load on those poor 
> CPUs, because the scheduling decision was moved away from where it really 
> should take place: the scheduler. I'm sure I'm missing something, though.

It is typically preferred not to force a specific CPU affinity.  Solaris
and NT both allow it, for varying reasons.  One would be if you set
aside a processor for a set of tasks and disallowed all other tasks from
operating there.  This is common with RT (and usually accompanied by
disabling interrupt processing on that CPU and using a fully preemptible
kernel -- i.e. you get complete freedom for the real-time task on the
affined CPU).  This is what Solaris's processor sets try to accomplish,
but IMO they are too heavy and this is why I like Ingo's proposal.  We
already have the cpus_allowed property which we respect, we just need to
let userspace set it.  The question is how?

	Robert Love



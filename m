Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281833AbRKWAVO>; Thu, 22 Nov 2001 19:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281834AbRKWAVE>; Thu, 22 Nov 2001 19:21:04 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:50348 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S281833AbRKWAUs>;
	Thu, 22 Nov 2001 19:20:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Robert Love <rml@tech9.net>
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
Date: Thu, 22 Nov 2001 16:20:11 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0111220951240.2446-300000@localhost.localdomain> <1006472754.1336.0.camel@icbm>
In-Reply-To: <1006472754.1336.0.camel@icbm>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16744i-0004zQ-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 22, 2001 15:45, Robert Love wrote:
>
> Ie, we would have a /proc/<pid>/cpu_affinity which is the same as your
> `unsigned long * user_mask_ptr'.  Reading and writing of the proc
> interface would correspond to your get and set syscalls.  Besides the
> sort of relevancy and useful abstraction of putting the affinity in the
> procfs, it eliminates any sizeof(cpus_allowed) problem since the read
> string is the size in characters of cpus_allowed.
>
> I would use your syscall code, though -- just reimplement it as a procfs
> file. This would mean adding a proc_write function, since the _actual_
> procfs (the proc part) only has a read method, but that is simple.
>
> Thoughts?

 Here here, I was just thinking "Well, I like the CPU affinity idea, but I 
loathe syscall creep... I hope this Robert Love fellow says something about 
that" as I read your email's header.

 In addition to keeping the syscall table from being filled with very 
specific, non-standard, and use-once syscalls, a /proc interface would allow 
me to change the CPU affinity of processes that aren't {get, set}_affinity 
aware (i.e., all Linux applications written up to this point). This isn't 
very different from how it's possible to change a processes other scheduling 
properties (priority, scheduler) from another process. Imagine if renice(8) 
had to be implemented as attaching to a process and calling nice(2)... ick. 

 Also, as an application developer, I try to avoid conditionally compiled, 
system-specific calls. I would have much less "cleanliness" objections 
towards testing for the /proc/<pid>/cpu_affinity files existance and 
conditionally writing to it. Compare this to the hacks some network servers 
use to try to detect sendfile(2)'s presence at runtime, and you'll see what I 
mean. Remember, everything is a file ;)

 And one final thing... what sort of benifit does CPU affinity have if we 
have the scheduler take in account CPU migration costs correctly? I can think 
of a lot of corner cases, but in general, it seems to me that it's a lot more 
sane to have the scheduler decide where processes belong. What if an 
application with n threads, where n is less than the number of CPUs, has to 
decide which CPUs to bind its threads to? What if a similar app, or another 
instance of the same app, already decided to bind against the same set of 
CPUs? The scheduler is stuck with an unfair scheduling load on those poor 
CPUs, because the scheduling decision was moved away from where it really 
should take place: the scheduler. I'm sure I'm missing something, though.

-Ryan 

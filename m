Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUBAEnf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 23:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUBAEnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 23:43:35 -0500
Received: from nevyn.them.org ([66.93.172.17]:21122 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265212AbUBAEnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 23:43:32 -0500
Date: Sat, 31 Jan 2004 23:43:31 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
Message-ID: <20040201044331.GA27271@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>
References: <20040201032525.GA10254@nevyn.them.org> <Pine.LNX.4.58.0401312014420.2033@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401312014420.2033@home.osdl.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 08:38:43PM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 31 Jan 2004, Daniel Jacobowitz wrote:
> >
> > This may be related to the python bug reported today...
> 
> Indeed.
> 
> Having a "waitpid(x, .., WNOHANG)" return 0 is a very interesting 
> condition. That condition basically guarantees that:
> 
>  - the kernel did find the child
>  - but the kernel decided that the child cannot be reaped right then.
> 
> If you see the process as a Zombie in a "ps" listing, then we know that 
> that isn't the reason why it couldn't be reaped. Can you verify that 
> /proc/<pid>/status shows it as "Z (zombie)"?

Yes, it is a zombie when the waitpid is executed.

> In fact, if we see it as "Z (zombie)", we know even more: it means that 
> wait_task_zombie() was never called, because that would have started out 
> with changing the process state to "X (dead)".
> 
> And that in turn implies that "eligible_child()" would have returned 2.
> 
> Which is a normal occurrence: it happens when a process group leader still 
> has threads attached to it. At that point it may be a Zombie, but we can't 
> reap it yet. The threads have to go away before the thing can be reaped.
> 
> Can you verify that that process doesn't have any sub-threads? (Again, 
> that should be easily visible in /proc/<pid>/task/).

It is quite easily visible - in fact, it's hilarious.

 8454 pts/8    Z      0:00 [linux-dp] <defunct>

drow@nevyn:~% ls /proc/8454
auxv  cmdline  cwd@  environ  exe@  fd/  maps  mem  mounts  root@  stat

drow@nevyn:~% ls /proc/8454/task
ls: /proc/8454/task: No such file or directory

What that means I'm not entirely sure.

> Another alternative is that the process is a zombie, but it is being
> traced. When that happens, it shows up on the "ptrace_children" list, and
> we'll see in in wait4(), but we won't be able to reap it. 

At this point it is being traced - this is gdbserver.  But the same
process that is tracing it is calling waitpid.  And the problem
persists after the tracer dies; the process above is actually from a
couple of hours ago, and its tracer was killed.

> Roland, Ingo - have you followed the discussion on linux-kernel? Something 
> strange does seem to be going on..

The only two kernels I've tried were 2.6.0-test7 and 2.6.2-rc3, by the
way - same behavior in both.  I'll try to write a single program
testcase for this.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

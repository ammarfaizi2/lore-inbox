Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUHMTmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUHMTmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUHMTil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:38:41 -0400
Received: from chaos.analogic.com ([204.178.40.224]:20116 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267335AbUHMTgv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:36:51 -0400
Date: Fri, 13 Aug 2004 15:36:34 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Frank van Maarseveen <frankvm@xs4all.nl>
cc: Jesse Pollard <jesse@cats-chateau.net>, Torin Ford <code-monkey@qwest.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.x Fork Problem?
In-Reply-To: <20040813190958.GB18563@janus>
Message-ID: <Pine.LNX.4.53.0408131521550.26183@chaos>
References: <006101c47fff$8feedac0$0200000a@torin> <04081209262700.19998@tabby>
 <20040813190958.GB18563@janus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004, Frank van Maarseveen wrote:

> On Thu, Aug 12, 2004 at 09:26:27AM -0500, Jesse Pollard wrote:
> > On Wednesday 11 August 2004 19:01, Torin Ford wrote:
> > >
> > > pid = fork();
> > > switch (pid)
> > > {
> > >    case -1:
> > >       blah; /* big trouble */
> > >       break;
> > >    case 0: /* Child */
> > >       exit(1);
> > >       break;
> > >    default: /* Parent */
> > >       pid2 = waitpid(pid, &status, 0);
> > >       if (pid2 == -1)
> > >       {
> > >          blah;  /* check out errno */
> > >       }
> > > }
> >
> > Yup - the parent process executed waitpid before the child process finished
> > the setup. This can happen in a multi-cpu environment or even a single, if
> > the scheduler puts the parent process higher than the child in the queue.
>
> ugh! I can follow the rationale for SMP.
>
> But wouldn't this kind of behavior actually break most real world programs?
>
> --
> Frank

When fork() returns with a pid. The pid is valid. It cannot
be that the child doesn't exist yet. This would, as you said,
break everything. What seems to happening is the child calls
exit() before the parent gets the CPU. The child should wait
in exit() until somebody claims its status.

There has never been any guarantee that the child gets the CPU
sooner than the parent. If the parent and child need to synchronize
things, there are lots of ways to do it.

In the above code there is something missing. in the code shown,
the child __will__ wait in exit() until somebody claims its status.
However, the child probably did a setsid(), becoming a process-leader
or the parent set up a SIGCHLD handler before the fork. In these
cases, the exit() will quickly exit because somebody will claim
the exit status.

So, by the time the parent gets the CPU, the child is long gone.
The solution is to use the default SIGCHLD handler if the parent
expects to get the child's status and for the child to not execute
setsid(), which will allow init to reap its status.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbUCCFat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 00:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbUCCFat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 00:30:49 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:34689 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S262365AbUCCFan
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 00:30:43 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>,
       Daniel Jacobowitz <djacobowitz@mvista.com>
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][1/7] Add / use kernel/Kconfig.kgdb
Date: Wed, 3 Mar 2004 11:00:24 +0530
User-Agent: KMail/1.5
Cc: Pavel Machek <pavel@suse.cz>, Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
References: <20040227212301.GC1052@smtp.west.cox.net> <200403011454.35346.amitkale@emsyssoft.com> <4044FEDE.5000105@mvista.com>
In-Reply-To: <4044FEDE.5000105@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403031100.24647.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 Mar 2004 3:08 am, George Anzinger wrote:
> Amit S. Kale wrote:
> > On Saturday 28 Feb 2004 6:38 am, George Anzinger wrote:
> >>Pavel Machek wrote:
> >>>Hi!
> >>>
> >>>>>+config KGDB_THREAD
> >>>>>+	bool "KGDB: Thread analysis"
> >>>>>+	depends on KGDB
> >>>>>+	help
> >>>>>+	  With thread analysis enabled, gdb can talk to kgdb stub to list
> >>>>>+	  threads and to get stack trace for a thread. This option also
> >>>>>enables
> >>>>>+	  some code which helps gdb get exact status of thread. Thread
> >>>>>analysis
> >>>>>+	  adds some overhead to schedule and down functions. You can disable
> >>>>>+	  this option if you do not want to compromise on speed.
> >>>>
> >>>>Lets remove the overhead and eliminate the need for this option in
> >>>> favor of always having threads.  Works in the mm kgdb...
> >>>
> >>>No. Thread analysis is unsuitable for the mainline (manipulates
> >>>sched.c in ugly way). It may be okay for -mm, but in such case it
> >>>should better be separated.
> >>
> >>Not in the -mm version.  I agree that sched.c should NEVER be treated
> >> this way and it is not in the -mm version.  I also think that, most of
> >> the time, it is useful to have the thread stuff, but that may be just my
> >> usage...
> >
> > If threads stuff didn't introduce any unclean code changes, I too would
> > prefer to have it on all the time. As things stands, threads stuff is
> > rather intrusive.
>
> Lets put the threads stuff in the stub.  The only stuff we need in the
> kernel is the flag that indicateds that the pid hash table has been
> initialized.
>
> Meanwhile, I would like to make a change to the gdb "info thread" command
> to do a better job of displaying the threads.  Here is what I am proposing:
>
> Gdb would work as it does now if the following set is not done.
>
> A new "set thread_level" command that would take the "bt" level to use on
> the thread display.
> A new "set thread_limits command that would take two expressions that would
> reduce to two memory addresses.
>
> Which ever of these is entered last will be active and used by "info
> thread" as follows:
>
> if thread_level is active gdb will do the indicated number of  "up"
> operations and display the result on the info thread line for that thread
> (note there is other info on this line that will not be changed).

You can already do a backtrace on all threads using gdb command
"thread apply all backtrace".

>
> if thread_limits is active gdb will do 0 or more "up" commands until the
> resultant PC is NOT between the given limits.

How does a user specify PC? There are umpteen number of kernel entry points 
(irqs, exceptions, system calls).

> The kernel, at this time, has defined symbols for the thread_limits command
> (it is used in the kernel for its internal display of threads).  I would
> expect that the thread_level version would be the answer for theaded
> application programs.
>
> Daniel, how does this sound?


The problem with kernel backtraces not stopping at kernel entry points is a 
tough one. gdbmod at kgdb.sourceforge.net attempts to do that. This gdb 
detects if we are debugging a kernel. If we are, a few things kick in like 
scanning of modules instead of .so libraries and stopping backtraces earlier.

GDB uses main as the function where backtraces stop unless overridden. This is 
broken by definition for multithreaded programs becauses non initial threads 
don't start from main. Kernel too doesn't have main and has several entry 
points.

If there is a way for gdb to know entry points from the kernel, it would be 
very easy to maintain. Say a .entrypoint section that lists pc ranges of 
entry points. GDB then stop a backtrace as soon as it enters one of these 
ranges.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)


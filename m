Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264472AbSIVS6V>; Sun, 22 Sep 2002 14:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264479AbSIVS6V>; Sun, 22 Sep 2002 14:58:21 -0400
Received: from nameservices.net ([208.234.25.16]:56551 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S264472AbSIVS6U>;
	Sun, 22 Sep 2002 14:58:20 -0400
Message-ID: <3D8E14B6.F98A86E4@opersys.com>
Date: Sun, 22 Sep 2002 15:06:30 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
References: <Pine.LNX.4.44.0209221222060.21475-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Ingo,

Thanks for taking the time to look at this.

Ingo Molnar wrote:
> my problem with this stuff is conceptual: it introduces a constant drag on
> the kernel sourcecode, while 99% of development will not want to trace,
> ever.

It seems my description was misleading. So here's the skinny: LTT's main
purpose is to enable users and developers to observe the system's dynamics
in order to retrieve exact information regarding the behavior of the
entire system WITHOUT modifying the system's behavior or degrading the
system's performance. In turn, this can be used for identifying
synchronization and performance problems. In doing so, however, the services
implemented by LTT in the kernel happen to be quite useful to many other
kernel subsystems and device drivers since they too occasionnally need
tracing.

Here are some actual practical cases:
- How do you debug process synchronization problems in user-space? You
can't use anything that calls on ptrace() since it modifies the
processes' behavior and you can't use printf's for anything the least
bit complicated. The only way you can do this is if you use a tracing
tool such as LTT that enables you to see which services were called,
what happened as a consequence of the processes' requests, and where
the synchronization failed.
- How do you measure the exact time processes spend in kernel space,
identify why they spend it there, which processes they had to wait
for, etc.?
- How do you measure the exact time it takes for an interrupt's
effects to propagate through the entire system?  As a simple example, say
you want to follow the exact sequence of processes that run from the
moment you press a key on the keyboard until a character shows up in
the command terminal in X. LTT will shows this quite easily.
- Take tools like oprofile and syscalltrack which need the same
information available through the trace points added by LTT. Instead
of diverting the system call table, as they currently do, they could
retrieve the information they need easily from LTT without using
clean interfaces and no table redirection.
- Say you have thousands of servers in an installation and one of them
has some sporadic problem. How are you going to debug this sytem?
Should the sysadmin be expected to download the kernel's source, patch
it for tracing and restart the system to find the problem? Rather,
wouldn't it be simpler if he could run the tracing in the background
for the time until the problem occurs and then look at the trace to
see what's the real problem before digging deeper?
- etc.

Do I think that the kernel should be instrumented in a way that it is
"a constant drag on the kernel sourcecode"? No. This is why the trace points
inserted really have more to do with the way a classic Unix kernel is
structured (system calls, process switching, forks, execs, ...) than
anything peculiar to Linux's source code. Hence, you could reimplement
the entire Linux source an entirely different way, you would still find
those very same events taking place. Also, all these trace points result
in zero code if the kernel is compilled without tracing support.

For adding additional trace points wherever you want, you can use
kernel probes to add them dynamically (kprobes already interfaces with
LTT and is slated to go in 2.5) or you can use the custom even API
available from LTT to create your own events and logging them as
part of the trace.

In brief, no LTT isn't a kernel debugging tool, but yes its integration
into the kernel would certainly help subsystems that do need this sort
of service.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================

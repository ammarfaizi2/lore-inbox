Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbWECI4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbWECI4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 04:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbWECI4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 04:56:13 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:45907 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S965126AbWECI4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 04:56:12 -0400
Subject: Re: [ck] 2.6.16-ck9
From: Juho Saarikko <juhos@mbnet.fi>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
In-Reply-To: <200605030801.05523.kernel@kolivas.org>
References: <200605022338.20534.kernel@kolivas.org>
	 <1146603461.5213.32.camel@a88-112-69-25.elisa-laajakaista.fi>
	 <200605030801.05523.kernel@kolivas.org>
Content-Type: text/plain
Organization: 
Message-Id: <1146646484.4260.6.camel@a88-112-69-25.elisa-laajakaista.fi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 May 2006 11:54:44 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 01:01, Con Kolivas wrote:
> On Wednesday 03 May 2006 06:57, Juho Saarikko wrote:
> > I tried to run SetiAtHome at IDLEPRIO, but it competes equally with a
> > while(1); loop run at nice 19. I'm starting to wonder if there isn't
> > some kind of bug in the kernel which results in a program returning from
> > a system call with an in-kernel semaphore held. After all, according to
> > top, SetiAtHome consumes over 90% CPU, and the system consumes only
> > about 1%, so it can't be making system calls all the time either. Or
> > maybe there's some case where the calculations can become confused and
> > think that a semaphore is still being held when it's not.
> >
> > Is there any way to test this ?
> >
> > Anyway, I ran strace on FahCore (a program, launched by SetiAtHome main
> > program, that actually consumes the CPU), and got this:
> >
> >
> > rt_sigprocmask(SIG_BLOCK, [CHLD], [RTMIN], 8) = 0
> > rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
> > rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
> > nanosleep({5, 0}, {5, 0})               = 0
> > nanosleep({0, 0}, NULL)                 = 0
> >
> >
> > This pattern just keeps on repeating, endlessly. Occasionally it also
> > has
> >
> > kill(5432, SIG_0)                       = 0
> >
> > attached to it. 5432 is the parent process, the FAH502-Linux.exe.
> >
> > There is something very strange going on here...
> 
> Find all the threads running with this command:
> ps -wweALo spid,user,priority,ni,pcpu,vsize,time,args

My version of ps doesn't seem to support spid, but by dropping it I got
the thread pids anyway.

> The spid will show you any threads with different pids to the main task. Then 
> check the actual scheduling policy they run at. Perhaps FahCore actually 
> manually sets them to SCHED_NORMAL.

And so it does. Annoying. Time to hack kernel to add a new scheduling
policy, SCHED_STAYIDLE, which is like SCHED_IDLE but cannot be unset
except by root.

Can't make it the default, since a program running at SCHED_IDLE in a
machine with 100% CPU usage by some other program will never process
SIGKILL, and thus can only be killed by setting its scheduling policy to
normal...

Darn obnoxious program, SetiAtHome...


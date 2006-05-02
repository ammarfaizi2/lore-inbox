Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbWEBWBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWEBWBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 18:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWEBWBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 18:01:14 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:60551 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965015AbWEBWBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 18:01:13 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Juho Saarikko <juhos@mbnet.fi>
Subject: Re: [ck] 2.6.16-ck9
Date: Wed, 3 May 2006 08:01:05 +1000
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
References: <200605022338.20534.kernel@kolivas.org> <1146603461.5213.32.camel@a88-112-69-25.elisa-laajakaista.fi>
In-Reply-To: <1146603461.5213.32.camel@a88-112-69-25.elisa-laajakaista.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605030801.05523.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 May 2006 06:57, Juho Saarikko wrote:
> On Tue, 2006-05-02 at 16:38, Con Kolivas wrote:
> > These are patches designed to improve system responsiveness and
> > interactivity. It is configurable to any workload but the default ck
> > patch is aimed at the desktop and cks is available with more emphasis on
> > serverspace.
> >
> > THESE INCLUDE THE PATCHES FROM 2.6.16.12 SO START WITH 2.6.16 AS YOUR
> > BASE
> >
> > Apply to 2.6.16
> > http://www.kernel.org/pub/linux/kernel/people/ck/patches/2.6/2.6.16/2.6.1
> >6-ck9/patch-2.6.16-ck9.bz2
> >
> > or server version
> > http://www.kernel.org/pub/linux/kernel/people/ck/patches/cks/patch-2.6.16
> >-cks9.bz2
> >
> > web:
> > http://kernel.kolivas.org
> >
> > all patches:
> > http://www.kernel.org/pub/linux/kernel/people/ck/patches/
> >
> > Split patches available.
> >
> >
> > Changes since 2.6.16-ck8:
> >
> > Added:
> >  +sched-fix_idleprio.patch
> > A small bug crept in that prevented SCHED_IDLEPRIO tasks from being
> > scheduled normally when they held a semaphore making it possible to
> > livelock. This fixes it.
>
> Hmm...
>
> I tried to run SetiAtHome at IDLEPRIO, but it competes equally with a
> while(1); loop run at nice 19. I'm starting to wonder if there isn't
> some kind of bug in the kernel which results in a program returning from
> a system call with an in-kernel semaphore held. After all, according to
> top, SetiAtHome consumes over 90% CPU, and the system consumes only
> about 1%, so it can't be making system calls all the time either. Or
> maybe there's some case where the calculations can become confused and
> think that a semaphore is still being held when it's not.
>
> Is there any way to test this ?
>
> Anyway, I ran strace on FahCore (a program, launched by SetiAtHome main
> program, that actually consumes the CPU), and got this:
>
>
> rt_sigprocmask(SIG_BLOCK, [CHLD], [RTMIN], 8) = 0
> rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
> rt_sigprocmask(SIG_SETMASK, [RTMIN], NULL, 8) = 0
> nanosleep({5, 0}, {5, 0})               = 0
> nanosleep({0, 0}, NULL)                 = 0
>
>
> This pattern just keeps on repeating, endlessly. Occasionally it also
> has
>
> kill(5432, SIG_0)                       = 0
>
> attached to it. 5432 is the parent process, the FAH502-Linux.exe.
>
> There is something very strange going on here...

Find all the threads running with this command:
ps -wweALo spid,user,priority,ni,pcpu,vsize,time,args

The spid will show you any threads with different pids to the main task. Then 
check the actual scheduling policy they run at. Perhaps FahCore actually 
manually sets them to SCHED_NORMAL

do:
schedtool $spid
of each thread to see what policy it is.

-- 
-ck

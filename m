Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbUDAPWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 10:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUDAPWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 10:22:21 -0500
Received: from zigzag.lvk.cs.msu.su ([158.250.17.23]:14055 "EHLO
	zigzag.lvk.cs.msu.su") by vger.kernel.org with ESMTP
	id S262924AbUDAPWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 10:22:06 -0500
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: Strange 'zombie' problem both in 2.4 and 2.6
Date: Thu, 1 Apr 2004 19:20:54 +0400
User-Agent: KMail/1.5.4
References: <200404011442.18078@zigzag.lvk.cs.msu.su> <200404011617.08261.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200404011617.08261.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WNDbA0WlVbQjFLz"
Message-Id: <200404011920.55030@zigzag.lvk.cs.msu.su>
X-Scanner: exiscan *1B93zz-0005wy-00*GeWvfmqb1GE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_WNDbA0WlVbQjFLz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> > Some time ago I was faced with a strange problem in 2.4 kernel.
> > I could reproduce in only on one system - a production 2-CPU server
> > that is used as LTSP server here and also runs tons of services and
> > MUST be always up.
> >
> > The problem is the following.
> > Server runs normally (and uptime may be already several weeks, but may
> > be only several hours).
> > Suddenly something happens.
> > And process table becomes full of zombies.
> > Looks like any thread created by any program becomes a zombie when
> > finished. Same programs (actually, same running processes) join()ed
> > finished threads correctly before Something Happened. So it looks very
> > much that Something happens inside the kernel.
> > Affected programs include mozilla, clamav, mysqld, licq and anything
> > else that creates short-living threads, or at least threads that live
> > shorter than program itself.
>
> How does ps -AH e looks like?

See output of "ps -lax" in attachment.

> > It looks like at some moment kernel looses the abitily to inform
> > process that their threads are over. AKAIK, this is done by SIGCHLD?
> > Anyway, manual sending SIGCHLD to the parent of zombies does not help.
>
> Did you try stracing parent process? It can receive SIGCHLD but
> ignore/mishandle it.

I tried to use strace -f, so all threads exist in the output. No signals 
arrive, expect those send manually by kill().
Stracing same binary on another host shows that SIGRT_1 arrives to the 
parent.
I may send the strace logs, but they are somewhat large.
So kernel really stops devivering signals.

As far as I understand, in case of threads SIGRT_1 is used instead of 
SIGCHLD.
So I tried to send SIGRT_1 to the parent manually. And zombies disappeared!
However, new zombies appear soon. They may still be removed by manual 
SIGRT_1, but it is not a solution for a kernel bug :).

> > After the problem happens, server becomes unusable (because of process
> > table overflow) in several minutes. One time Something Else happened,
> > and all those zombies disappeared. In all other cases a reboot was
> > required.
> >
> > If the process that created those "zombie thread" is terminated (i.e.
> > sevice stopped), all his zombies disappear. However, after service is
> > restarted, zombies become to appear again.
>
> Probably they get reparented to init and it wait()'s for them,
> ending their afterlife. So SIGCHLD works (at least in this case).

Seems that signal passing works only after reparenting zombies.

> > Athough I tried, I could not find any correlation between making
> > system to this "zombie-keeping" state and anything else happenning
> > with the system. Looks like that running java apps (with blackdown
> > jdk) makes this happen more often, bot still no direct correlation.
> >
> > The problem happened with official 2.4.23, 2.4.24 and 2.4.25 kernels,
> > compiled from kernel.org sources.
> >
> > Yestedray I was tired with this zombie problem (it arised twice during
> > this week), and decided to upgrade server to kernel 2.6.
> > I installed 2.6.4 kernel from the Debain kernel-image-2.6.4-1-k7-smp
> > package.
> >
> > Unfortunately, this did not eliminate the problem: it happened today
> > again. The difference is that when running in 2.6, most binaries use
> > NPTL libs from /lib/i686/cmov/, and seem not to be affected by the
> > problem (i.e. no zombies from them). However, users need to run some
> > statically-linked binaries (without source available) that have
> > non-NPTL libs statically linked and so still use linuxthreads; those
> > are affected (i.e. do create zombies). So problem is not rendering
> > server unusable (so it no longer that critical), but it still exists
> > in the 2.6 kernel.
>
> Sounds like userspace problem in threading libraries.
> What version of glibc/linuxthreads was in use before?
> Maybe post your report on linuxthreads mailing list.

I doubt it is a userspace problem.
It happens with the same userspace libs and binaries (or even same running 
processes) with which it did not happen sometime ago.
It happens at the same moment with different processes running from 
different accounts.
Restarting processes doesn't help.
It is not reprodusable on other hosts.
Manual signal send (kill -33 <parentpid>) removes already existing zombies.
I can hardly imagine a userspace problem that behaves like this.

Nikita

--Boundary-00=_WNDbA0WlVbQjFLz
Content-Type: text/plain;
  charset="us-ascii";
  name="ps"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ps"

0   206 18992     1  16   0 50512 1600 schedu S    ?          0:00 /space/p2/n/donkey/donkey0.50.1 - ! -g -l
1   206 18993 18992  16   0 50512 1600 schedu S    ?          0:00 /space/p2/n/donkey/donkey0.50.1 - ! -g -l
1   206 18994 18993  15   0 50512 1600 schedu S    ?          0:00 /space/p2/n/donkey/donkey0.50.1 - ! -g -l
1   206 18995 18993  18   0 50512 1600 io_sch D    ?          0:31 /space/p2/n/donkey/donkey0.50.1 - ! -g -l
1   206 18996 18993  16   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19021 18993  15   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19068 18993  16   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19069 18993  15   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19070 18993  15   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19071 18993  15   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19072 18993  15   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19073 18993  16   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19074 18993  15   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19077 18993  15   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19078 18993  16   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19090 18993  15   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19091 18993  15   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19092 18993  15   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19093 18993  16   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19094 18993  15   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19095 18993  16   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19096 18993  16   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19107 18993  15   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19108 18993  15   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
1   206 19111 18993  16   0     0    0 exit   Z    ?          0:00 [donkey0.50.1] <defunct>
0   206 19123 19080  15   0  2940  748 pipe_w S    pts/254    0:00 grep donkey

--Boundary-00=_WNDbA0WlVbQjFLz--


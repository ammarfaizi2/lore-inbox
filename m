Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUDANU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 08:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbUDANTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 08:19:31 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:2827 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262903AbUDANR3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 08:17:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>, linux-kernel@vger.kernel.org
Subject: Re: Strange 'zombie' problem both in 2.4 and 2.6
Date: Thu, 1 Apr 2004 16:17:08 +0300
X-Mailer: KMail [version 1.4]
References: <200404011442.18078@zigzag.lvk.cs.msu.su>
In-Reply-To: <200404011442.18078@zigzag.lvk.cs.msu.su>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200404011617.08261.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 April 2004 13:42, Nikita V. Youshchenko wrote:
> Hello.
>
> Some time ago I was faced with a strange problem in 2.4 kernel.
> I could reproduce in only on one system - a production 2-CPU server that is
> used as LTSP server here and also runs tons of services and MUST be always
> up.
>
> The problem is the following.
> Server runs normally (and uptime may be already several weeks, but may be
> only several hours).
> Suddenly something happens.
> And process table becomes full of zombies.
> Looks like any thread created by any program becomes a zombie when
> finished. Same programs (actually, same running processes) join()ed
> finished threads correctly before Something Happened. So it looks very
> much that Something happens inside the kernel.
> Affected programs include mozilla, clamav, mysqld, licq and anything else
> that creates short-living threads, or at least threads that live shorter
> than program itself.

How does ps -AH e looks like?

> It looks like at some moment kernel looses the abitily to inform process
> that their threads are over. AKAIK, this is done by SIGCHLD? Anyway,
> manual sending SIGCHLD to the parent of zombies does not help.

Did you try stracing parent process? It can receive SIGCHLD but
ignore/mishandle it.

> After the problem happens, server becomes unusable (because of process
> table overflow) in several minutes. One time Something Else happened, and
> all those zombies disappeared. In all other cases a reboot was required.
>
> If the process that created those "zombie thread" is terminated (i.e.
> sevice stopped), all his zombies disappear. However, after service is
> restarted, zombies become to appear again.

Probably they get reparented to init and it wait()'s for them,
ending their afterlife. So SIGCHLD works (at least in this case).

> Athough I tried, I could not find any correlation between making system to
> this "zombie-keeping" state and anything else happenning with the system.
> Looks like that running java apps (with blackdown jdk) makes this happen
> more often, bot still no direct correlation.
>
> The problem happened with official 2.4.23, 2.4.24 and 2.4.25 kernels,
> compiled from kernel.org sources.
>
> Yestedray I was tired with this zombie problem (it arised twice during this
> week), and decided to upgrade server to kernel 2.6.
> I installed 2.6.4 kernel from the Debain kernel-image-2.6.4-1-k7-smp
> package.
>
> Unfortunately, this did not eliminate the problem: it happened today again.
> The difference is that when running in 2.6, most binaries use NPTL libs
> from /lib/i686/cmov/, and seem not to be affected by the problem (i.e. no
> zombies from them). However, users need to run some statically-linked
> binaries (without source available) that have non-NPTL libs statically
> linked and so still use linuxthreads; those are affected (i.e. do create
> zombies). So problem is not rendering server unusable (so it no longer
> that critical), but it still exists in the 2.6 kernel.

Sounds like userspace problem in threading libraries.
What version of glibc/linuxthreads was in use before?
Maybe post your report on linuxthreads mailing list.

> I can't reproduce the problem on any other host. And the affected system is
> a production server that is somewhat difficult to use for debugging :(
> It is a dual-K7 server with Tyan Tiger MPX S2466 motherboard and 2 Gb of
> ram. Output of 'lspci -vv' and 'cat /proc/cpuinfo' is attached. I may
> provide any other technical information.
>
> I'm a seasoned unix developer and sysadmin, and have some kernel hacking
> experience. However, I don't work with the kernel currently, so I am not
> "in context of" kernel internals.
> So I'm looking either for a fix :), or for some advice on what to do with
> this (i.e. where to look in the kernel code and what to look for).
-- 
vda

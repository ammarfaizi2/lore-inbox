Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbUDAQJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbUDAQJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:09:42 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:39435 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262941AbUDAQJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:09:39 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>, linux-kernel@vger.kernel.org
Subject: Re: Strange 'zombie' problem both in 2.4 and 2.6
Date: Thu, 1 Apr 2004 19:09:20 +0300
User-Agent: KMail/1.5.4
References: <200404011442.18078@zigzag.lvk.cs.msu.su> <200404011617.08261.vda@port.imtp.ilyichevsk.odessa.ua> <200404011920.55030@zigzag.lvk.cs.msu.su>
In-Reply-To: <200404011920.55030@zigzag.lvk.cs.msu.su>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404011909.20671.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > It looks like at some moment kernel looses the abitily to inform
> > > process that their threads are over. AKAIK, this is done by SIGCHLD?
> > > Anyway, manual sending SIGCHLD to the parent of zombies does not help.
> >
> > Did you try stracing parent process? It can receive SIGCHLD but
> > ignore/mishandle it.
>
> I tried to use strace -f, so all threads exist in the output. No signals
> arrive, expect those send manually by kill().
> Stracing same binary on another host shows that SIGRT_1 arrives to the
> parent.
> I may send the strace logs, but they are somewhat large.
> So kernel really stops devivering signals.

Post reasonably small pieces of them.

> As far as I understand, in case of threads SIGRT_1 is used instead of
> SIGCHLD.
> So I tried to send SIGRT_1 to the parent manually. And zombies disappeared!
> However, new zombies appear soon. They may still be removed by manual
> SIGRT_1, but it is not a solution for a kernel bug :).

Maybe. Maybe not. I am no expert, I'd try to learn out how SIGRT_1
is generated in normal case (I suppose kernel does not distinguish
between threads and processes, maybe it's done by threading libs?)

> > Probably they get reparented to init and it wait()'s for them,
> > ending their afterlife. So SIGCHLD works (at least in this case).
>
> Seems that signal passing works only after reparenting zombies.
>
> > > Unfortunately, this did not eliminate the problem: it happened today
> > > again. The difference is that when running in 2.6, most binaries use
> > > NPTL libs from /lib/i686/cmov/, and seem not to be affected by the
> > > problem (i.e. no zombies from them). However, users need to run some
> > > statically-linked binaries (without source available) that have
> > > non-NPTL libs statically linked and so still use linuxthreads; those
> > > are affected (i.e. do create zombies). So problem is not rendering
> > > server unusable (so it no longer that critical), but it still exists
> > > in the 2.6 kernel.
> >
> > Sounds like userspace problem in threading libraries.
> > What version of glibc/linuxthreads was in use before?
> > Maybe post your report on linuxthreads mailing list.
>
> I doubt it is a userspace problem.
> It happens with the same userspace libs and binaries (or even same running
> processes) with which it did not happen sometime ago.
> It happens at the same moment with different processes running from
> different accounts.
> Restarting processes doesn't help.
> It is not reprodusable on other hosts.
> Manual signal send (kill -33 <parentpid>) removes already existing zombies.
> I can hardly imagine a userspace problem that behaves like this.

I won't argue. One thing is clear: not enough info at this time :(

Try to instrument (printk("...")) parts of kernel responsible for
handling exit() etc.
--
vda
>
> Nikita


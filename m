Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132696AbRC2Jai>; Thu, 29 Mar 2001 04:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132694AbRC2Ja3>; Thu, 29 Mar 2001 04:30:29 -0500
Received: from irmgard.exp-math.uni-essen.de ([132.252.150.18]:38663 "EHLO
	irmgard.exp-math.uni-essen.de") by vger.kernel.org with ESMTP
	id <S132696AbRC2JaS>; Thu, 29 Mar 2001 04:30:18 -0500
Date: Thu, 29 Mar 2001 11:29:34 +0200 (MESZ)
From: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Szabolcs Szakacsits <szaka@f-secure.com>,
   Martin Dalecki <dalecki@evision-ventures.com>,
   Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
   Jonathan Morton <chromi@cyberspace.org>,
   Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: OOM killer???
In-Reply-To: <200103282138.f2SLcT824292@webber.adilger.int>
Message-Id: <Pine.A32.3.95.1010329111147.63156A-100000@werner.exp-math.uni-essen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2001, Andreas Dilger wrote:

> Szaka writes:
> > On Tue, 27 Mar 2001, Andreas Dilger wrote:
> > > Every time this subject comes up, I point to AIX and SIGDANGER - a signal
> > > sent to processes when the system gets OOM.
> > 
> > And every time the SIGDANGER comes up, the issue that AIX provides
> > *both* early and late allocation mechanism even on per-process basis
> > that can be controlled by *both* the programmer and the admin is
> > completely ignored. Linux supports none of these...

Maybe some details here were helpful. Are you referring to
madvise()/mlock? Maybe malloc and friends could be modified to reserve
newly allocate pages. For things like fork()/exec() a new flag is
probably required to ensure this, or the new process could actually
run a syscall first to ensure all memory can be accessed.

> If Linux provided both of those, then people would probably already be
> happy.

Probably.

> 
> > ...with the current model it's quite possible the handler code is still
> > sitting on the disk and no memory will be available to page it in.
> 
> Actually, I see SIGDANGER being useful at the time we hit freepages.min
> (or maybe even freepages.low), rather than actual OOM so that the apps
> have a chance to DO something about the memory shortage, rather than just
> waiting around to die.
> 
> On AIX, if a process gets SIGDANGER without a registered signal handler,
> the process is terminated.  It would be nice to send SIGDANGER to

Not right. AIX has two lowlevel marks, if I understand the thread right,
we would use freepages.low and freepages.min.

If freepages.low is hit, a SIGDANGER is sent to all processes. The signal
is *ignored by default*. In the handler, an easy to use syscall (no
odd /proc file parsing (really, I don't like this bloatage, if I could I
would disable it for its security issues in certain places, at least in
the past, but it is no longer possible to live w/o it) can be used to
learn about the pages left. If it's not clear that SIGDANGER is only
triggered by oom we should have a nice syscall/libcall
like is_paging_space_low().

If freepages.min is reached, AIX starts to kill processes (just like OOM
killer). It uses some heuristics which might be better than our, but I
doubt it. Probably background (no ctty) and long running processes should
be preserved if possible. short term running, interactive progs can
typically just be restarted, but loosing one weeks computation is bad
(now a sensible application should actually checkpoint itself).
AIX also often kills the wrong process: Typical situation here: user A
runs a long running experiment, user B logs in, doesn't check load of the
machine, starts a too large application and user A's appl. dies while the
one of B survices for half an hour and dies too. 

The OOM killer of AIX honours catching SIGDANGER. It kills those procs
last. A nice trick is to make a no_op handler for it. This will have your
proc die last.

Michael.

--

Michael Weller: eowmob@exp-math.uni-essen.de, eowmob@ms.exp-math.uni-essen.de,
or even mat42b@spi.power.uni-essen.de. If you encounter an eowmob account on
any machine in the net, it's very likely it's me.


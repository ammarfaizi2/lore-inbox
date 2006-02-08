Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWBHKml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWBHKml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 05:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWBHKml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 05:42:41 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:64997 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1030286AbWBHKmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 05:42:40 -0500
Subject: Re: preempt-rt, NUMA and strange latency traces
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.58.0602080436190.8578@gandalf.stny.rr.com>
References: <1139311689.19708.36.camel@frecb000686>
	 <Pine.LNX.4.58.0602080436190.8578@gandalf.stny.rr.com>
Date: Wed, 08 Feb 2006 11:45:34 +0100
Message-Id: <1139395534.21471.13.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/02/2006 11:43:27,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/02/2006 11:43:31
Content-Type: multipart/mixed; boundary="=-a4XM84mf+f0wbD2xXnAX"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a4XM84mf+f0wbD2xXnAX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-15

On Wed, 2006-02-08 at 04:41 -0500, Steven Rostedt wrote:
> On Tue, 7 Feb 2006, S=E9bastien Dugu=E9 wrote:
>=20
> >   Hi,
> >
> >   I've been experimenting with 2.6.15-rt16 on a dual 2.8GHz Xeon box
> > with quite good results and decided to make a run on a NUMA dual node
> > IBM x440 (8 1.4GHz Xeon, 28GB ram).
> >
> >   However, the kernel crashes early when creating the slabs. Does the
> > current preempt-rt patchset supports NUMA machines or has support
> > been disabled until things settle down?
>=20
> Yeah, currently the -rt patch doesn't work well with NUMA.

  OK, I'll have to wait for that I guess.

>=20
> >
> >   Going on, I compiled a non NUMA RT kernel which booted just fine,
> > but when examining the latency traces, I came upon strange jumps
> > in the latencies such as:
> >
> >
> >    <...>-6459  2D.h1   42us : rcu_pending (update_process_times)
> >    <...>-6459  2D.h1   42us : scheduler_tick (update_process_times)
> >    <...>-6459  2D.h1   43us : sched_clock (scheduler_tick)
> >    <...>-6459  2D.h1   44us!: _raw_spin_lock (scheduler_tick)
> >    <...>-6459  2D.h2 28806us : _raw_spin_unlock (scheduler_tick)
> >    <...>-6459  2D.h1 28806us : rebalance_tick (scheduler_tick)
> >    <...>-6459  2D.h1 28807us : irq_exit (smp_apic_timer_interrupt)
> >    <...>-6459  2D..1 28808us < (608)
> >    <...>-6459  2D..1 28809us : smp_apic_timer_interrupt (c03e2a02 0 0)
> >    <...>-6459  2D.h1 28810us : handle_nextevent_update (smp_apic_timer_=
interrupt)
> >    <...>-6459  2D.h1 28810us : hrtimer_interrupt (handle_nextevent_upda=
te)
>=20
> Hmm, are the TSC of the CPUS in sync?  If not, you will get bad
> messurements of the latency tracer.  That is currently why we can't use
> tracing with x86_64 x2 CPUS.
>=20
> >
> >   There does not seem to be a precise code path leading to those jumps,
> > it seems
> > they can appear anywhere. Furthermore the jump seems to always be of ~ =
27 ms
> >
> >   I tried running on only 1 CPU, tried using the TSC instead of the cyc=
lone
> > timer but to no avail, the phenomenon is still there.
>=20
> OK, this scares me.  You get these with only one CPU?  Is it still
> compiled for SMP?  If not, see if the latencies go away if you turn off
> SMP.

  Yes the kernel is still compiled for SMP. An UP compiled kernel did
not boot. I will try to fix it and go for it again.

>=20
>  >
> >   My test program only consists in a thread running at max RT priority =
doing
> > a nanosleep().
> >
> >   What could be going on here?
>=20
> Good question.  Could you send your .config

  The more I think about it, the more I tend to believe it's hardware=20
related. It seems as if the CPU just hangs for ~27 ms before
resuming processing.

  Anyway, here is my .config. Maybe I've got something misconfigured
somewhere after all.

  Thanks for replying.




--=-a4XM84mf+f0wbD2xXnAX
Content-Disposition: attachment; filename=config-2.6.15-rt16-no-numa.gz
Content-Type: application/x-gzip; name=config-2.6.15-rt16-no-numa.gz
Content-Transfer-Encoding: base64

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
Xpaal4Ut0eoCa0ZEAmeF/wEQG0iSdnIAAA==

--=-a4XM84mf+f0wbD2xXnAX--


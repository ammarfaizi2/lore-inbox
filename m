Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbTLWB7b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 20:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264892AbTLWB7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 20:59:31 -0500
Received: from fmr05.intel.com ([134.134.136.6]:42386 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264889AbTLWB72 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 20:59:28 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] 2.6.0 batch scheduling, HT aware
Date: Mon, 22 Dec 2003 17:59:12 -0800
Message-ID: <7F740D512C7C1046AB53446D372001736187E4@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.0 batch scheduling, HT aware
Thread-Index: AcPI8dJLBElwNszRR+SgyAczkIXh+gAAsTzw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Nick Piggin" <piggin@cyberone.com.au>
Cc: "Con Kolivas" <kernel@kolivas.org>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Dec 2003 01:59:13.0408 (UTC) FILETIME=[5CFDB000:01C3C8F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today utilization of execution resources of a logical processor is
around 60% as you can find in public papers, and it's dependent on the
processor implementation and the workload. It could be higher in the
future, and their relative priority could be much higher then. So I
don't think it's a good idea to hard code such a implementation-specific
factor into the generic scheduler code.

Regarding H/W-based priority, I'm not sure it's very useful especially
because so many events happen inside the processor and a set of the
execution resources required changes very rapidly at runtime, i.e. the
H/W knows what it should do to run faster at runtime, and imposing
priority on those logical processor could make them run slower.

I think a software priority-based solution like the below would be more
generic and work better.
> How about this: if a task is "delta" priority points below a task
running
> on another sibling, move it to that sibling (so priorities via
timeslice
> start working). I call it active unbalancing! I might be able to make
it
> fit if there is interest. Other suggestions?

Jun


> -----Original Message-----
> From: Nick Piggin [mailto:piggin@cyberone.com.au]
> Sent: Monday, December 22, 2003 5:11 PM
> To: Nakajima, Jun
> Cc: Con Kolivas; linux kernel mailing list
> Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
> 
> 
> 
> Con Kolivas wrote:
> 
> >I've done a resync and update of my batch scheduling that is also
hyper-
> thread
> >aware.
> >
> >What is batch scheduling? Specifying a task as batch allows it to
only
> use cpu
> >time if there is idle time available, rather than having a proportion
of
> the
> >cpu time based on niceness.
> >
> >Why do I need hyper-thread aware batch scheduling?
> >
> >If you have a hyperthread (P4HT) processor and run it as two logical
cpus
> you
> >can have a very low priority task running that can consume 50% of
your
> >physical cpu's capacity no matter how high priority tasks you are
running.
> >For example if you use the distributed computing client setiathome
you
> will
> >be effectively be running at half your cpu's speed even if you run
> setiathome
> >at nice 20. Batch scheduling for normal cpus allows only idle time to
be
> used
> >for batch tasks, and for HT cpus only allows idle time when both
logical
> cpus
> >are idle.
> >
> >This is not being pushed for mainline kernel inclusion, but the issue
of
> how
> >to prevent low priority tasks slowing down HT cpus needs to be
considered
> for
> >the mainline HT scheduler if it ever gets included. This patch
provides a
> >temporising measure for those with HT processors, and a demonstrative
way
> to
> >handle them in mainline.
> >
> 
> I wonder how does Intel suggest we handle this problem? Batch
scheduling
> aside, I wonder how to do any sort of priorities at all? I think
POWER5
> can do priorities in hardware, that is the only sane way I can think
of
> doing it.
> 
> I think this patch is much too ugly to get into such an elegant
scheduler.
> No fault to you Con because its an ugly problem.
> 
> How about this: if a task is "delta" priority points below a task
running
> on another sibling, move it to that sibling (so priorities via
timeslice
> start working). I call it active unbalancing! I might be able to make
it
> fit if there is interest. Other suggestions?
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVANCF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVANCF7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 21:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVANCF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 21:05:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.190]:34775 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261382AbVANCFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:05:49 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: utz lehmann <lkml@s2y4n2c.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, "Jack O'Quin" <joq@io.com>,
       Chris Wright <chrisw@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       Matt Mackall <mpm@selenic.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       LKML <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1105651508.3457.31.camel@krustophenia.net>
References: <20050111214152.GA17943@devserv.devel.redhat.com>
	 <200501112251.j0BMp9iZ006964@localhost.localdomain>
	 <20050111150556.S10567@build.pdx.osdl.net> <87y8ezzake.fsf@sulphur.joq.us>
	 <20050112074906.GB5735@devserv.devel.redhat.com>
	 <87oefuma3c.fsf@sulphur.joq.us>
	 <20050113072802.GB13195@devserv.devel.redhat.com>
	 <878y6x9h2d.fsf@sulphur.joq.us>
	 <20050113210750.GA22208@devserv.devel.redhat.com>
	 <1105651508.3457.31.camel@krustophenia.net>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 03:05:19 +0100
Message-Id: <1105668319.15692.16.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 16:25 -0500, Lee Revell wrote:
> On Thu, 2005-01-13 at 22:07 +0100, Arjan van de Ven wrote:
> > On Thu, Jan 13, 2005 at 03:04:26PM -0600, Jack O'Quin wrote:
> > > 
> > > (Probably, this simplistic analysis misses some other, more subtle,
> > > factors.)
> > 
> > I think you can do nasty things to the locks held by those threads too
> > 
> > > 
> > > RT threads should not do FS writes of their own.  But, a badly broken
> > > or malicious one could, I suppose.  So, that might provide a mechanism
> > > for losing more data than usual.  Is that what you had in mind?
> > 
> > basically yes.
> > note that "FS writes" can come from various things, including library calls
> > made and such. But I think you got my point; even though it might seem a bit
> > theoretical it sure is unpleasant.
> > 
> 
> I added Con to the cc: because this thread is starting to converge with
> an email discussion we've been having.
> 
> The basic issue is that the current semantics of SCHED_FIFO seem make
> the deadlock/data corruption due to runaway RT thread issue difficult.
> The obvious solution is a new scheduling class equivalent to SCHED_FIFO
> but with a mechanism for the kernel to demote the offending thread to
> SCHED_OTHER in an emergency.  The problem can be solved in userspace
> with a SCHED_FIFO watchdog thread that runs at a higher RT priority than
> all other RT processes.
> 
> This all seems to imply that introducing an rlimit for MAX_RT_PRIO is an
> excellent solution.  The RT watchdog thread could run as root, and the
> rlimit would be used to ensure than even nonroot users in the RT group
> could never preempt the watchdog thread.

Just an idea. What about throttling runaway RT tasks?
If the system spend more than 98% in RT tasks for 5s consider this as a
_fatal error_. Print an error message and throttle RT tasks by inserting
ticks where only SCHED_OTHER tasks allowed. For a limit of 98% this
means one SCHED_OTHER only tick all 50 ticks.

The limit and timeout should be configurable and of course it can be
disabled.

I know this is against RT task preempt all SCHED_OTHER but this is only
for a fatal system state to be able to recover sanely. A locked up
machine is is the worse alternative.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVAMVac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVAMVac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVAMV2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:28:43 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:45232 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261709AbVAMVZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:25:10 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "Jack O'Quin" <joq@io.com>, Chris Wright <chrisw@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <20050113210750.GA22208@devserv.devel.redhat.com>
References: <20050111214152.GA17943@devserv.devel.redhat.com>
	 <200501112251.j0BMp9iZ006964@localhost.localdomain>
	 <20050111150556.S10567@build.pdx.osdl.net> <87y8ezzake.fsf@sulphur.joq.us>
	 <20050112074906.GB5735@devserv.devel.redhat.com>
	 <87oefuma3c.fsf@sulphur.joq.us>
	 <20050113072802.GB13195@devserv.devel.redhat.com>
	 <878y6x9h2d.fsf@sulphur.joq.us>
	 <20050113210750.GA22208@devserv.devel.redhat.com>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 16:25:08 -0500
Message-Id: <1105651508.3457.31.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 22:07 +0100, Arjan van de Ven wrote:
> On Thu, Jan 13, 2005 at 03:04:26PM -0600, Jack O'Quin wrote:
> > 
> > (Probably, this simplistic analysis misses some other, more subtle,
> > factors.)
> 
> I think you can do nasty things to the locks held by those threads too
> 
> > 
> > RT threads should not do FS writes of their own.  But, a badly broken
> > or malicious one could, I suppose.  So, that might provide a mechanism
> > for losing more data than usual.  Is that what you had in mind?
> 
> basically yes.
> note that "FS writes" can come from various things, including library calls
> made and such. But I think you got my point; even though it might seem a bit
> theoretical it sure is unpleasant.
> 

I added Con to the cc: because this thread is starting to converge with
an email discussion we've been having.

The basic issue is that the current semantics of SCHED_FIFO seem make
the deadlock/data corruption due to runaway RT thread issue difficult.
The obvious solution is a new scheduling class equivalent to SCHED_FIFO
but with a mechanism for the kernel to demote the offending thread to
SCHED_OTHER in an emergency.  The problem can be solved in userspace
with a SCHED_FIFO watchdog thread that runs at a higher RT priority than
all other RT processes.

This all seems to imply that introducing an rlimit for MAX_RT_PRIO is an
excellent solution.  The RT watchdog thread could run as root, and the
rlimit would be used to ensure than even nonroot users in the RT group
could never preempt the watchdog thread.

Lee 


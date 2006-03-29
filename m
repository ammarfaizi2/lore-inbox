Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWC2LIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWC2LIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 06:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWC2LIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 06:08:45 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:26254 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751038AbWC2LIo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 06:08:44 -0500
Subject: Re: [Devel] Re: [RFC] Virtualization steps
From: Sam Vilain <sam@vilain.net>
To: Kirill Korotaev <dev@openvz.org>
Cc: devel@openvz.org, Kir Kolyshkin <kir@sacred.ru>,
       linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>
In-Reply-To: <442A4FAA.4010505@openvz.org>
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>
	 <1143228339.19152.91.camel@localhost.localdomain>
	 <4428BB5C.3060803@tmr.com>  <4428DB76.9040102@openvz.org>
	 <1143583179.6325.10.camel@localhost.localdomain>
	 <4429B789.4030209@sacred.ru>
	 <1143588501.6325.75.camel@localhost.localdomain>
	 <442A4FAA.4010505@openvz.org>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 23:08:50 +1200
Message-Id: <1143630530.8022.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 13:13 +0400, Kirill Korotaev wrote:
> > Well, for instance the fair CPU scheduling overhead is so tiny it may as
> > well not be there in the VServer patch.  It's just a per-vserver TBF
> > that feeds back into the priority (and hence timeslice length) of the
> > process.  ie, you get "CPU tokens" which deplete as processes in your
> > vserver run and you either get a boost or a penalty depending on the
> > level of the tokens in the bucket.  This doesn't provide guarantees, but
> > works well for many typical workloads.
> I wonder what is the value of it if it doesn't do guarantees or QoS?

It still does "QoS".  The TBF has a "fill rate", which is basically N
tokens per M jiffies.  Then you just set the size of the "bucket", and
the prio bonus given is between -5 (when bucket is full) and +15 (when
bucket is empty).  The normal -10 to +10 'interactive' prio bonus is
reduced to -5 to +5 to compensate.

In other words, it's like a global 'nice' across all of the processes in
the vserver.

So, these characteristics do provide some level of guarantees, but not
all that people expect.  eg, people want to say "cap usage at 5%", but
as designed the scheduler does not ever prevent runnable processes from
running if the CPUs have nothing better to do, so they think the
scheduler is broken.  It is also possible with a fork bomb (assuming the
absence of appropriate ulimits) that you start enough processes that you
don't care that they are all effectively nice +19.

Herbert later made it add some of these guarantees, but I believe there
is a performance impact of some kind.

> In our experiments with it we failed to observe any fairness.

Well, it does not aim to be 'fair', it aims to be useful for allocating
CPU to vservers.   ie, if you allocate X% of the CPU in the system to a
vserver, and it uses more, then try to make it use less via priority
penalties - and give others shortchanged or not using the CPU very much
performance bonuses.  That's all.

So, if you under- or over-book CPU allocation, it doesn't work.  The
idea was that monitoring it could be shipped out to userland.  I just
wanted something flexible enough to allow virtually any policy to be put
into place without wasting too many cycles.

> > How does your fair scheduler work?  Do you just keep a runqueue for each
> > vps?
> we keep num_online_cpus runqueues per VPS.

Right.  I considered that approach but just couldn't be bothered
implementing it, so went with the TBF because it worked and was
lightweight.

> Fairs scheduler is some kind of SFQ like algorithm which selects VPS to 
> be scheduled, than standart linux scheduler selects a process in a VPS 
> runqueues to run.

Right.

> > To be honest, I've never needed to determine whether its overhead is 1%
> > or 0.01%, it would just be a meaningless benchmark anyway :-).  I know
> > it's "good enough for me".
> Sure! We feel the same, but people like numbers :)

Sometimes the answer has to be "mu".

Sam.


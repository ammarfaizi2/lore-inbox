Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVA3WO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVA3WO7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVA3WO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:14:59 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:31453 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261808AbVA3WOM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:14:12 -0500
Date: Sun, 30 Jan 2005 23:03:12 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       mark_h_johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Shane Shrybman <shrybman@aei.ca>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption,
 -RT-2.6.10-rc2-mm3-V0.7.32-15)
In-Reply-To: <20050128073856.GA2186@elte.hu>
Message-Id: <Pine.OSF.4.05.10501302245420.14749-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > I noticed that you changed rw-locks to behave quite diferently under
> > real-time preemption: They basicly works like normal locks now. I.e.
> > there can only be one reader task within each region. This can can
> > however lock the region recursively. [...]
> 
> correct.
> 
> > [...] I wanted to start looking at fixing that because it ought to
> > hurt scalability quite a bit - and even on UP create a few unneeded
> > task-switchs. [...]
> 
> no, it's not a big scalability problem. rwlocks are really a mistake -
> if you want scalability and spinlocks/semaphores are not enough then one
> should either use per-CPU locks or lockless structures. rwlocks/rwsems
> will very unlikely help much.
>
I agree that RCU ought to do the trick in a lot of cases. Unfortunately,
people haven't used RCU in a lot of code but an rwlock. I also like the
idea of rwlocks: Many readers or just one writer. I don't see the need to
take that away from people.  Here is an examble which even on a UP will
give problems without it:
You have a shared datastructure, rarely updated with many readers. A low
priority task is reading it. That is preempted a high priority task which
finds out it can't read it -> priority inheritance, task switch. The low
priority task finishes the job -> priority set back, task switch. If it
was done with a rwlock two task switchs would have been saved.

 
> > However, the more I think about it the bigger the problem:
> 
> yes, that complexity to get it perform in a deterministic manner is why
> i introduced this (major!) simplification of locking. It turns out that
> most of the time the actual use of rwlocks matches this simplified
> 'owner-recursive exclusive lock' semantics, so we are lucky.
> 
> look at what kind of worst-case scenarios there may already be with
> multiple spinlocks (blocker.c). With rwlocks that just gets insane.
> 
Yes it does. But one could make a compromise: The up_write() should _not_
be deterministic. In that case it would be very simple to implement.
up_read() could still be deterministic as it would only involve boosting
one writer in the rare case such exists. That kind of locking would be
very usefull in many real-time systems. Ofcourse, RCU can do the job as
well, but it puts a lot of contrains on the code. 

However, as Linux is a general OS there is no way to know wether a
specific lock needs to be determnistic wrt. writing or not as the actual
application is not known at the time the lock type is specified.

> 	Ingo
> 

Esben


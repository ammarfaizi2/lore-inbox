Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270844AbUJUVVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270844AbUJUVVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270973AbUJUVQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:16:08 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:34251 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S270840AbUJUVNO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:13:14 -0400
Date: Thu, 21 Oct 2004 17:12:44 -0400
To: john cooper <john.cooper@timesys.com>
Cc: Scott Wood <scott@timesys.com>, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@suse.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021211244.GA28290@yoda.timesys>
References: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk> <4177CD3C.9020201@timesys.com> <4177DA11.4090902@ru.mvista.com> <4177E89A.1090100@timesys.com> <20041021173302.GA26318@yoda.timesys> <4177FB4F.9030202@timesys.com> <20041021184742.GB26530@yoda.timesys> <41781984.5090602@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41781984.5090602@timesys.com>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 04:18:12PM -0400, john cooper wrote:
> Scott Wood wrote:
> >How would maintaining priority order make it faster to check for
> >recursive usage?  
> >
> It wouldn't. My point was an exhaustive traversal may be
> needed for other reasons with an insertion sort being
> near free.
> 
> Yet considering the cost to maintain these lists in priority
> order with multiple spinlock acquisition sequences due to how
> the aggregate data structure must be traversed/ordered,
> I haven't yet convinced myself either way.

Another issue is that if you keep them in order, you have to fix the
list whenever an owner of a listed mutex changes its priority.

> >On uniprocessor, one may wish to turn rwlocks into recursive non-rw
> >mutexes, where recursion checking would use a single owner field.
> >
> It isn't obvious to me how this would address the case of a
> task holding a reader lock on mx-A then blocking on mx-B.
> Another task attempting to acquire a reader lock on mx-A would
> block rather than immediately acquiring the lock.

Yes.  However, the contention case should not be optimized at the
expense of the common case, which can be faster for non-rwlock
implementations when PI is involved.  On SMP, you'd be introducing a
bottleneck by taking away rwlocks, but on UP it's only an issue when
you get preempted or block in a critical section.

There could be problems if some code tries to acquire read locks
out-of-order, believing that it can't deadlock that way (if the
writers don't nest), but that's a problem anyway unless there's a
reasonable way of implementing PI without limiting the number of
concurrent readers (they have to be stored somewhere, and the
alternatives of setting a hard limit on mutexes-per-thread or doing
dynamic allocation inside the lock function are worse).

-Scott

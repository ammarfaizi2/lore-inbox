Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270900AbUJUTja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270900AbUJUTja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 15:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270813AbUJUTiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:38:46 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:62374 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S270816AbUJUSsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:48:18 -0400
Date: Thu, 21 Oct 2004 14:47:42 -0400
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
Message-ID: <20041021184742.GB26530@yoda.timesys>
References: <Pine.OSF.4.05.10410211601500.11909-100000@da410.ifa.au.dk> <4177CD3C.9020201@timesys.com> <4177DA11.4090902@ru.mvista.com> <4177E89A.1090100@timesys.com> <20041021173302.GA26318@yoda.timesys> <4177FB4F.9030202@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4177FB4F.9030202@timesys.com>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 02:09:19PM -0400, john cooper wrote:
> Scott Wood wrote:
> >If you keep it in priority order, then you're paying the O(n) cost
> >every time you acquire a lock. 

I partially take this back; depending on how it's implemented, you
can get away with only adding it to the list once contention occurs.

> That's true for the case where the current priority is
> somewhere else handy (likely) and we don't need to traverse
> the list for other reasons such as allowing/disallowing
> recursive acquisition of a mutex by a given task.

How would maintaining priority order make it faster to check for
recursive usage?  You'd be looking for a specific mutex rather than
the highest priority blocker.  You could also check the per-mutex
list of owners (which you'll need to implement PI on rwlocks), to
avoid needing to add to the locks-held list in non-contended cases.

On uniprocessor, one may wish to turn rwlocks into recursive non-rw
mutexes, where recursion checking would use a single owner field.

Also, keeping it in priority order would introduce yet another place
that assumes of a linear priority scheme.  At some point, it may be
desireable to implement other schemes, such as maintaining per-CPU
priorities to deal with inheriting from CPU-bound tasks without
introducing said tasks' priorities on other CPUs.

-Scott

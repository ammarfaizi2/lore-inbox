Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966064AbWKNXAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966064AbWKNXAQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966442AbWKNXAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:00:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:30773 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S966064AbWKNXAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:00:13 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,422,1157353200"; 
   d="scan'208"; a="163880469:sNHT56022862"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <nickpiggin@yahoo.com.au>, "Ingo Molnar" <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: sched: incorrect argument used in task_hot()
Date: Tue, 14 Nov 2006 15:00:13 -0800
Message-ID: <000201c70840$a4902df0$d834030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccIQKRrBTFioiIpRuSaGTTt8/KaCw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The argument used for task_hot in can_migrate_task() looks wrong:

int can_migrate_task()
{ ...
       if (task_hot(p, rq->timestamp_last_tick, sd))
                return 0;
        return 1;
}

It is not using current time to estimate whether a task is cache-hot
or not on a remote CPU, instead it is using timestamp that the remote
cpu took last timer interrupt.  With timer interrupt staggered, this
under estimate how long a task has been off CPU by a wide margin
compare to its actual value.  The ramification is that tasks should
be considered as cache cold is now being evaluated as cache hot.

We've seen that the effect is especially annoying at HT sched domain
where l-b is not able to freely migrate tasks between sibling CPUs
and leave idle time on the system.

One route to defend that misbehave is to override sd->cache_hot_time
at boot time.  Intuitively, sys admin will set that parameter to zero.
But wait, that is not correct.  It should be set to -1 jiffy because
(rq->timestamp_last_tick - p->last_run) can be negative.  On top of
that one has to convert jiffy to ns when set the parameter. All very
unintuitive and undesirable.

I was very tempted to do:
     now - this_rq->timestamp_last_tick + rq->timestamp_last_tick;

But it is equally flawed that timestamp_last_tick is not synchronized
between this_rq and target_rq. The adjustment is simply inaccurate and
not suitable for load balance decision at HT (or even core) domain.

There are a number of other usages of above adjustment, I think they
are all inaccurate.  Though, most of them are for interactiveness and
can withstand the inaccuracy because it makes decision based on much
larger scale.

So back to the first observation on not enough l-b at HT domain because
of inaccurate time calculation, what would be the best solution to fix
this?

- Ken

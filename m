Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbUKPWUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbUKPWUT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbUKPWUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:20:18 -0500
Received: from gizmo09ps.bigpond.com ([144.140.71.19]:17117 "HELO
	gizmo09ps.bigpond.com") by vger.kernel.org with SMTP
	id S261839AbUKPWT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:19:58 -0500
Message-ID: <419A7D09.4080001@bigpond.net.au>
Date: Wed, 17 Nov 2004 09:19:53 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling
 bugs
References: <20041116113209.GA1890@elte.hu>
In-Reply-To: <20041116113209.GA1890@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> PREEMPT_RT on SMP systems triggered weird (very high) load average
> values rather easily, which turned out to be a mainline kernel
> ->nr_uninterruptible handling bug in try_to_wake_up().
> 
> the following code:
> 
>         if (old_state == TASK_UNINTERRUPTIBLE) {
>                 old_rq->nr_uninterruptible--;
> 
> potentially executes with old_rq potentially being != rq, and hence
> updating ->nr_uninterruptible without the lock held. Given a
> sufficiently concurrent preemption workload the count can get out of
> whack and updates might get lost, permanently skewing the global count. 
> Nothing except the load-average uses nr_uninterruptible() so this
> condition can go unnoticed quite easily.
> 
> the fix is to update ->nr_uninterruptible always on the runqueue where
> the task currently is. (this is also a tiny performance plus for
> try_to_wake_up() as a stackslot gets freed up.)

Couldn't this part of the problem have been solved by using an atomic_t 
for nr_uninterruptible as for nr_iowait?  It would also remove the need 
for migrate_nr_uninterruptible().

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

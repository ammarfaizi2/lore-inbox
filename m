Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWAINex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWAINex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWAINew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:34:52 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:9134 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751456AbWAINew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:34:52 -0500
Message-ID: <43C2785C.4E937748@tv-sign.ru>
Date: Mon, 09 Jan 2006 17:51:08 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/5] rcu: don't check ->donelist in __rcu_pending()
References: <43C165BC.F7C6DCF5@tv-sign.ru> <20060109093141.GA10811@in.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Sun, Jan 08, 2006 at 10:19:24PM +0300, Oleg Nesterov wrote:
> > ->donelist becomes != NULL only in rcu_process_callbacks().
> >
> > rcu_process_callbacks() always calls rcu_do_batch() when
> > ->donelist != NULL.
> >
> > rcu_do_batch() schedules rcu_process_callbacks() again if
> > ->donelist was not flushed entirely.
> >
> > So ->donelist != NULL means that rcu_tasklet is either
> > TASKLET_STATE_SCHED or TASKLET_STATE_RUN, we don't need to
> > check it in __rcu_pending().
>
> Do I smell a bug wrt CPU Hotplug here? Basically, I see that we do
> a rcu_move_batch of ->curlist and ->nxtlist of the dead CPU. Why not
> ->donelist?

After the quick reading CPU Hotplug code I think you are right, there
is a bug in rcu_offline_cpu(). It should also move ->donelist, it is
lost otherwise.

>             If we have to do a rcu_move_batch of ->donelist also,
> then perhaps the ->donelist != NULL check is required in
> rcu_pending?

rcu_move_batch() always adds entries to the ->nxttail, so I think
this patch is correct.

>               This is considering that the RCU tasklet of the dead
> CPU is killed (rather than moved over to a different CPU).

Yes, it is killed explicitly in rcu_offline_cpu() via tasklet_kill_immediate().

Note that we can't remove this tasklet_kill_immediate() and rely on
takeover_tasklets(). rcu_process_callbacks() does __get_cpu_var(),
so it can't find orphaned rcu_data anyway if the tasklet was moved
to another cpu.

So, do we need something like this (untested, uncompiled) patch or not?

--- 2.6.15/kernel/rcupdate.c~	2006-01-09 20:23:32.000000000 +0300
+++ 2.6.15/kernel/rcupdate.c	2006-01-09 20:26:20.000000000 +0300
@@ -355,8 +355,9 @@ static void __rcu_offline_cpu(struct rcu
 	spin_unlock_bh(&rcp->lock);
 	rcu_move_batch(this_rdp, rdp->curlist, rdp->curtail);
 	rcu_move_batch(this_rdp, rdp->nxtlist, rdp->nxttail);
-
+	rcu_move_batch(this_rdp, rdp->donelist, rdp->donetail);
 }
+
 static void rcu_offline_cpu(int cpu)
 {
 	struct rcu_data *this_rdp = &get_cpu_var(rcu_data);

Oleg.

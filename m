Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbULTBoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbULTBoj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 20:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbULTBoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 20:44:39 -0500
Received: from fsmlabs.com ([168.103.115.128]:30637 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261372AbULTBog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 20:44:36 -0500
Date: Sun, 19 Dec 2004 18:44:26 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Li Shaohua <shaohua.li@intel.com>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
In-Reply-To: <1103505344.5093.4.camel@npiggin-nld.site>
Message-ID: <Pine.LNX.4.61.0412191819130.18310@montezuma.fsmlabs.com>
References: <20041205004557.GA2028@us.ibm.com>  <20041205232007.7edc4a78.akpm@osdl.org>
  <Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com> 
 <20041206160405.GB1271@us.ibm.com>  <Pine.LNX.4.61.0412060941560.5219@montezuma.fsmlabs.com>
  <20041206192243.GC1435@us.ibm.com>  <Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
  <Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com> 
 <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com> 
 <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com> 
 <29495f1d04121818403f949fdd@mail.gmail.com>  <Pine.LNX.4.61.0412191757450.18310@montezuma.fsmlabs.com>
 <1103505344.5093.4.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Nick Piggin wrote:

> This thread can possibly be stalled forever if there is a CPU hog
> running, right?

Yep.

> In which case, you will want to use ssleep rather than a busy loop.

Well ssleep essentially does the same thing as the schedule_timeout.

> Another alternative may be to use more complex logic to detect that a
> CPU is not in the idle loop at all. In that case, a simple cpu_relax
> type spin loop should be OK, because the synchronisation would be
> achieved very quickly.

I considered checking whether the cpu is in the idle thread or not but 
wouldn't that require locking runqueues? Something like;

pm_idle = new_value;
wmb();
busy_map = cpu_online_map;
for_each_online_cpu(cpu) {
	runqueue_t *rq = cpu_rq(cpu);
	spin_lock_irq(&rq->lock);
	if (rq->curr != rq->idle)
		cpu_clear(cpu, busy_map);
	spin_unlock_irq(&rq->lock);
}

cpu_idle_map = busy_map;
wmb();

while (!cpus_empty(cpu_idle_map)) {
	cpus_and(cpu_idle_map, cpu_idle_map, cpu_online_map);
	ssleep(1);
}

Hmm then again, i think we could get away with doing an unlocked compare 
on the rq->curr and rq->idle since we've written back pm_idle and reading 
a stale rq->curr which isn't equal to rq->idle means that the remote 
processor should also have the new pm_idle. I'm still not convinced that 
it deserves this much complexity, this is a rarely carried out operation 
and usually at boottime or shutdown.

Thanks,
	Zwane

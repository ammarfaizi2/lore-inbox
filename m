Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUHBUZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUHBUZA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 16:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUHBUZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 16:25:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:34281 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263062AbUHBUY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 16:24:58 -0400
Subject: Re: CPU hotplug broken in 2.6.8-rc2 ?
From: Nathan Lynch <nathanl@austin.ibm.com>
To: dipankar@in.ibm.com
Cc: V Srivatsa <vatsa@in.ibm.com>, Joel Schopp <jschopp@austin.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, zwane@linuxpower.ca
In-Reply-To: <1091475519.29556.4.camel@pants.austin.ibm.com>
References: <20040802094907.GA3945@in.ibm.com>
	 <20040802095741.GA4599@in.ibm.com>
	 <1091475519.29556.4.camel@pants.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1091478386.29556.36.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 02 Aug 2004 15:26:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-02 at 14:38, Nathan Lynch wrote:
> Could you try on 2.6.8-rc2-mm2 along with this patch?  Vatsa had a patch
> go in that should prevent the crash you are seeing -- the patch below is
> needed to prevent the same crash in the offline case.  This check used
> to be in load_balance and some other scheduler functions, iirc; does
> anyone know why they were removed?

Er, I meant to put the check in rebalance_tick, not load_balance.

However, after a few minutes with this, I hit the BUG_ON in the CPU_DEAD
case in migration_call; not sure whether this is a separate issue.

Nathan

---

diff -puN kernel/sched.c~check-for-cpu-offline-in-rebalance_tick kernel/sched.c
--- 2.6.8-rc2-mm2/kernel/sched.c~check-for-cpu-offline-in-rebalance_tick	2004-08-02 15:18:24.000000000 -0500
+++ 2.6.8-rc2-mm2-nathanl/kernel/sched.c	2004-08-02 15:18:47.000000000 -0500
@@ -1616,6 +1616,9 @@ static void rebalance_tick(int this_cpu,
 	unsigned long j = jiffies + CPU_OFFSET(this_cpu);
 	struct sched_domain *sd;
 
+	if (cpu_is_offline(this_cpu))
+		return;
+
 	/* Update our load */
 	old_load = this_rq->cpu_load;
 	this_load = this_rq->nr_running * SCHED_LOAD_SCALE;

_



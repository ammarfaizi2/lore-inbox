Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbUKOWjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbUKOWjO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbUKOWjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:39:13 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:30887 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261499AbUKOWh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:37:58 -0500
Subject: [patch] scheduler: rebalance_tick interval update
From: Darren Hart <dvhltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <piggin@cyberone.com.au>, Matt Dobson <colpatch@us.ibm.com>,
       Martin J Bligh <mbligh@aracnet.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Mon, 15 Nov 2004 14:38:33 -0800
Message-Id: <1100558313.17202.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current rebalance_tick() code assigns each sched_domain's
last_balance field to += interval after performing a load_balance.  If
interval is 10, this has the effect of saying:  we want to run
load_balance at time = 10, 20, 30, 40, etc...  If for example
last_balance=10 and for some reason rebalance_tick can't be run until
30, load_balance will be called and last_balance will be updated to 20,
causing it to call load_balance again immediately the next time it is
called since the interval is 10 and we are already at >30.  It seems to
me that it would make much more sense for last_balance to be assigned
jiffies after a load_balance, then the meaning of last_balance is more
exact: "this domain was last balanced at jiffies" rather than "we last
handled the balance we were supposed to do at 20, at some indeterminate
time".  The following patch makes this change.

Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
---

diff -purN -X /home/mbligh/.diff.exclude /home/linux/views/linux-2.6.10-rc1-mm5/kernel/sched.c linux-2.6.10-rc1-mm5-jni/kernel/sched.c
--- /home/linux/views/linux-2.6.10-rc1-mm5/kernel/sched.c	2004-11-11 05:33:53.000000000 -0800
+++ linux-2.6.10-rc1-mm5-jni/kernel/sched.c	2004-11-15 11:28:16.000000000 -0800
@@ -2201,7 +2201,7 @@ static void rebalance_tick(int this_cpu,
 				/* We've pulled tasks over so no longer idle */
 				idle = NOT_IDLE;
 			}
-			sd->last_balance += interval;
+			sd->last_balance = jiffies;
 		}
 	}
 }



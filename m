Return-Path: <linux-kernel-owner+w=401wt.eu-S1751410AbXAFPKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbXAFPKQ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 10:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbXAFPKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 10:10:15 -0500
Received: from mail.screens.ru ([213.234.233.54]:38182 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410AbXAFPKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 10:10:14 -0500
Date: Sat, 6 Jan 2007 18:10:36 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070106151036.GA951@tv-sign.ru>
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104091850.c1feee76.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

( Srivatsa, Gautham, could you please verify my thinking ? )

On top of fix-flush_workqueue-vs-cpu_dead-race.patch

hotplug_sequence is incremented under "case CPU_DEAD:". This was ok
before flush_workqueue() was changed to use preempt_disable() instead
of workqueue_mutex. However preempt_disable() can't garantee that there
is no CPU_DEAD event in progress (it is possible that flush_workqueue()
runs after STOPMACHINE_EXIT), so flush_workqueue() can miss CPU_DEAD
event.

Increment hotplug_sequence earlier, under CPU_DOWN_PREPARE. We can't
miss the event, the task running flush_workqueue() will be re-scheduled
at least once before CPU actually disappears from cpu_online_map.

We may have a false positive but this is very unlikely and only means
we will have one unneeded "goto again".

Note: this patch depends on
handle-cpu_lock_acquire-and-cpu_lock_release-in-workqueue_cpu_callback
but only "textually".

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- mm-6.20-rc3/kernel/workqueue.c~1_down	2007-01-06 16:15:59.000000000 +0300
+++ mm-6.20-rc3/kernel/workqueue.c	2007-01-06 17:52:10.000000000 +0300
@@ -886,12 +886,15 @@ static int __devinit workqueue_cpu_callb
 		}
 		break;
 
+	case CPU_DOWN_PREPARE:
+		hotplug_sequence++;
+		break;
+
 	case CPU_DEAD:
 		list_for_each_entry(wq, &workqueues, list)
 			cleanup_workqueue_thread(wq, hotcpu);
 		list_for_each_entry(wq, &workqueues, list)
 			take_over_work(wq, hotcpu);
-		hotplug_sequence++;
 		break;
 
 	case CPU_LOCK_RELEASE:


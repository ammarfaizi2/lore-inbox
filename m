Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVBPCGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVBPCGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 21:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVBPCGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 21:06:38 -0500
Received: from orb.pobox.com ([207.8.226.5]:1254 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261971AbVBPCGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 21:06:36 -0500
Date: Tue, 15 Feb 2005 20:06:28 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] kthread_bind new worker threads when onlining cpu
Message-ID: <20050216020628.GA25596@otto>
References: <20050211232821.GA14499@otto> <Pine.LNX.4.61.0502121019080.26742@montezuma.fsmlabs.com> <20050214215948.GA22304@otto> <20050215070217.GB13568@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215070217.GB13568@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew-

On Tue, Feb 15, 2005 at 08:02:17AM +0100, Ingo Molnar wrote:
> 
> * Nathan Lynch <ntl@pobox.com> wrote:
> 
> > 
> > It looks as if we need to explicitly bind worker threads to a newly
> > onlined cpu.  This gets rid of the smp_processor_id warnings from
> > cache_reap.  Adding a little more instrumentation to the debug
> > smp_processor_id showed that new worker threads were actually running
> > on the wrong cpu...
> > 
> > Does this look ok?
> 
> indeed - looks much better than the 'turn off the warning' solution.
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

We weren't binding new worker threads to their cpu when onlining.
Using preempt and the debug version of smp_processor_id found this.

Signed-off-by: Nathan Lynch <ntl@pobox.com>

Index: linux-2.6.11-rc4-bk2/kernel/workqueue.c
===================================================================
--- linux-2.6.11-rc4-bk2.orig/kernel/workqueue.c	2005-02-14 11:13:08.000000000 -0600
+++ linux-2.6.11-rc4-bk2/kernel/workqueue.c	2005-02-14 15:18:35.000000000 -0600
@@ -485,8 +485,10 @@
 
 	case CPU_ONLINE:
 		/* Kick off worker threads. */
-		list_for_each_entry(wq, &workqueues, list)
+		list_for_each_entry(wq, &workqueues, list) {
+			kthread_bind(wq->cpu_wq[hotcpu].thread, hotcpu);
 			wake_up_process(wq->cpu_wq[hotcpu].thread);
+		}
 		break;
 
 	case CPU_UP_CANCELED:

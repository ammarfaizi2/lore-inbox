Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVAECk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVAECk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVAECk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:40:56 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:43708 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262213AbVAECks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:40:48 -0500
Subject: Re: [BUG] mm_struct leak on cpu hotplug (s390/ppc64)
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: rusty@rustcorp.com.au, paulus@au1.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050104131101.GA3560@osiris.boeblingen.de.ibm.com>
References: <20050104131101.GA3560@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 20:41:17 -0600
Message-Id: <1104892877.8954.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 14:11 +0100, Heiko Carstens wrote:
> Hi,
> 
> there is an mm_struct memory leak when using cpu hotplug. Appearently
> start_secondary in smp.c initializes active_mm of the cpu's idle task
> and increases init_mm's mm_count. But on cpu_die the idle task's
> active_mm doesn't get dropped and therefore on the next cpu_up event
> (->start_secondary) it gets overwritten and the result is a forgotten
> reference count to whatever mm_struct was active when the cpu
> was taken down previously.
> 
> The patch below should fix this for s390 (at least it works fine for
> me), but I'm not sure if it's ok to call mmdrop from __cpu_die.
> 
> Also this very same leak exists for ppc64 as well.
> 
> Any opinions?

Wouldn't it be better to fix this in generic code instead of duplicating
it in each architecture?  It looks like the same thing would occur on
ia64 also.

What about something like this?  Tested on ppc64.


Index: 2.6.10/kernel/sched.c
===================================================================
--- 2.6.10.orig/kernel/sched.c	2004-12-24 21:35:24.000000000 +0000
+++ 2.6.10/kernel/sched.c	2005-01-05 01:48:47.520250232 +0000
@@ -4088,6 +4088,9 @@
 		migrate_nr_uninterruptible(rq);
 		BUG_ON(rq->nr_running != 0);
 
+		/* Must manually drop reference to avoid leaking mm_structs. */
+		mmdrop(rq->idle->active_mm);
+
 		/* No need to migrate the tasks: it was best-effort if
 		 * they didn't do lock_cpu_hotplug().  Just wake up
 		 * the requestors. */



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWCNAsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWCNAsZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWCNAsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:48:25 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:56490 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751761AbWCNAsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:48:25 -0500
Subject: [Patch 4/9] Block I/O accounting collection
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Suparna Bhattacharya <suparna@in.ibm.com>
In-Reply-To: <1142296834.5858.3.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1142297302.5858.16.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Mar 2006 19:48:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-blkio-collect.patch

Collect per-task block I/O delay statistics.

Unlike earlier iterations of the delay accounting
patches, now delays are only collected for the actual
I/O waits rather than try and cover the delays seen in 
I/O submission paths.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 kernel/sched.c |    5 +++++
 1 files changed, 5 insertions(+)

Index: linux-2.6.16-rc5/kernel/sched.c
===================================================================
--- linux-2.6.16-rc5.orig/kernel/sched.c	2006-03-11 07:41:32.000000000 -0500
+++ linux-2.6.16-rc5/kernel/sched.c	2006-03-11 07:41:39.000000000 -0500
@@ -49,6 +49,7 @@
 #include <linux/syscalls.h>
 #include <linux/times.h>
 #include <linux/acct.h>
+#include <linux/delayacct.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -4117,9 +4118,11 @@ void __sched io_schedule(void)
 {
 	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());
 
+	delayacct_blkio_start();
 	atomic_inc(&rq->nr_iowait);
 	schedule();
 	atomic_dec(&rq->nr_iowait);
+	delayacct_blkio_end();
 }
 
 EXPORT_SYMBOL(io_schedule);
@@ -4129,9 +4132,11 @@ long __sched io_schedule_timeout(long ti
 	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());
 	long ret;
 
+	delayacct_blkio_start();
 	atomic_inc(&rq->nr_iowait);
 	ret = schedule_timeout(timeout);
 	atomic_dec(&rq->nr_iowait);
+	delayacct_blkio_end();
 	return ret;
 }
 



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265903AbUFDWNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265903AbUFDWNq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 18:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266031AbUFDWNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 18:13:46 -0400
Received: from fmr06.intel.com ([134.134.136.7]:46283 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265903AbUFDWNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 18:13:43 -0400
Reply-To: <anil.s.keshavamurthy@intel.com>
From: "Anil" <anil.s.keshavamurthy@intel.com>
To: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH] speedup flush_workqueue for singlethread_workqueue
Date: Fri, 4 Jun 2004 15:13:34 -0700
Organization: Intel
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRKgS09zEH958VaSk+uy1HaTVy9Bg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-ID: <ORSMSX409uejPw8Zyai00000001@orsmsx409.amr.corp.intel.com>
X-OriginalArrivalTime: 04 Jun 2004 22:13:35.0947 (UTC) FILETIME=[2E31D1B0:01C44A81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	In the flush_workqueue function for a single_threaded_worqueue case the code seemed to loop the same cpu_workqueue_struct
for each_online_cpu's. The attached patch checks this condition and bails out of for loop there by speeding up the flush_workqueue
for a singlethreaded_workqueue.

Please apply.

Thanks,
-anil

---

Name: speedup_flush_workqueue_for_single_thread
Status: Test Passed

 linux-2.6.7-rc2-mm2-root/kernel/workqueue.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -puN kernel/workqueue.c~flush_work_queue_fix kernel/workqueue.c
--- linux-2.6.7-rc2-mm2/kernel/workqueue.c~flush_work_queue_fix	2004-06-04 21:38:49.848195790 -0700
+++ linux-2.6.7-rc2-mm2-root/kernel/workqueue.c	2004-06-04 21:42:50.013357817 -0700
@@ -236,6 +236,7 @@ void fastcall flush_workqueue(struct wor
 {
 	struct cpu_workqueue_struct *cwq;
 	int cpu;
+	int run_once = 0;
 
 	might_sleep();
 
@@ -244,9 +245,12 @@ void fastcall flush_workqueue(struct wor
 		DEFINE_WAIT(wait);
 		long sequence_needed;
 
-		if (is_single_threaded(wq))
+		if (is_single_threaded(wq)) {
+			if (run_once)
+				break;
 			cwq = wq->cpu_wq + 0; /* Always use cpu 0's area. */
-		else
+			run_once = 1;
+		} else
 			cwq = wq->cpu_wq + cpu;
 
 		if (cwq->thread == current) {

_





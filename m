Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVKXTuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVKXTuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVKXTuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:50:04 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:55245 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750767AbVKXTuB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:50:01 -0500
Date: Fri, 25 Nov 2005 01:26:01 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: More PI issues with -rt
Message-ID: <20051124195601.GA9098@in.ibm.com>
Reply-To: dino@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I found that PI boosted SCHED_OTHER tasks behave like they have
SCHED_FIFO policy, while PI boosted SCHED_RR tasks continue to
behave like they have SCHED_RR policy. This didn't seem right

Does something like the following patch make sense?

	-Dinakar



--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pi-fix.patch"

Index: linux-2.6.14/kernel/sched.c
===================================================================
--- linux-2.6.14.orig/kernel/sched.c	2005-11-25 01:24:06.000000000 +0530
+++ linux-2.6.14/kernel/sched.c	2005-11-25 01:24:26.000000000 +0530
@@ -2986,8 +2986,9 @@
 		 * On PREEMPT_RT, boosted tasks will also get into this
 		 * branch and wont get their timeslice decreased until
 		 * they have done their work.
+		 * Boosted SCHED_OTHER tasks round-robin as well
 		 */
-		if ((p->policy == SCHED_RR) && !--p->time_slice) {
+		if ((p->policy != SCHED_FIFO) && !--p->time_slice) {
 			p->time_slice = task_timeslice(p);
 			p->first_time_slice = 0;
 			set_tsk_need_resched(p);

--cWoXeonUoKmBZSoM--

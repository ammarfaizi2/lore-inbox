Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbTH0PIH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTH0PIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:08:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:40411 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263399AbTH0PIF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:08:05 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: CAN_MIGRATE seems screwed up
Date: Wed, 27 Aug 2003 10:07:59 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308271008.01939.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, not sure how long this has been this way, but:

#define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
	((!idle || (jiffies - (p)->last_run > cache_decay_ticks)) &&    \
		!task_running(rq, p) &&					\
			cpu_isset(this_cpu, (p)->cpus_allowed))		

Is broken.  Having !idle make no sense.  It should be just the opposite; an 
idle cpu should be able to have a more aggressive steal, and a busy cpu 
should not. 

diff -Naurp linux-2.6.0-test4/kernel/sched.c 
linux-2.6.0-test4-can_migrate/kernel/sched.c
--- linux-2.6.0-test4/kernel/sched.c	Fri Aug 22 18:58:43 2003
+++ linux-2.6.0-test4-can_migrate/kernel/sched.c	Wed Aug 27 11:32:46 2003
@@ -1064,7 +1064,7 @@ skip_queue:
 	 */
 
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
-	((!idle || (jiffies - (p)->last_run > cache_decay_ticks)) &&	\
+	((idle || (jiffies - (p)->last_run > cache_decay_ticks)) &&	\
 		!task_running(rq, p) &&					\
 			cpu_isset(this_cpu, (p)->cpus_allowed))
 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVERXwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVERXwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbVERXwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:52:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26098 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262413AbVERXv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:51:56 -0400
Message-ID: <428BD501.5020905@mvista.com>
Date: Wed, 18 May 2005 16:51:29 -0700
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] BUG_ON() in ksoftirqd is a bit too agressive...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ksoftirqd is created by init, long after the timer system is up and running.  We 
have hit the BUG_ON(tasklet_... in this code, i.e. tasklets pending at ksoftirqd 
create time.  Since, with the RT option to push all softirq code to a thread, 
any softirqs are defered to this time, it is easy to hit this bug.  Clearly only 
a problem for cpu 0.  Here is a patch:


Index: linux-2.6.10/kernel/softirq.c
===================================================================
--- linux-2.6.10.orig/kernel/softirq.c
+++ linux-2.6.10/kernel/softirq.c
@@ -514,8 +514,12 @@

  	switch (action) {
  	case CPU_UP_PREPARE:
-		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
-		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
+		/* We may have tasklets already scheduled on
+		   processor 0, so don't check there. */
+		if (hotcpu != 0) {
+			BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
+			BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
+		}
  		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
  		if (IS_ERR(p)) {
  			printk("ksoftirqd for %i failed\n", hotcpu);
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

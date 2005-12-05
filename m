Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVLEK50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVLEK50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 05:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVLEK50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 05:57:26 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:45283 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932373AbVLEK5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 05:57:25 -0500
Date: Mon, 5 Dec 2005 16:28:49 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: paulmck@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Dipankar <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix bug in RCU torture test
Message-ID: <20051205105849.GD2385@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While doing some test of RCU torture module, I hit a OOPS in rcu_do_batch,
which was trying to processes callback of a module that was just removed.
This is because we weren't waiting long enough for all callbacks to fire.

Patch below fixes that.

Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>


---

 linux-2.6.15-rc5-mm1-root/kernel/rcutorture.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN kernel/rcutorture.c~rcutorture_fix kernel/rcutorture.c
--- linux-2.6.15-rc5-mm1/kernel/rcutorture.c~rcutorture_fix	2005-12-05 15:33:06.000000000 +0530
+++ linux-2.6.15-rc5-mm1-root/kernel/rcutorture.c	2005-12-05 15:33:17.000000000 +0530
@@ -408,9 +408,8 @@ rcu_torture_cleanup(void)
 	stats_task = NULL;
 
 	/* Wait for all RCU callbacks to fire.  */
+	rcu_barrier();
 
-	for (i = 0; i < RCU_TORTURE_PIPE_LEN; i++)
-		synchronize_rcu();
 	rcu_torture_stats_print();  /* -After- the stats thread is stopped! */
 	printk(KERN_ALERT TORTURE_FLAG
 	       "--- End of test: %s\n",

_


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017

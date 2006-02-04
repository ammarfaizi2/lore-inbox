Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946309AbWBDE63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946309AbWBDE63 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 23:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946310AbWBDE63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 23:58:29 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:50601 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1946309AbWBDE62
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 23:58:28 -0500
Date: Fri, 3 Feb 2006 20:57:39 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [Patch] rcutorture: tag success/failure line with module parameters
Message-ID: <20060204045739.GA1136@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

A long-running rcutorture test can overflow dmesg, so that the line
containing the module parameters is lost.  Although it is usually
possible to retrieve this information from the log files, it is much
better to just tag it onto the final success/failure line so that it
may be easily found.  This patch does just that.

Signed-off-by: <paulmck@us.ibm.com>
---

 rcutorture.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff -urpNa -X dontdiff linux-2.6.16-rc1-mm4/kernel/rcutorture.c linux-2.6.16-rc1-mm4-rcutortureendpars/kernel/rcutorture.c
--- linux-2.6.16-rc1-mm4/kernel/rcutorture.c	2006-02-02 16:04:26.000000000 -0800
+++ linux-2.6.16-rc1-mm4-rcutortureendpars/kernel/rcutorture.c	2006-02-02 18:34:52.000000000 -0800
@@ -441,6 +441,16 @@ rcu_torture_shuffle(void *arg)
 	return 0;
 }
 
+static inline void
+rcu_torture_print_module_parms(char *tag)
+{
+	printk(KERN_ALERT TORTURE_FLAG "--- %s: nreaders=%d "
+		"stat_interval=%d verbose=%d test_no_idle_hz=%d "
+		"shuffle_interval = %d\n",
+		tag, nrealreaders, stat_interval, verbose, test_no_idle_hz,
+		shuffle_interval);
+}
+
 static void
 rcu_torture_cleanup(void)
 {
@@ -483,9 +493,10 @@ rcu_torture_cleanup(void)
 	rcu_barrier();
 
 	rcu_torture_stats_print();  /* -After- the stats thread is stopped! */
-	printk(KERN_ALERT TORTURE_FLAG
-	       "--- End of test: %s\n",
-	       atomic_read(&n_rcu_torture_error) == 0 ? "SUCCESS" : "FAILURE");
+	if (atomic_read(&n_rcu_torture_error))
+		rcu_torture_print_module_parms("End of test: FAILURE");
+	else
+		rcu_torture_print_module_parms("End of test: SUCCESS");
 }
 
 static int
@@ -501,11 +512,7 @@ rcu_torture_init(void)
 		nrealreaders = nreaders;
 	else
 		nrealreaders = 2 * num_online_cpus();
-	printk(KERN_ALERT TORTURE_FLAG "--- Start of test: nreaders=%d "
-		"stat_interval=%d verbose=%d test_no_idle_hz=%d "
-		"shuffle_interval = %d\n",
-		nrealreaders, stat_interval, verbose, test_no_idle_hz,
-		shuffle_interval);
+	rcu_torture_print_module_parms("Start of test");
 	fullstop = 0;
 
 	/* Set up the freelist. */

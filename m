Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbTFEWEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 18:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbTFEWEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 18:04:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:23523 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265227AbTFEWEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 18:04:01 -0400
Subject: [BUGFIX - #764] linux-2.5.70_btime-fix_A1
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, h.lambermont@aramiska.net
Content-Type: text/plain
Organization: 
Message-Id: <1054851249.32090.1037.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Jun 2003 15:14:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All, 
	Due to a math error in the calculation of /proc/stat's btime, the value
could wobble, varying by a single second. The patch fixes this wobble
described in bugme bug #764. 

Reportedly Hans is seeing larger then 1 second wobbles which I have not
been able to reproduce, but that looks to be a separate issue to this
math bug. 

Please consider for inclusion.

thanks
-john

diff -Nru a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
--- a/fs/proc/proc_misc.c	Thu Jun  5 15:07:14 2003
+++ b/fs/proc/proc_misc.c	Thu Jun  5 15:07:14 2003
@@ -378,8 +378,23 @@
 {
 	int i, len;
 	extern unsigned long total_forks;
-	u64 jif = get_jiffies_64() - INITIAL_JIFFIES;
+	u64 jif;
 	unsigned int sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0;
+	struct timeval now; 
+	unsigned long seq;
+
+	/* Atomically read jiffies and time of day */ 
+	do {
+		seq = read_seqbegin(&xtime_lock);
+
+		jif = get_jiffies_64();
+		do_gettimeofday(&now);
+	} while (read_seqretry(&xtime_lock, seq));
+
+	/* calc # of seconds since boot time */
+	jif -= INITIAL_JIFFIES;
+	jif = ((u64)now.tv_sec * HZ) + (now.tv_usec/(1000000/HZ)) - jif;
+	do_div(jif, HZ);
 
 	for (i = 0 ; i < NR_CPUS; i++) {
 		int j;
@@ -419,7 +434,6 @@
 		len += sprintf(page + len, " %u", kstat_irqs(i));
 #endif
 
-	do_div(jif, HZ);
 	len += sprintf(page + len,
 		"\nctxt %lu\n"
 		"btime %lu\n"
@@ -427,7 +441,7 @@
 		"procs_running %lu\n"
 		"procs_blocked %lu\n",
 		nr_context_switches(),
-		xtime.tv_sec - (unsigned long) jif,
+		(unsigned long)jif,
 		total_forks,
 		nr_running(),
 		nr_iowait());



 


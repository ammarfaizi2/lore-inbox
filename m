Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTFCWuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 18:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTFCWuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 18:50:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:57085 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261798AbTFCWuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 18:50:22 -0400
Subject: [RFC][PATCH] linux-2.5.70_btime-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: h.lambermont@aramiska.net
Content-Type: text/plain
Organization: 
Message-Id: <1054681259.32091.783.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Jun 2003 16:00:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

	Since jiffies didn't necessarily start incrementing at a second
boundary, jiffies/HZ doesn't increment at the same moment as
xtime.tv_sec. This causes one second wobbles in the calculation of btime
(xtime.tv_sec - jiffies/HZ).  

This fix increases the precision of the calculation so the usec
component of xtime is used as well. Additionally it fixes some of the
non-atomic reading of time values. 


This is a fix for bugme bug #764.
http://bugme.osdl.org/show_bug.cgi?id=764


Let me know if you have any comments

thanks
-john

--- 1.77/fs/proc/proc_misc.c	Sun May 25 14:08:09 2003
+++ edited/fs/proc/proc_misc.c	Tue Jun  3 15:52:41 2003
@@ -378,8 +378,22 @@
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
+		jif = get_jiffies_64() - INITIAL_JIFFIES;
+		do_gettimeofday(&now);
+	} while (read_seqretry(&xtime_lock, seq));
+
+	/* calc # of seconds since boot time */
+	jif = ((u64)now.tv_sec * HZ) + (now.tv_usec/(1000000/HZ)) - jif;
+	do_div(jif, HZ);
 
 	for (i = 0 ; i < NR_CPUS; i++) {
 		int j;
@@ -419,7 +433,6 @@
 		len += sprintf(page + len, " %u", kstat_irqs(i));
 #endif
 
-	do_div(jif, HZ);
 	len += sprintf(page + len,
 		"\nctxt %lu\n"
 		"btime %lu\n"
@@ -427,7 +440,7 @@
 		"procs_running %lu\n"
 		"procs_blocked %lu\n",
 		nr_context_switches(),
-		xtime.tv_sec - (unsigned long) jif,
+		(unsigned long)jif,
 		total_forks,
 		nr_running(),
 		nr_iowait());




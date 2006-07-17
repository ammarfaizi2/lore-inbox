Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWGQV4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWGQV4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 17:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWGQV4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 17:56:08 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:54446 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751207AbWGQV4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 17:56:06 -0400
Subject: [Patch 3/3] delay accounting: temporarily enable by default
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Balbir Singh <balbir@in.ibm.com>, Chris Sturtivant <csturtiv@sgi.com>
In-Reply-To: <1153173063.4551.10.camel@dyn9002218086.watson.ibm.com>
References: <1153173063.4551.10.camel@dyn9002218086.watson.ibm.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1153173363.4551.19.camel@dyn9002218086.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 17 Jul 2006 17:56:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable delay accounting by default so that feature gets coverage testing
without requiring special measures/

Earlier, it was off by default and had to be enabled via a boot time param.
This patch reverses the default behaviour to improve coverage testing. It
can be removed late in the kernel development cycle if its believed users
shouldn't have to incur any cost if they don't want delay accounting. Or it
can be retained forever if the utility of the stats is deemed common enough
to warrant keeping the feature on.

Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>

 Documentation/accounting/delay-accounting.txt |   10 ++++++----
 Documentation/kernel-parameters.txt           |    4 ++--
 include/linux/delayacct.h                     |    4 ++--
 kernel/delayacct.c                            |    8 ++++----
 4 files changed, 14 insertions(+), 12 deletions(-)

Index: linux-2.6.18-rc2/Documentation/accounting/delay-accounting.txt
===================================================================
--- linux-2.6.18-rc2.orig/Documentation/accounting/delay-accounting.txt	2006-07-17 17:01:41.000000000 -0400
+++ linux-2.6.18-rc2/Documentation/accounting/delay-accounting.txt	2006-07-17 17:07:54.000000000 -0400
@@ -64,11 +64,13 @@ Compile the kernel with
 	CONFIG_TASK_DELAY_ACCT=y
 	CONFIG_TASKSTATS=y
 
-Enable the accounting at boot time by adding
-the following to the kernel boot options
-	delayacct
+Delay accounting is enabled by default at boot up.
+To disable, add
+   nodelayacct
+to the kernel boot options. The rest of the instructions
+below assume this has not been done.
 
-and after the system has booted up, use a utility
+After the system has booted up, use a utility
 similar to  getdelays.c to access the delays
 seen by a given task or a task group (tgid).
 The utility also allows a given command to be
Index: linux-2.6.18-rc2/kernel/delayacct.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/delayacct.c	2006-07-17 17:01:51.000000000 -0400
+++ linux-2.6.18-rc2/kernel/delayacct.c	2006-07-17 17:07:54.000000000 -0400
@@ -19,15 +19,15 @@
 #include <linux/sysctl.h>
 #include <linux/delayacct.h>
 
-int delayacct_on __read_mostly;	/* Delay accounting turned on/off */
+int delayacct_on __read_mostly = 1;	/* Delay accounting turned on/off */
 kmem_cache_t *delayacct_cache;
 
-static int __init delayacct_setup_enable(char *str)
+static int __init delayacct_setup_disable(char *str)
 {
-	delayacct_on = 1;
+	delayacct_on = 0;
 	return 1;
 }
-__setup("delayacct", delayacct_setup_enable);
+__setup("nodelayacct", delayacct_setup_disable);
 
 void delayacct_init(void)
 {
Index: linux-2.6.18-rc2/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.18-rc2.orig/Documentation/kernel-parameters.txt	2006-07-17 17:01:41.000000000 -0400
+++ linux-2.6.18-rc2/Documentation/kernel-parameters.txt	2006-07-17 17:07:54.000000000 -0400
@@ -448,8 +448,6 @@ running once the system is up.
 			Format: <area>[,<node>]
 			See also Documentation/networking/decnet.txt.
 
-	delayacct	[KNL] Enable per-task delay accounting
-
 	dhash_entries=	[KNL]
 			Set number of hash buckets for dentry cache.
 
@@ -1031,6 +1029,8 @@ running once the system is up.
 
 	nocache		[ARM]
 
+	nodelayacct	[KNL] Disable per-task delay accounting
+
 	nodisconnect	[HW,SCSI,M68K] Disables SCSI disconnects.
 
 	noexec		[IA-64]
Index: linux-2.6.18-rc2/include/linux/delayacct.h
===================================================================
--- linux-2.6.18-rc2.orig/include/linux/delayacct.h	2006-07-17 17:03:41.000000000 -0400
+++ linux-2.6.18-rc2/include/linux/delayacct.h	2006-07-17 17:07:54.000000000 -0400
@@ -55,7 +55,7 @@ static inline void delayacct_tsk_init(st
 {
 	/* reinitialize in case parent's non-null pointer was dup'ed*/
 	tsk->delays = NULL;
-	if (unlikely(delayacct_on))
+	if (delayacct_on)
 		__delayacct_tsk_init(tsk);
 }
 
@@ -80,7 +80,7 @@ static inline void delayacct_blkio_end(v
 static inline int delayacct_add_tsk(struct taskstats *d,
 					struct task_struct *tsk)
 {
-	if (likely(!delayacct_on) || !tsk->delays)
+	if (!delayacct_on || !tsk->delays)
 		return 0;
 	return __delayacct_add_tsk(d, tsk);
 }



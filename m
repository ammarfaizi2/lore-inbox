Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVANS41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVANS41 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVANSzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:55:01 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:10439 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261343AbVANSyl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:54:41 -0500
Date: Fri, 14 Jan 2005 19:54:40 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 2/8] s390: cmm interface.
Message-ID: <20050114185440.GB6789@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/8] s390: cmm interface.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Collaborative memory management inferface changes:
 - Allow cmmthread to run on every cpu.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/mm/cmm.c |   11 -----------
 1 files changed, 11 deletions(-)

diff -urN linux-2.6/arch/s390/mm/cmm.c linux-2.6-patched/arch/s390/mm/cmm.c
--- linux-2.6/arch/s390/mm/cmm.c	2004-12-24 22:35:14.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/cmm.c	2005-01-14 19:45:16.000000000 +0100
@@ -124,7 +124,6 @@
 	int rc;
 
 	daemonize("cmmthread");
-	set_cpus_allowed(current, cpumask_of_cpu(0));
 	while (1) {
 		rc = wait_event_interruptible(cmm_thread_wait,
 			(cmm_pages != cmm_pages_target ||
@@ -408,14 +407,6 @@
 static int
 cmm_init (void)
 {
-	int rc;
-
-	/* Prevent logical cpu 0 from being set offline. */
-	rc = smp_get_cpu(cpumask_of_cpu(0));
-	if (rc) {
-		printk(KERN_ERR "CMM: unable to reserve cpu 0\n");
-		return rc;
-	}
 #ifdef CONFIG_CMM_PROC
 	cmm_sysctl_header = register_sysctl_table(cmm_dir_table, 1);
 #endif
@@ -439,8 +430,6 @@
 #ifdef CONFIG_CMM_IUCV
 	smsg_unregister_callback(SMSG_PREFIX, cmm_smsg_target);
 #endif
-	/* Allow logical cpu 0 to be set offline again. */
-	smp_put_cpu(0);
 }
 
 module_init(cmm_init);

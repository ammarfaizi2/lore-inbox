Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbWHXVXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbWHXVXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWHXVXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:23:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:3757 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030475AbWHXVXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:23:33 -0400
Date: Thu, 24 Aug 2006 16:23:23 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, djbarrow@de.ibm.com,
       fpavlic@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 2/3] kthread: update the s390 lcs driver to use kthread
Message-ID: <20060824212323.GC30007@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the s390 Lan Channel Station Network Driver, which can be
compiled as a module, to use kthread, rather than kernel_thread
whose EXPORT_SYMBOL has been deprecated.

Compiles and boots fine.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 drivers/s390/net/lcs.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

4a9f3cfc86c034a4b9fb31f9939d7c457b41f9cd
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 2eded55..e4f9850 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -36,6 +36,7 @@
 #include <linux/in.h>
 #include <linux/igmp.h>
 #include <linux/delay.h>
+#include <linux/kthread.h>
 #include <net/arp.h>
 #include <net/ip.h>
 
@@ -1249,7 +1250,6 @@ lcs_register_mc_addresses(void *data)
 	struct in_device *in4_dev;
 
 	card = (struct lcs_card *) data;
-	daemonize("regipm");
 
 	if (!lcs_do_run_thread(card, LCS_SET_MC_THREAD))
 		return 0;
@@ -1729,11 +1729,11 @@ lcs_start_kernel_thread(struct lcs_card 
 {
 	LCS_DBF_TEXT(5, trace, "krnthrd");
 	if (lcs_do_start_thread(card, LCS_RECOVERY_THREAD))
-		kernel_thread(lcs_recovery, (void *) card, SIGCHLD);
+		kthread_run(lcs_recovery, (void *) card, "lcs_recover");
 #ifdef CONFIG_IP_MULTICAST
 	if (lcs_do_start_thread(card, LCS_SET_MC_THREAD))
-		kernel_thread(lcs_register_mc_addresses,
-				(void *) card, SIGCHLD);
+		kthread_run(lcs_register_mc_addresses,
+				(void *) card, "regipm");
 #endif
 }
 
@@ -2236,7 +2236,6 @@ lcs_recovery(void *ptr)
         int rc;
 
 	card = (struct lcs_card *) ptr;
-	daemonize("lcs_recover");
 
 	LCS_DBF_TEXT(4, trace, "recover1");
 	if (!lcs_do_run_thread(card, LCS_RECOVERY_THREAD))
-- 
1.1.6

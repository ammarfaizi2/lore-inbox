Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422752AbWHXWLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422752AbWHXWLA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 18:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422754AbWHXWLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 18:11:00 -0400
Received: from over.ny.us.ibm.com ([32.97.182.150]:38045 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S1422752AbWHXWK7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 18:10:59 -0400
Date: Thu, 24 Aug 2006 16:25:27 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: utz.bacher@de.ibm.com, fpavlic@de.ibm.com, tspat@de.ibm.com,
       linux-390@vm.marist.edu
Subject: [PATCH 3/3] kthread: convert the s390 qeth driver to use kthread
Message-ID: <20060824212527.GD30007@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the s390 qeth driver, which can be a module, to use kthread
rather than kernel_thread, whose EXPORT_SYMBOL is deprecated.

Compiles and boots, and dmesg shows it is in use for eth0.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 drivers/s390/net/qeth_main.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

315bee45e81ba606c009b59f8ad100bc5818eda3
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index 5fff1f9..06c1a17 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -50,6 +50,7 @@
 #include <linux/mii.h>
 #include <linux/rcupdate.h>
 #include <linux/ethtool.h>
+#include <linux/kthread.h>
 
 #include <net/arp.h>
 #include <net/ip.h>
@@ -956,7 +957,6 @@ qeth_register_ip_addresses(void *ptr)
 	struct qeth_card *card;
 
 	card = (struct qeth_card *) ptr;
-	daemonize("qeth_reg_ip");
 	QETH_DBF_TEXT(trace,4,"regipth1");
 	if (!qeth_do_run_thread(card, QETH_SET_IP_THREAD))
 		return 0;
@@ -974,7 +974,6 @@ qeth_set_promisc_mode(void *ptr)
 {
 	struct qeth_card *card = (struct qeth_card *) ptr;
 
-	daemonize("qeth_setprm");
 	QETH_DBF_TEXT(trace,4,"setprm1");
 	if (!qeth_do_run_thread(card, QETH_SET_PROMISC_MODE_THREAD))
 		return 0;
@@ -991,7 +990,6 @@ qeth_recover(void *ptr)
 	int rc = 0;
 
 	card = (struct qeth_card *) ptr;
-	daemonize("qeth_recover");
 	QETH_DBF_TEXT(trace,2,"recover1");
 	QETH_DBF_HEX(trace, 2, &card, sizeof(void *));
 	if (!qeth_do_run_thread(card, QETH_RECOVER_THREAD))
@@ -1048,11 +1046,11 @@ qeth_start_kernel_thread(struct qeth_car
 		return;
 
 	if (qeth_do_start_thread(card, QETH_SET_IP_THREAD))
-		kernel_thread(qeth_register_ip_addresses, (void *)card,SIGCHLD);
+		kthread_run(qeth_register_ip_addresses, (void *)card, "qeth_reg_ip");
 	if (qeth_do_start_thread(card, QETH_SET_PROMISC_MODE_THREAD))
-		kernel_thread(qeth_set_promisc_mode, (void *)card, SIGCHLD);
+		kthread_run(qeth_set_promisc_mode, (void *)card, "qeth_setprm");
 	if (qeth_do_start_thread(card, QETH_RECOVER_THREAD))
-		kernel_thread(qeth_recover, (void *) card, SIGCHLD);
+		kthread_run(qeth_recover, (void *) card, "qeth_recover");
 }
 
 
-- 
1.1.6

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUITQoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUITQoP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 12:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUITQoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 12:44:15 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:5530 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S266807AbUITQiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 12:38:18 -0400
Date: Mon, 20 Sep 2004 18:38:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: qeth network driver.
Message-ID: <20040920163809.GD3092@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: qeth network driver.

From: Steffen Thoss <thoss@de.ibm.com>
From: Ursula Braun-Krahl <braunu@de.ibm.com>

qeth network driver change:
 - Change misleading message about hardware ip fragmentation.
 - Include qeth_snmp_ureq_hdr structure in user copy in qeth_snmp_command.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/qeth_main.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2004-09-20 18:00:49.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2004-09-20 18:01:04.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.132 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.138 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.132 $	 $Date: 2004/08/19 12:39:43 $
+ *    $Revision: 1.138 $	 $Date: 2004/09/17 10:40:53 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -79,7 +79,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.132 $"
+#define VERSION_QETH_C "$Revision: 1.138 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -4373,12 +4373,13 @@
 	/* skip 4 bytes (data_len struct member) to get req_len */
 	if (copy_from_user(&req_len, udata + sizeof(int), sizeof(int)))
 		return -EFAULT;
-	ureq = kmalloc(req_len, GFP_KERNEL);
+	ureq = kmalloc(req_len+sizeof(struct qeth_snmp_ureq_hdr), GFP_KERNEL);
 	if (!ureq) {
 		QETH_DBF_TEXT(trace, 2, "snmpnome");
 		return -ENOMEM;
 	}
-	if (copy_from_user(ureq, udata, req_len)){
+	if (copy_from_user(ureq, udata,
+			req_len+sizeof(struct qeth_snmp_ureq_hdr))){
 		kfree(ureq);
 		return -EFAULT;
 	}
@@ -5743,7 +5744,7 @@
 	QETH_DBF_TEXT(trace,3,"ipaipfrg");
 
 	if (!qeth_is_supported(card, IPA_IP_FRAGMENTATION)) {
-		PRINT_INFO("IP fragmentation not supported on %s\n",
+		PRINT_INFO("Hardware IP fragmentation not supported on %s\n",
 			   card->info.if_name);
 		return  -EOPNOTSUPP;
 	}
@@ -5751,11 +5752,11 @@
 	rc = qeth_send_simple_setassparms(card, IPA_IP_FRAGMENTATION,
 					  IPA_CMD_ASS_START, 0);
 	if (rc) {
-		PRINT_WARN("Could not start IP fragmentation "
+		PRINT_WARN("Could not start Hardware IP fragmentation "
 			   "assist on %s: 0x%x\n",
 			   card->info.if_name, rc);
 	} else
-		PRINT_INFO("IP fragmentation enabled \n");
+		PRINT_INFO("Hardware IP fragmentation enabled \n");
 	return rc;
 }
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269712AbUICNus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269712AbUICNus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269711AbUICNuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:50:06 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:1719 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S269697AbUICNrc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:47:32 -0400
Date: Fri, 3 Sep 2004 15:48:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: lcs multicast deadlock.
Message-ID: <20040903134807.GC3493@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: lcs multicast deadlock.

From: Thomas Spatzier <tspat@de.ibm.com>

lcs network driver changes:
 - Fix deadlock on card->ipm_lock.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/lcs.c |   56 +++++++++++++++++++++++++++++++++++--------------
 1 files changed, 41 insertions(+), 15 deletions(-)

diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-s390/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	Fri Sep  3 15:26:13 2004
+++ linux-2.6-s390/drivers/s390/net/lcs.c	Fri Sep  3 15:26:31 2004
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.89 $	 $Date: 2004/08/24 10:49:27 $
+ *    $Revision: 1.92 $	 $Date: 2004/09/03 08:06:11 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,7 +59,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.89 $"
+#define VERSION_LCS_C  "$Revision: 1.92 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 static char debug_buffer[255];
@@ -454,17 +454,21 @@
 lcs_clear_multicast_list(struct lcs_card *card)
 {
 #ifdef	CONFIG_IP_MULTICAST
-	struct list_head *l, *n;
 	struct lcs_ipm_list *ipm;
 	unsigned long flags;
+
 	/* Free multicast list. */
 	LCS_DBF_TEXT(3, setup, "clmclist");
 	spin_lock_irqsave(&card->ipm_lock, flags);
-	list_for_each_safe(l, n, &card->ipm_list) {
-		ipm = list_entry(l, struct lcs_ipm_list, list);
+	while (!list_empty(&card->ipm_list)){
+		ipm = list_entry(card->ipm_list.next,
+				 struct lcs_ipm_list, list);
 		list_del(&ipm->list);
-		if (ipm->ipm_state != LCS_IPM_STATE_SET_REQUIRED)
+		if (ipm->ipm_state != LCS_IPM_STATE_SET_REQUIRED){
+			spin_unlock_irqrestore(&card->ipm_lock, flags);
 			lcs_send_delipm(card, ipm);
+			spin_lock_irqsave(&card->ipm_lock, flags);
+		}
 		kfree(ipm);
 	}
 	spin_unlock_irqrestore(&card->ipm_lock, flags);
@@ -1111,31 +1115,53 @@
 static void
 lcs_fix_multicast_list(struct lcs_card *card)
 {
-	struct list_head *l, *n;
-	struct lcs_ipm_list *ipm;
+	struct list_head failed_list;
+	struct lcs_ipm_list *ipm, *tmp;
 	unsigned long flags;
+	int rc;
 
 	LCS_DBF_TEXT(4,trace, "fixipm");
+	INIT_LIST_HEAD(&failed_list);
 	spin_lock_irqsave(&card->ipm_lock, flags);
-	list_for_each_safe(l, n, &card->ipm_list) {
-		ipm = list_entry(l, struct lcs_ipm_list, list);
+list_modified:
+	list_for_each_entry_safe(ipm, tmp, &card->ipm_list, list){
 		switch (ipm->ipm_state) {
 		case LCS_IPM_STATE_SET_REQUIRED:
-			if (lcs_send_setipm(card, ipm))
+			/* del from ipm_list so noone else can tamper with
+			 * this entry */
+			list_del_init(&ipm->list);
+			spin_unlock_irqrestore(&card->ipm_lock, flags);
+			rc = lcs_send_setipm(card, ipm);
+			spin_lock_irqsave(&card->ipm_lock, flags);
+			if (rc) {
 				PRINT_INFO("Adding multicast address failed."
 					   "Table possibly full!\n");
-			else
+				/* store ipm in failed list -> will be added
+				 * to ipm_list again, so a retry will be done
+				 * during the next call of this function */
+				list_add_tail(&ipm->list, &failed_list);
+			} else {
 				ipm->ipm_state = LCS_IPM_STATE_ON_CARD;
-			break;
+				/* re-insert into ipm_list */
+				list_add_tail(&ipm->list, &card->ipm_list);
+			}
+			goto list_modified;
 		case LCS_IPM_STATE_DEL_REQUIRED:
-			lcs_send_delipm(card, ipm);
 			list_del(&ipm->list);
+			spin_unlock_irqrestore(&card->ipm_lock, flags);
+			lcs_send_delipm(card, ipm);
+			spin_lock_irqsave(&card->ipm_lock, flags);
 			kfree(ipm);
-			break;
+			goto list_modified;
 		case LCS_IPM_STATE_ON_CARD:
 			break;
 		}
 	}
+	/* re-insert all entries from the failed_list into ipm_list */
+	list_for_each_entry(ipm, &failed_list, list) {
+		list_del_init(&ipm->list);
+		list_add_tail(&ipm->list, &card->ipm_list);
+	}
 	spin_unlock_irqrestore(&card->ipm_lock, flags);
 	if (card->state == DEV_STATE_UP)
 		netif_wake_queue(card->dev);

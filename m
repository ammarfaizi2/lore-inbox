Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbTCGMpt>; Fri, 7 Mar 2003 07:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbTCGMpW>; Fri, 7 Mar 2003 07:45:22 -0500
Received: from d06lmsgate-2.uk.ibm.com ([195.212.29.2]:28131 "EHLO
	d06lmsgate-2.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S261573AbTCGMnc> convert rfc822-to-8bit; Fri, 7 Mar 2003 07:43:32 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (4/7): lcs network driver.
Date: Fri, 7 Mar 2003 13:37:30 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303071337.30448.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Cannot free net_device in lcs_stop_device as you want the user
  to start network when doing ifconfig up and not oopsing the kernel.
* Receiving a LGW initiated stoplan first try to reset the card, stop it when
  reset fails

diffstat:
 lcs.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff -urN linux-2.5.64/drivers/s390/net/lcs.c linux-2.5.64-s390/drivers/s390/net/lcs.c
--- linux-2.5.64/drivers/s390/net/lcs.c	Wed Mar  5 04:28:59 2003
+++ linux-2.5.64-s390/drivers/s390/net/lcs.c	Fri Mar  7 11:40:40 2003
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.44 $	 $Date: 2003/02/18 19:49:02 $
+ *    $Revision: 1.45 $	 $Date: 2003/02/26 09:06:37 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,7 +59,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.44 $"
+#define VERSION_LCS_C  "$Revision: 1.45 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 
@@ -358,6 +358,7 @@
 		kfree(ipm_list);
 	}
 #endif
+	kfree(card->dev);
 	/* Cleanup channels. */
 	lcs_cleanup_channel(&card->write);
 	lcs_cleanup_channel(&card->read);
@@ -1434,6 +1435,7 @@
 lcs_lgw_stoplan_thread(void *data)
 {
 	struct lcs_card *card;
+	int rc;
 
 	card = (struct lcs_card *) data;
 	daemonize("lgwstop");
@@ -1446,7 +1448,11 @@
 	else
 		PRINT_ERR("Stoplan %s initiated by LGW failed!\n",
 			  card->dev->name);
-	return 0;
+	/*Try to reset the card, stop it on failure */
+        rc = lcs_resetcard(card);
+        if (rc != 0)
+                rc = lcs_stopcard(card);
+        return rc;
 }
 
 /**
@@ -1599,8 +1605,6 @@
 	LCS_DBF_TEXT(2, trace, "stopdev");
 	card   = (struct lcs_card *) dev->priv;
 	netif_stop_queue(dev);
-	// FIXME: really free the net_device here ?!?
-	kfree(card->dev);
 	rc = lcs_stopcard(card);
 	if (rc)
 		PRINT_ERR("Try it again!\n ");


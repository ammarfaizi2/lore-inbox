Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbVE0JDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVE0JDe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVE0JBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:01:39 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:42925 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262391AbVE0JAo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:00:44 -0400
Date: Fri, 27 May 2005 11:02:20 +0200
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [patch 3/10] s390: set online race in the lcs driver
Message-ID: <20050527090220.GC8213@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Frank Pavlic <pavlic@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch 3/10] s390: set online race in the lcs driver.

From: Michael Holzheu <holzheu@de.ibm.com>

There is a race between lcs_stopcard() and lcs_open_device() which
can lead to the error 'lcs: Error in starting channel, rc=-16'.
lcs_open_device() is invoked when 'ifconfig up' is called due to a
hotplug event, which is caused by register_netdev(). In parallel
lcs_stopcard() is executed. Both functions are sending lcs commands.
The second invocation fails with -EBUSY (-16) as return value.
Move invocation of register_netdev() after invocation of lcs_stopcard
to avoid the race.

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 drivers/s390/net/lcs.c |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff -urpN linux-2.6/drivers/s390/net/lcs.c linux-2.6-patched/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	2005-05-06 11:26:14.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/lcs.c	2005-05-06 11:26:16.000000000 +0200
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.97 $	 $Date: 2005/03/31 09:42:02 $
+ *    $Revision: 1.98 $	 $Date: 2005/04/18 13:41:29 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,7 +59,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.97 $"
+#define VERSION_LCS_C  "$Revision: 1.98 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 static char debug_buffer[255];
@@ -1098,14 +1098,6 @@ lcs_check_multicast_support(struct lcs_c
 		PRINT_ERR("Query IPAssist failed. Assuming unsupported!\n");
 		return -EOPNOTSUPP;
 	}
-	/* Print out supported assists: IPv6 */
-	PRINT_INFO("LCS device %s %s IPv6 support\n", card->dev->name,
-		   (card->ip_assists_supported & LCS_IPASS_IPV6_SUPPORT) ?
-		   "with" : "without");
-	/* Print out supported assist: Multicast */
-	PRINT_INFO("LCS device %s %s Multicast support\n", card->dev->name,
-		   (card->ip_assists_supported & LCS_IPASS_MULTICAST_SUPPORT) ?
-		   "with" : "without");
 	if (card->ip_assists_supported & LCS_IPASS_MULTICAST_SUPPORT)
 		return 0;
 	return -EOPNOTSUPP;
@@ -2198,30 +2190,39 @@ lcs_new_device(struct ccwgroup_device *c
 	if (!dev)
 		goto out;
 	card->dev = dev;
-netdev_out:
 	card->dev->priv = card;
 	card->dev->open = lcs_open_device;
 	card->dev->stop = lcs_stop_device;
 	card->dev->hard_start_xmit = lcs_start_xmit;
 	card->dev->get_stats = lcs_getstats;
 	SET_MODULE_OWNER(dev);
-	if (lcs_register_netdev(ccwgdev) != 0)
-		goto out;
 	memcpy(card->dev->dev_addr, card->mac, LCS_MAC_LENGTH);
 #ifdef CONFIG_IP_MULTICAST
 	if (!lcs_check_multicast_support(card))
 		card->dev->set_multicast_list = lcs_set_multicast_list;
 #endif
-	netif_stop_queue(card->dev);
+netdev_out:
 	lcs_set_allowed_threads(card,0xffffffff);
 	if (recover_state == DEV_STATE_RECOVER) {
 		lcs_set_multicast_list(card->dev);
 		card->dev->flags |= IFF_UP;
 		netif_wake_queue(card->dev);
 		card->state = DEV_STATE_UP;
-	} else
+	} else {
 		lcs_stopcard(card);
+	}
 
+	if (lcs_register_netdev(ccwgdev) != 0)
+		goto out;
+
+	/* Print out supported assists: IPv6 */
+	PRINT_INFO("LCS device %s %s IPv6 support\n", card->dev->name,
+		   (card->ip_assists_supported & LCS_IPASS_IPV6_SUPPORT) ?
+		   "with" : "without");
+	/* Print out supported assist: Multicast */
+	PRINT_INFO("LCS device %s %s Multicast support\n", card->dev->name,
+		   (card->ip_assists_supported & LCS_IPASS_MULTICAST_SUPPORT) ?
+		   "with" : "without");
 	return 0;
 out:
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVKLRlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVKLRlX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 12:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVKLRlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 12:41:23 -0500
Received: from fmr19.intel.com ([134.134.136.18]:63665 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932428AbVKLRlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 12:41:22 -0500
Message-ID: <43763964.5020503@linux.intel.com>
Date: Sat, 12 Nov 2005 12:50:12 -0600
From: James Ketrenos <jketreno@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: NetDev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
CC: Benoit Boissinot <bboissin+ipw2100@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] ipw2100: Fix 'Driver using old /proc/net/wireless...' message
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ipw2100: Fix 'Driver using old /proc/net/wireless...' message

Wireless extensions moved the get_wireless_stats handler from being
in net_device into wireless_handler.

A prior instance of this patch resolved the issue for the ipw2200.  This
one fixes it for the ipw2100.

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Signed-off-by: James Ketrenos <jketreno@linux.intel.com>
---
Also available as overlay at rsync://bughost.org/repos/ipw-delta/.git/
---
 drivers/net/wireless/ipw2100.c |   29 ++++++++++++++++++-----------
 drivers/net/wireless/ipw2100.h |    2 ++
 2 files changed, 20 insertions(+), 11 deletions(-)
---
diff --git a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
index a2e6214..77d2a21 100644
--- a/drivers/net/wireless/ipw2100.c
+++ b/drivers/net/wireless/ipw2100.c
@@ -6344,7 +6344,8 @@ static struct net_device *ipw2100_alloc_
 	dev->ethtool_ops = &ipw2100_ethtool_ops;
 	dev->tx_timeout = ipw2100_tx_timeout;
 	dev->wireless_handlers = &ipw2100_wx_handler_def;
-	dev->get_wireless_stats = ipw2100_wx_wireless_stats;
+	priv->wireless_data.ieee80211 = priv->ieee;
+	dev->wireless_data = &priv->wireless_data;
 	dev->set_mac_address = ipw2100_set_address;
 	dev->watchdog_timeo = 3 * HZ;
 	dev->irq = 0;
@@ -7178,6 +7179,11 @@ static int ipw2100_wx_get_range(struct n
 	}
 	range->num_frequency = val;
 
+	/* Event capability (kernel + driver) */
+	range->event_capa[0] = (IW_EVENT_CAPA_K_0 |
+				IW_EVENT_CAPA_MASK(SIOCGIWAP));
+	range->event_capa[1] = IW_EVENT_CAPA_K_1;
+
 	IPW_DEBUG_WX("GET Range\n");
 
 	return 0;
@@ -8446,16 +8452,6 @@ static iw_handler ipw2100_private_handle
 #endif				/* CONFIG_IPW2100_MONITOR */
 };
 
-static struct iw_handler_def ipw2100_wx_handler_def = {
-	.standard = ipw2100_wx_handlers,
-	.num_standard = sizeof(ipw2100_wx_handlers) / sizeof(iw_handler),
-	.num_private = sizeof(ipw2100_private_handler) / sizeof(iw_handler),
-	.num_private_args = sizeof(ipw2100_private_args) /
-	    sizeof(struct iw_priv_args),
-	.private = (iw_handler *) ipw2100_private_handler,
-	.private_args = (struct iw_priv_args *)ipw2100_private_args,
-};
-
 /*
  * Get wireless statistics.
  * Called by /proc/net/wireless
@@ -8597,6 +8593,17 @@ static struct iw_statistics *ipw2100_wx_
 	return (struct iw_statistics *)NULL;
 }
 
+static struct iw_handler_def ipw2100_wx_handler_def = {
+	.standard = ipw2100_wx_handlers,
+	.num_standard = sizeof(ipw2100_wx_handlers) / sizeof(iw_handler),
+	.num_private = sizeof(ipw2100_private_handler) / sizeof(iw_handler),
+	.num_private_args = sizeof(ipw2100_private_args) /
+	    sizeof(struct iw_priv_args),
+	.private = (iw_handler *) ipw2100_private_handler,
+	.private_args = (struct iw_priv_args *)ipw2100_private_args,
+	.get_wireless_stats = ipw2100_wx_wireless_stats,
+};
+
 static void ipw2100_wx_event_work(struct ipw2100_priv *priv)
 {
 	union iwreq_data wrqu;
diff --git a/drivers/net/wireless/ipw2100.h b/drivers/net/wireless/ipw2100.h
index a1a9cbc..7f20cf3 100644
--- a/drivers/net/wireless/ipw2100.h
+++ b/drivers/net/wireless/ipw2100.h
@@ -572,6 +572,8 @@ struct ipw2100_priv {
 	struct net_device *net_dev;
 	struct iw_statistics wstats;
 
+	struct iw_public_data wireless_data;
+
 	struct tasklet_struct irq_tasklet;
 
 	struct workqueue_struct *workqueue;


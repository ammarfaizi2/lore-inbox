Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWHVC2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWHVC2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 22:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWHVC2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 22:28:55 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:51617 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751125AbWHVC2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 22:28:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=o3j/LJp2b4TKGW0K1p8bzc6w+EGa4QDGx9+aO3SCKzRuhS30p6459XWPvHRGHxOIux1CCBUR8uM5wr79G4G3Bc13EboBWeqIvddeMiHjGD5hoodP+7FdIH5ENdpexpoYbQKrzYTXuCxJ/Hs2QvGDGziQYSHVsfD8SfMkkVS1Qts=
Message-ID: <c0835eaf0608211928k706cdb0bve3b08012d61b03f1@mail.gmail.com>
Date: Mon, 21 Aug 2006 22:28:54 -0400
From: "Robert Carr" <rcarrlkm@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18] atmel.c: General clean up
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just general cleanup, SET_MODULE_OWNER is defunct, using time_after is
preferable to comparing jiffies, and general practice is to set
last_rx after netif_rx (right?). This is my first attempt at a patch
so if I have horribly messed something up feedback is appreciated.


  --- a/drivers/net/wireless/atmel.c	2006-08-22 02:11:11.000000000 -0400
+++ b/drivers/net/wireless/atmel.c	2006-08-22 02:10:16.000000000 -0400
@@ -65,6 +65,7 @@
 #include <linux/crc32.h>
 #include <linux/proc_fs.h>
 #include <linux/device.h>
+#include <linux/jiffies.h>
 #include <linux/moduleparam.h>
 #include <linux/firmware.h>
 #include <net/ieee80211.h>
@@ -920,11 +921,12 @@ static void fast_rx_path(struct atmel_pr
 	else
  		memcpy(&skbp[6], header->addr2, 6); /* source address */

-	priv->dev->last_rx = jiffies;
  	skb->dev = priv->dev;
  	skb->protocol = eth_type_trans(skb, priv->dev);
  	skb->ip_summed = CHECKSUM_NONE;
  	netif_rx(skb);
+	priv->dev->last_rx = jiffies;
  	priv->stats.rx_bytes += 12 + msdu_size;
  	priv->stats.rx_packets++;
 }
@@ -1028,11 +1030,12 @@ static void frag_rx_path(struct atmel_pr
  				memcpy(skb_put(skb, priv->frag_len + 12),
  				       priv->rx_buf,
  				       priv->frag_len + 12);
-				priv->dev->last_rx = jiffies;
  				skb->dev = priv->dev;
  				skb->protocol = eth_type_trans(skb, priv->dev);
  				skb->ip_summed = CHECKSUM_NONE;
  				netif_rx(skb);
+			       priv->dev->last_rx = jiffies;
  				priv->stats.rx_bytes += priv->frag_len + 12;
  				priv->stats.rx_packets++;
 			}
@@ -1391,7 +1394,7 @@ static int atmel_validate_channel(struct
 {
 	/* check that channel is OK, if so return zero,
 	   else return suitable default channel */
-	int i;
+      unsigned int i;

 	for (i = 0; i < sizeof(channel_table)/sizeof(channel_table[0]); i++)
  		if (priv->reg_domain == channel_table[i].reg_domain) {
@@ -1606,7 +1609,7 @@ struct net_device *init_atmel_card(unsig
  	       dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
  	       dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5] );

-	SET_MODULE_OWNER(dev);
  	return dev;

 err_out_res:
@@ -2291,7 +2294,7 @@ static int atmel_set_scan(struct net_dev
  		return -EAGAIN;

 	/* Timeout old surveys. */
-	if ((jiffies - priv->last_survey) > (20 * HZ))
+	if (time_after(jiffies, data->last_updated + HZ * 20))
  		priv->site_survey_state = SITE_SURVEY_IDLE;
  	priv->last_survey = jiffies;




Signed-off-by: Robert Carr <rcarrlkm@gmail.com>

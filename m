Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271108AbUJUXct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271108AbUJUXct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271076AbUJUXcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:32:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47532 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S271099AbUJUX3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:29:19 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] use mmiowb in tg3.c
Date: Thu, 21 Oct 2004 16:28:06 -0700
User-Agent: KMail/1.7
Cc: netdev@oss.sgi.com, jgarzik@pobox.com, davem@davemloft.net, gnb@sgi.com,
       akepner@sgi.com
References: <200410211613.19601.jbarnes@engr.sgi.com>
In-Reply-To: <200410211613.19601.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GYEeBF4j/oqi4yZ"
Message-Id: <200410211628.06906.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_GYEeBF4j/oqi4yZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch originally from Greg Banks.  Some parts of the tg3 driver depend on 
PIO writes arriving in order.  This patch ensures that in two key places 
using the new mmiowb macro.  This not only prevents bugs (the queues can be 
corrupted), but is much faster than ensuring ordering using PIO reads (which 
involve a few round trips to the target bus on some platforms).

Arthur has another patch that uses mmiowb in tg3 that he posted earlier as 
well.

Signed-off-by: Greg Banks <gnb@sgi.com>
Signed-off-by: Jesse Barnes <jbarnes@sgi.com

Thanks,
Jesse

--Boundary-00=_GYEeBF4j/oqi4yZ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="tg3-mmiowb-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="tg3-mmiowb-2.patch"

===== drivers/net/tg3.c 1.210 vs edited =====
--- 1.210/drivers/net/tg3.c	2004-10-06 09:42:56 -07:00
+++ edited/drivers/net/tg3.c	2004-10-21 16:06:37 -07:00
@@ -2729,6 +2729,7 @@
 		tw32_rx_mbox(MAILBOX_RCV_JUMBO_PROD_IDX + TG3_64BIT_REG_LOW,
 			     sw_idx);
 	}
+	mmiowb();
 
 	return received;
 }
@@ -3176,6 +3177,7 @@
 		netif_stop_queue(dev);
 
 out_unlock:
+    	mmiowb();
 	spin_unlock_irqrestore(&tp->tx_lock, flags);
 
 	dev->trans_start = jiffies;

--Boundary-00=_GYEeBF4j/oqi4yZ--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWGKWya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWGKWya (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWGKWya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:54:30 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:27947 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932229AbWGKWy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:54:29 -0400
X-IronPort-AV: i="4.06,230,1149490800"; 
   d="scan'208"; a="433803758:sNHT31854394"
To: "Zach Brown" <zach.brown@oracle.com>
Cc: openib-general@openib.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>, "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [openib-general] ipoib lockdep warning
X-Message-Flag: Warning: May contain useful information
References: <44B405C8.4040706@oracle.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 11 Jul 2006 15:54:26 -0700
Message-ID: <adawtajzra5.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Jul 2006 22:54:27.0612 (UTC) FILETIME=[F65675C0:01C6A53C]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No time to really look at this in detail, but I think the issue is a
slightly bogus conversion to netif_tx_lock().  Can you try this patch
and see if things are better?

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index ab40488..ddd1946 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -820,9 +820,8 @@ void ipoib_mcast_restart_task(void *dev_
 
 	ipoib_mcast_stop_thread(dev, 0);
 
-	local_irq_save(flags);
 	netif_tx_lock(dev);
-	spin_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, flags);
 
 	/*
 	 * Unfortunately, the networking core only gives us a list of all of
@@ -893,9 +892,8 @@ void ipoib_mcast_restart_task(void *dev_
 		}
 	}
 
-	spin_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, flags);
 	netif_tx_unlock(dev);
-	local_irq_restore(flags);
 
 	/* We have to cancel outside of the spinlock */
 	list_for_each_entry_safe(mcast, tmcast, &remove_list, list) {

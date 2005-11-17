Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbVKQSIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbVKQSIK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVKQSII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:08:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:29346 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932612AbVKQSEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:15 -0500
Date: Thu, 17 Nov 2005 09:47:45 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       herbert@gondor.apana.org.au, oliver@neukum.name
Subject: [patch 16/22] USB: fix race in kaweth disconnect
Message-ID: <20051117174745.GP11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-fix-race-in-kaweth-disconnect.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

this patch from Herbert Xu fixes a race by moving termination of
the URBs into close() exclusively.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Oliver Neukum <oliver@neukum.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/net/kaweth.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

--- usb-2.6.orig/drivers/usb/net/kaweth.c
+++ usb-2.6/drivers/usb/net/kaweth.c
@@ -219,7 +219,6 @@ struct kaweth_device
 
 	__u32 status;
 	int end;
-	int removed;
 	int suspend_lowmem_rx;
 	int suspend_lowmem_ctrl;
 	int linkstate;
@@ -699,6 +698,7 @@ static int kaweth_close(struct net_devic
 
 	usb_kill_urb(kaweth->irq_urb);
 	usb_kill_urb(kaweth->rx_urb);
+	usb_kill_urb(kaweth->tx_urb);
 
 	flush_scheduled_work();
 
@@ -750,13 +750,6 @@ static int kaweth_start_xmit(struct sk_b
 
 	spin_lock(&kaweth->device_lock);
 
-	if (kaweth->removed) {
-	/* our device is undergoing disconnection - we bail out */
-		spin_unlock(&kaweth->device_lock);
-		dev_kfree_skb_irq(skb);
-		return 0;
-	}
-
 	kaweth_async_set_rx_mode(kaweth);
 	netif_stop_queue(net);
 
@@ -1136,10 +1129,6 @@ static void kaweth_disconnect(struct usb
 		return;
 	}
 	netdev = kaweth->net;
-	kaweth->removed = 1;
-	usb_kill_urb(kaweth->irq_urb);
-	usb_kill_urb(kaweth->rx_urb);
-	usb_kill_urb(kaweth->tx_urb);
 
 	kaweth_dbg("Unregistering net device");
 	unregister_netdev(netdev);

--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWETTWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWETTWd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 15:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWETTWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 15:22:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:12363 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750779AbWETTWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 15:22:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=ESPVf36QVu5Rqo5UUhLgI26g5eTRZy6fki4FHhMP79kwMe+mkQ2CkYLLS4DBJhQgJ7u9nJHkuHWdXH7TAh/X16bzk5xOyHPqt3eNuh8D3qlsY2ob9NpebiqSzUdfmKZfIWlL7+ZNhW+FtNPpIUFP/WuKk+O/DY7aS1LzCUHMk/w=
Message-ID: <446F6D9B.1070500@gmail.com>
Date: Sat, 20 May 2006 15:27:23 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: proski@gnu.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] orinoco: possible null pointer dereference in orinoco_rx_monitor()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the skb allocation fails, the current error path calls
dev_kfree_skb_irq() with a NULL argument. Also, 'err' is not being used.

Coverity CID: 275.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

diff --git a/drivers/net/wireless/orinoco.c b/drivers/net/wireless/orinoco.c
index 06523e2..c2d0b09 100644
--- a/drivers/net/wireless/orinoco.c
+++ b/drivers/net/wireless/orinoco.c
@@ -812,7 +812,6 @@ static void orinoco_rx_monitor(struct ne
 	if (datalen > IEEE80211_DATA_LEN + 12) {
 		printk(KERN_DEBUG "%s: oversized monitor frame, "
 		       "data length = %d\n", dev->name, datalen);
-		err = -EIO;
 		stats->rx_length_errors++;
 		goto update_stats;
 	}
@@ -821,8 +820,7 @@ static void orinoco_rx_monitor(struct ne
 	if (!skb) {
 		printk(KERN_WARNING "%s: Cannot allocate skb for monitor frame\n",
 		       dev->name);
-		err = -ENOMEM;
-		goto drop;
+		goto update_stats;
 	}
 
 	/* Copy the 802.11 header to the skb */



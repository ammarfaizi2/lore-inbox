Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWCIXGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWCIXGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWCIXGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:06:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11274 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750752AbWCIXGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:06:47 -0500
Date: Fri, 10 Mar 2006 00:06:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jkmaline@cc.hut.fi
Cc: hostap@shmoo.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linville@tuxdriver.com
Subject: [RFC: 2.6 patch] hostap_hw.c:hfa384x_set_rid(): fix error handling
Message-ID: <20060309230646.GI21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker noted that the call to prism2_hw_reset() was dead 
code.

Does this patch change the code to what was intended?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/net/wireless/hostap/hostap_hw.c.old	2006-03-09 23:28:30.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/net/wireless/hostap/hostap_hw.c	2006-03-09 23:30:19.000000000 +0100
@@ -928,16 +928,16 @@ static int hfa384x_set_rid(struct net_de
 
 	res = hfa384x_cmd(dev, HFA384X_CMDCODE_ACCESS_WRITE, rid, NULL, NULL);
 	up(&local->rid_bap_sem);
+
 	if (res) {
+		if (res == -ETIMEDOUT)
+			prism2_hw_reset(dev);
+
 		printk(KERN_DEBUG "%s: hfa384x_set_rid: CMDCODE_ACCESS_WRITE "
 		       "failed (res=%d, rid=%04x, len=%d)\n",
 		       dev->name, res, rid, len);
-		return res;
 	}
 
-	if (res == -ETIMEDOUT)
-		prism2_hw_reset(dev);
-
 	return res;
 }
 


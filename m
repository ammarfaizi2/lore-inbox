Return-Path: <linux-kernel-owner+w=401wt.eu-S1752313AbWLXPv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbWLXPv7 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 10:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbWLXPv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 10:51:59 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:65503 "EHLO
	mtiwmhc11.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752165AbWLXPv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 10:51:58 -0500
Message-ID: <458EA216.7000101@lwfinger.net>
Date: Sun, 24 Dec 2006 09:51:50 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Broadcom Linux <bcm43xx-dev@lists.berlios.de>,
       netdev <netdev@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, torvalds@osdl.org
Subject: bcm43xx-softmac broken on 2.6.20-rc2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a heads-up for anyone wishing to use bcm43xx-softmac on Linus's git tree, which is now at
v2.6.20-rc2. There are two serious bugs in that code. Fixes are found below.

The first bug is the result of changes in work queues. The second is the result of a typo that locks 
a mutex when it should unlock it.

These fixes have been pushed up stream, but neither has made it to Linus.

Larry
---

diff --git a/net/ieee80211/softmac/ieee80211softmac_assoc.c 
b/net/ieee80211/softmac/ieee80211softmac_assoc.c
index eec1a1d..a824852 100644
--- a/net/ieee80211/softmac/ieee80211softmac_assoc.c
+++ b/net/ieee80211/softmac/ieee80211softmac_assoc.c
@@ -167,7 +167,7 @@ static void
  ieee80211softmac_assoc_notify_scan(struct net_device *dev, int event_type, void *context)
  {
  	struct ieee80211softmac_device *mac = ieee80211_priv(dev);
-	ieee80211softmac_assoc_work((void*)mac);
+	ieee80211softmac_assoc_work(&mac->associnfo.work.work);
  }

  static void
@@ -177,7 +177,7 @@ ieee80211softmac_assoc_notify_auth(struc

  	switch (event_type) {
  	case IEEE80211SOFTMAC_EVENT_AUTHENTICATED:
-		ieee80211softmac_assoc_work((void*)mac);
+		ieee80211softmac_assoc_work(&mac->associnfo.work.work);
  		break;
  	case IEEE80211SOFTMAC_EVENT_AUTH_FAILED:
  	case IEEE80211SOFTMAC_EVENT_AUTH_TIMEOUT:




Index: linux-2.6/net/ieee80211/softmac/ieee80211softmac_wx.c
===================================================================
--- linux-2.6.orig/net/ieee80211/softmac/ieee80211softmac_wx.c
+++ linux-2.6/net/ieee80211/softmac/ieee80211softmac_wx.c
@@ -463,7 +463,7 @@ ieee80211softmac_wx_get_genie(struct net
  			err = -E2BIG;
  	}
  	spin_unlock_irqrestore(&mac->lock, flags);
-	mutex_lock(&mac->associnfo.mutex);
+	mutex_unlock(&mac->associnfo.mutex);

  	return err;
  }


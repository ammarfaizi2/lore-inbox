Return-Path: <linux-kernel-owner+w=401wt.eu-S1751115AbXAFCb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbXAFCb4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbXAFCbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:31:07 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36678 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbXAFCay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:30:54 -0500
Message-Id: <20070106023408.591445000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:21 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       Ulrich Kunitz <kune@deine-taler.de>,
       John W Linville <linville@tuxdriver.com>
Subject: [patch 28/50] softmac: Fixed handling of deassociation from AP
Content-Disposition: inline; filename=softmac-fixed-handling-of-deassociation-from-ap.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Ulrich Kunitz <kune@deine-taler.de>

In 2.6.19 a deauthentication from the AP doesn't start a
reassociation by the softmac code. It appears that
mac->associnfo.associating must be set and the
ieee80211softmac_assoc_work function must be scheduled. This patch
fixes that.

Signed-off-by: Ulrich Kunitz <kune@deine-taler.de>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
Date: Sun, 3 Dec 2006 15:32:00 +0000 (+0100)
Subject: [patch 28/50] [PATCH] softmac: Fixed handling of deassociation from AP
X-Git-Tag: v2.6.20-rc1
X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=2b50c24554d31c2db2f93b1151b5991e62f96594

 net/ieee80211/softmac/ieee80211softmac_assoc.c |   14 ++++++++++++--
 net/ieee80211/softmac/ieee80211softmac_auth.c  |    2 ++
 net/ieee80211/softmac/ieee80211softmac_priv.h  |    2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

--- linux-2.6.19.1.orig/net/ieee80211/softmac/ieee80211softmac_assoc.c
+++ linux-2.6.19.1/net/ieee80211/softmac/ieee80211softmac_assoc.c
@@ -427,6 +427,17 @@ ieee80211softmac_handle_assoc_response(s
 	return 0;
 }
 
+void
+ieee80211softmac_try_reassoc(struct ieee80211softmac_device *mac)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mac->lock, flags);
+	mac->associnfo.associating = 1;
+	schedule_work(&mac->associnfo.work);
+	spin_unlock_irqrestore(&mac->lock, flags);
+}
+
 int
 ieee80211softmac_handle_disassoc(struct net_device * dev,
 				 struct ieee80211_disassoc *disassoc)
@@ -445,8 +456,7 @@ ieee80211softmac_handle_disassoc(struct 
 	dprintk(KERN_INFO PFX "got disassoc frame\n");
 	ieee80211softmac_disassoc(mac);
 
-	/* try to reassociate */
-	schedule_work(&mac->associnfo.work);
+	ieee80211softmac_try_reassoc(mac);
 
 	return 0;
 }
--- linux-2.6.19.1.orig/net/ieee80211/softmac/ieee80211softmac_auth.c
+++ linux-2.6.19.1/net/ieee80211/softmac/ieee80211softmac_auth.c
@@ -328,6 +328,8 @@ ieee80211softmac_deauth_from_net(struct 
 	/* can't transmit data right now... */
 	netif_carrier_off(mac->dev);
 	spin_unlock_irqrestore(&mac->lock, flags);
+
+	ieee80211softmac_try_reassoc(mac);
 }
 
 /* 
--- linux-2.6.19.1.orig/net/ieee80211/softmac/ieee80211softmac_priv.h
+++ linux-2.6.19.1/net/ieee80211/softmac/ieee80211softmac_priv.h
@@ -238,4 +238,6 @@ void ieee80211softmac_call_events_locked
 int ieee80211softmac_notify_internal(struct ieee80211softmac_device *mac,
 	int event, void *event_context, notify_function_ptr fun, void *context, gfp_t gfp_mask);
 
+void ieee80211softmac_try_reassoc(struct ieee80211softmac_device *mac);
+
 #endif /* IEEE80211SOFTMAC_PRIV_H_ */

--

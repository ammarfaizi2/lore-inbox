Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425026AbWLCHmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425026AbWLCHmI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 02:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425024AbWLCHmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 02:42:08 -0500
Received: from alnrmhc11.comcast.net ([206.18.177.51]:39345 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1425022AbWLCHmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 02:42:07 -0500
Date: Sat, 2 Dec 2006 23:42:03 -0800
From: Maxime Austruy <maxime@tralhalla.org>
To: linville@tuxdriver.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] softmac: fix unbalanced mutex_lock/unlock in ieee80211softmac_wx_set_mlme
Message-ID: <20061203074203.GB5785@tralhalla.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Found a hang while playing with wpa_supplicant and a zd1211 usb adapter
using linux 2.6.19.  The problem is that ieee80211softmac_wx_set_mlme
forgets to release a mutex when mlme->cmd is IW_MLME_DEAUTH.  The fix
below allows me to kill wpa_supplicant and to restart it without having
to reboot the machine. FWIW, it seems that the problem was introduced
between 2.6.19-rc2 and 2.6.19-rc3 when this function was changed to use
a mutex.

Signed-off-by: Maxime Austruy <maxime@tralhalla.org>

--
 net/ieee80211/softmac/ieee80211softmac_wx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux.orig/net/ieee80211/softmac/ieee80211softmac_wx.c	2006-11-29 13:57:37.000000000 -0800
+++ linux/net/ieee80211/softmac/ieee80211softmac_wx.c	2006-12-02 22:58:20.000000000 -0800
@@ -495,7 +495,8 @@ ieee80211softmac_wx_set_mlme(struct net_
 			printk(KERN_DEBUG PFX "wx_set_mlme: we should know the net here...\n");
 			goto out;
 		}
-		return ieee80211softmac_deauth_req(mac, net, reason);
+		err =  ieee80211softmac_deauth_req(mac, net, reason);
+		goto out;
 	case IW_MLME_DISASSOC:
 		ieee80211softmac_send_disassoc_req(mac, reason);
 		mac->associnfo.associated = 0;

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWFBTqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWFBTqi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWFBTqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:46:37 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:25473 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751468AbWFBTqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:46:23 -0400
Message-Id: <20060602194743.769166000@sous-sol.org>
References: <20060602194618.482948000@sous-sol.org>
Date: Fri, 02 Jun 2006 00:00:08 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgewood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Zhu Yi <yi.zhu@intel.com>,
       John W Linville <linville@tuxdriver.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 08/11] ipw2200: Filter unsupported channels out in ad-hoc mode
Content-Disposition: inline; filename=ipw2200-Filter-unsupported-channels-out-in-ad-hoc-mode.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Zhu Yi <yi.zhu@intel.com>

Currently iwlist ethX freq[uency]/channel lists all the channels the card
supported for the current region, which includes some channels can only
be used in infrastructure mode. This patch filters these channels out if
the card is currently in ad-hoc mode.

Signed-off-by: Zhu Yi <yi.zhu@intel.com>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---

 drivers/net/wireless/ipw2200.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- linux-2.6.16.19.orig/drivers/net/wireless/ipw2200.c
+++ linux-2.6.16.19/drivers/net/wireless/ipw2200.c
@@ -8391,20 +8391,28 @@ static int ipw_wx_get_range(struct net_d
 
 	i = 0;
 	if (priv->ieee->mode & (IEEE_B | IEEE_G)) {
-		for (j = 0; j < geo->bg_channels && i < IW_MAX_FREQUENCIES;
-		     i++, j++) {
+		for (j = 0; j < geo->bg_channels && i < IW_MAX_FREQUENCIES; j++) {
+			if ((priv->ieee->iw_mode == IW_MODE_ADHOC) &&
+			    (geo->bg[j].flags & IEEE80211_CH_PASSIVE_ONLY))
+				continue;
+
 			range->freq[i].i = geo->bg[j].channel;
 			range->freq[i].m = geo->bg[j].freq * 100000;
 			range->freq[i].e = 1;
+			i++;
 		}
 	}
 
 	if (priv->ieee->mode & IEEE_A) {
-		for (j = 0; j < geo->a_channels && i < IW_MAX_FREQUENCIES;
-		     i++, j++) {
+		for (j = 0; j < geo->a_channels && i < IW_MAX_FREQUENCIES; j++) {
+			if ((priv->ieee->iw_mode == IW_MODE_ADHOC) &&
+			    (geo->a[j].flags & IEEE80211_CH_PASSIVE_ONLY))
+				continue;
+
 			range->freq[i].i = geo->a[j].channel;
 			range->freq[i].m = geo->a[j].freq * 100000;
 			range->freq[i].e = 1;
+			i++;
 		}
 	}
 

--

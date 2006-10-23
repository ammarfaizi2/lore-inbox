Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWJWSVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWJWSVg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWJWSVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:21:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:27434 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964987AbWJWSVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:21:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=sReHGEYEx6cOLLajEu+HMp7D8VC3pfVofMZFi2gftXcleBCc05OXF3HkPjF2kzcN6kXdmldgJ5uYEGkrYN7Q5Hv2qSZljqo5+FztuNca2AkIGxPUQZYdBaKiagH3gqDFvmMVEG721foF2eNKGplm+kcXzbiDnOP8bjkDj368USI=
Message-ID: <f46018bb0610231121s4fb48f88l28a6e7d4f31d40bb@mail.gmail.com>
Date: Mon, 23 Oct 2006 14:21:32 -0400
From: "Holden Karau" <holden@pigscanfly.ca>
To: zd1211-devs@lists.sourceforge.net
Subject: [PATCH] wireless-2.6 zd1211rw check against regulatory domain rather than hardcoded value of 11
Cc: linville@tuxdriver.com, netdev <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, holdenk@xandros.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 37a037dadd6cebb5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Holden Karau <holden@pigscanfly.ca> http://www.holdenkarau.com

I have made a small patch for the zd1211rw driver which uses the
boundry channels of the regulatory domain, rather than the hard coded
values of 1 & 11.
Signed-off-by: Holden Karau <holden@pigscanfly.ca> http://www.holdenkarau.com
---
I'm not entirely sure how useful this patch is, but it seems like a
good idea. If its totally misguided, let me know :-) In case the patch
gets mangled I've put it up at
http://www.holdenkarau.com/~holden/projects/zd1211rw/zd1211rw-use-geo-for-channels.patch
And now for the patch:
--- a/drivers/net/wireless/zd1211rw/zd_chip.c	2006-10-23
10:07:39.000000000 -0400
+++ b/drivers/net/wireless/zd1211rw/zd_chip.c	2006-10-23
10:41:51.000000000 -0400
@@ -38,6 +38,8 @@ void zd_chip_init(struct zd_chip *chip,
 	mutex_init(&chip->mutex);
 	zd_usb_init(&chip->usb, netdev, intf);
 	zd_rf_init(&chip->rf);
+	/* The chip needs to know which geo it is in */
+	chip->geo = ieee80211_get_geo(zd_mac_to_ieee80211(zd_netdev_mac(netdev)));
 }

 void zd_chip_clear(struct zd_chip *chip)
@@ -606,14 +608,17 @@ static int patch_6m_band_edge(struct zd_
 		{ CR128, 0x14 }, { CR129, 0x12 }, { CR130, 0x10 },
 		{ CR47,  0x1e },
 	};
+	struct ieee80211_geo *geo = chip->geo;

 	if (!chip->patch_6m_band_edge || !chip->rf.patch_6m_band_edge)
 		return 0;

-	/* FIXME: Channel 11 is not the edge for all regulatory domains. */
-	if (channel == 1 || channel == 11)
+	/* Checks the channel boundry of the region */
+	dev_dbg_f("checking boundry == %d || %d\n" , 1 , geo->bg_channels);
+	if (channel == 1 || channel == geo->bg_channels)
 		ioreqs[0].value = 0x12;

+
 	dev_dbg_f(zd_chip_dev(chip), "patching for channel %d\n", channel);
 	return zd_iowrite16a_locked(chip, ioreqs, ARRAY_SIZE(ioreqs));
 }
--- a/drivers/net/wireless/zd1211rw/zd_chip.h	2006-10-23
10:07:39.000000000 -0400
+++ b/drivers/net/wireless/zd1211rw/zd_chip.h	2006-10-23
10:39:08.000000000 -0400
@@ -21,6 +21,8 @@
 #include "zd_types.h"
 #include "zd_rf.h"
 #include "zd_usb.h"
+#include "zd_ieee80211.h"
+#include <linux/wireless.h>

 /* Header for the Media Access Controller (MAC) and the Baseband Processor
  * (BBP). It appears that the ZD1211 wraps the old ZD1205 with USB glue and
@@ -669,6 +671,7 @@ struct zd_chip {
 	/* SetPointOFDM in the vendor driver */
 	u8 ofdm_cal_values[3][E2P_CHANNEL_COUNT];
 	u16 link_led;
+  	struct ieee80211_geo* geo;
 	unsigned int pa_type:4,
 		patch_cck_gain:1, patch_cr157:1, patch_6m_band_edge:1,
 		new_phy_layout:1,

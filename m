Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVCWO1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVCWO1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVCWO1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:27:32 -0500
Received: from colino.net ([213.41.131.56]:51451 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262399AbVCWO0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:26:35 -0500
Date: Wed, 23 Mar 2005 15:26:12 +0100
From: Colin Leroy <colin@colino.net>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: RFC: workaround quality bug in zd1201 hardware
Message-ID: <20050323152612.66dce7e2@jack.colino.net>
X-Mailer: Sylpheed-Claws 1.9.6cvs9 (GTK+ 2.6.1; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I saw in zd1201.c that there's a hardware bug related to quality
statistics:
 /* Unfortunatly the quality and noise reported is useless. 
    they seem to be accumulators that increase until you
    read them, unless we poll on a fixed interval we can't
    use them
  */

Given that I couldn't find any spec for the zd1201, I tried the
following patch to see if we could cheat by updating commsquality while
scanning. The idea is to use the values we find during scan and copy
them to zd->iwstats; this can be useful because there are a lots of
tools out there that perform scanning periodically (netapplet,
NetworkManager, ...).

Unfortunately this doesn't work perfectly, because it looks like the
scale is different when reporting AP quality on scanning and
"normal" quality.

Maybe this can be made useful with a simple conversion ?
If anyone that has more knowledge on 802.11b than I have could give me
an hint, it'd be appreciated.

Thanks!
Signed-off-by: Colin Leroy <colin@colino.net>
--- a/drivers/usb/net/zd1201.c	2005-03-23 15:17:12.000000000 +0100
+++ b/drivers/usb/net/zd1201.c	2005-03-23 15:17:50.000000000 +0100
@@ -1160,6 +1160,7 @@
 		return -EIO;
 
 	for(i=8; i<zd->rxlen; i+=62) {
+		const char *ap_essid;
 		iwe.cmd = SIOCGIWAP;
 		iwe.u.ap_addr.sa_family = ARPHRD_ETHER;
 		memcpy(iwe.u.ap_addr.sa_data, zd->rxdata+i+6, 6);
@@ -1169,6 +1170,7 @@
 		iwe.u.data.length = zd->rxdata[i+16];
 		iwe.u.data.flags = 1;
 		cev = iwe_stream_add_point(cev, end_buf, &iwe, zd->rxdata+i+18);
+		ap_essid = zd->rxdata+i+18;
 
 		iwe.cmd = SIOCGIWMODE;
 		if (zd->rxdata[i+14]&0x01)
@@ -1204,6 +1206,17 @@
 		iwe.u.qual.noise= zd->rxdata[i+2]/10-100;
 		iwe.u.qual.level = (256+zd->rxdata[i+4]*100)/255-100;
 		iwe.u.qual.updated = 7;
+
+		if (ap_essid && zd->essid && !strcmp(ap_essid, zd->essid)) {
+			/* hack: work around hardware bug, update current 
+			 * link quality using the scan result. 
+			 */
+			zd->iwstats.qual.qual = iwe.u.qual.qual;
+			zd->iwstats.qual.level = iwe.u.qual.level;
+			zd->iwstats.qual.noise = iwe.u.qual.noise;
+			zd->iwstats.qual.updated = 2;
+		}
+
 		cev = iwe_stream_add_event(cev, end_buf, &iwe, IW_EV_QUAL_LEN);
 	}
 


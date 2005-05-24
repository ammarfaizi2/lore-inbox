Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVEXNLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVEXNLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVEXNLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:11:19 -0400
Received: from styx.suse.cz ([82.119.242.94]:62394 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262036AbVEXNKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:10:21 -0400
Date: Tue, 24 May 2005 15:10:18 +0200
From: Jiri Benc <jbenc@suse.cz>
To: NetDev <netdev@oss.sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com, pavel@suse.cz
Subject: [1/5] ieee80211: cleanup
Message-ID: <20050524151018.3304fbeb@griffin.suse.cz>
In-Reply-To: <20050524150711.01632672@griffin.suse.cz>
References: <20050524150711.01632672@griffin.suse.cz>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup of unused and duplicated constants and structures in the ieee80211
header.


Signed-off-by: Jiri Benc <jbenc@suse.cz>
Signed-off-by: Jirka Bohac <jbohac@suse.cz>

--- orig/include/net/ieee80211.h	2005-05-12 11:36:27.000000000 +0200
+++ new/include/net/ieee80211.h	2005-05-17 15:37:38.000000000 +0200
@@ -93,6 +93,8 @@
 	u16 length;
 } __attribute__ ((packed));
 
+#define IEEE80211_1ADDR_LEN 10
+#define IEEE80211_2ADDR_LEN 16
 #define IEEE80211_3ADDR_LEN 24
 #define IEEE80211_4ADDR_LEN 30
 #define IEEE80211_FCS_LEN    4
@@ -299,23 +301,6 @@
 #define WLAN_REASON_STA_REQ_ASSOC_WITHOUT_AUTH 9
 
 
-/* Information Element IDs */
-#define WLAN_EID_SSID 0
-#define WLAN_EID_SUPP_RATES 1
-#define WLAN_EID_FH_PARAMS 2
-#define WLAN_EID_DS_PARAMS 3
-#define WLAN_EID_CF_PARAMS 4
-#define WLAN_EID_TIM 5
-#define WLAN_EID_IBSS_PARAMS 6
-#define WLAN_EID_CHALLENGE 16
-#define WLAN_EID_RSN 48
-#define WLAN_EID_GENERIC 221
-
-#define IEEE80211_MGMT_HDR_LEN 24
-#define IEEE80211_DATA_HDR3_LEN 24
-#define IEEE80211_DATA_HDR4_LEN 30
-
-
 #define IEEE80211_STATMASK_SIGNAL (1<<0)
 #define IEEE80211_STATMASK_RSSI (1<<1)
 #define IEEE80211_STATMASK_NOISE (1<<2)
@@ -489,15 +474,6 @@
 
 */
 
-struct ieee80211_header_data {
-	u16 frame_ctl;
-	u16 duration_id;
-	u8 addr1[6];
-	u8 addr2[6];
-	u8 addr3[6];
-	u16 seq_ctrl;
-};
-
 #define BEACON_PROBE_SSID_ID_POSITION 12
 
 /* Management Frame Information Element Types */
@@ -542,7 +518,7 @@
 */
 
 struct ieee80211_authentication {
-	struct ieee80211_header_data header;
+	struct ieee80211_hdr_3addr header;
 	u16 algorithm;
 	u16 transaction;
 	u16 status;
@@ -551,7 +527,7 @@
 
 
 struct ieee80211_probe_response {
-	struct ieee80211_header_data header;
+	struct ieee80211_hdr_3addr header;
 	u32 time_stamp[2];
 	u16 beacon_interval;
 	u16 capability;
@@ -793,21 +769,21 @@
 
 extern inline int ieee80211_get_hdrlen(u16 fc)
 {
-	int hdrlen = 24;
+	int hdrlen = IEEE80211_3ADDR_LEN;
 
 	switch (WLAN_FC_GET_TYPE(fc)) {
 	case IEEE80211_FTYPE_DATA:
 		if ((fc & IEEE80211_FCTL_FROMDS) && (fc & IEEE80211_FCTL_TODS))
-			hdrlen = 30; /* Addr4 */
+			hdrlen = IEEE80211_4ADDR_LEN;
 		break;
 	case IEEE80211_FTYPE_CTL:
 		switch (WLAN_FC_GET_STYPE(fc)) {
 		case IEEE80211_STYPE_CTS:
 		case IEEE80211_STYPE_ACK:
-			hdrlen = 10;
+			hdrlen = IEEE80211_1ADDR_LEN;
 			break;
 		default:
-			hdrlen = 16;
+			hdrlen = IEEE80211_2ADDR_LEN;
 			break;
 		}
 		break;
--- orig/net/ieee80211/ieee80211_rx.c	2005-05-12 11:36:29.000000000 +0200
+++ new/net/ieee80211/ieee80211_rx.c	2005-05-17 15:37:38.000000000 +0200
@@ -475,7 +475,7 @@
 #endif
 
 	/* Data frame - extract src/dst addresses */
-	if (skb->len < IEEE80211_DATA_HDR3_LEN)
+	if (skb->len < IEEE80211_3ADDR_LEN)
 		goto rx_dropped;
 
 	switch (fc & (IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS)) {
@@ -488,7 +488,7 @@
 		memcpy(src, hdr->addr2, ETH_ALEN);
 		break;
 	case IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS:
-		if (skb->len < IEEE80211_DATA_HDR4_LEN)
+		if (skb->len < IEEE80211_4ADDR_LEN)
 			goto rx_dropped;
 		memcpy(dst, hdr->addr3, ETH_ALEN);
 		memcpy(src, hdr->addr4, ETH_ALEN);



--
Jiri Benc
SUSE Labs

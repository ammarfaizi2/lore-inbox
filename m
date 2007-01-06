Return-Path: <linux-kernel-owner+w=401wt.eu-S1751112AbXAFC2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbXAFC2k (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbXAFC2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:28:34 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47946 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbXAFC1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:27:53 -0500
Message-Id: <20070106023202.448044000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:10 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Marcel Holtmann <marcel@holtmann.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: [patch 17/50] Bluetooth: Add packet size checks for CAPI messages (CVE-2006-6106)
Content-Disposition: inline; filename=bluetooth-add-packet-size-checks-for-capi-messages.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Marcel Holtmann <marcel@holtmann.org>

With malformed packets it might be possible to overwrite internal
CMTP and CAPI data structures. This patch adds additional length
checks to prevent these kinds of remote attacks.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 net/bluetooth/cmtp/capi.c |   39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

--- linux-2.6.19.1.orig/net/bluetooth/cmtp/capi.c
+++ linux-2.6.19.1/net/bluetooth/cmtp/capi.c
@@ -196,6 +196,9 @@ static void cmtp_recv_interopmsg(struct 
 
 	switch (CAPIMSG_SUBCOMMAND(skb->data)) {
 	case CAPI_CONF:
+		if (skb->len < CAPI_MSG_BASELEN + 10)
+			break;
+
 		func = CAPIMSG_U16(skb->data, CAPI_MSG_BASELEN + 5);
 		info = CAPIMSG_U16(skb->data, CAPI_MSG_BASELEN + 8);
 
@@ -226,6 +229,9 @@ static void cmtp_recv_interopmsg(struct 
 			break;
 
 		case CAPI_FUNCTION_GET_PROFILE:
+			if (skb->len < CAPI_MSG_BASELEN + 11 + sizeof(capi_profile))
+				break;
+
 			controller = CAPIMSG_U16(skb->data, CAPI_MSG_BASELEN + 11);
 			msgnum = CAPIMSG_MSGID(skb->data);
 
@@ -246,17 +252,26 @@ static void cmtp_recv_interopmsg(struct 
 			break;
 
 		case CAPI_FUNCTION_GET_MANUFACTURER:
+			if (skb->len < CAPI_MSG_BASELEN + 15)
+				break;
+
 			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 10);
 
 			if (!info && ctrl) {
+				int len = min_t(uint, CAPI_MANUFACTURER_LEN,
+						skb->data[CAPI_MSG_BASELEN + 14]);
+
+				memset(ctrl->manu, 0, CAPI_MANUFACTURER_LEN);
 				strncpy(ctrl->manu,
-					skb->data + CAPI_MSG_BASELEN + 15,
-					skb->data[CAPI_MSG_BASELEN + 14]);
+					skb->data + CAPI_MSG_BASELEN + 15, len);
 			}
 
 			break;
 
 		case CAPI_FUNCTION_GET_VERSION:
+			if (skb->len < CAPI_MSG_BASELEN + 32)
+				break;
+
 			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 12);
 
 			if (!info && ctrl) {
@@ -269,13 +284,18 @@ static void cmtp_recv_interopmsg(struct 
 			break;
 
 		case CAPI_FUNCTION_GET_SERIAL_NUMBER:
+			if (skb->len < CAPI_MSG_BASELEN + 17)
+				break;
+
 			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 12);
 
 			if (!info && ctrl) {
+				int len = min_t(uint, CAPI_SERIAL_LEN,
+						skb->data[CAPI_MSG_BASELEN + 16]);
+
 				memset(ctrl->serial, 0, CAPI_SERIAL_LEN);
 				strncpy(ctrl->serial,
-					skb->data + CAPI_MSG_BASELEN + 17,
-					skb->data[CAPI_MSG_BASELEN + 16]);
+					skb->data + CAPI_MSG_BASELEN + 17, len);
 			}
 
 			break;
@@ -284,14 +304,18 @@ static void cmtp_recv_interopmsg(struct 
 		break;
 
 	case CAPI_IND:
+		if (skb->len < CAPI_MSG_BASELEN + 6)
+			break;
+
 		func = CAPIMSG_U16(skb->data, CAPI_MSG_BASELEN + 3);
 
 		if (func == CAPI_FUNCTION_LOOPBACK) {
+			int len = min_t(uint, skb->len - CAPI_MSG_BASELEN - 6,
+						skb->data[CAPI_MSG_BASELEN + 5]);
 			appl = CAPIMSG_APPID(skb->data);
 			msgnum = CAPIMSG_MSGID(skb->data);
 			cmtp_send_interopmsg(session, CAPI_RESP, appl, msgnum, func,
-						skb->data + CAPI_MSG_BASELEN + 6,
-						skb->data[CAPI_MSG_BASELEN + 5]);
+						skb->data + CAPI_MSG_BASELEN + 6, len);
 		}
 
 		break;
@@ -309,6 +333,9 @@ void cmtp_recv_capimsg(struct cmtp_sessi
 
 	BT_DBG("session %p skb %p len %d", session, skb, skb->len);
 
+	if (skb->len < CAPI_MSG_BASELEN)
+		return;
+
 	if (CAPIMSG_COMMAND(skb->data) == CAPI_INTEROPERABILITY) {
 		cmtp_recv_interopmsg(session, skb);
 		return;

--

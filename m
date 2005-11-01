Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbVKAIM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbVKAIM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbVKAIM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:12:57 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:937 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932585AbVKAIM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:12:56 -0500
Message-ID: <4367235B.40608@m1k.net>
Date: Tue, 01 Nov 2005 03:12:11 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 01/37] dvb: dst: Correcty Identify Tuner and Daughterboards
Content-Type: multipart/mixed;
 boundary="------------010807080108010402040002"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010807080108010402040002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------010807080108010402040002
Content-Type: text/x-patch;
 name="2353.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2353.patch"

From: Manu Abraham <manu@linuxtv.org>

- Identify Tuner, Daughterboards correctly
- Added partial support for
  VP-10320A (DVB-S), VP-20210 (DVB-C), VP-3040 (DVB-T)

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/bt8xx/dst.c        |   58 +++++++++++++++++++++++++++++++++--
 drivers/media/dvb/bt8xx/dst_common.h |    2 +
 2 files changed, 58 insertions(+), 2 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dst.c
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dst.c
@@ -690,8 +690,8 @@
 		.device_id = "DTT-CI",
 		.offset = 1,
 		.dst_type = DST_TYPE_IS_TERR,
-		.type_flags = DST_TYPE_HAS_TS204 | DST_TYPE_HAS_FW_2,
-		.dst_feature = 0
+		.type_flags = DST_TYPE_HAS_TS204 | DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_2 | DST_TYPE_HAS_MULTI_FE,
+		.dst_feature = DST_TYPE_HAS_CA
 	},
 
 	{
@@ -796,6 +796,56 @@
 	return 0;
 }
 
+static int dst_get_tuner_info(struct dst_state *state)
+{
+	u8 get_tuner_1[] = { 0x00, 0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	u8 get_tuner_2[] = { 0x00, 0x0b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+
+	get_tuner_1[7] = dst_check_sum(get_tuner_1, 7);
+	get_tuner_2[7] = dst_check_sum(get_tuner_2, 7);
+	if (state->type_flags & DST_TYPE_HAS_MULTI_FE) {
+		if (dst_command(state, get_tuner_2, 8) < 0) {
+			dprintk(verbose, DST_INFO, 1, "Unsupported Command");
+			return -1;
+		}
+	} else {
+		if (dst_command(state, get_tuner_1, 8) < 0) {
+			dprintk(verbose, DST_INFO, 1, "Unsupported Command");
+			return -1;
+		}
+	}
+	memset(&state->board_info, '\0', 8);
+	memcpy(&state->board_info, &state->rxbuffer, 8);
+	if (state->type_flags & DST_TYPE_HAS_MULTI_FE) {
+		if (state->board_info[1] == 0x0b) {
+			if (state->type_flags & DST_TYPE_HAS_TS204)
+				state->type_flags &= ~DST_TYPE_HAS_TS204;
+			state->type_flags |= DST_TYPE_HAS_NEWTUNE;
+			dprintk(verbose, DST_INFO, 1, "DST type has TS=188");
+		} else {
+			if (state->type_flags & DST_TYPE_HAS_NEWTUNE)
+				state->type_flags &= ~DST_TYPE_HAS_NEWTUNE;
+			state->type_flags |= DST_TYPE_HAS_TS204;
+			dprintk(verbose, DST_INFO, 1, "DST type has TS=204");
+		}
+	} else {
+		if (state->board_info[0] == 0xbc) {
+			if (state->type_flags & DST_TYPE_HAS_TS204)
+				state->type_flags &= ~DST_TYPE_HAS_TS204;
+			state->type_flags |= DST_TYPE_HAS_NEWTUNE;
+			dprintk(verbose, DST_INFO, 1, "DST type has TS=188, Daughterboard=[%d]", state->board_info[1]);
+
+		} else if (state->board_info[0] == 0xcc) {
+			if (state->type_flags & DST_TYPE_HAS_NEWTUNE)
+				state->type_flags &= ~DST_TYPE_HAS_NEWTUNE;
+			state->type_flags |= DST_TYPE_HAS_TS204;
+			dprintk(verbose, DST_INFO, 1, "DST type has TS=204 Daughterboard=[%d]", state->board_info[1]);
+		}
+	}
+
+	return 0;
+}
+
 static int dst_get_device_id(struct dst_state *state)
 {
 	u8 reply;
@@ -886,6 +936,10 @@
 		dprintk(verbose, DST_INFO, 1, "MAC: Unsupported command");
 		return 0;
 	}
+	if ((state->type_flags & DST_TYPE_HAS_MULTI_FE) || (state->type_flags & DST_TYPE_HAS_FW_BUILD)) {
+		if (dst_get_tuner_info(state) < 0)
+			dprintk(verbose, DST_INFO, 1, "Tuner: Unsupported command");
+	}
 	if (state->type_flags & DST_TYPE_HAS_FW_BUILD) {
 		if (dst_fw_ver(state) < 0) {
 			dprintk(verbose, DST_INFO, 1, "FW: Unsupported command");
--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dst_common.h
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dst_common.h
@@ -49,6 +49,7 @@
 #define DST_TYPE_HAS_FW_BUILD	64
 #define DST_TYPE_HAS_OBS_REGS	128
 #define DST_TYPE_HAS_INC_COUNT	256
+#define DST_TYPE_HAS_MULTI_FE	512
 
 /*	Card capability list	*/
 
@@ -117,6 +118,7 @@
 	u8 fw_version[8];
 	u8 card_info[8];
 	u8 vendor[8];
+	u8 board_info[8];
 };
 
 struct dst_types {




--------------010807080108010402040002--

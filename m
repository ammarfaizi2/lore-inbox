Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVIDXkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVIDXkz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVIDXjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:39:47 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:51841 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932142AbVIDXa5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:57 -0400
Message-Id: <20050904232331.677289000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:39 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Manu Abraham <manu@linuxtv.org>
Content-Disposition: inline; filename=dvb-bt8xx-dst-identify-boards.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 40/54] dst: identify boards
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Abraham <manu@linuxtv.org>

Identify board properly: Add functions to retrieve
MAC Address, FW details, Card type and Vendor Information.

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/dst.c        |   89 +++++++++++++++++++++++++++++++++--
 drivers/media/dvb/bt8xx/dst_common.h |    4 +
 2 files changed, 90 insertions(+), 3 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/dst.c	2005-09-04 22:28:34.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/dst.c	2005-09-04 22:28:35.000000000 +0200
@@ -673,7 +673,7 @@ struct dst_types dst_tlist[] = {
 		.offset = 1,
 		.dst_type = DST_TYPE_IS_CABLE,
 		.type_flags = DST_TYPE_HAS_TS204 | DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_1
-							| DST_TYPE_HAS_FW_2 | DST_TYPE_HAS_FW_BUILD,
+							| DST_TYPE_HAS_FW_2,
 		.dst_feature = DST_TYPE_HAS_CA
 	},
 
@@ -681,7 +681,7 @@ struct dst_types dst_tlist[] = {
 		.device_id = "DCTNEW",
 		.offset = 1,
 		.dst_type = DST_TYPE_IS_CABLE,
-		.type_flags = DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_3,
+		.type_flags = DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_3 | DST_TYPE_HAS_FW_BUILD,
 		.dst_feature = 0
 	},
 
@@ -689,7 +689,7 @@ struct dst_types dst_tlist[] = {
 		.device_id = "DTT-CI",
 		.offset = 1,
 		.dst_type = DST_TYPE_IS_TERR,
-		.type_flags = DST_TYPE_HAS_TS204 | DST_TYPE_HAS_FW_2 | DST_TYPE_HAS_FW_BUILD,
+		.type_flags = DST_TYPE_HAS_TS204 | DST_TYPE_HAS_FW_2,
 		.dst_feature = 0
 	},
 
@@ -729,6 +729,71 @@ struct dst_types dst_tlist[] = {
 
 };
 
+static int dst_get_mac(struct dst_state *state)
+{
+	u8 get_mac[] = { 0x00, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	get_mac[7] = dst_check_sum(get_mac, 7);
+	if (dst_command(state, get_mac, 8) < 0) {
+		dprintk(verbose, DST_INFO, 1, "Unsupported Command");
+		return -1;
+	}
+	memset(&state->mac_address, '\0', 8);
+	memcpy(&state->mac_address, &state->rxbuffer, 6);
+	dprintk(verbose, DST_ERROR, 1, "MAC Address=[%02x:%02x:%02x:%02x:%02x:%02x]",
+		state->mac_address[0], state->mac_address[1], state->mac_address[2],
+		state->mac_address[4], state->mac_address[5], state->mac_address[6]);
+
+	return 0;
+}
+
+static int dst_fw_ver(struct dst_state *state)
+{
+	u8 get_ver[] = { 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	get_ver[7] = dst_check_sum(get_ver, 7);
+	if (dst_command(state, get_ver, 8) < 0) {
+		dprintk(verbose, DST_INFO, 1, "Unsupported Command");
+		return -1;
+	}
+	memset(&state->fw_version, '\0', 8);
+	memcpy(&state->fw_version, &state->rxbuffer, 8);
+	dprintk(verbose, DST_ERROR, 1, "Firmware Ver = %x.%x Build = %02x, on %x:%x, %x-%x-20%02x",
+		state->fw_version[0] >> 4, state->fw_version[0] & 0x0f,
+		state->fw_version[1],
+		state->fw_version[5], state->fw_version[6],
+		state->fw_version[4], state->fw_version[3], state->fw_version[2]);
+
+	return 0;
+}
+
+static int dst_card_type(struct dst_state *state)
+{
+	u8 get_type[] = { 0x00, 0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	get_type[7] = dst_check_sum(get_type, 7);
+	if (dst_command(state, get_type, 8) < 0) {
+		dprintk(verbose, DST_INFO, 1, "Unsupported Command");
+		return -1;
+	}
+	memset(&state->card_info, '\0', 8);
+	memcpy(&state->card_info, &state->rxbuffer, 8);
+	dprintk(verbose, DST_ERROR, 1, "Device Model=[%s]", &state->card_info[0]);
+
+	return 0;
+}
+
+static int dst_get_vendor(struct dst_state *state)
+{
+	u8 get_vendor[] = { 0x00, 0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	get_vendor[7] = dst_check_sum(get_vendor, 7);
+	if (dst_command(state, get_vendor, 8) < 0) {
+		dprintk(verbose, DST_INFO, 1, "Unsupported Command");
+		return -1;
+	}
+	memset(&state->vendor, '\0', 8);
+	memcpy(&state->vendor, &state->rxbuffer, 8);
+	dprintk(verbose, DST_ERROR, 1, "Vendor=[%s]", &state->vendor[0]);
+
+	return 0;
+}
 
 static int dst_get_device_id(struct dst_state *state)
 {
@@ -816,6 +881,24 @@ static int dst_probe(struct dst_state *s
 		dprintk(verbose, DST_ERROR, 1, "unknown device.");
 		return -1;
 	}
+	if (dst_get_mac(state) < 0) {
+		dprintk(verbose, DST_INFO, 1, "MAC: Unsupported command");
+		return 0;
+	}
+	if (state->type_flags & DST_TYPE_HAS_FW_BUILD) {
+		if (dst_fw_ver(state) < 0) {
+			dprintk(verbose, DST_INFO, 1, "FW: Unsupported command");
+			return 0;
+		}
+		if (dst_card_type(state) < 0) {
+			dprintk(verbose, DST_INFO, 1, "Card: Unsupported command");
+			return 0;
+		}
+		if (dst_get_vendor(state) < 0) {
+			dprintk(verbose, DST_INFO, 1, "Vendor: Unsupported command");
+			return 0;
+		}
+	}
 
 	return 0;
 }
--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/dst_common.h	2005-09-04 22:28:34.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/dst_common.h	2005-09-04 22:28:35.000000000 +0200
@@ -113,6 +113,10 @@ struct dst_state {
 	fe_sec_mini_cmd_t minicmd;
 	fe_modulation_t modulation;
 	u8 messages[256];
+	u8 mac_address[8];
+	u8 fw_version[8];
+	u8 card_info[8];
+	u8 vendor[8];
 };
 
 struct dst_types {

--


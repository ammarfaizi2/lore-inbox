Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262944AbVEHUAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbVEHUAe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbVEHT7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:59:36 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:3735 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262938AbVEHTKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:18 -0400
Message-Id: <20050508184349.467371000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:43:01 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-bt8xx-dst-cleanup.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 32/37] DST: misc. fixes
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

removed unused module parameter session
removed unnecesary delay for FTA cards
(Manu Abraham)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/bt8xx/dst.c        |   14 ++++++--------
 drivers/media/dvb/bt8xx/dst_ca.c     |   19 ++++++-------------
 drivers/media/dvb/bt8xx/dst_common.h |    8 ++++----
 3 files changed, 16 insertions(+), 25 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dst.c	2005-05-08 18:13:49.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst.c	2005-05-08 18:13:54.000000000 +0200
@@ -44,13 +44,7 @@ MODULE_PARM_DESC(debug, "debug messages,
 
 static unsigned int dst_addons;
 module_param(dst_addons, int, 0644);
-MODULE_PARM_DESC(dst_addons, "CA daughterboard, default is 0 (no)");
-
-static unsigned int new_fw;
-module_param(new_fw, int, 0644);
-MODULE_PARM_DESC(new_fw, "Support for the new interface firmware, default 0");
-
-
+MODULE_PARM_DESC(dst_addons, "CA daughterboard, default is 0 (No addons)");
 
 #define dprintk	if (debug) printk
 
@@ -787,7 +781,11 @@ static int dst_probe(struct dst_state *s
 		dprintk("%s: RDC 8820 RESET Failed.\n", __FUNCTION__);
 		return -1;
 	}
-	msleep(4000);
+	if (dst_addons & DST_TYPE_HAS_CA)
+		msleep(4000);
+	else
+		msleep(100);
+
 	if ((dst_comm_init(state)) < 0) {
 		dprintk("%s: DST Initialization Failed.\n", __FUNCTION__);
 		return -1;
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_ca.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dst_ca.c	2005-05-08 18:13:30.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_ca.c	2005-05-08 18:13:54.000000000 +0200
@@ -40,23 +40,16 @@ static unsigned int debug = 1;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(dst_ca_debug, "debug messages, default is 0 (yes)");
 
-static unsigned int session;
-module_param(session, int, 0644);
-MODULE_PARM_DESC(session, "Support for hardware that has multiple sessions, default 0");
-
-static unsigned int new_ca;
-module_param(new_ca, int, 0644);
-MODULE_PARM_DESC(new_ca, "Support for the new CA interface firmware, default 0");
-
 #define dprintk if (debug) printk
 
-
+/*	Need some more work	*/
 static int ca_set_slot_descr(void)
 {
 	/*	We could make this more graceful ?	*/
 	return -EOPNOTSUPP;
 }
 
+/*	Need some more work	*/
 static int ca_set_pid(void)
 {
 	/*	We could make this more graceful ?	*/
@@ -213,7 +206,7 @@ static int ca_get_slot_caps(struct dst_s
 	return 0;
 }
 
-
+/*	Need some more work	*/
 static int ca_get_slot_descr(struct dst_state *state, struct ca_msg *p_ca_message, void *arg)
 {
 	return -EOPNOTSUPP;
@@ -302,9 +295,9 @@ static int ca_get_message(struct dst_sta
 	return 0;
 }
 
-static int handle_en50221_tag(struct ca_msg *p_ca_message, struct ca_msg *hw_buffer)
+static int handle_en50221_tag(struct dst_state *state, struct ca_msg *p_ca_message, struct ca_msg *hw_buffer)
 {
-	if (session) {
+	if (state->dst_hw_cap & DST_TYPE_HAS_SESSION) {
 		hw_buffer->msg[2] = p_ca_message->msg[1];		/*		MSB			*/
 		hw_buffer->msg[3] = p_ca_message->msg[2];		/*		LSB			*/
 	}
@@ -351,7 +344,7 @@ static int ca_set_pmt(struct dst_state *
 	if (verbose > 3)
 		dprintk("%s, p_ca_message length %d (0x%x)\n", __FUNCTION__,p_ca_message->length,p_ca_message->length );
 
-	handle_en50221_tag(p_ca_message, hw_buffer);			/*	EN50221 tag		*/
+	handle_en50221_tag(state, p_ca_message, hw_buffer);			/*	EN50221 tag		*/
 
 	/*	Handle the length field (variable)	*/
 	if (!(p_ca_message->msg[3] & 0x80)) {				/*	Length = 1		*/
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_common.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dst_common.h	2005-05-08 18:13:44.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_common.h	2005-05-08 18:13:54.000000000 +0200
@@ -48,7 +48,6 @@
 #define DST_TYPE_HAS_FW_3	32
 #define DST_TYPE_HAS_FW_BUILD	64
 
-
 /*	Card capability list	*/
 
 #define DST_TYPE_HAS_MAC	1
@@ -58,6 +57,7 @@
 #define DST_TYPE_HAS_MOTO	16
 #define DST_TYPE_HAS_CA		32
 #define	DST_TYPE_HAS_ANALOG	64	/*	Analog inputs	*/
+#define DST_TYPE_HAS_SESSION	128
 
 
 #define RDC_8820_PIO_0_DISABLE	0
@@ -107,7 +107,7 @@ struct dst_state {
 	unsigned long cur_jiff;
 	u8 k22;
 	fe_bandwidth_t bandwidth;
-	u8 dst_hw_cap;
+	u32 dst_hw_cap;
 	u8 dst_fw_version;
 	fe_sec_mini_cmd_t minicmd;
 	u8 messages[256];
@@ -117,8 +117,8 @@ struct dst_types {
 	char *device_id;
 	int offset;
 	u8 dst_type;
-	u64 type_flags;
-	u64 dst_feature;
+	u32 type_flags;
+	u32 dst_feature;
 };
 
 

--


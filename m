Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbUKIH60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUKIH60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 02:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUKIH6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 02:58:25 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:24227 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261433AbUKIHzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 02:55:51 -0500
Date: Tue, 9 Nov 2004 18:55:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [4/6] PPC64 iSeries more MF cleanup
Message-Id: <20041109185547.6eaf99ee.sfr@canb.auug.org.au>
In-Reply-To: <20041109185131.29e6eabd.sfr@canb.auug.org.au>
References: <20041109184223.16ea3414.sfr@canb.auug.org.au>
	<20041109184551.03b8a32c.sfr@canb.auug.org.au>
	<20041109184813.1a6e02cf.sfr@canb.auug.org.au>
	<20041109185131.29e6eabd.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__9_Nov_2004_18_55_47_+1100_ecklAHHfp_WYNrjk"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__9_Nov_2004_18_55_47_+1100_ecklAHHfp_WYNrjk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This patch starts the improvement of the style of the MF code:
	- remove a union that is used where casts suffice
	- add a helper function (signal_ce_msg_simple) and use it
	- replace some painful code that converts a byte array to
	  a couple of u32's and then shifts and masks the bytes back out.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-mf.0.7/arch/ppc64/kernel/mf.c linus-bk-mf.0.8/arch/ppc64/kernel/mf.c
--- linus-bk-mf.0.7/arch/ppc64/kernel/mf.c	2004-11-09 17:27:46.000000000 +1100
+++ linus-bk-mf.0.8/arch/ppc64/kernel/mf.c	2004-11-09 17:57:33.000000000 +1100
@@ -48,13 +48,8 @@
  * This is the structure layout for the Machine Facilites LPAR event
  * flows.
  */
-union safe_cast {
-	u64 ptr_as_u64;
-	void *ptr;
-};
-
 struct VspCmdData {
-	union safe_cast token;
+	u64 token;
 	u16 cmd;
 	HvLpIndex lp_index;
 	u8 result_code;
@@ -215,12 +210,8 @@
 
 			if (ev1 == ev)
 				rc = -EIO;
-			else if (ev1->hdlr != NULL) {
-				union safe_cast mySafeCast;
-
-				mySafeCast.ptr_as_u64 = ev1->event.hp_lp_event.xCorrelationToken;
-				(*ev1->hdlr)(mySafeCast.ptr, -EIO);
-			}
+			else if (ev1->hdlr != NULL)
+				(*ev1->hdlr)((void *)ev1->event.hp_lp_event.xCorrelationToken, -EIO);
 
 			spin_lock_irqsave(&pending_event_spinlock, flags);
 			free_pending_event(ev1);
@@ -287,7 +278,7 @@
 	ev->event.hp_lp_event.xSubtype = 6;
 	ev->event.hp_lp_event.x.xSubtypeData =
 		subtype_data('M', 'F',  'V',  'I');
-	ev->event.data.vsp_cmd.token.ptr = &response;
+	ev->event.data.vsp_cmd.token = (u64)&response;
 	ev->event.data.vsp_cmd.cmd = vspCmd->cmd;
 	ev->event.data.vsp_cmd.lp_index = HvLpConfig_getLpIndex();
 	ev->event.data.vsp_cmd.result_code = 0xFF;
@@ -322,6 +313,18 @@
 }
 
 /*
+ * Send a 12-byte CE message (with no data) to the primary partition VSP object
+ */
+static int signal_ce_msg_simple(u8 ce_op, struct CeMsgCompleteData *completion)
+{
+	u8 ce_msg[12];
+
+	memset(ce_msg, 0, sizeof(ce_msg));
+	ce_msg[3] = ce_op;
+	return signal_ce_msg(ce_msg, completion);
+}
+
+/*
  * Send a 12-byte CE message and DMA data to the primary partition VSP object
  */
 static int dma_and_signal_ce_msg(char *ce_msg,
@@ -385,7 +388,7 @@
 			if ((event->data.ce_msg.ce_msg[5] & 0x20) != 0) {
 				printk(KERN_INFO "mf.c: Commencing partition shutdown\n");
 				if (shutdown() == 0)
-					signal_ce_msg("\x00\x00\x00\xDB\x00\x00\x00\x00\x00\x00\x00\x00", NULL);
+					signal_ce_msg_simple(0xDB, NULL);
 			}
 			break;
 		case 0xC0:	/* get time */
@@ -464,16 +467,13 @@
 		case 4:	/* allocate */
 		case 5:	/* deallocate */
 			if (pending_event_head->hdlr != NULL) {
-				union safe_cast mySafeCast;
-
-				mySafeCast.ptr_as_u64 = event->hp_lp_event.xCorrelationToken;
-				(*pending_event_head->hdlr)(mySafeCast.ptr, event->data.alloc.count);
+				(*pending_event_head->hdlr)((void *)event->hp_lp_event.xCorrelationToken, event->data.alloc.count);
 			}
 			freeIt = 1;
 			break;
 		case 6:
 			{
-				struct VspRspData *rsp = (struct VspRspData *)event->data.vsp_cmd.token.ptr;
+				struct VspRspData *rsp = (struct VspRspData *)event->data.vsp_cmd.token;
 
 				if (rsp != NULL) {
 					if (rsp->response != NULL)
@@ -543,11 +543,8 @@
 	if (ev == NULL) {
 		rc = -ENOMEM;
 	} else {
-		union safe_cast mine;
-
-		mine.ptr = userToken;
 		ev->event.hp_lp_event.xSubtype = 4;
-		ev->event.hp_lp_event.xCorrelationToken = mine.ptr_as_u64;
+		ev->event.hp_lp_event.xCorrelationToken = (u64)userToken;
 		ev->event.hp_lp_event.x.xSubtypeData =
 			subtype_data('M', 'F', 'M', 'A');
 		ev->event.data.alloc.target_lp = targetLp;
@@ -575,11 +572,8 @@
 	if (ev == NULL)
 		rc = -ENOMEM;
 	else {
-		union safe_cast mine;
-
-		mine.ptr = userToken;
 		ev->event.hp_lp_event.xSubtype = 5;
-		ev->event.hp_lp_event.xCorrelationToken = mine.ptr_as_u64;
+		ev->event.hp_lp_event.xCorrelationToken = (u64)userToken;
 		ev->event.hp_lp_event.x.xSubtypeData =
 			subtype_data('M', 'F', 'M', 'D');
 		ev->event.data.alloc.target_lp = targetLp;
@@ -600,8 +594,9 @@
 void mf_power_off(void)
 {
 	printk(KERN_INFO "mf.c: Down it goes...\n");
-	signal_ce_msg("\x00\x00\x00\x4D\x00\x00\x00\x00\x00\x00\x00\x00", NULL);
-	for (;;);
+	signal_ce_msg_simple(0x4d, NULL);
+	for (;;)
+		;
 }
 
 /*
@@ -611,8 +606,9 @@
 void mf_reboot(void)
 {
 	printk(KERN_INFO "mf.c: Preparing to bounce...\n");
-	signal_ce_msg("\x00\x00\x00\x4E\x00\x00\x00\x00\x00\x00\x00\x00", NULL);
-	for (;;);
+	signal_ce_msg_simple(0x4e, NULL);
+	for (;;)
+		;
 }
 
 /*
@@ -659,7 +655,7 @@
  */
 void mf_clear_src(void)
 {
-	signal_ce_msg("\x00\x00\x00\x4B\x00\x00\x00\x00\x00\x00\x00\x00", NULL);
+	signal_ce_msg_simple(0x4b, NULL);
 }
 
 /*
@@ -678,7 +674,7 @@
 	HvLpEvent_registerHandler(HvLpEvent_Type_MachineFac, &hvHandler);
 
 	/* virtual continue ack */
-	signal_ce_msg("\x00\x00\x00\x57\x00\x00\x00\x00\x00\x00\x00\x00", NULL);
+	signal_ce_msg_simple(0x57, NULL);
 
 	/* initialization complete */
 	printk(KERN_NOTICE "mf.c: iSeries Linux LPAR Machine Facilities initialized\n");
@@ -935,8 +931,7 @@
 	init_completion(&rtcData.com);
 	ceComplete.handler = &getRtcTimeComplete;
 	ceComplete.token = (void *)&rtcData;
-	rc = signal_ce_msg("\x00\x00\x00\x40\x00\x00\x00\x00\x00\x00\x00\x00",
-			&ceComplete);
+	rc = signal_ce_msg_simple(0x40, &ce_complete);
 	if (rc == 0) {
 		wait_for_completion(&rtcData.com);
 
@@ -953,14 +948,13 @@
 				mf_set_rtc(tm);
 			}
 			{
-				u32 dataWord1 = *((u32 *)(rtcData.xCeMsg.ce_msg+4));
-				u32 dataWord2 = *((u32 *)(rtcData.xCeMsg.ce_msg+8));
-				u8 year = (dataWord1 >> 16) & 0x000000FF;
-				u8 sec = (dataWord1 >> 8) & 0x000000FF;
-				u8 min = dataWord1 & 0x000000FF;
-				u8 hour = (dataWord2 >> 24) & 0x000000FF;
-				u8 day = (dataWord2 >> 8) & 0x000000FF;
-				u8 mon = dataWord2 & 0x000000FF;
+				u8 *ce_msg = rtcData.xCeMsg.ce_msg;
+				u8 year = ce_msg[5];
+				u8 sec = ce_msg[6];
+				u8 min = ce_msg[7];
+				u8 hour = ce_msg[8];
+				u8 day = ce_msg[10];
+				u8 mon = ce_msg[11];
 
 				BCD_TO_BIN(sec);
 				BCD_TO_BIN(min);
@@ -997,7 +991,7 @@
 	return rc;
 }
 
-int mf_set_rtc(struct rtc_time * tm)
+int mf_set_rtc(struct rtc_time *tm)
 {
 	char ceTime[12] = "\x00\x00\x00\x41\x00\x00\x00\x00\x00\x00\x00\x00";
 	u8 day, mon, hour, min, sec, y1, y2;

--Signature=_Tue__9_Nov_2004_18_55_47_+1100_ecklAHHfp_WYNrjk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBkHgE4CJfqux9a+8RAqLGAJ4kJDzYrRp+nZP+z1o8gZ9q+D2j5QCfQEAZ
1pVt0t0GLEmL4wrz1Z7hMUc=
=vv2a
-----END PGP SIGNATURE-----

--Signature=_Tue__9_Nov_2004_18_55_47_+1100_ecklAHHfp_WYNrjk--

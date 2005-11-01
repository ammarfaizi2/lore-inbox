Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbVKAIQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbVKAIQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbVKAIQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:16:16 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:15432 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964993AbVKAIPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:15:47 -0500
Message-ID: <4367240C.8030204@m1k.net>
Date: Tue, 01 Nov 2005 03:15:08 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 24/37] dvb: dst: protect the read/write commands with a mutex
Content-Type: multipart/mixed;
 boundary="------------090008070504040907000609"
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
--------------090008070504040907000609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------090008070504040907000609
Content-Type: text/x-patch;
 name="2395.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2395.patch"

From: Manu Abraham <manu@linuxtv.org>

 -We need to protect the read/write commands with a mutex.

Bug reported by Henrik Sjoberg <henke@epact.se>

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/bt8xx/dst.c        |   34 +++++++++++++++++++++-------------
 drivers/media/dvb/bt8xx/dst_ca.c     |   17 +++++++++++------
 drivers/media/dvb/bt8xx/dst_common.h |    3 +++
 3 files changed, 35 insertions(+), 19 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dst.c
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dst.c
@@ -910,6 +910,7 @@
 
 static int dst_probe(struct dst_state *state)
 {
+	sema_init(&state->dst_mutex, 1);
 	if ((rdc_8820_reset(state)) < 0) {
 		dprintk(verbose, DST_ERROR, 1, "RDC 8820 RESET Failed.");
 		return -1;
@@ -960,21 +961,23 @@
 int dst_command(struct dst_state *state, u8 *data, u8 len)
 {
 	u8 reply;
+
+	down(&state->dst_mutex);
 	if ((dst_comm_init(state)) < 0) {
 		dprintk(verbose, DST_NOTICE, 1, "DST Communication Initialization Failed.");
-		return -1;
+		goto error;
 	}
 	if (write_dst(state, data, len)) {
 		dprintk(verbose, DST_INFO, 1, "Tring to recover.. ");
 		if ((dst_error_recovery(state)) < 0) {
 			dprintk(verbose, DST_ERROR, 1, "Recovery Failed.");
-			return -1;
+			goto error;
 		}
-		return -1;
+		goto error;
 	}
 	if ((dst_pio_disable(state)) < 0) {
 		dprintk(verbose, DST_ERROR, 1, "PIO Disable Failed.");
-		return -1;
+		goto error;
 	}
 	if (state->type_flags & DST_TYPE_HAS_FW_1)
 		udelay(3000);
@@ -982,36 +985,41 @@
 		dprintk(verbose, DST_DEBUG, 1, "Trying to recover.. ");
 		if ((dst_error_recovery(state)) < 0) {
 			dprintk(verbose, DST_INFO, 1, "Recovery Failed.");
-			return -1;
+			goto error;
 		}
-		return -1;
+		goto error;
 	}
 	if (reply != ACK) {
 		dprintk(verbose, DST_INFO, 1, "write not acknowledged 0x%02x ", reply);
-		return -1;
+		goto error;
 	}
 	if (len >= 2 && data[0] == 0 && (data[1] == 1 || data[1] == 3))
-		return 0;
+		goto error;
 	if (state->type_flags & DST_TYPE_HAS_FW_1)
 		udelay(3000);
 	else
 		udelay(2000);
 	if (!dst_wait_dst_ready(state, NO_DELAY))
-		return -1;
+		goto error;
 	if (read_dst(state, state->rxbuffer, FIXED_COMM)) {
 		dprintk(verbose, DST_DEBUG, 1, "Trying to recover.. ");
 		if ((dst_error_recovery(state)) < 0) {
 			dprintk(verbose, DST_INFO, 1, "Recovery failed.");
-			return -1;
+			goto error;
 		}
-		return -1;
+		goto error;
 	}
 	if (state->rxbuffer[7] != dst_check_sum(state->rxbuffer, 7)) {
 		dprintk(verbose, DST_INFO, 1, "checksum failure");
-		return -1;
+		goto error;
 	}
-
+	up(&state->dst_mutex);
 	return 0;
+
+error:
+	up(&state->dst_mutex);
+	return -EIO;
+
 }
 EXPORT_SYMBOL(dst_command);
 
--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dst_ca.c
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dst_ca.c
@@ -81,36 +81,41 @@
 {
 	u8 reply;
 
+	down(&state->dst_mutex);
 	dst_comm_init(state);
 	msleep(65);
 
 	if (write_dst(state, data, len)) {
 		dprintk(verbose, DST_CA_INFO, 1, " Write not successful, trying to recover");
 		dst_error_recovery(state);
-		return -1;
+		goto error;
 	}
 	if ((dst_pio_disable(state)) < 0) {
 		dprintk(verbose, DST_CA_ERROR, 1, " DST PIO disable failed.");
-		return -1;
+		goto error;
 	}
 	if (read_dst(state, &reply, GET_ACK) < 0) {
 		dprintk(verbose, DST_CA_INFO, 1, " Read not successful, trying to recover");
 		dst_error_recovery(state);
-		return -1;
+		goto error;
 	}
 	if (read) {
 		if (! dst_wait_dst_ready(state, LONG_DELAY)) {
 			dprintk(verbose, DST_CA_NOTICE, 1, " 8820 not ready");
-			return -1;
+			goto error;
 		}
 		if (read_dst(state, ca_string, 128) < 0) {	/*	Try to make this dynamic	*/
 			dprintk(verbose, DST_CA_INFO, 1, " Read not successful, trying to recover");
 			dst_error_recovery(state);
-			return -1;
+			goto error;
 		}
 	}
-
+	up(&state->dst_mutex);
 	return 0;
+
+error:
+	up(&state->dst_mutex);
+	return -EIO;
 }
 
 
--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dst_common.h
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dst_common.h
@@ -22,6 +22,7 @@
 #ifndef DST_COMMON_H
 #define DST_COMMON_H
 
+#include <linux/smp_lock.h>
 #include <linux/dvb/frontend.h>
 #include <linux/device.h>
 #include "bt878.h"
@@ -119,6 +120,8 @@
 	u8 card_info[8];
 	u8 vendor[8];
 	u8 board_info[8];
+
+	struct semaphore dst_mutex;
 };
 
 struct dst_types {


--------------090008070504040907000609--

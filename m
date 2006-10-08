Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWJHSqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWJHSqO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWJHSqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:46:13 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:41134 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751329AbWJHSqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:46:12 -0400
Message-ID: <4529476D.3030009@linuxtv.org>
Date: Sun, 08 Oct 2006 14:46:05 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: stable@kernel.org
CC: linux-kernel@vger.kernel.org,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Hans Verkuil <hverkuil@xs4all.nl>
Subject: [2.6.17.y PATCH 1/2] Fix msp343xG handling regression
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 04b0693f33d4ee6a6a8eed116c6d5d1f3eb77d63 Mon Sep 17 00:00:00 2001
From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Mon, 2 Oct 2006 23:03:59 -0400
Subject: [PATCH] Fix msp343xG handling regression

The msp3430G and msp3435G models cannot do Automatic Standard Detection,
so these should be forced to BTSC. These chips are early production
versions for the msp34xxG series and are quite rare.

Due to broken handling of the 'standard' option in 2.6.17, there is
no workaround possible.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
---
 drivers/media/video/msp3400-driver.c   |    2 ++
 drivers/media/video/msp3400-driver.h   |    1 +
 drivers/media/video/msp3400-kthreads.c |    7 ++++---
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/media/video/msp3400-driver.c b/drivers/media/video/msp3400-driver.c
index b806999..dd23219 100644
--- a/drivers/media/video/msp3400-driver.c
+++ b/drivers/media/video/msp3400-driver.c
@@ -942,6 +942,8 @@ static int msp_attach(struct i2c_adapter
 	state->has_virtual_dolby_surround = msp_revision == 'G' && msp_prod_lo == 1;
 	/* Has Virtual Dolby Surround & Dolby Pro Logic: only in msp34x2 */
 	state->has_dolby_pro_logic = msp_revision == 'G' && msp_prod_lo == 2;
+	/* The msp343xG supports BTSC only and cannot do Automatic Standard Detection. */
+	state->force_btsc = msp_family == 3 && msp_revision == 'G' && msp_prod_hi == 3;
 
 	state->opmode = opmode;
 	if (state->opmode == OPMODE_AUTO) {
diff --git a/drivers/media/video/msp3400-driver.h b/drivers/media/video/msp3400-driver.h
index 4e45104..6359d74 100644
--- a/drivers/media/video/msp3400-driver.h
+++ b/drivers/media/video/msp3400-driver.h
@@ -64,6 +64,7 @@ struct msp_state {
 	u8 has_sound_processing;
 	u8 has_virtual_dolby_surround;
 	u8 has_dolby_pro_logic;
+	u8 force_btsc;
 
 	int radio;
 	int opmode;
diff --git a/drivers/media/video/msp3400-kthreads.c b/drivers/media/video/msp3400-kthreads.c
index 633a102..a0ac592 100644
--- a/drivers/media/video/msp3400-kthreads.c
+++ b/drivers/media/video/msp3400-kthreads.c
@@ -949,11 +949,12 @@ int msp34xxg_thread(void *data)
 
 		/* setup the chip*/
 		msp34xxg_reset(client);
-		state->std = state->radio ? 0x40 : msp_standard;
-		if (state->std != 1)
-			goto unmute;
+		state->std = state->radio ? 0x40 :
+			(state->force_btsc && msp_standard == 1) ? 32 : msp_standard;
 		/* start autodetect */
 		msp_write_dem(client, 0x20, state->std);
+		if (state->std != 1)
+			goto unmute;
 
 		/* watch autodetect */
 		v4l_dbg(1, msp_debug, client, "started autodetect, waiting for result\n");

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbTI2S05 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263976AbTI2RoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:44:15 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:57528 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263973AbTI2RnB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:43:01 -0400
Subject: [PATCH 4/4] Fix AT keyboard repeat rate setting.
In-Reply-To: <10648573751939@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 29 Sep 2003 19:42:55 +0200
Message-Id: <10648573751561@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1386, 2003-09-29 17:00:25+02:00, vojtech@suse.cz
  input: Fix AT keyboard repeat rate setting, also make rate selection
         in finer steps.


 atkbd.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Mon Sep 29 19:36:47 2003
+++ b/drivers/input/keyboard/atkbd.c	Mon Sep 29 19:36:47 2003
@@ -370,10 +370,11 @@
 static int atkbd_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
 	struct atkbd *atkbd = dev->private;
-	struct { int p; u8 v; } period[] =	
-		{ {30, 0x00}, {25, 0x02}, {20, 0x04}, {15, 0x08}, {10, 0x0c}, {7, 0x10}, {5, 0x14}, {0, 0x14} };
-	struct { int d; u8 v; } delay[] =
-        	{ {1000, 0x60}, {750, 0x40}, {500, 0x20}, {250, 0x00}, {0, 0x00} };
+	const short period[32] =
+		{ 33,  37,  42,  46,  50,  54,  58,  63,  67,  75,  83,  92, 100, 109, 116, 125,
+		 133, 149, 167, 182, 200, 217, 232, 250, 270, 303, 333, 370, 400, 435, 470, 500 };
+	const short delay[4] =
+		{ 250, 500, 750, 1000 };
 	char param[2];
 	int i, j;
 
@@ -407,11 +408,11 @@
 			if (atkbd_softrepeat) return 0;
 
 			i = j = 0;
-			while (period[i].p > dev->rep[REP_PERIOD]) i++;
-			while (delay[j].d > dev->rep[REP_DELAY]) j++;
-			dev->rep[REP_PERIOD] = period[i].p;
-			dev->rep[REP_DELAY] = delay[j].d;
-			param[0] = period[i].v | delay[j].v;
+			while (i < 32 && period[i] < dev->rep[REP_PERIOD]) i++;
+			while (j < 4 && delay[j] < dev->rep[REP_DELAY]) j++;
+			dev->rep[REP_PERIOD] = period[i];
+			dev->rep[REP_DELAY] = delay[j];
+			param[0] = i | (j << 5);
 			atkbd_command(atkbd, param, ATKBD_CMD_SETREP);
 
 			return 0;


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263541AbTI2PQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTI2PQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:16:49 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:22958 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263541AbTI2PQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:16:46 -0400
Date: Mon, 29 Sep 2003 17:16:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: keyboard repeat / sound [was Re: Linux 2.6.0-test6]
Message-ID: <20030929151643.GA15992@ucw.cz>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <20030928085902.GA3742@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030928085902.GA3742@k3.hellgate.ch>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 10:59:02AM +0200, Roger Luethi wrote:

> With test6, keyboard repeat takes very noticably longer to kick in after X
> has been started (for both X and console). In test5, starting X makes no
> difference.

Bug in repeat rate setting code. Thanks for reporting, this should fix
it:

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Mon Sep 29 17:16:17 2003
+++ b/drivers/input/keyboard/atkbd.c	Mon Sep 29 17:16:17 2003
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

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

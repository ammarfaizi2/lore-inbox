Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUCPOrP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbUCPOnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:43:17 -0500
Received: from styx.suse.cz ([82.208.2.94]:56193 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261906AbUCPOTg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:36 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446776360@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 6/44] Fix sunkbd.c to work with serport
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:36 +0100
In-Reply-To: <1079446776531@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1474.188.6, 2004-01-26 13:25:24+01:00, vojtech@suse.cz
  input: Fix sunkbd.c to work with serport. Must sleep.


 sunkbd.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
--- a/drivers/input/keyboard/sunkbd.c	Tue Mar 16 13:19:57 2004
+++ b/drivers/input/keyboard/sunkbd.c	Tue Mar 16 13:19:57 2004
@@ -77,6 +77,7 @@
 	struct input_dev dev;
 	struct serio *serio;
 	struct work_struct tq;
+	wait_queue_head_t wait;
 	char name[64];
 	char phys[32];
 	char type;
@@ -96,11 +97,13 @@
 
 	if (sunkbd->reset <= -1) {		/* If cp[i] is 0xff, sunkbd->reset will stay -1. */
 		sunkbd->reset = data;		/* The keyboard sends 0xff 0xff 0xID on powerup */
+		wake_up_interruptible(&sunkbd->wait);
 		goto out;
 	}
 
 	if (sunkbd->layout == -1) {
 		sunkbd->layout = data;
+		wake_up_interruptible(&sunkbd->wait);
 		goto out;
 	}
 
@@ -176,22 +179,19 @@
 
 static int sunkbd_initialize(struct sunkbd *sunkbd)
 {
-	int t;
-
-	t = 1000;
 	sunkbd->reset = -2;
 	sunkbd->serio->write(sunkbd->serio, SUNKBD_CMD_RESET);
-	while (sunkbd->reset < 0 && --t) mdelay(1);
-	if (!t) return -1;
+	wait_event_interruptible_timeout(sunkbd->wait, sunkbd->reset >= 0, HZ);
+	if (sunkbd->reset <0)
+		return -1;
 
 	sunkbd->type = sunkbd->reset;
 
 	if (sunkbd->type == 4) {	/* Type 4 keyboard */
-		t = 250;
 		sunkbd->layout = -2;
 		sunkbd->serio->write(sunkbd->serio, SUNKBD_CMD_LAYOUT);
-		while (sunkbd->layout < 0 && --t) mdelay(1);
-		if (!t) return -1;
+		wait_event_interruptible_timeout(sunkbd->wait, sunkbd->layout >= 0, HZ/4);
+		if (sunkbd->layout < 0) return -1;
 		if (sunkbd->layout & SUNKBD_LAYOUT_5_MASK) sunkbd->type = 5;
 	}
 
@@ -206,9 +206,8 @@
 static void sunkbd_reinit(void *data)
 {
 	struct sunkbd *sunkbd = data;
-	int t = 1000;
 
-	while (sunkbd->reset < 0 && --t) mdelay(1);
+	wait_event_interruptible_timeout(sunkbd->wait, sunkbd->reset >= 0, HZ);
 
 	sunkbd->serio->write(sunkbd->serio, SUNKBD_CMD_SETLED);
 	sunkbd->serio->write(sunkbd->serio, 
@@ -239,6 +238,7 @@
 	memset(sunkbd, 0, sizeof(struct sunkbd));
 
 	init_input_dev(&sunkbd->dev);
+	init_waitqueue_head(&sunkbd->wait);
 
 	sunkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_SND) | BIT(EV_REP);
 	sunkbd->dev.ledbit[0] = BIT(LED_CAPSL) | BIT(LED_COMPOSE) | BIT(LED_SCROLLL) | BIT(LED_NUML);
@@ -275,7 +275,7 @@
 		set_bit(sunkbd->keycode[i], sunkbd->dev.keybit);
 	clear_bit(0, sunkbd->dev.keybit);
 
-	sprintf(sunkbd->name, "%s/input", serio->phys);
+	sprintf(sunkbd->phys, "%s/input0", serio->phys);
 
 	sunkbd->dev.name = sunkbd->name;
 	sunkbd->dev.phys = sunkbd->phys;


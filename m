Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWBAFJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWBAFJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWBAFJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:07 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:12213 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030325AbWBAFJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:03 -0500
Message-Id: <20060201050734.199937000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 08/18] db9: fix possible crash with Saturn gamepads
Content-Disposition: inline; filename=db9-fix-saturn.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: db9 - fix possible crash with Saturn gamepads

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/db9.c |   70 ++++++++++++++++++++++---------------------
 1 files changed, 36 insertions(+), 34 deletions(-)

Index: work/drivers/input/joystick/db9.c
===================================================================
--- work.orig/drivers/input/joystick/db9.c
+++ work/drivers/input/joystick/db9.c
@@ -275,68 +275,70 @@ static unsigned char db9_saturn_read_pac
 /*
  * db9_saturn_report() analyzes packet and reports.
  */
-static int db9_saturn_report(unsigned char id, unsigned char data[60], struct input_dev *dev, int n, int max_pads)
+static int db9_saturn_report(unsigned char id, unsigned char data[60], struct input_dev *devs[], int n, int max_pads)
 {
+	struct input_dev *dev;
 	int tmp, i, j;
 
 	tmp = (id == 0x41) ? 60 : 10;
-	for (j = 0; (j < tmp) && (n < max_pads); j += 10, n++) {
+	for (j = 0; j < tmp && n < max_pads; j += 10, n++) {
+		dev = devs[n];
 		switch (data[j]) {
 		case 0x16: /* multi controller (analog 4 axis) */
-			input_report_abs(dev + n, db9_abs[5], data[j + 6]);
+			input_report_abs(dev, db9_abs[5], data[j + 6]);
 		case 0x15: /* mission stick (analog 3 axis) */
-			input_report_abs(dev + n, db9_abs[3], data[j + 4]);
-			input_report_abs(dev + n, db9_abs[4], data[j + 5]);
+			input_report_abs(dev, db9_abs[3], data[j + 4]);
+			input_report_abs(dev, db9_abs[4], data[j + 5]);
 		case 0x13: /* racing controller (analog 1 axis) */
-			input_report_abs(dev + n, db9_abs[2], data[j + 3]);
+			input_report_abs(dev, db9_abs[2], data[j + 3]);
 		case 0x34: /* saturn keyboard (udlr ZXC ASD QE Esc) */
 		case 0x02: /* digital pad (digital 2 axis + buttons) */
-			input_report_abs(dev + n, db9_abs[0], !(data[j + 1] & 128) - !(data[j + 1] & 64));
-			input_report_abs(dev + n, db9_abs[1], !(data[j + 1] & 32) - !(data[j + 1] & 16));
+			input_report_abs(dev, db9_abs[0], !(data[j + 1] & 128) - !(data[j + 1] & 64));
+			input_report_abs(dev, db9_abs[1], !(data[j + 1] & 32) - !(data[j + 1] & 16));
 			for (i = 0; i < 9; i++)
-				input_report_key(dev + n, db9_cd32_btn[i], ~data[j + db9_saturn_byte[i]] & db9_saturn_mask[i]);
+				input_report_key(dev, db9_cd32_btn[i], ~data[j + db9_saturn_byte[i]] & db9_saturn_mask[i]);
 			break;
 		case 0x19: /* mission stick x2 (analog 6 axis + buttons) */
-			input_report_abs(dev + n, db9_abs[0], !(data[j + 1] & 128) - !(data[j + 1] & 64));
-			input_report_abs(dev + n, db9_abs[1], !(data[j + 1] & 32) - !(data[j + 1] & 16));
+			input_report_abs(dev, db9_abs[0], !(data[j + 1] & 128) - !(data[j + 1] & 64));
+			input_report_abs(dev, db9_abs[1], !(data[j + 1] & 32) - !(data[j + 1] & 16));
 			for (i = 0; i < 9; i++)
-				input_report_key(dev + n, db9_cd32_btn[i], ~data[j + db9_saturn_byte[i]] & db9_saturn_mask[i]);
-			input_report_abs(dev + n, db9_abs[2], data[j + 3]);
-			input_report_abs(dev + n, db9_abs[3], data[j + 4]);
-			input_report_abs(dev + n, db9_abs[4], data[j + 5]);
+				input_report_key(dev, db9_cd32_btn[i], ~data[j + db9_saturn_byte[i]] & db9_saturn_mask[i]);
+			input_report_abs(dev, db9_abs[2], data[j + 3]);
+			input_report_abs(dev, db9_abs[3], data[j + 4]);
+			input_report_abs(dev, db9_abs[4], data[j + 5]);
 			/*
-			input_report_abs(dev + n, db9_abs[8], (data[j + 6] & 128 ? 0 : 1) - (data[j + 6] & 64 ? 0 : 1));
-			input_report_abs(dev + n, db9_abs[9], (data[j + 6] & 32 ? 0 : 1) - (data[j + 6] & 16 ? 0 : 1));
+			input_report_abs(dev, db9_abs[8], (data[j + 6] & 128 ? 0 : 1) - (data[j + 6] & 64 ? 0 : 1));
+			input_report_abs(dev, db9_abs[9], (data[j + 6] & 32 ? 0 : 1) - (data[j + 6] & 16 ? 0 : 1));
 			*/
-			input_report_abs(dev + n, db9_abs[6], data[j + 7]);
-			input_report_abs(dev + n, db9_abs[7], data[j + 8]);
-			input_report_abs(dev + n, db9_abs[5], data[j + 9]);
+			input_report_abs(dev, db9_abs[6], data[j + 7]);
+			input_report_abs(dev, db9_abs[7], data[j + 8]);
+			input_report_abs(dev, db9_abs[5], data[j + 9]);
 			break;
 		case 0xd3: /* sankyo ff (analog 1 axis + stop btn) */
-			input_report_key(dev + n, BTN_A, data[j + 3] & 0x80);
-			input_report_abs(dev + n, db9_abs[2], data[j + 3] & 0x7f);
+			input_report_key(dev, BTN_A, data[j + 3] & 0x80);
+			input_report_abs(dev, db9_abs[2], data[j + 3] & 0x7f);
 			break;
 		case 0xe3: /* shuttle mouse (analog 2 axis + buttons. signed value) */
-			input_report_key(dev + n, BTN_START, data[j + 1] & 0x08);
-			input_report_key(dev + n, BTN_A, data[j + 1] & 0x04);
-			input_report_key(dev + n, BTN_C, data[j + 1] & 0x02);
-			input_report_key(dev + n, BTN_B, data[j + 1] & 0x01);
-			input_report_abs(dev + n, db9_abs[2], data[j + 2] ^ 0x80);
-			input_report_abs(dev + n, db9_abs[3], (0xff-(data[j + 3] ^ 0x80))+1); /* */
+			input_report_key(dev, BTN_START, data[j + 1] & 0x08);
+			input_report_key(dev, BTN_A, data[j + 1] & 0x04);
+			input_report_key(dev, BTN_C, data[j + 1] & 0x02);
+			input_report_key(dev, BTN_B, data[j + 1] & 0x01);
+			input_report_abs(dev, db9_abs[2], data[j + 2] ^ 0x80);
+			input_report_abs(dev, db9_abs[3], (0xff-(data[j + 3] ^ 0x80))+1); /* */
 			break;
 		case 0xff:
 		default: /* no pad */
-			input_report_abs(dev + n, db9_abs[0], 0);
-			input_report_abs(dev + n, db9_abs[1], 0);
+			input_report_abs(dev, db9_abs[0], 0);
+			input_report_abs(dev, db9_abs[1], 0);
 			for (i = 0; i < 9; i++)
-				input_report_key(dev + n, db9_cd32_btn[i], 0);
+				input_report_key(dev, db9_cd32_btn[i], 0);
 			break;
 		}
 	}
 	return n;
 }
 
-static int db9_saturn(int mode, struct parport *port, struct input_dev *dev)
+static int db9_saturn(int mode, struct parport *port, struct input_dev *devs[])
 {
 	unsigned char id, data[60];
 	int type, n, max_pads;
@@ -361,7 +363,7 @@ static int db9_saturn(int mode, struct p
 	max_pads = min(db9_modes[mode].n_pads, DB9_MAX_DEVICES);
 	for (tmp = 0, i = 0; i < n; i++) {
 		id = db9_saturn_read_packet(port, data, type + i, 1);
-		tmp = db9_saturn_report(id, data, dev, tmp, max_pads);
+		tmp = db9_saturn_report(id, data, devs, tmp, max_pads);
 	}
 	return 0;
 }
@@ -489,7 +491,7 @@ static void db9_timer(unsigned long priv
 		case DB9_SATURN_DPP:
 		case DB9_SATURN_DPP_2:
 
-			db9_saturn(db9->mode, port, dev);
+			db9_saturn(db9->mode, port, db9->dev);
 			break;
 
 		case DB9_CD32_PAD:


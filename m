Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTFFXnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 19:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbTFFXnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 19:43:20 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:11207 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262369AbTFFXnS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 19:43:18 -0400
Date: Sat, 7 Jun 2003 01:56:47 +0200
From: Tobias Diedrich <ranma@gmx.at>
To: linux-kernel@vger.kernel.org
Subject: gamecon module & PSX dance mat controller
Message-ID: <20030606235647.GA3242@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma@gmx.at>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-GPG-Fingerprint: 7168 1190 37D2 06E8 2496  2728 E6AF EC7A 9AC7 E0BC
X-GPG-Key: http://studserv.stud.uni-hannover.de/~ranma/gpg-key
User-Agent: Mutt/1.5.4i
X-Seen: false
X-ID: GD7wCYZDoeOmWnAQK5fWdjdTVpCDRAXZJWjXTOw9-o9KFT1GdkQoc4@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed that the directional buttons are mapped on the x and y axis.
This breaks dance mat support, because there you can actually (and have
to) stand on both left and right or up and down at the same time,
the following patch fixes that by mapping the directional buttons on
BTN_LEFT, BTN_RIGHT, BTN_FORWARD and BTN_BACK instead of x- and y-axis.
With this patch, you can use a real psx dance mat controller for games
like pyddr and stepmania.

--- linux/drivers/char/joystick/gamecon.c	2001-09-13 00:34:06.000000000 +0200
+++ linux/drivers/char/joystick/gamecon.c	2003-06-07 01:45:17.000000000 +0200
@@ -230,9 +230,9 @@
 #define GC_PSX_ID(x)	((x) >> 4)	/* High nibble is device type */
 #define GC_PSX_LEN(x)	((x) & 0xf)	/* Low nibble is length in words */
 
-static short gc_psx_abs[] = { ABS_X, ABS_Y, ABS_RX, ABS_RY, ABS_HAT0X, ABS_HAT0Y };
+static short gc_psx_abs[] = { ABS_X, ABS_Y, ABS_RX, ABS_RY };
 static short gc_psx_btn[] = { BTN_TL, BTN_TR, BTN_TL2, BTN_TR2, BTN_A, BTN_B, BTN_X, BTN_Y,
-				BTN_START, BTN_SELECT, BTN_THUMBL, BTN_THUMBR };
+                              BTN_SELECT, BTN_THUMBR, BTN_THUMBL, BTN_START, BTN_FORWARD, BTN_RIGHT, BTN_BACK, BTN_LEFT};
 
 /*
  * gc_psx_command() writes 8bit command and reads 8bit data from
@@ -396,37 +396,18 @@
  		switch (gc_psx_read_packet(gc, data)) {
 
 			case GC_PSX_RUMBLE:
-
-				input_report_key(dev + i, BTN_THUMB,  ~data[0] & 0x04);
-				input_report_key(dev + i, BTN_THUMB2, ~data[0] & 0x02);
-
 			case GC_PSX_NEGCON:
 			case GC_PSX_ANALOG:
 
 				for (j = 0; j < 4; j++)
 					input_report_abs(dev + i, gc_psx_abs[j], data[j + 2]);
 
-				input_report_abs(dev + i, ABS_HAT0X, !(data[0] & 0x20) - !(data[0] & 0x80));
-				input_report_abs(dev + i, ABS_HAT0Y, !(data[0] & 0x40) - !(data[0] & 0x10));
-
-				for (j = 0; j < 8; j++)
-					input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << j));
-
-				input_report_key(dev + i, BTN_START,  ~data[0] & 0x08);
-				input_report_key(dev + i, BTN_SELECT, ~data[0] & 0x01);
-
-				break;
-
 			case GC_PSX_NORMAL:
 
-				input_report_abs(dev + i, ABS_X, 128 + !(data[0] & 0x20) * 127 - !(data[0] & 0x80) * 128);
-				input_report_abs(dev + i, ABS_Y, 128 + !(data[0] & 0x40) * 127 - !(data[0] & 0x10) * 128);
-
-				for (j = 0; j < 8; j++)
+				for (j = 0; j < 8; j++) {
+					input_report_key(dev + i, gc_psx_btn[j+8], ~data[0] & (1 << j));
 					input_report_key(dev + i, gc_psx_btn[j], ~data[1] & (1 << j));
-
-				input_report_key(dev + i, BTN_START,  ~data[0] & 0x08);
-				input_report_key(dev + i, BTN_SELECT, ~data[0] & 0x01);
+				}
 
 				break;
 		}
@@ -559,7 +540,7 @@
 					case GC_PSX_ANALOG:
 					case GC_PSX_RUMBLE:
 
-						for (j = 0; j < 6; j++) {
+						for (j = 0; j < 4; j++) {
 							psx = gc_psx_abs[j];
 							set_bit(psx, gc->dev[i].absbit);
 							if (j < 4) {
@@ -572,7 +553,7 @@
 							}
 						}
 
-						for (j = 0; j < 12; j++)
+						for (j = 0; j < 16; j++)
 							set_bit(gc_psx_btn[j], gc->dev[i].keybit);
 
 						break;

-- 
Tobias						PGP: http://9ac7e0bc.2ya.com
This mail is made of 100% recycled bits

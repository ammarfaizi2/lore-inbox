Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263837AbTFUNqj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 09:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264203AbTFUNib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 09:38:31 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:23202 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263837AbTFUNiB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 09:38:01 -0400
Subject: [PATCH 10/11] input: Fixes for sidewinder.c
In-Reply-To: <10562035171903@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 21 Jun 2003 15:51:57 +0200
Message-Id: <10562035174020@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1368, 2003-06-21 04:48:10-07:00, vojtech@kernel.bkbits.net
  input: Fixes for sidewinder.c: Workaround for
         misbehaving 3DPro joysticks, don't trust FreestylePro
         1-bit data packet for data width recognition, invert
         FreestylePro buttons.


 sidewinder.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

===================================================================

diff -Nru a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
--- a/drivers/input/joystick/sidewinder.c	Sat Jun 21 15:25:59 2003
+++ b/drivers/input/joystick/sidewinder.c	Sat Jun 21 15:25:59 2003
@@ -378,10 +378,10 @@
 			for (j = 0; j < 6; j++)
 				input_report_key(dev, sw_btn[SW_ID_FSP][j], !GB(j+10,1));
 
-			input_report_key(dev, BTN_TR,     GB(26,1));
-			input_report_key(dev, BTN_START,  GB(27,1));
-			input_report_key(dev, BTN_MODE,   GB(38,1));
-			input_report_key(dev, BTN_SELECT, GB(39,1));
+			input_report_key(dev, BTN_TR,     !GB(26,1));
+			input_report_key(dev, BTN_START,  !GB(27,1));
+			input_report_key(dev, BTN_MODE,   !GB(38,1));
+			input_report_key(dev, BTN_SELECT, !GB(39,1));
 
 			input_sync(dev);
 
@@ -602,7 +602,6 @@
 		gameport->phys, gameport->io, gameport->speed);
 
 	i = sw_read_packet(gameport, buf, SW_LENGTH, 0);		/* Read normal packet */
-	m |= sw_guess_mode(buf, i);					/* Data packet (1-bit) can carry mode info [FSP] */
 	udelay(SW_TIMEOUT);
 	dbg("Init 1: Mode %d. Length %d.", m , i);
 
@@ -676,6 +675,8 @@
 					} else
 					sw->type = SW_ID_PP;
 					break;
+				case 66:
+					sw->bits = 3;
 				case 198:
 					sw->length = 22;
 				case 64:


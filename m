Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbTA1MYw>; Tue, 28 Jan 2003 07:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbTA1MYw>; Tue, 28 Jan 2003 07:24:52 -0500
Received: from mpsb-nat26.plala.or.jp ([202.212.115.73]:43965 "EHLO
	mps6.plala.or.jp") by vger.kernel.org with ESMTP id <S265242AbTA1MYu>;
	Tue, 28 Jan 2003 07:24:50 -0500
Date: Tue, 28 Jan 2003 21:34:08 +0900
From: <yokotak@rmail.plala.or.jp>
X-Mailer: EdMax Ver2.85.2F
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gamecon (added support for Sega Saturn controller), kernel 2.4.20
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20030127113636.A9329@ucw.cz>
References: <20030127113636.A9329@ucw.cz>
Message-Id: <20030128123407.XMOG22161.mps6.plala.or.jp@rmail.mail.plala.or.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your reply.

Vojtech Pavlik <vojtech@suse.cz> wrote:
> Two in some cases. And that's the number of Saturn pads supported by
> your patch as well, right?
I am sorry. Suggested by you, I find DB9_MULTI_0802_2 on db9.c now. I 
will try to hack db9.c. DPP compatible JOY-DB9.C patch previously exists.
 (http://www.self-core.org/~kaoru-k/pub/joy_db9_dpp_saturn_2.2.17.patch)
Below patch is preliminaly support for ninth button on db9.c compatible 
interface. I have not tested if it works or not. (I have no interface 
nor knowledge of 0x37a command register.)

> Gamecon is based on that it uses one input line per device. The Saturn
> needs more than one (four?).
But using gamecon.c might be the easiest way to support more (12 pads 
with two multitap on each connector, in maximum) pads, although satun 
pad can not live with other pads in my gamecon.c patch.

[Multitap and DirectPad Pro Interface]
      +-----------+
      |           |
      | Linux BOX |
      |           |(1 LPT port)
      +-----------+
               |
               |
               |
            +-----+
            | DPP |(2 connectors)
            +-----+
            /     \
           /       \
          /         \
    +-----+         +-----+
pad1|multi|pad6 pad7|multi|pad12 (12 gamepads)
pad2| tap |pad5 pad8| tap |pad11
    +-----+         +-----+
   pad3 pad4       pad9 pad10
(I have only tested with first 6 pad with a multitap.)


--- db9.c.orig	Thu Sep 13 07:34:06 2001
+++ db9.c	Tue Jan 28 20:18:22 2003
@@ -70,9 +70,9 @@
 #define DB9_NOSELECT		0x08
 
 #define DB9_SATURN0		0x00
-#define DB9_SATURN1		0x02
-#define DB9_SATURN2		0x04
-#define DB9_SATURN3		0x06
+#define DB9_SATURN1		(DB9_SATURN0 ^ 0x02)
+#define DB9_SATURN2		(DB9_SATURN0 ^ 0x04)
+#define DB9_SATURN3		(DB9_SATURN1 ^ 0x04)
 
 #define DB9_GENESIS6_DELAY	14
 #define DB9_REFRESH_TIME	HZ/100
@@ -95,7 +95,7 @@
 static short db9_genesis_btn[] = { BTN_START, BTN_A, BTN_B, BTN_C, BTN_X, BTN_Y, BTN_Z, BTN_MODE };
 static short db9_cd32_btn[] = { BTN_A, BTN_B, BTN_C, BTN_X, BTN_Y, BTN_Z, BTN_TL, BTN_TR, BTN_START };
 
-static char db9_buttons[DB9_MAX_PAD] = { 0, 1, 2, 4, 0, 6, 8, 8, 1, 1, 7 };
+static char db9_buttons[DB9_MAX_PAD] = { 0, 1, 2, 4, 0, 6, 8, 9, 1, 1, 7 };
 static short *db9_btn[DB9_MAX_PAD] = { NULL, db9_multi_btn, db9_multi_btn, db9_genesis_btn, NULL, db9_genesis_btn,
 					db9_genesis_btn, db9_cd32_btn, db9_multi_btn, db9_multi_btn, db9_cd32_btn };
 static char *db9_name[DB9_MAX_PAD] = { NULL, "Multisystem joystick", "Multisystem joystick (2 fire)", "Genesis pad",
@@ -222,27 +222,32 @@
 
 		case DB9_SATURN_PAD:
 
-			parport_write_control(port, DB9_SATURN0);
+			parport_write_control(port, DB9_SATURN0);	/*  low -  low */
 			data = parport_read_data(port);
 
-			input_report_key(dev, BTN_Y,  ~data & DB9_LEFT);
-			input_report_key(dev, BTN_Z,  ~data & DB9_DOWN);
-			input_report_key(dev, BTN_TL, ~data & DB9_UP);
+			input_report_key(dev, BTN_X,  ~data & DB9_LEFT);
+			input_report_key(dev, BTN_Y,  ~data & DB9_DOWN);
+			input_report_key(dev, BTN_Z,  ~data & DB9_UP);
 			input_report_key(dev, BTN_TR, ~data & DB9_RIGHT);
 
-			parport_write_control(port, DB9_SATURN2);
+			parport_write_control(port, DB9_SATURN2);	/* high -  low */
 			data = parport_read_data(port);
 
 			input_report_abs(dev, ABS_X, (data & DB9_RIGHT ? 0 : 1) - (data & DB9_LEFT ? 0 : 1));
 			input_report_abs(dev, ABS_Y, (data & DB9_DOWN  ? 0 : 1) - (data & DB9_UP   ? 0 : 1));
 			
-			parport_write_control(port, DB9_NORMAL);
+			parport_write_control(port, DB9_SATURN1);	/*  low - high */
 			data = parport_read_data(port);
 
 			input_report_key(dev, BTN_A, ~data & DB9_LEFT);
 			input_report_key(dev, BTN_B, ~data & DB9_UP);
 			input_report_key(dev, BTN_C, ~data & DB9_DOWN);
-			input_report_key(dev, BTN_X, ~data & DB9_RIGHT);
+			input_report_key(dev, BTN_START, ~data & DB9_RIGHT);
+
+			parport_write_control(port, DB9_SATURN3);	/* high - high */
+			data = parport_read_data(port);
+
+			input_report_key(dev, BTN_TL, ~data & DB9_RIGHT);
 			break;
 
 		case DB9_CD32_PAD:


yokota


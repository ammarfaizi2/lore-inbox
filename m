Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUEKGZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUEKGZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUEKGZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:25:51 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:38008 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262388AbUEKGZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:25:11 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 2/9] New set of input patches - 03-kbd98-interrupt.patch
Date: Tue, 11 May 2004 01:24:35 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200405110101.42805.dtor_core@ameritech.net> <200405110103.27973.dtor_core@ameritech.net>
In-Reply-To: <200405110103.27973.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405110124.35229.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1587.20.4, 2004-05-10 01:26:53-05:00, dtor_core@ameritech.net
  Input: kbd98_interrupt should return irqreturn_t


 98kbd.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)


===================================================================



diff -Nru a/drivers/input/keyboard/98kbd.c b/drivers/input/keyboard/98kbd.c
--- a/drivers/input/keyboard/98kbd.c	Tue May 11 00:55:01 2004
+++ b/drivers/input/keyboard/98kbd.c	Tue May 11 00:55:01 2004
@@ -109,8 +109,8 @@
 	struct jis_kbd_conv jis[16];
 };
 
-void kbd98_interrupt(struct serio *serio, unsigned char data,
-			unsigned int flags, struct pt_regs *regs)
+irqreturn_t kbd98_interrupt(struct serio *serio, unsigned char data,
+			    unsigned int flags, struct pt_regs *regs)
 {
 	struct kbd98 *kbd98 = serio->private;
 	unsigned char scancode, keycode;
@@ -119,15 +119,15 @@
 	switch (data) {
 		case KBD98_RET_ACK:
 			kbd98->ack = 1;
-			return;
+			goto out;
 		case KBD98_RET_NAK:
 			kbd98->ack = -1;
-			return;
+			goto out;
 	}
 
 	if (kbd98->cmdcnt) {
 		kbd98->cmdbuf[--kbd98->cmdcnt] = data;
-		return;
+		goto out;
 	}
 
 	scancode = data & KBD98_KEY;
@@ -164,7 +164,7 @@
 
 			keycode = kbd98->jis[i].emul[kbd98->shift].keycode;
 			if (keycode == KBD98_KEY_NULL)
-				return;
+				break;
 
 			if (press) {
 				kbd98->emul.scancode = scancode;
@@ -187,27 +187,31 @@
 			}
 
 			input_sync(&kbd98->dev);
-			return;
+			break;
 
 		case KEY_CAPSLOCK:
 			input_report_key(&kbd98->dev, keycode, 1);
 			input_sync(&kbd98->dev);
 			input_report_key(&kbd98->dev, keycode, 0);
 			input_sync(&kbd98->dev);
-			return;
+			break;
 
 		case KBD98_KEY_NULL:
-			return;
+			break;
 
 		case 0:
 			printk(KERN_WARNING "kbd98.c: Unknown key (scancode %#x) %s.\n",
 				data & KBD98_KEY, data & KBD98_RELEASE ? "released" : "pressed");
-			return;
+			break;
 
 		default:
 			input_report_key(&kbd98->dev, keycode, press);
 			input_sync(&kbd98->dev);
-		}
+			break;
+	}
+
+out:
+	return IRQ_HANDLED;
 }
 
 /*

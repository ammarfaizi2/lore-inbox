Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264595AbUFGMXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUFGMXK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264600AbUFGMWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:22:48 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:8321 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264595AbUFGL4R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:17 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093542769@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093543447@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:54 +0200
Subject: [PATCH 24/39] input: kbd98_interrupt should return irqreturn_t
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.27.4, 2004-05-10 01:26:53-05:00, dtor_core@ameritech.net
  Input: kbd98_interrupt should return irqreturn_t


 98kbd.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/98kbd.c b/drivers/input/keyboard/98kbd.c
--- a/drivers/input/keyboard/98kbd.c	2004-06-07 13:11:40 +02:00
+++ b/drivers/input/keyboard/98kbd.c	2004-06-07 13:11:40 +02:00
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


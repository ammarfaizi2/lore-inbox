Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVA0ROf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVA0ROf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbVA0ROf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:14:35 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:60895 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262663AbVA0ROM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:14:12 -0500
Subject: [PATCH 6/6] Fix ACK/NAK handling in libps2.c - don't ignore bytes before ACK
In-Reply-To: <11068460382243@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 27 Jan 2005 18:13:58 +0100
Message-Id: <11068460382169@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/for-linus

===================================================================

ChangeSet@1.1976, 2005-01-27 01:18:50-05:00, dtor_core@ameritech.net
  Input: ACK/NAK processing rules in libps2 were too strict - while it is a
         good idea to discard any character other than ACK/NAK during probe
         it causes missing releases and keys getting "stuck" when a command
         issued on enabled device. The effect is easily demonstrated with
         the following command:
             while true; do xset led 3; xset -led 3; done
  
         With this change extra characters will be discarded only if device
         has not been marked as "enabled" yet.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru> 


 libps2.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
--- a/drivers/input/serio/libps2.c	2005-01-27 17:47:59 +01:00
+++ b/drivers/input/serio/libps2.c	2005-01-27 17:47:59 +01:00
@@ -223,7 +223,8 @@
 }
 
 /*
- * ps2_handle_ack()
+ * ps2_handle_ack() is supposed to be used in interrupt handler
+ * to properly process ACK/NAK of a command from a PS/2 device.
  */
 
 int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data)
@@ -250,18 +251,27 @@
 			}
 			/* Fall through */
 		default:
-			return 1;
+			return 0;
 	}
 
+
 	if (!ps2dev->nak && ps2dev->cmdcnt)
 		ps2dev->flags |= PS2_FLAG_CMD | PS2_FLAG_CMD1;
 
 	ps2dev->flags &= ~PS2_FLAG_ACK;
 	wake_up_interruptible(&ps2dev->wait);
 
-	return data == PS2_RET_ACK || data == PS2_RET_NAK;
+	if (data != PS2_RET_ACK)
+		ps2_handle_response(ps2dev, data);
+
+	return 1;
 }
 
+/*
+ * ps2_handle_response() is supposed to be used in interrupt handler
+ * to properly store device's response to a command and notify process
+ * waiting for completion of the command.
+ */
 
 int ps2_handle_response(struct ps2dev *ps2dev, unsigned char data)
 {


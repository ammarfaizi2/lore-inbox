Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbTIUTED (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 15:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbTIUTED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 15:04:03 -0400
Received: from smtp4.hy.skanova.net ([195.67.199.133]:41412 "EHLO
	smtp4.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262536AbTIUTD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 15:03:58 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>
Subject: [PATCH 1/2] synaptics: Don't try to handle more than eight multi buttons
From: Peter Osterlund <petero2@telia.com>
Date: 21 Sep 2003 21:03:51 +0200
Message-ID: <m2wuc2t148.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch from Dmitry is not yet in Linus's tree. Please apply.
Dmitry's original email was:

Peter,

Peter Berg Larsen pointed to me that with regard to multi-button 
capabilities the spec says: "If nExtBtm is greater than 8 ... nExtbtm 
should be considered to be invalid and treated as zero."

The patch below should fix that. I also sent it to Vojtech with my 
reconnect patch.

Dmitry

 linux-petero/drivers/input/mouse/synaptics.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff -puN drivers/input/mouse/synaptics.c~synaptics-multi-btn-fix2 drivers/input/mouse/synaptics.c
--- linux/drivers/input/mouse/synaptics.c~synaptics-multi-btn-fix2	2003-09-21 14:55:14.000000000 +0200
+++ linux-petero/drivers/input/mouse/synaptics.c	2003-09-21 14:55:14.000000000 +0200
@@ -164,7 +164,8 @@ static void print_ident(struct synaptics
 
 	if (SYN_CAP_EXTENDED(priv->capabilities)) {
 		printk(KERN_INFO " Touchpad has extended capability bits\n");
-		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
+		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) &&
+		    SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) <= 8)
 			printk(KERN_INFO " -> %d multi-buttons, i.e. besides standard buttons\n",
 			       (int)(SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)));
 		else if (SYN_CAP_FOUR_BUTTON(priv->capabilities))
@@ -352,7 +353,11 @@ int synaptics_init(struct psmouse *psmou
 	if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
 		switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
 		default:
-			printk(KERN_ERR "This touchpad reports more than 8 multi-buttons, don't know how to handle.\n");
+			/*
+			 * if nExtBtn is greater than 8 it should be considered
+			 * invalid and treated as 0
+			 */
+			break;
 		case 8:
 			set_bit(BTN_7, psmouse->dev.keybit);
 			set_bit(BTN_6, psmouse->dev.keybit);
@@ -437,7 +442,11 @@ static void synaptics_parse_hw_state(uns
 		    ((buf[3] & 2) ? !hw->right : hw->right)) {
 			switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
 			default:
-				; /* we did comment while initialising... */
+				/*
+				 * if nExtBtn is greater than 8 it should be
+				 * considered invalid and treated as 0
+				 */
+				break;
 			case 8:
 				hw->b7 = ((buf[5] & 0x08)) ? 1 : 0;
 				hw->b6 = ((buf[4] & 0x08)) ? 1 : 0;
@@ -516,7 +525,11 @@ static void synaptics_process_packet(str
 	if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
 		switch(SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
 		default:
-			; /* we did comment while initialising... */
+			/*
+			 * if nExtBtn is greater than 8 it should be considered
+			 * invalid and treated as 0
+			 */
+			break;
 		case 8:
 			input_report_key(dev, BTN_7,       hw.b7);
 			input_report_key(dev, BTN_6,       hw.b6);

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

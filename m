Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272144AbTG2Vuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272150AbTG2Vuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:50:51 -0400
Received: from mailc.telia.com ([194.22.190.4]:54011 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id S272144AbTG2Vun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:50:43 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH: Support Synaptics TouchPad old-style absolute packet format
From: Peter Osterlund <petero2@telia.com>
Date: 29 Jul 2003 23:50:32 +0200
Message-ID: <m2wue16lzr.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch adds support for the old-style absolute packet format used
by some old versions of the touchpad. The patch applies on top of the
previous synaptics patches. The whole patch series is also available
here:

http://w1.894.telia.com/~u89404340/patches/touchpad/2.6.0-test2/v1/


 linux-petero/drivers/input/mouse/synaptics.c |  174 +++++++++++++++------------
 1 files changed, 100 insertions(+), 74 deletions(-)

diff -puN drivers/input/mouse/synaptics.c~synaptics-old-proto drivers/input/mouse/synaptics.c
--- linux/drivers/input/mouse/synaptics.c~synaptics-old-proto	Tue Jul 29 23:22:26 2003
+++ linux-petero/drivers/input/mouse/synaptics.c	Tue Jul 29 23:22:26 2003
@@ -394,20 +394,6 @@ void synaptics_disconnect(struct psmouse
 
 static void synaptics_parse_hw_state(unsigned char buf[], struct synaptics_data *priv, struct synaptics_hw_state *hw)
 {
-	hw->x = (((buf[3] & 0x10) << 8) |
-		 ((buf[1] & 0x0f) << 8) |
-		 buf[4]);
-	hw->y = (((buf[3] & 0x20) << 7) |
-		 ((buf[1] & 0xf0) << 4) |
-		 buf[5]);
-
-	hw->z = buf[2];
-	hw->w = (((buf[0] & 0x30) >> 2) |
-		 ((buf[0] & 0x04) >> 1) |
-		 ((buf[3] & 0x04) >> 2));
-
-	hw->left  = (buf[0] & 0x01) ? 1 : 0;
-	hw->right = (buf[0] & 0x02) ? 1 : 0;
 	hw->up    = 0;
 	hw->down  = 0;
 	hw->b0    = 0;
@@ -418,32 +404,58 @@ static void synaptics_parse_hw_state(uns
 	hw->b5    = 0;
 	hw->b6    = 0;
 	hw->b7    = 0;
-	if (SYN_CAP_EXTENDED(priv->capabilities) &&
-	    (SYN_CAP_FOUR_BUTTON(priv->capabilities))) {
-		hw->up = ((buf[3] & 0x01)) ? 1 : 0;
-		if (hw->left)
-			hw->up = !hw->up;
-		hw->down = ((buf[3] & 0x02)) ? 1 : 0;
-		if (hw->right)
-			hw->down = !hw->down;
-	}
-	if (buf[3] == 0xC2 && SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)) {
-		switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
-		default:
-			; /* we did comment while initialising... */
-		case 8:
-			hw->b7 = ((buf[5] & 0x08)) ? 1 : 0;
-			hw->b6 = ((buf[4] & 0x08)) ? 1 : 0;
-		case 6:
-			hw->b5 = ((buf[5] & 0x04)) ? 1 : 0;
-			hw->b4 = ((buf[4] & 0x04)) ? 1 : 0;
-		case 4:
-			hw->b3 = ((buf[5] & 0x02)) ? 1 : 0;
-			hw->b2 = ((buf[4] & 0x02)) ? 1 : 0;
-		case 2:
-			hw->b1 = ((buf[5] & 0x01)) ? 1 : 0;
-			hw->b0 = ((buf[4] & 0x01)) ? 1 : 0;
+
+	if (SYN_MODEL_NEWABS(priv->model_id)) {
+		hw->x = (((buf[3] & 0x10) << 8) |
+			 ((buf[1] & 0x0f) << 8) |
+			 buf[4]);
+		hw->y = (((buf[3] & 0x20) << 7) |
+			 ((buf[1] & 0xf0) << 4) |
+			 buf[5]);
+
+		hw->z = buf[2];
+		hw->w = (((buf[0] & 0x30) >> 2) |
+			 ((buf[0] & 0x04) >> 1) |
+			 ((buf[3] & 0x04) >> 2));
+
+		hw->left  = (buf[0] & 0x01) ? 1 : 0;
+		hw->right = (buf[0] & 0x02) ? 1 : 0;
+		if (SYN_CAP_EXTENDED(priv->capabilities) &&
+		    (SYN_CAP_FOUR_BUTTON(priv->capabilities))) {
+			hw->up = ((buf[3] & 0x01)) ? 1 : 0;
+			if (hw->left)
+				hw->up = !hw->up;
+			hw->down = ((buf[3] & 0x02)) ? 1 : 0;
+			if (hw->right)
+				hw->down = !hw->down;
+		}
+		if (buf[3] == 0xC2 && SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)) {
+			switch (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) & ~0x01) {
+			default:
+				; /* we did comment while initialising... */
+			case 8:
+				hw->b7 = ((buf[5] & 0x08)) ? 1 : 0;
+				hw->b6 = ((buf[4] & 0x08)) ? 1 : 0;
+			case 6:
+				hw->b5 = ((buf[5] & 0x04)) ? 1 : 0;
+				hw->b4 = ((buf[4] & 0x04)) ? 1 : 0;
+			case 4:
+				hw->b3 = ((buf[5] & 0x02)) ? 1 : 0;
+				hw->b2 = ((buf[4] & 0x02)) ? 1 : 0;
+			case 2:
+				hw->b1 = ((buf[5] & 0x01)) ? 1 : 0;
+				hw->b0 = ((buf[4] & 0x01)) ? 1 : 0;
+			}
 		}
+	} else {
+		hw->x = (((buf[1] & 0x1f) << 8) | buf[2]);
+		hw->y = (((buf[4] & 0x1f) << 8) | buf[5]);
+
+		hw->z = (((buf[0] & 0x30) << 2) | (buf[3] & 0x3F));
+		hw->w = (((buf[1] & 0x80) >> 4) | ((buf[0] & 0x04) >> 1));
+
+		hw->left  = (buf[0] & 0x01) ? 1 : 0;
+		hw->right = (buf[0] & 0x02) ? 1 : 0;
 	}
 }
 
@@ -522,44 +534,58 @@ void synaptics_process_byte(struct psmou
 	struct input_dev *dev = &psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
 	unsigned char data = psmouse->packet[psmouse->pktcnt - 1];
+	int newabs = SYN_MODEL_NEWABS(priv->model_id);
 
 	input_regs(dev, regs);
 
-	/* check first byte */
-	if (psmouse->pktcnt == 1 && (data & 0xC8) != 0x80) {
-		printk(KERN_WARNING "Synaptics driver lost sync at 1st byte\n");
-		priv->out_of_sync++;
-		psmouse->pktcnt = 0;
-	        if (psmouse_resetafter > 0 && priv->out_of_sync	== psmouse_resetafter) {
-			psmouse->state = PSMOUSE_IGNORE;
-			serio_rescan(psmouse->serio);
-		}
-		return;
-	}
-
-	/* check 4th byte */
-	if (psmouse->pktcnt == 4 && (data & 0xC8) != 0xC0) {
-		printk(KERN_WARNING "Synaptics driver lost sync at 4th byte\n");
-		priv->out_of_sync++;
-		psmouse->pktcnt = 0;
-	        if (psmouse_resetafter > 0 && priv->out_of_sync	== psmouse_resetafter) {
-			psmouse->state = PSMOUSE_IGNORE;
-			serio_rescan(psmouse->serio);
-		}
-		return;
-	}
-
-	if (psmouse->pktcnt >= 6) { /* Full packet received */
-		if (priv->out_of_sync) {
-			priv->out_of_sync = 0;
-			printk(KERN_NOTICE "Synaptics driver resynced.\n");
-		}
-
-		if (priv->ptport && synaptics_is_pt_packet(psmouse->packet))
-			synaptics_pass_pt_packet(priv->ptport, psmouse->packet);
-		else
-			synaptics_process_packet(psmouse);
+	switch (psmouse->pktcnt) {
+	case 1:
+		if (newabs ? ((data & 0xC8) != 0x80) : ((data & 0xC0) != 0xC0)) {
+			printk(KERN_WARNING "Synaptics driver lost sync at 1st byte\n");
+			goto bad_sync;
+		}
+		break;
+	case 2:
+		if (!newabs && ((data & 0x60) != 0x00)) {
+			printk(KERN_WARNING "Synaptics driver lost sync at 2nd byte\n");
+			goto bad_sync;
+		}
+		break;
+	case 4:
+		if (newabs ? ((data & 0xC8) != 0xC0) : ((data & 0xC0) != 0x80)) {
+			printk(KERN_WARNING "Synaptics driver lost sync at 4th byte\n");
+			goto bad_sync;
+		}
+		break;
+	case 5:
+		if (!newabs && ((data & 0x60) != 0x00)) {
+			printk(KERN_WARNING "Synaptics driver lost sync at 5th byte\n");
+			goto bad_sync;
+		}
+		break;
+	default:
+		if (psmouse->pktcnt >= 6) { /* Full packet received */
+			if (priv->out_of_sync) {
+				priv->out_of_sync = 0;
+				printk(KERN_NOTICE "Synaptics driver resynced.\n");
+			}
 
-		psmouse->pktcnt = 0;
+			if (priv->ptport && synaptics_is_pt_packet(psmouse->packet))
+				synaptics_pass_pt_packet(priv->ptport, psmouse->packet);
+			else
+				synaptics_process_packet(psmouse);
+
+			psmouse->pktcnt = 0;
+		}
+		break;
+	}
+	return;
+
+ bad_sync:
+	priv->out_of_sync++;
+	psmouse->pktcnt = 0;
+	if (psmouse_resetafter > 0 && priv->out_of_sync	== psmouse_resetafter) {
+		psmouse->state = PSMOUSE_IGNORE;
+		serio_rescan(psmouse->serio);
 	}
 }

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

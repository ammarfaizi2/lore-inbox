Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVA3KhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVA3KhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 05:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVA3KhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 05:37:16 -0500
Received: from av1-2-sn4.m-sp.skanova.net ([81.228.10.115]:52683 "EHLO
	av1-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261669AbVA3Kgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 05:36:50 -0500
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/4] Add support for Synaptics touchpad scroll wheels
References: <m34qgz9pj5.fsf@telia.com> <m3zmyr8avm.fsf@telia.com>
	<m3vf9f8asf.fsf_-_@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 30 Jan 2005 11:36:48 +0100
In-Reply-To: <m3vf9f8asf.fsf_-_@telia.com>
Message-ID: <m3r7k38apr.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some Synaptics touchpads have a middle mouse button that also works as
a scroll wheel.  Scroll data is reported as packets with w == 2 and
the scroll amount in byte 1, treated as a signed character.  For some
reason, the smallest possible wheel movement is reported as a scroll
amount of 4 units.  This amount is typically spread out over more than
one packet, so the driver has to accumulate scroll delta values to
correctly deal with this.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/input/mouse/synaptics.c |   28 +++++++++++++++++++++++++--
 linux-petero/drivers/input/mouse/synaptics.h |    2 +
 2 files changed, 28 insertions(+), 2 deletions(-)

diff -puN drivers/input/mouse/synaptics.c~synaptics-scroll-wheel drivers/input/mouse/synaptics.c
--- linux/drivers/input/mouse/synaptics.c~synaptics-scroll-wheel	2005-01-30 11:22:34.000000000 +0100
+++ linux-petero/drivers/input/mouse/synaptics.c	2005-01-30 11:22:34.000000000 +0100
@@ -322,8 +322,11 @@ static void synaptics_parse_hw_state(uns
 		hw->left  = (buf[0] & 0x01) ? 1 : 0;
 		hw->right = (buf[0] & 0x02) ? 1 : 0;
 
-		if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
+		if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities)) {
 			hw->middle = ((buf[0] ^ buf[3]) & 0x01) ? 1 : 0;
+			if (hw->w == 2)
+				hw->scroll = (signed char)(buf[1]);
+		}
 
 		if (SYN_CAP_FOUR_BUTTON(priv->capabilities)) {
 			hw->up   = ((buf[0] ^ buf[3]) & 0x01) ? 1 : 0;
@@ -379,6 +382,26 @@ static void synaptics_process_packet(str
 
 	synaptics_parse_hw_state(psmouse->packet, priv, &hw);
 
+	if (hw.scroll) {
+		priv->scroll += hw.scroll;
+
+		while (priv->scroll >= 4) {
+			input_report_key(dev, BTN_BACK, !hw.down);
+			input_sync(dev);
+			input_report_key(dev, BTN_BACK, hw.down);
+			input_sync(dev);
+			priv->scroll -= 4;
+		}
+		while (priv->scroll <= -4) {
+			input_report_key(dev, BTN_FORWARD, !hw.up);
+			input_sync(dev);
+			input_report_key(dev, BTN_FORWARD, hw.up);
+			input_sync(dev);
+			priv->scroll += 4;
+		}
+		return;
+	}
+
 	if (hw.z > 0) {
 		num_fingers = 1;
 		finger_width = 5;
@@ -528,7 +551,8 @@ static void set_input_params(struct inpu
 	if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
 		set_bit(BTN_MIDDLE, dev->keybit);
 
-	if (SYN_CAP_FOUR_BUTTON(priv->capabilities)) {
+	if (SYN_CAP_FOUR_BUTTON(priv->capabilities) ||
+	    SYN_CAP_MIDDLE_BUTTON(priv->capabilities)) {
 		set_bit(BTN_FORWARD, dev->keybit);
 		set_bit(BTN_BACK, dev->keybit);
 	}
diff -puN drivers/input/mouse/synaptics.h~synaptics-scroll-wheel drivers/input/mouse/synaptics.h
--- linux/drivers/input/mouse/synaptics.h~synaptics-scroll-wheel	2005-01-30 11:22:34.000000000 +0100
+++ linux-petero/drivers/input/mouse/synaptics.h	2005-01-30 11:22:34.000000000 +0100
@@ -92,6 +92,7 @@ struct synaptics_hw_state {
 	unsigned int up:1;
 	unsigned int down:1;
 	unsigned char ext_buttons;
+	signed char scroll;
 };
 
 struct synaptics_data {
@@ -103,6 +104,7 @@ struct synaptics_data {
 
 	unsigned char pkt_type;			/* packet type - old, new, etc */
 	unsigned char mode;			/* current mode byte */
+	int scroll;
 };
 
 #endif /* _SYNAPTICS_H */
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340

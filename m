Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264579AbUFGL6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264579AbUFGL6f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 07:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUFGLzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 07:55:52 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:52864 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264479AbUFGLzZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:25 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093521452@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1086609352170@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:52 +0200
Subject: [PATCH 5/39] input: Support Synaptics touchpads that have separate middle button
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.753.12, 2004-04-23 02:32:22-05:00, dtor_core@ameritech.net
  Input: support Synaptics touchpads that have separate middle button


 synaptics.c |   11 +++++++++++
 synaptics.h |    2 ++
 2 files changed, 13 insertions(+)

===================================================================

diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-06-07 13:13:27 +02:00
+++ b/drivers/input/mouse/synaptics.c	2004-06-07 13:13:27 +02:00
@@ -184,6 +184,8 @@
 		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
 			printk(KERN_INFO " -> %d multi-buttons, i.e. besides standard buttons\n",
 			       (int)(SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)));
+		if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
+			printk(KERN_INFO " -> middle button\n");
 		if (SYN_CAP_FOUR_BUTTON(priv->capabilities))
 			printk(KERN_INFO " -> four buttons\n");
 		if (SYN_CAP_MULTIFINGER(priv->capabilities))
@@ -342,6 +344,9 @@
 	set_bit(BTN_LEFT, dev->keybit);
 	set_bit(BTN_RIGHT, dev->keybit);
 
+	if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
+		set_bit(BTN_MIDDLE, dev->keybit);
+
 	if (SYN_CAP_FOUR_BUTTON(priv->capabilities)) {
 		set_bit(BTN_FORWARD, dev->keybit);
 		set_bit(BTN_BACK, dev->keybit);
@@ -470,6 +475,9 @@
 		hw->left  = (buf[0] & 0x01) ? 1 : 0;
 		hw->right = (buf[0] & 0x02) ? 1 : 0;
 
+		if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
+			hw->middle = ((buf[0] ^ buf[3]) & 0x01) ? 1 : 0;
+
 		if (SYN_CAP_FOUR_BUTTON(priv->capabilities)) {
 			hw->up   = ((buf[0] ^ buf[3]) & 0x01) ? 1 : 0;
 			hw->down = ((buf[0] ^ buf[3]) & 0x02) ? 1 : 0;
@@ -568,6 +576,9 @@
 
 	input_report_key(dev, BTN_LEFT, hw.left);
 	input_report_key(dev, BTN_RIGHT, hw.right);
+
+	if (SYN_CAP_MIDDLE_BUTTON(priv->capabilities))
+		input_report_key(dev, BTN_MIDDLE, hw.middle);
 
 	if (SYN_CAP_FOUR_BUTTON(priv->capabilities)) {
 		input_report_key(dev, BTN_FORWARD, hw.up);
diff -Nru a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
--- a/drivers/input/mouse/synaptics.h	2004-06-07 13:13:27 +02:00
+++ b/drivers/input/mouse/synaptics.h	2004-06-07 13:13:27 +02:00
@@ -44,6 +44,7 @@
 
 /* synaptics capability bits */
 #define SYN_CAP_EXTENDED(c)		((c) & (1 << 23))
+#define SYN_CAP_MIDDLE_BUTTON(c)	((c) & (1 << 18))
 #define SYN_CAP_PASS_THROUGH(c)		((c) & (1 << 7))
 #define SYN_CAP_SLEEP(c)		((c) & (1 << 4))
 #define SYN_CAP_FOUR_BUTTON(c)		((c) & (1 << 3))
@@ -88,6 +89,7 @@
 	int w;
 	unsigned int left:1;
 	unsigned int right:1;
+	unsigned int middle:1;
 	unsigned int up:1;
 	unsigned int down:1;
 	unsigned char ext_buttons;


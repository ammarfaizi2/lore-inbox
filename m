Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264972AbUDUGbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264972AbUDUGbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbUDUGHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:07:16 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:35500 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264978AbUDUGFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:41 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/15] New set of input patches: synaptics middle button support
Date: Wed, 21 Apr 2004 00:51:06 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210051.08554.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1903, 2004-04-20 22:23:47-05:00, dtor_core@ameritech.net
  Input: support Synaptics touchpads that have separate middle button


 synaptics.c |   11 +++++++++++
 synaptics.h |    2 ++
 2 files changed, 13 insertions(+)


===================================================================



diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Tue Apr 20 22:57:07 2004
+++ b/drivers/input/mouse/synaptics.c	Tue Apr 20 22:57:07 2004
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
--- a/drivers/input/mouse/synaptics.h	Tue Apr 20 22:57:07 2004
+++ b/drivers/input/mouse/synaptics.h	Tue Apr 20 22:57:07 2004
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

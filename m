Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTIYQuu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbTIYQut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:50:49 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:36055 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261506AbTIYQu3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:50:29 -0400
Subject: [PATCH 2/8] Fix multibutton handling in synaptics.c.
In-Reply-To: <1064508612452@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 25 Sep 2003 18:50:12 +0200
Message-Id: <1064508612553@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, dtor_core@ameritech.net, petero2@telia.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1342, 2003-09-25 18:18:59+02:00, dtor_core@ameritech.net
  input: Fix multibutton handling in Synaptics.c (nExtBtn > 8 case)


 synaptics.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Thu Sep 25 18:37:42 2003
+++ b/drivers/input/mouse/synaptics.c	Thu Sep 25 18:37:42 2003
@@ -164,7 +164,8 @@
 
 	if (SYN_CAP_EXTENDED(priv->capabilities)) {
 		printk(KERN_INFO " Touchpad has extended capability bits\n");
-		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
+		if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) &&
+		    SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) <= 8)
 			printk(KERN_INFO " -> %d multi-buttons, i.e. besides standard buttons\n",
 			       (int)(SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap)));
 		else if (SYN_CAP_FOUR_BUTTON(priv->capabilities))
@@ -352,7 +353,11 @@
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
@@ -437,7 +442,11 @@
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
@@ -516,7 +525,11 @@
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


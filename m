Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUCPPUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUCPOlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:41:32 -0500
Received: from styx.suse.cz ([82.208.2.94]:57473 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261907AbUCPOTg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:36 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446776784@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 8/44] Don't reinitialize scancode map after sleep in atkbd.c
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:36 +0100
In-Reply-To: <10794467763238@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1474.188.8, 2004-01-26 13:29:36+01:00, vojtech@suse.cz
  input: Bail out in atkbd.c if scancode set is changed, don't
         reinitialize scancode map. This is even more anoying than
         a new keyboard device in the unlikely case of set change.


 atkbd.c |   38 ++++++--------------------------------
 1 files changed, 6 insertions(+), 32 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Mar 16 13:19:50 2004
+++ b/drivers/input/keyboard/atkbd.c	Tue Mar 16 13:19:50 2004
@@ -741,45 +741,19 @@
 {
 	struct atkbd *atkbd = serio->private;
 	struct serio_dev *dev = serio->dev;
-	int i;
 
-        if (!dev) {
-                printk(KERN_DEBUG "atkbd: reconnect request, but serio is disconnected, ignoring...\n");
-                return -1;
-        }
+	if (!dev) {
+		printk(KERN_DEBUG "atkbd: reconnect request, but serio is disconnected, ignoring...\n");
+		return -1;
+	}
 
 	if (atkbd->write) {
 		if (atkbd_probe(atkbd))
 			return -1;
-
-		atkbd->set = atkbd_set_3(atkbd);
+		if (atkbd->set != atkbd_set_3(atkbd))
+			return -1;
 		atkbd_enable(atkbd);
-	} else {
-		atkbd->set = 2;
-		atkbd->id = 0xab00;
 	}
-
-	/*
-	 * Here we probably should check if the keyboard has the same set that
-         * it had before and bail out if it's different. But this will most likely
-         * cause new keyboard device be created... and for the user it will look
-         * like keyboard is lost
-	 */
-
-	if (atkbd->translated) {
-		for (i = 0; i < 128; i++) {
-			atkbd->keycode[i] = atkbd_set2_keycode[atkbd_unxlate_table[i]];
-			atkbd->keycode[i | 0x80] = atkbd_set2_keycode[atkbd_unxlate_table[i] | 0x80];
-		}
-	} else if (atkbd->set == 2) {
-		memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
-	} else {
-		memcpy(atkbd->keycode, atkbd_set3_keycode, sizeof(atkbd->keycode));
-	}
-
-	for (i = 0; i < 512; i++)
-		if (atkbd->keycode[i] && atkbd->keycode[i] < 255)
-			set_bit(atkbd->keycode[i], atkbd->dev.keybit);
 
 	return 0;
 }


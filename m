Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265821AbTIJWQU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265820AbTIJWOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:14:46 -0400
Received: from hera.cwi.nl ([192.16.191.8]:27050 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265817AbTIJWOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:14:22 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 11 Sep 2003 00:14:08 +0200 (MEST)
Message-Id: <UTC200309102214.h8AME8l06380.aeb@smtp.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] another keyboard problem solved
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A colleague reported that the keyboard of his brandnew laptop
is dead under 2.6 while 2.4 works.

Now I once wrote

  In order to avoid interference between scancode sequences
  or mouse packets and the reponses given to commands,
  the keyboard or mouse should always be disabled before
  giving a command that requires a response, and probably
  enabled afterwards. Some keyboards or mice do the disable
  automatically in this situation, but still require an
  explicit enable afterwards. 

(http://www.win.tue.nl/~aeb/linux/kbd/scancodes-9.html)

This is what happens on this laptop. The routine atkbd_probe()
probes for a keyboard, and after detecting it, enables it.
But immediately afterwards the routine atkbd_set_3() reads
the current scancode set and sets the desired set, and as a
side effect of these commands, the keyboard gets disabled again.

Thus, the keyboard enable must be moved after all command sending
has been done.

Now that I patch this area anyway: we are almost always in
scancode set 2 but send the ATKBD_CMD_SETALL_MB command
that only works in scancode set 3. At best this is useless.
At worst it confuses the keyboard. So, I put this command
in a separate routine and call that only when we really
are in scancode set 3.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Mon Jun 23 04:43:32 2003
+++ b/drivers/input/keyboard/atkbd.c	Wed Sep 10 23:24:13 2003
@@ -322,6 +322,16 @@
 }
 
 /*
+ * Enable keyboard.
+ */
+static void atkbd_enable(struct atkbd *atkbd)
+{
+	if (atkbd_command(atkbd, NULL, ATKBD_CMD_ENABLE))
+		printk(KERN_ERR "atkbd.c: Failed to enable keyboard on %s\n",
+		       atkbd->serio->phys);
+}
+
+/*
  * atkbd_set_3 checks if a keyboard has a working Set 3 support, and
  * sets it into that. Unfortunately there are keyboards that can be switched
  * to Set 3, but don't work well in that (BTC Multimedia ...)
@@ -399,7 +409,9 @@
 
 	if (atkbd_reset)
 		if (atkbd_command(atkbd, NULL, ATKBD_CMD_RESET_BAT)) 
-			printk(KERN_WARNING "atkbd.c: keyboard reset failed on %s\n", atkbd->serio->phys);
+			printk(KERN_WARNING
+			       "atkbd.c: keyboard reset failed on %s\n",
+			       atkbd->serio->phys);
 
 /*
  * Then we check the keyboard ID. We should get 0xab83 under normal conditions.
@@ -433,24 +445,20 @@
 	if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
 		return -1;
 
+	return 0;
+}
+
 /*
  * Disable autorepeat. We don't need it, as we do it in software anyway,
  * because that way can get faster repeat, and have less system load (less
  * accesses to the slow ISA hardware). If this fails, we don't care, and will
  * just ignore the repeated keys.
+ *
+ * This command is for scancode set 3 only.
  */
-
+static void atkbd_disable_autorepeat(struct atkbd *atkbd)
+{
 	atkbd_command(atkbd, NULL, ATKBD_CMD_SETALL_MB);
-
-/*
- * Last, we enable the keyboard to make sure  that we get keypresses from it.
- */
-
-	if (atkbd_command(atkbd, NULL, ATKBD_CMD_ENABLE))
-		printk(KERN_ERR "atkbd.c: Failed to enable keyboard on %s\n",
-			atkbd->serio->phys);
-
-	return 0;
 }
 
 /*
@@ -477,7 +485,7 @@
 }
 
 /*
- * atkbd_connect() is called when the serio module finds and interface
+ * atkbd_connect() is called when the serio module finds an interface
  * that isn't handled yet by an appropriate device driver. We check if
  * there is an AT keyboard out there and if yes, we register ourselves
  * to the input module.
@@ -531,7 +539,9 @@
 		}
 		
 		atkbd->set = atkbd_set_3(atkbd);
-
+		if (atkbd->set == 3)
+			atkbd_disable_autorepeat(atkbd);
+		atkbd_enable(atkbd);
 	} else {
 		atkbd->set = 2;
 		atkbd->id = 0xab00;

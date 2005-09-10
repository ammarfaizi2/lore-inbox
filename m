Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbVIJWeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVIJWeR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbVIJWeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:10 -0400
Received: from styx.suse.cz ([82.119.242.94]:30116 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932353AbVIJWdv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:51 -0400
Subject: [PATCH 8/26] i8042 - fix IRQ printing when either KBD or AUX port
In-Reply-To: <11263916522920@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:12 +0200
Message-Id: <11263916522684@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: i8042 - fix IRQ printing when either KBD or AUX port
From: Dmitry Torokhov <dtor_core@ameritech.net>
Date: 1125816111 -0500
       is absent from ACPI/PNP tables.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/input/serio/i8042-x86ia64io.h |   39 +++++++++++++++++++++------------
 1 files changed, 25 insertions(+), 14 deletions(-)

c3d31e7f9a94800ba895a081e143e79954f6c62f
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -258,7 +258,8 @@ static void i8042_pnp_exit(void)
 
 static int __init i8042_pnp_init(void)
 {
-	int result_kbd, result_aux;
+	int result_kbd = 0, result_aux = 0;
+	char kbd_irq_str[4] = { 0 }, aux_irq_str[4] = { 0 };
 
 	if (i8042_nopnp) {
 		printk(KERN_INFO "i8042: PNP detection disabled\n");
@@ -267,6 +268,7 @@ static int __init i8042_pnp_init(void)
 
 	if ((result_kbd = pnp_register_driver(&i8042_pnp_kbd_driver)) >= 0)
 		i8042_pnp_kbd_registered = 1;
+
 	if ((result_aux = pnp_register_driver(&i8042_pnp_aux_driver)) >= 0)
 		i8042_pnp_aux_registered = 1;
 
@@ -280,6 +282,25 @@ static int __init i8042_pnp_init(void)
 #endif
 	}
 
+	if (result_kbd > 0)
+		snprintf(kbd_irq_str, sizeof(kbd_irq_str),
+			"%d", i8042_pnp_kbd_irq);
+	if (result_aux > 0)
+		snprintf(aux_irq_str, sizeof(aux_irq_str),
+			"%d", i8042_pnp_aux_irq);
+
+	printk(KERN_INFO "PNP: PS/2 Controller [%s%s%s] at %#x,%#x irq %s%s%s\n",
+		i8042_pnp_kbd_name, (result_kbd > 0 && result_aux > 0) ? "," : "",
+		i8042_pnp_aux_name,
+		i8042_pnp_data_reg, i8042_pnp_command_reg,
+		kbd_irq_str, (result_kbd > 0 && result_aux > 0) ? "," : "",
+		aux_irq_str);
+
+#if defined(__ia64__)
+	if (result_aux <= 0)
+		i8042_noaux = 1;
+#endif
+
 	if (((i8042_pnp_data_reg & ~0xf) == (i8042_data_reg & ~0xf) &&
 	      i8042_pnp_data_reg != i8042_data_reg) || !i8042_pnp_data_reg) {
 		printk(KERN_WARNING "PNP: PS/2 controller has invalid data port %#x; using default %#x\n",
@@ -295,30 +316,20 @@ static int __init i8042_pnp_init(void)
 	}
 
 	if (!i8042_pnp_kbd_irq) {
-		printk(KERN_WARNING "PNP: PS/2 controller doesn't have KBD irq; using default %#x\n", i8042_kbd_irq);
+		printk(KERN_WARNING "PNP: PS/2 controller doesn't have KBD irq; using default %d\n", i8042_kbd_irq);
 		i8042_pnp_kbd_irq = i8042_kbd_irq;
 	}
 
-	if (!i8042_pnp_aux_irq) {
-		printk(KERN_WARNING "PNP: PS/2 controller doesn't have AUX irq; using default %#x\n", i8042_aux_irq);
+	if (!i8042_noaux && !i8042_pnp_aux_irq) {
+		printk(KERN_WARNING "PNP: PS/2 controller doesn't have AUX irq; using default %d\n", i8042_aux_irq);
 		i8042_pnp_aux_irq = i8042_aux_irq;
 	}
 
-#if defined(__ia64__)
-	if (result_aux <= 0)
-		i8042_noaux = 1;
-#endif
-
 	i8042_data_reg = i8042_pnp_data_reg;
 	i8042_command_reg = i8042_pnp_command_reg;
 	i8042_kbd_irq = i8042_pnp_kbd_irq;
 	i8042_aux_irq = i8042_pnp_aux_irq;
 
-	printk(KERN_INFO "PNP: PS/2 Controller [%s%s%s] at %#x,%#x irq %d%s%d\n",
-		i8042_pnp_kbd_name, (result_kbd > 0 && result_aux > 0) ? "," : "", i8042_pnp_aux_name,
-		i8042_data_reg, i8042_command_reg, i8042_kbd_irq,
-		(result_aux > 0) ? "," : "", i8042_aux_irq);
-
 	return 0;
 }
 


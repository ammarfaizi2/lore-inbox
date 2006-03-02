Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWCBXKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWCBXKS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWCBXKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:10:00 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:60591 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751203AbWCBXJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:09:44 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH 6/9] i8042: adjust pnp_register_driver signature
Date: Thu, 2 Mar 2006 16:09:42 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-input@atrey.karlin.mff.cuni.cz
References: <200603021601.27467.bjorn.helgaas@hp.com>
In-Reply-To: <200603021601.27467.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021609.42272.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_driver() returns the number of
devices claimed.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- work-mm4.orig/drivers/input/serio/i8042-x86ia64io.h	2006-03-02 12:40:45.000000000 -0700
+++ work-mm4/drivers/input/serio/i8042-x86ia64io.h	2006-03-02 12:45:21.000000000 -0700
@@ -192,7 +192,9 @@
 #include <linux/pnp.h>
 
 static int i8042_pnp_kbd_registered;
+static unsigned int i8042_pnp_kbd_devices;
 static int i8042_pnp_aux_registered;
+static unsigned int i8042_pnp_aux_devices;
 
 static int i8042_pnp_command_reg;
 static int i8042_pnp_data_reg;
@@ -219,6 +221,7 @@
 		strncat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
 	}
 
+	i8042_pnp_kbd_devices++;
 	return 0;
 }
 
@@ -239,6 +242,7 @@
 		strncat(i8042_pnp_aux_name, pnp_dev_name(dev), sizeof(i8042_pnp_aux_name));
 	}
 
+	i8042_pnp_aux_devices++;
 	return 0;
 }
 
@@ -287,21 +291,23 @@
 
 static int __init i8042_pnp_init(void)
 {
-	int result_kbd = 0, result_aux = 0;
 	char kbd_irq_str[4] = { 0 }, aux_irq_str[4] = { 0 };
+	int err;
 
 	if (i8042_nopnp) {
 		printk(KERN_INFO "i8042: PNP detection disabled\n");
 		return 0;
 	}
 
-	if ((result_kbd = pnp_register_driver(&i8042_pnp_kbd_driver)) >= 0)
+	err = pnp_register_driver(&i8042_pnp_kbd_driver);
+	if (!err)
 		i8042_pnp_kbd_registered = 1;
 
-	if ((result_aux = pnp_register_driver(&i8042_pnp_aux_driver)) >= 0)
+	err = pnp_register_driver(&i8042_pnp_aux_driver);
+	if (!err)
 		i8042_pnp_aux_registered = 1;
 
-	if (result_kbd <= 0 && result_aux <= 0) {
+	if (!i8042_pnp_kbd_devices && !i8042_pnp_aux_devices) {
 		i8042_pnp_exit();
 #if defined(__ia64__)
 		return -ENODEV;
@@ -311,24 +317,24 @@
 #endif
 	}
 
-	if (result_kbd > 0)
+	if (i8042_pnp_kbd_devices)
 		snprintf(kbd_irq_str, sizeof(kbd_irq_str),
 			"%d", i8042_pnp_kbd_irq);
-	if (result_aux > 0)
+	if (i8042_pnp_aux_devices)
 		snprintf(aux_irq_str, sizeof(aux_irq_str),
 			"%d", i8042_pnp_aux_irq);
 
 	printk(KERN_INFO "PNP: PS/2 Controller [%s%s%s] at %#x,%#x irq %s%s%s\n",
-		i8042_pnp_kbd_name, (result_kbd > 0 && result_aux > 0) ? "," : "",
+		i8042_pnp_kbd_name, (i8042_pnp_kbd_devices && i8042_pnp_aux_devices) ? "," : "",
 		i8042_pnp_aux_name,
 		i8042_pnp_data_reg, i8042_pnp_command_reg,
-		kbd_irq_str, (result_kbd > 0 && result_aux > 0) ? "," : "",
+		kbd_irq_str, (i8042_pnp_kbd_devices && i8042_pnp_aux_devices) ? "," : "",
 		aux_irq_str);
 
 #if defined(__ia64__)
-	if (result_kbd <= 0)
+	if (!i8042_pnp_kbd_devices)
 		i8042_nokbd = 1;
-	if (result_aux <= 0)
+	if (!i8042_pnp_aux_devices)
 		i8042_noaux = 1;
 #endif
 

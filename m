Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVIJWkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVIJWkF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVIJWeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:03 -0400
Received: from styx.suse.cz ([82.119.242.94]:24996 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932347AbVIJWdu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:50 -0400
Subject: [PATCH 9/26] i8042 - add i8042.nokbd module option to allow supressing
In-Reply-To: <11263916522684@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:12 +0200
Message-Id: <1126391652208@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: i8042 - add i8042.nokbd module option to allow supressing
From: Dmitry Torokhov <dtor_core@ameritech.net>
Date: 1125816120 -0500
       creation of keyboard port.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 Documentation/kernel-parameters.txt   |    1 +
 drivers/input/serio/i8042-x86ia64io.h |    4 +++-
 drivers/input/serio/i8042.c           |   22 ++++++++++++++++++----
 3 files changed, 22 insertions(+), 5 deletions(-)

945ef0d428bc33c639e49d27fb8cc765adec3fdf
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -549,6 +549,7 @@ running once the system is up.
 			     keyboard and can not control its state
 			     (Don't attempt to blink the leds)
 	i8042.noaux	[HW] Don't check for auxiliary (== mouse) port
+	i8042.nokbd	[HW] Don't check/create keyboard port
 	i8042.nomux	[HW] Don't check presence of an active multiplexing
 			     controller
 	i8042.nopnp	[HW] Don't use ACPIPnP / PnPBIOS to discover KBD/AUX
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -297,6 +297,8 @@ static int __init i8042_pnp_init(void)
 		aux_irq_str);
 
 #if defined(__ia64__)
+	if (result_kbd <= 0)
+		i8042_nokbd = 1;
 	if (result_aux <= 0)
 		i8042_noaux = 1;
 #endif
@@ -315,7 +317,7 @@ static int __init i8042_pnp_init(void)
 		i8042_pnp_command_reg = i8042_command_reg;
 	}
 
-	if (!i8042_pnp_kbd_irq) {
+	if (!i8042_nokbd && !i8042_pnp_kbd_irq) {
 		printk(KERN_WARNING "PNP: PS/2 controller doesn't have KBD irq; using default %d\n", i8042_kbd_irq);
 		i8042_pnp_kbd_irq = i8042_kbd_irq;
 	}
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -27,6 +27,10 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@s
 MODULE_DESCRIPTION("i8042 keyboard and mouse controller driver");
 MODULE_LICENSE("GPL");
 
+static unsigned int i8042_nokbd;
+module_param_named(nokbd, i8042_nokbd, bool, 0);
+MODULE_PARM_DESC(nokbd, "Do not probe or use KBD port.");
+
 static unsigned int i8042_noaux;
 module_param_named(noaux, i8042_noaux, bool, 0);
 MODULE_PARM_DESC(noaux, "Do not probe or use AUX (mouse) port.");
@@ -1058,7 +1062,7 @@ static int __init i8042_create_mux_port(
 
 static int __init i8042_init(void)
 {
-	int i;
+	int i, have_ports = 0;
 	int err;
 
 	dbg_init();
@@ -1100,11 +1104,20 @@ static int __init i8042_init(void)
 			if (err)
 				goto err_unregister_ports;
 		}
+		have_ports = 1;
 	}
 
-	err = i8042_create_kbd_port();
-	if (err)
-		goto err_unregister_ports;
+	if (!i8042_nokbd) {
+		err = i8042_create_kbd_port();
+		if (err)
+			goto err_unregister_ports;
+		have_ports = 1;
+	}
+
+	if (!have_ports) {
+		err = -ENODEV;
+		goto err_unregister_device;
+	}
 
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
@@ -1114,6 +1127,7 @@ static int __init i8042_init(void)
 	for (i = 0; i < I8042_NUM_PORTS; i++)
 		if (i8042_ports[i].serio)
 			serio_unregister_port(i8042_ports[i].serio);
+ err_unregister_device:
 	platform_device_unregister(i8042_platform_device);
  err_unregister_driver:
 	driver_unregister(&i8042_driver);


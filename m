Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVIJWjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVIJWjW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVIJWeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:06 -0400
Received: from styx.suse.cz ([82.119.242.94]:27556 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932348AbVIJWdv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:51 -0400
Subject: [PATCH 7/26] make i8042_platform_init return 'real' error code
In-Reply-To: <11263916524159@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:12 +0200
Message-Id: <11263916522920@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: make i8042_platform_init return 'real' error code
From: Dmitry Torokhov <dtor_core@ameritech.net>
Date: 1125816098 -0500

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/input/serio/i8042-io.h        |    6 +++---
 drivers/input/serio/i8042-ip22io.h    |    2 +-
 drivers/input/serio/i8042-jazzio.h    |    2 +-
 drivers/input/serio/i8042-sparcio.h   |   12 ++++++------
 drivers/input/serio/i8042-x86ia64io.h |   22 ++++++++++++----------
 drivers/input/serio/i8042.c           |    5 +++--
 6 files changed, 26 insertions(+), 23 deletions(-)

8d5987a6e17fa36776a0c9964db0f24c3d070862
diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
--- a/drivers/input/serio/i8042-io.h
+++ b/drivers/input/serio/i8042-io.h
@@ -69,16 +69,16 @@ static inline int i8042_platform_init(vo
  */
 #if !defined(__sh__) && !defined(__alpha__) && !defined(__mips__) && !defined(CONFIG_PPC64)
 	if (!request_region(I8042_DATA_REG, 16, "i8042"))
-		return -1;
+		return -EBUSY;
 #endif
 
         i8042_reset = 1;
 
 #if defined(CONFIG_PPC64)
 	if (check_legacy_ioport(I8042_DATA_REG))
-		return -1;
+		return -EBUSY;
 	if (!request_region(I8042_DATA_REG, 16, "i8042"))
-		return -1;
+		return -EBUSY;
 #endif
 	return 0;
 }
diff --git a/drivers/input/serio/i8042-ip22io.h b/drivers/input/serio/i8042-ip22io.h
--- a/drivers/input/serio/i8042-ip22io.h
+++ b/drivers/input/serio/i8042-ip22io.h
@@ -58,7 +58,7 @@ static inline int i8042_platform_init(vo
 #if 0
 	/* XXX sgi_kh is a virtual address */
 	if (!request_mem_region(sgi_kh, sizeof(struct hpc_keyb), "i8042"))
-		return 1;
+		return -EBUSY;
 #endif
 
 	i8042_reset = 1;
diff --git a/drivers/input/serio/i8042-jazzio.h b/drivers/input/serio/i8042-jazzio.h
--- a/drivers/input/serio/i8042-jazzio.h
+++ b/drivers/input/serio/i8042-jazzio.h
@@ -53,7 +53,7 @@ static inline int i8042_platform_init(vo
 #if 0
 	/* XXX JAZZ_KEYBOARD_ADDRESS is a virtual address */
 	if (!request_mem_region(JAZZ_KEYBOARD_ADDRESS, 2, "i8042"))
-		return 1;
+		return -EBUSY;
 #endif
 
 	return 0;
diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -48,10 +48,10 @@ static inline void i8042_write_command(i
 #define OBP_PS2MS_NAME1		"kdmouse"
 #define OBP_PS2MS_NAME2		"mouse"
 
-static int i8042_platform_init(void)
+static int __init i8042_platform_init(void)
 {
 #ifndef CONFIG_PCI
-	return -1;
+	return -ENODEV;
 #else
 	char prop[128];
 	int len;
@@ -59,14 +59,14 @@ static int i8042_platform_init(void)
 	len = prom_getproperty(prom_root_node, "name", prop, sizeof(prop));
 	if (len < 0) {
 		printk("i8042: Cannot get name property of root OBP node.\n");
-		return -1;
+		return -ENODEV;
 	}
 	if (strncmp(prop, "SUNW,JavaStation-1", len) == 0) {
 		/* Hardcoded values for MrCoffee.  */
 		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
 		kbd_iobase = ioremap(0x71300060, 8);
 		if (!kbd_iobase)
-			return -1;
+			return -ENODEV;
 	} else {
 		struct linux_ebus *ebus;
 		struct linux_ebus_device *edev;
@@ -78,7 +78,7 @@ static int i8042_platform_init(void)
 					goto edev_found;
 			}
 		}
-		return -1;
+		return -ENODEV;
 
 	edev_found:
 		for_each_edevchild(edev, child) {
@@ -96,7 +96,7 @@ static int i8042_platform_init(void)
 		    i8042_aux_irq == -1) {
 			printk("i8042: Error, 8042 device lacks both kbd and "
 			       "mouse nodes.\n");
-			return -1;
+			return -ENODEV;
 		}
 	}
 
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -256,7 +256,7 @@ static void i8042_pnp_exit(void)
 	}
 }
 
-static int i8042_pnp_init(void)
+static int __init i8042_pnp_init(void)
 {
 	int result_kbd, result_aux;
 
@@ -322,25 +322,29 @@ static int i8042_pnp_init(void)
 	return 0;
 }
 
+#else
+static inline int i8042_pnp_init(void) { return 0; }
+static inline void i8042_pnp_exit(void) { }
 #endif
 
-static inline int i8042_platform_init(void)
+static int __init i8042_platform_init(void)
 {
+	int retval;
+
 /*
  * On ix86 platforms touching the i8042 data register region can do really
  * bad things. Because of this the region is always reserved on ix86 boxes.
  *
  *	if (!request_region(I8042_DATA_REG, 16, "i8042"))
- *		return -1;
+ *		return -EBUSY;
  */
 
 	i8042_kbd_irq = I8042_MAP_IRQ(1);
 	i8042_aux_irq = I8042_MAP_IRQ(12);
 
-#ifdef CONFIG_PNP
-	if (i8042_pnp_init())
-		return -1;
-#endif
+	retval = i8042_pnp_init();
+	if (retval)
+		return retval;
 
 #if defined(__ia64__)
         i8042_reset = 1;
@@ -354,14 +358,12 @@ static inline int i8042_platform_init(vo
 		i8042_nomux = 1;
 #endif
 
-	return 0;
+	return retval;
 }
 
 static inline void i8042_platform_exit(void)
 {
-#ifdef CONFIG_PNP
 	i8042_pnp_exit();
-#endif
 }
 
 #endif /* _I8042_X86IA64IO_H */
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1066,8 +1066,9 @@ static int __init i8042_init(void)
 	init_timer(&i8042_timer);
 	i8042_timer.function = i8042_timer_func;
 
-	if (i8042_platform_init())
-		return -EBUSY;
+	err = i8042_platform_init();
+	if (err)
+		return err;
 
 	i8042_ports[I8042_AUX_PORT_NO].irq = I8042_AUX_IRQ;
 	i8042_ports[I8042_KBD_PORT_NO].irq = I8042_KBD_IRQ;


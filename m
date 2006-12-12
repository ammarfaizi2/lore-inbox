Return-Path: <linux-kernel-owner+w=401wt.eu-S1751533AbWLLScd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWLLScd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWLLScd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:32:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:36444 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbWLLScb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:32:31 -0500
Date: Tue, 12 Dec 2006 13:32:29 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] remove config ordering/dependency between ucb1400-ts and sound
 subsystem
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       Dmitry Torokhov <dtor@insightbb.com>,
       lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0612121322040.18171@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Commit 2d4ba4a3b9aef95d328d74a17ae84f8d658059e2 introduced a dependency
that was never meant to exist when the ac97_bus.c module was created.
Move ac97_bus.c up the directory hierarchy to make sure it is built when 
selected even if sound is configured out so things work as originally 
intended.

Signed-off-by: Nicolas Pitre <nico@cam.org>
Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

---

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 3d5f196..6b46c9b 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -146,7 +146,7 @@ config TOUCHSCREEN_TOUCHWIN
 
 config TOUCHSCREEN_UCB1400
 	tristate "Philips UCB1400 touchscreen"
-	depends on SND_AC97_BUS
+	select AC97_BUS
 	help
 	  This enables support for the Philips UCB1400 touchscreen interface.
 	  The UCB1400 is an AC97 audio codec.  The touchscreen interface
diff --git a/sound/Kconfig b/sound/Kconfig
index 95949b6..9d77300 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -93,4 +93,12 @@ endmenu
 
 endif
 
+config AC97_BUS
+	tristate
+	help
+	  This is used to avoid config and link hard dependencies between the
+	  sound subsystem and other function drivers completely unrelated to
+	  sound although they're sharing the AC97 bus. Concerned drivers
+	  should "select" this.
+
 endmenu
diff --git a/sound/Makefile b/sound/Makefile
index 5f6bef5..9aee54c 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -8,6 +8,9 @@ obj-$(CONFIG_DMASOUND) += oss/
 obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/
 obj-$(CONFIG_SND_AOA) += aoa/
 
+# This one must be compilable even if sound is configured out
+obj-$(CONFIG_AC97_BUS) += ac97_bus.o
+
 ifeq ($(CONFIG_SND),y)
   obj-y += last.o
 endif
diff --git a/sound/ac97_bus.c b/sound/ac97_bus.c
new file mode 100644
index 0000000..66de2c2
--- /dev/null
+++ b/sound/ac97_bus.c
@@ -0,0 +1,72 @@
+/*
+ * Linux driver model AC97 bus interface
+ *
+ * Author:	Nicolas Pitre
+ * Created:	Jan 14, 2005
+ * Copyright:	(C) MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/string.h>
+
+/*
+ * Let drivers decide whether they want to support given codec from their
+ * probe method.  Drivers have direct access to the struct snd_ac97 structure and may
+ * decide based on the id field amongst other things.
+ */
+static int ac97_bus_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
+static int ac97_bus_suspend(struct device *dev, pm_message_t state)
+{
+	int ret = 0;
+
+	if (dev->driver && dev->driver->suspend)
+		ret = dev->driver->suspend(dev, state);
+
+	return ret;
+}
+
+static int ac97_bus_resume(struct device *dev)
+{
+	int ret = 0;
+
+	if (dev->driver && dev->driver->resume)
+		ret = dev->driver->resume(dev);
+
+	return ret;
+}
+
+struct bus_type ac97_bus_type = {
+	.name		= "ac97",
+	.match		= ac97_bus_match,
+	.suspend	= ac97_bus_suspend,
+	.resume		= ac97_bus_resume,
+};
+
+static int __init ac97_bus_init(void)
+{
+	return bus_register(&ac97_bus_type);
+}
+
+subsys_initcall(ac97_bus_init);
+
+static void __exit ac97_bus_exit(void)
+{
+	bus_unregister(&ac97_bus_type);
+}
+
+module_exit(ac97_bus_exit);
+
+EXPORT_SYMBOL(ac97_bus_type);
+
+MODULE_LICENSE("GPL");
diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index 7971285..40ebd2f 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -26,11 +26,7 @@ config SND_VX_LIB
 config SND_AC97_CODEC
 	tristate
 	select SND_PCM
-	select SND_AC97_BUS
-
-config SND_AC97_BUS
-	tristate
-
+	select AC97_BUS
 
 config SND_DUMMY
 	tristate "Dummy (/dev/null) soundcard"
diff --git a/sound/pci/ac97/Makefile b/sound/pci/ac97/Makefile
index 77b3482..3c32221 100644
--- a/sound/pci/ac97/Makefile
+++ b/sound/pci/ac97/Makefile
@@ -10,11 +10,9 @@ snd-ac97-codec-objs += ac97_proc.o
 endif
 
 snd-ak4531-codec-objs := ak4531_codec.o
-snd-ac97-bus-objs := ac97_bus.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_AC97_CODEC) += snd-ac97-codec.o
 obj-$(CONFIG_SND_ENS1370) += snd-ak4531-codec.o
-obj-$(CONFIG_SND_AC97_BUS) += snd-ac97-bus.o
 
 obj-m := $(sort $(obj-m))
diff --git a/sound/pci/ac97/ac97_bus.c b/sound/pci/ac97/ac97_bus.c
deleted file mode 100644
index 66de2c2..0000000
--- a/sound/pci/ac97/ac97_bus.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * Linux driver model AC97 bus interface
- *
- * Author:	Nicolas Pitre
- * Created:	Jan 14, 2005
- * Copyright:	(C) MontaVista Software Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/string.h>
-
-/*
- * Let drivers decide whether they want to support given codec from their
- * probe method.  Drivers have direct access to the struct snd_ac97 structure and may
- * decide based on the id field amongst other things.
- */
-static int ac97_bus_match(struct device *dev, struct device_driver *drv)
-{
-	return 1;
-}
-
-static int ac97_bus_suspend(struct device *dev, pm_message_t state)
-{
-	int ret = 0;
-
-	if (dev->driver && dev->driver->suspend)
-		ret = dev->driver->suspend(dev, state);
-
-	return ret;
-}
-
-static int ac97_bus_resume(struct device *dev)
-{
-	int ret = 0;
-
-	if (dev->driver && dev->driver->resume)
-		ret = dev->driver->resume(dev);
-
-	return ret;
-}
-
-struct bus_type ac97_bus_type = {
-	.name		= "ac97",
-	.match		= ac97_bus_match,
-	.suspend	= ac97_bus_suspend,
-	.resume		= ac97_bus_resume,
-};
-
-static int __init ac97_bus_init(void)
-{
-	return bus_register(&ac97_bus_type);
-}
-
-subsys_initcall(ac97_bus_init);
-
-static void __exit ac97_bus_exit(void)
-{
-	bus_unregister(&ac97_bus_type);
-}
-
-module_exit(ac97_bus_exit);
-
-EXPORT_SYMBOL(ac97_bus_type);
-
-MODULE_LICENSE("GPL");

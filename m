Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270677AbTHFUEK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270759AbTHFUEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:04:10 -0400
Received: from vitelus.com ([64.81.243.207]:39085 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S270677AbTHFUDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:03:06 -0400
Date: Wed, 6 Aug 2003 12:59:31 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: Synaptics driver considered harmful
Message-ID: <20030806195931.GE2712@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why isn't there a config option for this driver? I just tried to
upgrade to CVS HEAD (bkcvs) from a 2.4 kernel and everything went
smoothly except my mouse didn't work until I appended
psmouse_noext=1. This should not be necessary IMHO. It seems that even
desktop users are forced to compile in this driver, and according at
least to my experience, it can seriously break things. I don't see
what the benefits of the synaptics driver are, and it sounds like
this driver has been causing problems since it was released. The
driver may well stabilize in the future, but right now it should not
be a standard part of the PS/2 mouse driver.


Index: drivers/input/mouse/Kconfig
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/input/mouse/Kconfig,v
retrieving revision 1.8
diff -u -u -r1.8 Kconfig
--- drivers/input/mouse/Kconfig	22 Jun 2003 00:42:21 -0000	1.8
+++ drivers/input/mouse/Kconfig	6 Aug 2003 18:31:31 -0000
@@ -30,6 +30,16 @@
 	  The module will be called psmouse. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+config MOUSE_PS2_SYNAPTICS
+	bool "Synaptics touchpad driver"
+	default n
+	depends on INPUT && INPUT_MOUSE && SERIO && MOUSE_PS2
+	---help---
+	  Say Y here if you have a Synaptics touchpad and would like to use its
+	  PS/2 extensions. Saying Y here may cause problems.
+
+	  If unsure, say N.
+
 config MOUSE_SERIAL
 	tristate "Serial mouse"
 	depends on INPUT && INPUT_MOUSE && SERIO
Index: drivers/input/mouse/Makefile
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/input/mouse/Makefile,v
retrieving revision 1.8
diff -u -u -r1.8 Makefile
--- drivers/input/mouse/Makefile	22 Jun 2003 00:42:21 -0000	1.8
+++ drivers/input/mouse/Makefile	6 Aug 2003 18:31:31 -0000
@@ -12,6 +12,7 @@
 obj-$(CONFIG_MOUSE_PC110PAD)	+= pc110pad.o
 obj-$(CONFIG_MOUSE_PC9800)	+= 98busmouse.o
 obj-$(CONFIG_MOUSE_PS2)		+= psmouse.o
+obj-$(CONFIG_MOUSE_PS2_SYNAPTICS)	+= synaptics.o
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 
-psmouse-objs  := psmouse-base.o logips2pp.o synaptics.o
+psmouse-objs  := psmouse-base.o logips2pp.o
Index: drivers/input/mouse/psmouse-base.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/input/mouse/psmouse-base.c,v
retrieving revision 1.3
diff -u -u -r1.3 psmouse-base.c
--- drivers/input/mouse/psmouse-base.c	22 Jun 2003 00:42:21 -0000	1.3
+++ drivers/input/mouse/psmouse-base.c	6 Aug 2003 18:31:35 -0000
@@ -18,7 +18,9 @@
 #include <linux/serio.h>
 #include <linux/init.h>
 #include "psmouse.h"
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
 #include "synaptics.h"
+#endif
 #include "logips2pp.h"
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
@@ -145,6 +147,7 @@
 		goto out;
 	}
 
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
 	if (psmouse->pktcnt == 1 && psmouse->type == PSMOUSE_SYNAPTICS) {
 		/*
 		 * The synaptics driver has its own resync logic,
@@ -154,6 +157,7 @@
 		psmouse->pktcnt = 0;
 		goto out;
 	}
+#endif
 
 	if (psmouse->pktcnt == 1 && psmouse->packet[0] == PSMOUSE_RET_BAT) {
 		serio_rescan(serio);
@@ -250,6 +254,7 @@
 	if (psmouse_noext)
 		return PSMOUSE_PS2;
 
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
 /*
  * Try Synaptics TouchPad magic ID
  */
@@ -269,6 +274,7 @@
 		else
 			return PSMOUSE_PS2;
        }
+#endif
 
 /*
  * Try Genius NetMouse magic init.
@@ -480,7 +486,9 @@
 	struct psmouse *psmouse = serio->private;
 	input_unregister_device(&psmouse->dev);
 	serio_close(serio);
+#ifdef CONFIG_MOUSE_PS2_SYNAPTICS
 	synaptics_disconnect(psmouse);
+#endif
 	kfree(psmouse);
 }
 

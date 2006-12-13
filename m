Return-Path: <linux-kernel-owner+w=401wt.eu-S932390AbWLMEue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWLMEue (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 23:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWLMEue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 23:50:34 -0500
Received: from mouth.voxel.net ([69.9.180.118]:38744 "EHLO mail.squishy.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbWLMEuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 23:50:32 -0500
Message-ID: <457F822E.4040404@debian.org>
Date: Tue, 12 Dec 2006 23:31:42 -0500
From: Andres Salomon <dilinger@debian.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: dtor@insightbb.com, vojtech@suse.cz, warp@aehallh.com
Subject: [PATCH] psmouse split
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------060908060708000705010302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060908060708000705010302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

When Zephaniah Hull sent in a patch for the OLPC touchpad [0], it was
suggested that the psmouse driver be split out into separate components.
 What's currently there is way too fat, and people are not happy about
adding even more code to the driver.

I've taken a stab at doing just that.  The attached patch splits the
various protocol extensions into their own modules, defines a protocol
registration layer, and allows modules to define their own psmouse
protocols.  Psmouse-base now only registers a few extensions, and then
scans the ps/2 ports.  Other modules (ie, psmouse-alps) register their
extension, and force a rescan of all serio ports that the psmouse driver
happens to be using.  The max_proto stuff has been removed, with the
intention that people should be loading (or unloading) only the modules
they need, rather than playing around w/ module arguments.  Rather than
playing games w/ extension detection ordering, I opted to just reset the
port before every scan.

The patch is attached, and I have a git repository here:

git://dev.laptop.org/users/dilinger/psmouse-split

There's also a gitweb interface:

http://dev.laptop.org/git?p=users/dilinger/psmouse-split;a=summary

Comments and feedback are welcome.  I intend to do a few further
cleanups (at the very least, there are now stale header files that need
to go away, and further testing is needed).

[0] http://thread.gmane.org/gmane.linux.kernel/441574/

--------------060908060708000705010302
Content-Type: text/x-patch;
 name="psmouse.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="psmouse.patch"

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 35d998c..b160686 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -37,6 +37,66 @@ config MOUSE_PS2
 	  To compile this driver as a module, choose M here: the
 	  module will be called psmouse.
 
+config MOUSE_PS2_ALPS
+	tristate "ALPS PS/2 mouse protocol extension"
+	depends on MOUSE_PS2
+	---help---
+	  Say Y here if you have an ALPS PS/2 touchpad connected to
+	  your system.
+
+	  If unsure, say Y.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called psmouse-alps.
+
+config MOUSE_PS2_LOGIPS2PP
+	tristate "Logictech PS/2++ mouse protocol extension"
+	depends on MOUSE_PS2
+	---help---
+	  Say Y here if you have a Logictech PS/2++ mouse connected to
+	  your system.
+
+	  If unsure, say Y.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called psmouse-logips2pp.
+
+config MOUSE_PS2_SYNAPTICS
+	tristate "Synaptics PS/2 mouse protocol extension"
+	depends on MOUSE_PS2
+	---help---
+	  Say Y here if you have a Synaptics PS/2 TouchPad connected to
+	  your system.
+
+	  If unsure, say Y.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called psmouse-synaptics.
+
+config MOUSE_PS2_LIFEBOOK
+	tristate "Fujitsu Lifebook PS/2 mouse protocol extension"
+	depends on MOUSE_PS2
+	---help---
+	  Say Y here if you have a Fujitsu B-series Lifebook PS/2
+	  TouchScreen connected to your system.
+
+	  If unsure, say Y.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called psmouse-lifebook.
+
+config MOUSE_PS2_TRACKPOINT
+	tristate "IBM Trackpoint PS/2 mouse protocol extension"
+	depends on MOUSE_PS2
+	---help---
+	  Say Y here if you have an IBM Trackpoint PS/2 mouse connected
+	  to your system.
+
+	  If unsure, say Y.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called psmouse-trackpoint.
+
 config MOUSE_SERIAL
 	tristate "Serial mouse"
 	select SERIO
diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index 21a1de6..5a0767b 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -10,8 +10,18 @@ obj-$(CONFIG_MOUSE_INPORT)	+= inport.o
 obj-$(CONFIG_MOUSE_LOGIBM)	+= logibm.o
 obj-$(CONFIG_MOUSE_PC110PAD)	+= pc110pad.o
 obj-$(CONFIG_MOUSE_PS2)		+= psmouse.o
+obj-$(CONFIG_MOUSE_PS2_ALPS)	+= psmouse-alps.o
+obj-$(CONFIG_MOUSE_PS2_LOGIPS2PP)	+= psmouse-logips2pp.o
+obj-$(CONFIG_MOUSE_PS2_SYNAPTICS)	+= psmouse-synaptics.o
+obj-$(CONFIG_MOUSE_PS2_LIFEBOOK)	+= psmouse-lifebook.o
+obj-$(CONFIG_MOUSE_PS2_TRACKPOINT)	+= psmouse-trackpoint.o
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
 
-psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o trackpoint.o
+psmouse-alps-objs		:= alps.o
+psmouse-logips2pp-objs		:= logips2pp.o
+psmouse-synaptics-objs		:= synaptics.o
+psmouse-lifebook-objs		:= lifebook.o
+psmouse-trackpoint-objs		:= trackpoint.o
+psmouse-objs			:= psmouse-base.o
diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 4e71a66..dc4f6b3 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -21,6 +21,10 @@ #include <linux/libps2.h>
 #include "psmouse.h"
 #include "alps.h"
 
+MODULE_AUTHOR("Neil Brown <neilb@cse.unsw.edu.au>");
+MODULE_DESCRIPTION("ALPS touchpad PS/2 mouse driver");
+MODULE_LICENSE("GPL");
+
 #undef DEBUG
 #ifdef DEBUG
 #define dbg(format, arg...) printk(KERN_INFO "alps.c: " format "\n", ## arg)
@@ -418,7 +422,7 @@ static void alps_disconnect(struct psmou
 	kfree(priv);
 }
 
-int alps_init(struct psmouse *psmouse)
+static int alps_do_init(struct psmouse *psmouse)
 {
 	struct alps_data *priv;
 	struct input_dev *dev1 = psmouse->dev, *dev2;
@@ -499,7 +503,7 @@ init_fail:
 	return -1;
 }
 
-int alps_detect(struct psmouse *psmouse, int set_properties)
+static int alps_detect(struct psmouse *psmouse, int set_properties)
 {
 	int version;
 	const struct alps_model_info *model;
@@ -516,3 +520,23 @@ int alps_detect(struct psmouse *psmouse,
 	return 0;
 }
 
+static struct psmouse_protocol alps_proto = {
+	.type		= PSMOUSE_ALPS,
+	.name		= "AlpsPS/2",
+	.alias		= "alps",
+	.detect		= alps_detect,
+	.init		= alps_do_init,
+};
+
+static int __init alps_init(void)
+{
+	return psmouse_protocol_register(&alps_proto, 1);
+}
+
+static void __exit alps_exit(void)
+{
+	psmouse_protocol_unregister(&alps_proto);
+}
+
+module_init(alps_init);
+module_exit(alps_exit);
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 69db732..fdaa6da 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -12,9 +12,6 @@
 #ifndef _ALPS_H
 #define _ALPS_H
 
-int alps_detect(struct psmouse *psmouse, int set_properties);
-int alps_init(struct psmouse *psmouse);
-
 struct alps_model_info {
         unsigned char signature[3];
         unsigned char byte0, mask0;
diff --git a/drivers/input/mouse/lifebook.c b/drivers/input/mouse/lifebook.c
index 29542f0..09b4dfa 100644
--- a/drivers/input/mouse/lifebook.c
+++ b/drivers/input/mouse/lifebook.c
@@ -18,7 +18,10 @@ #include <linux/libps2.h>
 #include <linux/dmi.h>
 
 #include "psmouse.h"
-#include "lifebook.h"
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
+MODULE_DESCRIPTION("Fujitsu B-series Lifebook PS/2 TouchScreen driver");
+MODULE_LICENSE("GPL");
 
 static struct dmi_system_id lifebook_dmi_table[] = {
 	{
@@ -133,7 +136,7 @@ static void lifebook_disconnect(struct p
 	psmouse_reset(psmouse);
 }
 
-int lifebook_detect(struct psmouse *psmouse, int set_properties)
+static int lifebook_detect(struct psmouse *psmouse, int set_properties)
 {
         if (!dmi_check_system(lifebook_dmi_table))
                 return -1;
@@ -146,7 +149,7 @@ int lifebook_detect(struct psmouse *psmo
         return 0;
 }
 
-int lifebook_init(struct psmouse *psmouse)
+static int lifebook_do_init(struct psmouse *psmouse)
 {
 	struct input_dev *input_dev = psmouse->dev;
 
@@ -169,3 +172,23 @@ int lifebook_init(struct psmouse *psmous
 	return 0;
 }
 
+static struct psmouse_protocol lifebook_proto = {
+	.type		= PSMOUSE_LIFEBOOK,
+	.name		= "LBPS/2",
+	.alias		= "lifebook",
+	.detect		= lifebook_detect,
+	.init		= lifebook_do_init,
+};
+
+static int __init lifebook_init(void)
+{
+	return psmouse_protocol_register(&lifebook_proto, 1);
+}
+
+static void __exit lifebook_exit(void)
+{
+	psmouse_protocol_unregister(&lifebook_proto);
+}
+
+module_init(lifebook_init);
+module_exit(lifebook_exit);
diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
index d3ddea2..34a46d0 100644
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -13,7 +13,10 @@ #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/libps2.h>
 #include "psmouse.h"
-#include "logips2pp.h"
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
+MODULE_DESCRIPTION("Logitech PS/2++ mouse driver");
+MODULE_LICENSE("GPL");
 
 /* Logitech mouse types */
 #define PS2PP_KIND_WHEEL	1
@@ -35,6 +38,10 @@ struct ps2pp_info {
 	u16 features;
 };
 
+static unsigned int ps2pp_rescan = 1;
+module_param_named(rescan, ps2pp_rescan, uint, 0644); 
+MODULE_PARM_DESC(rescan, "Rescan PS/2 ports after loading (default = 1).");
+
 /*
  * Process a PS2++ or PS2T++ packet.
  */
@@ -321,7 +328,7 @@ static void ps2pp_set_model_properties(s
  * that support it.
  */
 
-int ps2pp_init(struct psmouse *psmouse, int set_properties)
+static int ps2pp_do_init(struct psmouse *psmouse, int set_properties)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[4];
@@ -415,3 +422,22 @@ int ps2pp_init(struct psmouse *psmouse, 
 	return use_ps2pp ? 0 : -1;
 }
 
+static struct psmouse_protocol ps2pp_proto = {
+	.type		= PSMOUSE_PS2PP,
+	.name		= "PS2++",
+	.alias		= "logitech",
+	.detect		= ps2pp_do_init,
+};
+
+static int __init ps2pp_init(void)
+{
+	return psmouse_protocol_register(&ps2pp_proto, 1);
+}
+
+static void __exit ps2pp_exit(void)
+{
+	psmouse_protocol_unregister(&ps2pp_proto);
+}
+
+module_init(ps2pp_init);
+module_exit(ps2pp_exit);
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index a0e4a03..996aaf0 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -23,11 +23,6 @@ #include <linux/libps2.h>
 #include <linux/mutex.h>
 
 #include "psmouse.h"
-#include "synaptics.h"
-#include "logips2pp.h"
-#include "alps.h"
-#include "lifebook.h"
-#include "trackpoint.h"
 
 #define DRIVER_DESC	"PS/2 mouse driver"
 
@@ -35,15 +30,6 @@ MODULE_AUTHOR("Vojtech Pavlik <vojtech@s
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-static unsigned int psmouse_max_proto = PSMOUSE_AUTO;
-static int psmouse_set_maxproto(const char *val, struct kernel_param *kp);
-static int psmouse_get_maxproto(char *buffer, struct kernel_param *kp);
-#define param_check_proto_abbrev(name, p)	__param_check(name, p, unsigned int)
-#define param_set_proto_abbrev			psmouse_set_maxproto
-#define param_get_proto_abbrev			psmouse_get_maxproto
-module_param_named(proto, psmouse_max_proto, proto_abbrev, 0644);
-MODULE_PARM_DESC(proto, "Highest protocol extension to probe (bare, imps, exps, any). Useful for KVM switches.");
-
 static unsigned int psmouse_resolution = 200;
 module_param_named(resolution, psmouse_resolution, uint, 0644);
 MODULE_PARM_DESC(resolution, "Resolution, in dpi.");
@@ -110,14 +96,7 @@ static DEFINE_MUTEX(psmouse_mutex);
 
 static struct workqueue_struct *kpsmoused_wq;
 
-struct psmouse_protocol {
-	enum psmouse_type type;
-	const char *name;
-	const char *alias;
-	int maxproto;
-	int (*detect)(struct psmouse *, int);
-	int (*init)(struct psmouse *);
-};
+static LIST_HEAD(psmouse_protocols);
 
 /*
  * psmouse_process_byte() analyzes the PS/2 data stream and reports
@@ -373,7 +352,7 @@ int psmouse_sliced_command(struct psmous
 
 	return 0;
 }
-
+EXPORT_SYMBOL(psmouse_sliced_command);
 
 /*
  * psmouse_reset() resets the mouse into power-on state.
@@ -390,7 +369,7 @@ int psmouse_reset(struct psmouse *psmous
 
 	return 0;
 }
-
+EXPORT_SYMBOL(psmouse_reset);
 
 /*
  * Genius NetMouse magic init.
@@ -544,211 +523,112 @@ static int ps2bare_detect(struct psmouse
 	return 0;
 }
 
+static struct psmouse_protocol ps2bare_proto = {
+	.type		= PSMOUSE_PS2,
+	.name		= "PS/2",
+	.alias		= "bare",
+	.detect		= ps2bare_detect,
+};
 
 /*
  * psmouse_extensions() probes for any extensions to the basic PS/2 protocol
  * the mouse may have.
  */
 
-static int psmouse_extensions(struct psmouse *psmouse,
-			      unsigned int max_proto, int set_properties)
+static int psmouse_extensions(struct psmouse *psmouse, int set_properties)
 {
 	int synaptics_hardware = 0;
-
-/*
- * We always check for lifebook because it does not disturb mouse
- * (it only checks DMI information).
- */
-	if (lifebook_detect(psmouse, set_properties) == 0) {
-		if (max_proto > PSMOUSE_IMEX) {
-			if (!set_properties || lifebook_init(psmouse) == 0)
-				return PSMOUSE_LIFEBOOK;
-		}
-	}
-
-/*
- * Try Kensington ThinkingMouse (we try first, because synaptics probe
- * upsets the thinkingmouse).
- */
-
-	if (max_proto > PSMOUSE_IMEX && thinking_detect(psmouse, set_properties) == 0)
-		return PSMOUSE_THINKPS;
-
-/*
- * Try Synaptics TouchPad
- */
-	if (max_proto > PSMOUSE_PS2 && synaptics_detect(psmouse, set_properties) == 0) {
-		synaptics_hardware = 1;
-
-		if (max_proto > PSMOUSE_IMEX) {
-			if (!set_properties || synaptics_init(psmouse) == 0)
-				return PSMOUSE_SYNAPTICS;
-/*
- * Some Synaptics touchpads can emulate extended protocols (like IMPS/2).
- * Unfortunately Logitech/Genius probes confuse some firmware versions so
- * we'll have to skip them.
- */
-			max_proto = PSMOUSE_IMEX;
-		}
-/*
- * Make sure that touchpad is in relative mode, gestures (taps) are enabled
- */
-		synaptics_reset(psmouse);
-	}
-
-/*
- * Try ALPS TouchPad
- */
-	if (max_proto > PSMOUSE_IMEX) {
-		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
-		if (alps_detect(psmouse, set_properties) == 0) {
-			if (!set_properties || alps_init(psmouse) == 0)
-				return PSMOUSE_ALPS;
-/*
- * Init failed, try basic relative protocols
- */
-			max_proto = PSMOUSE_IMEX;
+	struct psmouse_protocol *proto;
+
+	list_for_each_entry(proto, &psmouse_protocols, node) {
+		/*
+ 		 * Reset before every probe in case the device has
+ 		 * gotten confused by the extended protocol probes.
+ 		 * Do a full reset because some mice put themselves
+ 		 * to sleep when they see a PSMOUSE_RESET_DIS.
+ 		 */
+		psmouse_reset(psmouse);
+		if (proto->detect(psmouse, set_properties) == 0) {
+			if (proto->type == PSMOUSE_SYNAPTICS)
+				synaptics_hardware = 1;
+			if (!set_properties) {
+				if (proto->init && proto->init(psmouse) != 0)
+					continue;
+			}
+			return proto->type;
 		}
 	}
 
-	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse, set_properties) == 0)
-		return PSMOUSE_GENPS;
-
-	if (max_proto > PSMOUSE_IMEX && ps2pp_init(psmouse, set_properties) == 0)
-		return PSMOUSE_PS2PP;
-
-	if (max_proto > PSMOUSE_IMEX && trackpoint_detect(psmouse, set_properties) == 0)
-		return PSMOUSE_TRACKPOINT;
+	ps2bare_detect(psmouse, set_properties);
 
-/*
- * Reset to defaults in case the device got confused by extended
- * protocol probes. Note that we do full reset becuase some mice
- * put themselves to sleep when see PSMOUSE_RESET_DIS.
- */
-	psmouse_reset(psmouse);
+	return PSMOUSE_PS2;
+}
 
-	if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse, set_properties) == 0)
-		return PSMOUSE_IMEX;
+static void psmouse_rescan(struct serio *serio, void *data)
+{
+	if (serio->drv->driver.name == "psmouse")
+		serio_rescan(serio);
+}
 
-	if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse, set_properties) == 0)
-		return PSMOUSE_IMPS;
+int psmouse_protocol_register(struct psmouse_protocol *proto, int rescan)
+{
+	mutex_lock(&psmouse_mutex);
+	list_add_tail(&proto->node, &psmouse_protocols);
+	mutex_unlock(&psmouse_mutex);
+	if (rescan)
+		serio_for_each(NULL, psmouse_rescan);
+	return 0;
+}
+EXPORT_SYMBOL(psmouse_protocol_register);
 
-/*
- * Okay, all failed, we have a standard mouse here. The number of the buttons
- * is still a question, though. We assume 3.
- */
-	ps2bare_detect(psmouse, set_properties);
+void psmouse_protocol_unregister(struct psmouse_protocol *proto)
+{
+        mutex_lock(&psmouse_mutex);
+	if (!list_empty(&proto->node))
+		list_del_init(&proto->node);
+	mutex_unlock(&psmouse_mutex);
+	serio_for_each(NULL, psmouse_rescan);
+}
+EXPORT_SYMBOL(psmouse_protocol_unregister);
 
-	if (synaptics_hardware) {
-/*
- * We detected Synaptics hardware but it did not respond to IMPS/2 probes.
- * We need to reset the touchpad because if there is a track point on the
- * pass through port it could get disabled while probing for protocol
- * extensions.
- */
-		psmouse_reset(psmouse);
-	}
+static void psmouse_protocol_cleanup(void)
+{
+	struct list_head *node, *next;
 
-	return PSMOUSE_PS2;
+	mutex_lock(&psmouse_mutex);
+	list_for_each_safe(node, next, &psmouse_protocols)
+		list_del(node);
+	INIT_LIST_HEAD(&psmouse_protocols);
+	mutex_unlock(&psmouse_mutex);
 }
 
-static const struct psmouse_protocol psmouse_protocols[] = {
-	{
-		.type		= PSMOUSE_PS2,
-		.name		= "PS/2",
-		.alias		= "bare",
-		.maxproto	= 1,
-		.detect		= ps2bare_detect,
-	},
-	{
-		.type		= PSMOUSE_PS2PP,
-		.name		= "PS2++",
-		.alias		= "logitech",
-		.detect		= ps2pp_init,
-	},
-	{
-		.type		= PSMOUSE_THINKPS,
-		.name		= "ThinkPS/2",
-		.alias		= "thinkps",
-		.detect		= thinking_detect,
-	},
-	{
-		.type		= PSMOUSE_GENPS,
-		.name		= "GenPS/2",
-		.alias		= "genius",
-		.detect		= genius_detect,
-	},
-	{
-		.type		= PSMOUSE_IMPS,
-		.name		= "ImPS/2",
-		.alias		= "imps",
-		.maxproto	= 1,
-		.detect		= intellimouse_detect,
-	},
-	{
-		.type		= PSMOUSE_IMEX,
-		.name		= "ImExPS/2",
-		.alias		= "exps",
-		.maxproto	= 1,
-		.detect		= im_explorer_detect,
-	},
-	{
-		.type		= PSMOUSE_SYNAPTICS,
-		.name		= "SynPS/2",
-		.alias		= "synaptics",
-		.detect		= synaptics_detect,
-		.init		= synaptics_init,
-	},
-	{
-		.type		= PSMOUSE_ALPS,
-		.name		= "AlpsPS/2",
-		.alias		= "alps",
-		.detect		= alps_detect,
-		.init		= alps_init,
-	},
-	{
-		.type		= PSMOUSE_LIFEBOOK,
-		.name		= "LBPS/2",
-		.alias		= "lifebook",
-		.init		= lifebook_init,
-	},
-	{
-		.type		= PSMOUSE_TRACKPOINT,
-		.name		= "TPPS/2",
-		.alias		= "trackpoint",
-		.detect		= trackpoint_detect,
-	},
-	{
-		.type		= PSMOUSE_AUTO,
-		.name		= "auto",
-		.alias		= "any",
-		.maxproto	= 1,
-	},
-};
-
 static const struct psmouse_protocol *psmouse_protocol_by_type(enum psmouse_type type)
 {
-	int i;
+	struct psmouse_protocol *p;
 
-	for (i = 0; i < ARRAY_SIZE(psmouse_protocols); i++)
-		if (psmouse_protocols[i].type == type)
-			return &psmouse_protocols[i];
+	if (type == PSMOUSE_PS2)
+		return &ps2bare_proto;
+	list_for_each_entry(p, &psmouse_protocols, node) {
+		if (p->type == type)
+			return p;
+	}
 
 	WARN_ON(1);
-	return &psmouse_protocols[0];
+	return &ps2bare_proto;
 }
 
 static const struct psmouse_protocol *psmouse_protocol_by_name(const char *name, size_t len)
 {
-	const struct psmouse_protocol *p;
-	int i;
+	struct psmouse_protocol *p = &ps2bare_proto;
 
-	for (i = 0; i < ARRAY_SIZE(psmouse_protocols); i++) {
-		p = &psmouse_protocols[i];
+	if ((strlen(p->name) == len && !strncmp(p->name, name, len)) ||
+		    (strlen(p->alias) == len && !strncmp(p->alias, name, len)))
+		return &ps2bare_proto;
 
+	list_for_each_entry(p, &psmouse_protocols, node) {
 		if ((strlen(p->name) == len && !strncmp(p->name, name, len)) ||
 		    (strlen(p->alias) == len && !strncmp(p->alias, name, len)))
-			return &psmouse_protocols[i];
+			return p;
 	}
 
 	return NULL;
@@ -805,6 +685,7 @@ void psmouse_set_resolution(struct psmou
 	ps2_command(&psmouse->ps2dev, &p, PSMOUSE_CMD_SETRES);
 	psmouse->resolution = 25 << p;
 }
+EXPORT_SYMBOL(psmouse_set_resolution);
 
 /*
  * Here we set the mouse report rate.
@@ -838,11 +719,9 @@ static void psmouse_initialize(struct ps
  * We set the mouse report rate, resolution and scaling.
  */
 
-	if (psmouse_max_proto != PSMOUSE_PS2) {
-		psmouse->set_rate(psmouse, psmouse->rate);
-		psmouse->set_resolution(psmouse, psmouse->resolution);
-		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
-	}
+	psmouse->set_rate(psmouse, psmouse->rate);
+	psmouse->set_resolution(psmouse, psmouse->resolution);
+	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
 }
 
 /*
@@ -1063,7 +942,7 @@ static int psmouse_switch_protocol(struc
 		psmouse->type = proto->type;
 	}
 	else
-		psmouse->type = psmouse_extensions(psmouse, psmouse_max_proto, 1);
+		psmouse->type = psmouse_extensions(psmouse, 1);
 
 	/*
 	 * If mouse's packet size is 3 there is no point in polling the
@@ -1216,7 +1095,7 @@ static int psmouse_reconnect(struct seri
 		if (psmouse->reconnect(psmouse))
 			goto out;
 	} else if (psmouse_probe(psmouse) < 0 ||
-		   psmouse->type != psmouse_extensions(psmouse, psmouse_max_proto, 0))
+		   psmouse->type != psmouse_extensions(psmouse, 0))
 		goto out;
 
 	/* ok, the device type (and capabilities) match the old one,
@@ -1297,6 +1176,7 @@ out:
 	serio_unpin_driver(serio);
 	return retval;
 }
+EXPORT_SYMBOL(psmouse_attr_show_helper);
 
 ssize_t psmouse_attr_set_helper(struct device *dev, struct device_attribute *devattr,
 				const char *buf, size_t count)
@@ -1347,6 +1227,7 @@ ssize_t psmouse_attr_set_helper(struct d
 	serio_unpin_driver(serio);
 	return retval;
 }
+EXPORT_SYMBOL(psmouse_attr_set_helper);
 
 static ssize_t psmouse_show_int_attr(struct psmouse *psmouse, void *offset, char *buf)
 {
@@ -1442,7 +1323,7 @@ static ssize_t psmouse_attr_set_protocol
 	if (psmouse_switch_protocol(psmouse, proto) < 0) {
 		psmouse_reset(psmouse);
 		/* default to PSMOUSE_PS2 */
-		psmouse_switch_protocol(psmouse, &psmouse_protocols[0]);
+		psmouse_switch_protocol(psmouse, &ps2bare_proto);
 	}
 
 	psmouse_initialize(psmouse);
@@ -1498,30 +1379,30 @@ static ssize_t psmouse_attr_set_resoluti
 	return count;
 }
 
-
-static int psmouse_set_maxproto(const char *val, struct kernel_param *kp)
-{
-	const struct psmouse_protocol *proto;
-
-	if (!val)
-		return -EINVAL;
-
-	proto = psmouse_protocol_by_name(val, strlen(val));
-
-	if (!proto || !proto->maxproto)
-		return -EINVAL;
-
-	*((unsigned int *)kp->arg) = proto->type;
-
-	return 0;
-}
-
-static int psmouse_get_maxproto(char *buffer, struct kernel_param *kp)
-{
-	int type = *((unsigned int *)kp->arg);
-
-	return sprintf(buffer, "%s\n", psmouse_protocol_by_type(type)->name);
-}
+static struct psmouse_protocol thinkps_proto = {
+	.type		= PSMOUSE_THINKPS,
+	.name		= "ThinkPS/2",
+	.alias		= "thinkps",
+	.detect		= thinking_detect,
+};
+static struct psmouse_protocol genius_proto = {
+	.type		= PSMOUSE_GENPS,
+	.name		= "GenPS/2",
+	.alias		= "genius",
+	.detect		= genius_detect,
+};
+static struct psmouse_protocol imps_proto = {
+	.type		= PSMOUSE_IMPS,
+	.name		= "ImPS/2",
+	.alias		= "imps",
+	.detect		= intellimouse_detect,
+};
+static struct psmouse_protocol exps_proto = {
+	.type		= PSMOUSE_IMEX,
+	.name		= "ImExPS/2",
+	.alias		= "exps",
+	.detect		= im_explorer_detect,
+};
 
 static int __init psmouse_init(void)
 {
@@ -1533,6 +1414,11 @@ static int __init psmouse_init(void)
 		return -ENOMEM;
 	}
 
+	psmouse_protocol_register(&thinkps_proto, 0);
+	psmouse_protocol_register(&genius_proto, 0);
+	psmouse_protocol_register(&imps_proto), 0;
+	psmouse_protocol_register(&exps_proto, 0);
+
 	err = serio_register_driver(&psmouse_drv);
 	if (err)
 		destroy_workqueue(kpsmoused_wq);
@@ -1542,6 +1428,7 @@ static int __init psmouse_init(void)
 
 static void __exit psmouse_exit(void)
 {
+	psmouse_protocol_cleanup();
 	serio_unregister_driver(&psmouse_drv);
 	destroy_workqueue(kpsmoused_wq);
 }
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 1b74cae..d56a031 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -1,6 +1,8 @@
 #ifndef _PSMOUSE_H
 #define _PSMOUSE_H
 
+#include <linux/list.h>
+
 #define PSMOUSE_CMD_SETSCALE11	0x00e6
 #define PSMOUSE_CMD_SETSCALE21	0x00e7
 #define PSMOUSE_CMD_SETRES	0x10e8
@@ -89,6 +91,17 @@ enum psmouse_type {
 	PSMOUSE_AUTO		/* This one should always be last */
 };
 
+struct psmouse_protocol {
+	enum psmouse_type type;
+	const char *name;
+	const char *alias;
+	int (*detect)(struct psmouse *, int);
+	int (*init)(struct psmouse *);
+	struct list_head node;
+};
+int psmouse_protocol_register(struct psmouse_protocol *proto, int rescan);
+void psmouse_protocol_unregister(struct psmouse_protocol *proto);
+
 int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);
 int psmouse_reset(struct psmouse *psmouse);
 void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution);
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 49ac696..f63f964 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -30,6 +30,10 @@ #include <linux/libps2.h>
 #include "psmouse.h"
 #include "synaptics.h"
 
+MODULE_AUTHOR("C. Scott Ananian <cananian@alumni.priceton.edu>");
+MODULE_DESCRIPTION("Synaptics TouchPad PS/2 mouse driver");
+MODULE_LICENSE("GPL");
+
 /*
  * The x/y limits are taken from the Synaptics TouchPad interfacing Guide,
  * section 2.3.2, which says that they should be valid regardless of the
@@ -542,6 +546,30 @@ static void synaptics_disconnect(struct 
 	psmouse->private = NULL;
 }
 
+static int synaptics_detect(struct psmouse *psmouse, int set_properties)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	unsigned char param[4];
+
+	param[0] = 0;
+
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+	ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO);
+
+	if (param[1] != 0x47)
+		return -1;
+
+	if (set_properties) {
+		psmouse->vendor = "Synaptics";
+		psmouse->name = "TouchPad";
+	}
+
+	return 0;
+}
+
 static int synaptics_reconnect(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
@@ -569,30 +597,6 @@ static int synaptics_reconnect(struct ps
 	return 0;
 }
 
-int synaptics_detect(struct psmouse *psmouse, int set_properties)
-{
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param[4];
-
-	param[0] = 0;
-
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
-	ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO);
-
-	if (param[1] != 0x47)
-		return -1;
-
-	if (set_properties) {
-		psmouse->vendor = "Synaptics";
-		psmouse->name = "TouchPad";
-	}
-
-	return 0;
-}
-
 #if defined(__i386__)
 #include <linux/dmi.h>
 static struct dmi_system_id toshiba_dmi_table[] = {
@@ -621,7 +625,7 @@ static struct dmi_system_id toshiba_dmi_
 };
 #endif
 
-int synaptics_init(struct psmouse *psmouse)
+static int synaptics_do_init(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv;
 
@@ -679,4 +683,23 @@ #endif
 	return -1;
 }
 
+static struct psmouse_protocol synaptics_proto = {
+	.type		= PSMOUSE_SYNAPTICS,
+	.name		= "SynPS/2",
+	.alias		= "synaptics",
+	.detect		= synaptics_detect,
+	.init		= synaptics_do_init,
+};
+
+static int __init synaptics_init(void)
+{
+	return psmouse_protocol_register(&synaptics_proto, 1);
+}
+
+static void __exit synaptics_exit(void)
+{
+	psmouse_protocol_unregister(&synaptics_proto);
+}
 
+module_init(synaptics_init);
+module_exit(synaptics_exit);
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 68fff1d..db9faa5 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -9,8 +9,6 @@
 #ifndef _SYNAPTICS_H
 #define _SYNAPTICS_H
 
-extern int synaptics_detect(struct psmouse *psmouse, int set_properties);
-extern int synaptics_init(struct psmouse *psmouse);
 extern void synaptics_reset(struct psmouse *psmouse);
 
 /* synaptics queries */
diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index 9ab5b5e..cee80d2 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -19,6 +19,10 @@ #include <asm/uaccess.h>
 #include "psmouse.h"
 #include "trackpoint.h"
 
+MODULE_AUTHOR("Stephen Evanchik <evanchsa@gmail.com>");
+MODULE_DESCRIPTION("IBM TrackPoint PS/2 mouse driver");
+MODULE_LICENSE("GPL");
+
 /*
  * Device IO: read, write and toggle bit
  */
@@ -287,7 +291,7 @@ static int trackpoint_reconnect(struct p
 	return 0;
 }
 
-int trackpoint_detect(struct psmouse *psmouse, int set_properties)
+static int trackpoint_detect(struct psmouse *psmouse, int set_properties)
 {
 	struct trackpoint_data *priv;
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
@@ -334,3 +338,22 @@ int trackpoint_detect(struct psmouse *ps
 	return 0;
 }
 
+static struct psmouse_protocol trackpoint_proto = {
+	.type		= PSMOUSE_TRACKPOINT,
+	.name		= "TPPS/2",
+	.alias		= "trackpoint",
+	.detect		= trackpoint_detect,
+};
+
+static int __init trackpoint_init(void)
+{
+	return psmouse_protocol_register(&trackpoint_proto, 1);
+}
+
+static void __exit trackpoint_exit(void)
+{
+	psmouse_protocol_unregister(&trackpoint_proto);
+}
+
+module_init(trackpoint_init);
+module_exit(trackpoint_exit);
diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/trackpoint.h
index 050298b..5c20e9a 100644
--- a/drivers/input/mouse/trackpoint.h
+++ b/drivers/input/mouse/trackpoint.h
@@ -142,6 +142,4 @@ struct trackpoint_data
 	unsigned char ext_dev;
 };
 
-extern int trackpoint_detect(struct psmouse *psmouse, int set_properties);
-
 #endif /* _TRACKPOINT_H */
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index f0ce822..37c40a4 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -51,6 +51,7 @@ EXPORT_SYMBOL(serio_open);
 EXPORT_SYMBOL(serio_close);
 EXPORT_SYMBOL(serio_rescan);
 EXPORT_SYMBOL(serio_reconnect);
+EXPORT_SYMBOL(serio_for_each);
 
 /*
  * serio_mutex protects entire serio subsystem and is taken every time
@@ -686,6 +687,16 @@ void serio_reconnect(struct serio *serio
 	serio_queue_event(serio, NULL, SERIO_RECONNECT_PORT);
 }
 
+void serio_for_each(void *data, void (*fn)(struct serio *, void *))
+{
+	struct serio *serio;
+
+	mutex_lock(&serio_mutex);
+	list_for_each_entry(serio, &serio_list, node)
+		fn(serio, data);
+	mutex_unlock(&serio_mutex);
+}
+
 /*
  * Submits register request to kseriod for subsequent execution.
  * Note that port registration is always asynchronous.
diff --git a/include/linux/serio.h b/include/linux/serio.h
index 0f478a8..4aba3c2 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -75,6 +75,7 @@ int serio_open(struct serio *serio, stru
 void serio_close(struct serio *serio);
 void serio_rescan(struct serio *serio);
 void serio_reconnect(struct serio *serio);
+void serio_for_each(void *data, void (*fn)(struct serio *, void *));
 irqreturn_t serio_interrupt(struct serio *serio, unsigned char data, unsigned int flags);
 
 void __serio_register_port(struct serio *serio, struct module *owner);

--------------060908060708000705010302--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTJ2Ggb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 01:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTJ2Ggb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 01:36:31 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:55891 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261891AbTJ2GgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 01:36:18 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PS/2 mouse rate setting
Date: Wed, 29 Oct 2003 01:36:04 -0500
User-Agent: KMail/1.5.4
References: <20031027140217.GA1065@averell> <20031028035625.GB20145@rivenstone.net> <20031028094709.GA4325@ucw.cz>
In-Reply-To: <20031028094709.GA4325@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310290136.06439.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 October 2003 04:47 am, Vojtech Pavlik wrote:
> > >     I need this patch to use the scroll wheel on my Logitech mouse
> > > with my Belkin KVM switch in 2.6. This patch was in -mm for a while
> > > before some changes there broke the diff, and I got some mail from
> > > people who said it was helpful.  I didn't hear about any problems.
> > >
> > >     Linus, will you please consider applying it?
>
> Plase not in this shape. I don't want yet another option to the driver.
> Dmitry said he'll whip up a patch that with a single option can limit
> the maximum protocol of the PS/2 mouse to either PS/2, IMPS/2 or
> ImExPS/2, possibly more, "psmouse_proto=". That's a better solution.
>

Here it is... New parameter psmouse_proto={bare|imps|exps}. I don't think
we should bother with providing options for the rest of the protocols as
these 3 are most generic ones.

I marked psmouse_noext deprecated and psmouse will emit a warning if it
is used, if you think we can still remove it completely at this time just
let me know.

I also changed the parameter processing to module_param as it is much
easier.

Dmitry

===================================================================


ChangeSet@1.1381, 2003-10-29 01:24:15-05:00, dtor_core@ameritech.net
  Input: New parameter psmouse_maxproto to replace psmouse_noext.
         Allows to specify highest PS/2 protocol extension that
         kernel has permission to negotiate (bare|imps|exps).
  
         psmouse_noext marked as deprecated and emits a warning
         when used.
  
         Parameter parsing converted to the new scheme.


 Documentation/kernel-parameters.txt |    3 
 drivers/input/mouse/logips2pp.c     |   21 +++
 drivers/input/mouse/logips2pp.h     |    2 
 drivers/input/mouse/psmouse-base.c  |  227 ++++++++++++++++--------------------
 drivers/input/mouse/synaptics.c     |   19 ++-
 drivers/input/mouse/synaptics.h     |    1 
 6 files changed, 146 insertions(+), 127 deletions(-)


diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	Wed Oct 29 01:26:03 2003
+++ b/Documentation/kernel-parameters.txt	Wed Oct 29 01:26:03 2003
@@ -790,7 +790,8 @@
 			before loading.
 			See Documentation/ramdisk.txt.
 
-	psmouse_noext	[HW,MOUSE] Disable probing for PS2 mouse protocol extensions
+	psmouse_proto=  [HW,MOUSE] Highest PS2 mouse protocol extension to 
+			probe for (bare|imps|exps).
 
 	psmouse_resetafter=
 			[HW,MOUSE] Try to reset Synaptics Touchpad after so many
diff -Nru a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c	Wed Oct 29 01:26:03 2003
+++ b/drivers/input/mouse/logips2pp.c	Wed Oct 29 01:26:03 2003
@@ -142,7 +142,7 @@
  * touchpad.
  */
 
-int ps2pp_detect_model(struct psmouse *psmouse, unsigned char *param)
+static int ps2pp_detect_model(struct psmouse *psmouse, unsigned char *param)
 {
 	int i;
 	static int logitech_4btn[] = { 12, 40, 41, 42, 43, 52, 73, 80, -1 };
@@ -226,3 +226,22 @@
 
 	return 0;
 }
+
+/*
+ * Logitech magic init.
+ */
+int ps2pp_detect(struct psmouse *psmouse)
+{
+	unsigned char param[4];
+
+	param[0] = 0;
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+	param[1] = 0;
+	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+
+	return param[1] != 0 ? ps2pp_detect_model(psmouse, param) : 0;
+}
+
diff -Nru a/drivers/input/mouse/logips2pp.h b/drivers/input/mouse/logips2pp.h
--- a/drivers/input/mouse/logips2pp.h	Wed Oct 29 01:26:03 2003
+++ b/drivers/input/mouse/logips2pp.h	Wed Oct 29 01:26:03 2003
@@ -13,5 +13,5 @@
 struct psmouse;
 void ps2pp_process_packet(struct psmouse *psmouse);
 void ps2pp_set_800dpi(struct psmouse *psmouse);
-int ps2pp_detect_model(struct psmouse *psmouse, unsigned char *param);
+int ps2pp_detect(struct psmouse *psmouse); 
 #endif
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Wed Oct 29 01:26:03 2003
+++ b/drivers/input/mouse/psmouse-base.c	Wed Oct 29 01:26:03 2003
@@ -12,6 +12,7 @@
 
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
@@ -24,25 +25,34 @@
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("PS/2 mouse driver");
-MODULE_PARM(psmouse_noext, "1i");
-MODULE_PARM_DESC(psmouse_noext, "Disable any protocol extensions. Useful for KVM switches.");
-MODULE_PARM(psmouse_resolution, "i");
-MODULE_PARM_DESC(psmouse_resolution, "Resolution, in dpi.");
-MODULE_PARM(psmouse_rate, "i");
-MODULE_PARM_DESC(psmouse_rate, "Report rate, in reports per second.");
-MODULE_PARM(psmouse_smartscroll, "i");
-MODULE_PARM_DESC(psmouse_smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
-MODULE_PARM(psmouse_resetafter, "i");
-MODULE_PARM_DESC(psmouse_resetafter, "Reset Synaptics Touchpad after so many bad packets (0 = never).");
 MODULE_LICENSE("GPL");
 
-#define PSMOUSE_LOGITECH_SMARTSCROLL	1
-
 static int psmouse_noext;
+module_param(psmouse_noext, int, 0);
+MODULE_PARM_DESC(psmouse_noext, "[DEPRECATED] Disable any protocol extensions. Useful for KVM switches.");
+
+static char *psmouse_proto;
+static unsigned int psmouse_max_proto = -1UL;
+module_param(psmouse_proto, charp, 0);
+MODULE_PARM_DESC(psmouse_proto, "Highest protocol extension to probe (bare, imps, exps). Useful for KVM switches.");
+
 int psmouse_resolution;
+module_param(psmouse_resolution, uint, 0);
+MODULE_PARM_DESC(psmouse_resolution, "Resolution, in dpi.");
+
 unsigned int psmouse_rate;
+module_param(psmouse_rate, uint, 0);
+MODULE_PARM_DESC(psmouse_rate, "Report rate, in reports per second.");
+
+#define PSMOUSE_LOGITECH_SMARTSCROLL	1
+
 int psmouse_smartscroll = PSMOUSE_LOGITECH_SMARTSCROLL;
+module_param(psmouse_smartscroll, bool, 0);
+MODULE_PARM_DESC(psmouse_smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
+
 unsigned int psmouse_resetafter;
+module_param(psmouse_resetafter, uint, 0);
+MODULE_PARM_DESC(psmouse_resetafter, "Reset Synaptics Touchpad after so many bad packets (0 = never).");
 
 static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
 
@@ -259,46 +269,12 @@
 }
 
 /*
- * psmouse_extensions() probes for any extensions to the basic PS/2 protocol
- * the mouse may have.
+ * Genius NetMouse magic init.
  */
-
-static int psmouse_extensions(struct psmouse *psmouse)
+static int genius_detect(struct psmouse *psmouse)
 {
 	unsigned char param[4];
 
-	param[0] = 0;
-	psmouse->vendor = "Generic";
-	psmouse->name = "Mouse";
-	psmouse->model = 0;
-
-	if (psmouse_noext)
-		return PSMOUSE_PS2;
-
-/*
- * Try Synaptics TouchPad magic ID
- */
-
-       param[0] = 0;
-       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-       psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
-
-       if (param[1] == 0x47) {
-		psmouse->vendor = "Synaptics";
-		psmouse->name = "TouchPad";
-		if (!synaptics_init(psmouse))
-			return PSMOUSE_SYNAPTICS;
-		else
-			return PSMOUSE_PS2;
-       }
-
-/*
- * Try Genius NetMouse magic init.
- */
-
 	param[0] = 3;
 	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
 	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
@@ -306,65 +282,94 @@
 	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
 	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
 
-	if (param[0] == 0x00 && param[1] == 0x33 && param[2] == 0x55) {
-
-		set_bit(BTN_EXTRA, psmouse->dev.keybit);
-		set_bit(BTN_SIDE, psmouse->dev.keybit);
-		set_bit(REL_WHEEL, psmouse->dev.relbit);
-
-		psmouse->vendor = "Genius";
-		psmouse->name = "Wheel Mouse";
-		return PSMOUSE_GENPS;
-	}
+	return param[0] == 0x00 && param[1] == 0x33 && param[2] == 0x55; 
+}
 
 /*
- * Try Logitech magic ID.
+ * IntelliMouse magic init.
  */
+static int intellimouse_detect(struct psmouse *psmouse)
+{
+	unsigned char param[2];
 
-	param[0] = 0;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
-	param[1] = 0;
-	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
-
-	if (param[1]) {
-		int type = ps2pp_detect_model(psmouse, param);
-		if (type)
-			return type;
-	}
+	param[0] = 200;
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
+	param[0] = 100;
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
+	param[0] =  80;
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
+	psmouse_command(psmouse, param, PSMOUSE_CMD_GETID);
+	
+	return param[0] == 3;
+}
 
 /*
- * Try IntelliMouse magic init.
+ * Try IntelliMouse/Explorer magic init.
  */
+static int im_explorer_detect(struct psmouse *psmouse)
+{
+	unsigned char param[2];
 
 	param[0] = 200;
 	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
-	param[0] = 100;
+	param[0] = 200;
 	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
 	param[0] =  80;
 	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
 	psmouse_command(psmouse, param, PSMOUSE_CMD_GETID);
 	
-	if (param[0] == 3) {
+	return param[0] == 4;
+}
 
-		set_bit(REL_WHEEL, psmouse->dev.relbit);
+/*
+ * psmouse_extensions() probes for any extensions to the basic PS/2 protocol
+ * the mouse may have.
+ */
+
+static int psmouse_extensions(struct psmouse *psmouse)
+{
+	psmouse->vendor = "Generic";
+	psmouse->name = "Mouse";
+	psmouse->model = 0;
 
 /*
- * Try IntelliMouse/Explorer magic init.
+ * Try Synaptics TouchPad
  */
+	if (psmouse_max_proto > PSMOUSE_PS2 && synaptics_detect(psmouse)) {
+		psmouse->vendor = "Synaptics";
+		psmouse->name = "TouchPad";
+
+#if CONFIG_MOUSE_PS2_SYNAPTICS
+		if (psmouse_max_proto > PSMOUSE_IMEX && synaptics_init(psmouse) == 0)
+			return PSMOUSE_SYNAPTICS;
+#endif
+		/* 
+		 * Synaptics hardware (according to Peter Berg Larsen) can get confused 
+		 * by protocol probes below so we have to stop here  
+		 */  
+		return PSMOUSE_PS2;
+	}
+
+	if (psmouse_max_proto > PSMOUSE_IMEX && genius_detect(psmouse)) {
+		set_bit(BTN_EXTRA, psmouse->dev.keybit);
+		set_bit(BTN_SIDE, psmouse->dev.keybit);
+		set_bit(REL_WHEEL, psmouse->dev.relbit);
+
+		psmouse->vendor = "Genius";
+		psmouse->name = "Wheel Mouse";
+		return PSMOUSE_GENPS;
+	}
 
-		param[0] = 200;
-		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
-		param[0] = 200;
-		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
-		param[0] =  80;
-		psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
-		psmouse_command(psmouse, param, PSMOUSE_CMD_GETID);
+	if (psmouse_max_proto > PSMOUSE_IMEX) {
+		int type = ps2pp_detect(psmouse);
+		if (type)
+			return type;
+	}
 
-		if (param[0] == 4) {
+	if (psmouse_max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse)) {
+		set_bit(REL_WHEEL, psmouse->dev.relbit);
 
+		if (psmouse_max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse)) {
 			set_bit(BTN_SIDE, psmouse->dev.keybit);
 			set_bit(BTN_EXTRA, psmouse->dev.keybit);
 
@@ -629,47 +634,29 @@
 	.cleanup =	psmouse_cleanup,
 };
 
-#ifndef MODULE
-static int __init psmouse_noext_setup(char *str)
+static inline void psmouse_parse_proto(void)
 {
-	psmouse_noext = 1;
-	return 1;
-}
-
-static int __init psmouse_resolution_setup(char *str)
-{
-	get_option(&str, &psmouse_resolution);
-	return 1;
-}
-
-static int __init psmouse_smartscroll_setup(char *str)
-{
-	get_option(&str, &psmouse_smartscroll);
-	return 1;
-}
-
-static int __init psmouse_resetafter_setup(char *str)
-{
-	get_option(&str, &psmouse_resetafter);
-	return 1;
-}
+	if (psmouse_noext) {
+		printk(KERN_WARNING "psmouse: 'psmouse_noext' option is deprecated, please use 'psmouse_proto'\n");
+		psmouse_max_proto = PSMOUSE_PS2;
+	}
 
-static int __init psmouse_rate_setup(char *str)
-{
-	get_option(&str, &psmouse_rate);
-	return 1;
+	/* even is psmouse_noext is present psmouse_proto overrides it */ 
+	if (psmouse_proto) {
+		if (!strcmp(psmouse_proto, "bare"))
+			psmouse_max_proto = PSMOUSE_PS2;
+		else if (!strcmp(psmouse_proto, "imps"))
+			psmouse_max_proto = PSMOUSE_IMPS;
+		else if (!strcmp(psmouse_proto, "exps"))
+			psmouse_max_proto = PSMOUSE_IMEX;
+		else
+			printk(KERN_ERR "psmouse: unknown protocol type '%s'\n", psmouse_proto);
+	}
 }
 
-__setup("psmouse_noext", psmouse_noext_setup);
-__setup("psmouse_resolution=", psmouse_resolution_setup);
-__setup("psmouse_smartscroll=", psmouse_smartscroll_setup);
-__setup("psmouse_resetafter=", psmouse_resetafter_setup);
-__setup("psmouse_rate=", psmouse_rate_setup);
-
-#endif
-
 int __init psmouse_init(void)
 {
+	psmouse_parse_proto();
 	serio_register_device(&psmouse_dev);
 	return 0;
 }
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Wed Oct 29 01:26:03 2003
+++ b/drivers/input/mouse/synaptics.c	Wed Oct 29 01:26:03 2003
@@ -371,13 +371,24 @@
 	clear_bit(REL_Y, dev->relbit);
 }
 
+int synaptics_detect(struct psmouse *psmouse)
+{
+	unsigned char param[4];
+	
+	param[0] = 0;
+	
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
+	psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
+	
+	return param[1] == 0x47;
+}
+
 int synaptics_init(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv;
-
-#ifndef CONFIG_MOUSE_PS2_SYNAPTICS
-	return -1;
-#endif
 
 	psmouse->private = priv = kmalloc(sizeof(struct synaptics_data), GFP_KERNEL);
 	if (!priv)
diff -Nru a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
--- a/drivers/input/mouse/synaptics.h	Wed Oct 29 01:26:03 2003
+++ b/drivers/input/mouse/synaptics.h	Wed Oct 29 01:26:03 2003
@@ -11,6 +11,7 @@
 
 
 extern void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
+extern int synaptics_detect(struct psmouse *psmouse);
 extern int synaptics_init(struct psmouse *psmouse);
 extern int synaptics_pt_init(struct psmouse *psmouse);
 extern void synaptics_disconnect(struct psmouse *psmouse);

===================================================================


This BitKeeper patch contains the following changesets:
1.1381
## Wrapped with gzip_uu ##


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
;OW>#@<ZZBR?CDZ$YLG0R;$C_ 8XFF\9>)P  
 

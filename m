Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268238AbUI2GvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268238AbUI2GvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 02:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268237AbUI2Guh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 02:50:37 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:37998 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268238AbUI2GsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 02:48:03 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 5/8] Export psmouse parameters via sysfs
Date: Wed, 29 Sep 2004 01:44:48 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200409290140.53350.dtor_core@ameritech.net> <200409290143.11562.dtor_core@ameritech.net> <200409290144.04783.dtor_core@ameritech.net>
In-Reply-To: <200409290144.04783.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409290144.50310.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1951, 2004-09-28 00:51:49-05:00, dtor_core@ameritech.net
  Input: psmouse - export rate, resolution, resetafter and smartscroll
         (Logitech only) as individual mouse attributes (sysfs) and allow
         them to be set/changed independently for each mouse:
  
           echo -n "100" > /sys/bus/serio/devices/serio0/rate
           echo -n "200" > /sys/bus/serio/devices/serio0/resolution


 logips2pp.c    |   48 +++++++++++++++++----
 psmouse-base.c |  127 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 psmouse.h      |   22 +++++++++
 3 files changed, 185 insertions(+), 12 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c	2004-09-29 01:21:02 -05:00
+++ b/drivers/input/mouse/logips2pp.c	2004-09-29 01:21:02 -05:00
@@ -109,14 +109,17 @@
  * enabled if we do nothing to it. Of course I put this in because I want it
  * disabled :P
  * 1 - enabled (if previously disabled, also default)
- * 0/2 - disabled
+ * 0 - disabled
  */
 
-static void ps2pp_set_smartscroll(struct psmouse *psmouse)
+static void ps2pp_set_smartscroll(struct psmouse *psmouse, unsigned int smartscroll)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[4];
 
+	if (smartscroll > 1)
+		smartscroll = 1;
+
 	ps2pp_cmd(psmouse, param, 0x32);
 
 	param[0] = 0;
@@ -124,13 +127,31 @@
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
 
-	if (psmouse_smartscroll < 2) {
-		/* 0 - disabled, 1 - enabled */
-		param[0] = psmouse_smartscroll;
-		ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
-	}
+	param[0] = smartscroll;
+	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
+}
+
+static ssize_t psmouse_attr_show_smartscroll(struct psmouse *psmouse, char *buf)
+{
+	return sprintf(buf, "%d\n", psmouse->smartscroll ? 1 : 0);
+}
+
+static ssize_t psmouse_attr_set_smartscroll(struct psmouse *psmouse, const char *buf, size_t count)
+{
+	unsigned long value;
+	char *rest;
+
+	value = simple_strtoul(buf, &rest, 10);
+	if (*rest || value > 1)
+		return -EINVAL;
+
+	ps2pp_set_smartscroll(psmouse, value);
+	psmouse->smartscroll = value;
+	return count;
 }
 
+PSMOUSE_DEFINE_ATTR(smartscroll);
+
 /*
  * Support 800 dpi resolution _only_ if the user wants it (there are good
  * reasons to not use it even if the mouse supports it, and of course there are
@@ -152,6 +173,11 @@
 		psmouse_set_resolution(psmouse, resolution);
 }
 
+static void ps2pp_disconnect(struct psmouse *psmouse)
+{
+	device_remove_file(&psmouse->ps2dev.serio->dev, &psmouse_attr_smartscroll);
+}
+
 static struct ps2pp_info *get_model_info(unsigned char model)
 {
 	static struct ps2pp_info ps2pp_list[] = {
@@ -295,7 +321,7 @@
 			if ((param[0] & 0x78) == 0x48 &&
 			    (param[1] & 0xf3) == 0xc2 &&
 			    (param[2] & 0x03) == ((param[1] >> 2) & 3)) {
-				ps2pp_set_smartscroll(psmouse);
+				ps2pp_set_smartscroll(psmouse, psmouse->smartscroll);
 				protocol = PSMOUSE_PS2PP;
 			}
 		}
@@ -303,8 +329,12 @@
 		if (set_properties) {
 			psmouse->vendor = "Logitech";
 			psmouse->model = model;
-			if (protocol == PSMOUSE_PS2PP)
+			if (protocol == PSMOUSE_PS2PP) {
 				psmouse->set_resolution = ps2pp_set_resolution;
+				psmouse->disconnect = ps2pp_disconnect;
+
+				device_create_file(&psmouse->ps2dev.serio->dev, &psmouse_attr_smartscroll);
+			}
 
 			if (buttons < 3)
 				clear_bit(BTN_MIDDLE, psmouse->dev.keybit);
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-09-29 01:21:02 -05:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-09-29 01:21:02 -05:00
@@ -44,7 +44,7 @@
 module_param_named(rate, psmouse_rate, uint, 0);
 MODULE_PARM_DESC(rate, "Report rate, in reports per second.");
 
-int psmouse_smartscroll = 1;
+static unsigned int psmouse_smartscroll = 1;
 module_param_named(smartscroll, psmouse_smartscroll, bool, 0);
 MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
 
@@ -52,6 +52,10 @@
 module_param_named(resetafter, psmouse_resetafter, uint, 0);
 MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
 
+PSMOUSE_DEFINE_ATTR(rate);
+PSMOUSE_DEFINE_ATTR(resolution);
+PSMOUSE_DEFINE_ATTR(resetafter);
+
 __obsolete_setup("psmouse_noext");
 __obsolete_setup("psmouse_resolution=");
 __obsolete_setup("psmouse_smartscroll=");
@@ -209,7 +213,7 @@
 				psmouse->name, psmouse->phys, psmouse->pktcnt);
 			psmouse->pktcnt = 0;
 
-			if (++psmouse->out_of_sync == psmouse_resetafter) {
+			if (++psmouse->out_of_sync == psmouse->resetafter) {
 				psmouse->state = PSMOUSE_IGNORE;
 				printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
 				serio_reconnect(psmouse->ps2dev.serio);
@@ -638,6 +642,10 @@
 {
 	struct psmouse *psmouse, *parent;
 
+	device_remove_file(&serio->dev, &psmouse_attr_rate);
+	device_remove_file(&serio->dev, &psmouse_attr_resolution);
+	device_remove_file(&serio->dev, &psmouse_attr_resetafter);
+
 	psmouse = serio->private;
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
@@ -706,6 +714,8 @@
 
 	psmouse->rate = psmouse_rate;
 	psmouse->resolution = psmouse_resolution;
+	psmouse->resetafter = psmouse_resetafter;
+	psmouse->smartscroll = psmouse_smartscroll;
 	psmouse->type = psmouse_extensions(psmouse, psmouse_max_proto, 1);
 	if (!psmouse->vendor)
 		psmouse->vendor = "Generic";
@@ -741,6 +751,10 @@
 	if (parent && parent->pt_activate)
 		parent->pt_activate(parent);
 
+	device_create_file(&serio->dev, &psmouse_attr_rate);
+	device_create_file(&serio->dev, &psmouse_attr_resolution);
+	device_create_file(&serio->dev, &psmouse_attr_resetafter);
+
 	if (serio->child) {
 		/*
 		 * Nothing to be done here, serio core will detect that
@@ -817,6 +831,115 @@
 	.disconnect	= psmouse_disconnect,
 	.cleanup	= psmouse_cleanup,
 };
+
+ssize_t psmouse_attr_show_helper(struct device *dev, char *buf,
+				 ssize_t (*handler)(struct psmouse *, char *))
+{
+	struct serio *serio = to_serio_port(dev);
+	int retval;
+
+	retval = serio_pin_driver(serio);
+	if (retval)
+		return retval;
+
+	if (serio->drv != &psmouse_drv) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	retval = handler(serio->private, buf);
+
+out:
+	serio_unpin_driver(serio);
+	return retval;
+}
+
+ssize_t psmouse_attr_set_helper(struct device *dev, const char *buf, size_t count,
+				ssize_t (*handler)(struct psmouse *, const char *, size_t))
+{
+	struct serio *serio = to_serio_port(dev);
+	struct psmouse *psmouse = serio->private, *parent = NULL;
+	int retval;
+
+	retval = serio_pin_driver(serio);
+	if (retval)
+		return retval;
+
+	if (serio->drv != &psmouse_drv) {
+		retval = -ENODEV;
+		goto out;
+	}
+
+	if (serio->parent && (serio->type & SERIO_TYPE) == SERIO_PS_PSTHRU) {
+		parent = serio->parent->private;
+		psmouse_deactivate(parent);
+	}
+	psmouse_deactivate(psmouse);
+
+	retval = handler(psmouse, buf, count);
+
+	psmouse_activate(psmouse);
+	if (parent)
+		psmouse_activate(parent);
+
+out:
+	serio_unpin_driver(serio);
+	return retval;
+}
+
+static ssize_t psmouse_attr_show_rate(struct psmouse *psmouse, char *buf)
+{
+	return sprintf(buf, "%d\n", psmouse->rate);
+}
+
+static ssize_t psmouse_attr_set_rate(struct psmouse *psmouse, const char *buf, size_t count)
+{
+	unsigned long value;
+	char *rest;
+
+	value = simple_strtoul(buf, &rest, 10);
+	if (*rest)
+		return -EINVAL;
+
+	psmouse->set_rate(psmouse, value);
+	return count;
+}
+
+static ssize_t psmouse_attr_show_resolution(struct psmouse *psmouse, char *buf)
+{
+	return sprintf(buf, "%d\n", psmouse->resolution);
+}
+
+static ssize_t psmouse_attr_set_resolution(struct psmouse *psmouse, const char *buf, size_t count)
+{
+	unsigned long value;
+	char *rest;
+
+	value = simple_strtoul(buf, &rest, 10);
+	if (*rest)
+		return -EINVAL;
+
+	psmouse->set_resolution(psmouse, value);
+	return count;
+}
+
+static ssize_t psmouse_attr_show_resetafter(struct psmouse *psmouse, char *buf)
+{
+	return sprintf(buf, "%d\n", psmouse->resetafter);
+}
+
+static ssize_t psmouse_attr_set_resetafter(struct psmouse *psmouse, const char *buf, size_t count)
+{
+	unsigned long value;
+	char *rest;
+
+	value = simple_strtoul(buf, &rest, 10);
+	if (*rest)
+		return -EINVAL;
+
+	psmouse->resetafter = value;
+	return count;
+}
 
 static inline void psmouse_parse_proto(void)
 {
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	2004-09-29 01:21:02 -05:00
+++ b/drivers/input/mouse/psmouse.h	2004-09-29 01:21:02 -05:00
@@ -52,6 +52,8 @@
 
 	unsigned int rate;
 	unsigned int resolution;
+	unsigned int resetafter;
+	unsigned int smartscroll;	/* Logitech only */
 
 	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse, struct pt_regs *regs);
 	void (*set_rate)(struct psmouse *psmouse, unsigned int rate);
@@ -81,6 +83,24 @@
 int psmouse_reset(struct psmouse *psmouse);
 void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution);
 
-extern int psmouse_smartscroll;
+ssize_t psmouse_attr_show_helper(struct device *dev, char *buf,
+			ssize_t (*handler)(struct psmouse *, char *));
+ssize_t psmouse_attr_set_helper(struct device *dev, const char *buf, size_t count,
+			int (*handler)(struct psmouse *, const char *, size_t));
+
+#define PSMOUSE_DEFINE_ATTR(_name)						\
+static ssize_t psmouse_attr_show_##_name(struct psmouse *, char *);		\
+static ssize_t psmouse_attr_set_##_name(struct psmouse *, const char *, size_t);\
+static ssize_t psmouse_do_show_##_name(struct device *d, char *b)		\
+{										\
+	return psmouse_attr_show_helper(d, b, psmouse_attr_show_##_name);	\
+}										\
+static ssize_t psmouse_do_set_##_name(struct device *d, const char *b, size_t s)\
+{										\
+	return psmouse_attr_set_helper(d, b, s, psmouse_attr_set_##_name);	\
+}										\
+static struct device_attribute psmouse_attr_##_name = 				\
+	__ATTR(_name, S_IWUSR | S_IRUGO,					\
+		psmouse_do_show_##_name, psmouse_do_set_##_name);
 
 #endif /* _PSMOUSE_H */

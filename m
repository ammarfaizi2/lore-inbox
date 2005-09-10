Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVIJWlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVIJWlF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVIJWd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:33:58 -0400
Received: from styx.suse.cz ([82.119.242.94]:19620 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932341AbVIJWdt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:49 -0400
Subject: [PATCH 2/26] rework psmouse attributes to reduce module size
In-Reply-To: <1126391651592@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:11 +0200
Message-Id: <112639165121@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: rework psmouse attributes to reduce module size
From: Dmitry Torokhov <dtor_core@ameritech.net>
Date: 1125816020 -0500

Rearrange attribute code to use generic show and set handlers
instead of replicating them for every attribute; switch to
using attribute_group instead of creating all attributes
manually. All this saves about 4K.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/input/mouse/logips2pp.c    |   12 +-
 drivers/input/mouse/psmouse-base.c |  117 +++++++++++++----------
 drivers/input/mouse/psmouse.h      |   49 ++++++----
 drivers/input/mouse/trackpoint.c   |  183 +++++++++++++++++++-----------------
 4 files changed, 199 insertions(+), 162 deletions(-)

cfe9e88866fe892f4f71bf132c64ec8bd5256e5e
diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -150,12 +150,12 @@ static void ps2pp_set_smartscroll(struct
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
 }
 
-static ssize_t psmouse_attr_show_smartscroll(struct psmouse *psmouse, char *buf)
+static ssize_t ps2pp_attr_show_smartscroll(struct psmouse *psmouse, void *data, char *buf)
 {
 	return sprintf(buf, "%d\n", psmouse->smartscroll ? 1 : 0);
 }
 
-static ssize_t psmouse_attr_set_smartscroll(struct psmouse *psmouse, const char *buf, size_t count)
+static ssize_t ps2pp_attr_set_smartscroll(struct psmouse *psmouse, void *data, const char *buf, size_t count)
 {
 	unsigned long value;
 	char *rest;
@@ -169,7 +169,8 @@ static ssize_t psmouse_attr_set_smartscr
 	return count;
 }
 
-PSMOUSE_DEFINE_ATTR(smartscroll);
+PSMOUSE_DEFINE_ATTR(smartscroll, S_IWUSR | S_IRUGO, NULL,
+			ps2pp_attr_show_smartscroll, ps2pp_attr_set_smartscroll);
 
 /*
  * Support 800 dpi resolution _only_ if the user wants it (there are good
@@ -194,7 +195,7 @@ static void ps2pp_set_resolution(struct 
 
 static void ps2pp_disconnect(struct psmouse *psmouse)
 {
-	device_remove_file(&psmouse->ps2dev.serio->dev, &psmouse_attr_smartscroll);
+	device_remove_file(&psmouse->ps2dev.serio->dev, &psmouse_attr_smartscroll.dattr);
 }
 
 static struct ps2pp_info *get_model_info(unsigned char model)
@@ -379,7 +380,8 @@ int ps2pp_init(struct psmouse *psmouse, 
 				psmouse->set_resolution = ps2pp_set_resolution;
 				psmouse->disconnect = ps2pp_disconnect;
 
-				device_create_file(&psmouse->ps2dev.serio->dev, &psmouse_attr_smartscroll);
+				device_create_file(&psmouse->ps2dev.serio->dev,
+						   &psmouse_attr_smartscroll.dattr);
 			}
 		}
 
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -58,10 +58,30 @@ static unsigned int psmouse_resetafter;
 module_param_named(resetafter, psmouse_resetafter, uint, 0644);
 MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
 
-PSMOUSE_DEFINE_ATTR(protocol);
-PSMOUSE_DEFINE_ATTR(rate);
-PSMOUSE_DEFINE_ATTR(resolution);
-PSMOUSE_DEFINE_ATTR(resetafter);
+PSMOUSE_DEFINE_ATTR(protocol, S_IWUSR | S_IRUGO,
+			NULL,
+			psmouse_attr_show_protocol, psmouse_attr_set_protocol);
+PSMOUSE_DEFINE_ATTR(rate, S_IWUSR | S_IRUGO,
+			(void *) offsetof(struct psmouse, rate),
+			psmouse_show_int_attr, psmouse_attr_set_rate);
+PSMOUSE_DEFINE_ATTR(resolution, S_IWUSR | S_IRUGO,
+			(void *) offsetof(struct psmouse, resolution),
+			psmouse_show_int_attr, psmouse_attr_set_resolution);
+PSMOUSE_DEFINE_ATTR(resetafter, S_IWUSR | S_IRUGO,
+			(void *) offsetof(struct psmouse, resetafter),
+			psmouse_show_int_attr, psmouse_set_int_attr);
+
+static struct attribute *psmouse_attributes[] = {
+	&psmouse_attr_protocol.dattr.attr,
+	&psmouse_attr_rate.dattr.attr,
+	&psmouse_attr_resolution.dattr.attr,
+	&psmouse_attr_resetafter.dattr.attr,
+	NULL
+};
+
+static struct attribute_group psmouse_attribute_group = {
+	.attrs	= psmouse_attributes,
+};
 
 __obsolete_setup("psmouse_noext");
 __obsolete_setup("psmouse_resolution=");
@@ -800,10 +820,7 @@ static void psmouse_disconnect(struct se
 
 	psmouse = serio_get_drvdata(serio);
 
-	device_remove_file(&serio->dev, &psmouse_attr_protocol);
-	device_remove_file(&serio->dev, &psmouse_attr_rate);
-	device_remove_file(&serio->dev, &psmouse_attr_resolution);
-	device_remove_file(&serio->dev, &psmouse_attr_resetafter);
+	sysfs_remove_group(&serio->dev.kobj, &psmouse_attribute_group);
 
 	down(&psmouse_sem);
 
@@ -940,10 +957,7 @@ static int psmouse_connect(struct serio 
 	if (parent && parent->pt_activate)
 		parent->pt_activate(parent);
 
-	device_create_file(&serio->dev, &psmouse_attr_protocol);
-	device_create_file(&serio->dev, &psmouse_attr_rate);
-	device_create_file(&serio->dev, &psmouse_attr_resolution);
-	device_create_file(&serio->dev, &psmouse_attr_resetafter);
+	sysfs_create_group(&serio->dev.kobj, &psmouse_attribute_group);
 
 	psmouse_activate(psmouse);
 
@@ -1040,10 +1054,12 @@ static struct serio_driver psmouse_drv =
 	.cleanup	= psmouse_cleanup,
 };
 
-ssize_t psmouse_attr_show_helper(struct device *dev, char *buf,
-				 ssize_t (*handler)(struct psmouse *, char *))
+ssize_t psmouse_attr_show_helper(struct device *dev, struct device_attribute *devattr,
+				 char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
+	struct psmouse_attribute *attr = to_psmouse_attr(devattr);
+	struct psmouse *psmouse;
 	int retval;
 
 	retval = serio_pin_driver(serio);
@@ -1055,19 +1071,21 @@ ssize_t psmouse_attr_show_helper(struct 
 		goto out;
 	}
 
-	retval = handler(serio_get_drvdata(serio), buf);
+	psmouse = serio_get_drvdata(serio);
+
+	retval = attr->show(psmouse, attr->data, buf);
 
 out:
 	serio_unpin_driver(serio);
 	return retval;
 }
 
-ssize_t psmouse_attr_set_helper(struct device *dev, const char *buf, size_t count,
-				ssize_t (*handler)(struct psmouse *, const char *, size_t))
+ssize_t psmouse_attr_set_helper(struct device *dev, struct device_attribute *devattr,
+				const char *buf, size_t count)
 {
 	struct serio *serio = to_serio_port(dev);
-	struct psmouse *psmouse = serio_get_drvdata(serio);
-	struct psmouse *parent = NULL;
+	struct psmouse_attribute *attr = to_psmouse_attr(devattr);
+	struct psmouse *psmouse, *parent = NULL;
 	int retval;
 
 	retval = serio_pin_driver(serio);
@@ -1083,6 +1101,8 @@ ssize_t psmouse_attr_set_helper(struct d
 	if (retval)
 		goto out_unpin;
 
+	psmouse = serio_get_drvdata(serio);
+
 	if (psmouse->state == PSMOUSE_IGNORE) {
 		retval = -ENODEV;
 		goto out_up;
@@ -1095,7 +1115,7 @@ ssize_t psmouse_attr_set_helper(struct d
 
 	psmouse_deactivate(psmouse);
 
-	retval = handler(psmouse, buf, count);
+	retval = attr->set(psmouse, attr->data, buf, count);
 
 	if (retval != -ENODEV)
 		psmouse_activate(psmouse);
@@ -1110,12 +1130,34 @@ ssize_t psmouse_attr_set_helper(struct d
 	return retval;
 }
 
-static ssize_t psmouse_attr_show_protocol(struct psmouse *psmouse, char *buf)
+static ssize_t psmouse_show_int_attr(struct psmouse *psmouse, void *offset, char *buf)
+{
+	unsigned long *field = (unsigned long *)((char *)psmouse + (size_t)offset);
+
+	return sprintf(buf, "%lu\n", *field);
+}
+
+static ssize_t psmouse_set_int_attr(struct psmouse *psmouse, void *offset, const char *buf, size_t count)
+{
+	unsigned long *field = (unsigned long *)((char *)psmouse + (size_t)offset);
+	unsigned long value;
+	char *rest;
+
+	value = simple_strtoul(buf, &rest, 10);
+	if (*rest)
+		return -EINVAL;
+
+	*field = value;
+
+	return count;
+}
+
+static ssize_t psmouse_attr_show_protocol(struct psmouse *psmouse, void *data, char *buf)
 {
 	return sprintf(buf, "%s\n", psmouse_protocol_by_type(psmouse->type)->name);
 }
 
-static ssize_t psmouse_attr_set_protocol(struct psmouse *psmouse, const char *buf, size_t count)
+static ssize_t psmouse_attr_set_protocol(struct psmouse *psmouse, void *data, const char *buf, size_t count)
 {
 	struct serio *serio = psmouse->ps2dev.serio;
 	struct psmouse *parent = NULL;
@@ -1179,12 +1221,7 @@ static ssize_t psmouse_attr_set_protocol
 	return count;
 }
 
-static ssize_t psmouse_attr_show_rate(struct psmouse *psmouse, char *buf)
-{
-	return sprintf(buf, "%d\n", psmouse->rate);
-}
-
-static ssize_t psmouse_attr_set_rate(struct psmouse *psmouse, const char *buf, size_t count)
+static ssize_t psmouse_attr_set_rate(struct psmouse *psmouse, void *data, const char *buf, size_t count)
 {
 	unsigned long value;
 	char *rest;
@@ -1197,12 +1234,7 @@ static ssize_t psmouse_attr_set_rate(str
 	return count;
 }
 
-static ssize_t psmouse_attr_show_resolution(struct psmouse *psmouse, char *buf)
-{
-	return sprintf(buf, "%d\n", psmouse->resolution);
-}
-
-static ssize_t psmouse_attr_set_resolution(struct psmouse *psmouse, const char *buf, size_t count)
+static ssize_t psmouse_attr_set_resolution(struct psmouse *psmouse, void *data, const char *buf, size_t count)
 {
 	unsigned long value;
 	char *rest;
@@ -1215,23 +1247,6 @@ static ssize_t psmouse_attr_set_resoluti
 	return count;
 }
 
-static ssize_t psmouse_attr_show_resetafter(struct psmouse *psmouse, char *buf)
-{
-	return sprintf(buf, "%d\n", psmouse->resetafter);
-}
-
-static ssize_t psmouse_attr_set_resetafter(struct psmouse *psmouse, const char *buf, size_t count)
-{
-	unsigned long value;
-	char *rest;
-
-	value = simple_strtoul(buf, &rest, 10);
-	if (*rest)
-		return -EINVAL;
-
-	psmouse->resetafter = value;
-	return count;
-}
 
 static int psmouse_set_maxproto(const char *val, struct kernel_param *kp)
 {
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -86,24 +86,37 @@ int psmouse_sliced_command(struct psmous
 int psmouse_reset(struct psmouse *psmouse);
 void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution);
 
-ssize_t psmouse_attr_show_helper(struct device *dev, char *buf,
-			ssize_t (*handler)(struct psmouse *, char *));
-ssize_t psmouse_attr_set_helper(struct device *dev, const char *buf, size_t count,
-			ssize_t (*handler)(struct psmouse *, const char *, size_t));
 
-#define PSMOUSE_DEFINE_ATTR(_name)						\
-static ssize_t psmouse_attr_show_##_name(struct psmouse *, char *);		\
-static ssize_t psmouse_attr_set_##_name(struct psmouse *, const char *, size_t);\
-static ssize_t psmouse_do_show_##_name(struct device *d, struct device_attribute *attr, char *b)		\
-{										\
-	return psmouse_attr_show_helper(d, b, psmouse_attr_show_##_name);	\
-}										\
-static ssize_t psmouse_do_set_##_name(struct device *d, struct device_attribute *attr, const char *b, size_t s)\
-{										\
-	return psmouse_attr_set_helper(d, b, s, psmouse_attr_set_##_name);	\
-}										\
-static struct device_attribute psmouse_attr_##_name =				\
-	__ATTR(_name, S_IWUSR | S_IRUGO,					\
-		psmouse_do_show_##_name, psmouse_do_set_##_name);
+struct psmouse_attribute {
+	struct device_attribute dattr;
+	void *data;
+	ssize_t (*show)(struct psmouse *psmouse, void *data, char *buf);
+	ssize_t (*set)(struct psmouse *psmouse, void *data,
+			const char *buf, size_t count);
+};
+#define to_psmouse_attr(a)	container_of((a), struct psmouse_attribute, dattr)
+
+ssize_t psmouse_attr_show_helper(struct device *dev, struct device_attribute *attr,
+				 char *buf);
+ssize_t psmouse_attr_set_helper(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count);
+
+#define PSMOUSE_DEFINE_ATTR(_name, _mode, _data, _show, _set)			\
+static ssize_t _show(struct psmouse *, void *data, char *);			\
+static ssize_t _set(struct psmouse *, void *data, const char *, size_t);	\
+static struct psmouse_attribute psmouse_attr_##_name = {			\
+	.dattr	= {								\
+		.attr	= {							\
+			.name	= __stringify(_name),				\
+			.mode	= _mode,					\
+			.owner	= THIS_MODULE,					\
+		},								\
+		.show	= psmouse_attr_show_helper,				\
+		.store	= psmouse_attr_set_helper,				\
+	},									\
+	.data	= _data,							\
+	.show	= _show,							\
+	.set	= _set,								\
+}
 
 #endif /* _PSMOUSE_H */
diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -19,54 +19,6 @@
 #include "psmouse.h"
 #include "trackpoint.h"
 
-PSMOUSE_DEFINE_ATTR(sensitivity);
-PSMOUSE_DEFINE_ATTR(speed);
-PSMOUSE_DEFINE_ATTR(inertia);
-PSMOUSE_DEFINE_ATTR(reach);
-PSMOUSE_DEFINE_ATTR(draghys);
-PSMOUSE_DEFINE_ATTR(mindrag);
-PSMOUSE_DEFINE_ATTR(thresh);
-PSMOUSE_DEFINE_ATTR(upthresh);
-PSMOUSE_DEFINE_ATTR(ztime);
-PSMOUSE_DEFINE_ATTR(jenks);
-PSMOUSE_DEFINE_ATTR(press_to_select);
-PSMOUSE_DEFINE_ATTR(skipback);
-PSMOUSE_DEFINE_ATTR(ext_dev);
-
-#define MAKE_ATTR_READ(_item) \
-	static ssize_t psmouse_attr_show_##_item(struct psmouse *psmouse, char *buf) \
-	{ \
-		struct trackpoint_data *tp = psmouse->private; \
-		return sprintf(buf, "%lu\n", (unsigned long)tp->_item); \
-	}
-
-#define MAKE_ATTR_WRITE(_item, command) \
-	static ssize_t psmouse_attr_set_##_item(struct psmouse *psmouse, const char *buf, size_t count) \
-	{ \
-		char *rest; \
-		unsigned long value; \
-		struct trackpoint_data *tp = psmouse->private; \
-		value = simple_strtoul(buf, &rest, 10); \
-		if (*rest) \
-			return -EINVAL; \
-		tp->_item = value; \
-		trackpoint_write(&psmouse->ps2dev, command, tp->_item); \
-		return count; \
-	}
-
-#define MAKE_ATTR_TOGGLE(_item, command, mask) \
-	static ssize_t psmouse_attr_set_##_item(struct psmouse *psmouse, const char *buf, size_t count) \
-	{ \
-		unsigned char toggle; \
-		struct trackpoint_data *tp = psmouse->private; \
-		toggle = (buf[0] == '1') ? 1 : 0; \
-		if (toggle != tp->_item) { \
-			tp->_item = toggle; \
-			trackpoint_toggle_bit(&psmouse->ps2dev, command, mask); \
-		} \
-		return count; \
-	}
-
 /*
  * Device IO: read, write and toggle bit
  */
@@ -108,59 +60,114 @@ static int trackpoint_toggle_bit(struct 
 	return 0;
 }
 
-MAKE_ATTR_WRITE(sensitivity, TP_SENS);
-MAKE_ATTR_READ(sensitivity);
-
-MAKE_ATTR_WRITE(speed, TP_SPEED);
-MAKE_ATTR_READ(speed);
 
-MAKE_ATTR_WRITE(inertia, TP_INERTIA);
-MAKE_ATTR_READ(inertia);
+/*
+ * Trackpoint-specific attributes
+ */
+struct trackpoint_attr_data {
+	size_t field_offset;
+	unsigned char command;
+	unsigned char mask;
+};
 
-MAKE_ATTR_WRITE(reach, TP_REACH);
-MAKE_ATTR_READ(reach);
+static ssize_t trackpoint_show_int_attr(struct psmouse *psmouse, void *data, char *buf)
+{
+	struct trackpoint_data *tp = psmouse->private;
+	struct trackpoint_attr_data *attr = data;
+	unsigned char *field = (unsigned char *)((char *)tp + attr->field_offset);
 
-MAKE_ATTR_WRITE(draghys, TP_DRAGHYS);
-MAKE_ATTR_READ(draghys);
+	return sprintf(buf, "%u\n", *field);
+}
 
-MAKE_ATTR_WRITE(mindrag, TP_MINDRAG);
-MAKE_ATTR_READ(mindrag);
+static ssize_t trackpoint_set_int_attr(struct psmouse *psmouse, void *data,
+					const char *buf, size_t count)
+{
+	struct trackpoint_data *tp = psmouse->private;
+	struct trackpoint_attr_data *attr = data;
+	unsigned char *field = (unsigned char *)((char *)tp + attr->field_offset);
+	unsigned long value;
+	char *rest;
+
+	value = simple_strtoul(buf, &rest, 10);
+	if (*rest || value > 255)
+		return -EINVAL;
 
-MAKE_ATTR_WRITE(thresh, TP_THRESH);
-MAKE_ATTR_READ(thresh);
+	*field = value;
+	trackpoint_write(&psmouse->ps2dev, attr->command, value);
 
-MAKE_ATTR_WRITE(upthresh, TP_UP_THRESH);
-MAKE_ATTR_READ(upthresh);
+	return count;
+}
 
-MAKE_ATTR_WRITE(ztime, TP_Z_TIME);
-MAKE_ATTR_READ(ztime);
+#define TRACKPOINT_INT_ATTR(_name, _command)					\
+	static struct trackpoint_attr_data trackpoint_attr_##_name = {		\
+		.field_offset = offsetof(struct trackpoint_data, _name),	\
+		.command = _command,						\
+	};									\
+	PSMOUSE_DEFINE_ATTR(_name, S_IWUSR | S_IRUGO,				\
+			    &trackpoint_attr_##_name,				\
+			    trackpoint_show_int_attr, trackpoint_set_int_attr)
 
-MAKE_ATTR_WRITE(jenks, TP_JENKS_CURV);
-MAKE_ATTR_READ(jenks);
+static ssize_t trackpoint_set_bit_attr(struct psmouse *psmouse, void *data,
+					const char *buf, size_t count)
+{
+	struct trackpoint_data *tp = psmouse->private;
+	struct trackpoint_attr_data *attr = data;
+	unsigned char *field = (unsigned char *)((char *)tp + attr->field_offset);
+	unsigned long value;
+	char *rest;
+
+	value = simple_strtoul(buf, &rest, 10);
+	if (*rest || value > 1)
+		return -EINVAL;
+
+	if (*field != value) {
+		*field = value;
+		trackpoint_toggle_bit(&psmouse->ps2dev, attr->command, attr->mask);
+	}
 
-MAKE_ATTR_TOGGLE(press_to_select, TP_TOGGLE_PTSON, TP_MASK_PTSON);
-MAKE_ATTR_READ(press_to_select);
+	return count;
+}
 
-MAKE_ATTR_TOGGLE(skipback, TP_TOGGLE_SKIPBACK, TP_MASK_SKIPBACK);
-MAKE_ATTR_READ(skipback);
 
-MAKE_ATTR_TOGGLE(ext_dev, TP_TOGGLE_EXT_DEV, TP_MASK_EXT_DEV);
-MAKE_ATTR_READ(ext_dev);
+#define TRACKPOINT_BIT_ATTR(_name, _command, _mask)				\
+	static struct trackpoint_attr_data trackpoint_attr_##_name = {		\
+		.field_offset	= offsetof(struct trackpoint_data, _name),	\
+		.command	= _command,					\
+		.mask		= _mask,					\
+	};									\
+	PSMOUSE_DEFINE_ATTR(_name, S_IWUSR | S_IRUGO,				\
+			    &trackpoint_attr_##_name,				\
+			    trackpoint_show_int_attr, trackpoint_set_bit_attr)
+
+TRACKPOINT_INT_ATTR(sensitivity, TP_SENS);
+TRACKPOINT_INT_ATTR(speed, TP_SPEED);
+TRACKPOINT_INT_ATTR(inertia, TP_INERTIA);
+TRACKPOINT_INT_ATTR(reach, TP_REACH);
+TRACKPOINT_INT_ATTR(draghys, TP_DRAGHYS);
+TRACKPOINT_INT_ATTR(mindrag, TP_MINDRAG);
+TRACKPOINT_INT_ATTR(thresh, TP_THRESH);
+TRACKPOINT_INT_ATTR(upthresh, TP_UP_THRESH);
+TRACKPOINT_INT_ATTR(ztime, TP_Z_TIME);
+TRACKPOINT_INT_ATTR(jenks, TP_JENKS_CURV);
+
+TRACKPOINT_BIT_ATTR(press_to_select, TP_TOGGLE_PTSON, TP_MASK_PTSON);
+TRACKPOINT_BIT_ATTR(skipback, TP_TOGGLE_SKIPBACK, TP_MASK_SKIPBACK);
+TRACKPOINT_BIT_ATTR(ext_dev, TP_TOGGLE_EXT_DEV, TP_MASK_EXT_DEV);
 
 static struct attribute *trackpoint_attrs[] = {
-	&psmouse_attr_sensitivity.attr,
-	&psmouse_attr_speed.attr,
-	&psmouse_attr_inertia.attr,
-	&psmouse_attr_reach.attr,
-	&psmouse_attr_draghys.attr,
-	&psmouse_attr_mindrag.attr,
-	&psmouse_attr_thresh.attr,
-	&psmouse_attr_upthresh.attr,
-	&psmouse_attr_ztime.attr,
-	&psmouse_attr_jenks.attr,
-	&psmouse_attr_press_to_select.attr,
-	&psmouse_attr_skipback.attr,
-	&psmouse_attr_ext_dev.attr,
+	&psmouse_attr_sensitivity.dattr.attr,
+	&psmouse_attr_speed.dattr.attr,
+	&psmouse_attr_inertia.dattr.attr,
+	&psmouse_attr_reach.dattr.attr,
+	&psmouse_attr_draghys.dattr.attr,
+	&psmouse_attr_mindrag.dattr.attr,
+	&psmouse_attr_thresh.dattr.attr,
+	&psmouse_attr_upthresh.dattr.attr,
+	&psmouse_attr_ztime.dattr.attr,
+	&psmouse_attr_jenks.dattr.attr,
+	&psmouse_attr_press_to_select.dattr.attr,
+	&psmouse_attr_skipback.dattr.attr,
+	&psmouse_attr_ext_dev.dattr.attr,
 	NULL
 };
 


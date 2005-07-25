Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVGYFxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVGYFxT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 01:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVGYFxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:53:19 -0400
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:61053 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261555AbVGYFxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:18 -0400
Message-Id: <20050725054530.929151000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:34:52 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 03/24] serio: add modalias
Content-Disposition: inline; filename=serio-modalias.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: serio - add modalias attribute and environment variable to
       simplify hotplug scripts.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/serio.c |   42 ++++++++++++++++++++++++++----------------
 1 files changed, 26 insertions(+), 16 deletions(-)

Index: work/drivers/input/serio/serio.c
===================================================================
--- work.orig/drivers/input/serio/serio.c
+++ work/drivers/input/serio/serio.c
@@ -389,6 +389,14 @@ static ssize_t serio_show_description(st
 	return sprintf(buf, "%s\n", serio->name);
 }
 
+static ssize_t serio_show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct serio *serio = to_serio_port(dev);
+
+	return sprintf(buf, "serio:ty%02Xpr%02Xid%02Xex%02X\n",
+			serio->id.type, serio->id.proto, serio->id.id, serio->id.extra);
+}
+
 static ssize_t serio_show_id_type(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct serio *serio = to_serio_port(dev);
@@ -487,6 +495,7 @@ static ssize_t serio_set_bind_mode(struc
 
 static struct device_attribute serio_device_attrs[] = {
 	__ATTR(description, S_IRUGO, serio_show_description, NULL),
+	__ATTR(modalias, S_IRUGO, serio_show_modalias, NULL),
 	__ATTR(drvctl, S_IWUSR, NULL, serio_rebind_driver),
 	__ATTR(bind_mode, S_IWUSR | S_IRUGO, serio_show_bind_mode, serio_set_bind_mode),
 	__ATTR_NULL
@@ -785,36 +794,37 @@ static int serio_bus_match(struct device
 
 #ifdef CONFIG_HOTPLUG
 
-#define PUT_ENVP(fmt, val) 						\
-do {									\
-	envp[i++] = buffer;						\
-	length += snprintf(buffer, buffer_size - length, fmt, val);	\
-	if (buffer_size - length <= 0 || i >= num_envp)			\
-		return -ENOMEM;						\
-	length++;							\
-	buffer += length;						\
-} while (0)
+#define SERIO_ADD_HOTPLUG_VAR(fmt, val...)				\
+	do {								\
+		int err = add_hotplug_env_var(envp, num_envp, &i,	\
+					buffer, buffer_size, &len,	\
+					fmt, val);			\
+		if (err)						\
+			return err;					\
+	} while (0)
+
 static int serio_hotplug(struct device *dev, char **envp, int num_envp, char *buffer, int buffer_size)
 {
 	struct serio *serio;
 	int i = 0;
-	int length = 0;
+	int len = 0;
 
 	if (!dev)
 		return -ENODEV;
 
 	serio = to_serio_port(dev);
 
-	PUT_ENVP("SERIO_TYPE=%02x", serio->id.type);
-	PUT_ENVP("SERIO_PROTO=%02x", serio->id.proto);
-	PUT_ENVP("SERIO_ID=%02x", serio->id.id);
-	PUT_ENVP("SERIO_EXTRA=%02x", serio->id.extra);
-
+	SERIO_ADD_HOTPLUG_VAR("SERIO_TYPE=%02x", serio->id.type);
+	SERIO_ADD_HOTPLUG_VAR("SERIO_PROTO=%02x", serio->id.proto);
+	SERIO_ADD_HOTPLUG_VAR("SERIO_ID=%02x", serio->id.id);
+	SERIO_ADD_HOTPLUG_VAR("SERIO_EXTRA=%02x", serio->id.extra);
+	SERIO_ADD_HOTPLUG_VAR("MODALIAS=serio:ty%02Xpr%02Xid%02Xex%02X",
+				serio->id.type, serio->id.proto, serio->id.id, serio->id.extra);
 	envp[i] = NULL;
 
 	return 0;
 }
-#undef PUT_ENVP
+#undef SERIO_ADD_HOTPLUG_VAR
 
 #else
 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422997AbWBOGPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422997AbWBOGPB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422998AbWBOGOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:14:10 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:62623 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1422997AbWBOGOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:14:06 -0500
Message-Id: <20060215061150.133664000.dtor_core@ameritech.net>
References: <20060215060140.243794000.dtor_core@ameritech.net>
Date: Wed, 15 Feb 2006 01:01:43 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PATCH 3/6] trackpoint: enable devices connected to external port
Content-Disposition: inline; filename=trackpint-ext-dev.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: trackpoint - enable devices connected to external port

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/trackpoint.c |   20 ++++++++++++++------
 drivers/input/mouse/trackpoint.h |    4 ++--
 2 files changed, 16 insertions(+), 8 deletions(-)

Index: work/drivers/input/mouse/trackpoint.c
===================================================================
--- work.orig/drivers/input/mouse/trackpoint.c
+++ work/drivers/input/mouse/trackpoint.c
@@ -68,15 +68,19 @@ struct trackpoint_attr_data {
 	size_t field_offset;
 	unsigned char command;
 	unsigned char mask;
+	unsigned char inverted;
 };
 
 static ssize_t trackpoint_show_int_attr(struct psmouse *psmouse, void *data, char *buf)
 {
 	struct trackpoint_data *tp = psmouse->private;
 	struct trackpoint_attr_data *attr = data;
-	unsigned char *field = (unsigned char *)((char *)tp + attr->field_offset);
+	unsigned char value = *(unsigned char *)((char *)tp + attr->field_offset);
+
+	if (attr->inverted)
+		value = !value;
 
-	return sprintf(buf, "%u\n", *field);
+	return sprintf(buf, "%u\n", value);
 }
 
 static ssize_t trackpoint_set_int_attr(struct psmouse *psmouse, void *data,
@@ -120,6 +124,9 @@ static ssize_t trackpoint_set_bit_attr(s
 	if (*rest || value > 1)
 		return -EINVAL;
 
+	if (attr->inverted)
+		value = !value;
+
 	if (*field != value) {
 		*field = value;
 		trackpoint_toggle_bit(&psmouse->ps2dev, attr->command, attr->mask);
@@ -129,11 +136,12 @@ static ssize_t trackpoint_set_bit_attr(s
 }
 
 
-#define TRACKPOINT_BIT_ATTR(_name, _command, _mask)				\
+#define TRACKPOINT_BIT_ATTR(_name, _command, _mask, _inv)				\
 	static struct trackpoint_attr_data trackpoint_attr_##_name = {		\
 		.field_offset	= offsetof(struct trackpoint_data, _name),	\
 		.command	= _command,					\
 		.mask		= _mask,					\
+		.inverted	= _inv,						\
 	};									\
 	PSMOUSE_DEFINE_ATTR(_name, S_IWUSR | S_IRUGO,				\
 			    &trackpoint_attr_##_name,				\
@@ -150,9 +158,9 @@ TRACKPOINT_INT_ATTR(upthresh, TP_UP_THRE
 TRACKPOINT_INT_ATTR(ztime, TP_Z_TIME);
 TRACKPOINT_INT_ATTR(jenks, TP_JENKS_CURV);
 
-TRACKPOINT_BIT_ATTR(press_to_select, TP_TOGGLE_PTSON, TP_MASK_PTSON);
-TRACKPOINT_BIT_ATTR(skipback, TP_TOGGLE_SKIPBACK, TP_MASK_SKIPBACK);
-TRACKPOINT_BIT_ATTR(ext_dev, TP_TOGGLE_EXT_DEV, TP_MASK_EXT_DEV);
+TRACKPOINT_BIT_ATTR(press_to_select, TP_TOGGLE_PTSON, TP_MASK_PTSON, 0);
+TRACKPOINT_BIT_ATTR(skipback, TP_TOGGLE_SKIPBACK, TP_MASK_SKIPBACK, 0);
+TRACKPOINT_BIT_ATTR(ext_dev, TP_TOGGLE_EXT_DEV, TP_MASK_EXT_DEV, 1);
 
 static struct attribute *trackpoint_attrs[] = {
 	&psmouse_attr_sensitivity.dattr.attr,
Index: work/drivers/input/mouse/trackpoint.h
===================================================================
--- work.orig/drivers/input/mouse/trackpoint.h
+++ work/drivers/input/mouse/trackpoint.h
@@ -78,7 +78,7 @@
 
 #define TP_TOGGLE_MB		0x23	/* Disable/Enable Middle Button */
 #define TP_MASK_MB			0x01
-#define TP_TOGGLE_EXT_DEV	0x23	/* Toggle external device */
+#define TP_TOGGLE_EXT_DEV	0x23	/* Disable external device */
 #define TP_MASK_EXT_DEV			0x02
 #define TP_TOGGLE_DRIFT		0x23	/* Drift Correction */
 #define TP_MASK_DRIFT			0x80
@@ -125,7 +125,7 @@
 #define TP_DEF_MB		0x00
 #define TP_DEF_PTSON		0x00
 #define TP_DEF_SKIPBACK		0x00
-#define TP_DEF_EXT_DEV		0x01
+#define TP_DEF_EXT_DEV		0x00	/* 0 means enabled */
 
 #define MAKE_PS2_CMD(params, results, cmd) ((params<<12) | (results<<8) | (cmd))
 


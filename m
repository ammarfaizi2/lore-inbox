Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVDDGQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVDDGQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 02:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVDDGPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 02:15:23 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:45916 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261538AbVDDGOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 02:14:04 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 4/4] serio 'id' attributes
Date: Mon, 4 Apr 2005 01:13:55 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>,
       InputML <linux-input@atrey.karlin.mff.cuni.cz>,
       Andrew Morton <akpm@osdl.org>
References: <200504040110.13315.dtor_core@ameritech.net> <200504040111.49402.dtor_core@ameritech.net> <200504040113.01274.dtor_core@ameritech.net>
In-Reply-To: <200504040113.01274.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504040113.55800.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

Input: move serio port's id attributes into separate subdirectory:
       ..devices/serioX/id_type  -> ..devices/serioX/id/type
       ..devices/serioX/id_proto -> ..devices/serioX/id/proto

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 serio.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

Index: dtor/drivers/input/serio/serio.c
===================================================================
--- dtor.orig/drivers/input/serio/serio.c
+++ dtor/drivers/input/serio/serio.c
@@ -388,6 +388,24 @@ static ssize_t serio_show_id_extra(struc
 	return sprintf(buf, "%02x\n", serio->id.extra);
 }
 
+static DEVICE_ATTR(type, S_IRUGO, serio_show_id_type, NULL);
+static DEVICE_ATTR(proto, S_IRUGO, serio_show_id_proto, NULL);
+static DEVICE_ATTR(id, S_IRUGO, serio_show_id_id, NULL);
+static DEVICE_ATTR(extra, S_IRUGO, serio_show_id_extra, NULL);
+
+static struct attribute *serio_device_id_attrs[] = {
+	&dev_attr_type.attr,
+	&dev_attr_proto.attr,
+	&dev_attr_id.attr,
+	&dev_attr_extra.attr,
+	NULL
+};
+
+static struct attribute_group serio_id_attr_group = {
+	.name	= "id",
+	.attrs	= serio_device_id_attrs,
+};
+
 static ssize_t serio_rebind_driver(struct device *dev, const char *buf, size_t count)
 {
 	struct serio *serio = to_serio_port(dev);
@@ -444,10 +462,6 @@ static ssize_t serio_set_bind_mode(struc
 
 static struct device_attribute serio_device_attrs[] = {
 	__ATTR(description, S_IRUGO, serio_show_description, NULL),
-	__ATTR(id_type, S_IRUGO, serio_show_id_type, NULL),
-	__ATTR(id_proto, S_IRUGO, serio_show_id_proto, NULL),
-	__ATTR(id_id, S_IRUGO, serio_show_id_id, NULL),
-	__ATTR(id_extra, S_IRUGO, serio_show_id_extra, NULL),
 	__ATTR(drvctl, S_IWUSR, NULL, serio_rebind_driver),
 	__ATTR(bind_mode, S_IWUSR | S_IRUGO, serio_show_bind_mode, serio_set_bind_mode),
 	__ATTR_NULL
@@ -498,6 +512,7 @@ static void serio_add_port(struct serio 
 	if (serio->start)
 		serio->start(serio);
 	device_add(&serio->dev);
+	sysfs_create_group(&serio->dev.kobj, &serio_id_attr_group);
 	serio->registered = 1;
 }
 
@@ -526,6 +541,7 @@ static void serio_destroy_port(struct se
 	}
 
 	if (serio->registered) {
+		sysfs_remove_group(&serio->dev.kobj, &serio_id_attr_group);
 		device_del(&serio->dev);
 		list_del_init(&serio->node);
 		serio->registered = 0;

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbVJ1Gso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbVJ1Gso (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbVJ1Gqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:46:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:19178 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965116AbVJ1GbI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:08 -0400
Cc: gregkh@suse.de
Subject: [PATCH] INPUT: Fix oops when accessing sysfs files of nested input devices
In-Reply-To: <11304810263348@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:26 -0700
Message-Id: <11304810262190@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] INPUT: Fix oops when accessing sysfs files of nested input devices

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 706d2a7c95014882307f31cd0f3c2a95b0544819
tree d13cecf9467ec8812058bad516c451e1d2c7263e
parent ae2ea92c4fa1b32ab686bf48243b3671b3aa7c3a
author Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:25:43 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:06 -0700

 drivers/input/input.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index b0ede4c..0d570cf 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -642,17 +642,22 @@ static ssize_t input_dev_show_##name(str
 	up(&input_dev->sem);							\
 										\
 	return retval;								\
-}
+}										\
+static CLASS_DEVICE_ATTR(name, S_IRUGO, input_dev_show_##name, NULL);
 
 INPUT_DEV_STRING_ATTR_SHOW(name);
 INPUT_DEV_STRING_ATTR_SHOW(phys);
 INPUT_DEV_STRING_ATTR_SHOW(uniq);
 
-static struct class_device_attribute input_dev_attrs[] = {
-	__ATTR(name, S_IRUGO, input_dev_show_name, NULL),
-	__ATTR(phys, S_IRUGO, input_dev_show_phys, NULL),
-	__ATTR(uniq, S_IRUGO, input_dev_show_uniq, NULL),
-	__ATTR_NULL
+static struct attribute *input_dev_attrs[] = {
+	&class_device_attr_name.attr,
+	&class_device_attr_phys.attr,
+	&class_device_attr_uniq.attr,
+	NULL
+};
+
+static struct attribute_group input_dev_group = {
+	.attrs	= input_dev_attrs,
 };
 
 #define INPUT_DEV_ID_ATTR(name)							\
@@ -728,7 +733,6 @@ static void input_dev_release(struct cla
 struct class input_dev_class = {
 	.name			= "input_dev",
 	.release		= input_dev_release,
-	.class_dev_attrs	= input_dev_attrs,
 };
 
 struct input_dev *input_allocate_device(void)
@@ -766,6 +770,7 @@ static void input_register_classdevice(s
 	kfree(path);
 
 	class_device_add(&dev->cdev);
+	sysfs_create_group(&dev->cdev.kobj, &input_dev_group);
 	sysfs_create_group(&dev->cdev.kobj, &input_dev_id_attr_group);
 	sysfs_create_group(&dev->cdev.kobj, &input_dev_caps_attr_group);
 }


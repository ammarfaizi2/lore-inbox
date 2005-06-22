Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbVFVFcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVFVFcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVFVF2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:28:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:36247 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262750AbVFVFMQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:12:16 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: new family structure.
In-Reply-To: <11194171262246@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:12:07 -0700
Message-Id: <11194171273603@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: new family structure.

Removed some fields which are not required.
First step for writing operations.
Now only read and read name remain.
Patch depends on w1 cleanups patch.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ca775c629a366ded01aae69da8410f70aaf85de1
tree 2e8138bb6aca6d1d699138d57809e8673abeb7aa
parent 7785925dd8e0d2f389d4a9168f1683c6b249a552
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Fri, 20 May 2005 22:49:08 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:43:09 -0700

 drivers/w1/w1.c        |   18 ------------------
 drivers/w1/w1.h        |    2 +-
 drivers/w1/w1_family.c |    2 +-
 drivers/w1/w1_family.h |    3 ---
 drivers/w1/w1_therm.c  |   10 ----------
 5 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -102,9 +102,6 @@ static ssize_t w1_default_read_bin(struc
 static struct device_attribute w1_slave_attribute =
 	__ATTR(name, S_IRUGO, w1_default_read_name, NULL);
 
-static struct device_attribute w1_slave_attribute_val =
-	__ATTR(value, S_IRUGO, w1_default_read_name, NULL);
-
 static struct bin_attribute w1_slave_bin_attribute = {
 	.attr = {
 		.name = "w1_slave",
@@ -310,12 +307,9 @@ static int __w1_attach_slave_device(stru
 
 	memcpy(&sl->attr_bin, &w1_slave_bin_attribute, sizeof(sl->attr_bin));
 	memcpy(&sl->attr_name, &w1_slave_attribute, sizeof(sl->attr_name));
-	memcpy(&sl->attr_val, &w1_slave_attribute_val, sizeof(sl->attr_val));
 
 	sl->attr_bin.read = sl->family->fops->rbin;
 	sl->attr_name.show = sl->family->fops->rname;
-	sl->attr_val.show = sl->family->fops->rval;
-	sl->attr_val.attr.name = sl->family->fops->rvalname;
 
 	err = device_create_file(&sl->dev, &sl->attr_name);
 	if (err < 0) {
@@ -326,23 +320,12 @@ static int __w1_attach_slave_device(stru
 		return err;
 	}
 
-	err = device_create_file(&sl->dev, &sl->attr_val);
-	if (err < 0) {
-		dev_err(&sl->dev,
-			 "sysfs file creation for [%s] failed. err=%d\n",
-			 sl->dev.bus_id, err);
-		device_remove_file(&sl->dev, &sl->attr_name);
-		device_unregister(&sl->dev);
-		return err;
-	}
-
 	err = sysfs_create_bin_file(&sl->dev.kobj, &sl->attr_bin);
 	if (err < 0) {
 		dev_err(&sl->dev,
 			 "sysfs file creation for [%s] failed. err=%d\n",
 			 sl->dev.bus_id, err);
 		device_remove_file(&sl->dev, &sl->attr_name);
-		device_remove_file(&sl->dev, &sl->attr_val);
 		device_unregister(&sl->dev);
 		return err;
 	}
@@ -428,7 +411,6 @@ static void w1_slave_detach(struct w1_sl
 
 	sysfs_remove_bin_file (&sl->dev.kobj, &sl->attr_bin);
 	device_remove_file(&sl->dev, &sl->attr_name);
-	device_remove_file(&sl->dev, &sl->attr_val);
 	device_unregister(&sl->dev);
 	w1_family_put(sl->family);
 
diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -79,7 +79,7 @@ struct w1_slave
 	struct completion	dev_released;
 
 	struct bin_attribute	attr_bin;
-	struct device_attribute	attr_name, attr_val;
+	struct device_attribute	attr_name;
 };
 
 typedef void (* w1_slave_found_callback)(unsigned long, u64);
diff --git a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
--- a/drivers/w1/w1_family.c
+++ b/drivers/w1/w1_family.c
@@ -30,7 +30,7 @@ static LIST_HEAD(w1_families);
 
 static int w1_check_family(struct w1_family *f)
 {
-	if (!f->fops->rname || !f->fops->rbin || !f->fops->rval || !f->fops->rvalname)
+	if (!f->fops->rname || !f->fops->rbin)
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
--- a/drivers/w1/w1_family.h
+++ b/drivers/w1/w1_family.h
@@ -39,9 +39,6 @@ struct w1_family_ops
 {
 	ssize_t (* rname)(struct device *, struct device_attribute *, char *);
 	ssize_t (* rbin)(struct kobject *, char *, loff_t, size_t);
-
-	ssize_t (* rval)(struct device *, struct device_attribute *, char *);
-	unsigned char rvalname[MAXNAMELEN];
 };
 
 struct w1_family
diff --git a/drivers/w1/w1_therm.c b/drivers/w1/w1_therm.c
--- a/drivers/w1/w1_therm.c
+++ b/drivers/w1/w1_therm.c
@@ -43,14 +43,11 @@ static u8 bad_roms[][9] = {
 			};
 
 static ssize_t w1_therm_read_name(struct device *, struct device_attribute *attr, char *);
-static ssize_t w1_therm_read_temp(struct device *, struct device_attribute *attr, char *);
 static ssize_t w1_therm_read_bin(struct kobject *, char *, loff_t, size_t);
 
 static struct w1_family_ops w1_therm_fops = {
 	.rname = &w1_therm_read_name,
 	.rbin = &w1_therm_read_bin,
-	.rval = &w1_therm_read_temp,
-	.rvalname = "temp1_input",
 };
 
 static struct w1_family w1_therm_family_DS18S20 = {
@@ -142,13 +139,6 @@ static inline int w1_convert_temp(u8 rom
 	return 0;
 }
 
-static ssize_t w1_therm_read_temp(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
-
-	return sprintf(buf, "%d\n", w1_convert_temp(sl->rom, sl->family->fid));
-}
-
 static int w1_therm_check_rom(u8 rom[9])
 {
 	int i;


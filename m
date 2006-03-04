Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWCDA4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWCDA4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 19:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWCDA4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 19:56:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48803 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750945AbWCDA4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 19:56:13 -0500
Message-ID: <4408E5F6.7060403@ce.jp.nec.com>
Date: Fri, 03 Mar 2006 19:57:26 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alasdair Kergon <agk@redhat.com>, Neil Brown <neilb@suse.de>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
CC: Lars Marowsky-Bree <lmb@suse.de>, akpm@osdl.org,
       device-mapper development <dm-devel@redhat.com>
Subject: [PATCH 1/6] kobject_add_dir
References: <4408E33E.1080703@ce.jp.nec.com>
In-Reply-To: <4408E33E.1080703@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------010304010507020902010703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010304010507020902010703
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch is part of dm/md sysfs dependency tree.

This adds kobject_add_dir() function which creates a subdirectory
for a given kobject.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------010304010507020902010703
Content-Type: text/x-patch;
 name="01-kobject_add_dir.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-kobject_add_dir.patch"

Adding kobject_add_dir() function which creates a subdirectory
for a given kobject.

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

 include/linux/kobject.h |    2 ++
 lib/kobject.c           |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

--- linux-2.6.16-rc5.orig/include/linux/kobject.h	2006-02-27 00:09:35.000000000 -0500
+++ linux-2.6.16-rc5/include/linux/kobject.h	2006-03-02 14:26:26.000000000 -0500
@@ -80,6 +80,8 @@ extern void kobject_unregister(struct ko
 extern struct kobject * kobject_get(struct kobject *);
 extern void kobject_put(struct kobject *);
 
+extern struct kobject * kobject_add_dir(struct kobject *, const char *);
+
 extern char * kobject_get_path(struct kobject *, gfp_t);
 
 struct kobj_type {
--- linux-2.6.16-rc5.orig/lib/kobject.c	2006-02-27 00:09:35.000000000 -0500
+++ linux-2.6.16-rc5/lib/kobject.c	2006-03-02 14:26:26.000000000 -0500
@@ -379,6 +379,43 @@ void kobject_put(struct kobject * kobj)
 }
 
 
+static void dir_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
+static struct kobj_type dir_ktype = {
+	.release	= dir_release,
+	.sysfs_ops	= NULL,
+	.default_attrs	= NULL,
+};
+
+/**
+ *	kobject_add_dir - add sub directory of object.
+ *	@parent:	object in which a directory is created.
+ *	@name:	directory name.
+ *
+ *	Add a plain directory object as child of given object.
+ */
+struct kobject *kobject_add_dir(struct kobject *parent, const char *name)
+{
+	struct kobject *k;
+
+	if (!parent)
+		return NULL;
+
+	k = kzalloc(sizeof(*k), GFP_KERNEL);
+	if (!k)
+		return NULL;
+
+	k->parent = parent;
+	k->ktype = &dir_ktype;
+	kobject_set_name(k, name);
+	kobject_register(k);
+
+	return k;
+}
+
 /**
  *	kset_init - initialize a kset for use
  *	@k:	kset 

--------------010304010507020902010703--

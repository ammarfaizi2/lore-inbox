Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWCMWM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWCMWM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWCMWM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:12:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12230 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932493AbWCMWM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:12:57 -0500
Message-ID: <4415EEC1.5080201@ce.jp.nec.com>
Date: Mon, 13 Mar 2006 17:14:25 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Alasdair Kergon <agk@redhat.com>,
       Greg KH <gregkh@suse.de>, Neil Brown <neilb@suse.de>
CC: Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dm/md dependency tree in sysfs: kobject_add_dir
References: <4415EC4B.4010003@ce.jp.nec.com>
In-Reply-To: <4415EC4B.4010003@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------020206050300040204010102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020206050300040204010102
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch is part of dm/md dependency tree in sysfs.

This adds kobject_add_dir() function which creates a subdirectory
for a given kobject.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------020206050300040204010102
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

--- linux-2.6.16-rc6.orig/include/linux/kobject.h	2006-03-11 17:12:55.000000000 -0500
+++ linux-2.6.16-rc6/include/linux/kobject.h	2006-03-13 11:23:55.000000000 -0500
@@ -80,6 +80,8 @@ extern void kobject_unregister(struct ko
 extern struct kobject * kobject_get(struct kobject *);
 extern void kobject_put(struct kobject *);
 
+extern struct kobject * kobject_add_dir(struct kobject *, const char *);
+
 extern char * kobject_get_path(struct kobject *, gfp_t);
 
 struct kobj_type {
--- linux-2.6.16-rc6.orig/lib/kobject.c	2006-03-11 17:12:55.000000000 -0500
+++ linux-2.6.16-rc6/lib/kobject.c	2006-03-13 11:23:55.000000000 -0500
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

--------------020206050300040204010102--

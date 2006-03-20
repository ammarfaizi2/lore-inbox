Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030553AbWCTWBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030553AbWCTWBc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWCTWBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:48825 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965003AbWCTWBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:05 -0500
Cc: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 20/23] kobject_add_dir
In-Reply-To: <11428920392452-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:39 -0800
Message-Id: <11428920393385-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adding kobject_add_dir() function which creates a subdirectory
for a given kobject.

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 include/linux/kobject.h |    2 ++
 lib/kobject.c           |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

7423172a50968de1905a61413c52bb070a62f5ce
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 7ece63f..4cb1214 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -80,6 +80,8 @@ extern void kobject_unregister(struct ko
 extern struct kobject * kobject_get(struct kobject *);
 extern void kobject_put(struct kobject *);
 
+extern struct kobject *kobject_add_dir(struct kobject *, const char *);
+
 extern char * kobject_get_path(struct kobject *, gfp_t);
 
 struct kobj_type {
diff --git a/lib/kobject.c b/lib/kobject.c
index 36668c8..25204a4 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -385,6 +385,44 @@ void kobject_put(struct kobject * kobj)
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
+EXPORT_SYMBOL_GPL(kobject_add_dir);
+
 /**
  *	kset_init - initialize a kset for use
  *	@k:	kset 
-- 
1.2.4



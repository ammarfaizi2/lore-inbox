Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbSKYR1x>; Mon, 25 Nov 2002 12:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbSKYR1x>; Mon, 25 Nov 2002 12:27:53 -0500
Received: from air-2.osdl.org ([65.172.181.6]:14263 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262224AbSKYR1u>;
	Mon, 25 Nov 2002 12:27:50 -0500
Date: Mon, 25 Nov 2002 11:29:26 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use
In-Reply-To: <017601c29287$ddde7860$94d40a0a@amr.corp.intel.com>
Message-ID: <Pine.LNX.4.33.0211251117020.898-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Nov 2002, Rusty Lynch wrote:

> Patrick,
> 
> Your changes added various subsys_* calls that do not seem to
> exist in the latest bk tree, or in the patch you sent earlier in this
> thread.
> 
> Do you have a local implementation of:
> 
> subsys_create_file()
> subsys_remove_file()
> 
> and defines struct subsys_attribute?

Woops, I forgot to include that part of the patch. Attached is what I have 
against current BK, which should also be 2.5.49. This should be everything 
you need to make it work. Sorry about that.

	-pat

diff -Nru a/fs/sysfs/inode.c b/fs/sysfs/inode.c
--- a/fs/sysfs/inode.c	Mon Nov 25 11:28:31 2002
+++ b/fs/sysfs/inode.c	Mon Nov 25 11:28:31 2002
@@ -145,6 +145,43 @@
 	return error;
 }
 
+#define to_subsys(k) container_of(k,struct subsystem,kobj)
+#define to_sattr(a) container_of(a,struct subsys_attribute,attr)
+
+/**
+ * Subsystem file operations.
+ * These operations allow subsystems to have files that can be 
+ * read/written. 
+ */
+ssize_t subsys_attr_show(struct kobject * kobj, struct attribute * attr, 
+			 char * page, size_t count, loff_t off)
+{
+	struct subsystem * s = to_subsys(kobj);
+	struct subsys_attribute * sattr = to_sattr(attr);
+	ssize_t ret = 0;
+
+	if (sattr->show)
+		ret = sattr->show(s,page,count,off);
+	return ret;
+}
+
+ssize_t subsys_attr_store(struct kobject * kobj, struct attribute * attr,
+			  const char * page, size_t count, loff_t off)
+{
+	struct subsystem * s = to_subsys(kobj);
+	struct subsys_attribute * sattr = to_sattr(attr);
+	ssize_t ret = 0;
+
+	if (sattr->store)
+		ret = sattr->store(s,page,count,off);
+	return ret;
+}
+
+static struct sysfs_ops subsys_sysfs_ops = {
+	.show	= subsys_attr_show,
+	.store	= subsys_attr_store,
+};
+
 /**
  *	sysfs_read_file - read an attribute. 
  *	@file:	file pointer.
@@ -265,9 +302,14 @@
 
 	if (!kobj || !attr)
 		goto Einval;
-	
+
+	/* if the kobject has no subsystem, then it is a subsystem itself,
+	 * so give it the subsys_sysfs_ops.
+	 */
 	if (kobj->subsys)
 		ops = kobj->subsys->sysfs_ops;
+	else
+		ops = &subsys_sysfs_ops;
 
 	/* No sysfs operations, either from having no subsystem,
 	 * or the subsystem have no operations.
diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	Mon Nov 25 11:28:31 2002
+++ b/include/linux/kobject.h	Mon Nov 25 11:28:31 2002
@@ -60,4 +60,13 @@
 	kobject_put(&s->kobj);
 }
 
+struct subsys_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct subsystem *, char *, size_t, loff_t);
+	ssize_t (*store)(struct subsystem *, const char *, size_t, loff_t); 
+};
+
+extern int subsys_create_file(struct subsystem * , struct subsys_attribute *);
+extern void subsys_remove_file(struct subsystem * , struct subsys_attribute *);
+
 #endif /* _KOBJECT_H_ */
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Mon Nov 25 11:28:31 2002
+++ b/lib/kobject.c	Mon Nov 25 11:28:31 2002
@@ -229,6 +229,38 @@
 }
 
 
+/**
+ *	subsystem_create_file - export sysfs attribute file.
+ *	@s:	subsystem.
+ *	@a:	subsystem attribute descriptor.
+ */
+
+int subsys_create_file(struct subsystem * s, struct subsys_attribute * a)
+{
+	int error = 0;
+	if (subsys_get(s)) {
+		error = sysfs_create_file(&s->kobj,&a->attr);
+		subsys_put(s);
+	}
+	return error;
+}
+
+
+/**
+ *	subsystem_remove_file - remove sysfs attribute file.
+ *	@s:	subsystem.
+ *	@a:	attribute desciptor.
+ */
+
+void subsys_remove_file(struct subsystem * s, struct subsys_attribute * a)
+{
+	if (subsys_get(s)) {
+		sysfs_remove_file(&s->kobj,&a->attr);
+		subsys_put(s);
+	}
+}
+
+
 EXPORT_SYMBOL(kobject_init);
 EXPORT_SYMBOL(kobject_register);
 EXPORT_SYMBOL(kobject_unregister);
@@ -238,3 +270,5 @@
 EXPORT_SYMBOL(subsystem_init);
 EXPORT_SYMBOL(subsystem_register);
 EXPORT_SYMBOL(subsystem_unregister);
+EXPORT_SYMBOL(subsys_create_file);
+EXPORT_SYMBOL(subsys_remove_file);


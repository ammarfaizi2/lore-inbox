Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbTDYEIc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 00:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbTDYEIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 00:08:32 -0400
Received: from fmr02.intel.com ([192.55.52.25]:26857 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262894AbTDYEI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 00:08:26 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C592420@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add generic file support to sysfs ...
Date: Thu, 24 Apr 2003 21:20:27 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C30AE2.00135720"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C30AE2.00135720
Content-Type: text/plain;
	charset="iso-8859-1"


Hi Patrick

How opposed would you be to something like this? [see inlined patch below]

Basically I am adding the ability to create short of an "attribute"
that has specific file_operations and a private pointer. The struct
generic_file contains that. Once any of the fops is called, from
the file->f_dentry->d_fsdata it is possible to get to the 'struct
generic_file', from where the 'private' pointer can be obtained
for whatever purpose.

[as a matter of fact, I could just put the 'generic_file->private'
ptr in f_dentry->d_fsdata and things would be the same].

Usage for this: I am working in this 'kue' silly thing for event
delivery, and I wanted to be able to have a /sysfs/events/ directory,
and then, on there, different files for different message queues.

Some other people around here also voiced that it'd be interesting
to have it.

Only issue I see right now is that it is left to the fops to 
do kobject_{get,put}() management of the parent. Maybe they could be 
wrapped in tin foil, do the get(), call the actual method, do the put()
and return the obtained value ... but I am not sure this is really
needed.

Need to clean up this patch, though, this is just a draft. If 
you are ok, I want to add some doc in Documentation/ and whatever
else you/anyone else might need/want.

If not ok ... why? :)

Thanks,

PS: Patch is vs. 2.5.66 ... should patch fine in others as long
as the bin support is there already.

diff -u -r1.1.1.2 -r1.1.1.2.4.1
--- fs/sysfs/Makefile	8 Mar 2003 01:31:15 -0000	1.1.1.2
+++ fs/sysfs/Makefile	25 Apr 2003 04:03:27 -0000	1.1.1.2.4.1
@@ -2,4 +2,5 @@
 # Makefile for the sysfs virtual filesystem
 #
 
-obj-y		:= inode.o file.o dir.o symlink.o mount.o bin.o
+obj-y		:= inode.o file.o dir.o symlink.o mount.o bin.o gfile.o
+
diff -N fs/sysfs/gfile.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ fs/sysfs/gfile.c	25 Apr 2003 04:03:52 -0000	1.1.2.1
@@ -0,0 +1,62 @@
+/*
+ * gfile.c - general file operations for sysfs.
+ */
+
+#include <linux/fs.h>
+#include <linux/kobject.h>
+
+#include "sysfs.h"
+
+
+/**
+ *	sysfs_create_generic_file - create generic file for object.
+ *	@kobj:	object.
+ *	@gfile:	generic file descriptor.
+ *
+ */
+
+int sysfs_create_generic_file(struct kobject * kobj, struct generic_file *
gfile)
+{
+	struct dentry * dentry;
+	struct dentry * parent;
+	int error = 0;
+
+	if (!kobj || !gfile)
+		return -EINVAL;
+
+	parent = kobj->dentry;
+
+	down(&parent->d_inode->i_sem);
+	dentry = sysfs_get_dentry(parent,gfile->attr.name);
+	if (!IS_ERR(dentry)) {
+		dentry->d_fsdata = (void *)gfile;
+		error = sysfs_create(dentry,
+				     (gfile->attr.mode & S_IALLUGO) |
S_IFREG,
+				     NULL);
+		if (!error) {
+			dentry->d_inode->i_size = 0;
+			dentry->d_inode->i_fop = &gfile->fops;
+		}
+	} else
+		error = PTR_ERR(dentry);
+	up(&parent->d_inode->i_sem);
+	return error;
+}
+
+
+/**
+ *	sysfs_remove_generic_file - remove generic file for object.
+ *	@kobj:	object.
+ *	@gfile:	generic file descriptor.
+ *
+ */
+
+int sysfs_remove_generic_file (struct kobject * kobj,
+			       struct generic_file *gfile)
+{
+	sysfs_hash_and_remove(kobj->dentry,gfile->attr.name);
+	return 0;
+}
+
+EXPORT_SYMBOL(sysfs_create_generic_file);
+EXPORT_SYMBOL(sysfs_remove_generic_file);
diff -u -r1.1.1.2 -r1.1.1.2.4.1
--- include/linux/sysfs.h	8 Mar 2003 01:31:18 -0000	1.1.1.2
+++ include/linux/sysfs.h	25 Apr 2003 04:04:42 -0000	1.1.1.2.4.1
@@ -30,6 +30,12 @@
 	ssize_t (*write)(struct kobject *, struct sysfs_bin_buffer *);
 };
 
+struct generic_file {
+	struct attribute         attr;
+	struct file_operations * fops;
+	void *                   private;
+};
+
 struct sysfs_ops {
 	ssize_t	(*show)(struct kobject *, struct attribute *,char *);
 	ssize_t	(*store)(struct kobject *,struct attribute *,const char *,
size_t);
@@ -55,5 +61,13 @@
 
 extern void
 sysfs_remove_link(struct kobject *, char * name);
+
+extern int
+sysfs_create_generic_file (struct kobject *,
+			   struct generic_file *);
+
+extern int
+sysfs_remove_generic_file (struct kobject *,
+			   struct generic_file *);
 
 #endif /* _SYSFS_H_ */

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)


------_=_NextPart_000_01C30AE2.00135720
Content-Type: application/octet-stream;
	name="gfile-2.5.66-draft.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="gfile-2.5.66-draft.patch"

diff -u -r1.1.1.2 -r1.1.1.2.4.1=0A=
--- fs/sysfs/Makefile	8 Mar 2003 01:31:15 -0000	1.1.1.2=0A=
+++ fs/sysfs/Makefile	25 Apr 2003 04:03:27 -0000	1.1.1.2.4.1=0A=
@@ -2,4 +2,5 @@=0A=
 # Makefile for the sysfs virtual filesystem=0A=
 #=0A=
 =0A=
-obj-y		:=3D inode.o file.o dir.o symlink.o mount.o bin.o=0A=
+obj-y		:=3D inode.o file.o dir.o symlink.o mount.o bin.o gfile.o=0A=
+=0A=
diff -N fs/sysfs/gfile.c=0A=
--- /dev/null	1 Jan 1970 00:00:00 -0000=0A=
+++ fs/sysfs/gfile.c	25 Apr 2003 04:03:52 -0000	1.1.2.1=0A=
@@ -0,0 +1,62 @@=0A=
+/*=0A=
+ * gfile.c - general file operations for sysfs.=0A=
+ */=0A=
+=0A=
+#include <linux/fs.h>=0A=
+#include <linux/kobject.h>=0A=
+=0A=
+#include "sysfs.h"=0A=
+=0A=
+=0A=
+/**=0A=
+ *	sysfs_create_generic_file - create generic file for object.=0A=
+ *	@kobj:	object.=0A=
+ *	@gfile:	generic file descriptor.=0A=
+ *=0A=
+ */=0A=
+=0A=
+int sysfs_create_generic_file(struct kobject * kobj, struct =
generic_file * gfile)=0A=
+{=0A=
+	struct dentry * dentry;=0A=
+	struct dentry * parent;=0A=
+	int error =3D 0;=0A=
+=0A=
+	if (!kobj || !gfile)=0A=
+		return -EINVAL;=0A=
+=0A=
+	parent =3D kobj->dentry;=0A=
+=0A=
+	down(&parent->d_inode->i_sem);=0A=
+	dentry =3D sysfs_get_dentry(parent,gfile->attr.name);=0A=
+	if (!IS_ERR(dentry)) {=0A=
+		dentry->d_fsdata =3D (void *)gfile;=0A=
+		error =3D sysfs_create(dentry,=0A=
+				     (gfile->attr.mode & S_IALLUGO) | S_IFREG,=0A=
+				     NULL);=0A=
+		if (!error) {=0A=
+			dentry->d_inode->i_size =3D 0;=0A=
+			dentry->d_inode->i_fop =3D &gfile->fops;=0A=
+		}=0A=
+	} else=0A=
+		error =3D PTR_ERR(dentry);=0A=
+	up(&parent->d_inode->i_sem);=0A=
+	return error;=0A=
+}=0A=
+=0A=
+=0A=
+/**=0A=
+ *	sysfs_remove_generic_file - remove generic file for object.=0A=
+ *	@kobj:	object.=0A=
+ *	@gfile:	generic file descriptor.=0A=
+ *=0A=
+ */=0A=
+=0A=
+int sysfs_remove_generic_file (struct kobject * kobj,=0A=
+			       struct generic_file *gfile)=0A=
+{=0A=
+	sysfs_hash_and_remove(kobj->dentry,gfile->attr.name);=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+EXPORT_SYMBOL(sysfs_create_generic_file);=0A=
+EXPORT_SYMBOL(sysfs_remove_generic_file);=0A=
diff -u -r1.1.1.2 -r1.1.1.2.4.1=0A=
--- include/linux/sysfs.h	8 Mar 2003 01:31:18 -0000	1.1.1.2=0A=
+++ include/linux/sysfs.h	25 Apr 2003 04:04:42 -0000	1.1.1.2.4.1=0A=
@@ -30,6 +30,12 @@=0A=
 	ssize_t (*write)(struct kobject *, struct sysfs_bin_buffer *);=0A=
 };=0A=
 =0A=
+struct generic_file {=0A=
+	struct attribute         attr;=0A=
+	struct file_operations * fops;=0A=
+	void *                   private;=0A=
+};=0A=
+=0A=
 struct sysfs_ops {=0A=
 	ssize_t	(*show)(struct kobject *, struct attribute *,char *);=0A=
 	ssize_t	(*store)(struct kobject *,struct attribute *,const char *, =
size_t);=0A=
@@ -55,5 +61,13 @@=0A=
 =0A=
 extern void=0A=
 sysfs_remove_link(struct kobject *, char * name);=0A=
+=0A=
+extern int=0A=
+sysfs_create_generic_file (struct kobject *,=0A=
+			   struct generic_file *);=0A=
+=0A=
+extern int=0A=
+sysfs_remove_generic_file (struct kobject *,=0A=
+			   struct generic_file *);=0A=
 =0A=
 #endif /* _SYSFS_H_ */=0A=

------_=_NextPart_000_01C30AE2.00135720--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbVKWV4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVKWV4h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVKWV4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:56:37 -0500
Received: from digitalimplant.org ([64.62.235.95]:61360 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932559AbVKWV4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:56:36 -0500
Date: Wed, 23 Nov 2005 13:56:29 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: greg@kroah.com
cc: linux-kernel@vger.kernel.org
Subject: [RFC] Updates to sysfs_create_subdir()
Message-ID: <Pine.LNX.4.50.0511231336261.16769-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sysfs_create_subdir() is used by the attribute_group code to create a
subdirectory in sysfs in which to store attributes in a more organized
fashion than in a flat directory. It works well and does exactly as
advertised.

However, I've recently run into a couple of limitations with the interface
The patch below addresses these issues.

First, two different pieces of code cannot create attributes in the same
subdirectory without sharing the attribute_group data structure. For
instance, each device has a 'power' subdirectory (for better or worse :).
It is not (easily) possible for a modular piece of code to add attributes
in the power directory, when what you really want to do is e.g.:

	struct attribute group my_power_attrs = {
		.name = "power",
		...
	};
	...
	sysfs_create_group(dev->kobj, &my_power_attrs);

And have them appear in the right place.

The patch addresses this problem by recognizing when a subdirectory
already exists when a group is added and not returning an error.


Secondly, there is sometimes a need to organize things a bit more than
with just one subdirectory. Sometimes, you may want to separate attributes
based on category, without creating painfully long attribute names. The
patch at:

http://kernel.org/pub/linux/kernel/people/mochel/patches/acpi-cpu-info.patch

illustrates this by putting ACPI C state information for processors into
the subdirectory acpi/pm/c1/ etc. This patch is just an example (though it
is a working one).

The patch below addresses this issue by parsing the subdirectory name and
creating any parent directories delineated by a '/'.

Thoughts?


	Pat



Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 59734ba..cb820ac 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -94,38 +94,127 @@ static int init_symlink(struct inode * i
 }

 static int create_dir(struct kobject * k, struct dentry * p,
-		      const char * n, struct dentry ** d)
+		      struct dentry * dir)
 {
 	int error;
 	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;

-	down(&p->d_inode->i_sem);
-	*d = lookup_one_len(n, p, strlen(n));
-	if (!IS_ERR(*d)) {
-		error = sysfs_make_dirent(p->d_fsdata, *d, k, mode, SYSFS_DIR);
+	error = sysfs_make_dirent(p->d_fsdata, dir, k, mode, SYSFS_DIR);
+	if (!error) {
+		error = sysfs_create(dir, mode, init_dir);
 		if (!error) {
-			error = sysfs_create(*d, mode, init_dir);
-			if (!error) {
-				p->d_inode->i_nlink++;
-				(*d)->d_op = &sysfs_dentry_ops;
-				d_rehash(*d);
-			}
-		}
-		if (error && (error != -EEXIST)) {
-			sysfs_put((*d)->d_fsdata);
-			d_drop(*d);
+			p->d_inode->i_nlink++;
+			dir->d_op = &sysfs_dentry_ops;
+			d_rehash(dir);
 		}
-		dput(*d);
+		dput(dir);
+	}
+	if (error && (error != -EEXIST)) {
+		sysfs_put((dir)->d_fsdata);
+		d_drop(dir);
+	}
+
+	return error;
+}
+
+static int make_one_dir(struct kobject * k, struct dentry * parent,
+			char * name, struct dentry ** d)
+{
+	struct dentry * dir;
+	int error = 0;
+
+	down(&parent->d_inode->i_sem);
+
+	dir = lookup_one_len(name, parent, strlen(name));
+
+	if (!IS_ERR(dir)) {
+		/*
+		 * Check if directory does or does not exist.
+		 * If it does, then return that dentry.
+		 * Otherwise go ahead and create it.
+		 */
+		if (!dir->d_inode)
+			error = create_dir(k, parent, dir);
 	} else
-		error = PTR_ERR(*d);
-	up(&p->d_inode->i_sem);
+		error = PTR_ERR(dir);
+	up(&parent->d_inode->i_sem);
+
+	if (!error)
+		*d = dir;
+
 	return error;
 }


+/**
+ *	sysfs_create_subdir - Create one or more subdirectories in sysfs
+ *	@k:	kobject that owns the ancestral directory.
+ *	@n:	Directory (or directories) to be added.
+ *	@d:	The dentry of the bottom-most directory.
+ *
+ *	This function creates one or more subdirectories in a kobject's
+ *	sysfs directory, which can be used to add attributes for that
+ *	kobject (in an organized fashion).
+ *
+ *	The algorithm is simple: it scans @n for '/', replaces each
+ *	occurence with a NULL character and creates a directory with the name
+ *	of that resulting string. It continues until it reaches the end of @n.
+ *
+ *	For example, if @k had a directory at /sys/devices/my-device/, and
+ *	this function was called with @n == "foo/bar/baz", the resulting
+ *	directory structure would look like:
+ *
+ *	/sys/devices/my-device/
+ *	`-- foo
+ *	    `-- bar
+ *	        `-- baz
+ *
+ *	And the dentry to 'baz' would be passed back in @d.
+ *
+ *	Note that this function and its helpers have recently been updated to
+ *	recognize when a subdirectory has already been created and to return
+ *	without an error. So, after the above example was finished, a caller
+ *	could call this function with the same @k and @n == "foo". A new
+ *	directory would not be created and the dentry for 'foo' would be
+ *	returned in @d.
+ */
+
 int sysfs_create_subdir(struct kobject * k, const char * n, struct dentry ** d)
 {
-	return create_dir(k,k->dentry,n,d);
+	struct dentry * parent = k->dentry;
+	struct dentry * dir;
+	char * str, * s;
+	char * next;
+	int ret;
+
+	s = str = kstrdup(n, GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	while ((next = strchr(str, '/'))) {
+		*next++ = '\0';
+
+		/*
+		 * Check if it's the end of the string anyway
+		 */
+		if (*next == '\0')
+			break;
+
+		ret = make_one_dir(k, parent, str, &dir);
+		if (ret)
+			goto Done;
+
+		str = next;
+		parent = dir;
+	}
+
+	/*
+	 * Make the final directory (where the files will go).
+	 */
+	ret = make_one_dir(k, parent, str, d);
+ Done:
+	kfree(s);
+	return ret;
 }

 /**
@@ -136,7 +225,8 @@ int sysfs_create_subdir(struct kobject *

 int sysfs_create_dir(struct kobject * kobj)
 {
-	struct dentry * dentry = NULL;
+	const char * name = kobject_name(kobj);
+	struct dentry * dir;
 	struct dentry * parent;
 	int error = 0;

@@ -149,9 +239,16 @@ int sysfs_create_dir(struct kobject * ko
 	else
 		return -EFAULT;

-	error = create_dir(kobj,parent,kobject_name(kobj),&dentry);
+	down(&parent->d_inode->i_sem);
+	dir = lookup_one_len(name, parent, strlen(name));
+	if (!IS_ERR(dir))
+		error = create_dir(kobj, parent, dir);
+	else
+		error = PTR_ERR(dir);
+	up(&parent->d_inode->i_sem);
+
 	if (!error)
-		kobj->dentry = dentry;
+		kobj->dentry = dir;
 	return error;
 }


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTH2WCv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 18:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTH2WCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 18:02:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:64915 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262167AbTH2WCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 18:02:15 -0400
Date: Fri, 29 Aug 2003 14:59:43 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
cc: <davidm@napali.hpl.hp.com>, <linux-ia64@vger.kernel.org>,
       <Matt_Domsch@Dell.com>, <linux-kernel@vger.kernel.org>,
       <matthew.e.tolentino@intel.com>
Subject: Re: [PATCH] efivars update
In-Reply-To: <200308292124.h7TLOCAZ000785@snoqualmie.dp.intel.com>
Message-ID: <Pine.LNX.4.33.0308291448340.944-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A while back I posted a patch that moved the EFI variable services driver (efivars) to a new drivers/efi directory.  As EFI driver are typically platform/architecturally independent, it seems like a good idea to collect them in a common place.  Pat suggested the efivars driver should be converted to use sysfs rather than proc....so here you go.  As such, this patch does several things:
> 
> + Adds a new driver directory drivers/efi.
> + Adds a new generic config option for EFI drivers - CONFIG_EFI
> + Moves efivars from arch/ia64/kernel to drivers/efi
> + Allows EFI variables to be read/created/deleted/modified via sysfs
> + Bumps the driver revision level up to 0.07 to reflect these changes
> 
> Within the sysfs hierarchy, I've created an efi subsystem under which future
> EFI related information might be exported.  I've also created another subsystem vars that manages/exports EFI variable information.  

Hey, neat. :) 

Would you mind posting the output of tree(1) of the sysfs hierarchy of one 
of the sytems? 

> Note, this patch relies upon the kobject_set_name() call recently introduced by Pat Mochel in order to export the long gvariable name-guid combinations needed to accurately identify variables of the same name.  

That patch is below. I'll be sending it to Linus once he gets back from
vacation, unless anyone has any serious objections to it. Note that it
completely removes any limitation on the length of a kobject (and sysfs
directory) name.



	Pat

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1163  -> 1.1166 
#	include/linux/kobject.h	1.23    -> 1.24   
#	      fs/sysfs/dir.c	1.10    -> 1.11   
#	       lib/kobject.c	1.27    -> 1.28   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/29	mochel@osdl.org	1.1164
# [kobject] Support unlimited name lengths.
# 
# Add ->k_name pointer which points to the name for a kobject. By default, this
# points to ->name (the static name array). 
#  
# Users of kobjects may use the helper function kobject_set_name() (and are 
# encouraged to do so in all cases). This function will determined whether or
# not the name is short enough to fit in ->name. If so, great. 
# 
# Otherwise, a dyanamic string is allocated and the name is stored there. 
# ->k_name will point to that, and will be freed when the kobject is released. 
# 
# kobject_set_name() may take a format string, like:
# 
# 	kobject_set_name(kobj,"%s%d",base_name,id); 
# 
# and will behave as expected (will put in ->name, unless it's too long, in 
# which case a new string will be allocated and it will be stored in there). 
# --------------------------------------------
# 03/08/29	mochel@osdl.org	1.1166
# [sysfs] Use kobject_name() when creating directories for kobjects.
# --------------------------------------------
#
diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	Fri Aug 29 14:56:56 2003
+++ b/fs/sysfs/dir.c	Fri Aug 29 14:56:56 2003
@@ -71,7 +71,7 @@
 	else
 		return -EFAULT;
 
-	dentry = create_dir(kobj,parent,kobj->name);
+	dentry = create_dir(kobj,parent,kobject_name(kobj));
 	if (!IS_ERR(dentry))
 		kobj->dentry = dentry;
 	else
@@ -158,7 +158,7 @@
 {
 	struct dentry * new_dentry, * parent;
 
-	if (!strcmp(kobj->name, new_name))
+	if (!strcmp(kobject_name(kobj), new_name))
 		return;
 
 	if (!kobj->parent)
@@ -170,9 +170,7 @@
 
 	new_dentry = sysfs_get_dentry(parent, new_name);
 	d_move(kobj->dentry, new_dentry);
-
-	strlcpy(kobj->name, new_name, KOBJ_NAME_LEN);
-
+	kobject_set_name(kobj,new_name);
 	up(&parent->d_inode->i_sem);	
 }
 
diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	Fri Aug 29 14:56:56 2003
+++ b/include/linux/kobject.h	Fri Aug 29 14:56:56 2003
@@ -24,6 +24,7 @@
 #define KOBJ_NAME_LEN	20
 
 struct kobject {
+	char			* k_name;
 	char			name[KOBJ_NAME_LEN];
 	atomic_t		refcount;
 	struct list_head	entry;
@@ -32,6 +33,14 @@
 	struct kobj_type	* ktype;
 	struct dentry		* dentry;
 };
+
+extern int kobject_set_name(struct kobject *, const char *, ...)
+	__attribute__((format(printf,2,3)));
+
+static inline char * kobject_name(struct kobject * kobj)
+{
+	return kobj->k_name;
+}
 
 extern void kobject_init(struct kobject *);
 extern void kobject_cleanup(struct kobject *);
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Fri Aug 29 14:56:56 2003
+++ b/lib/kobject.c	Fri Aug 29 14:56:56 2003
@@ -48,7 +48,7 @@
 static int create_dir(struct kobject * kobj)
 {
 	int error = 0;
-	if (strlen(kobj->name)) {
+	if (kobject_name(kobj)) {
 		error = sysfs_create_dir(kobj);
 		if (!error) {
 			if ((error = populate_dir(kobj)))
@@ -76,7 +76,7 @@
 	 * Add 1 to strlen for leading '/' of each level.
 	 */
 	do {
-		length += strlen (parent->name) + 1;
+		length += strlen(kobject_name(parent)) + 1;
 		parent = parent->parent;
 	} while (parent);
 	return length;
@@ -88,10 +88,10 @@
 
 	--length;
 	for (parent = kobj; parent; parent = parent->parent) {
-		int cur = strlen (parent->name);
+		int cur = strlen(kobject_name(parent));
 		/* back up enough to print this name with '/' */
 		length -= cur;
-		strncpy (path + length, parent->name, cur);
+		strncpy (path + length, kobject_name(parent), cur);
 		*(path + --length) = '/';
 	}
 
@@ -254,11 +254,12 @@
 
 	if (!(kobj = kobject_get(kobj)))
 		return -ENOENT;
-
+	if (!kobj->k_name)
+		kobj->k_name = kobj->name;
 	parent = kobject_get(kobj->parent);
 
 	pr_debug("kobject %s: registering. parent: %s, set: %s\n",
-		 kobj->name, parent ? parent->name : "<NULL>", 
+		 kobject_name(kobj), parent ? kobject_name(parent) : "<NULL>", 
 		 kobj->kset ? kobj->kset->kobj.name : "<NULL>" );
 
 	if (kobj->kset) {
@@ -305,7 +306,7 @@
 		error = kobject_add(kobj);
 		if (error) {
 			printk("kobject_register failed for %s (%d)\n",
-			       kobj->name,error);
+			       kobject_name(kobj),error);
 			dump_stack();
 		}
 	} else
@@ -313,6 +314,57 @@
 	return error;
 }
 
+
+/**
+ *	kobject_set_name - Set the name of an object
+ *	@kobj:	object.
+ *	@name:	name. 
+ *
+ *	If strlen(name) < KOBJ_NAME_LEN, then use a dynamically allocated
+ *	string that @kobj->k_name points to. Otherwise, use the static 
+ *	@kobj->name array.
+ */
+
+int kobject_set_name(struct kobject * kobj, const char * fmt, ...)
+{
+	int error = 0;
+	int limit = KOBJ_NAME_LEN;
+	int need;
+	va_list args;
+
+	va_start(args,fmt);
+	/* 
+	 * First, try the static array 
+	 */
+	need = vsnprintf(kobj->name,limit,fmt,args);
+	if (need < limit) 
+		kobj->k_name = kobj->name;
+	else {
+		/* 
+		 * Need more space? Allocate it and try again 
+		 */
+		kobj->k_name = kmalloc(need,GFP_KERNEL);
+		if (!kobj->k_name) {
+			error = -ENOMEM;
+			goto Done;
+		}
+		limit = need;
+		need = vsnprintf(kobj->k_name,limit,fmt,args);
+
+		/* Still? Give up. */
+		if (need > limit) {
+			kfree(kobj->k_name);
+			error = -EFAULT;
+		}
+	}
+ Done:
+	va_end(args);
+	return error;
+}
+
+EXPORT_SYMBOL(kobject_set_name);
+
+
 /**
  *	kobject_rename - change the name of an object
  *	@kobj:	object in question.
@@ -360,7 +412,7 @@
 
 void kobject_unregister(struct kobject * kobj)
 {
-	pr_debug("kobject %s: unregistering\n",kobj->name);
+	pr_debug("kobject %s: unregistering\n",kobject_name(kobj));
 	kobject_del(kobj);
 	kobject_put(kobj);
 }
@@ -392,11 +444,14 @@
 	struct kobj_type * t = get_ktype(kobj);
 	struct kset * s = kobj->kset;
 
-	pr_debug("kobject %s: cleaning up\n",kobj->name);
+	pr_debug("kobject %s: cleaning up\n",kobject_name(kobj));
 	if (t && t->release)
 		t->release(kobj);
 	if (s)
 		kset_put(s);
+	if (kobj->k_name != kobj->name)
+		kfree(kobj->k_name);
+	kobj->k_name = NULL;
 }
 
 /**
@@ -488,7 +543,7 @@
 	down_read(&kset->subsys->rwsem);
 	list_for_each(entry,&kset->list) {
 		struct kobject * k = to_kobj(entry);
-		if (!strcmp(k->name,name)) {
+		if (!strcmp(kobject_name(k),name)) {
 			ret = k;
 			break;
 		}



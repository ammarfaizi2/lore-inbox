Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbSKUXAu>; Thu, 21 Nov 2002 18:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbSKUXAt>; Thu, 21 Nov 2002 18:00:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:49795 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265541AbSKUXAb>;
	Thu, 21 Nov 2002 18:00:31 -0500
Date: Thu, 21 Nov 2002 17:03:44 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use
In-Reply-To: <003701c291aa$a3b28a10$94d40a0a@amr.corp.intel.com>
Message-ID: <Pine.LNX.4.33.0211211637560.913-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-973767115-1037919824=:913"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-973767115-1037919824=:913
Content-Type: TEXT/PLAIN; charset=US-ASCII


> Very cool.  Bitkeeper is one of those things I never bothered
> with yet (mainly because I feel some comfortable with CVS.)
> It looks like it might be worth going through ramp-up time
> on bk to keep up with changes to the kernel.

There are also nightly snapshots, though I don't recall the URL off the 
top of my head..

> > It seems that having a pure sysfs implementation would be superior,
> > instead of having to use a character device to write to. After looking
> > into this, I realize that a couple of pieces of infrastructure are needed,
> > so I'm working on that, and will post a modified version of your module
> > once I'm done..
> 
> I look forward to seeing it.

Ok, there are basically two parts to it: the required modifications to 
sysfs and your updated module. 

The appended patch adds the support to sysfs be defining struct 
subsys_attribute for declaring attributes of subsystems themselves, as 
well as the needed helpers for creation/teardown and read/write. 

I've attached a replacement for noisy.c that creates a sysfs file named 
'ctl' that handles addition and deletion of nprobes, similar to the char 
device you had created. From the top of the file:

/*
 * Noisy Interface for Linux
 *
 * This driver allows arbitrary printk's to be inserted into
 * executing kernel code by using the new kprobes interface.
 * A message is attached to an address, and when that address
 * is reached, the message is printed. 
 *
 * This uses a sysfs control file to manage a list of probes. 
 * The sysfs directory is at
 *
 * /sys/noisy/
 *
 * and the control is named 'ctl'. 
 *
 * A Noisy Probe can be added by echoing into the file, like:
 *
 *	$ echo "add <address> <message>" > /sys/noisy/ctl
 *
 * where <address> is the address to break on, and <message> 
 * is the message to print when the address is reached. 
 *
 * Probes can be removed by doing:
 *
 *	$ echo "del <address>" > /sys/noisy/ctl
 *
 * where <address> is the address of the probe.
 *
 * The probes themselves get a directory under /sys/noisy/, and
 * the name of the directory is the address of the probe. Each
 * probe directory contains one file ('message') that contains
 * the message to be printed. (More may be added later).
 */

I've tried to comment the changes and the necessary steps in making this 
work. 

[ Note: While I'm generally happy with the way things work, I realize that 
it still requires a decent amount of overhead in using the sysfs interface 
(see the file). I'll be looking into shrinking this...]

Everything seems to work..

> It looks like the patch is against the bk tree, and does not apply cleanly
> to
> strait 2.5.48.  I don't know how much has changed to sysfs/inode.c, but
> I can see where the last hunk is looking too far up, so I'll try it anyway.

Ah yes, I forgot there was a patch applied to sysfs since 2.5.48. I've 
included everything since 2.5.48 in the one I've appended. 


	-pat

===== fs/sysfs/inode.c 1.60 vs 1.67 =====
--- 1.60/fs/sysfs/inode.c	Sat Nov 16 15:01:34 2002
+++ 1.67/fs/sysfs/inode.c	Thu Nov 21 17:01:53 2002
@@ -23,6 +23,8 @@
  * Please see Documentation/filesystems/sysfs.txt for more information.
  */
 
+#undef DEBUG 
+
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
@@ -87,16 +89,17 @@
 	return inode;
 }
 
-static int sysfs_mknod(struct inode *dir, struct dentry *dentry, int mode, int dev)
+static int sysfs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
 	struct inode *inode;
 	int error = 0;
 
 	if (!dentry->d_inode) {
 		inode = sysfs_get_inode(dir->i_sb, mode, dev);
-		if (inode)
+		if (inode) {
 			d_instantiate(dentry, inode);
-		else
+			dget(dentry);
+		} else
 			error = -ENOSPC;
 	} else
 		error = -EEXIST;
@@ -142,17 +145,43 @@
 	return error;
 }
 
-static int sysfs_unlink(struct inode *dir, struct dentry *dentry)
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
 {
-	struct inode *inode = dentry->d_inode;
-	down(&inode->i_sem);
-	dentry->d_inode->i_nlink--;
-	up(&inode->i_sem);
-	d_invalidate(dentry);
-	dput(dentry);
-	return 0;
+	struct subsystem * s = to_subsys(kobj);
+	struct subsys_attribute * sattr = to_sattr(attr);
+	ssize_t ret = 0;
+
+	if (sattr->show)
+		ret = sattr->show(s,page,count,off);
+	return ret;
 }
 
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
@@ -173,17 +202,11 @@
 sysfs_read_file(struct file *file, char *buf, size_t count, loff_t *ppos)
 {
 	struct attribute * attr = file->f_dentry->d_fsdata;
-	struct sysfs_ops * ops = NULL;
-	struct kobject * kobj;
+	struct sysfs_ops * ops = file->private_data;
+	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
 	unsigned char *page;
 	ssize_t retval = 0;
 
-	kobj = file->f_dentry->d_parent->d_fsdata;
-	if (kobj && kobj->subsys)
-		ops = kobj->subsys->sysfs_ops;
-	if (!ops || !ops->show)
-		return 0;
-
 	if (count > PAGE_SIZE)
 		count = PAGE_SIZE;
 
@@ -234,16 +257,11 @@
 sysfs_write_file(struct file *file, const char *buf, size_t count, loff_t *ppos)
 {
 	struct attribute * attr = file->f_dentry->d_fsdata;
-	struct sysfs_ops * ops = NULL;
-	struct kobject * kobj;
+	struct sysfs_ops * ops = file->private_data;
+	struct kobject * kobj = file->f_dentry->d_parent->d_fsdata;
 	ssize_t retval = 0;
 	char * page;
 
-	kobj = file->f_dentry->d_parent->d_fsdata;
-	if (kobj && kobj->subsys)
-		ops = kobj->subsys->sysfs_ops;
-	if (!ops || !ops->store)
-		return 0;
 
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page)
@@ -275,21 +293,77 @@
 	return retval;
 }
 
-static int sysfs_open_file(struct inode * inode, struct file * filp)
+static int check_perm(struct inode * inode, struct file * file)
 {
-	struct kobject * kobj;
+	struct kobject * kobj = kobject_get(file->f_dentry->d_parent->d_fsdata);
+	struct attribute * attr = file->f_dentry->d_fsdata;
+	struct sysfs_ops * ops = NULL;
 	int error = 0;
 
-	kobj = filp->f_dentry->d_parent->d_fsdata;
-	if ((kobj = kobject_get(kobj))) {
-		struct attribute * attr = filp->f_dentry->d_fsdata;
-		if (!attr)
-			error = -EINVAL;
-	} else
-		error = -EINVAL;
+	if (!kobj || !attr)
+		goto Einval;
+
+	/* if the kobject has no subsystem, then it is a subsystem itself,
+	 * so give it the subsys_sysfs_ops.
+	 */
+	if (kobj->subsys)
+		ops = kobj->subsys->sysfs_ops;
+	else
+		ops = &subsys_sysfs_ops;
+
+	/* No sysfs operations, either from having no subsystem,
+	 * or the subsystem have no operations.
+	 */
+	if (!ops)
+		goto Eaccess;
+
+	/* File needs write support.
+	 * The inode's perms must say it's ok, 
+	 * and we must have a store method.
+	 */
+	if (file->f_mode & FMODE_WRITE) {
+
+		if (!(inode->i_mode & S_IWUGO))
+			goto Eperm;
+		if (!ops->store)
+			goto Eaccess;
+
+	}
+
+	/* File needs read support.
+	 * The inode's perms must say it's ok, and we there
+	 * must be a show method for it.
+	 */
+	if (file->f_mode & FMODE_READ) {
+		if (!(inode->i_mode & S_IRUGO))
+			goto Eperm;
+		if (!ops->show)
+			goto Eaccess;
+	}
+
+	/* No error? Great, store the ops in file->private_data
+	 * for easy access in the read/write functions.
+	 */
+	file->private_data = ops;
+	goto Done;
+
+ Einval:
+	error = -EINVAL;
+	goto Done;
+ Eaccess:
+	error = -EACCES;
+	goto Done;
+ Eperm:
+	error = -EPERM;
+ Done:
 	return error;
 }
 
+static int sysfs_open_file(struct inode * inode, struct file * filp)
+{
+	return check_perm(inode,filp);
+}
+
 static int sysfs_release(struct inode * inode, struct file * filp)
 {
 	struct kobject * kobj = filp->f_dentry->d_parent->d_fsdata;
@@ -541,7 +615,8 @@
 		/* make sure dentry is really there */
 		if (victim->d_inode && 
 		    (victim->d_parent->d_inode == dir->d_inode)) {
-			sysfs_unlink(dir->d_inode,victim);
+			simple_unlink(dir->d_inode,victim);
+			d_delete(victim);
 		}
 	}
 	up(&dir->d_inode->i_sem);
@@ -599,19 +674,16 @@
 	list_for_each_safe(node,next,&dentry->d_subdirs) {
 		struct dentry * d = list_entry(node,struct dentry,d_child);
 		/* make sure dentry is still there */
-		if (d->d_inode)
-			sysfs_unlink(dentry->d_inode,d);
+		if (d->d_inode) {
+			simple_unlink(dentry->d_inode,d);
+			d_delete(dentry);
+		}
 	}
 
-	d_invalidate(dentry);
-	if (simple_empty(dentry)) {
-		dentry->d_inode->i_nlink -= 2;
-		dentry->d_inode->i_flags |= S_DEAD;
-		parent->d_inode->i_nlink--;
-	}
 	up(&dentry->d_inode->i_sem);
-	dput(dentry);
-
+	d_invalidate(dentry);
+	simple_rmdir(parent->d_inode,dentry);
+	d_delete(dentry);
 	up(&parent->d_inode->i_sem);
 	dput(parent);
 }
@@ -622,4 +694,3 @@
 EXPORT_SYMBOL(sysfs_remove_link);
 EXPORT_SYMBOL(sysfs_create_dir);
 EXPORT_SYMBOL(sysfs_remove_dir);
-MODULE_LICENSE("GPL");

--8323328-973767115-1037919824=:913
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="noisy.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0211211703440.913@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="noisy.c"

LyoNCiAqIE5vaXN5IEludGVyZmFjZSBmb3IgTGludXgNCiAqDQogKiBUaGlz
IGRyaXZlciBhbGxvd3MgYXJiaXRyYXJ5IHByaW50aydzIHRvIGJlIGluc2Vy
dGVkIGludG8NCiAqIGV4ZWN1dGluZyBrZXJuZWwgY29kZSBieSB1c2luZyB0
aGUgbmV3IGtwcm9iZXMgaW50ZXJmYWNlLg0KICogQSBtZXNzYWdlIGlzIGF0
dGFjaGVkIHRvIGFuIGFkZHJlc3MsIGFuZCB3aGVuIHRoYXQgYWRkcmVzcw0K
ICogaXMgcmVhY2hlZCwgdGhlIG1lc3NhZ2UgaXMgcHJpbnRlZC4gDQogKg0K
ICogVGhpcyB1c2VzIGEgc3lzZnMgY29udHJvbCBmaWxlIHRvIG1hbmFnZSBh
IGxpc3Qgb2YgcHJvYmVzLiANCiAqIFRoZSBzeXNmcyBkaXJlY3RvcnkgaXMg
YXQNCiAqDQogKiAvc3lzL25vaXN5Lw0KICoNCiAqIGFuZCB0aGUgY29udHJv
bCBpcyBuYW1lZCAnY3RsJy4gDQogKg0KICogQSBOb2lzeSBQcm9iZSBjYW4g
YmUgYWRkZWQgYnkgZWNob2luZyBpbnRvIHRoZSBmaWxlLCBsaWtlOg0KICoN
CiAqCSQgZWNobyAiYWRkIDxhZGRyZXNzPiA8bWVzc2FnZT4iID4gL3N5cy9u
b2lzeS9jdGwNCiAqDQogKiB3aGVyZSA8YWRkcmVzcz4gaXMgdGhlIGFkZHJl
c3MgdG8gYnJlYWsgb24sIGFuZCA8bWVzc2FnZT4gDQogKiBpcyB0aGUgbWVz
c2FnZSB0byBwcmludCB3aGVuIHRoZSBhZGRyZXNzIGlzIHJlYWNoZWQuIA0K
ICoNCiAqIFByb2JlcyBjYW4gYmUgcmVtb3ZlZCBieSBkb2luZzoNCiAqDQog
KgkkIGVjaG8gImRlbCA8YWRkcmVzcz4iID4gL3N5cy9ub2lzeS9jdGwNCiAq
DQogKiB3aGVyZSA8YWRkcmVzcz4gaXMgdGhlIGFkZHJlc3Mgb2YgdGhlIHBy
b2JlLg0KICoNCiAqIFRoZSBwcm9iZXMgdGhlbXNlbHZlcyBnZXQgYSBkaXJl
Y3RvcnkgdW5kZXIgL3N5cy9ub2lzeS8sIGFuZA0KICogdGhlIG5hbWUgb2Yg
dGhlIGRpcmVjdG9yeSBpcyB0aGUgYWRkcmVzcyBvZiB0aGUgcHJvYmUuIEVh
Y2gNCiAqIHByb2JlIGRpcmVjdG9yeSBjb250YWlucyBvbmUgZmlsZSAoJ21l
c3NhZ2UnKSB0aGF0IGNvbnRhaW5zDQogKiB0aGUgbWVzc2FnZSB0byBiZSBw
cmludGVkLiAoTW9yZSBtYXkgYmUgYWRkZWQgbGF0ZXIpLg0KICoNCiAqIENv
cHlyaWdodCAoQykgMjAwMiBSdXN0eSBMeW5jaCA8cnVzdHlAbGludXguaW50
ZWwuY29tPg0KICovDQoNCiNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiNp
bmNsdWRlIDxsaW51eC9pbml0Lmg+DQojaW5jbHVkZSA8bGludXgva3Byb2Jl
cy5oPg0KI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCiNpbmNsdWRlIDxsaW51
eC9rb2JqZWN0Lmg+DQoNCi8qIGV4cG9ydGVkIGJ5IGFyY2gvWU9VUkFSQ0gv
a2VybmVsL3RyYXBzLmMgKi8NCmV4dGVybiBpbnQgdmFsaWRfa2VybmVsX2Fk
ZHJlc3ModW5zaWduZWQgbG9uZyk7DQoNCiNkZWZpbmUgTUFYX01TR19TSVpF
IDEyOA0KDQojZGVmaW5lIHRvX25wcm9iZShlbnRyeSkgY29udGFpbmVyX29m
KGVudHJ5LHN0cnVjdCBucHJvYmUsa29iai5lbnRyeSk7DQoNCnN0YXRpYyBE
RUNMQVJFX01VVEVYKG5vaXN5X3NlbSk7DQpzdGF0aWMgc3RydWN0IHN1YnN5
c3RlbSBub2lzeV9zdWJzeXM7DQoNCi8qDQogKiBzdHJ1Y3QgbnJwb2JlOiBk
YXRhIHN0cnVjdHVyZSBmb3IgbWFuYWdpbmcgbGlzdCBvZiBwcm9iZSBwb2lu
dHMNCiAqLw0Kc3RydWN0IG5wcm9iZSB7DQoJc3RydWN0IGtwcm9iZSBwcm9i
ZTsNCgljaGFyIG1lc3NhZ2VbTUFYX01TR19TSVpFICsgMV07DQoJc3RydWN0
IGtvYmplY3Qga29iajsNCn07DQoNCi8qIA0KICogUHJvYmUgaGFuZGxlcnMu
DQogKiBPbmx5IG9uZSBpcyB1c2VkIChwcmUpIHRvIHByaW50IHRoZSBtZXNz
YWdlIG91dC4NCiAqLw0Kc3RhdGljIHZvaWQgbm9pc3lfcHJlX2hhbmRsZXIo
c3RydWN0IGtwcm9iZSAqcCwgc3RydWN0IHB0X3JlZ3MgKnIpDQp7DQoJc3Ry
dWN0IG5wcm9iZSAqYyA9IGNvbnRhaW5lcl9vZihwLCBzdHJ1Y3QgbnByb2Jl
LCBwcm9iZSk7DQoJcHJpbnRrKEtFUk5fQ1JJVCAiJXM6ICVzXG4iLCBfX0ZV
TkNUSU9OX18sIGMtPm1lc3NhZ2UpOw0KfQ0KDQpzdGF0aWMgdm9pZCBub2lz
eV9wb3N0X2hhbmRsZXIoc3RydWN0IGtwcm9iZSAqcCwgc3RydWN0IHB0X3Jl
Z3MgKnIsIA0KCQkJICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3MpDQp7IH0N
Cg0Kc3RhdGljIGludCBub2lzeV9mYXVsdF9oYW5kbGVyKHN0cnVjdCBrcHJv
YmUgKnAsIHN0cnVjdCBwdF9yZWdzICpyLCBpbnQgdHJhcG5yKQ0Kew0KCS8q
IExldCB0aGUga2VybmVsIGhhbmRsZSB0aGlzIGZhdWx0ICovDQoJcmV0dXJu
IDA7DQp9DQoNCg0KLyoNCiAqIHN0cnVjdCBub2lzeV9hdHRyaWJ1dGUgLSB1
c2VkIGZvciBkZWZpbmluZyBwcm9iZSBhdHRyaWJ1dGVzLCB3aXRoIGEgDQog
KiB0eXBlc2FmZSBzaG93IG1ldGhvZC4NCiAqLw0Kc3RydWN0IG5vaXN5X2F0
dHJpYnV0ZSB7DQoJc3RydWN0IGF0dHJpYnV0ZSBhdHRyOw0KCXNzaXplX3Qg
KCpzaG93KShzdHJ1Y3QgbnByb2JlICosY2hhciAqLHNpemVfdCxsb2ZmX3Qp
Ow0KfTsNCg0KDQovKioNCiAqCW5vaXN5X2F0dHJfc2hvdyAtIGZvcndhcmQg
c3lzZnMgcmVhZCBjYWxsIHRvIHByb3BlciBoYW5kbGVyLg0KICoJQGtvYmo6
CWtvYmplY3Qgb2YgcHJvYmUgYmVpbmcgYWNlc3NlZC4NCiAqCUBhdHRyOgln
ZW5lcmljIGF0dHJpYnV0ZSBwb3J0aW9uIG9mIHN0cnVjdCBub2lzeV9hdHRy
aWJ1dGUuDQogKglAcGFnZToJYnVmZmVyIHRvIHdyaXRlIGludG8uDQogKglA
Y291bnQ6CW51bWJlciBvZiBieXRlcyByZXF1ZXN0ZWQuDQogKglAb2ZmOglv
ZmZzZXQgaW50byBidWZmZXIuDQogKg0KICoJVGhpcyBpcyBjYWxsZWQgZnJv
bSBzeXNmcyBhbmQgaXMgbmVjZXNzYXJ5IHRvIGNvbnZlcnQgdGhlIGdlbmVy
aWMNCiAqCWtvYmplY3QgaW50byB0aGUgcmlnaHQgdHlwZSwgYW5kIHRvIGNv
bnZlcnQgdGhlIGF0dHJpYnV0ZSBpbnRvIHRoZQ0KICoJcmlnaHQgYXR0cmli
dXRlIHR5cGUuDQogKi8NCg0Kc3RhdGljIHNzaXplX3Qgbm9pc3lfYXR0cl9z
aG93KHN0cnVjdCBrb2JqZWN0ICoga29iaiwgc3RydWN0IGF0dHJpYnV0ZSAq
IGF0dHIsDQoJCQkgICAgICAgY2hhciAqIHBhZ2UsIHNpemVfdCBjb3VudCwg
bG9mZl90IG9mZikNCnsNCglzdHJ1Y3QgbnByb2JlICogbiA9IGNvbnRhaW5l
cl9vZihrb2JqLHN0cnVjdCBucHJvYmUsa29iaik7DQoJc3RydWN0IG5vaXN5
X2F0dHJpYnV0ZSAqIG5vaXN5X2F0dHIgPSBjb250YWluZXJfb2YoYXR0cixz
dHJ1Y3Qgbm9pc3lfYXR0cmlidXRlLGF0dHIpOw0KCXJldHVybiBub2lzeV9h
dHRyLT5zaG93ID8gbm9pc3lfYXR0ci0+c2hvdyhuLHBhZ2UsY291bnQsb2Zm
KSA6IDA7DQp9DQoNCi8qDQogKiBub2lzeV9zeXNmc19vcHMgLSBzeXNmcyBv
cGVyYXRpb25zIGZvciBzdHJ1Y3QgbnByb2Jlcy4NCiAqLw0Kc3RhdGljIHN0
cnVjdCBzeXNmc19vcHMgbm9pc3lfc3lzZnNfb3BzID0gew0KCS5zaG93CT0g
bm9pc3lfYXR0cl9zaG93LA0KfTsNCg0KDQovKiBEZWZhdWx0IEF0dHJpYnV0
ZSAtIHRoZSBtZXNzYWdlIHRvIHByaW50IG91dC4gKi8NCnN0YXRpYyBzc2l6
ZV90IG5vaXN5X21lc3NhZ2VfcmVhZChzdHJ1Y3QgbnByb2JlICogbiwgY2hh
ciAqIHBhZ2UsIHNpemVfdCBjb3VudCwgbG9mZl90IG9mZikNCnsNCglyZXR1
cm4gb2ZmID8gMDogc25wcmludGYocGFnZSxNQVhfTVNHX1NJWkUsIiVzXG4i
LG4tPm1lc3NhZ2UpOw0KfQ0KDQpzdGF0aWMgc3RydWN0IG5vaXN5X2F0dHJp
YnV0ZSBhdHRyX21lc3NhZ2UgPSB7DQoJLmF0dHIJPSB7IC5uYW1lID0gIm1l
c3NhZ2UiLCAubW9kZSA9IFNfSVJVR08gfSwNCgkuc2hvdwk9IG5vaXN5X21l
c3NhZ2VfcmVhZCwNCn07DQoNCi8qIERlY2xhcmUgYXJyYXkgb2YgZGVmYXVs
dCBhdHRyaWJ1dGVzIHRvIGJlIGFkZGVkIHdoZW4gYW4gbnByb2JlIGlzIGFk
ZGVkICovDQpzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqIGRlZmF1bHRfYXR0
cnNbXSA9IHsNCgkmYXR0cl9tZXNzYWdlLmF0dHIsDQoJTlVMTCwNCn07DQoN
Cg0KLyogRGVjbGFyZSBub2lzeV9zdWJzeXMgZm9yIGFkZGl0aW9uIHRvIHN5
c2ZzICovDQpzdGF0aWMgc3RydWN0IHN1YnN5c3RlbSBub2lzeV9zdWJzeXMg
PSB7DQoJLmtvYmoJPSB7IC5uYW1lID0gIm5vaXN5IiB9LA0KCS5kZWZhdWx0
X2F0dHJzCT0gZGVmYXVsdF9hdHRycywNCgkuc3lzZnNfb3BzCT0gJm5vaXN5
X3N5c2ZzX29wcywNCn07DQoNCg0KLyoNCiAqIG5vaXN5IGN0bCBhdHRyaWJ1
dGUuDQogKiBUaGlzIGlzIGRlY2xhcmVkIGFzIGFuIGF0dHJpYnV0ZSBvZiB0
aGUgc3Vic3lzdGVtLCBhbmQgYWRkZWQgaW4gDQogKiBub2lzeV9pbml0KCku
IA0KICogDQogKiBSZWFkaW5nIHRoaXMgYXR0cmlidXRlIGR1bXBzIGFsbCB0
aGUgcmVnaXN0ZXJlZCBub2lzeSBwcm9iZXMuDQogKiBXcml0aW5nIHRvIGl0
IGVpdGhlciBhZGRzIG9yIGRlbGV0ZXMgYSBub2lzeSBwcm9iZSwgYXMgZGVz
Y3JpYmVkIGF0IA0KICogdGhlIGJlZ2lubmluZyBvZiB0aGUgZmlsZS4NCiAq
Lw0Kc3RhdGljIHNzaXplX3QgY3RsX3Nob3coc3RydWN0IHN1YnN5c3RlbSAq
IHMsIGNoYXIgKiBwYWdlLCBzaXplX3QgY291bnQsIGxvZmZfdCBvZmYpDQp7
DQoJY2hhciAqIHN0ciA9IHBhZ2U7DQoJaW50IHJldCA9IDA7DQoNCglkb3du
KCZub2lzeV9zZW0pOw0KCWlmICghb2ZmKSB7DQoJCXN0cnVjdCBsaXN0X2hl
YWQgKiBlbnRyeSwgKiBuZXh0Ow0KCQlsaXN0X2Zvcl9lYWNoX3NhZmUoZW50
cnksbmV4dCwmbm9pc3lfc3Vic3lzLmxpc3QpIHsNCgkJCXN0cnVjdCBucHJv
YmUgKiBuID0gdG9fbnByb2JlKGVudHJ5KTsNCgkJCWlmICgocmV0ICsgTUFY
X01TR19TSVpFKSA+IFBBR0VfU0laRSkNCgkJCQlicmVhazsNCgkJCXN0ciAr
PSBzbnByaW50ZihzdHIsUEFHRV9TSVpFIC0gcmV0LCIlcDogJXNcbiIsDQoJ
CQkJCW4tPnByb2JlLmFkZHIsbi0+bWVzc2FnZSk7DQoJCQlyZXQgPSBzdHIg
LSBwYWdlOw0KCQl9DQoJfQ0KCXVwKCZub2lzeV9zZW0pOw0KCXJldHVybiBy
ZXQ7DQp9DQoNCnN0YXRpYyBpbnQgYWRkKHVuc2lnbmVkIGxvbmcgYWRkciwg
Y2hhciAqIG1lc3NhZ2UpDQp7DQoJc3RydWN0IG5wcm9iZSAqIG47DQoJaW50
IGVycm9yID0gMDsNCg0KCWlmICghdmFsaWRfa2VybmVsX2FkZHJlc3MoYWRk
cikpDQoJCXJldHVybiAtRUZBVUxUOw0KDQoJbiA9IGttYWxsb2Moc2l6ZW9m
KHN0cnVjdCBucHJvYmUpLEdGUF9LRVJORUwpOw0KCWlmICghbikNCgkJcmV0
dXJuIC1FTk9NRU07DQoJbWVtc2V0KG4sMCxzaXplb2Yoc3RydWN0IG5wcm9i
ZSkpOw0KDQoJbi0+cHJvYmUuYWRkciA9IChrcHJvYmVfb3Bjb2RlX3QgKilh
ZGRyOw0KCXN0cm5jcHkobi0+bWVzc2FnZSxtZXNzYWdlLE1BWF9NU0dfU0la
RSk7DQoJbi0+cHJvYmUucHJlX2hhbmRsZXIgPSBub2lzeV9wcmVfaGFuZGxl
cjsNCgluLT5wcm9iZS5wb3N0X2hhbmRsZXIgPSBub2lzeV9wb3N0X2hhbmRs
ZXI7DQoJbi0+cHJvYmUuZmF1bHRfaGFuZGxlciA9IG5vaXN5X2ZhdWx0X2hh
bmRsZXI7DQoNCgkvKiBEb2luZyB0aGlzIG1hbnVhbGx5IHdpbGwgYmUgdW5u
ZWNlc3Nhcnkgc29vbi4gKi8NCglrb2JqZWN0X2luaXQoJm4tPmtvYmopOw0K
CW4tPmtvYmouc3Vic3lzID0gJm5vaXN5X3N1YnN5czsNCglzbnByaW50Zihu
LT5rb2JqLm5hbWUsIEtPQkpfTkFNRV9MRU4sICIlcCIsIG4tPnByb2JlLmFk
ZHIpOw0KCQ0KCWlmICgoZXJyb3IgPSByZWdpc3Rlcl9rcHJvYmUoJm4tPnBy
b2JlKSkpIHsNCgkJcHJpbnRrKEtFUk5fRVJSICJVbmFibGUgdG8gcmVnaXN0
ZXIgcHJvYmUgYXQgJXBcbiIsIA0KCQkgICAgICAgKG4tPnByb2JlKS5hZGRy
KTsNCgkJZ290byBFcnJvcjsNCgl9DQoJaWYgKChlcnJvciA9IGtvYmplY3Rf
cmVnaXN0ZXIoJm4tPmtvYmopKSkgew0KCQl1bnJlZ2lzdGVyX2twcm9iZSgm
bi0+cHJvYmUpOw0KCQlnb3RvIEVycm9yOw0KCX0NCglnb3RvIERvbmU7DQog
RXJyb3I6DQoJa2ZyZWUobik7DQogRG9uZToNCglyZXR1cm4gZXJyb3I7DQp9
DQoNCnN0YXRpYyBpbnQgZGVsKHVuc2lnbmVkIGxvbmcgYWRkcikNCnsNCglz
dHJ1Y3QgbGlzdF9oZWFkICogZW50cnk7DQoJc3RydWN0IG5wcm9iZSAqIG47
DQoNCglsaXN0X2Zvcl9lYWNoKGVudHJ5LCZub2lzeV9zdWJzeXMubGlzdCkg
ew0KCQluID0gdG9fbnByb2JlKGVudHJ5KTsNCgkJaWYgKCh1bnNpZ25lZCBs
b25nKShuLT5wcm9iZS5hZGRyKSA9PSBhZGRyKSB7DQoJCQlrb2JqZWN0X3Vu
cmVnaXN0ZXIoJm4tPmtvYmopOw0KCQkJdW5yZWdpc3Rlcl9rcHJvYmUoJm4t
PnByb2JlKTsNCgkJCXJldHVybiAwOw0KCQl9DQoJfQ0KCXJldHVybiAtRUZB
VUxUOw0KfQ0KDQpzdGF0aWMgc3NpemVfdCBjdGxfc3RvcmUoc3RydWN0IHN1
YnN5c3RlbSAqIHMsIGNvbnN0IGNoYXIgKiBwYWdlLCBzaXplX3QgY291bnQs
IGxvZmZfdCBvZmYpDQp7DQoJY2hhciBtZXNzYWdlW01BWF9NU0dfU0laRV07
DQoJY2hhciBjdGxbMTZdOw0KCXVuc2lnbmVkIGxvbmcgYWRkcjsNCglpbnQg
bnVtOw0KCWludCBlcnJvcjsNCglpbnQgcmV0ID0gMDsNCg0KCWRvd24oJm5v
aXN5X3NlbSk7DQoJaWYgKG9mZikNCgkJZ290byBEb25lOw0KCW51bSA9IHNz
Y2FuZihwYWdlLCIlMTVzIDB4JWx4ICUxMjhzIixjdGwsJmFkZHIsbWVzc2Fn
ZSk7DQoJaWYgKCFudW0pIHsNCgkJZXJyb3IgPSAtRUlOVkFMOw0KCQlnb3Rv
IERvbmU7DQoJfQ0KCWlmICghc3RyY21wKGN0bCwiYWRkIikgJiYgbnVtID09
IDMpDQoJCWVycm9yID0gYWRkKGFkZHIsbWVzc2FnZSk7DQoJZWxzZSBpZiAo
IXN0cmNtcChjdGwsImRlbCIpICYmIG51bSA9PSAyKQ0KCQllcnJvciA9IGRl
bChhZGRyKTsNCgllbHNlDQoJCWVycm9yID0gLUVJTlZBTDsNCglyZXQgPSBl
cnJvciA/IGVycm9yIDogY291bnQ7DQogRG9uZToNCgl1cCgmbm9pc3lfc2Vt
KTsNCglyZXR1cm4gcmV0Ow0KfQ0KDQpzdGF0aWMgc3RydWN0IHN1YnN5c19h
dHRyaWJ1dGUgc3Vic3lzX2F0dHJfY3RsID0gew0KCS5hdHRyCT0geyAubmFt
ZSA9ICJjdGwiLCAubW9kZSA9IDA2NDQgfSwNCgkuc2hvdwk9IGN0bF9zaG93
LA0KCS5zdG9yZQk9IGN0bF9zdG9yZSwNCn07DQoNCg0Kc3RhdGljIGludCBf
X2luaXQgbm9pc3lfaW5pdCh2b2lkKQ0Kew0KCXN1YnN5c3RlbV9yZWdpc3Rl
cigmbm9pc3lfc3Vic3lzKTsNCglzdWJzeXNfY3JlYXRlX2ZpbGUoJm5vaXN5
X3N1YnN5cywmc3Vic3lzX2F0dHJfY3RsKTsNCglyZXR1cm4gMDsNCn0NCg0K
c3RhdGljIHZvaWQgX19leGl0IG5vaXN5X2V4aXQgKHZvaWQpDQp7DQoJc3Vi
c3lzX3JlbW92ZV9maWxlKCZub2lzeV9zdWJzeXMsJnN1YnN5c19hdHRyX2N0
bCk7DQoJc3Vic3lzdGVtX3VucmVnaXN0ZXIoJm5vaXN5X3N1YnN5cyk7DQp9
DQoNCm1vZHVsZV9pbml0KG5vaXN5X2luaXQpOw0KbW9kdWxlX2V4aXQobm9p
c3lfZXhpdCk7DQoNCk1PRFVMRV9BVVRIT1IoIlJ1c3R5IEx5bmNoIik7DQpN
T0RVTEVfTElDRU5TRSgiR1BMIik7DQo=
--8323328-973767115-1037919824=:913--

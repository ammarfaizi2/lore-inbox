Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSKUUme>; Thu, 21 Nov 2002 15:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbSKUUme>; Thu, 21 Nov 2002 15:42:34 -0500
Received: from air-2.osdl.org ([65.172.181.6]:11699 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262528AbSKUUmU>;
	Thu, 21 Nov 2002 15:42:20 -0500
Date: Thu, 21 Nov 2002 14:45:50 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use
In-Reply-To: <028501c29174$36792ca0$6901a8c0@amr.corp.intel.com>
Message-ID: <Pine.LNX.4.33.0211211352100.913-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-848336614-1037911550=:913"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-848336614-1037911550=:913
Content-Type: TEXT/PLAIN; charset=US-ASCII


Ok, I've had a chance to play with it a bit..

The kprobes patch didn't apply to current -bk. Attached is an updated 
patch. I also have some comments on your 'noisy' patch, but first..

> I can see this with a little kprobes example code that I have
> been playing with that will create entries like:
> 
> /sysfsroot/noisy/0xc0107ae0/sys_fork
> 
> when someone uses that driver to insert a kernel probe
> at 0xc0107ae0 that will printk "sys_fork".

It seems that having a pure sysfs implementation would be superior, 
instead of having to use a character device to write to. After looking 
into this, I realize that a couple of pieces of infrastructure are needed, 
so I'm working on that, and will post a modified version of your module 
once I'm done..

> What I have noticed, is that if I create a new probe
> (which will create the sysfs entry), open a new shell and
> cd to /sysfsroot/noisy/0xc0107ae0, and then use my
> driver to remove the probe (which will remove the
> sysfs entry), then /sysfsroot/noisy/0xc0107ae0 doesn't
> go away after I cd out of the shell.
> 
> >From then on any attempts to create new sysfs entries
> do not show up in /sysfsroot/ until I unload/load my driver
> again.
> 
> It seems like this could be an issue with some real code
> (not just this stupid play code of mine), like maybe hotswap
> code that updates sysfs entries.

Yes, it was a real bug. I've mucked with the method to do file and 
directory deletion, and it turns out that the way I was doing it was 
wrong. I've gone back to mimmicking vfs_unlink() and vfs_rmdir(), which I 
shouldn't have diverged from in the first place. (doing d_delete() after 
low-level unlinking, instead of d_invalidate() before it). 

Appended to this email is my current working patch to sysfs, including 
fixes discussed and posted yesterday. I've pushed these to Linus, though 
he appears to be away. I'll push again, with this fix in the next day or 
so. 

Please try this patch and let me know if you still experience the problem 
you're seeing.

Concerning your patch: 

> +config NOISY

'Noisy' seems like such a generic name, and the description doesn't seem 
to imply its dependence on kprobes. Maybe KPROBES_NOISY? And, you should 
put it under KPROBES, under DEBUG_KERNEL.

> diff -urN linux-2.5.48-kprobes/drivers/char/noisy.c
> linux-2.5.48-kprobes-patched/drivers/char/noisy.c

> +static struct list_head probe_list;
> +struct nprobe {
> +	struct list_head list;
> +	struct kprobe probe;
> +	char message[MAX_MSG_SIZE + 1];
> +	struct attribute attr;
> +	struct kobject kobj;
> +};

struct subsystem has a list, and kobject and entry, so you don't have to 
do it yourself..

> +static ssize_t noisy_write(struct file *file, const char *buf, size_t
> count,
> +			   loff_t *ppos)
> +{
> +	struct nprobe *n = 0;
> +	size_t ret = -ENOMEM;
> +	char *tmp = 0;
> +
> +	if (count > MAX_MSG_SIZE) {
> +		printk(KERN_CRIT
> +		       "noisy: Input buffer (%i bytes) is too big!\n",
> +		       count);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	tmp = kmalloc(count + 1, GFP_KERNEL);
> +	if (!tmp) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}

This should be memset to 0. 

> +	n = kmalloc(sizeof(struct nprobe), GFP_KERNEL);
> +	if (!n) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	memset(n, '\0', sizeof(struct nprobe));
> +
> +	if (copy_from_user((void *)tmp, (void *)buf, count)) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	tmp[count] = '\0';
> +
> +	if (2 != sscanf(tmp, "0x%x %s", &(n->probe).addr, n->message)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}

You don't free n if you get an error from copy_from_user() or sscanf(). 

> +	(n->attr).name = n->message;
> +	(n->attr).mode = S_IRUGO;

Instead of doing this, you should just declare a static attribute called
'message' and have the contents be the message. This will save you from 
initializing it each time, and save you 4 bytes in struct nprobe. 
Something like this should work:


struct noisy_attribute {
	struct attribute attr;
	ssize_t (*read)(struct nprobe *,char *,size_t,loff_t);
};

static ssize_t noisy_attr_show(struct kobject * kobj, struct attribute * 
attr,
			       char * page, size_t count, loff_t off)
{
	struct nprobe * n = container_of(kobj,struct nprobe,kobj);
	struct noisy_attribute * noisy_attr = container_of(attr,struct 
noisy_attribute,attr);
	ssize_t ret = 0;
	return noisy_attr->show ? noisy_attr->show(n,page,count,off);
}

static struct sysfs_ops noisy_sysfs_ops = {
	.show	= noisy_attr_show,
};


/* Default Attribute */
static ssize_t noisy_message_read(struct nprobe * n, char * page, size_t 
count, loff_t off)
{
	return off ? snprintf(page,MAX_MSG_SIZE,"%s",n->message);
}

static struct noisy_attribute attr_message = {
	.attr	= { .name = "message", .mode = S_IRUGO },
};

static struct attribute * default_attrs[] = {
	&attr_message.attr,
	NULL,
};

/*
 * sysfs stuff
 */

struct subsystem noisy_subsys = {
	.kobj	= { .name = "noisy" },
	.default_attrs	= default_attrs,
	.sysfs_ops	= noisy_sysfs_ops,
};


Note that this will also save you from manually having to create and 
teardown the file when the kobject is registered and unregistered. 


	-pat

--- linux-2.5-virgin/fs/sysfs/inode.c	Wed Nov 20 12:13:06 2002
+++ linux-2.5-core/fs/sysfs/inode.c	Thu Nov 21 13:51:32 2002
@@ -23,6 +23,8 @@
  * Please see Documentation/filesystems/sysfs.txt for more information.
  */
 
+#undef DEBUG 
+
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
@@ -94,9 +96,10 @@
 
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
@@ -142,17 +145,6 @@
 	return error;
 }
 
-static int sysfs_unlink(struct inode *dir, struct dentry *dentry)
-{
-	struct inode *inode = dentry->d_inode;
-	down(&inode->i_sem);
-	dentry->d_inode->i_nlink--;
-	up(&inode->i_sem);
-	d_invalidate(dentry);
-	dput(dentry);
-	return 0;
-}
-
 /**
  *	sysfs_read_file - read an attribute. 
  *	@file:	file pointer.
@@ -173,17 +165,11 @@
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
 
@@ -234,16 +220,11 @@
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
-		return -EINVAL;
 
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page)
@@ -275,21 +256,72 @@
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
+	if (kobj->subsys)
+		ops = kobj->subsys->sysfs_ops;
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
@@ -541,7 +573,8 @@
 		/* make sure dentry is really there */
 		if (victim->d_inode && 
 		    (victim->d_parent->d_inode == dir->d_inode)) {
-			sysfs_unlink(dir->d_inode,victim);
+			simple_unlink(dir->d_inode,victim);
+			d_delete(victim);
 		}
 	}
 	up(&dir->d_inode->i_sem);
@@ -599,19 +632,16 @@
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
@@ -622,4 +652,3 @@
 EXPORT_SYMBOL(sysfs_remove_link);
 EXPORT_SYMBOL(sysfs_create_dir);
 EXPORT_SYMBOL(sysfs_remove_dir);
-MODULE_LICENSE("GPL");

--8323328-848336614-1037911550=:913
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="kprobes.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0211211445500.913@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="kprobes.diff"

PT09PT0gYXJjaC9pMzg2L0tjb25maWcgMS4xMCB2cyBlZGl0ZWQgPT09PT0N
Ci0tLSAxLjEwL2FyY2gvaTM4Ni9LY29uZmlnCU1vbiBOb3YgMTggMTE6NTI6
MzEgMjAwMg0KKysrIGVkaXRlZC9hcmNoL2kzODYvS2NvbmZpZwlUaHUgTm92
IDIxIDExOjIwOjMxIDIwMDINCkBAIC0xNTUxLDYgKzE1NTEsMTUgQEANCiAJ
ICBTYXkgWSBoZXJlIGlmIHlvdSBhcmUgZGV2ZWxvcGluZyBkcml2ZXJzIG9y
IHRyeWluZyB0byBkZWJ1ZyBhbmQNCiAJICBpZGVudGlmeSBrZXJuZWwgcHJv
YmxlbXMuDQogDQorY29uZmlnIEtQUk9CRVMNCisJYm9vbCAiS3Byb2JlcyIN
CisJZGVwZW5kcyBvbiBERUJVR19LRVJORUwNCisJaGVscA0KKwkgIEtwcm9i
ZXMgYWxsb3dzIHlvdSB0byB0cmFwIGF0IGFsbW9zdCBhbnkga2VybmVsIGFk
ZHJlc3MsIHVzaW5nDQorCSAgcmVnaXN0ZXJfa3Byb2JlKCksIGFuZCBwcm92
aWRpbmcgYSBjYWxsYmFjayBmdW5jdGlvbi4gIFRoaXMgaXMgdXNlZnVsDQor
CSAgZm9yIGtlcm5lbCBkZWJ1Z2dpbmcsIG5vbi1pbnRydXNpdmUgaW5zdHJ1
bWVudGF0aW9uIGFuZCB0ZXN0aW5nLiAgSWYNCisJICBpbiBkb3VidCwgc2F5
ICJOIi4NCisNCiBjb25maWcgREVCVUdfU1RBQ0tPVkVSRkxPVw0KIAlib29s
ICJDaGVjayBmb3Igc3RhY2sgb3ZlcmZsb3dzIg0KIAlkZXBlbmRzIG9uIERF
QlVHX0tFUk5FTA0KPT09PT0gYXJjaC9pMzg2L2tlcm5lbC9NYWtlZmlsZSAx
LjI5IHZzIGVkaXRlZCA9PT09PQ0KLS0tIDEuMjkvYXJjaC9pMzg2L2tlcm5l
bC9NYWtlZmlsZQlUaHUgTm92ICA3IDExOjI2OjQ1IDIwMDINCisrKyBlZGl0
ZWQvYXJjaC9pMzg2L2tlcm5lbC9NYWtlZmlsZQlUaHUgTm92IDIxIDExOjIw
OjMxIDIwMDINCkBAIC0yOSw2ICsyOSw3IEBADQogb2JqLSQoQ09ORklHX1BS
T0ZJTElORykJCSs9IHByb2ZpbGUubw0KIG9iai0kKENPTkZJR19FREQpICAg
ICAgICAgICAgIAkrPSBlZGQubw0KIG9iai0kKENPTkZJR19NT0RVTEVTKQkJ
Kz0gbW9kdWxlLm8NCitvYmotJChDT05GSUdfS1BST0JFUykJCSs9IGtwcm9i
ZXMubw0KIA0KIEVYVFJBX0FGTEFHUyAgIDo9IC10cmFkaXRpb25hbA0KIA0K
PT09PT0gYXJjaC9pMzg2L2tlcm5lbC9lbnRyeS5TIDEuNDYgdnMgZWRpdGVk
ID09PT09DQotLS0gMS40Ni9hcmNoL2kzODYva2VybmVsL2VudHJ5LlMJV2Vk
IE5vdiAyMCAxMjo1NjowNiAyMDAyDQorKysgZWRpdGVkL2FyY2gvaTM4Ni9r
ZXJuZWwvZW50cnkuUwlUaHUgTm92IDIxIDExOjIwOjMxIDIwMDINCkBAIC00
MDUsOSArNDA1LDE2IEBADQogCWptcCByZXRfZnJvbV9leGNlcHRpb24NCiAN
CiBFTlRSWShkZWJ1ZykNCisJcHVzaGwgJC0xCQkJIyBtYXJrIHRoaXMgYXMg
YW4gaW50DQorCVNBVkVfQUxMDQorCW1vdmwgJWVzcCwlZWR4DQogCXB1c2hs
ICQwDQotCXB1c2hsICRkb19kZWJ1Zw0KLQlqbXAgZXJyb3JfY29kZQ0KKwlw
dXNobCAlZWR4DQorCWNhbGwgZG9fZGVidWcNCisJYWRkbCAkOCwlZXNwDQor
CXRlc3RsICVlYXgsJWVheCANCisJam56IHJlc3RvcmVfYWxsDQorCWptcCBy
ZXRfZnJvbV9leGNlcHRpb24NCiANCiBFTlRSWShubWkpDQogCXB1c2hsICVl
YXgNCkBAIC00MjAsOSArNDI3LDE2IEBADQogCVJFU1RPUkVfQUxMDQogDQog
RU5UUlkoaW50MykNCisJcHVzaGwgJC0xCQkJIyBtYXJrIHRoaXMgYXMgYW4g
aW50DQorCVNBVkVfQUxMDQorCW1vdmwgJWVzcCwlZWR4DQogCXB1c2hsICQw
DQotCXB1c2hsICRkb19pbnQzDQotCWptcCBlcnJvcl9jb2RlDQorCXB1c2hs
ICVlZHgNCisJY2FsbCBkb19pbnQzDQorCWFkZGwgJDgsJWVzcA0KKwl0ZXN0
bCAlZWF4LCVlYXggDQorCWpueiByZXN0b3JlX2FsbA0KKwlqbXAgcmV0X2Zy
b21fZXhjZXB0aW9uDQogDQogRU5UUlkob3ZlcmZsb3cpDQogCXB1c2hsICQw
DQo9PT09PSBhcmNoL2kzODYva2VybmVsL3RyYXBzLmMgMS4zNiB2cyBlZGl0
ZWQgPT09PT0NCi0tLSAxLjM2L2FyY2gvaTM4Ni9rZXJuZWwvdHJhcHMuYwlN
b24gTm92IDE4IDEyOjEwOjQ1IDIwMDINCisrKyBlZGl0ZWQvYXJjaC9pMzg2
L2tlcm5lbC90cmFwcy5jCVRodSBOb3YgMjEgMTE6MjA6NDggMjAwMg0KQEAg
LTI0LDYgKzI0LDcgQEANCiAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+
DQogI2luY2x1ZGUgPGxpbnV4L2hpZ2htZW0uaD4NCiAjaW5jbHVkZSA8bGlu
dXgva2FsbHN5bXMuaD4NCisjaW5jbHVkZSA8bGludXgva3Byb2Jlcy5oPg0K
IA0KICNpZmRlZiBDT05GSUdfRUlTQQ0KICNpbmNsdWRlIDxsaW51eC9pb3Bv
cnQuaD4NCkBAIC00MDQsNyArNDA1LDYgQEANCiB9DQogDQogRE9fVk04Nl9F
UlJPUl9JTkZPKCAwLCBTSUdGUEUsICAiZGl2aWRlIGVycm9yIiwgZGl2aWRl
X2Vycm9yLCBGUEVfSU5URElWLCByZWdzLT5laXApDQotRE9fVk04Nl9FUlJP
UiggMywgU0lHVFJBUCwgImludDMiLCBpbnQzKQ0KIERPX1ZNODZfRVJST1Io
IDQsIFNJR1NFR1YsICJvdmVyZmxvdyIsIG92ZXJmbG93KQ0KIERPX1ZNODZf
RVJST1IoIDUsIFNJR1NFR1YsICJib3VuZHMiLCBib3VuZHMpDQogRE9fRVJS
T1JfSU5GTyggNiwgU0lHSUxMLCAgImludmFsaWQgb3BlcmFuZCIsIGludmFs
aWRfb3AsIElMTF9JTExPUE4sIHJlZ3MtPmVpcCkNCkBAIC00MjAsNiArNDIw
LDkgQEANCiB7DQogCWlmIChyZWdzLT5lZmxhZ3MgJiBWTV9NQVNLKQ0KIAkJ
Z290byBncF9pbl92bTg2Ow0KKwkNCisJaWYgKGtwcm9iZV9ydW5uaW5nKCkg
JiYga3Byb2JlX2ZhdWx0X2hhbmRsZXIocmVncywgMTMpKQ0KKwkJcmV0dXJu
Ow0KIA0KIAlpZiAoIShyZWdzLT54Y3MgJiAzKSkNCiAJCWdvdG8gZ3BfaW5f
a2VybmVsOw0KQEAgLTU1MSw2ICs1NTQsMTcgQEANCiAJbm1pX2NhbGxiYWNr
ID0gZHVtbXlfbm1pX2NhbGxiYWNrOw0KIH0NCiANCithc21saW5rYWdlIGlu
dCBkb19pbnQzKHN0cnVjdCBwdF9yZWdzICpyZWdzLCBsb25nIGVycm9yX2Nv
ZGUpDQorew0KKwlpZiAoa3Byb2JlX2hhbmRsZXIocmVncykpDQorCQlyZXR1
cm4gMTsNCisJLyogVGhpcyBpcyBhbiBpbnRlcnJ1cHQgZ2F0ZSwgYmVjYXVz
ZSBrcHJvYmVzIHdhbnRzIGludGVycnVwdHMNCisgICAgICAgICAgIGRpc2Fi
bGVkLiAgTm9ybWFsIHRyYXAgaGFuZGxlcnMgZG9uJ3QuICovDQorCXJlc3Rv
cmVfaW50ZXJydXB0cyhyZWdzKTsNCisJZG9fdHJhcCgzLCBTSUdUUkFQLCAi
aW50MyIsIDEsIHJlZ3MsIGVycm9yX2NvZGUsIE5VTEwpOw0KKwlyZXR1cm4g
MDsNCit9DQorDQogLyoNCiAgKiBPdXIgaGFuZGxpbmcgb2YgdGhlIHByb2Nl
c3NvciBkZWJ1ZyByZWdpc3RlcnMgaXMgbm9uLXRyaXZpYWwuDQogICogV2Ug
ZG8gbm90IGNsZWFyIHRoZW0gb24gZW50cnkgYW5kIGV4aXQgZnJvbSB0aGUg
a2VybmVsLiBUaGVyZWZvcmUNCkBAIC01NzMsNyArNTg3LDcgQEANCiAgKiBm
aW5kIGV2ZXJ5IG9jY3VycmVuY2Ugb2YgdGhlIFRGIGJpdCB0aGF0IGNvdWxk
IGJlIHNhdmVkIGF3YXkgZXZlbg0KICAqIGJ5IHVzZXIgY29kZSkNCiAgKi8N
Ci1hc21saW5rYWdlIHZvaWQgZG9fZGVidWcoc3RydWN0IHB0X3JlZ3MgKiBy
ZWdzLCBsb25nIGVycm9yX2NvZGUpDQorYXNtbGlua2FnZSBpbnQgZG9fZGVi
dWcoc3RydWN0IHB0X3JlZ3MgKiByZWdzLCBsb25nIGVycm9yX2NvZGUpDQog
ew0KIAl1bnNpZ25lZCBpbnQgY29uZGl0aW9uOw0KIAlzdHJ1Y3QgdGFza19z
dHJ1Y3QgKnRzayA9IGN1cnJlbnQ7DQpAQCAtNTgxLDYgKzU5NSwxMiBAQA0K
IA0KIAlfX2FzbV9fIF9fdm9sYXRpbGVfXygibW92bCAlJWRiNiwlMCIgOiAi
PXIiIChjb25kaXRpb24pKTsNCiANCisJaWYgKHBvc3Rfa3Byb2JlX2hhbmRs
ZXIocmVncykpDQorCQlyZXR1cm4gMTsNCisNCisJLyogSW50ZXJydXB0cyBu
b3QgZGlzYWJsZWQgZm9yIG5vcm1hbCB0cmFwIGhhbmRsaW5nLiAqLw0KKwly
ZXN0b3JlX2ludGVycnVwdHMocmVncyk7DQorDQogCS8qIE1hc2sgb3V0IHNw
dXJpb3VzIGRlYnVnIHRyYXBzIGR1ZSB0byBsYXp5IERSNyBzZXR0aW5nICov
DQogCWlmIChjb25kaXRpb24gJiAoRFJfVFJBUDB8RFJfVFJBUDF8RFJfVFJB
UDJ8RFJfVFJBUDMpKSB7DQogCQlpZiAoIXRzay0+dGhyZWFkLmRlYnVncmVn
WzddKQ0KQEAgLTYzMSwxNSArNjUxLDE1IEBADQogCV9fYXNtX18oIm1vdmwg
JTAsJSVkYjciDQogCQk6IC8qIG5vIG91dHB1dCAqLw0KIAkJOiAiciIgKDAp
KTsNCi0JcmV0dXJuOw0KKwlyZXR1cm4gMDsNCiANCiBkZWJ1Z192bTg2Og0K
IAloYW5kbGVfdm04Nl90cmFwKChzdHJ1Y3Qga2VybmVsX3ZtODZfcmVncyAq
KSByZWdzLCBlcnJvcl9jb2RlLCAxKTsNCi0JcmV0dXJuOw0KKwlyZXR1cm4g
MDsNCiANCiBjbGVhcl9URjoNCiAJcmVncy0+ZWZsYWdzICY9IH5URl9NQVNL
Ow0KLQlyZXR1cm47DQorCXJldHVybiAwOw0KIH0NCiANCiAvKg0KQEAgLTgw
Myw2ICs4MjMsOCBAQA0KIAlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzayA9IGN1
cnJlbnQ7DQogCWNsdHMoKTsJCS8qIEFsbG93IG1hdGhzIG9wcyAob3Igd2Ug
cmVjdXJzZSkgKi8NCiANCisJaWYgKGtwcm9iZV9ydW5uaW5nKCkgJiYga3By
b2JlX2ZhdWx0X2hhbmRsZXIoJnJlZ3MsIDcpKQ0KKwkJcmV0dXJuOw0KIAlp
ZiAoIXRzay0+dXNlZF9tYXRoKQ0KIAkJaW5pdF9mcHUodHNrKTsNCiAJcmVz
dG9yZV9mcHUodHNrKTsNCkBAIC04OTYsOSArOTE4LDkgQEANCiAjZW5kaWYN
CiANCiAJc2V0X3RyYXBfZ2F0ZSgwLCZkaXZpZGVfZXJyb3IpOw0KLQlzZXRf
dHJhcF9nYXRlKDEsJmRlYnVnKTsNCisJX3NldF9nYXRlKGlkdF90YWJsZSsx
LDE0LDMsJmRlYnVnKTsgLyogZGVidWcgdHJhcCBmb3Iga3Byb2JlcyAqLw0K
IAlzZXRfaW50cl9nYXRlKDIsJm5taSk7DQotCXNldF9zeXN0ZW1fZ2F0ZSgz
LCZpbnQzKTsJLyogaW50My01IGNhbiBiZSBjYWxsZWQgZnJvbSBhbGwgKi8N
CisJX3NldF9nYXRlKGlkdF90YWJsZSszLDE0LDMsJmludDMpOyAvKiBpbnQz
LTUgY2FuIGJlIGNhbGxlZCBmcm9tIGFsbCAqLw0KIAlzZXRfc3lzdGVtX2dh
dGUoNCwmb3ZlcmZsb3cpOw0KIAlzZXRfc3lzdGVtX2dhdGUoNSwmYm91bmRz
KTsNCiAJc2V0X3RyYXBfZ2F0ZSg2LCZpbnZhbGlkX29wKTsNCj09PT09IGFy
Y2gvaTM4Ni9tbS9mYXVsdC5jIDEuMjAgdnMgZWRpdGVkID09PT09DQotLS0g
MS4yMC9hcmNoL2kzODYvbW0vZmF1bHQuYwlTYXQgT2N0IDEyIDA2OjExOjAz
IDIwMDINCisrKyBlZGl0ZWQvYXJjaC9pMzg2L21tL2ZhdWx0LmMJVGh1IE5v
diAyMSAxMToyMDozMSAyMDAyDQpAQCAtMTksNiArMTksNyBAQA0KICNpbmNs
dWRlIDxsaW51eC9pbml0Lmg+DQogI2luY2x1ZGUgPGxpbnV4L3R0eS5oPg0K
ICNpbmNsdWRlIDxsaW51eC92dF9rZXJuLmg+CQkvKiBGb3IgdW5ibGFua19z
Y3JlZW4oKSAqLw0KKyNpbmNsdWRlIDxsaW51eC9rcHJvYmVzLmg+DQogDQog
I2luY2x1ZGUgPGFzbS9zeXN0ZW0uaD4NCiAjaW5jbHVkZSA8YXNtL3VhY2Nl
c3MuaD4NCkBAIC0xNjIsNiArMTYzLDkgQEANCiANCiAJLyogZ2V0IHRoZSBh
ZGRyZXNzICovDQogCV9fYXNtX18oIm1vdmwgJSVjcjIsJTAiOiI9ciIgKGFk
ZHJlc3MpKTsNCisNCisJaWYgKGtwcm9iZV9ydW5uaW5nKCkgJiYga3Byb2Jl
X2ZhdWx0X2hhbmRsZXIocmVncywgMTQpKQ0KKwkJcmV0dXJuOw0KIA0KIAkv
KiBJdCdzIHNhZmUgdG8gYWxsb3cgaXJxJ3MgYWZ0ZXIgY3IyIGhhcyBiZWVu
IHNhdmVkICovDQogCWlmIChyZWdzLT5lZmxhZ3MgJiBYODZfRUZMQUdTX0lG
KQ0KPT09PT0ga2VybmVsL01ha2VmaWxlIDEuMjEgdnMgZWRpdGVkID09PT09
DQotLS0gMS4yMS9rZXJuZWwvTWFrZWZpbGUJTW9uIE5vdiAxOCAyMjo1MTox
NCAyMDAyDQorKysgZWRpdGVkL2tlcm5lbC9NYWtlZmlsZQlUaHUgTm92IDIx
IDExOjIwOjMxIDIwMDINCkBAIC00LDcgKzQsNyBAQA0KIA0KIGV4cG9ydC1v
YmpzID0gc2lnbmFsLm8gc3lzLm8ga21vZC5vIHdvcmtxdWV1ZS5vIGtzeW1z
Lm8gcG0ubyBleGVjX2RvbWFpbi5vIFwNCiAJCXByaW50ay5vIHBsYXRmb3Jt
Lm8gc3VzcGVuZC5vIGRtYS5vIG1vZHVsZS5vIGNwdWZyZXEubyBcDQotCQlw
cm9maWxlLm8gcmN1cGRhdGUubyBpbnRlcm1vZHVsZS5vDQorCQlwcm9maWxl
Lm8gcmN1cGRhdGUubyBpbnRlcm1vZHVsZS5vIGtwcm9iZXMubw0KIA0KIG9i
ai15ICAgICA9IHNjaGVkLm8gZm9yay5vIGV4ZWNfZG9tYWluLm8gcGFuaWMu
byBwcmludGsubyBwcm9maWxlLm8gXA0KIAkgICAgZXhpdC5vIGl0aW1lci5v
IHRpbWUubyBzb2Z0aXJxLm8gcmVzb3VyY2UubyBcDQpAQCAtMjEsNiArMjEs
NyBAQA0KIG9iai0kKENPTkZJR19DUFVfRlJFUSkgKz0gY3B1ZnJlcS5vDQog
b2JqLSQoQ09ORklHX0JTRF9QUk9DRVNTX0FDQ1QpICs9IGFjY3Qubw0KIG9i
ai0kKENPTkZJR19TT0ZUV0FSRV9TVVNQRU5EKSArPSBzdXNwZW5kLm8NCitv
YmotJChDT05GSUdfS1BST0JFUykgKz0ga3Byb2Jlcy5vDQogDQogaWZuZXEg
KCQoQ09ORklHX0lBNjQpLHkpDQogIyBBY2NvcmRpbmcgdG8gQWxhbiBNb2Ry
YSA8YWxhbkBsaW51eGNhcmUuY29tLmF1PiwgdGhlIC1mbm8tb21pdC1mcmFt
ZS1wb2ludGVyIGlzDQo=
--8323328-848336614-1037911550=:913--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261772AbSIXSUW>; Tue, 24 Sep 2002 14:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261773AbSIXSUV>; Tue, 24 Sep 2002 14:20:21 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48258 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261772AbSIXSUM>;
	Tue, 24 Sep 2002 14:20:12 -0400
Date: Tue, 24 Sep 2002 11:26:55 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Linus Torvalds <torvalds@transmeta.com>
cc: greg@kroah.com, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
In-Reply-To: <amj5u2$20t$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209241118130.966-200000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="346834433-2043535826-1032892015=:966"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--346834433-2043535826-1032892015=:966
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Sun, 22 Sep 2002, Linus Torvalds wrote:

> In article <20020921033137.GA26017@kroah.com>, Greg KH  <greg@kroah.com> wrote:
> >On Fri, Sep 20, 2002 at 07:55:22PM -0700, David Brownell wrote:
> >> 
> >> How about a facility to create the character (or block?) special file
> >> node right there in the driverfs directory?  Optional of course.
> >
> >No, Linus has stated that this is not ok to do.  See the lkml archives
> >for the whole discussion about this.
> 
> I'm not totally against it, it's just that it has some issues:
> 
>  - naming policy in general. Trivially handled by just always calling
>    the special node something truly boring and nautral like "node", and
>    be done with it. The _path_ is the real name, the "node" would be
>    just an openable entity.
> 
>  - the issue of persistent permissions and ownership. 
> 
> The latter is the real problem.  And I personally think the only sane
> policy is to just let "/sbin/hotplug" handle it, which definitely
> implies _not_ having the kernel create the real device node. That way
> user-space can have any policy it damn well pleases, including having
> some default heuristics along with "a priori known nodes".
> 
> But clearly that user-space hotplug entity needs to know major and minor
> numbers in order to create the real device node, and that's where the
> "node" thing may be acceptable - as a template, nothing more.  Although
> I suspect that there are other, simpler and more acceptable templates
> (ie export the dang thing as just a "node" text-file, which describes
> the majors and minors and "char vs block" issues)

The concern that I had was that people would actually start using the 
stupid thing, and start to rely on the path and existence of them. But, I 
suppose if people really _want_ to do that, we shouldn't stop them from 
hurting themselves. ;)

Userspace does need to know major/minor, as well as block vs. char. We 
could encode those in one file each, but a device node gives us all three 
in a standard format. 

So, appended is a patch that allows you to create a device node in 
driverfs. The API is:

int device_create_node(struct device *device, mode_t mode, kdev_t kdev);

The name is "node", and it's created in the device's directory. There are 
plans to call /sbin/hotplug after the device is registered with its class. 
It's then that the kernel will know what type of device it is, and what 
the major/minor should be. The device path will be passed to 
/sbin/hotplug, which can then query the node as a template for creating 
other device nodes. 

Note that ->fops is not set, though it appears that a request_module()  
happpens when you try to write to it.

Also, the owner of the device is root, and I easily make the permissions 
more stringent (i.e. make it S_IRUGO only always).

Attached is a simple little module to illustrate the use of the API. It 
creates a device 'foo0' and a node inside its directory once registered:

# tree /sys/root/foo0/
/sys/root/foo0/
|-- name
|-- node
`-- power


# ls -l /sys/root/foo0/node 
cr--r--r--    1 root     root      10,  16 Sep 23 10:58 
/sys/root/foo0/node


Will submit as a BK patch pending feedback..


	-pat


===== drivers/base/fs/device.c 1.20 vs edited =====
--- 1.20/drivers/base/fs/device.c	Mon Aug 26 08:39:22 2002
+++ edited/drivers/base/fs/device.c	Tue Sep 24 10:47:48 2002
@@ -80,6 +80,24 @@
 };
 
 /**
+ * device_create_node - create a device node for a device
+ * @dev:	device we're creating the node for
+ * @mode:	permissions of the device
+ * @kdev:	major/minor of the device
+ *
+ */
+int device_create_node(struct device * dev, mode_t mode, kdev_t kdev)
+{
+	struct attribute attr = {
+		.name	= "node",
+		.mode	= mode,
+	};
+	printk("creating node (kdev = %d, mode = %d, dev = %s)\n",
+	       kdev_t_to_nr(kdev),mode,dev->bus_id);
+	return driverfs_create_node(&attr,&dev->dir,kdev);
+}
+
+/**
  * device_create_file - create a driverfs file for a device
  * @dev:	device requesting file
  * @entry:	entry describing file
@@ -243,3 +261,4 @@
 
 EXPORT_SYMBOL(device_create_file);
 EXPORT_SYMBOL(device_remove_file);
+EXPORT_SYMBOL(device_create_node);
===== fs/driverfs/inode.c 1.50 vs edited =====
--- 1.50/fs/driverfs/inode.c	Wed Sep 11 13:47:46 2002
+++ edited/fs/driverfs/inode.c	Tue Sep 24 10:51:26 2002
@@ -145,8 +145,6 @@
 	if (dentry->d_inode)
 		return -EEXIST;
 
-	/* only allow create if ->d_fsdata is not NULL (so we can assume it 
-	 * comes from the driverfs API below. */
 	inode = driverfs_get_inode(dir->i_sb, mode, dev);
 	if (inode) {
 		d_instantiate(dentry, inode);
@@ -598,6 +596,30 @@
 	up(&parent->dentry->d_inode->i_sem);
 	return error;
 }
+
+int driverfs_create_node(struct attribute * attr, 
+			 struct driver_dir_entry * parent, kdev_t kdev)
+{
+	struct dentry * dentry;
+	int error = 0;
+
+	if (!attr || !parent)
+		return -EINVAL;
+
+	if (!parent->dentry)
+		return -EINVAL;
+
+	down(&parent->dentry->d_inode->i_sem);
+	dentry = get_dentry(parent->dentry,attr->name);
+	if (!IS_ERR(dentry)) {
+		error = driverfs_mknod(parent->dentry->d_inode,dentry,
+				       attr->mode,kdev_t_to_nr(kdev));
+	} else
+		error = PTR_ERR(dentry);
+	up(&parent->dentry->d_inode->i_sem);
+	return error;
+}
+
 
 /**
  * driverfs_create_symlink - make a symlink
===== include/linux/device.h 1.38 vs edited =====
--- 1.38/include/linux/device.h	Mon Sep 23 18:23:03 2002
+++ edited/include/linux/device.h	Tue Sep 24 11:01:26 2002
@@ -346,6 +346,8 @@
 extern int device_create_file(struct device *device, struct device_attribute * entry);
 extern void device_remove_file(struct device * dev, struct device_attribute * attr);
 
+extern int device_create_node(struct device *device, mode_t mode, kdev_t kdev);
+
 /*
  * Platform "fixup" functions - allow the platform to have their say
  * about devices and actions that the general device layer doesn't
===== include/linux/driverfs_fs.h 1.13 vs edited =====
--- 1.13/include/linux/driverfs_fs.h	Thu Aug  1 12:07:33 2002
+++ edited/include/linux/driverfs_fs.h	Tue Sep 24 10:54:16 2002
@@ -26,6 +26,8 @@
 #ifndef _DRIVER_FS_H_
 #define _DRIVER_FS_H_
 
+#include <linux/kdev_t.h>
+
 struct driver_dir_entry;
 struct attribute;
 
@@ -57,6 +59,10 @@
 extern int
 driverfs_create_file(struct attribute * attr,
 		     struct driver_dir_entry * parent);
+
+
+extern int driverfs_create_node(struct attribute * attr, 
+				struct driver_dir_entry * parent, kdev_t kdev);
 
 extern int 
 driverfs_create_symlink(struct driver_dir_entry * parent, 

--346834433-2043535826-1032892015=:966
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="foodev.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0209241126550.966@cherise.pdx.osdl.net>
Content-Description: 
Content-Disposition: attachment; filename="foodev.c"

LyoNCiAqIGZvb2Rldi5jIC0gc2ltcGxlIGlsbHVzdHJhdGlvbiBvZiBkZXZp
Y2Ugbm9kZSBjcmVhdGlvbiBpbiBkcml2ZXJmcy4NCiAqDQogKiBDb3B5cmln
aHQgKGMpIDIwMDIgUGF0cmljayBNb2NoZWwNCiAqDQogKiBUaGlzIGlzIHNp
bXBsZSBhbmQgc3R1cGlkLiBXZSBkZWNsYXJlIGEgcGxhdGZvcm0gZGV2aWNl
LCByZWdpc3RlciBpdA0KICogd2l0aCB0aGUgc3lzdGVtLCB0aGVuIGNyZWF0
ZSBhIGRldmljZSBub2RlIGZvciBpdC4NCiAqIFRoZSBtYWpvci9taW5vciB1
c2VkIGlzIHRoZSBjaGFyIG1pc2MgZGV2aWNlLCBhbmQgdGhlIGZpcnN0IGZy
ZWUgbWlub3INCiAqIChyaWdodCBhZnRlciB0aGUgbWs3MTIgdG91Y2hzY3Jl
ZW47IHN0dXBpZCBtazcxMikuDQogKg0KICogVGhpcyBpcyB2ZXJ5IGJ1Z2d5
LCBidXQgaXQncyBub3QgbWVhbnQgdG8gYmUgcGVyZmVjdC4gV2Ugc2hvdWxk
IGNoZWNrDQogKiB0aGUgcmV0dXJuIG9mIHRoZSByZWdpc3RyYXRpb24gYW5k
IGNyZWF0aW9uIGZ1bmN0aW9ucy4gDQogKiBBbmQsIHRoZSBtb2R1bGUgY2Fu
IGJlIHVubG9hZGVkIHdoaWxlIHRoZXJlIGFyZSBzdGlsbCByZWZlcmVuY2Vz
IHRvIA0KICogdGhlIGRldmljZS4gT2ggd2VsbC4uDQogKiANCiAqIEFsc28s
IHRoZSBkZXZpY2UgaGFzIG5vIHBhcmVudCBvciBidXMuIERvbid0IGRvIHRo
YXQuIEV2ZXIuIEkgd3JvdGUgDQogKiB0aGUgQVBJLCBzbyBJJ20gc3BlY2lh
bC4gOykNCiAqDQogKiBDb21waWxlZCB3aXRoOg0KDQpDRkxBR1MgPSAtV2Fs
bCAtTzIgLWZvbWl0LWZyYW1lLXBvaW50ZXIgLURNT0RVTEUgLURfX0tFUk5F
TF9fDQpJRElSID0gL2hvbWUvbW9jaGVsL3NyYy9rZXJuZWwvZGV2ZWwvbGlu
dXgtMi41L2luY2x1ZGUNCg0KZm9vZGV2Lm86OiANCgkkKENDKSAkKENGTEFH
UykgLUkkKElESVIpIC1jIC1vICRAICQ8DQoNCiAqLw0KDQojaW5jbHVkZSA8
bGludXgva2VybmVsLmg+DQojaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQoj
aW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQojaW5jbHVkZSA8bGludXgvaW5p
dC5oPg0KDQpzdGF0aWMgc3RydWN0IGRldmljZSBmb29kZXYgPSB7DQoJLmJ1
c19pZAk9ICJmb28wIiwNCgkubmFtZQk9ICJUaGUgRm9vIERldmljZSIsDQp9
Ow0KDQpzdGF0aWMgaW50IF9faW5pdCBmb29kZXZfaW5pdCh2b2lkKQ0Kew0K
CWRldmljZV9yZWdpc3RlcigmZm9vZGV2KTsNCglkZXZpY2VfY3JlYXRlX25v
ZGUoJmZvb2RldiwoU19JRkNIUnxTX0lSVUdPKSxta19rZGV2KDEwLDE2KSk7
DQoJcmV0dXJuIDA7DQp9DQoNCnN0YXRpYyB2b2lkIF9fZXhpdCBmb29kZXZf
ZXhpdCh2b2lkKQ0Kew0KCXB1dF9kZXZpY2UoJmZvb2Rldik7DQp9DQoNCm1v
ZHVsZV9pbml0KGZvb2Rldl9pbml0KTsNCm1vZHVsZV9leGl0KGZvb2Rldl9l
eGl0KTsNCg==
--346834433-2043535826-1032892015=:966--

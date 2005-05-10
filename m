Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVEJWTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVEJWTu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 18:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVEJWTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 18:19:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:9373 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261842AbVEJWTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 18:19:14 -0400
Date: Tue, 10 May 2005 15:16:15 -0700
From: Greg KH <greg@kroah.com>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Jean Delvare <khali@linux-fr.org>,
       LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4 1/3] dynamic sysfs callbacks
Message-ID: <20050510221615.GA4613@kroah.com>
References: <253818670505070621784dbd63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253818670505070621784dbd63@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 09:21:34AM -0400, Yani Ioannou wrote:
> Hi,
> 
> This patch against 2.6.12-rc4 adds a void * field to the base sysfs
> attribute, and updates all the derived attributes (device_attribute,
> etc) to pass the void * to their sysfs callbacks. This facilitates a
> number of things:

Woah.  Why change _every_ type of attribute callback?  Why not only
change the ones that actually need this kind of change?  That would
reduce your patch immensly, and allow us to actually see what is going
on.

And, in looking at the attribute structure, I see we already have a
private pointer in the bin_attribute structure, so we might as well
collapse them together.

So, here's a first patch to base your next changes off of.  It merely
adds a private pointer to the struct attribute.  It breaks no code, and
requires no other changes to get it to work properly.  Can you now work
off of it and start changing _only_ the attribute types that need this
change for now?  That should reduce your changes a lot.  I'll add this
patch to my quilt tree so it will show up in the next -mm releases.

thanks,

greg k-h

Subject: sysfs: make attribute contain a private pointer.

Lets us get rid of the bin_attribute's pointer at the same time.
This is being done so that sysfs code can determine what attribute is being
accessed to allow smaller amounts of kernel code to be written.

Based on a patch from Yani Ioannou <yani.ioannou@gmail.com>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/pci/pci-sysfs.c |    4 ++--
 include/linux/sysfs.h   |   30 ++++++++++++++++++++----------
 2 files changed, 22 insertions(+), 12 deletions(-)

--- gregkh-2.6.orig/include/linux/sysfs.h	2005-05-10 14:15:04.000000000 -0700
+++ gregkh-2.6/include/linux/sysfs.h	2005-05-10 15:10:31.000000000 -0700
@@ -18,6 +18,7 @@
 struct attribute {
 	const char		* name;
 	struct module 		* owner;
+	void			* private;
 	mode_t			mode;
 };
 
@@ -33,15 +34,25 @@
  * for examples..
  */
 
-#define __ATTR(_name,_mode,_show,_store) { \
-	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
-	.show	= _show,					\
-	.store	= _store,					\
-}
-
-#define __ATTR_RO(_name) { \
-	.attr	= { .name = __stringify(_name), .mode = 0444, .owner = THIS_MODULE },	\
-	.show	= _name##_show,	\
+#define __ATTR(_name,_mode,_show,_store) {	\
+	.attr = {				\
+		.name = __stringify(_name),	\
+		.mode = _mode,			\
+		.private = NULL,		\
+		.owner = THIS_MODULE,		\
+	}, 					\
+	.show	= _show,			\
+	.store	= _store,			\
+}
+
+#define __ATTR_RO(_name) {			\
+	.attr	= {				\
+		.name = __stringify(_name),	\
+		.mode = 0444,			\
+		.private = NULL,		\
+		.owner = THIS_MODULE,		\
+	},					\
+	.show	= _name##_show,			\
 }
 
 #define __ATTR_NULL { .attr = { .name = NULL } }
@@ -53,7 +64,6 @@
 struct bin_attribute {
 	struct attribute	attr;
 	size_t			size;
-	void			*private;
 	ssize_t (*read)(struct kobject *, char *, loff_t, size_t);
 	ssize_t (*write)(struct kobject *, char *, loff_t, size_t);
 	int (*mmap)(struct kobject *, struct bin_attribute *attr,
--- gregkh-2.6.orig/drivers/pci/pci-sysfs.c	2005-05-10 14:15:04.000000000 -0700
+++ gregkh-2.6/drivers/pci/pci-sysfs.c	2005-05-10 15:06:29.000000000 -0700
@@ -299,7 +299,7 @@
 {
 	struct pci_dev *pdev = to_pci_dev(container_of(kobj,
 						       struct device, kobj));
-	struct resource *res = (struct resource *)attr->private;
+	struct resource *res = (struct resource *)attr->attr.private;
 	enum pci_mmap_state mmap_type;
 
 	vma->vm_pgoff += res->start >> PAGE_SHIFT;
@@ -337,9 +337,9 @@
 			res_attr->attr.name = res_attr_name;
 			res_attr->attr.mode = S_IRUSR | S_IWUSR;
 			res_attr->attr.owner = THIS_MODULE;
+			res_attr->attr.private = &pdev->resource[i];
 			res_attr->size = pci_resource_len(pdev, i);
 			res_attr->mmap = pci_mmap_resource;
-			res_attr->private = &pdev->resource[i];
 			sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
 		}
 	}

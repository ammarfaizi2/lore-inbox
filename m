Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbULVAcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbULVAcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbULVAcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:32:03 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25987 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261924AbULVAaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:30:39 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] allow struct bin_attributes in class devices
Date: Tue, 21 Dec 2004 16:30:36 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200412211619.52596.jbarnes@engr.sgi.com> <20041222002810.GA12886@kroah.com>
In-Reply-To: <20041222002810.GA12886@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sAMyBy2eHU7EDCH"
Message-Id: <200412211630.36844.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_sAMyBy2eHU7EDCH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, December 21, 2004 4:28 pm, Greg KH wrote:
> On Tue, Dec 21, 2004 at 04:19:52PM -0800, Jesse Barnes wrote:
> > This small patch adds routines to create and remove bin_attribute files
> > for class devices.  One intended use is for binary files corresponding to
> > PCI busses, like bus legacy I/O ports or ISA memory.
> >
> >  drivers/base/class.c   |   16 ++++++++++++++++
> >  include/linux/device.h |    5 ++++-
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> >
> > Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
>
> Ugh, we'll get this eventually... You forgot a EXPORT_SYMBOL_GPL() so
> that modules can use these functions :)
>
> Third time's a charm :)

Doh!  Here you go.

Jesse


--Boundary-00=_sAMyBy2eHU7EDCH
Content-Type: text/plain;
  charset="iso-8859-1";
  name="class-device-bin-files-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="class-device-bin-files-2.patch"

===== drivers/base/class.c 1.56 vs edited =====
--- 1.56/drivers/base/class.c	2004-11-12 03:45:39 -08:00
+++ edited/drivers/base/class.c	2004-12-21 16:29:34 -08:00
@@ -179,6 +179,22 @@
 		sysfs_remove_file(&class_dev->kobj, &attr->attr);
 }
 
+int class_device_create_bin_file(struct class_device *class_dev,
+				 struct bin_attribute *attr)
+{
+	int error = -EINVAL;
+	if (class_dev)
+		error = sysfs_create_bin_file(&class_dev->kobj, attr);
+	return error;
+}
+
+void class_device_remove_bin_file(struct class_device *class_dev,
+				  struct bin_attribute *attr)
+{
+	if (class_dev)
+		sysfs_remove_bin_file(&class_dev->kobj, attr);
+}
+
 static int class_device_dev_link(struct class_device * class_dev)
 {
 	if (class_dev->dev)
@@ -576,6 +592,8 @@
 EXPORT_SYMBOL_GPL(class_device_put);
 EXPORT_SYMBOL_GPL(class_device_create_file);
 EXPORT_SYMBOL_GPL(class_device_remove_file);
+EXPORT_SYMBOL_GPL(class_device_create_bin_file);
+EXPORT_SYMBOL_GPL(class_device_remove_bin_file);
 
 EXPORT_SYMBOL_GPL(class_interface_register);
 EXPORT_SYMBOL_GPL(class_interface_unregister);
===== include/linux/device.h 1.133 vs edited =====
--- 1.133/include/linux/device.h	2004-12-08 15:22:36 -08:00
+++ edited/include/linux/device.h	2004-12-21 16:16:06 -08:00
@@ -228,7 +228,10 @@
 				    const struct class_device_attribute *);
 extern void class_device_remove_file(struct class_device *, 
 				     const struct class_device_attribute *);
-
+extern int class_device_create_bin_file(struct class_device *,
+					struct bin_attribute *);
+extern void class_device_remove_bin_file(struct class_device *,
+					 struct bin_attribute *);
 
 struct class_interface {
 	struct list_head	node;

--Boundary-00=_sAMyBy2eHU7EDCH--

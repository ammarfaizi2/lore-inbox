Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTEVQWP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 12:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTEVQWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 12:22:15 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:10701 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262763AbTEVQWN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 12:22:13 -0400
Date: Thu, 22 May 2003 18:34:48 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Re: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030522163448.GA17004@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030522153154.GD13224@ranty.ddts.net> <Pine.LNX.4.44.0305220911290.5889-100000@cherise>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305220911290.5889-100000@cherise>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 22, 2003 at 09:14:26AM -0700, Patrick Mochel wrote:
> 
> I don't have any problems with the interface, and am ok with the driver 
> core and sysfs changes. I have the sysfs binary file patch, but would you 
> mind sending me the class device release() patch separately? 

 Sorry. Since it is small I'll simply split class-casts+release.diff and
 attach both pieces just in case.
 
> Also, what about just creating a drivers/firmware/ directory (or 
> drivers/base/firmware/) for the core code? 

 Making a directory for a single source file seams a little overkill,
 although at some point could be interesting to have all firmware images
 in the kernel on the same directory to be copied to initramfs or
 elsewhere.

 For now I don't think it is worth it's own directory, but I don't
 really care as long as the functionality is there.

 If I had to choose I would take drivers/base/firmware/
 
 Thanks

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="class-casts.diff"

diff --exclude=CVS -urN linux-2.5.orig/drivers/base/base.h linux-2.5.mine/drivers/base/base.h
--- linux-2.5.orig/drivers/base/base.h	2003-05-21 17:38:39.000000000 +0200
+++ linux-2.5.mine/drivers/base/base.h	2003-05-21 10:25:09.000000000 +0200
@@ -4,3 +4,12 @@
 extern int bus_add_driver(struct device_driver *);
 extern void bus_remove_driver(struct device_driver *);
 
+static inline struct class_device *to_class_dev(struct kobject *obj)
+{
+	return container_of(obj,struct class_device,kobj);
+}
+static inline
+struct class_device_attribute *to_class_dev_attr(struct attribute *_attr)
+{
+	return container_of(_attr,struct class_device_attribute,attr);
+}
diff --exclude=CVS -urN linux-2.5.orig/drivers/base/class.c linux-2.5.mine/drivers/base/class.c
--- linux-2.5.orig/drivers/base/class.c	2003-05-21 17:38:39.000000000 +0200
+++ linux-2.5.mine/drivers/base/class.c	2003-05-22 16:51:46.000000000 +0200
@@ -148,9 +148,6 @@
 }
 
 
-#define to_class_dev(obj) container_of(obj,struct class_device,kobj)
-#define to_class_dev_attr(_attr) container_of(_attr,struct class_device_attribute,attr)
-
 static ssize_t
 class_device_attr_show(struct kobject * kobj, struct attribute * attr,
 		       char * buf)

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="class-device-release.diff"

diff --exclude=CVS -urN linux-2.5.orig/drivers/base/class.c linux-2.5.mine/drivers/base/class.c
--- linux-2.5.orig/drivers/base/class.c	2003-05-21 17:38:39.000000000 +0200
+++ linux-2.5.mine/drivers/base/class.c	2003-05-22 16:51:46.000000000 +0200
@@ -182,7 +179,15 @@
 	.store	= class_device_attr_store,
 };
 
+static void class_dev_release(struct kobject * kobj)
+{
+	struct class_device *class_dev = to_class_dev(kobj);
+	if (class_dev->release)
+		class_dev->release(class_dev);
+}
+
 static struct kobj_type ktype_class_device = {
+	.release	= &class_dev_release,
 	.sysfs_ops	= &class_dev_sysfs_ops,
 };
 
diff --exclude=CVS -urN linux-2.5.orig/include/linux/device.h linux-2.5.mine/include/linux/device.h
--- linux-2.5.orig/include/linux/device.h	2003-05-22 13:05:16.000000000 +0200
+++ linux-2.5.mine/include/linux/device.h	2003-05-22 12:05:45.000000000 +0200
@@ -204,6 +204,7 @@
 	void			* class_data;	/* class-specific data */
 
 	char	class_id[BUS_ID_SIZE];	/* unique to this class */
+	void	(*release)(struct class_device * class_dev);
 };
 
 static inline void *

--n8g4imXOkfNTN/H1--

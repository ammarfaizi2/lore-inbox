Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUCBUHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 15:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUCBUHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 15:07:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:13453 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261756AbUCBUGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 15:06:49 -0500
Date: Tue, 2 Mar 2004 12:06:34 -0800
From: Greg KH <greg@kroah.com>
To: Jamey Hicks <jamey.hicks@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: add class_device_find
Message-ID: <20040302200634.GA2986@kroah.com>
References: <4044ACF0.1030909@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4044ACF0.1030909@hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 10:49:04AM -0500, Jamey Hicks wrote:
> 
> This patch adds:
> 
> struct class_device * class_device_find(struct class *class, const char 
> *class_id)
> 
> to find a class device by name so that drivers that match up class 
> devices by ID do not need to reach into the internals of class 
> implementation.  RMK recommended that I take this approach, and it seems 
> reasonable to me.  Please let me know what you think.

Hm, well your patch was line-wrapped, the code was not race-safe, you
didn't protect the class_device that you returned, you used
list_for_each instead of list_for_each_entry, you made a check that can
never fail, and you forgot to modify device.h.

But other than that it was fine :)

How about this version instead?

Might I ask about which part of the kernel you are going to want to use
this call in?

thanks,

greg k-h


# Driver core: add class_device_find function
# 
# based on an idea from Jamey Hicks <jamey.hicks@hp.com>

diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Tue Mar  2 12:02:30 2004
+++ b/drivers/base/class.c	Tue Mar  2 12:02:30 2004
@@ -375,6 +375,33 @@
 	return 0;
 }
 
+/**
+ * class_device_find - find a struct class_device in a specific class
+ * @class: the class to search
+ * @class_id: the class_id to search for
+ *
+ * Iterates through the list of all class devices registered to a class.  If
+ * the class_id is found, its reference count is incremented and returned to
+ * the caller.  If the class_id does not match any existing struct class_device
+ * registered to this struct class, then NULL is returned.
+ */
+struct class_device * class_device_find(struct class *class, const char *class_id)
+{
+	struct class_device *class_dev;
+	struct class_device *found = NULL;
+
+	down_read(&class->subsys.rwsem);
+	list_for_each_entry(class_dev, &class->children, node) {
+		if (strcmp(class_dev->class_id, class_id) == 0) {
+			found = class_device_get(class_dev);
+			break;
+		}
+	}
+	up_read(&class->subsys.rwsem);
+
+	return found;
+}
+
 struct class_device * class_device_get(struct class_device *class_dev)
 {
 	if (class_dev)
@@ -466,6 +493,7 @@
 EXPORT_SYMBOL(class_device_put);
 EXPORT_SYMBOL(class_device_create_file);
 EXPORT_SYMBOL(class_device_remove_file);
+EXPORT_SYMBOL(class_device_find);
 
 EXPORT_SYMBOL(class_interface_register);
 EXPORT_SYMBOL(class_interface_unregister);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Mar  2 12:02:30 2004
+++ b/include/linux/device.h	Tue Mar  2 12:02:30 2004
@@ -214,6 +214,7 @@
 extern void class_device_del(struct class_device *);
 
 extern int class_device_rename(struct class_device *, char *);
+extern struct class_device * class_device_find(struct class *class, const char *class_id);
 
 extern struct class_device * class_device_get(struct class_device *);
 extern void class_device_put(struct class_device *);

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVA0KHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVA0KHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVA0KHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:07:40 -0500
Received: from soundwarez.org ([217.160.171.123]:52655 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262543AbVA0KHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:07:36 -0500
Date: Thu, 27 Jan 2005 11:07:33 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH] sysfs: export the vfs release call of binary attribute
Message-ID: <20050127100733.GA3018@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no way to know what time userspace has finished writing
to a binary sysfs attribute bigger than one page. The firmware_class code uses
its own special file in the class directory to notify about this. This can
be simplified by using this release callback.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== fs/sysfs/bin.c 1.20 vs edited =====
--- 1.20/fs/sysfs/bin.c	2004-12-21 18:32:08 +01:00
+++ edited/fs/sysfs/bin.c	2005-01-26 20:56:07 +01:00
@@ -156,6 +156,9 @@ static int release(struct inode * inode,
 	struct bin_attribute * attr = to_bin_attr(file->f_dentry);
 	u8 * buffer = file->private_data;
 
+	if (attr->release)
+		attr->release(kobj);
+
 	if (kobj) 
 		kobject_put(kobj);
 	module_put(attr->attr.owner);
===== include/linux/sysfs.h 1.39 vs edited =====
--- 1.39/include/linux/sysfs.h	2004-12-21 18:31:01 +01:00
+++ edited/include/linux/sysfs.h	2005-01-26 20:34:01 +01:00
@@ -56,6 +56,7 @@ struct bin_attribute {
 	void			*private;
 	ssize_t (*read)(struct kobject *, char *, loff_t, size_t);
 	ssize_t (*write)(struct kobject *, char *, loff_t, size_t);
+	int (*release)(struct kobject *);
 	int (*mmap)(struct kobject *, struct bin_attribute *attr,
 		    struct vm_area_struct *vma);
 };


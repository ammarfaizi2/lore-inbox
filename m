Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbUKDHVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbUKDHVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbUKDHPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:15:14 -0500
Received: from [211.58.254.17] ([211.58.254.17]:64674 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262125AbUKDHDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 02:03:39 -0500
Date: Thu, 4 Nov 2004 16:03:37 +0900
From: Tejun Heo <tj@home-tj.org>
To: mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 3/5] driver-model: sysfs_release() dangling pointer reference fix
Message-ID: <20041104070337.GD25567@home-tj.org>
References: <20041104070134.GA25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104070134.GA25567@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 df_03_sysfs_release_fix.patch

 Some attributes are allocated dynamically (e.g. module and device
parameters) and are usually deallocated when the assoicated kobject is
released.  So, it's not safe to access attr after putting the kobject.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/fs/sysfs/file.c
===================================================================
--- linux-export.orig/fs/sysfs/file.c	2004-11-04 10:25:58.000000000 +0900
+++ linux-export/fs/sysfs/file.c	2004-11-04 11:04:14.000000000 +0900
@@ -330,11 +330,13 @@ static int sysfs_release(struct inode * 
 {
 	struct kobject * kobj = to_kobj(filp->f_dentry->d_parent);
 	struct attribute * attr = to_attr(filp->f_dentry);
+	struct module * owner = attr->owner;
 	struct sysfs_buffer * buffer = filp->private_data;
 
 	if (kobj) 
 		kobject_put(kobj);
-	module_put(attr->owner);
+	/* After this point, attr should not be accessed. */
+	module_put(owner);
 
 	if (buffer) {
 		if (buffer->page)

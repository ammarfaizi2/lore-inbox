Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbUKEAuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbUKEAuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbUKEAtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:49:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:32478 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262517AbUKEAsq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:48:46 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <1099615705183@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 4 Nov 2004 16:48:25 -0800
Message-Id: <10996157052267@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2449.2.6, 2004/11/04 10:54:31-08:00, tj@home-tj.org

[PATCH] driver-model: sysfs_release() dangling pointer reference fix

 df_03_sysfs_release_fix.patch

Some attributes are allocated dynamically (e.g. module and device
parameters) and are usually deallocated when the assoicated kobject is
released.  So, it's not safe to access attr after putting the kobject.


Signed-off-by: Tejun Heo <tj@home-tj.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/file.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c	2004-11-04 16:30:39 -08:00
+++ b/fs/sysfs/file.c	2004-11-04 16:30:39 -08:00
@@ -330,11 +330,13 @@
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


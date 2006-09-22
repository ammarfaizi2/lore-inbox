Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWIVTmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWIVTmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWIVTmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:42:45 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:19497 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964823AbWIVTmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:42:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Caw+nGk+tjexJM3claZBkH+G+CqjvWrXIgsJU14YeObix0Th563arcD7L96G1ozamK3Y13USb7QZTiGMkHKM6AJ79wJt8c/5Asb9hzZ/MNg1sOl3rv42dFrNOxJ3fbvW9GsXPPkBA3R8t18B3QhS7om+GOj93Knxibm1KTGKs34=
Message-ID: <c1bf1cf0609221242x7daea179ha47fd44e3a807e0f@mail.gmail.com>
Date: Fri, 22 Sep 2006 12:42:43 -0700
From: "Ed Swierk" <eswierk@arastra.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] load_module: no BUG if module_subsys uninitialized
Cc: rusty@rustcorp.com.au
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 433cd750bd4e15cf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Invoking load_module() before param_sysfs_init() is called crashes in
mod_sysfs_setup(), since the kset in module_subsys is not initialized
yet.

Another patch for the same symptom
(module_subsys-initialize-earlier.patch) moves param_sysfs_init() to
the subsys initcalls, but this is still not early enough in the boot
process in some cases. In particular, topology_init() causes
/sbin/hotplug to run, which requests net-pf-1 (the UNIX socket
protocol) which can be compiled as a module. Moving param_sysfs_init()
to the postcore initcalls fixes this particular race, but there might
well be other cases where a usermodehelper causes a module to load
earlier still.

The patch below makes load_module() return an error rather than
crashing the kernel if invoked before module_subsys is initialized.

--- linux-2.6.17.11.orig/kernel/module.c        2006-08-23
21:16:33.000000000 +0000
+++ linux-2.6.17.11/kernel/module.c     2006-09-22 05:19:03.000000000 +0000
@@ -998,6 +998,12 @@
 {
        int err;

+       if (!module_subsys.kset.subsys) {
+               printk(KERN_ERR "%s: module_subsys not initialized\n",
+                      mod->name);
+               err = -EINVAL;
+               goto out;
+       }
        memset(&mod->mkobj.kobj, 0, sizeof(mod->mkobj.kobj));
        err = kobject_set_name(&mod->mkobj.kobj, "%s", mod->name);
        if (err)

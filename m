Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263567AbUENX2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbUENX2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264529AbUENXMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:12:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:58076 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263567AbUENXIM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:12 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <10845760421519@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:23 -0700
Message-Id: <10845760432011@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.23, 2004/05/11 13:32:24-07:00, greg@kroah.com

Module attributes: fix build error if CONFIG_MODULE_UNLOAD=n

Thanks to Andrew Morton for pointing this out to me.


 kernel/module.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)


diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Fri May 14 15:57:16 2004
+++ b/kernel/module.c	Fri May 14 15:57:16 2004
@@ -379,6 +379,22 @@
 }
 #endif /* CONFIG_SMP */
 
+static int add_attribute(struct module *mod, struct kernel_param *kp)
+{
+	struct module_attribute *a;
+	int retval;
+
+	a = &mod->mkobj->attr[mod->mkobj->num_attributes];
+	a->attr.name = (char *)kp->name;
+	a->attr.owner = mod;
+	a->attr.mode = kp->perm;
+	a->param = kp;
+	retval = sysfs_create_file(&mod->mkobj->kobj, &a->attr);
+	if (!retval)
+		mod->mkobj->num_attributes++;
+	return retval;
+}
+
 #ifdef CONFIG_MODULE_UNLOAD
 /* Init the unload section of the module. */
 static void module_unload_init(struct module *mod)
@@ -502,22 +518,6 @@
 	struct stopref sref = { mod, flags, forced };
 
 	return stop_machine_run(__try_stop_module, &sref, NR_CPUS);
-}
-
-static int add_attribute(struct module *mod, struct kernel_param *kp)
-{
-	struct module_attribute *a;
-	int retval;
-
-	a = &mod->mkobj->attr[mod->mkobj->num_attributes];
-	a->attr.name = (char *)kp->name;
-	a->attr.owner = mod;
-	a->attr.mode = kp->perm;
-	a->param = kp;
-	retval = sysfs_create_file(&mod->mkobj->kobj, &a->attr);
-	if (!retval)
-		mod->mkobj->num_attributes++;
-	return retval;
 }
 
 unsigned int module_refcount(struct module *mod)


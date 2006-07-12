Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWGLDwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWGLDwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWGLDwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:52:05 -0400
Received: from xenotime.net ([66.160.160.81]:10214 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932393AbWGLDv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:51:59 -0400
Date: Tue, 11 Jul 2006 20:48:46 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH -mm] kernel/params: must_check fixes
Message-Id: <20060711204846.f036e5fa.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Check all __must_check warnings in kernel/params.c

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 kernel/params.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

--- linux-2618-rc1mm1.orig/kernel/params.c
+++ linux-2618-rc1mm1/kernel/params.c
@@ -547,6 +547,7 @@ static void __init kernel_param_sysfs_se
 					    unsigned int name_skip)
 {
 	struct module_kobject *mk;
+	int ret;
 
 	mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
 	BUG_ON(!mk);
@@ -554,7 +555,8 @@ static void __init kernel_param_sysfs_se
 	mk->mod = THIS_MODULE;
 	kobj_set_kset_s(mk, module_subsys);
 	kobject_set_name(&mk->kobj, name);
-	kobject_register(&mk->kobj);
+	ret = kobject_register(&mk->kobj);
+	BUG_ON(ret < 0);
 
 	/* no need to keep the kobject if no parameter is exported */
 	if (!param_sysfs_setup(mk, kparam, num_params, name_skip)) {
@@ -684,7 +686,14 @@ decl_subsys(module, &module_ktype, NULL)
  */
 static int __init param_sysfs_init(void)
 {
-	subsystem_register(&module_subsys);
+	int ret;
+
+	ret = subsystem_register(&module_subsys);
+	if (ret < 0) {
+		printk(KERN_WARNING "%s (%d): subsystem_register error: %d\n",
+			__FILE__, __LINE__, ret);
+		return ret;
+	}
 
 	param_sysfs_builtin();
 


---

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVAHJFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVAHJFR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVAHIsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:48:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:56965 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261887AbVAHFs2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:28 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632613788@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:41 -0800
Message-Id: <11051632613738@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.19, 2004/12/21 10:36:20-08:00, tj@home-tj.org

[PATCH] module sysfs: expand module_attribute methods

        Modify module_attribute show/store methods to accept self
        argument to enable further extensions.


Signed-off-by: Tejun Heo <tj@home-tj.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/module.h |    5 +++--
 kernel/module.c        |    3 ++-
 kernel/params.c        |    2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)


diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	2005-01-07 15:41:39 -08:00
+++ b/include/linux/module.h	2005-01-07 15:41:39 -08:00
@@ -48,8 +48,9 @@
 
 struct module_attribute {
         struct attribute attr;
-        ssize_t (*show)(struct module *, char *);
-        ssize_t (*store)(struct module *, const char *, size_t count);
+        ssize_t (*show)(struct module_attribute *, struct module *, char *);
+        ssize_t (*store)(struct module_attribute *, struct module *,
+			 const char *, size_t count);
 };
 
 struct module_kobject
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	2005-01-07 15:41:39 -08:00
+++ b/kernel/module.c	2005-01-07 15:41:39 -08:00
@@ -651,7 +651,8 @@
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);
 
-static ssize_t show_refcnt(struct module *mod, char *buffer)
+static ssize_t show_refcnt(struct module_attribute *mattr,
+			   struct module *mod, char *buffer)
 {
 	/* sysfs holds a reference */
 	return sprintf(buffer, "%u\n", module_refcount(mod)-1);
diff -Nru a/kernel/params.c b/kernel/params.c
--- a/kernel/params.c	2005-01-07 15:41:39 -08:00
+++ b/kernel/params.c	2005-01-07 15:41:39 -08:00
@@ -693,7 +693,7 @@
 	if (!try_module_get(mk->mod))
 		return -ENODEV;
 
-	ret = attribute->show(mk->mod, buf);
+	ret = attribute->show(attribute, mk->mod, buf);
 
 	module_put(mk->mod);
 


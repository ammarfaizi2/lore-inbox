Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbUKWDDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbUKWDDi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 22:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbUKWCtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:49:13 -0500
Received: from [211.58.254.17] ([211.58.254.17]:32140 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261187AbUKWCry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:47:54 -0500
Date: Tue, 23 Nov 2004 11:47:52 +0900
From: Tejun Heo <tj@home-tj.org>
To: greg@kroah.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc2 2/4] module sysfs: expand module_attribute methods
Message-ID: <20041123024752.GC7326@home-tj.org>
References: <20041123024537.GA7326@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123024537.GA7326@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 11:45:37AM +0900, Tejun Heo wrote:
> 02_module_attribute_extension.patch
> 	Modify module_attribute show/store methods to accept self
> 	argument to enable further extensions.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/include/linux/module.h
===================================================================
--- linux-export.orig/include/linux/module.h	2004-11-23 11:31:32.000000000 +0900
+++ linux-export/include/linux/module.h	2004-11-23 11:32:13.000000000 +0900
@@ -48,8 +48,9 @@ struct module;
 
 struct module_attribute {
         struct attribute attr;
-        ssize_t (*show)(struct module *, char *);
-        ssize_t (*store)(struct module *, const char *, size_t count);
+        ssize_t (*show)(struct module_attribute *, struct module *, char *);
+        ssize_t (*store)(struct module_attribute *, struct module *,
+			 const char *, size_t count);
 };
 
 struct module_kobject
Index: linux-export/kernel/module.c
===================================================================
--- linux-export.orig/kernel/module.c	2004-11-23 11:31:32.000000000 +0900
+++ linux-export/kernel/module.c	2004-11-23 11:32:13.000000000 +0900
@@ -651,7 +651,8 @@ void symbol_put_addr(void *addr)
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);
 
-static ssize_t show_refcnt(struct module *mod, char *buffer)
+static ssize_t show_refcnt(struct module_attribute *mattr,
+			   struct module *mod, char *buffer)
 {
 	/* sysfs holds a reference */
 	return sprintf(buffer, "%u\n", module_refcount(mod)-1);
Index: linux-export/kernel/params.c
===================================================================
--- linux-export.orig/kernel/params.c	2004-11-23 11:31:32.000000000 +0900
+++ linux-export/kernel/params.c	2004-11-23 11:32:13.000000000 +0900
@@ -691,7 +691,7 @@ static ssize_t module_attr_show(struct k
 	if (!try_module_get(mk->mod))
 		return -ENODEV;
 
-	ret = attribute->show(mk->mod, buf);
+	ret = attribute->show(attribute, mk->mod, buf);
 
 	module_put(mk->mod);
 

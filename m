Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbUKWGRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbUKWGRp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbUKWGQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:16:18 -0500
Received: from [211.58.254.17] ([211.58.254.17]:4763 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262112AbUKWGOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:14:30 -0500
Date: Tue, 23 Nov 2004 15:14:23 +0900
From: Tejun Heo <tj@home-tj.org>
To: greg@kroah.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH REPOST 2.6.10-rc2 0/4] module sysfs: expand module_attribute
Message-ID: <20041123061423.GC14209@home-tj.org>
References: <20041123061252.GA14209@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123061252.GA14209@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-export/include/linux/module.h
===================================================================
--- linux-export.orig/include/linux/module.h	2004-11-23 15:08:01.000000000 +0900
+++ linux-export/include/linux/module.h	2004-11-23 15:08:11.000000000 +0900
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
--- linux-export.orig/kernel/module.c	2004-11-23 15:08:01.000000000 +0900
+++ linux-export/kernel/module.c	2004-11-23 15:08:11.000000000 +0900
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
--- linux-export.orig/kernel/params.c	2004-11-23 15:08:01.000000000 +0900
+++ linux-export/kernel/params.c	2004-11-23 15:08:11.000000000 +0900
@@ -693,7 +693,7 @@ static ssize_t module_attr_show(struct k
 	if (!try_module_get(mk->mod))
 		return -ENODEV;
 
-	ret = attribute->show(mk->mod, buf);
+	ret = attribute->show(attribute, mk->mod, buf);
 
 	module_put(mk->mod);
 
